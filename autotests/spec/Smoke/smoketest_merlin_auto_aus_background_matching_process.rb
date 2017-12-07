#--------------------------------------------------------------------#
#	TID : TID013887 , TID013882
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Accounting - Cash entry and Matching
# 	Story: 25002 
#--------------------------------------------------------------------#


describe "Smoke Test: Background matching for non referenced invoice number", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		# Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID013887 and TID013882"
	end
	_cashentry_date = "15/06/2015"
	_date_today =  Time.now.strftime("%d/%m/%Y")
	_mail_subject = "Background Matching completed"
	_expected_mail_content1 = "Company : Merlin Auto AUS Matched by : Invoice Number Allow Partial Payment : Yes Matching Date: "+Time.now.strftime("%d/%m/%Y")+" Match Up To: "+Time.now.strftime("%d/%m/%Y")+" Where: Document currency is Mixed Account: J Boag Brewing Matching Results : Invoices Matched: 1 Cash Matched: 1 Total Invoice Amount Matched: 1100.00 Total Cash Amount Matched: 990.00 Total Discount: 110.00 Thank you for using FinancialForce."
 	_expected_mail_content2 = "Company : Merlin Auto AUS Matched by : Invoice Number Then Match By: Document Number - Oldest First Allow Partial Payment : Yes Matching Date: " +Time.now.strftime("%d/%m/%Y")+" Match Up To: "+Time.now.strftime("%d/%m/%Y")+" Where: Document currency is Mixed Account: J Boag Brewing Matching Results : Invoices Matched: 3 Cash Matched: 1 Total Invoice Amount Matched: 1090.00 Total Cash Amount Matched: 1000.00 Total Discount: 90.00 Thank you for using FinancialForce."

	it "TID013887 : background matching process for 1 sales invoice and 1 cash entry for referenced  invoice number" do	
		gen_start_test "TID013887"
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_aus] ,true
		gen_start_test "Additional data setup required for execution of script"
		begin
			SF.set_bcc_email $bd_mail_id_ffa_autotest_user, true
		end
		gen_start_test "TST017117: Create a sales invoice document and post it."
		begin
			#Section 1.1
			begin
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account  $bd_account_jboag_brewing
				SIN.set_invoice_date "15/06/2015"

				SIN.add_line 1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , "1" , "1100" , '' , nil, nil
				SF.click_button_save
				SF.wait_for_search_button
				FFA.click_post
				SF.wait_for_search_button	
				#expected Result
				invoice_number = SIN.get_invoice_number
				invoice_status = SIN.get_status
				gen_compare $bd_document_status_complete , invoice_status , "Expected Invoice Status to be Complete for " + invoice_number
			end
			#Section 1.2
			begin
				SF.tab $tab_cash_entries
				SF.wait_for_search_button
				SF.click_button_new
				CE.set_bank_account $bd_bank_account_commonwealth_current_account
				CE.set_date _cashentry_date
					
				CE.line_set_account_name $bd_account_jboag_brewing
				FFA.click_new_line
				CE.line_set_account_reference 1, invoice_number
				CE.line_set_cashentryvalue 1 , '1100'
				FFA.click_save_post
					
				#expected Result
				cash_entry_status = CE.get_cash_entry_status
				gen_compare $bd_document_status_complete , cash_entry_status , "Expected Cash Entry Status to be Complete"
			end	
			#Section 1.3
			begin
				SF.tab $tab_background_matching
				BGM.set_account $bd_account_jboag_brewing
				BGM.select_first_match_by $bd_bgm_first_match_by_invoice_number
				BGM.set_matching_date _date_today
				BGM.set_match_upto_date _date_today
				BGM.set_allow_partial_payment true
				SF.click_button $ffa_next_button
				SF.click_button $bgm_start_matching_button
				SF.wait_for_apex_job

				#Expected Status
				SF.tab $tab_sales_invoices

				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page invoice_number
				payment_status = SIN.get_invoice_payment_status
				gen_compare $bd_document_payment_status_paid , payment_status , "Expected Invoice Status  to be paid for "	+invoice_number
				outstanding_value = SIN.get_invoice_payment_outstanding_value
				gen_compare '0.00' , outstanding_value , "Expected Invoice outstanding value : 0.00 "	
				# Check mail for background matching.
				_actual_mail_content = Mailinator.get_mail_content $bd_mail_id_ffa_autotest_user, _mail_subject , true
				if _actual_mail_content.include?(_expected_mail_content1)
					gen_report_test "Expected mail to contain the necessary information of successfull background matching."
				else
					gen_report_test "WARNING: MAIL not delivered successfully at mailinator.Expected: #{_expected_mail_content1} and Actual: #{_actual_mail_content}"
				end
			end
		end
		gen_end_test "TID013887"
	end

	it "TID013882 : Smoke Test: Background matching with 3 invoice number and 1 cash entry" do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_start_test "TID013882"
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_aus] ,true
		gen_start_test "TST018315: Background matching using Document Number Oldest First match method"
		begin
		    #Section 1.1
			begin
				# First Invoice
				SF.tab $tab_sales_invoices
				SF.wait_for_search_button
				SF.click_button_new
				SIN.set_account  $bd_account_jboag_brewing
				SIN.set_invoice_date "15/06/2015"

				SIN.add_line 1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , "1" , "600" , '' , nil, nil
				FFA.click_save_post
				#expected Result
				firstinvoice_number = SIN.get_invoice_number
				invoice_status = SIN.get_status
				gen_compare $bd_document_status_complete , invoice_status , "Expected Invoice Status to be Complete for "+ firstinvoice_number
				
				# Second Invoice
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account  $bd_account_jboag_brewing
				SIN.set_invoice_date "15/06/2015"

				SIN.add_line 1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , "1" , "300" , '' , nil, nil
				FFA.click_save_post
				#expected Result
				secondinvoice_number = SIN.get_invoice_number
				invoice_status = SIN.get_status
				gen_compare $bd_document_status_complete , invoice_status , "Expected Invoice Status to be Complete for " + secondinvoice_number
				
				#Third Invoice
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account  $bd_account_jboag_brewing
				SIN.set_invoice_date "15/06/2015"

				SIN.add_line 1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , "1" , "300" , '' , nil, nil
				FFA.click_save_post
				#expected Result
				thirdinvoice_number = SIN.get_invoice_number
				invoice_status = SIN.get_status
				gen_compare $bd_document_status_complete , invoice_status , "Expected Invoice Status to be Complete for " + thirdinvoice_number
			end
			
			#Section 1.2
			begin
				#Cash Entry
				SF.tab $tab_cash_entries
				SF.click_button_new
				CE.set_bank_account $bd_bank_account_commonwealth_current_account
				CE.set_date _cashentry_date

				CE.line_set_account_name $bd_account_jboag_brewing
				FFA.click_new_line
				CE.line_set_cashentryvalue 1 , '1000'
				FFA.click_save_post
				
				cash_entry_status = CE.get_cash_entry_status
				gen_compare $bd_document_status_complete , cash_entry_status , "Expected Cash Entry Status to be Complete"
			end
			#Section 1.3
			begin
				SF.tab $tab_background_matching
				BGM.set_account $bd_account_jboag_brewing
				BGM.select_first_match_by $bd_bgm_first_match_by_invoice_number
				BGM.click_button_add_matching_condition
				BGM.select_then_match_by $bd_bgm_then_match_by_oldest_first
				BGM.set_matching_date _date_today
				BGM.set_match_upto_date _date_today
				BGM.set_allow_partial_payment true
				SF.click_button $ffa_next_button
				SF.click_button $bgm_start_matching_button
				SF.wait_for_apex_job
				
				#Expected Result
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page firstinvoice_number
				payment_status = SIN.get_invoice_payment_status
				gen_compare $bd_document_payment_status_paid , payment_status , "Expected Invoice Status  to be paid for "+ firstinvoice_number	
				outstanding_value = SIN.get_invoice_payment_outstanding_value
				gen_compare '0.00' , outstanding_value , "Expected Invoice outstanding value : 0.00 "+ firstinvoice_number		
				
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page secondinvoice_number
				payment_status = SIN.get_invoice_payment_status
				gen_compare $bd_document_payment_status_paid , payment_status , "Expected Invoice Status  to be paid for "+ secondinvoice_number
				outstanding_value = SIN.get_invoice_payment_outstanding_value
				gen_compare '0.00' , outstanding_value , "Expected Invoice outstanding value : 0.00 "+ secondinvoice_number	
				
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page thirdinvoice_number
				payment_status = SIN.get_invoice_payment_status
				gen_compare $bd_document_payment_status_part_paid , payment_status , "Expected Invoice Status  to be part paid for "	 + thirdinvoice_number
				# Check mail for background matching.
				_actual_mail_content = Mailinator.get_mail_content $bd_mail_id_ffa_autotest_user, _mail_subject , true
				if _actual_mail_content.include?(_expected_mail_content2)
					gen_report_test "Expected mail to contain the necessary information of successfull background matching."
				else
					gen_report_test "WARNING: MAIL not delivered successfully at mailinator.Expected: #{_expected_mail_content2} and Actual: #{_actual_mail_content}"
				end
			end
	    end
		gen_end_test "TID013882"
	end	
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID013887 and TID013882"
		SF.logout 
	end	
end
