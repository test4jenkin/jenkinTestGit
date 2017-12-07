#--------------------------------------------------------------------#
# TID : TID012774
# Pre-Requisit: Org with basedata deployed. CODATID012774Data deployed on org; 
# Product Area: Allocations
# Story: 20803
#--------------------------------------------------------------------#


describe "TID012774 : Allocations Templates", :type => :request do
	
	include_context "login"
	include_context "logout_after_each"
	## This label has a parameter. Let's handle it.
	tempLabel = FFA.fetch_label 'AllocationAssociatedWithSchedule'
	tempLabel = tempLabel.sub('{0}', '#')
	tempLabelMessages = tempLabel.split('#')

	TEMPLATE1 = "Template 1"
	TEMPLATE2 = "Template 2"
	WARNING_MESSAGE_1 = tempLabelMessages[0]
	WARNING_MESSAGE_2 = tempLabelMessages[1]
	WARNING_MESSAGE_3 = FFA.fetch_label 'AllocationOverWriteName'
	GLA_ACR_EUR = 'Accounts Receivable Control - EUR'
	EXPENSE_ACCOUNT = 'Accounts Receivable - IS'
	DIM1 = 'Dim 1 EUR'
	
	before(:all) do
		gen_start_test "TID012774"
		## Allocations do a lot of asynchronous requests.
		## Let's be a little patient.
		Capybara.default_wait_time = 10
	end

	after(:all) do
		login_user
		## Restore default wait time.
		Capybara.default_wait_time = 4
		# Delete Test Data
		_delete_data = ["CODATID012774Data.destroyData();"]
		APEX.execute_commands _delete_data
		# Abort the Queued apex job 
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
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID012774"
	end


	it "TID012774 - Override templates", :unmanaged => true  do
		gen_report_test "TST016429 - Save template - override an existing template associated to schedule"
		_create_data = ["CODATID012774Data.selectCompany();", "CODATID012774Data.createData();", "CODATID012774Data.createDataExt1();"]
		_create_data+= ["CODATID012774Data.createDataExt2();", "CODATID012774Data.switchProfile();"]
		# Execute Commands
		APEX.execute_commands _create_data
		begin
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			## Load Template 1
			Allocations.set_template TEMPLATE1
			Allocations.load_template
			
			## Check template filters
			expect(page).to have_selector($alloc_filter_set)
			gen_report_test "Expected filter set to be present."

			expect(Allocations.assert_filterset_gla_value 1, $alloc_filter_set_multiselect_label, EXPENSE_ACCOUNT)
			gen_report_test "Expected filter GLA set to be present as #{EXPENSE_ACCOUNT}."
			expect(Allocations.assert_filterset_dim1_value 1, $alloc_filter_set_multiselect_label, DIM1)
			gen_report_test "Expected filter Dimension1 set to be present as #{DIM1}."

			Allocations.click_on_next_button

			## Check template split
			Allocations.click_on_next_button
			expect(Allocations.assert_split_table_rows 1)
			expect(Allocations.assert_split_table_row_value 0, EXPENSE_ACCOUNT)

			## Modify template
			Allocations.click_on_back_button
			Allocations.click_on_back_button

			Allocations.clear_filterset_field 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,GLA_ACR_EUR
				
			## Save template
			Allocations.save_template
			gen_report_test "TST016429 A"

			## Check popup and warning message
			expect(page).to have_selector($alloc_template_save_popup)
			within(find($alloc_template_save_popup)) do
				expect(find($alloc_template_save_popup_name).value).to eq(TEMPLATE1)
				Allocations.popup_save_template
				gen_report_test "TST016429 B"
				expect(find($alloc_template_save_popup_message_box)).to have_content(WARNING_MESSAGE_1)
				expect(find($alloc_template_save_popup_message_box)).to have_content(WARNING_MESSAGE_2)
				find($alloc_template_save_popup_cancel_button).click
			end
		end

		gen_report_test "TST016430 - Save template - override an existing template not associated to schedule"

		begin
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			## Load Template 2
			Allocations.set_template TEMPLATE2
			Allocations.load_template

			## Modify template
			Allocations.clear_filterset_field 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,GLA_ACR_EUR

			## Save template
			Allocations.save_template
			gen_report_test "TST016430 A"

			## Check popup and warning message
			expect(page).to have_selector($alloc_template_save_popup)
			within(find($alloc_template_save_popup)) do
				gen_report_test "TST016430 B"
				expect(find($alloc_template_save_popup_name).value).to eq(TEMPLATE2)
				Allocations.popup_save_template
				expect(find($alloc_template_save_popup_message_box)).to have_content(WARNING_MESSAGE_3)
			end
		end
	end
end
