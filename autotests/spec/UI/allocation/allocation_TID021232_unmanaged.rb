#--------------------------------------------------------------------#
#	TID : TID021232
#	Pre-Requisite: Org with basedata deployed.CODATID021232Data.cls should exists on org
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocation_TID021232_unmanaged.rb -fh -o TID021232.html
#   
#--------------------------------------------------------------------#
describe "TID021232 - Verify the Allocation process by applying the fixed allocation rule.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
before :all do
	# Hold Base Data
	gen_start_test "TID021232: Verify the Allocation process by applying the fixed allocation rule."
	FFA.hold_base_data_and_wait
end

it "Verify the Allocation process by applying the fixed allocation rule" , :unmanaged => true do
	SF.app $accounting
	PERCENTAGE_1 = "20"
	PERCENTAGE_2 = "30"
	PERCENTAGE_3 = "40"
	PERCENTAGE_4 = "10"
	PERCENTAGE_5 = "50"
	PERCENTAGE_100 = "100%"
	PERCENTAGE_0 = "0%"
	_transaction_type_filed_label = 'Transaction Type'
	_transaction_type_field_value = 'Allocation'
	_fixed_alloc_single_company_description = 'Fixed Allocation single company mode'
	_fixed_alloc_multi_company_description = 'Fixed Allocation multi company mode'						
	ACTIVE_FIXED_ALLOCATION_RULE_NAME = "FixedAR_1"
	_sencha_warning_multiple_fiscal_periods = "Selecting transactions by date range instead of period may result in retrieving transactions from multiple fiscal periods."
	CURRENT_FORMATTED_DATE = FFA.get_current_formatted_date
	_gmt_offset = gen_get_current_user_gmt_offset
	_locale = gen_get_current_user_locale
	_today = gen_get_current_date _gmt_offset
	current_date = gen_locale_format_date _today, _locale
	CURRENT_PERIOD = FFA.get_current_period
	NEXT_PERIOD = FFA.get_period_by_date Date.today>>1
	begin
		_create_data = ["CODATID021232Data.selectCompany();", "CODATID021232Data.createData();", "CODATID021232Data.createDataExt1();","CODATID021232Data.createDataExt2();", "CODATID021232Data.createDataExt3();", "CODATID021232Data.createDataExt4();","CODATID021232Data.createDataExt5();", "CODATID021232Data.createDataExt6();", "CODATID021232Data.createDataExt7();","CODATID021232Data.createDataExt8();", "CODATID021232Data.createDataExt9();"]
		APEX.execute_commands _create_data
	end
	
	SF.tab $tab_select_company
	FFA.select_company [$company_merlin_auto_gb], true
	
	gen_start_test "TST036743 - Verify the Allocation process by applying the fixed allocation rule in single company mode."
	begin
		SF.tab $tab_allocations
		Allocations.allocation_list_view_click_new_button
		gen_report_test "UI loaded succesfully from list view."
		
		#Verify that Allocations UI get opened succesfully
		gen_compare_has_content $alloc_retrieve_source_page_label, true, "Expected Retrieve Source screen"
		gen_wait_until_object $alloc_to_period_field
		Allocations.set_allocation_type $alloc_type_label
		
		#Verify warning message displayed on selection of TimePeriod = Date 
		Allocations.set_timeperiod_value $alloc_date_label
		gen_compare _sencha_warning_multiple_fiscal_periods,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
		FFA.sencha_popup_click_continue
		
		#Set Allocation filter criteria 
		Allocations.set_timeperiod_date_selection '',CURRENT_FORMATTED_DATE
		#Allocation filter 1
		Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
		Allocations.click_on_add_filter_group_button
		
		#Allocation filter 2
		Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
		Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
		Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
		
		#Verify that user is navigated to Allocation method screen on selection of Next button
		Allocations.click_on_next_button
		gen_compare_has_content $alloc_label_method_of_allocation, true, "Expected Method of Allocation screen"
		
		#Verify that user is navigated to Fixed distribution screen on selection of Next button
		Allocations.click_on_next_button
		gen_compare_has_content $alloc_label_allocation_rule, true, "Expected Fixed distribution screen"
		
		#Verify the values of Not Distributed/Distributed amount on selection of an Fixed allocation rule = FixedAR_1
		Allocations.set_rule_name ACTIVE_FIXED_ALLOCATION_RULE_NAME
		gen_compare PERCENTAGE_0, Allocations.get_not_distributed_amount, "Not Distributed amount matched successfully"
		gen_compare PERCENTAGE_100, Allocations.get_distributed_amount, "Distributed amount matched successfully"
		
		#Assert values in row 1 of Allocation distribution grid
		row_1_GLA = Allocations.assert_split_table_row_value 1, $bd_gla_account_receivable_control_usd
		row_1_Dimension1 = Allocations.assert_split_table_row_value 1, $bd_dim1_usd
		row_1_Dimension2 = Allocations.assert_split_table_row_value 1, $bd_dim2_usd
		row_1_Dimension3 = Allocations.assert_split_table_row_value 1, $bd_dim3_usd
		row_1_Dimension4 = Allocations.assert_split_table_row_value 1, $bd_dim4_usd
		row_1_percentage = Allocations.assert_split_table_row_value 1, PERCENTAGE_1
		row_1_amount = Allocations.assert_split_table_row_value 1, '28.20'
		
		gen_compare true, row_1_GLA, "Expected GLA is Accounts receivable control - USD"
		gen_compare true, row_1_Dimension1, "Expected Dimension 1 is Dim 1 USD"
		gen_compare true, row_1_Dimension2, "Expected Dimension 2 is Dim 2 USD"
		gen_compare true, row_1_Dimension3, "Expected Dimension 3 is Dim 3 USD"
		gen_compare true, row_1_Dimension4, "Expected Dimension 4 is Dim 4 USD"
		gen_compare true, row_1_percentage, "Expected percentage is 20.0000%"
		gen_compare true, row_1_amount, "Expected amount is 28.20"
		
		#Assert values in row 2 of Allocation distribution grid
		row_2_GLA = Allocations.assert_split_table_row_value 2, $bd_gla_account_receivable_control_eur
		row_2_Dimension1 = Allocations.assert_split_table_row_value 2, $bd_apex_eur_001
		row_2_Dimension2 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension3 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension4 = Allocations.assert_split_table_row_value 2, ''
		row_2_percentage = Allocations.assert_split_table_row_value 2, PERCENTAGE_2
		row_2_amount = Allocations.assert_split_table_row_value 2, '42.30'
		
		gen_compare true, row_2_GLA, "Expected GLA is Accounts receivable control - EUR"
		gen_compare true, row_2_Dimension1, "Expected Dimension 1 is Apex EUR 001"
		gen_compare true, row_2_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_2_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_2_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_2_percentage, "Expected percentage is 30.0000%"
		gen_compare true, row_2_amount, "Expected amount is 42.30"
		
		#Assert values in row 3 of Allocation distribution grid
		row_3_GLA = Allocations.assert_split_table_row_value 3, $bd_gla_apextaxgla001
		row_3_Dimension1 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension2 = Allocations.assert_split_table_row_value 3, $bd_apex_eur_002
		row_3_Dimension3 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension4 = Allocations.assert_split_table_row_value 3, ''
		row_3_percentage = Allocations.assert_split_table_row_value 3, PERCENTAGE_3
		row_3_amount = Allocations.assert_split_table_row_value 3, '56.40'
		
		gen_compare true, row_3_GLA, "Expected GLA is APEXTAXGLA001"
		gen_compare true, row_3_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_3_Dimension2, "Expected Dimension 2 is Apex EUR 002"
		gen_compare true, row_3_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_3_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_3_percentage, "Expected percentage is 40.0000%"
		gen_compare true, row_3_amount, "Expected amount is 56.40"
		
		#Assert values in row 4 of Allocation distribution grid
		row_4_GLA = Allocations.assert_split_table_row_value 4, $bd_gla_bank_account_euros_us
		row_4_Dimension1 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension2 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension3 = Allocations.assert_split_table_row_value 4, $bd_apex_eur_003
		row_4_Dimension4 = Allocations.assert_split_table_row_value 4, ''
		row_4_percentage = Allocations.assert_split_table_row_value 4, PERCENTAGE_4
		row_4_amount = Allocations.assert_split_table_row_value 4, '14.10'
		
		gen_compare true, row_4_GLA, "Expected GLA is Bank Account - Euros US"
		gen_compare true, row_4_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_4_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_4_Dimension3, "Expected Dimension 3 is Apex EUR 003"
		gen_compare true, row_4_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_4_percentage, "Expected percentage is 10.0000%"
		gen_compare true, row_4_amount, "Expected amount is 14.10"
		
		#Verify the Percentage and amount total values on fixed distribution screen
		gen_compare '100%', Allocations.get_fixed_distribution_total_percentage, "Expected percentage total is 100%"
		gen_compare '141.00', Allocations.get_fixed_distribution_total_amount, "Expected amount total is 141.00"
		
		#Verify that user is navigated to preview/post on selection of Next button
		Allocations.click_on_next_button
		
		#Set document description in posting details section
		Allocations.set_destination_document_description _fixed_alloc_single_company_description
		expect(Allocations.assert_destination_document_date FFA.get_current_formatted_date).to eq(true)
		gen_report_test "Date field should get populated with today's date"
		expect(Allocations.assert_destination_document_period FFA.get_current_period).to eq(true)
		gen_report_test "Period field should get populated with current period"
		
		#Expand Allocation post screen preview section
		Allocations.click_on_accordion_panel_expand_button
		
		#Expand source and distribution sections 
		Allocations.click_on_source_section_expand_collapse_button
		Allocations.click_on_distribution_section_expand_collapse_button
		CIF.click_toggle_button
		
		_row1_source_TST036743 = "#{$bd_gla_account_receivable_control_usd} 141.00"
		_row5_distribution_TST036743 = "#{$bd_gla_account_receivable_control_usd} #{$bd_dim1_usd} #{$bd_dim2_usd} #{$bd_dim3_usd} #{$bd_dim4_usd} 28.20"
		_row4_distribution_TST036743 = "#{$bd_gla_account_receivable_control_eur} #{$bd_apex_eur_001} 42.30"
		_row3_distribution_TST036743 = "#{$bd_gla_apextaxgla001} #{$bd_apex_eur_002} 56.40"
		_row2_distribution_TST036743 = "#{$bd_gla_bank_account_euros_us} #{$bd_apex_eur_003} 14.10"
		
		#Assert the values in source and distribution section on preview grid.
		gen_compare _row1_source_TST036743, Allocations.get_allocation_preview_grid_row(1) ,"TST036743 Expected row 1 on preview grid"
		gen_compare _row2_distribution_TST036743, Allocations.get_allocation_preview_grid_row(2) ,"TST036743 Expected row 2 on preview grid"
		gen_compare _row3_distribution_TST036743, Allocations.get_allocation_preview_grid_row(3) ,"TST036743 Expected row 3 on preview grid"
		gen_compare _row4_distribution_TST036743, Allocations.get_allocation_preview_grid_row(4) ,"TST036743 Expected row 4 on preview grid"
		gen_compare _row5_distribution_TST036743, Allocations.get_allocation_preview_grid_row(5) ,"TST036743 Expected row 5 on preview grid"
		CIF.click_toggle_button
		Allocations.click_on_post_button
		Allocations.wait_for_list_view
		gen_end_test "TST036743 - Verify the Allocation process by applying the fixed allocation rule in single company mode."
	end

	gen_start_test "TST036744 - Verify the Allocation process by applying the fixed allocation rule in multi - company mode."
		begin
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain,$company_merlin_auto_usa], true
	
		#Step1 - verify the UI on load
		SF.tab $tab_allocations
		Allocations.allocation_list_view_click_new_button
		gen_compare_has_content $alloc_retrieve_source_page_label, true, "Expected Retrieve Source screen"
		expect(Allocations.is_only_intercompany_transactions_checkbox_checked?).to be false
		gen_report_test "only intercompany transactions checkbox is false"
		
		#Allocation filter 1
		Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_operator_equals_label, $company_merlin_auto_usa
		Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
		Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
		Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
		Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
		Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
		Allocations.click_on_add_filter_group_button
		
		#Allocation filter 2
		Allocations.set_filterset_field_value 2,$alloc_filter_set_company_field_object_label, $alloc_filter_operator_equals_label, $company_merlin_auto_spain
		Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
		Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
		Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
		Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
		Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
		
		#Verify that user is navigated to Allocation method screen on selection of Next button
		Allocations.click_on_next_button
		gen_compare "$(795.94)",Allocations.get_total_value,"Total value matched successfully"
		gen_compare_has_content $alloc_label_method_of_allocation, true, "Expected Method of Allocation screen"
		gen_report_test "User is navigated to Allocation method selection screen"
		
		#Verify that user is navigated to Fixed distribution screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?("Allocation Rule")).to be true
		gen_report_test "User is navigated to Fixed distribution screen"
		
		#Verify the values of Not Distributed/Distributed amount on selection of an Fixed allocation rule = FixedAR_1
		Allocations.set_rule_name ACTIVE_FIXED_ALLOCATION_RULE_NAME
		gen_compare PERCENTAGE_0, Allocations.get_not_distributed_amount, "Not Distributed amount matched successfully"
		gen_compare PERCENTAGE_100, Allocations.get_distributed_amount, "Distributed amount matched successfully"
		
		#Assert values in row 1 of Allocation distribution grid
		row_1_GLA = Allocations.assert_split_table_row_value 1, $bd_gla_account_receivable_control_usd
		row_1_Dimension1 = Allocations.assert_split_table_row_value 1, $bd_dim1_usd
		row_1_Dimension2 = Allocations.assert_split_table_row_value 1, $bd_dim2_usd
		row_1_Dimension3 = Allocations.assert_split_table_row_value 1, $bd_dim3_usd
		row_1_Dimension4 = Allocations.assert_split_table_row_value 1, $bd_dim4_usd
		row_1_percentage = Allocations.assert_split_table_row_value 1, PERCENTAGE_1
		row_1_amount = Allocations.assert_split_table_row_value 1, '(159.19)'
		
		gen_compare true, row_1_GLA, "Expected GLA is Accounts receivable control - USD"
		gen_compare true, row_1_Dimension1, "Expected Dimension 1 is Dim 1 USD"
		gen_compare true, row_1_Dimension2, "Expected Dimension 2 is Dim 2 USD"
		gen_compare true, row_1_Dimension3, "Expected Dimension 3 is Dim 3 USD"
		gen_compare true, row_1_Dimension4, "Expected Dimension 4 is Dim 4 USD"
		gen_compare true, row_1_percentage, "Expected percentage is 20.0000%"
		gen_compare true, row_1_amount, "Expected amount is -159.19"
		
		#Assert values in row 2 of Allocation distribution grid
		row_2_GLA = Allocations.assert_split_table_row_value 2, $bd_gla_account_receivable_control_eur
		row_2_Dimension1 = Allocations.assert_split_table_row_value 2, $bd_apex_eur_001
		row_2_Dimension2 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension3 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension4 = Allocations.assert_split_table_row_value 2, ''
		row_2_percentage = Allocations.assert_split_table_row_value 2, PERCENTAGE_2
		row_2_amount = Allocations.assert_split_table_row_value 2, '(238.78)'
		
		gen_compare true, row_2_GLA, "Expected GLA is Accounts receivable control - EUR"
		gen_compare true, row_2_Dimension1, "Expected Dimension 1 is Apex EUR 001"
		gen_compare true, row_2_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_2_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_2_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_2_percentage, "Expected percentage is 30.0000%"
		gen_compare true, row_2_amount, "Expected amount is -238.78"
		
		#Assert values in row 3 of Allocation distribution grid
		row_3_GLA = Allocations.assert_split_table_row_value 3, $bd_gla_apextaxgla001
		row_3_Dimension1 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension2 = Allocations.assert_split_table_row_value 3, $bd_apex_eur_002
		row_3_Dimension3 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension4 = Allocations.assert_split_table_row_value 3, ''
		row_3_percentage = Allocations.assert_split_table_row_value 3, PERCENTAGE_3
		row_3_amount = Allocations.assert_split_table_row_value 3, '(318.38)'
		
		gen_compare true, row_3_GLA, "Expected GLA is APEXTAXGLA001"
		gen_compare true, row_3_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_3_Dimension2, "Expected Dimension 2 is Apex EUR 002"
		gen_compare true, row_3_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_3_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_3_percentage, "Expected percentage is 40.0000%"
		gen_compare true, row_3_amount, "Expected amount is -318.38"
		
		#Assert values in row 4 of Allocation distribution grid
		row_4_GLA = Allocations.assert_split_table_row_value 4, $bd_gla_bank_account_euros_us
		row_4_Dimension1 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension2 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension3 = Allocations.assert_split_table_row_value 4, $bd_apex_eur_003
		row_4_Dimension4 = Allocations.assert_split_table_row_value 4, ''
		row_4_percentage = Allocations.assert_split_table_row_value 4, PERCENTAGE_4
		row_4_amount = Allocations.assert_split_table_row_value 4, '(79.59)'
		
		gen_compare true, row_4_GLA, "Expected GLA is Bank Account - Euros US"
		gen_compare true, row_4_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_4_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_4_Dimension3, "Expected Dimension 3 is Apex EUR 003"
		gen_compare true, row_4_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_4_percentage, "Expected percentage is 10.0000%"
		gen_compare true, row_4_amount, "Expected amount is -79.59"
		
		#Verify the Percentage and amount total values on fixed distribution screen
		gen_compare '100%', Allocations.get_fixed_distribution_total_percentage, "Expected percentage total is 100.00%"
		gen_compare '(795.94)', Allocations.get_fixed_distribution_total_amount, "Expected amount total is -795.94"
		
		#Verify that user is navigated to preview/post on selection of Next button
		Allocations.click_on_next_button
		
		#Set document description in posting details section
		Allocations.set_destination_document_description _fixed_alloc_multi_company_description
		#expect(Allocations.assert_available_companies [$company_merlin_auto_spain, $company_merlin_auto_usa]).to eq(true)
		#gen_report_test "Merlin auto spain and merlin auto USA should be displayed in company picklist"
		Allocations.set_destination_company_value $company_merlin_auto_spain
		expect(Allocations.assert_destination_document_date FFA.get_current_formatted_date).to eq(true)
		gen_report_test "Date field should get populated with today's date"
		expect(Allocations.assert_destination_document_period FFA.get_current_period).to eq(true)
		gen_report_test "Period field should get populated with current period"
		
		#Expand Allocation post screen preview section
		Allocations.click_on_accordion_panel_expand_button
		
		#Expand source and distribution sections 
		Allocations.click_on_source_section_expand_collapse_button
		Allocations.click_on_distribution_section_expand_collapse_button
		CIF.click_toggle_button
		
		_row1_source_TST036744 = "#{$bd_gla_sales_parts} #{$bd_dim1_eur} #{$bd_dim3_eur} 795.94"
		_row5_distribution_TST036744 = "#{$bd_gla_account_receivable_control_usd} #{$bd_dim1_usd} #{$bd_dim2_usd} #{$bd_dim3_usd} #{$bd_dim4_usd} 159.19"
		_row4_distribution_TST036744 = "#{$bd_gla_account_receivable_control_eur} #{$bd_apex_eur_001} 238.78"
		_row3_distribution_TST036744 = "#{$bd_gla_apextaxgla001} #{$bd_apex_eur_002} 318.38"
		_row2_distribution_TST036744 = "#{$bd_gla_bank_account_euros_us} #{$bd_apex_eur_003} 79.59"
		
		#Assert the values in source and distribution section on preview grid.
		gen_compare _row1_source_TST036744, Allocations.get_allocation_preview_grid_row(1) ,"TST036744 Expected row 1 on preview grid"
		gen_compare _row2_distribution_TST036744, Allocations.get_allocation_preview_grid_row(2) ,"TST036744 Expected row 2 on preview grid"
		gen_compare _row3_distribution_TST036744, Allocations.get_allocation_preview_grid_row(3) ,"TST036744 Expected row 3 on preview grid"
		gen_compare _row4_distribution_TST036744, Allocations.get_allocation_preview_grid_row(4) ,"TST036744 Expected row 4 on preview grid"
		gen_compare _row5_distribution_TST036744, Allocations.get_allocation_preview_grid_row(5) ,"TST036744 Expected row 5 on preview grid"
		CIF.click_toggle_button
		Allocations.click_on_post_button
		Allocations.wait_for_list_view
		gen_end_test "TST036744 - Verify the Allocation process by applying the fixed allocation rule in multi - company mode."
	end
end

after :all do
	login_user
	#Delete Test Data
	_delete_data = ["CODATID021232Data.destroyData();"]
	APEX.execute_commands _delete_data
	FFA.delete_new_data_and_wait
	SF.wait_for_apex_job
	SF.logout
	gen_end_test "TID021232: Verify the Allocation process by applying the fixed allocation rule."
end
end
	