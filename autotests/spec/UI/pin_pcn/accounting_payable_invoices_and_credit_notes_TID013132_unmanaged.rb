#--------------------------------------------------------------------#
#	TID : TID013132
# 	Pre-Requisite : Org with basedata deployed, Deploy CODATID013132Data.cls on org
#  	Product Area: Accounting - Payables Invoices & Credit Notes (UI Test)
# 	Story: 27348 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Payables Invoices & Credit Notes", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID013132 : Accounting - Payables Invoices & Credit Notes UI Test"
	end
	
	it "TID013132 : Verify that selection criteria of Payable Invoices for Payments and Payment Selection", :unmanaged => true  do
		gen_start_test "TID013132 : Verify that selection criteria of Payable Invoices for Payments and Payment Selection"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		create_payable_invoices = ["CODATID013132Data.selectCompany();", "CODATID013132Data.createData();", "CODATID013132Data.createDataExt1();", "CODATID013132Data.createDataExt2();", "CODATID013132Data.switchProfile();"]
		APEX.execute_commands create_payable_invoices
		current_date = Time.now
		_date_after_60_days = FFA.add_days_to_date current_date , "60"
		_pin1_vendor_inv_num = "BMW001"
		_pin2_vendor_inv_num = "BMW002"
		
		gen_start_test "TST016849 : Payable Invoices with status 'On Hold' should not be available in Payments"
		begin
			SF.tab $tab_payable_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			_expected_visible_pin_number2 = FFA.get_column_value_in_grid $pin_vendor_invoice_number_label , _pin2_vendor_inv_num , $pin_payable_invoice_number_label
			SF.tab $tab_payments
			SF.click_button_new
			FFA.select_bank_account_from_lookup $pay_bank_account_lookup_icon, $bdu_bank_account_apex_eur_b_account, $company_merlin_auto_spain
			gen_tab_out $pay_bank_account
			FFA.wait_page_message $ffa_msg_retrieving_payment_currency
			PAY.set_settlement_discount $bdu_gla_settlement_discounts_allowed_uk
			PAY.set_currency_write_off $bdu_gla_write_off_uk
			PAY.set_due_date _date_after_60_days
			PAY.click_retrieve_accounts_button
			PAY.click_show_transactions $bdu_account_bmw_automobiles
			within_frame(find($pay_show_transaction_pop_up)) do
				expect(page).not_to have_text(_expected_visible_pin_number2)
			end
			PAY.account_transaction_click_ok_button
			gen_report_test "Expected Payable Invoices with Status 'on Hold' are not available for Payments"
		end
		
		gen_start_test "TST016850 : Payable Invoices with status 'Release for Payments should be available in Payments"
		begin
			SF.tab $tab_payable_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			_expected_visible_pin_number1 = FFA.get_column_value_in_grid $pin_vendor_invoice_number_label , _pin1_vendor_inv_num , $pin_payable_invoice_number_label
			SF.tab $tab_payments
			SF.click_button_new
			FFA.select_bank_account_from_lookup $pay_bank_account_lookup_icon, $bdu_bank_account_apex_eur_b_account, $company_merlin_auto_spain
			gen_tab_out $pay_bank_account
			FFA.wait_page_message $ffa_msg_retrieving_payment_currency
			PAY.set_settlement_discount $bdu_gla_settlement_discounts_allowed_uk
			PAY.set_currency_write_off $bdu_gla_write_off_uk
			PAY.set_due_date _date_after_60_days
			PAY.click_retrieve_accounts_button
			PAY.click_show_transactions $bdu_account_bmw_automobiles
			within_frame(find($pay_show_transaction_pop_up)) do
				expect(page).to have_text(_expected_visible_pin_number1)
			end
			PAY.account_transaction_click_ok_button
			gen_report_test "Expected posted Payable Invoices with Status not 'on Hold' are available for Payments"
		end
		
		gen_start_test "TST016851 : Payable Invoices with status 'On Hold' should not be available in Payments Selection"
		begin	
			SF.tab $tab_payment_selection
			gen_wait_until_object_disappear $page_loadmask_message
			PAYSEL.set_due_date_end_date_filter _date_after_60_days
			gen_tab_out $paysel_due_date_end_date
			PAYSEL.click_retrieve_documents
			PAYSEL.expand_retreived_documents $bdu_account_bmw_automobiles
			expect(page).not_to have_text(_expected_visible_pin_number2)
			gen_report_test "Expected Payable Invoices with Status 'on Hold' are not available for Payments"
		end
		
		gen_start_test "TST016852 : Payable Invoices with status 'Release for Payments' will be available in Payments Selection"
		begin	
			SF.tab $tab_payment_selection
			gen_wait_until_object_disappear $page_loadmask_message
			PAYSEL.set_due_date_end_date_filter _date_after_60_days
			gen_tab_out $paysel_due_date_end_date
			PAYSEL.click_retrieve_documents
			PAYSEL.expand_retreived_documents $bdu_account_bmw_automobiles
			expect(page).to have_text(_expected_visible_pin_number1)
			gen_report_test "Expected posted Payable Invoices with Status not 'on Hold' are available for Payments"
		end
		gen_end_test "TID013132 : Verify that selection criteria of Payable Invoices for Payments and Payment Selection"
	end
	
	after :all do
		login_user
		delete_payable_invoices = ["CODATID013132Data.destroyData();"]
		APEX.execute_commands delete_payable_invoices
		FFA.delete_new_data_and_wait
		gen_end_test "TID013132 : Accounting - Payables Invoices & Credit Notes UI Test"
	end
end