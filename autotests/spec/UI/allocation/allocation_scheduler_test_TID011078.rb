#--------------------------------------------------------------------#
#	TID : TID011078
#	Pre-Requisit: Org with basedata deployed.
#	Product Area: Allocation Scheduler
# 	Story: V13 release testing
#--------------------------------------------------------------------#
describe "TID011078 - Allocation Scheduler Test for Create, save and edit scheduler.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	
	template_success = FFA.fetch_label 'AllocationSaveTemplateSuccess'
	before :all do
		# Hold Base Data
		FFA.hold_base_data_and_wait
	end
	
	it "Create Data required for UI tests" do
		_alloc_sched_name = "Complete Allocation Scheduler Capybara Test"
		_alloc_sched_desc = "Automate Allocation scheduler including chaining"
		_monthly_day_occurrence = "last"
		_monthly_week_day = "Friday"
		_monthly_start_time = "19:00"
		_template_01 = "Template 01"
		_template_02 = "Template 02"
		_customer_ref_01 = "REF1"
		_customer_ref_02 = "REF2"
		_sin_description_01 = "SIN1 DESCRIPTION1"
		_sin_description_02 = "SIN2 DESCRIPTION2"
		_template_desc_01 = "GLA ARC - USD to Rent and ARC - GBP"
		_template_desc_02 = "GLA ARC - EUR to Rent and Marketing"
		_range_type_dynamic = "Dynamic"
		_transaction_by_month = "Month"
		_transaction_by_current_month = "Current Month"
		
		puts "Create Data required for UI tests"
		# login to merlin auto gbp 
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_gb],true

		# Create Sale Invoice 1
		SF.tab $tab_sales_invoices
		SF.click_button_new
		SIN.set_account $bd_account_algernon_partners_co
		SIN.set_customer_reference _customer_ref_01
 		SIN.select_shipping_method $bdu_shipping_method_fedex
		SIN.set_currency $bd_currency_gbp
		SIN.set_description _sin_description_01
		SIN.add_line 1, $bd_product_a4_paper , 1 , 1000 , nil , nil , nil
		FFA.click_save_post
		gen_report_test "Invoice 1 created and posted"

		# Create Sales invoices 2
		SF.tab $tab_sales_invoices
		SF.click_button_new
		SIN.set_account $bd_account_coda_harrogate
		SIN.set_customer_reference _customer_ref_02
		SIN.select_shipping_method $bdu_shipping_method_fedex
		SIN.set_currency $bd_currency_gbp
		SIN.set_description _sin_description_02
		SIN.add_line 1, $bd_product_bendix_front_brake_pad_1975_83_chrysler_cordoba , 1 , 500 , nil , nil , nil
		FFA.click_save_post
		gen_report_test "Invoice 2 created and posted"

		# Create first template
		SF.tab $tab_allocations
		SF.click_button_new
		gen_wait_until_object_disappear $page_loadmask_message
		Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
		Allocations.click_on_next_button

		Allocations.select_fixed_allocation_method_button
		Allocations.click_on_next_button
		Allocations.set_split_all_in_one "1", $bd_gla_rent, "90"
		Allocations.set_split_all_in_one "2", $bd_gla_account_receivable_control_gbp, "10"
		Allocations.click_on_next_button
		Allocations.save_template

		Allocations.set_popup_template_name _template_01
		Allocations.set_popup_template_description _template_desc_01
		Allocations.popup_save_template
		gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'
				
		gen_report_test "Template 1 created"

		#Create second template
		SF.tab $tab_allocations
		SF.click_button_new
		gen_wait_until_object_disappear $page_loadmask_message
		Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_gbp
		Allocations.click_on_next_button

		Allocations.select_fixed_allocation_method_button
		Allocations.click_on_next_button
		Allocations.set_split_all_in_one "1", $bd_gla_heat_light_power, "80"
		Allocations.set_split_all_in_one "2", $bd_gla_sales_parts, "20"
		Allocations.click_on_next_button
		Allocations.save_template

		Allocations.set_popup_template_name _template_02
		Allocations.set_popup_template_description _template_desc_02
		Allocations.popup_save_template
		gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'
		gen_report_test "Template 2 created"

		gen_start_test "TID011078- Allocation Scheduler Test for Create, save and edit scheduler."
		# Create a valid schedule
		SF.tab $tab_allocation_scheduler
		FFA.wait_page_message $ffa_msg_loading
		AS.create_schedule
		AS.set_allocsched_name _alloc_sched_name
		AS.set_allocsched_description _alloc_sched_desc
		AS.set_allocsched_status

		# on select templates tab
		AS.select_tab $as_tab_select_template
		AS.select_allocsched_template _template_01
		gen_wait_until_object_disappear $ffa_msg_loading
		AS.select_allocsched_template _template_02
		gen_wait_until_object_disappear $ffa_msg_loading
		# validation that template is selected successfully
		actual = AS.get_summary_message 1
		gen_compare "2 templates selected",actual,"Template selected successfully"
		
		# on frequency tab 
		AS.select_tab  $as_tab_set_schedule_frequency 
		# Monthly option
		AS.set_schedule $as_schedule_monthly
		AS.set_monthly_week_all_in_one _monthly_day_occurrence , _monthly_week_day , _monthly_start_time
		# validation that schedule frequency is selected successfully
		actual = AS.get_summary_message 2
		gen_include "Next Scheduled Run is on", actual, "Schedule frequency selected successfully"

		# on retrieve transactions
		AS.select_tab  $as_tab_retrieve_transactions 
		AS.set_date_range_type _range_type_dynamic
		AS.select_transaction_by _transaction_by_month
		AS.select_transaction_by_month _transaction_by_current_month
		# validation that Transation From and To date are selected successfully
		actual = AS.get_summary_message 3
		gen_include "Transactions will be retrieved from", actual, "Transaction From and To Date are selected successfully"

		# on set posting details
		AS.select_tab $as_tab_set_posting_details
		AS.set_posting_date_offset "4"
		AS.select_period_from_offset_posting_date "-1"
		# validation Transaction Posting Date is selected successfully
		actual = AS.get_summary_message 4
		gen_include "Transactions will be posted on", actual, "Schedule frequency selected successfully"	
		# save schedule
		AS.save_schedule
		
		# edit schedule and run now
		expect(page).to have_css($as_schedule_list_page, text: 'Allocation Schedule List')
		gen_report_test "Schedule List page displayed"
		AS.click_refresh_button
		gen_click_link_and_wait _alloc_sched_name
		AS.select_tab $as_tab_set_schedule_frequency
		AS.set_schedule_ends $as_schedule_ends_after
		AS.click_run_now
		# save edited schedule
		AS.save_schedule

		# Delete created schedule
		expect(page).to have_css($as_schedule_list_page, text: 'Allocation Schedule List')
		gen_report_test "Schedule List page displayed"		
		AS.click_refresh_button
		# No need to delete data explicitly, New data created will be deleted through after::all block
	end
	
	after :all do
		login_user
		# Abort the Queued apex job so that delete data job clears TID data.
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
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID013946 - Allocation Scheduler Test for Create, save and edit scheduler."
		SF.logout
	end
end







