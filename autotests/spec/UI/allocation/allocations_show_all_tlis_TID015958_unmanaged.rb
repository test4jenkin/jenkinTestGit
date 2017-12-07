#--------------------------------------------------------------------#
# TID : TID015958
# Pre-Requisit: Org with basedata deployed; CODATID015958Data.cls deployed on org.
# Product Area: Accounting - Allocations
# Story: 25268
#--------------------------------------------------------------------#

describe "Intercompany Eliminations", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	# Test setup
	before(:all) do
		## Intercompany Eliminations does a lot of asynchronous requests.
		## Let's be a little patient.
		$current_default_wait_time = Capybara.default_wait_time
		## We do not want to take hidden elements into account
		$current_ignore_hidden = Capybara.ignore_hidden_elements

		Capybara.default_wait_time = 10
		Capybara.ignore_hidden_elements = true
		
		begin
			#Execute data methods to create data
			_create_data = ["CODATID015958Data.selectCompany();", "CODATID015958Data.createData();", "CODATID015958Data.createDataExt1();"]
			_create_data+= ["CODATID015958Data.createDataExt2();", "CODATID015958Data.createDataExt3();", "CODATID015958Data.switchProfile();"]
			#Execute Commands
			APEX.execute_commands _create_data
		end 
	end

	it "TID015958 - Allocation - TLI info" , :unmanaged => true do
		SF.login_as_user SFACC_USER
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_aus, $company_merlin_auto_gb ] ,true
		gen_start_test "TID05958"
		$locale = "English (United States)"		#gen_get_current_user_locale  -- Currently open_new_window method is failing
		CURRENT_DATE = FFA.get_current_formatted_date
		AVAILABLE_COMPANIES = [ $company_merlin_auto_spain, $company_merlin_auto_aus, $company_merlin_auto_gb ]
		CURRENT_PERIOD = FFA.get_current_period
		NEXT_PERIOD = FFA.get_period_by_date Date.today>>1
		GLA_ACCOUNTS_RECEIVABLE_CONTROL = "Accounts Receivable Control"

		test_step "TST022433 - View transaction line items list - multicompany - from one company" do
			expected_rows_summary = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(20.66)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(20.50)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(20.00)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(20.10)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(20.28)})"
			]

			expected_expand_rows_all_tlis_row_1 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.33)})" + " " + "(#{gen_locale_format_number(10.33)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.33)})" + " " + "(#{gen_locale_format_number(10.33)})"
			]
			expected_expand_rows_all_tlis_row_2 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.25)})" + " " + "(#{gen_locale_format_number(10.25)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.25)})" + " " + "(#{gen_locale_format_number(10.25)})" 
			]
			expected_expand_rows_all_tlis_row_3 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.00)})" + " " + "(#{gen_locale_format_number(10.00)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.00)})" + " " + "(#{gen_locale_format_number(10.00)})"
			]
			expected_expand_rows_all_tlis_row_4 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.05)})" + " " + "(#{gen_locale_format_number(10.05)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.05)})" + " " + "(#{gen_locale_format_number(10.05)})"
			]
			expected_expand_rows_all_tlis_row_5 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.14)})" + " " + "(#{gen_locale_format_number(10.14)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.14)})" + " " + "(#{gen_locale_format_number(10.14)})"
			]

			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $ffa_msg_loading
			gen_compare "0.00",Allocations.get_total_value,"No filter is selected."
			
			page.has_css?($alloc_only_ict_checkbox_label)
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp

			Allocations.click_on_preview_button

			puts "show tlis in summary"
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows_summary).to eq(true)

			puts "show tlis in details"
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[0]),expected_expand_rows_all_tlis_row_1).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[1]),expected_expand_rows_all_tlis_row_2).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[2]),expected_expand_rows_all_tlis_row_3).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[3]),expected_expand_rows_all_tlis_row_4).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[4]),expected_expand_rows_all_tlis_row_5).to eq(true)
		end

		test_step "TST022434 - View transaction line items list - multicompany - from several companies" do
			expected_rows_summary = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(20.66)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.34)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(20.50)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.26)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(20.00)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(10.01)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(20.10)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.06)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(20.28)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.15)})"
			]

			expected_rows_all_tlis_1 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.33)})" + " " + "(#{gen_locale_format_number(10.33)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.33)})" + " " + "(#{gen_locale_format_number(10.33)})"
			]
			expected_rows_all_tlis_2 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.34)})" + " " + "(#{gen_locale_format_number(10.34)})"
			]
			expected_rows_all_tlis_3 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.25)})" + " " + "(#{gen_locale_format_number(10.25)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.25)})" + " " + "(#{gen_locale_format_number(10.25)})"
			]
			expected_rows_all_tlis_4 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.26)})" + " " + "(#{gen_locale_format_number(10.26)})"
			]
			expected_rows_all_tlis_5 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.00)})" + " " + "(#{gen_locale_format_number(10.00)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.00)})" + " " + "(#{gen_locale_format_number(10.00)})"
			]
			expected_rows_all_tlis_6 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.01)})" + " " + "(#{gen_locale_format_number(10.01)})"
			]
			expected_rows_all_tlis_7 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.05)})" + " " + "(#{gen_locale_format_number(10.05)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.05)})" + " " + "(#{gen_locale_format_number(10.05)})"
			]
			expected_rows_all_tlis_8 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.06)})" + " " + "(#{gen_locale_format_number(10.06)})"
			]
			expected_rows_all_tlis_9 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.14)})" + " " + "(#{gen_locale_format_number(10.14)})",
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.14)})" + " " + "(#{gen_locale_format_number(10.14)})"
			]
			expected_rows_all_tlis_10 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.15)})" + " " + "(#{gen_locale_format_number(10.15)})"
			]

			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $ffa_msg_loading
			
			gen_compare "0.00",Allocations.get_total_value,"No filter is selected."

			page.has_css?($alloc_only_ict_checkbox_label)
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp

			Allocations.click_on_add_filter_group_button

			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp

			Allocations.click_on_preview_button

			puts "show tlis in summary"
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows_summary).to eq(true)

			puts "show tlis in details"
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[0]),expected_rows_all_tlis_1).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[1]),expected_rows_all_tlis_2).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[2]),expected_rows_all_tlis_3).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[3]),expected_rows_all_tlis_4).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[4]),expected_rows_all_tlis_5).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[5]),expected_rows_all_tlis_6).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[6]),expected_rows_all_tlis_7).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[7]),expected_rows_all_tlis_8).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[8]),expected_rows_all_tlis_9).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[9]),expected_rows_all_tlis_10).to eq(true)
		end

		test_step "TST022442 - View transaction line items list - multicompany - search TLIs" do
			expected_rows_initial_1 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.33)})" + " " + "(#{gen_locale_format_number(10.33)})"
			]
			expected_rows_initial_2 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.34)})" + " " + "(#{gen_locale_format_number(10.34)})"
			]
			expected_rows_initial_3 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.25)})" + " " + "(#{gen_locale_format_number(10.25)})"
			]
			expected_rows_initial_4 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.26)})" + " " + "(#{gen_locale_format_number(10.26)})"
			]
			expected_rows_initial_5 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.00)})" + " " + "(#{gen_locale_format_number(10.00)})"
			]
			expected_rows_initial_6 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.01)})" + " " + "(#{gen_locale_format_number(10.01)})"
			]
			expected_rows_initial_7 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.05)})" + " " + "(#{gen_locale_format_number(10.05)})"
			]
			expected_rows_initial_8 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.06)})" + " " + "(#{gen_locale_format_number(10.06)})"
			]
			expected_rows_initial_9 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.14)})" + " " + "(#{gen_locale_format_number(10.14)})"
			]
			expected_rows_initial_10 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.15)})" + " " + "(#{gen_locale_format_number(10.15)})"
			]
			
			expected_rows_first_search = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.33)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.34)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.25)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.26)})"
			]

			expected_rows_second_search = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.25)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.26)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(10.00)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(10.01)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.05)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.06)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.14)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.15)})"
			]

			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $ffa_msg_loading
			gen_compare "0.00",Allocations.get_total_value,"No filter is selected."
			page.has_css?($alloc_only_ict_checkbox_label)
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp

			Allocations.click_on_add_filter_group_button

			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp

			Allocations.click_on_preview_button
			Allocations.click_toggle_button
			expect(Allocations.assert_retrieved_detail_grid_rows 1,expected_rows_initial_1).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 2,expected_rows_initial_2).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 3,expected_rows_initial_3).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 4,expected_rows_initial_4).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 5,expected_rows_initial_5).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 6,expected_rows_initial_6).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 7,expected_rows_initial_7).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 8,expected_rows_initial_8).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 9,expected_rows_initial_9).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows 10,expected_rows_initial_10).to eq(true)
			Allocations.click_toggle_button
			
			#Complete Search
			Allocations.set_search "Accounts Receivable Control - EUR"
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows_first_search).to eq(true)

			#Partial Search
			Allocations.set_search "Dim"
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows_second_search).to eq(true)
		end

		test_step "TST022453 - View transaction line items list - singlecompany - from one company" do
			expected_rows_summary = [
				$bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(6.89)})",
				$bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(6.83)})",
				$bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " +"(#{gen_locale_format_number(6.67)})",
				$bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(6.70)})",
				$bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(6.76)})"
			]

			expected_all_tlis_1 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.33)})" + " " + "(#{gen_locale_format_number(6.89)})"
			]
			expected_all_tlis_2 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.25)})" + " " + "(#{gen_locale_format_number(6.83)})"
			]
			expected_all_tlis_3 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.00)})" + " " + "(#{gen_locale_format_number(6.67)})"
			]
			expected_all_tlis_4 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.05)})" + " " + "(#{gen_locale_format_number(6.70)})"
			]
			expected_all_tlis_5 = [
				$bd_currency_usd + " " + "(#{gen_locale_format_number(10.14)})" + " " + "(#{gen_locale_format_number(6.76)})"
			]

			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain], true
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $ffa_msg_loading
			gen_compare "0.00",Allocations.get_total_value,"No filter is selected."
			page.has_css?($alloc_only_ict_checkbox_label)
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp

			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows_summary).to eq(true)

			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[0]),expected_all_tlis_1).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[1]),expected_all_tlis_2).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[2]),expected_all_tlis_3).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[3]),expected_all_tlis_4).to eq(true)
			expect(Allocations.assert_retrieved_detail_grid_rows Allocations.get_retrieved_summary_row_number(expected_rows_summary[4]),expected_all_tlis_5).to eq(true)
		end
	end
	
	after(:all) do
		login_user
		## Restore previous environment variables.
		Capybara.default_wait_time = $current_default_wait_time
		Capybara.ignore_hidden_elements = $current_ignore_hidden
		# Delete Test Data
		_delete_data = ["CODATID015958Data.destroyData();"]
		APEX.execute_commands _delete_data
		gen_end_test "TID015958"
	end
end
