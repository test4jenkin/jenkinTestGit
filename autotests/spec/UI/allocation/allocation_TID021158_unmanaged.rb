#--------------------------------------------------------------------#
#	TID : TID021158
#	Pre-Requisite: Org with basedata deployed.CODATID021158Data.cls should exists on org
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocation_TID021158_unmanaged.rb -fh -o TID021158.html
#   
#--------------------------------------------------------------------#
describe "TID021158 - Verify the TLIs retrieved when user filter specific set of data in Multi - company Mode.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		gen_start_test "TID021158: This TID verifies the TLIs retrieved when user filter specific set of data in Multi - company Mode."
		FFA.hold_base_data_and_wait
	end
	
	it "Verify the TLIs retrieved when user filter specific set of data in Multi - company Mode" , :unmanaged => true do
		SF.app $accounting
		
		error_message_filter_selection_with_no_results = "[1]Either your current filter selection has returned no results or there is no balance to allocate. Amend your filters and try again.;"
		error_message_on_different_dual_currency = "[1]All the transaction line items retrieved must have the same dual currency.;"
		error_message_on_invalid_period = "[1]The From period must be greater than or equal to the To period.;"
		
		CURRENT_PERIOD = FFA.get_current_period
		NEXT_PERIOD = FFA.get_period_by_date Date.today>>1
		begin
			_create_data = ["CODATID021158Data.selectCompany();", "CODATID021158Data.createData();", "CODATID021158Data.createDataExt1();","CODATID021158Data.createDataExt2();", "CODATID021158Data.createDataExt3();", "CODATID021158Data.createDataExt4();","CODATID021158Data.createDataExt5();", "CODATID021158Data.createDataExt6();", "CODATID021158Data.createDataExt7();"]
			APEX.execute_commands _create_data
		end
		
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_gb,$company_merlin_auto_spain,$company_merlin_auto_usa], true
		
		gen_start_test "TST036360 - Verify the TLIs retrieved in Multi - company mode when only ICT = False."
		begin
			#Step1 - verify the UI on load
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			expect(page.has_text?$alloc_retrieve_source_page_label).to be true
			gen_report_test "UI loaded successfully"
			gen_compare "0.00",Allocations.get_total_value,"Total value matched successfully"
			gen_compare "0", Allocations.get_filters_selected_value,"Number of filter selected"
			expect(Allocations.is_only_intercompany_transactions_checkbox_checked?).to be false
			gen_report_test "Intercompany checkbox is unchecked."
			gen_assert_enabled $alloc_retrieve_source_filter_group_preview_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_All_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_group_button
			gen_assert_disabled $alloc_add_filter_group_button
			gen_report_test "UI loaded succesfully from list view."
			
			#Step2 - enter the filter criteria
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_gb
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.click_on_add_filter_group_button
			#filter 2
			Allocations.set_filterset_field_value 2,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			Allocations.set_filterset_field_value 2,$alloc_filter_set_period_field_object_label,$alloc_filter_set_from_label,NEXT_PERIOD
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.click_on_add_filter_group_button
			#filter 3
			Allocations.set_filterset_field_value 3,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field_value 3,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			
			gen_compare "3", Allocations.get_filters_selected_value,"Number of filter selected"
			
			#step3 
			Allocations.click_on_preview_button
			gen_compare error_message_on_invalid_period,FFA.get_sencha_popup_error_message,"incorrect filters"
			FFA.sencha_popup_click_continue
			
			#step4
			Allocations.click_on_filter_group_close_button 2
			gen_compare "2", Allocations.get_filters_selected_value,"Number of filter selected"
			
			#step5
			Allocations.click_on_preview_button
			gen_compare error_message_on_different_dual_currency,FFA.get_sencha_popup_error_message,"incorrect filters"
			FFA.sencha_popup_click_continue
			#step6
			Allocations.click_on_filter_group_close_button 2
			gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected"
			
			#step7
			Allocations.click_on_preview_button
			gen_compare "€(144.00)",Allocations.get_total_value,"Total value matched successfully"
			
			#step8
			Allocations.click_on_show_filters_button
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field_value 1,$alloc_filter_set_period_field_object_label,$alloc_filter_set_to_label,CURRENT_PERIOD
			
			#Step9
			Allocations.click_on_preview_button
			gen_compare "$(795.94)",Allocations.get_total_value,"Total value matched successfully"
			
			#step10
			Allocations.click_on_show_filters_button
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			
			#step11
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"incorrect filters"
			FFA.sencha_popup_click_continue
			
			#step12
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label
			
			#step13
			Allocations.click_on_preview_button
			gen_compare "1",Allocations.get_filters_selected_value,"Filter selection match."
			gen_compare "$(795.94)",Allocations.get_total_value,"Total value matched successfully"
		end
		gen_end_test "TST036360 - Verify the TLIs retrieved in Multi - company mode when only ICT = False."
		
		gen_start_test "TST036361 - Verify the TLIs retrieved in Multi - company mode when only ICT = true."
		begin
			#Step1 - verify the UI on load
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			expect(page.has_text? $alloc_retrieve_source_page_label).to be true
			gen_report_test "UI loaded successfully."
			gen_compare "0.00",Allocations.get_total_value,"Total value matched successfully"
			gen_compare "0", Allocations.get_filters_selected_value,"Number of filter selected"
			expect(Allocations.is_only_intercompany_transactions_checkbox_checked?).to be false
			gen_report_test "Intercompany checkbox is unchecked."
			gen_assert_enabled $alloc_retrieve_source_filter_group_preview_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_All_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_group_button
			gen_assert_disabled $alloc_add_filter_group_button
			gen_report_test "Retrieve Source UI get successfully load."
			
			#Step2 - enter the filter criteria
			Allocations.click_only_intercompany_transactions_checkbox true
			expect(Allocations.is_only_intercompany_transactions_checkbox_checked?).to be true
			gen_report_test "Intercompany checkbox is checked."
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_gb
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.click_on_add_filter_group_button
			#filter 2
			Allocations.set_filterset_field_value 2,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			Allocations.set_filterset_field_value 2,$alloc_filter_set_period_field_object_label,$alloc_filter_set_from_label,NEXT_PERIOD
			Allocations.set_filterset_field_value 2,$alloc_filter_set_period_field_object_label,$alloc_filter_set_to_label,CURRENT_PERIOD
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.click_on_add_filter_group_button
			#filter 3
			Allocations.set_filterset_field_value 3,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field_value 3,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			
			#step3 
			Allocations.click_on_preview_button
			gen_compare error_message_on_invalid_period,FFA.get_sencha_popup_error_message,"incorrect filters"
			FFA.sencha_popup_click_continue
			
			#step4
			Allocations.click_on_filter_group_close_button 2
			gen_compare "2", Allocations.get_filters_selected_value,"Number of filter selected"
			
			#step5
			Allocations.click_on_preview_button
			gen_compare "$(656.25)",Allocations.get_total_value,"Total value matched successfully"
			
			#step6
			Allocations.click_on_show_filters_button
			Allocations.click_on_filter_group_close_button 2
			gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected"
			
			#step7
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"incorrect filters"
			FFA.sencha_popup_click_continue
			
			#Step8
			gen_compare "0.00",Allocations.get_total_value,"Total value matched successfully"
			
			#step9
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field_value 1,$alloc_filter_set_period_field_object_label,$alloc_filter_set_to_label,CURRENT_PERIOD
			
			#Step10
			Allocations.click_on_preview_button
			gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected"
			gen_compare "$(656.25)",Allocations.get_total_value,"Total value matched successfully"
			
			#step11
			Allocations.click_on_show_filters_button
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			
			#step12
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"incorrect filters"
			FFA.sencha_popup_click_continue
			
			#step13
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label
			Allocations.clear_filterset_field 1,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label
			
			#step14
			Allocations.click_on_preview_button
			gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected"
			gen_compare "$(656.25)",Allocations.get_total_value,"Total value matched successfully"
			
			#step15
			Allocations.click_on_show_filters_button
			Allocations.set_filterset_field_value 1,$alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_usa
			Allocations.set_filterset_field_value 1, $alloc_filter_set_period_field_object_label,$alloc_filter_set_to_label,CURRENT_PERIOD
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			
			#step16
			gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected"
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"incorrect filters"
			FFA.sencha_popup_click_continue
		end
		gen_end_test "TST036361 - Verify the TLIs retrieved in Multi - company mode when only ICT = true."
	end

	after :all do
		login_user
		#Delete Test Data
		_delete_data = ["CODATID021158Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID021158: Verify the TLIs retrieved when user filter specific set of data in Multi - company Mode."
	end
end
		