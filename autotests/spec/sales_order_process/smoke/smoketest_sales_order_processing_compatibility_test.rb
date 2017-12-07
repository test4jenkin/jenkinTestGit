#--------------------------------------------------------------------#
#	TID : TID008698
# 	Pre-Requisite : /setup_data.rb 
#  	Product Area:  Accounting - Other - Sales Order Processing
#--------------------------------------------------------------------#

describe "TID008698 Smoke Test: COMPATIBILITY TEST - Sales Order Processing", :type => :request do
	include_context "login"
	current_date = Time.now.strftime("%d/%m/%Y")
	before :all do
			#Hold Base Data
			gen_start_test "TID008698"	
			FFA.hold_base_data_and_wait
	end
	
	it "TST009951 : Smoke Test for SOP" do
	gen_start_test "TID008698-TST009951 create Sales order and Sales Order Qaick start wizard "	
		begin	
			#get Sales order Count before wizard 
			SF.tab $tab_sales_orders
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_initial_so_count = FFA.ffa_listview_get_rows
						
			#1. create new Sales Order
			SF.tab $tab_sales_orders
			SF.click_button_new
			SOP.set_opportunity $bd_opp_pyramid_emergency_generators
			SOP.set_account $bd_account_pyramid_construction_inc
			SOP.set_order_status "In progress"
			SOP.set_order_status_today
			SOP.set_required_by_date (Date.today + 10).strftime("%d/%m/%Y")
			SOP.set_shipping_date (Date.today + 5).strftime("%d/%m/%Y")
			SF.click_button_save
			SF.wait_for_search_button
			
			#Create Sale Order Line Item
			SF.click_button $sop_new_sales_order_line_item
			SOP.set_line_item_type $sop_line_item_type_stock
			SOP.set_line_item_quantity "10"
			SOP.set_line_item_unit_price "40"
			SF.click_button_save
			SF.wait_for_search_button
			if page.has_button? ($sf_edit_button)
				gen_report_test("Sales order line item added successfully")
			else
				raise "New Sales order line item failed."
			end	
			
			#verify the sales order
			SF.tab $tab_sales_orders
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_so_count = FFA.ffa_listview_get_rows
			#validate the count
			gen_compare (_initial_so_count+1) , _so_count , "1 Sales order with line Item generated. successfully"
	
			#2. Run Sales Order QuickStart
			SF.tab $tab_sales_order_quick_start
			SF.wait_for_search_button
			SOQS.wizard_click_button_start_the_wizard
			SOQS.wizard_click_button_ok
			SOQS.wizard_select_source_object $ffa_object_sales_order
			SOQS.wizard_click_button_ok
			SOQS.wizard_click_button_view_example
			SOQS.wizard_click_button_ok
			SOQS.wizard_click_button_next
			SOQS.set_sales_order_listview $soqs_wizard_sales_order_list_option_all
			SOQS.set_preferred_start_time $soqs_wizard_preferred_start_time_12_30_AM
			SOQS.wizard_click_button_next
			SOQS.wizard_click_button_save
			SOQS.wizard_click_button_run_now
			SOQS.wizard_click_button_close_wizard		
			SF.wait_for_apex_job
			gen_report_test("Sales order Wizard ran successfully.")
			
			#get Sales order Count after wizard 
			SF.tab $tab_sales_orders
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_so_count = FFA.ffa_listview_get_rows
			#validate the count
			gen_compare (_initial_so_count+2) , _so_count , "1 more Sales order generated. successfully"			
		end
		gen_end_test "TID008698-TST009951 create Sales order and Sales Order Qaick start wizard "	
	end
	
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		
		#Delete Sales ORDERsif not deleted by delete data button
		delete_sales_orders = "DELETE [SELECT Id from ffso__salesOrder__c];"
		APEX.execute_commands [delete_sales_orders]
		#abort queued job
		job_id_for_queued_job_query = "SELECT id FROM CronTrigger where State = 'WAITING' limit 1"
		APEX.execute_soql job_id_for_queued_job_query
		soql_results = APEX.get_execution_status_message
		expected_result_with_one_item = "totalSize\":1,"
		if soql_results.include? expected_result_with_one_item
			puts "Aborting the job with queued status."
			job_id_array = soql_results.split("\"")
			array_length =  job_id_array.length
			queued_job_id = job_id_array[array_length-2]
			abort_queued_worker_item = "System.abortJob('#{queued_job_id}');"	
			APEX.execute_script abort_queued_worker_item
			gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."
		end
		gen_end_test "TID008698"
		SF.logout 
	end
end