#------------------------------------------------------------------------------------------------------#
#	TID : TID013944
# 	Pre-Requisite : Org with basedata deployed and run.postInstall ant target is executed on Org;
#					Deploy CODATID013944Data.cls on org
#  	Product Area: Accounting - Purchase Credit Notes (UI Test)
#------------------------------------------------------------------------------------------------------#


describe "UI Test - Accounting - Conversion of PIN to PCN for Paid/Unpaid/Part-Paid PIN", :type => :request do
include_context "login"
include_context "logout_after_each"

	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID013944 : Accounting - Conversion of PIN to PCN for Paid/Unpaid/Part-Paid PIN"		
	end
	
	it "TID013944 : Accounting - Conversion of PIN to PCN for Paid/Unpaid/Part-Paid PIN", :unmanaged => true  do
		gen_start_test "TID013944 : Verify that Payable Invoice with Payment status 'Paid' should be converted to payable credit note "
		
		_pcr_vendor_credit_note_number = "#TID013944CRN_1"		
		_pcr_vendor_credit_note_number_2 = "#TID013944CRN_2"
		_pcr_vendor_credit_note_number_3 = "#TID013944CRN_3"
		_pin_vendor_invoice_number = "#TID013944_1"
		_pin_vendor_invoice_number_2 = "#TID013944_2"
		_pin_vendor_invoice_number_3 = "#TID013944_3"
		_payment_method_electronic = "Electronic"
		_payable_invoice_1 = ""
		_payable_invoice_2 = ""
		_payable_invoice_3 = ""	
		_payment_value_437 = "-437.00"
		_payment_value_100 = "-100.00"
		_pcr_warning_message = "You are about to convert an invoice that is paid or part-paid to a credit note. Enter the vendor credit note number provided by the vendor."
		_pcr_convert_to_credit_note_message = "You are about to convert this invoice to a credit note. Enter the vendor credit note number provided by the vendor."
		
		gen_start_test "TST018550	- Verify that Payable Invoice with Payment status 'Paid' should be converted to payable credit note "
		begin
			#Execute the apex methods
			_create_data = ["CODATID013944Data.selectCompany();", "CODATID013944Data.createData();", 
							"CODATID013944Data.createDataExt1();",
							"CODATID013944Data.createAndPostPurchaseInvoice_1();", 
							"CODATID013944Data.retreivePayableInvoice(CODATID013944Data.REF_PAY1);",
							"CODATID013944Data.payableInvoicePay(CODATID013944Data.REF_PAY1);"]
			APEX.execute_commands _create_data
			SF.wait_for_apex_job
			_confirm_pay_data = ["CODATID013944Data.payableInvoiceConfirmPay(CODATID013944Data.REF_PAY1);"]
			APEX.execute_commands _confirm_pay_data
			SF.wait_for_apex_job
			_pin_status_and_switch_profile = [	"CODATID013944Data.verifyPayableInvoiceStatus(CODATID013944Data.VENDOR_INVOICE_NUM_1, CODATID013944Data.PAYMENTSTATUS_PAID);","CODATID013944Data.switchProfile();"]
			APEX.execute_commands _pin_status_and_switch_profile
			# Update payable invoice list view
			SF.tab $tab_payable_invoices
			SF.click_button_go		
			SF.edit_list_view $bd_select_view_all, $pin_vendor_invoice_number_label, 5
		end
		
		begin
			SF.login_as_user $bd_user_std_user_alias 
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
		end
		
		begin
			SF.tab $tab_payable_invoices
			SF.click_button_go		
			_payable_invoice_1 = FFA.get_column_value_in_grid $pin_vendor_invoice_number_label , _pin_vendor_invoice_number , $pin_payable_invoice_number_label
			SF.click_link _payable_invoice_1
			SF.wait_for_search_button
			SF.click_button $sin_convert_to_credit_note_button
			SF.wait_for_search_button
			expect(page).to have_text(_pcr_warning_message)
			PCR.set_vendor_credit_note_number_convert _pcr_vendor_credit_note_number
			# confirm the action
			PINEXT.convert_to_credit_note_confirm
			SF.wait_for_search_button			
			SF.logout
		end
		
		# Verify Converted Credit note status
		begin
			# login_user
			#Execute the apex method
			_verifyTST018550 = ["CODATID013944Data.verifyTST018550();"]
			APEX.execute_commands _verifyTST018550			
		end	
	
		gen_end_test "TST018550	- Verify that Payable Invoice with Payment status 'Paid' should be converted to payable credit note "
	
		gen_start_test "TST018551 : Verify that Payable Invoice with Payment status 'Unpaid' should be converted to payable credit note "	
		begin
			#Execute the apex methods
			_create_invoice_and_verify_status = [	"CODATID013944Data.createAndPostPurchaseInvoice_2();",
													"CODATID013944Data.verifyPayableInvoiceStatus(CODATID013944Data.VENDOR_INVOICE_NUM_2,CODATID013944Data.PAYMENTSTATUS_UN_PAID);"]			
			APEX.execute_commands _create_invoice_and_verify_status

			
			SF.login_as_user $bd_user_std_user_alias 
			SF.tab $tab_payable_invoices
			SF.click_button_go
			_payable_invoice_2 = FFA.get_column_value_in_grid $pin_vendor_invoice_number_label , _pin_vendor_invoice_number_2 , $pin_payable_invoice_number_label
			SF.click_link _payable_invoice_2
			SF.wait_for_search_button
			SF.click_button $sin_convert_to_credit_note_button
			SF.wait_for_search_button
			expect(page).to have_text(_pcr_convert_to_credit_note_message)
			PCR.set_vendor_credit_note_number_convert _pcr_vendor_credit_note_number_2
			# confirm the action
			PINEXT.convert_to_credit_note_confirm
			SF.wait_for_search_button
			SF.logout

			#Execute the apex method
			_verifyTST018551 = ["CODATID013944Data.verifyTST018551();"]
			APEX.execute_commands _verifyTST018551
		end
		gen_end_test "TST018551 : Verify that Payable Invoice with Payment status 'Unpaid' should be converted to payable credit note "

		gen_start_test "TST018553 : Verify that Payable Invoice with Payment status 'Part Paid' should be converted to payable credit note"
		begin
			# Execute the apex methods
			_create_data = ["CODATID013944Data.createAndPostPurchaseInvoice_3();" ,"CODATID013944Data.retreivePayableInvoice(CODATID013944Data.REF_PART_PAY);"]
			APEX.execute_commands _create_data
			# Retrieve Payable Invoice number
			
			SF.tab $tab_payable_invoices
			SF.click_button_go	
			
			_payable_invoice_3 = FFA.get_column_value_in_grid $pin_vendor_invoice_number_label , _pin_vendor_invoice_number_3 , $pin_payable_invoice_number_label
			
			# Step for converting a payable invoice to Part paid Payable invoice
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button	
			SF.edit_list_view $bd_select_view_all, $label_payment_payment_value, 7
			_payment_number_retrieved = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_value_437 , $label_payment_number
			PAY.open_payment_detail_page _payment_number_retrieved
			gen_wait_until_object_disappear $pay_transaction_processing_icon			
			PAY.click_show_transactions $bdu_account_bmw_automobiles			
			PAY.set_transactions_payment_value _payable_invoice_3, _payment_value_100			
			PAY.click_pay_button
			page.has_text?($pay_payment_confirm_pay_button)
			PAY.click_confirm_pay_button
			SF.wait_for_apex_job
			
			#Execute the apex methods
			_verify_status = [	"CODATID013944Data.verifyPayableInvoiceStatus(CODATID013944Data.VENDOR_INVOICE_NUM_3,CODATID013944Data.PAYMENTSTATUS_PART_PAID);"]
			APEX.execute_commands _verify_status
			
			SF.login_as_user $bd_user_std_user_alias 
			# Convert to Payable Credit Note
			SF.tab $tab_payable_invoices
			SF.click_button_go				
			_payable_invoice_3 = FFA.get_column_value_in_grid $pin_vendor_invoice_number_label , _pin_vendor_invoice_number_3 , $pin_payable_invoice_number_label
			SF.click_link _payable_invoice_3
			SF.wait_for_search_button
			SF.click_button $sin_convert_to_credit_note_button
			SF.wait_for_search_button
			expect(page).to have_text(_pcr_warning_message)
			PCR.set_vendor_credit_note_number_convert _pcr_vendor_credit_note_number_3
			# confirm the action
			PINEXT.convert_to_credit_note_confirm
			SF.wait_for_search_button
			SF.logout
			#Execute the apex method
			_verifyTST018553 = ["CODATID013944Data.verifyTST018553();"]
			APEX.execute_commands _verifyTST018553
		end
		gen_end_test "TST018553 : Verify that Payable Invoice with Payment status 'Part Paid' should be converted to payable credit note"	
	end
	
	after :all do
		login_user		
		# Delete Test Data
		_delete_data = ["CODATID013944Data.destroyData();","CODATID013944Data.destroyDataExt1();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		SF.logout		
		gen_end_test "TID013944 : Accounting - Conversion of PIN to PCN for Paid/Unpaid/Part-Paid PIN"
	end
end