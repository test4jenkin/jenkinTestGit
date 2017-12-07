#--------------------------------------------------------------------#
#	TID : TID021233
#	Pre-Requisite: Org with basedata deployed.CODATID021232Data.cls should exists on org
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocation_TID021233_unmanaged.rb -fh -o TID021233.html
#   
#--------------------------------------------------------------------#
describe "TID021233 - Verify the Allocation process by applying the manual allocation rule.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
before :all do
	# Hold Base Data
	gen_start_test "TID021233: Verify the Allocation process by applying the manual allocation rule."
	FFA.hold_base_data_and_wait
end

it "Verify the Allocation process by applying the manual allocation rule" , :unmanaged => true do
	SF.app $accounting
	PERCENTAGE_5 = "50.0000"
	PERCENTAGE_100 = "100%"
	_sencha_warning_multiple_fiscal_periods = "Selecting transactions by date range instead of period may result in retrieving transactions from multiple fiscal periods."
	CURRENT_FORMATTED_DATE = FFA.get_current_formatted_date
	current_year = Date.today.strftime("%Y")
	current_month = Date.today.strftime("%m")
	current_date = Date.today.strftime("%d")
	CURRENT_PERIOD = FFA.get_current_period
	NEXT_PERIOD = FFA.get_period_by_date Date.today>>1
	begin
		_create_data = ["CODATID021232Data.selectCompany();", "CODATID021232Data.createData();", "CODATID021232Data.createDataExt1();","CODATID021232Data.createDataExt2();", "CODATID021232Data.createDataExt3();", "CODATID021232Data.createDataExt4();","CODATID021232Data.createDataExt5();", "CODATID021232Data.createDataExt6();", "CODATID021232Data.createDataExt7();"]
		APEX.execute_commands _create_data
	end
	
	SF.tab $tab_select_company
	FFA.select_company [$company_merlin_auto_gb], true
	
	gen_start_test "TST036745 - Verify the Allocation process by applying the manual allocation rule in single company mode."
	begin
		SF.tab $tab_allocations
		Allocations.allocation_list_view_click_new_button
		gen_report_test "UI loaded succesfully from list view."
		
		#Verify that Allocations UI get opened succesfully
		expect(page.has_text?("Retrieve Source")).to be true
		gen_wait_until_object $alloc_to_period_field
		Allocations.set_allocation_type 'Transactions'
		
		#Verify warning message displayed on selection of TimePeriod = Date 
		Allocations.set_timeperiod_value 'Date'
		gen_compare _sencha_warning_multiple_fiscal_periods,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
		FFA.sencha_popup_click_continue
		
		#Set Allocation filter criteria 
		Allocations.set_timeperiod_date_selection '',CURRENT_FORMATTED_DATE
		#Allocation filter 1
		Allocations.set_filterset_field_value 1,'codaGeneralLedgerAccount__c','Multiselect',$bd_gla_account_receivable_control_usd
		Allocations.set_filterset_field_value 1,'codaDimension1__c','Multiselect',''
		Allocations.set_filterset_field_value 1,'codaDimension2__c','Multiselect',''
		Allocations.set_filterset_field_value 1,'codaDimension3__c','Multiselect',''
		Allocations.set_filterset_field_value 1,'codaDimension4__c','Multiselect',''
		Allocations.click_on_add_filter_group_button
		
		#Allocation filter 2
		Allocations.set_filterset_field_value 2,'codaGeneralLedgerAccount__c','Multiselect',$bd_gla_stock_parts
		Allocations.set_filterset_field_value 2,'codaDimension1__c','Multiselect',$bd_dim1_eur
		Allocations.set_filterset_field_value 2,'codaDimension2__c','Multiselect',''
		Allocations.set_filterset_field_value 2,'codaDimension3__c','Multiselect',$bd_dim3_eur
		Allocations.set_filterset_field_value 2,'codaDimension4__c','Multiselect',''
		
		#Verify that user is navigated to Allocation method screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?("Method of Allocation")).to be true
		
		#Verify that user is navigated to manual distribution screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?("Allocation Rule")).to be true
		
		#Verify the values of Not Distributed/Distributed amount on Distribution screen page load.
		gen_compare "100%", Allocations.get_not_distributed_amount, "Not Distributed amount matched successfully"
		gen_compare "0%", Allocations.get_distributed_amount, "Distributed amount matched successfully"
		
		#Set values in row 1 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 1, $bd_gla_account_receivable_control_eur
		Allocations.set_split_line_dimension1 1, $bd_dim1_usd
		Allocations.set_split_line_dimension2 1, $bd_dim2_usd
		Allocations.set_split_line_dimension3 1, $bd_dim3_usd
		Allocations.set_split_line_dimension4 1, $bd_dim4_usd
		Allocations.set_split_line_percentage 1, PERCENTAGE_5
		
		#Set values in row 2 of Manual distribution grid
		Allocations.set_split_line_gla 2, $bd_gla_apextaxgla001
		Allocations.set_split_line_dimension1 2, $bd_apex_eur_001
		Allocations.set_split_line_dimension2 2, $bd_apex_eur_002
		Allocations.set_split_line_dimension3 2, $bd_apex_eur_003
		Allocations.set_split_line_dimension4 2, $bd_apex_eur_004
		Allocations.set_split_line_percentage 2, PERCENTAGE_5
		
		#Verify the values of Not Distributed/Distributed amount after manual distribution.
		gen_compare "0%", Allocations.get_not_distributed_amount, "Not Distributed amount matched successfully"
		gen_compare "100%", Allocations.get_distributed_amount, "Distributed amount matched successfully"
		
		
		#Verify the Percentage and amount total values on manual distribution screen
		gen_compare PERCENTAGE_100, Allocations.get_fixed_distribution_total_percentage, "Expected percentage total is 100%"
		gen_compare '141.00', Allocations.get_fixed_distribution_total_amount, "Expected amount total is 141.00"
		
		#Verify that user is navigated to preview/post on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?("Posting Details")).to be true
		gen_report_test "User is navigated to preview/post screen"
		
		#Set document description in posting details section
		Allocations.set_destination_document_description 'Manual Allocation single company mode'
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
		
		_row1_source_TST036745 = "#{$bd_gla_account_receivable_control_usd} 141.00"
		_row1_distribution_TST036745 = "#{$bd_gla_apextaxgla001} #{$bd_apex_eur_001} #{$bd_apex_eur_002} #{$bd_apex_eur_003} #{$bd_apex_eur_004} 70.50"
		_row2_distribution_TST036745 = "#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_usd} #{$bd_dim2_usd} #{$bd_dim3_usd} #{$bd_dim4_usd} 70.50"
		
		#Assert the values in source and distribution section on preview grid.
		gen_compare _row1_source_TST036745, Allocations.get_allocation_preview_grid_row(1) ,"TST036745 Expected row 1 on preview grid"
		gen_compare _row1_distribution_TST036745, Allocations.get_allocation_preview_grid_row(2) ,"TST036745 Expected row 2 on preview grid"
		gen_compare _row2_distribution_TST036745, Allocations.get_allocation_preview_grid_row(3) ,"TST036745 Expected row 3 on preview grid"
		
		CIF.click_toggle_button
		gen_end_test "TST036745 - Verify the Allocation process by applying the manual allocation rule in single company mode."
	end

	gen_start_test "TST036746 - Verify the Allocation process by applying the manual allocation rule in multi company mode."
		begin
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain,$company_merlin_auto_usa], true
	
		#Step1 - verify the UI on load
		SF.tab $tab_allocations
		Allocations.allocation_list_view_click_new_button
		expect(page.has_text?("Retrieve Source")).to be true
		gen_report_test "Retrieve Source UI get successfully load."
		expect(Allocations.is_only_intercompany_transactions_checkbox_checked?).to be false
		gen_report_test "only intercompany transactions checkbox is false"
		
		#Allocation filter 1
		Allocations.set_filterset_field_value 1,'codaCompany__c', 'Equals', $company_merlin_auto_usa
		Allocations.set_filterset_field_value 1,'codaGeneralLedgerAccount__c','Multiselect',$bd_gla_sales_parts
		Allocations.set_filterset_field_value 1,'codaDimension1__c','Multiselect',$bd_dim1_eur
		Allocations.set_filterset_field_value 1,'codaDimension2__c','Multiselect',$alloc_no_dimesion
		Allocations.set_filterset_field_value 1,'codaDimension3__c','Multiselect',$bd_dim3_eur
		Allocations.set_filterset_field_value 1,'codaDimension4__c','Multiselect',$alloc_no_dimesion
		Allocations.click_on_add_filter_group_button
		
		#Allocation filter 2
		Allocations.set_filterset_field_value 2,'codaCompany__c', 'Equals', $company_merlin_auto_spain
		Allocations.set_filterset_field_value 2,'codaGeneralLedgerAccount__c','Multiselect',$bd_gla_sales_parts
		Allocations.set_filterset_field_value 2,'codaDimension1__c','Multiselect',$bd_dim1_eur
		Allocations.set_filterset_field_value 2,'codaDimension2__c','Multiselect',$alloc_no_dimesion
		Allocations.set_filterset_field_value 2,'codaDimension3__c','Multiselect',$bd_dim3_eur
		Allocations.set_filterset_field_value 2,'codaDimension4__c','Multiselect',$alloc_no_dimesion
		
		#Verify that user is navigated to Allocation method screen on selection of Next button
		Allocations.click_on_next_button
		gen_compare "$(795.94)",Allocations.get_total_value,"Total value matched successfully"
		expect(page.has_text?("Method of Allocation")).to be true
		gen_report_test "User is navigated to Allocation method selection screen"
		
		#Verify that user is navigated to manual distribution screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?("Allocation Rule")).to be true
		gen_report_test "User is navigated to Fixed distribution screen"
		
		#Verify the values of Not Distributed/Distributed amount on Distribution screen page load.
		gen_compare "100%", Allocations.get_not_distributed_amount, "Not Distributed amount matched successfully"
		gen_compare "0%", Allocations.get_distributed_amount, "Distributed amount matched successfully"
		
		#Set values in row 1 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 1, $bd_gla_account_receivable_control_eur
		Allocations.set_split_line_dimension1 1, $bd_dim1_usd
		Allocations.set_split_line_dimension2 1, $bd_dim2_usd
		Allocations.set_split_line_dimension3 1, $bd_dim3_usd
		Allocations.set_split_line_dimension4 1, $bd_dim4_usd
		Allocations.set_split_line_percentage 1, PERCENTAGE_5
		
		#Set values in row 2 of Manual distribution grid
		Allocations.set_split_line_gla 2, $bd_gla_apextaxgla001
		Allocations.set_split_line_dimension1 2, $bd_apex_eur_001
		Allocations.set_split_line_dimension2 2, $bd_apex_eur_002
		Allocations.set_split_line_dimension3 2, $bd_apex_eur_003
		Allocations.set_split_line_dimension4 2, $bd_apex_eur_004
		Allocations.set_split_line_percentage 2, PERCENTAGE_5
		
		#Verify the values of Not Distributed/Distributed amount after manual distribution.
		gen_compare "0%", Allocations.get_not_distributed_amount, "Not Distributed amount matched successfully"
		gen_compare "100%", Allocations.get_distributed_amount, "Distributed amount matched successfully"
		
		#Verify the Percentage and amount total values on manual distribution screen
		gen_compare PERCENTAGE_100, Allocations.get_fixed_distribution_total_percentage, "Expected percentage total is 100%"
		gen_compare '(795.94)', Allocations.get_fixed_distribution_total_amount, "Expected amount total is -795.94"
		
		#Verify that user is navigated to preview/post on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?("Posting Details")).to be true
		gen_report_test "User is navigated to preview/post screen"
		
		#Set document description in posting details section
		Allocations.set_destination_document_description 'Manual Allocation multi company mode'
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
		
		_row1_source_TST036746 = "#{$bd_gla_sales_parts} #{$bd_dim1_eur} #{$bd_dim3_eur} 795.94"
		_row1_distribution_TST036746 = "#{$bd_gla_apextaxgla001} #{$bd_apex_eur_001} #{$bd_apex_eur_002} #{$bd_apex_eur_003} #{$bd_apex_eur_004} 397.97"
		_row2_distribution_TST036746 = "#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_usd} #{$bd_dim2_usd} #{$bd_dim3_usd} #{$bd_dim4_usd} 397.97"
		
		#Assert the values in source and distribution section on preview grid.
		gen_compare _row1_source_TST036746, Allocations.get_allocation_preview_grid_row(1) ,"TST036746 Expected row 1 on preview grid"
		gen_compare _row1_distribution_TST036746, Allocations.get_allocation_preview_grid_row(2) ,"TST036746 Expected row 2 on preview grid"
		gen_compare _row2_distribution_TST036746, Allocations.get_allocation_preview_grid_row(3) ,"TST036746 Expected row 3 on preview grid"
		
		CIF.click_toggle_button
		gen_end_test "TST036746 - Verify the Allocation process by applying the manual allocation rule in multi company mode."
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
	gen_end_test "TID021233: Verify the Allocation process by applying the manual allocation rule."
end
end
	