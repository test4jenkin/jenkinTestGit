#--------------------------------------------------------------------#
#TID : TID015246
#Pre-Requisite : Base data should exist on the org;Deploy CODATID015246Data.cls on org.
#Product Area: Accounting - Income Schedule
#--------------------------------------------------------------------#

describe "TID015246- Accounting - Income Schedule", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		gen_start_test  "TID015246: Posting successfully a SIN creating Currency Adjustment Journal when different products have different Sales Revenue Account and different Income Schedule Definition in an Invoice. "
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "TID015246- Execute Script as Anonymous user , Create and Post Invoice with income schedule ", :unmanaged => true  do
		gen_start_test "TST021139 - Check that the SIN is posted successfully and the Create Currency Adjustment is completed without errors."
		begin
			#Create prerequistic data
			create_and_post_invoice = [ "CODATID015246Data.selectCompany();",
				"CODATID015246Data.createData();",
				"CODATID015246Data.PostInvoice();"]					
			APEX.execute_commands create_and_post_invoice
			
			# Run background posting 
			backgroundPosting = ["BackgroundPostingSchedulerService.runNow();"]
			APEX.execute_commands backgroundPosting
			SF.wait_for_apex_job
			
			#TST021139 Check that the SIN is posted successfully and the Create Currency Adjustment is completed without errors.
			validations = "CODATID015246Data.ValidateLogs_TST021139();"
			APEX.execute_script validations
			query_result = APEX.get_execution_status_message
			gen_compare $apex_script_executed_successfully_message_value , query_result, "TST021139-Check that the SIN is posted successfully and the Create Currency Adjustment is completed without errors."			
		end
	end
	after :all do
		login_user	
		destroyData = [ "CODATID015246Data.destroyData();"]						
		APEX.execute_commands destroyData	
		
		#Delete Test Data
		FFA.delete_new_data_and_wait	
		SF.logout
		gen_end_test  "TID015246: Posting successfully a SIN creating Currency Adjustment Journal when different products have different Sales Revenue Account and different Income Schedule Definition in an Invoice. "
	end
end