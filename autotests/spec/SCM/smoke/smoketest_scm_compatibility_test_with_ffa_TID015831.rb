#--------------------------------------------------------------------#
#	TID : TID015831- SCM Compatibility Test
# 	Pre-Requisite : spec/SCM/setup_data/setup_data.rb
#  	Product Area: Accounting - Check
#--------------------------------------------------------------------#

describe "Smoke Test:SCM Compatibility Test- check FFA is not affected by the installation of SCM", :type => :request do
include_context "login"
	before :all do
		gen_start_test "TID015831 -SCM Compatibility Test"
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end	
	current_date = Date.today
	_match_message = "Invoice {0} has been successfully matched to credit note {1}."
		
	it "TID015831-TST036829 : Create a cash entry and post it. " do
		
		_cashentry_value_220 = "220.00" 
		_cashentry_description = "TST036829 Cash Entry"
		_currency_dual_rate_0_56 = "0.56"
		
		gen_start_test "TST036829-Create and Post Cash Entry"
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_aus] ,true
			
			SF.tab $tab_cash_entries
			SF.click_button_new
			SF.wait_for_search_button
			CE.set_bank_account $bd_bank_account_commonwealth_current_account
			CE.set_currency_dual_rate _currency_dual_rate_0_56
			CE.set_payment_method $bd_payment_method_cash
			CE.set_cash_entry_description _cashentry_description
			
			CE.line_set_account_name $bd_account_jboag_and_sons
			FFA.click_new_line
			CE.line_set_payment_method_value 1 ,$bd_payment_method_cash
			CE.line_set_cashentryvalue 1,_cashentry_value_220
			CE.click_update
			FFA.click_save_post
			gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "TST036829: Expected cash entry status to be complete"
		end	
		gen_end_test "TST036829-Create and Post Cash Entry"
		SF.logout
	end
	
	it "TID015831-TST036830: Create post PIN and convert it into PCR " do
		login_user
		_vendor_inv_number = "ABC1001"
		_vendor_inv_total_436 = "436.00"
		_vendor_credit_note_number = "VCN1"
		_vendor_credit_note_total = "218.00"
		_dual_rate_0_56 = "0.56"
		_dim1 = 1
		gen_start_test "TST036830: Create post PIN and convert it into PCR "
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_aus] ,true
			
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bd_account_jboag_and_sons
			FFA.click_account_toggle_icon
			PIN.set_account_dimension _dim1 , $bd_dimension_queensland
			FFA.click_account_toggle_icon
			PIN.set_invoice_date current_date.strftime("%d/%m/%Y")
			PIN.set_currency_dual_rate _dual_rate_0_56
			PIN.set_vendor_invoice_number _vendor_inv_number
			PIN.set_vendor_invoice_total _vendor_inv_total_436
			
			#Add expense line - GLA
			PIN.set_expense_line_gla $bd_gla_account_payable_control_aud
			PIN.click_new_expense_line
			PIN.set_expense_line_net_value 1, "200.00"
			PIN.set_expense_line_tax_code 1 , $bd_tax_code_gst_purchase
			# Add Product Line 
			PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PIN.click_product_new_line
			PIN.set_product_line_quantity 1, 1
			PIN.set_product_line_unit_price 1, "200.00"
			PIN.set_product_line_tax_code 1, $bd_tax_code_gst_purchase
			# Post the Payable Invoice
			FFA.click_save_post
			invoice_name = PIN.get_invoice_number
			gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TST036830: Expected Payable Invoice status to be complete. "
			
			SF.click_button $pinext_convert_to_credit_note
			PCR.set_vendor_credit_note_number_convert _vendor_credit_note_number
			# confirm the action
			SF.click_button $pinext_convert_to_credit_note_confirm
			SF.wait_for_search_button
			credit_note_number = SCR.get_credit_note_number
			FFA.click_post_match
			page.has_text?($bd_document_status_complete)
			gen_compare $bd_document_status_complete , PCR.get_credit_note_status , "TST036830: Expected PCRN status to be complete"
			gen_compare  true, page.has_text?(_match_message.sub("{0}", invoice_name ).sub("{1}",credit_note_number)) , "Post and match successfull"
		end
		gen_end_test "TST036830: Create post PIN and convert it into PCR "
		SF.logout
	end
		
	it "TID015831- TST036837: 	Create and Post SIN and convert it into SCR" do
		login_user
		gen_start_test "TST036837: 	Create and Post SIN and convert it into SCR"
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_bolinger
			FFA.click_new_line
			SIN.line_set_product_name 1, $bd_product_champagne
			SIN.line_set_quantity 1,1
			SIN.line_set_unit_price 1, "50.00"
			SIN.set_product_diemension1 $bd_dim1_gbp
			SIN.set_product_diemension2 $bd_dim2_gbp
			FFA.click_save_post
			gen_compare $bd_document_status_complete, SIN.get_status ,"Expected sales invoice status to be complete."
			SF.click_button $sin_convert_to_credit_note_button
			SF.wait_for_search_button
			gen_compare true, page.has_text?($bd_document_status_in_progress), "Convert to credit note , SCR is in inprogress status"
			SF.click_button_edit
			SF.wait_for_search_button
			SF.click_button_save
			SF.wait_for_search_button
			SF.click_button $scn_post_match_button
			gen_compare true, page.has_text?($bd_document_status_complete), "Post and match SCR is in Complete status"
		end
		gen_end_test "TST036837: 	Create and Post SIN and convert it into SCR"
		SF.logout
	end
	
	it "TID015831- TST036838: TST036838: Create and post journals" do
	
		login_user
		gen_start_test "TST036838: 	Create and post journals"
		begin			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_journals
			SF.click_button_new

			JNL.select_journal_line_type $bd_jnl_line_type_account_customer
			JNL.select_journal_line_value $bd_account_bolinger
			JNL.add_line 1 , $bd_gla_write_off_uk  , "100" , nil , nil ,nil, nil,nil
			JNL.add_line_analysis_details 1,"10.00", nil,nil

			JNL.select_journal_line_type $bd_jnl_line_type_account_vendor
			JNL.select_journal_line_value  $bd_account_bolinger
			JNL.add_line 2 , $bd_gla_write_off_uk  , "-100" , nil , nil ,nil, nil,nil

			FFA.click_save_post
			gen_compare $bd_jnl_type_manual_journal , JNL.get_journal_type , "Expected Journal type to be Manual Journal"
			gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
		end
		gen_end_test "TST036838: Create and post journals"
		SF.logout
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_start_test "TID015831 -SCM Compatibility Test"
		SF.logout 
	end
end	