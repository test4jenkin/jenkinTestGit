#--------------------------------------------------------------------#
#	TID : TID021157
#	Pre-Requisite: Org with basedata deployed.CODATID021157Data.cls should exists on org
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocation_TID021157_unmanaged.rb -fh -o TID021157.html
#   
#--------------------------------------------------------------------#
describe "TID021157 - This TID verifies the TLIs retrieve when user filter specific set of data in single company Mode", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		gen_start_test "TID021157: This TID verifies the TLIs retrieve when user filter specific set of data in single company Mode"
		FFA.hold_base_data_and_wait
	end
	
	it "Verify the TLIs retrieve in Allocation process in single company Mode." , :unmanaged => true do
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_gb], true
		
		_sencha_warning_TST036358 = "Selecting transactions by date range instead of period may result in retrieving transactions from multiple fiscal periods."
		error_message_on_adding_maximum_filter_sets = "You cannot add more than 5 filter groups."
		error_message_on_selecting_filters_with_zero_total ="There is no balance to allocate. Amend your filters and try again."
		error_message_filter_selection_with_no_results = "[1]Either your current filter selection has returned no results or there is no balance to allocate. Amend your filters and try again.;"
		_gmt_offset = gen_get_current_user_gmt_offset
		_locale = gen_get_current_user_locale
		_today = gen_get_current_date _gmt_offset
		_today_date = gen_locale_format_date _today, _locale
		_20daysbeforetoday = gen_locale_format_date (Time.now - 60*60*24*20).gmtime.getlocal(_gmt_offset).to_date, _locale
		CURRENT_FORMATTED_DATE = _today_date
		current_year = Date.today.strftime("%Y")
		current_month = Date.today.strftime("%m")
		current_date = Date.today.strftime("%d")
		CURRENT_PERIOD = FFA.get_current_period
		NEXT_PERIOD = FFA.get_period_by_date Date.today>>1
		begin
			_create_data = ["CODATID021157Data.selectCompany();", "CODATID021157Data.createData();", "CODATID021157Data.createDataExt1();"]
			APEX.execute_commands _create_data
		end
		
		gen_start_test "TST036358 - Verify the TLIs retrieve in Allocation process when Time Period = Date"
		begin
			#Step1
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			gen_compare "0.00",Allocations.get_total_value,"Total value matched successfully"
			
			#Step2
			expect(page.has_text?$alloc_retrieve_source_page_label).to be true
			gen_report_test "Retrieve Source UI gets displayed to user."
			gen_compare "0", Allocations.get_filters_selected_value,"Number of filter selected"
			gen_compare $alloc_type_label,Allocations.get_allocation_type ,"Allocation type matched"
			gen_compare $alloc_period_label, Allocations.get_time_period_value , "Time Period matched"
			gen_compare "",Allocations.get_from_period_value ,"From Period value matched"
			gen_compare CURRENT_PERIOD, Allocations.get_to_period_value ,"To period value matched"
			gen_assert_enabled $alloc_retrieve_source_filter_group_preview_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_All_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_group_button
			gen_assert_disabled $alloc_add_filter_group_button
			gen_report_test "UI loaded succesfully from list view."
			
			#Step3
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_timeperiod_value $alloc_date_label
			gen_report_test "Warning message on changing the timeperiod selection"
			gen_compare _sencha_warning_TST036358,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
			
			#Step4
			FFA.sencha_popup_click_continue
			gen_compare "",Allocations.get_from_date_value ,"From Date field is visible and value matched successfully"
			gen_compare CURRENT_FORMATTED_DATE,Allocations.get_to_date_value ,"To Date field is visible and value matched successfully"
			
			#step5
			#from_date = current_date.to_i - 20
			#from_date_value = from_date.to_s + "/" + current_month + "/" + current_year
			Allocations.set_timeperiod_date_selection _20daysbeforetoday, CURRENT_FORMATTED_DATE
			
			#Step6
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_is
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.click_on_add_filter_group_button
			#filter 2
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_postage_and_stationery
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_003
			Allocations.click_on_add_filter_group_button
			#filter 3
			Allocations.set_filterset_field_value 3,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_004
			Allocations.click_on_add_filter_group_button
			#filter 4
			Allocations.set_filterset_field_value 4,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_payable_control_eur
			Allocations.click_on_add_filter_group_button
			#filter 5
			Allocations.click_gla_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_from_label,$bd_gla_account_payable_control_aud
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_to_label,$bd_gla_write_off_us
			Allocations.click_dimension1_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_to_label,$bd_tasmania
			Allocations.click_dimension2_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_002
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_to_label,$bd_wizard_smith_beer
			Allocations.click_dimension3_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_003
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_to_label,$bd_sales_gbp
			Allocations.click_dimension4_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_004
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_to_label,$bd_roger_scarlatti
			
			#Step6
			gen_compare "5", Allocations.get_filters_selected_value,"Number of filter selected is 5"
			Allocations.click_on_add_filter_group_button
			
			gen_compare error_message_on_adding_maximum_filter_sets,FFA.get_sencha_popup_error_message,"You cannot add more than 5 filter groups."
			FFA.sencha_popup_click_continue
			
			#Step7
			Allocations.click_on_filter_group_close_button 4
			gen_compare "4", Allocations.get_filters_selected_value,"Number of filter selected"
			Allocations.click_on_preview_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			#Step8
			Allocations.click_on_next_button
			gen_assert_enabled $alloc_back_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			gen_end_test "TST036358 - Verify the TLIs retrieve in Allocation process when Time Period = Date"
		end
		
		gen_start_test "TST036359 - Verify the TLIs retrieve in Allocation process when Time Period = Period"
		begin
			#Step1
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			gen_compare "0.00",Allocations.get_total_value,"Total value matched successfully"
			
			#Step2
			expect(page.has_text?$alloc_retrieve_source_page_label).to be true
			gen_report_test "Retrieve Source UI gets displayed to user."
			gen_compare "0", Allocations.get_filters_selected_value,"Number of filter selected"
			gen_compare $alloc_type_label,Allocations.get_allocation_type ,"Allocation type matched"
			gen_compare $alloc_period_label, Allocations.get_time_period_value , "Time Period matched"
			gen_compare "",Allocations.get_from_period_value ,"From Period value matched"
			gen_compare CURRENT_PERIOD, Allocations.get_to_period_value ,"To period value matched"
			gen_assert_enabled $alloc_retrieve_source_filter_group_preview_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_All_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_group_button
			gen_assert_disabled $alloc_add_filter_group_button
			gen_report_test "UI loaded succesfully from list view."
			
			#Step3
			Allocations.set_allocation_type $alloc_type_label
			# set current periods
			PREVIOUS_PERIOD = FFA.get_period_by_date Date.today<<1
			Allocations.set_timeperiod_period_selection PREVIOUS_PERIOD,CURRENT_PERIOD
			
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_is
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.click_on_add_filter_group_button
			#filter 2
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_postage_and_stationery
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_003
			Allocations.click_on_add_filter_group_button
			#filter 3
			Allocations.set_filterset_field_value 3,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_004
			Allocations.click_on_add_filter_group_button
			#filter 4
			Allocations.set_filterset_field_value 4,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_payable_control_eur
			Allocations.click_on_add_filter_group_button
			#filter 5
			Allocations.click_gla_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_from_label,$bd_gla_account_payable_control_aud
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_to_label,$bd_gla_write_off_us
			Allocations.click_dimension1_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_to_label,$bd_tasmania
			Allocations.click_dimension2_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_002
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_to_label,$bd_wizard_smith_beer
			Allocations.click_dimension3_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_003
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_to_label,$bd_sales_gbp
			Allocations.click_dimension4_filter_fromto_button 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_from_label,$bd_apex_eur_004
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_to_label,$bd_roger_scarlatti
			
			#Step4
			gen_compare "5", Allocations.get_filters_selected_value,"Number of filter selected is 5"
			Allocations.click_on_add_filter_group_button
			
			gen_compare error_message_on_adding_maximum_filter_sets,FFA.get_sencha_popup_error_message,"You cannot add more than 5 filter groups."
			FFA.sencha_popup_click_continue
			
			#Step5
			Allocations.click_on_filter_group_close_button 4
			gen_compare "4", Allocations.get_filters_selected_value,"Number of filter selected"
			Allocations.click_on_preview_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			#Step6
			Allocations.click_on_next_button
			gen_assert_enabled $alloc_back_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			gen_end_test "TST036359 - Verify the TLIs retrieve in Allocation process when Time Period = Period"
		end

		gen_start_test "TST036605 - Verify the TLIs retrieve in Allocation process when Time Period = Soft Date"
		begin
			#Step1
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			gen_compare "0.00",Allocations.get_total_value,"Total value matched successfully"
			
			#Step2
			
			expect(page.has_text?$alloc_retrieve_source_page_label).to be true
			gen_report_test "Retrieve Source UI gets displayed to user."
			gen_compare "0", Allocations.get_filters_selected_value,"Number of filter selected"
			gen_compare $alloc_type_label,Allocations.get_allocation_type ,"Allocation type matched"
			gen_compare $alloc_period_label, Allocations.get_time_period_value , "Time Period matched"
			gen_compare "",Allocations.get_from_period_value ,"From Period value matched"
			gen_compare CURRENT_PERIOD, Allocations.get_to_period_value ,"To period value matched"
			gen_assert_enabled $alloc_retrieve_source_filter_group_preview_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_All_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_group_button
			gen_assert_disabled $alloc_add_filter_group_button
			gen_report_test "UI loaded succesfully from list view."
			
			#Step3
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_timeperiod_value $alloc_soft_date_label
			gen_compare _sencha_warning_TST036358,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
			
			#Step4
			FFA.sencha_popup_click_continue
			gen_compare "Current Month",Allocations.get_soft_date_value ,"Soft date picklist field is visible and default value matched successfully"

			#Step5
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_is
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.click_on_add_filter_group_button
			#filter 2
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_postage_and_stationery
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_003
			Allocations.click_on_add_filter_group_button
			#filter 3
			Allocations.set_filterset_field_value 3,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_004
			Allocations.click_on_add_filter_group_button
			#filter 4
			Allocations.set_filterset_field_value 4,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field_value 4,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_gbp
			Allocations.set_filterset_field_value 4,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$bd_harrogate
			Allocations.click_on_add_filter_group_button
			#filter 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_gbp
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			#Step6
			Allocations.click_on_add_filter_group_button
			gen_compare error_message_on_adding_maximum_filter_sets,FFA.get_sencha_popup_error_message,"You cannot add more than 5 filter groups."
			
			#Step7 
			FFA.sencha_popup_click_continue
			Allocations.click_on_selected_filter_clear_group_button 5
			gla = Allocations.assert_filterset_gla_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,gla , "Expected gla is blank"
			dim1 = Allocations.assert_filterset_dim1_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim1 , "Expected dim1 is blank"
			dim2 = Allocations.assert_filterset_dim2_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim2 , "Expected dim2 is blank"
			dim3 = Allocations.assert_filterset_dim3_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim3 , "Expected dim3 is blank"
			dim4 = Allocations.assert_filterset_dim4_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim4 , "Expected dim4 is blank"
			
			Allocations.click_on_preview_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			#Step8
			Allocations.click_on_show_filters_button
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_gbp
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			gen_compare "5", Allocations.get_filters_selected_value,"Number of filter selected"
			
			#Step9
			Allocations.click_on_preview_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			#Step10
			Allocations.click_on_show_filters_button
			Allocations.set_timeperiod_soft_date_selection $alloc_last_month_label, 4
			
			#Step11
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			
			#Step12
			Allocations.set_timeperiod_soft_date_selection $alloc_last_n_month_label, 4
			Allocations.click_on_preview_button
			
			#Step 13
			gen_compare "£83.33",Allocations.get_total_value,"Total Value retrieve after filter selection."
			Allocations.click_on_show_filters_button
			
			#Step14
			Allocations.set_timeperiod_soft_date_selection $alloc_last_n_days_label, 31
			Allocations.click_on_preview_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			gen_end_test "TST036605 - Verify the TLIs retrieve in Allocation process when Time Period = Soft Date"
		end
		
		gen_start_test "TST036606 - Verify the TLIs retrieve in Allocation process when Time Period = Soft Period"
		begin
			#Step1
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			gen_compare "0.00",Allocations.get_total_value,"Total value matched successfully"
			
			#Step2
			
			expect(page.has_text?$alloc_retrieve_source_page_label).to be true
			gen_report_test "source selection pop up get open on click of add source button"
			gen_compare "0", Allocations.get_filters_selected_value,"Number of filter selected"
			gen_compare $alloc_type_label,Allocations.get_allocation_type ,"Allocation type matched"
			gen_compare $alloc_period_label, Allocations.get_time_period_value , "Time Period matched"
			gen_compare "",Allocations.get_from_period_value ,"From Period value matched"
			gen_compare CURRENT_PERIOD, Allocations.get_to_period_value ,"To period value matched"
			gen_assert_enabled $alloc_retrieve_source_filter_group_preview_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_All_button
			gen_assert_enabled $alloc_retrieve_source_filter_group_clear_group_button
			gen_assert_disabled $alloc_add_filter_group_button
			gen_report_test "UI loaded succesfully from list view."
			
			#Step3
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_timeperiod_value $alloc_soft_period_label
			gen_compare "Current Period",Allocations.get_soft_period_value ,"Soft period picklist field is visible and default value matched successfully"
			
			#Step4
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_is
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_eur
			Allocations.click_on_add_filter_group_button
			#filter 2
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_postage_and_stationery
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_003
			Allocations.click_on_add_filter_group_button
			#filter 3
			Allocations.set_filterset_field_value 3,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			Allocations.set_filterset_field_value 3,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_004
			Allocations.click_on_add_filter_group_button
			#filter 4
			Allocations.set_filterset_field_value 4,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field_value 4,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_gbp
			Allocations.set_filterset_field_value 4,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$bd_harrogate
			Allocations.click_on_add_filter_group_button
			#filter 5
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_gbp
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.click_on_add_filter_group_button
			
			#Step5
			gen_compare error_message_on_adding_maximum_filter_sets,FFA.get_sencha_popup_error_message,"You cannot add more than 5 filter groups."
			FFA.sencha_popup_click_continue
			
			Allocations.click_on_preview_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			#Step6
			
			Allocations.click_on_show_filters_button
			Allocations.click_on_selected_filter_clear_group_button 5
			gla = Allocations.assert_filterset_gla_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,gla , "Expected gla is blank"
			dim1 = Allocations.assert_filterset_dim1_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim1 , "Expected dim1 is blank"
			dim2 = Allocations.assert_filterset_dim2_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim2 , "Expected dim2 is blank"
			dim3 = Allocations.assert_filterset_dim3_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim3 , "Expected dim3 is blank"
			dim4 = Allocations.assert_filterset_dim4_value 5,$alloc_filter_set_multiselect_label,''
			gen_compare true ,dim4 , "Expected dim4 is blank"
			
			#Step7 
			Allocations.set_filterset_field_value 5,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_gbp
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_001
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			Allocations.set_filterset_field_value 5,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$alloc_no_dimesion
			
			gen_compare "5", Allocations.get_filters_selected_value,"Number of filter selected"
			
			#Step8
			Allocations.click_on_preview_button
			gen_compare "£499.99",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			#Step9
			Allocations.click_on_show_filters_button
			Allocations.set_timeperiod_soft_period_selection 'Last Period', 4
			Allocations.click_on_preview_button
			
			#Step10
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			
			#Step11
			Allocations.set_timeperiod_soft_period_selection $alloc_last_n_period_label, 4

			#Step12
			Allocations.click_on_preview_button
			
			#Step 13
			gen_compare "£83.33",Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			gen_end_test "TST036606 - Verify the TLIs retrieve in Allocation process when Time Period = Soft Period"
		end	
	end	
	
	after :all do
		login_user
		#Delete Test Data
		_delete_data = ["CODATID021157Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID021157: This TID verifies the TLIs retrieve when user filter specific set of data in single company Mode"
	end
end