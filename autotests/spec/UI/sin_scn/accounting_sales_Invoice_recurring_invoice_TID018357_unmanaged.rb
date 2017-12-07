#--------------------------------------------------------------------#
#TID : TID018357
#Product Area: Accounting - Sales Invoices & Credit Notes
#--------------------------------------------------------------------#

describe "SF - save and post Recurrig Invoices", :type => :request do
include_context "login"
include_context "logout_after_each"
_account_payable_control = ""
	before :all do
		gen_start_test  "TID018357 SF - save and post Recurrig Invoices from Scratch Quantity "
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "Execute Script as Anonymous user , Create Sales Invoice and Recurring invoices ", :unmanaged => true  do
		gen_start_test "TST017838 - starts Verify error message to be displayed on click of Pay button, if Account payable control field is blank for accounts retrieved in Payment."
		begin
			#Create prerequistic data
			create_recurring_invoice = [ "CODATID018357Data.selectCompany();",
				"CODATID018357Data.createData();",
				"CODATID018357Data.createDataExt1();"]					
			APEX.execute_commands create_recurring_invoice
			SF.wait_for_apex_job
			
			# Run background posting 
			backgroundPosting = ["BackgroundPostingSchedulerService.runNow();"]
			APEX.execute_commands backgroundPosting
			SF.wait_for_apex_job
			
			validations = "CODATID018357Data.validateResults();"
			APEX.execute_script validations
			query_result = APEX.get_execution_status_message
			if(query_result != $apex_script_executed_successfully_message_value)					
				raise "Error in excecution -" + query_result
			end			
		end
	end
	after :all do
		login_user	
		destroyData = [ "CODATID018357Data.destroyData();"]						
		APEX.execute_commands destroyData	
		
		#Delete Test Data
		FFA.delete_new_data_and_wait	
		SF.logout
		gen_end_test  "TID018357 SF - save and post Recurrig Invoices from Scratch Quantity "	
	end
end
