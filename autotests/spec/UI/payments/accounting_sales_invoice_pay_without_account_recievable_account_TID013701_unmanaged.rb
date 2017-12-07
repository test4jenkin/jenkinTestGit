#--------------------------------------------------------------------#
#TID : TID013701
# Pre-Requisit: Org with basedata deployed;Deploy CODATID013701Data.cls on org.
#  Product Area: Accounting : Payments
# Story: 27344 
#--------------------------------------------------------------------#

describe "Pay without account Receivable account", :type => :request do
include_context "login"
include_context "logout_after_each"
	_account_receivable_control = "";
	before :all do
		gen_start_test  "TID013701, TST017840-Create Sales Invoices , POST and Pay without account Receivable account "
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "Execute Script as Anonymous user , Create Sales Invoices and Post ", :unmanaged => true  do
		_payment_total_value_669_74 = "669.74"
		_payment_total_value_493_49 = "493.49"
		_transaction_line_Item_number_0 = [0];	
		begin
			"Execute Script as Anonymous user" 
			create_payable_invoices = [ "CODATID013701Data.selectCompany();",
						"CODATID013701Data.createData();",
						"CODATID013701Data.createSalesInvoiceSaveAndPost(CODATID013701Data.ACCOUNT_CAMBRIDGE_AUTO);",
						"CODATID013701Data.createSalesInvoiceSaveAndPost(CODATID013701Data.ACCOUNT_CAMBRIDGE_AUTO);",
						"CODATID013701Data.createSalesInvoiceSaveAndPost(CODATID013701Data.ACCOUNT_CAMBRIDGE1_AUTO);",
						"CODATID013701Data.createSalesInvoiceSaveAndPost(CODATID013701Data.ACCOUNT_CAMBRIDGE1_AUTO);",
						"CODATID013701Data.createCheckRange();",
						"CODATID013701Data.createPaymentAndRerieveAccounts();"]	
			APEX.execute_commands create_payable_invoices						
		end
		begin		
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_669_74 , $label_payment_number

			#Uncheck a Line Item from Cambridge 1 Auto Account and click OK and Save"
			PAY.uncheck_account_line_Items payment_no, $bd_account_cambridge1_auto, _transaction_line_Item_number_0
			PAY.click_save_button
			SF.wait_for_apex_job
			
			#remove Account receivable from Account
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			SF.select_records_per_page "100"
			gen_click_link_and_wait $bd_account_cambridge1_auto
			_account_receivable_control = Account.get_account_receivable_control_name
			SF.click_button_edit
			Account.set_accounts_receivable_control ""
			SF.click_button_save
			SF.wait_for_search_button
			
			#Click on pay button
			SF.tab $tab_payments
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_493_49 , $label_payment_number
			PAY.open_payment_detail_page payment_no
			gen_wait_until_object_disappear $pay_transaction_processing_icon
			PAY.click_pay_button
			SF.wait_for_search_button
			
			#get Error Messages on Page 
			_actual_error_message = PAY.get_error_message
			_expected_error_message = $ffa_msg_payment_enter_Receivable_Control_field_value.gsub($sf_param_substitute, $bd_account_cambridge1_auto) 
			gen_compare _expected_error_message, _actual_error_message,"Expected - Account Receivable Control should present for "
		end
	end
	after :all do
		login_user
		#"Destroy Data as Anonymous user " 
		destroy_test_data = [ "CODATID013701Data.destroyData();"]						
		APEX.execute_commands destroy_test_data	
		#Delete Test Data
		FFA.delete_new_data_and_wait	
		#Reset account receivale control value for account 
		if _account_receivable_control != "" then
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			SF.select_records_per_page "100"
			gen_click_link_and_wait $bd_account_cambridge1_auto
			SF.click_button_edit
			Account.set_accounts_receivable_control _account_receivable_control
			SF.click_button_save
			SF.wait_for_search_button
		end
		SF.logout
		gen_end_test  "TID013701, TST017840-Create Sales Invoices , POST and Pay without account Receivable account."	
	end
end

