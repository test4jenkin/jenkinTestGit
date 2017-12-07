#--------------------------------------------------------------------#
#TID : TID017201
#Product Area: Accounting - Sales Invoices & Credit Notes
#--------------------------------------------------------------------#

describe "SF - save and post Recurrig Invoices", :type => :request do
include_context "login"
include_context "logout_after_each"
_account_payable_control = ""
	before :all do
		gen_start_test  "TID017201: TST025213, TST025214, TST025215 and TST025216 SF - save and post Recurrig Invoices from Scratch Revenue Schedule "
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "Execute Script as Anonymous user , Create Sales Invoice and Recurring invoices ", :unmanaged => true  do
		gen_start_test "TST025213 - starts Verify error message to be displayed on click of Pay button, if Account payable control field is blank for accounts retrieved in Payment."
		begin
			#Create prerequistic data
			create_recurring_invoice = [ "CODATID017201Data.selectCompany();",
				"CODATID017201Data.createData();",
				"CODATID017201Data.CreateInvoiceToSave();",
				"CODATID017201Data.CreateInvoiceToSaveAndPost();"]					
			APEX.execute_commands create_recurring_invoice
			
			#TST025213 Preview and Save
			validations = "CODATID017201Data.RecurringInvoicePreviewAndSave();"
			APEX.execute_script validations
			query_result = APEX.get_execution_status_message
			gen_compare $apex_script_executed_successfully_message_value , query_result, "TST025213 Preview and Save successfull."					
			SF.wait_for_apex_job
			
			#TST025214 Post Last invoice and validate 
			validations = "CODATID017201Data.postLastInvoiceAndValidate();"
			APEX.execute_script validations
			query_result = APEX.get_execution_status_message
			gen_compare $apex_script_executed_successfully_message_value , query_result, "TST025214 Post Last invoice and validation successfull."				
	
			#TST025215 Save and Post  
			validations = "CODATID017201Data.SaveAndPostReccuringInvoices();"
			APEX.execute_script validations
			query_result = APEX.get_execution_status_message
			gen_compare $apex_script_executed_successfully_message_value , query_result, "TST025215 Save and Post successfull."			
			SF.wait_for_apex_job
			
			# Run background posting 
			backgroundPosting = ["BackgroundPostingSchedulerService.runNow();"]
			APEX.execute_commands backgroundPosting
			SF.wait_for_apex_job
			
			##TST025216 validate first Invoice  
			validations = "CODATID017201Data.ValidateFirstInvoiceAfterSaveAndPost();"
			APEX.execute_script validations
			query_result = APEX.get_execution_status_message
			gen_compare $apex_script_executed_successfully_message_value , query_result, "TST025216-First Invoice validations passed successfully."			
		end
	end
	after :all do
		login_user	
		destroyData = [ "CODATID017201Data.destroyData();"]						
		APEX.execute_commands destroyData	
		
		#Delete Test Data
		FFA.delete_new_data_and_wait	
		SF.logout
		gen_end_test  "TID017201 SF - save and post Recurrig Invoices from Scratch Revenue Schedule "	
	end
end
