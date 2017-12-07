#--------------------------------------------------------------------#
#TID : TID013700
# Pre-Requisit: Org with basedata deployed; Deploy CODATID013700Data.cls on org.
# Product Area: 
# Story: 27344 
#--------------------------------------------------------------------#

describe "Pay without account Payable account", :type => :request do
include_context "login"
include_context "logout_after_each"
_account_payable_control = ""
	before :all do
		gen_start_test  "TID013700-Create Purchase Invoices , POST and Pay without account Payable account "
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "Execute Script as Anonymous user , Create Purchase Invoices and Post ", :unmanaged => true  do
		_payment_total_value_N409_70 = "-409.70"
		_payment_total_value_N304_65 = "-304.65"
		_transaction_line_Item_number_0 = [0];	
		gen_start_test "TST017838 - starts Verify error message to be displayed on click of Pay button, if Account payable control field is blank for accounts retrieved in Payment."
		begin
			begin "get Account payable Control and Execute Script as Anonymous user " 
				#get Account payable Control 
				SF.tab $tab_accounts
				SF.select_view $bd_select_view_all_accounts
				SF.click_button_go
				SF.select_records_per_page "100"
				gen_click_link_and_wait $bd_account_bmw_automobiles
				_account_payable_control = Account.get_account_payable_control_name
			
				create_payable_invoices = [ "CODATID013700Data.selectCompany();",
					"CODATID013700Data.createData();",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_AUDI);",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_AUDI);",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);",
					"CODATID013700Data.createCheckRange();",
					"CODATID013700Data.createPaymentAndRerieveAccounts();"]
					
				APEX.execute_commands create_payable_invoices
			end
			begin
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				SF.edit_list_view $bd_select_view_all, $label_payment_payment_value, 4
				payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_N409_70 , $label_payment_number

				#Uncheck a Line Item from Audi Account and click OK and Save"
				PAY.uncheck_account_line_Items payment_no, $bd_account_audi, _transaction_line_Item_number_0
				PAY.click_save_button
				SF.wait_for_apex_job
							
				#remove Account payable from Account
				remove_account_payable = [ "CODATID013700Data.ChangeAccountPayableControl(null);"]						
				APEX.execute_commands remove_account_payable
				
				#Click on pay button
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_N304_65 , $label_payment_number
				PAY.open_payment_detail_page payment_no
				gen_wait_until_object_disappear $pay_transaction_processing_icon
				PAY.click_pay_button
				
				#get Error Messages on Page 
				_actual_error_message = PAY.get_error_message
				_expected_error_message = $ffa_msg_payment_pay_enter_payable_Control_field_value.gsub($sf_param_substitute, $bd_account_bmw_automobiles) 
				gen_compare _expected_error_message, _actual_error_message,"Expected - Account Payable Control should present for account"			
						
				#"Reset account Payable control value for account and Destroy Data as Anonymous user " 
				reset_gla_and_destroy_test_data = [ "CODATID013700Data.ChangeAccountPayableControl('"+_account_payable_control+"');", "CODATID013700Data.destroyData();"]						
				APEX.execute_commands reset_gla_and_destroy_test_data	
			end
		end
		
		gen_start_test "TST017839 starts - Verify error message to be displayed on click of Confirm & Pay button, if Account payable control field is blank for accounts retrieved in Payment."
		begin
			begin	"Execute Script as Anonymous user,  Create Purchase Invoices and Post " 
				create_payable_invoices = [ "CODATID013700Data.selectCompany();",
					"CODATID013700Data.createData();",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_AUDI);",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_AUDI);",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);",
					"CODATID013700Data.createPurchaseInvoiceSaveAndPost(CODABaseDataExt.NAMEACCOUNT_BMWAUTOMOBILES);",
					"CODATID013700Data.createCheckRange();",
					"CODATID013700Data.createPaymentAndRerieveAccounts();"]
					
				APEX.execute_commands create_payable_invoices
			end
			
			begin		
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_N409_70 , $label_payment_number

				#Uncheck a Line Item from Audi Account and click OK and Save"
				PAY.uncheck_account_line_Items payment_no, $bd_account_audi, _transaction_line_Item_number_0
				PAY.click_save_button
				SF.wait_for_apex_job	

				#Click on pay button
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_N304_65 , $label_payment_number
				PAY.open_payment_detail_page payment_no
				gen_wait_until_object_disappear $pay_transaction_processing_icon
				PAY.click_pay_button
				PAY.click_dialog_box_ok_button
				
				#get Account payable from Account
				SF.tab $tab_accounts
				SF.select_view $bd_select_view_all_accounts
				SF.click_button_go
				SF.select_records_per_page "100"
				gen_click_link_and_wait $bd_account_bmw_automobiles
				_account_payable_control = Account.get_account_payable_control_name
							
				#remove Account payable from Account
				remove_account_payable = [ "CODATID013700Data.ChangeAccountPayableControl(null);"]						
				APEX.execute_commands remove_account_payable			
				
				#Click on confirm and pay button
				SF.tab $tab_payments
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.wait_for_search_button
				payment_no = FFA.get_column_value_in_grid $label_payment_payment_value , _payment_total_value_N304_65 , $label_payment_number
				PAY.open_payment_detail_page payment_no
				PAY.click_dialog_box_ok_button
				PAY.click_confirm_pay_button
				
				#get Error Messages on Page 
				_actual_error_message = PAY.get_error_message
				_expected_error_message = $ffa_msg_payment_confirm_pay_enter_payable_Control_field_value.gsub($sf_param_substitute, $bd_account_bmw_automobiles) 
				gen_compare _expected_error_message, _actual_error_message,"Expected - Account Payable Control should present for account"			 
			end
		end
	end
	after :all do
		login_user	
		#"Reset account Payable control value for account and Destroy Data as Anonymous user " 
		_account_payable_control = $bdu_gla_account_payable_control_eur
		reset_gla_and_destroy_test_data = [ "CODATID013700Data.ChangeAccountPayableControl('"+_account_payable_control+"');" , "CODATID013700Data.destroyData();"]						
		APEX.execute_commands reset_gla_and_destroy_test_data	
		
		#Delete Test Data
		FFA.delete_new_data_and_wait	
		SF.logout
		gen_end_test  "TID013700-Create Purchase Invoices , POST and Pay without account Payable account."	
	end
end
