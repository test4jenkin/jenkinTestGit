#--------------------------------------------------------------------#
# TID : TID014831
# Pre-Requisit: Org with basedata deployed.Deploy CODATID014831Data.cls on org.
# Product Area: Intercompany
# Story: 25401
#--------------------------------------------------------------------#


describe "Intercompany Eliminations",:type => :request  do
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
			_create_data = ["CODATID014831Data.selectCompany();", "CODATID014831Data.createData();", "CODATID014831Data.createDataExt1();"]
			_create_data+= ["CODATID014831Data.createDataExt2();", "CODATID014831Data.createDataExt3();", "CODATID014831Data.createDataExt4();"]
			_create_data+= ["CODATID014831Data.createDataExt5();", "CODATID014831Data.createDataExt6();","CODATID014831Data.switchProfile();"]
			# Execute Commands
			APEX.execute_commands _create_data
		end 
		$locale = "English (United States)"		#gen_get_current_user_locale  -- Currently open_new_window method is failing
		CURRENT_DATE = FFA.get_current_formatted_date
		AVAILABLE_COMPANIES = [ $company_merlin_auto_spain, $company_merlin_auto_usa, $company_merlin_auto_gb ]
		CURRENT_PERIOD = FFA.get_current_period
		NEXT_PERIOD = FFA.get_period_by_date Date.today>>1
	end
	
	it "TID014831:TST020301 - Intercompany Elimination - Retrieve in multi-company mode", :unmanaged => true  do
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TID014831"
		
		test_step "TST020301 - One company, all periods, all GLA's" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(20.67)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(20.51)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(20.29)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(20.11)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(20.01)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			
			Allocations.click_on_preview_button
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test "TID014831-TID014831"
	end
	
	it "TID014831:TST020302-1 - Intercompany Elimination - Retrieve in multi-company mode", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020302"
		test_step "TST020302-1 - One company, one period, all GLA's" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.33)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.25)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.14)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.05)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(10.00)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message

			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp

			Allocations.click_on_preview_button
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end

		test_step "TST020302-2 - One company, one period, all GLA's" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.34)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.26)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.15)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.06)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(10.01)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message

			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test "TID014831-TST020302"
	end	

	it "TID014831:TST020303 - One company, one period, one GLA", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020303"
		test_step "TST020303-1 - One company, one period, one GLA" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.33)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.25)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end

		test_step "TST020303-2 - One company, one period, one GLA" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.14)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.05)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test  "TID014831-TST020303"
	end

	it "TID014831:TST020304 - One company, one period, several GLA's", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020304"
		test_step "TST020304 - One company, one period, several GLA's" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.33)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.25)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.14)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.05)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.click_on_preview_button
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test  "TID014831-TST020304"
	end
	
	it "TID014831:TST020305 - One company, one period, all GLA's, one dimension", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020305"
		test_step "TST020305 - One company, one period, all GLA's, one dimension" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.14)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test  "TID014831-TST020305"
	end
	
	it "TID014831:TST020307 - One company, several periods, all GLA's, several dimensions", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020307"
		test_step "TST020307 - One company, several periods, all GLA's, several dimensions" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(20.67)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(20.51)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(20.01)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test "TID014831-TST020307"
	end
	
	it "TID014831:TST020308 - Several companies, all periods, all GLA's, all dimensions", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020308"
		test_step "TST020308 - Several companies, all periods, all GLA's, all dimensions" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(20.67)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(20.51)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(20.29)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(20.11)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(20.01)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(20.67)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(20.51)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(20.29)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(20.11)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(20.01)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion

			Allocations.click_on_add_filter_group_button
			 
			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, CURRENT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test "TID014831-TST020308"
	end
	
	it "TID014831:TST020309 - Several companies, one period, all GLA's, all dimensions - ICT checkbox is False", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020309"
		test_step "TST020309 - Several companies, one period, all GLA's, all dimensions - ICT checkbox is False" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.33)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.25)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.14)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.05)})",
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(10.00)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(10.34)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(10.26)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + "(#{gen_locale_format_number(10.15)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + "(#{gen_locale_format_number(10.06)})",
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + "(#{gen_locale_format_number(10.01)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion

			Allocations.click_on_add_filter_group_button
			 
			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.click_on_preview_button

			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test "TID014831-TST020309"
	end

	it "TID014831:TST020310 - Dual currency conversion", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020310"
		test_step "TST020310 - Dual currency conversion" do
			expected_rows = [
				$company_merlin_auto_gb + " " + $bd_gla_account_receivable_control_eur + " " + "(#{gen_locale_format_number(12.40)})",
				$company_merlin_auto_gb + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + "(#{gen_locale_format_number(12.30)})"
			]
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_gb
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.click_on_preview_button

			Allocations.assert_total_amount_value "(#{gen_locale_format_number(24.70)})"
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test "TID014831-TST020310"
	end
	
	it "TID014831:TST020687 - Several companies, one period, all GLA's, all dimensions. ICT checkbox is TRUE", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST020687"
		test_step "TST020687 - Several companies, one period, all GLA's, all dimensions. ICT checkbox is TRUE" do
			expected_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_bank_account_euros_us + " " + "#{gen_locale_format_number(100.00)}"
			]

			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_only_intercompany_transactions_checkbox true

			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_bank_account_euros_us

			Allocations.click_on_preview_button
			expect(Allocations.assert_retrieved_summary_grid_rows expected_rows).to eq(true)
		end
		gen_end_test "TID014831-TST020687"
	end
	
	it "TID014831:TST021271 - Validation - Several companies - mandatory fields", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST021271"
		test_step "TST021271 - Validation - Several companies - mandatory fields" do
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			gen_assert_disabled $alloc_add_filter_group_button

			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain

			gen_assert_disabled $alloc_add_filter_group_button

			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd

			gen_assert_enabled $alloc_add_filter_group_button

			Allocations.click_on_add_filter_group_button

			gen_assert_disabled $alloc_add_filter_group_button

			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus

			gen_assert_disabled $alloc_add_filter_group_button

			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur

			gen_assert_enabled $alloc_add_filter_group_button
		end
		gen_end_test "TID014831-TST021271"
	end
		

=begin These steps are failing due to Sencha issues. Will be addressed in the future. The functionality is automated in Apex.

		test_step "TST021173-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - company not selected validation" do
			expected_popup_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(-10.33),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(-10.25),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(-10.14),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(-10.05),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(-10.00),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(-10.34),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(-10.26),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(-10.15),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(-10.06),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(-10.01)
			]
			SF.tab $tab_allocations

			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion

			Allocations.add_filter_set
			 
			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.retrieve

			Allocations.open_summary_by_gla
			gen_wait_until_object $alloc_popup
			expect(Allocations.assert_popup_rows expected_popup_rows).to eq(true)
			Allocations.close_popup_rows
		end

		test_step "TST021173-2 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - company not selected validation" do
			gen_check_dependency "TST021173-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - company not selected validation"

			Allocations.set_gla_split 1, $bd_gla_account_receivable_control_eur
			Allocations.set_percent_split 1, 40

			Allocations.set_gla_split 2, $bd_gla_account_receivable_control_usd
			Allocations.set_dimension1_split 2, $bd_dim1_eur
			Allocations.set_percent_split 2, 60

			Allocations.create_allocation

			expect(Allocations.assert_create_popup_available_companies [$company_merlin_auto_spain, $company_merlin_auto_aus, $company_merlin_auto_gb]).to eq(true)
			expect(Allocations.assert_create_popup_date FFA.get_current_formatted_date).to eq(true)
			expect(Allocations.assert_create_popup_period FFA.get_current_period).to eq(true)

			Allocations.set_create_popup_description "Multi-company allocations transaction 1"
			Allocations.set_create_popup_company $company_merlin_auto_gb

			within_window open_new_window do ## TODO
				FFA.select_company [$company_merlin_auto_gb], false
			end

			Allocations.confirm_allocation_creation

			expect(Allocations.assert_exception FFA.fetch_label XXXXXXXXXXX).to eq(true) ## TODO
		end

		test_step "TST021177-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - invalid gla currency validation" do
			expected_popup_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(-10.33),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(-10.25),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(-10.14),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(-10.05),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(-10.00),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(-10.34),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(-10.26),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(-10.15),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(-10.06),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(-10.01)
			]
			SF.tab $tab_allocations

			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion

			Allocations.add_filter_set
			 
			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.retrieve

			Allocations.open_summary_by_gla
			gen_wait_until_object $alloc_popup
			expect(Allocations.assert_popup_rows expected_popup_rows).to eq(true)
			Allocations.close_popup_rows
		end

		test_step "TST021177-2 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - invalid gla currency validation" do
			gen_check_dependency "TST021177-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - invalid gla currency validation"

			Allocations.set_gla_split 1, $bd_gla_account_receivable_control_aud
			Allocations.set_percent_split 1, 100

			Allocations.create_allocation

			expect(Allocations.assert_create_popup_available_companies [$company_merlin_auto_spain, $company_merlin_auto_aus, $company_merlin_auto_gb]).to eq(true)
			expect(Allocations.assert_create_popup_date FFA.get_current_formatted_date).to eq(true)
			expect(Allocations.assert_create_popup_period FFA.get_current_period).to eq(true)

			Allocations.set_create_popup_description "Multi-company allocations transaction 1"
			Allocations.set_create_popup_company $company_merlin_auto_gb

			Allocations.confirm_allocation_creation

			expect(Allocations.assert_exception FFA.fetch_label XXXXXXXXXXX).to eq(true) ## TODO
		end

		test_step "TST021172-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions" do
			expected_popup_rows = [
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(-10.33),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(-10.25),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(-10.14),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(-10.05),
				$company_merlin_auto_spain + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(-10.00),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(-10.34),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(-10.26),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(-10.15),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(-10.06),
				$company_merlin_auto_aus + " " + $bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(-10.01)
			]
			SF.tab $tab_allocations

			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion

			Allocations.add_filter_set
			 
			sleep 5
			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.retrieve
		end

		test_step "TST021172-2 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions" do
			gen_check_dependency "TST021172-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions"

			expected_tlis = [
				$bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(10.33),
				$bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(10.25),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(10.14),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(10.05),
				$bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(10.00),
				$bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(10.34),
				$bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(10.26),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(10.15),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(10.06),
				$bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(10.01),
				$bd_gla_account_payable_control_eur + " " + gen_locale_format_number(-40.63),
				$bd_gla_account_payable_control_usd + " " + $bd_dim1_eur + " " + gen_locale_format_number(-60.95)
			]

			Allocations.set_gla_split 1, $bd_gla_account_receivable_control_eur
			Allocations.set_percent_split 1, 40

			Allocations.set_gla_split 2, $bd_gla_account_receivable_control_usd
			Allocations.set_dimension1_split 2, $bd_dim1_eur
			Allocations.set_percent_split 2, 60

			Allocations.create_allocation

			period = FFA.get_period_by_date(Date.today - 60)
			description = "Multi-company allocations transaction 1"
			dest_company = $company_merlin_auto_aus
			date = Date.today - 5

			sleep 5
			Allocations.set_create_popup_description description

			expect(Allocations.assert_create_popup_available_companies [$company_merlin_auto_spain, $company_merlin_auto_aus, $company_merlin_auto_gb]).to eq(true)
			sleep 5
			Allocations.set_create_popup_company dest_company

			expect(Allocations.assert_create_popup_date FFA.get_current_formatted_date).to eq(true)
			sleep 5
			Allocations.set_create_popup_date(date)

			while !find($alloc_create_allocation_popup_period)['value'].include? FFA.get_current_period do
				sleep 1
			end
			expect(Allocations.assert_create_popup_period FFA.get_current_period).to eq(true)
			sleep 5
			Allocations.set_create_popup_period(period)

			sleep 5
			Allocations.confirm_allocation_creation
			sleep 60000

			Allocations.click_view_transaction_popup_button

			transaction_date = FFA.get_current_formatted_date date

			FFA.assert_transaction transaction_date period description company expected_tlis
		end
=end

	it "TID014831:TST022601 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - transaction preview", :unmanaged => true  do
		login_user
		SF.login_as_user SFACC_USER
		gen_start_test "TID014831-TST022601"
		test_step "TST022601-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - transaction preview" do
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, CURRENT_PERIOD
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 1, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion

			Allocations.click_on_add_filter_group_button
			 
			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, NEXT_PERIOD
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim1_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim2_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim3_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $bd_dim4_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension1_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension2_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension3_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.set_filterset_field 2, $alloc_filter_set_dimension4_field_object_label, $alloc_filter_set_multiselect_label, $alloc_no_dimesion
			Allocations.click_on_next_button
		end

		test_step "TST022601-2 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - transaction preview" do
			gen_check_dependency "TST022601-1 - Create allocation from retrieve with several companies, one period, all GLA's, all dimensions - company not selected validation"

			expected_tlis = [
				$bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(10.33),
				$bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(10.25),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(10.14),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(10.05),
				$bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(10.00),
				$bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(10.34),
				$bd_gla_account_receivable_control_eur + " " + $bd_dim1_eur + " " + gen_locale_format_number(10.26),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim2_eur + " " + gen_locale_format_number(10.15),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim3_eur + " " + gen_locale_format_number(10.06),
				$bd_gla_account_receivable_control_gbp + " " + $bd_dim4_eur + " " + gen_locale_format_number(10.01),
				$bd_gla_account_receivable_control_eur + " " + gen_locale_format_number(40.64),
				$bd_gla_account_receivable_control_usd + " " + $bd_dim2_usd + " " + gen_locale_format_number(60.95)
			]

			Allocations.click_on_next_button

			#This part will be re-modified in coming sprints due to the ongoing work in Allocation
			# Allocations.set_split_line_gla 1, $bd_gla_account_receivable_control_eur
			# Allocations.set_split_line_percentage 1, 40

			# Allocations.set_split_line_gla 2, $bd_gla_account_receivable_control_usd
			# Allocations.set_split_line_dimension2 2, $bd_dim2_usd
			# Allocations.set_split_line_percentage 2, 60

			# Allocations.create_allocation
			# sleep 3
			# expect(Allocations.assert_create_popup_lines_preview expected_tlis).to eq(true)
			# gen_report_test "Expected the values of transaction line item to be correct."
			#close the poup
			# Allocations.click_create_allocation_pupup_cancel_button
		end
		gen_end_test "TID014831-TST022601"
	end
	
	after(:all) do
		login_user
		## Restore previous environment variables.
		Capybara.default_wait_time = $current_default_wait_time
		Capybara.ignore_hidden_elements = $current_ignore_hidden
		# Delete Test Data
		_delete_data = ["CODATID014831Data.destroyData();"]
		APEX.execute_commands _delete_data
		gen_end_test "TID014831"
	end
end
