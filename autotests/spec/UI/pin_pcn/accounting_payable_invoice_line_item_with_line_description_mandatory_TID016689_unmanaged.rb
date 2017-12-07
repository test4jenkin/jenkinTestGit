#--------------------------------------------------------------------#
#	TID : TID016689
# 	Pre-Requisite : Org with basedata deployed and deploy CODATID016689Data.cls on org
#  	Product Area: Accounting - Payables Invoices & Credit Notes
# 	Story: AC-6648 
#--------------------------------------------------------------------#


describe "Accounting - Payables Invoices & Credit Notes", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID016689 : Accounting - Payables Invoices & Credit Notes UI Test"
	end
	
	it "TID013132 : Verify that Try to create a new Document with Manage Lines, without Line Description, when the Line Description is mandatory.", :unmanaged => true  do
		gen_start_test "TID016689 : Verify that You should see the next error: Line Description: You must enter a value"
		
		puts "Additional data required for TID016689, Set LineDescription__c mandatory for documents"
		begin
			SF.make_field_required $ffa_object_payable_invoice_line_item , $ffa_field_line_description, true
			SF.make_field_required $ffa_object_payable_credit_note_line_item , $ffa_field_line_description, true
			SF.make_field_required $ffa_object_sales_invoice_line_item , $ffa_field_line_description, true
			SF.make_field_required $ffa_object_sales_credit_note_line_item , $ffa_field_line_description, true
			SF.make_field_required $ffa_object_journal_line_item , $ffa_field_line_description, true			
		end
		
		puts "Create Data"
		begin			
			create_data = [ "CODATID016689Data.selectcompany();",
							"CODATID016689Data.createdata();",
							"CODATID016689Data.switchprofile();"]				
			APEX.execute_commands create_data
		end
		
		puts "Call System Test from Base data Job and wait untill it complete and assert all Test method's status"
		begin
			test_result = APEX.call_system_test_class "CODATID016689DataSystemTest"
			gen_compare test_result[0].size().to_s	,"5", "all system test methods passed successfuly"
			gen_include "TST024108_A", test_result[0].to_s, "TST024108_A passed successfuly"
			gen_include "TST024108_B", test_result[0].to_s, "TST024108_B passed successfuly"
			gen_include "TST024108_C", test_result[0].to_s, "TST024108_C passed successfuly"
			gen_include "TST024108_D", test_result[0].to_s, "TST024108_D passed successfuly"
			gen_include "TST024108_E", test_result[0].to_s, "TST024108_E passed successfuly"			
		end
	end
	
	after :all do
		login_user
		#Revert Additional data ,  Set LineDescription__c non required for documents
		SF.make_field_required $ffa_object_payable_invoice_line_item , $ffa_field_line_description, false
		SF.make_field_required $ffa_object_payable_credit_note_line_item , $ffa_field_line_description, false
		SF.make_field_required $ffa_object_sales_invoice_line_item , $ffa_field_line_description, false
		SF.make_field_required $ffa_object_sales_credit_note_line_item , $ffa_field_line_description, false
		SF.make_field_required $ffa_object_journal_line_item , $ffa_field_line_description, false			
		
		delete_payable_invoices = ["CODATID016689Data.destroyData();"]
		APEX.execute_commands delete_payable_invoices
		FFA.delete_new_data_and_wait
		gen_end_test "TID016689 : Verify that You should see the next error: Line Description: You must enter a value"
	end
end