#--------------------------------------------------------------------#
#	TID : TID013438 
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Merlin Auto Spain- cash matching (Smoke Test)
# 	Story: 24494 
#--------------------------------------------------------------------#

describe "Smoke test: cash matching", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "Merlin Auto Spain: TID013438: Cash Matching by Invoice Number."
	end
	
	it "TID013438 : Cash Matching by - Invoice Number, Customer Reference for Merlin Auton Spain" do
		
		_line = 1
		_cashentry_date = "16/01/2015"
		_expected_period = "2015/001"
		_cash_entry_value = "100.00"
		_unit_price = "100.00"
		_invoice_date = "01/01/2015"
		_match_upto_date = "20/01/2015"
		_reference_number = "BMRef1"
		_mail_subject = "Background Matching completed"
		_message = "Please review your settings before continuing. Matches created in error must be undone manually in Cash Matching."
		_expected_partial_payment_value = "Enabled"
		_expected_mail_content1 = "Matching Criteria Summary: Company : Merlin Auto Spain Matched by : Customer Reference Allow Partial Payment : Yes Matching Date: "+Time.now.strftime("%d/%m/%Y")+" Match Up To: 20/01/2015 Where: Document currency is Mixed Account: Algernon Partners & Co Matching Results : Invoices Matched: 1 Cash Matched: 1 Total Invoice Amount Matched: 100.00 Total Cash Amount Matched: 95.00 Total Discount: 5.00 Thank you for using FinancialForce. Created by FinancialForce http://www.FinancialForce.com/"
		_expected_mail_content2 = "Matching Criteria Summary: Company : Merlin Auto Spain Matched by : Invoice Number Allow Partial Payment : Yes Matching Date: "+Time.now.strftime("%d/%m/%Y")+" Match Up To: 20/01/2015 Where: Document currency is Mixed Account: Algernon Partners & Co Matching Results : Invoices Matched: 1 Cash Matched: 1 Total Invoice Amount Matched: 100.00 Total Cash Amount Matched: 95.00 Total Discount: 5.00 Thank you for using FinancialForce. Created by FinancialForce http://www.FinancialForce.com/"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		puts "Additional data setup required for execution of script"
		begin
			SF.set_bcc_email $bd_mail_id_ffa_autotest_user, true
		end
		
		puts "TST017187 : Cash Matching by Customer Reference"
		begin
			puts "1.1 : Create a cash entry record and save and post it."
			begin
				SF.tab $tab_cash_entries
				SF.wait_for_search_button
				SF.click_button_new
				page.has_text?($cashentry_bank_account)
				CE.set_bank_account $bd_bank_account_santander_current_account
				CE.set_date _cashentry_date
				gen_compare _expected_period , CE.get_cashentry_period , "Expected Cash Entry period will be 2015/001"
				FFA.select_currency_from_lookup $cashentry_currency_lookup, $bd_currency_eur, $company_merlin_auto_spain
				CE.line_set_account_name $bd_account_algernon_partners_co
				FFA.click_new_line
				CE.line_set_cashentryvalue _line , _cash_entry_value
				CE.line_set_account_reference _line, _reference_number
				FFA.click_save_post
				gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "Expected Cash entry status to be complete" 
			end
			
			puts "1.2 : Creating a Sales Invoice record and save and post it."
			begin
				SF.tab $tab_sales_invoices
				SF.wait_for_search_button
				SF.click_button_new
				SIN.set_account $bd_account_algernon_partners_co
				SIN.set_invoice_date _invoice_date
				gen_compare _expected_period , SIN.get_invoice_period_before_save , "Expected Invoice period to be 2015/001"
				SIN.set_currency $bd_currency_eur
				FFA.click_new_line
				SIN.line_set_product_name _line , $bd_product_auto_com_clutch_kit_1989_dodge_raider
				SIN.line_set_unit_price _line , _unit_price
				SIN.line_set_tax_code _line , nil
				SIN.set_customer_reference _reference_number
				FFA.click_save_post
				gen_compare $bd_document_status_complete, SIN.get_status, "Expected Sales Invoice status to be Complete"
			end
			
			puts "1.3 : Background matching by Customer Reference"
			begin
				# Go to background matching tab and set fields
				SF.tab $tab_background_matching
				BGM.set_account $bd_account_algernon_partners_co
				BGM.set_match_upto_date _match_upto_date
				BGM.select_currency_mode $bd_bgm_currency_mode_document
				BGM.select_matching_currency $bd_bgm_matching_currency_all_currencies
				BGM.select_first_match_by $bd_bgm_first_match_by_customer_reference
				BGM.set_allow_partial_payment true
				_date_today =  Time.now.strftime("%d/%m/%Y")
				BGM.set_matching_date _date_today
				SF.click_button $ffa_next_button
				page.has_text?($bd_account_algernon_partners_co)
				# Verification points for next page
				gen_compare $bd_account_algernon_partners_co, BGM.get_account_value, "Expected account to be Algernon Partners & Co"
				gen_compare _match_upto_date, BGM.get_matched_up_to_value, "Expected matched upto to be 20/01/2015"
				gen_compare $bd_bgm_first_match_by_customer_reference, BGM.get_first_match_by_value, "Expected first match by to be Customer Reference"
				gen_compare "Document currency is Mixed", BGM.get_where_value, "Expected where to be Document currency is Mixed"
				gen_compare _date_today, BGM.get_matching_date_value, "Expected matching date to be " +_date_today
				gen_compare _expected_partial_payment_value, BGM.get_partial_payments_value, "Expected partial payments to be Enabled"
				gen_compare _message, BGM.get_warning_message, "Expected warning message to be Please review your settings before continuing. Matches created in error must be undone manually in Cash Matching."
				SF.click_button $bgm_start_matching_button
				SF.wait_for_apex_job
				# Verification of email through mailinator
				_actual_mail_content = Mailinator.get_mail_content $bd_mail_id_ffa_autotest_user, _mail_subject , true
				if _actual_mail_content.include?(_expected_mail_content1)
					gen_report_test "Expected mail to contain the necessary information of successfull background matching."
				else
					gen_report_test "WARNING: MAIL not delivered successfully at mailinator.Expected: #{_expected_mail_content1} and Actual: #{_actual_mail_content}"
				end
			end
		end
		
		puts "TST017188 : Cash Matching by Invoice Number"
		begin
			puts "1.1 : Create sales invoice with a product line item and save and post it."
			begin
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account $bd_account_algernon_partners_co
				SIN.set_invoice_date _invoice_date
				gen_compare _expected_period , SIN.get_invoice_period_before_save , "Expected Invoice period to be 2015/001"
				SIN.set_currency $bd_currency_eur
				FFA.click_new_line
				SIN.line_set_product_name _line , $bd_product_auto_com_clutch_kit_1989_dodge_raider
				SIN.line_set_unit_price _line , _unit_price
				SIN.line_set_tax_code _line , nil
				SIN.set_customer_reference _reference_number
				FFA.click_save_post
				_invoice_number = SIN.get_invoice_number
				gen_compare $bd_document_status_complete, SIN.get_status, "Expected Sales Invoice status to be Complete"
			end
			
			puts "1.2 : Create a cash entry record and save and post it."
			begin
				SF.tab $tab_cash_entries
				SF.wait_for_search_button
				SF.click_button_new
				CE.set_bank_account $bd_bank_account_santander_current_account
				CE.set_date _cashentry_date
				gen_compare _expected_period , CE.get_cashentry_period , "Expected Cash Entry period will be 2015/001"
				FFA.select_currency_from_lookup $cashentry_currency_lookup, $bd_currency_eur, $company_merlin_auto_spain
				CE.line_set_account_name $bd_account_algernon_partners_co
				FFA.click_new_line
				CE.line_set_cashentryvalue _line , _cash_entry_value
				CE.line_set_account_reference _line, _invoice_number
				FFA.click_save_post
				gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "Expected Cash entry status to be complete"
			end
			
			puts "1.3 : Background matching by Invoice Number"
			begin
				# Go to background matching tab and set fields
				SF.tab $tab_background_matching
				BGM.set_account $bd_account_algernon_partners_co
				BGM.set_match_upto_date _match_upto_date
				BGM.select_currency_mode $bd_bgm_currency_mode_document
				BGM.select_matching_currency $bd_bgm_matching_currency_all_currencies
				BGM.select_first_match_by $bd_bgm_first_match_by_invoice_number
				BGM.set_allow_partial_payment true
				BGM.set_matching_date _date_today
				SF.click_button $ffa_next_button
				# Verification points for next page
				gen_compare $bd_account_algernon_partners_co, BGM.get_account_value, "Expected account to be Algernon Partners & Co"
				gen_compare _match_upto_date, BGM.get_matched_up_to_value, "Expected matched upto to be 20/01/2015"
				gen_compare $bd_bgm_first_match_by_invoice_number, BGM.get_first_match_by_value, "Expected first match by to be Customer Reference"
				gen_compare "Document currency is Mixed", BGM.get_where_value, "Expected where to be Document currency is Mixed"
				gen_compare _date_today, BGM.get_matching_date_value, "Expected matching date to be "+_date_today
				gen_compare _expected_partial_payment_value, BGM.get_partial_payments_value, "Expected partial payments to be Enabled"
				gen_compare _message, BGM.get_warning_message, "Expected warning message to be Please review your settings before continuing. Matches created in error must be undone manually in Cash Matching."
				SF.click_button $bgm_start_matching_button
				SF.wait_for_apex_job
				# Verification of email through mailinator
				_actual_mail_content = Mailinator.get_mail_content $bd_mail_id_ffa_autotest_user, _mail_subject , true
				if _actual_mail_content.include?(_expected_mail_content2)
					gen_report_test "Expected mail to contain the necessary information of successfull background matching."
				else
					gen_report_test "WARNING: MAIL not delivered successfully at mailinator.Expected: #{_expected_mail_content2} and Actual: #{_actual_mail_content}"
				end
			end
		end		
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		puts "Revert additional data setup done initially : Disable BCC email functionality"
		SF.set_bcc_email $bd_mail_id_ffa_autotest_user, false
		gen_end_test "Merlin Auto Spain: TID013438: Cash Matching by Invoice Number."
		SF.logout 
	end
end