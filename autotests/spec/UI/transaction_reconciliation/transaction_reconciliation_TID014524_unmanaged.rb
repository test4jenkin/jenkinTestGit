#--------------------------------------------------------------------#
# TID : TID014524
# Pre-Requisit: Org with basedata deployed;Deploy CODATID014524Data.cls on org.
# Product Area: Intercompany
# Story: 25211
#--------------------------------------------------------------------#


describe "Intercompany Reconciliation Auto-matching", :type => :request do

	# Constants
	AVAILABLE_COMPANIES = [ $company_merlin_auto_spain, $company_merlin_auto_usa, $company_merlin_auto_gb ]
	MERLIN_AUTO_SPAIN_LINES = [ 5 ]
	MERLIN_AUTO_USA_LINES = [ 1 ]
	MERLIN_AUTO_SPAIN_LINES_RERUN = [ 1, 5 ]
	MERLIN_AUTO_USA_LINES_RERUN = [ 1, 2]
	include_context "login"
	include_context "logout_after_each"
	# Test setup
	before(:all) do	
		#FFA.hold_base_data_and_wait		
		## Intercompany Reconciliation does a lot of asynchronous requests.
		## Let's be a little patient.
		$current_default_wait_time = Capybara.default_wait_time
		## We do not want to take hidden elements into account
		$current_ignore_hidden = Capybara.ignore_hidden_elements

		Capybara.default_wait_time = 10
		Capybara.ignore_hidden_elements = true
	end

	after(:all) do
		login_user
		SF.retry_script_block do
			delete_data = [ "CODATID014524Data.destroyData();"]				
			APEX.execute_commands delete_data
		end
		## Restore previous environment variables.
		Capybara.default_wait_time = $current_default_wait_time
		Capybara.ignore_hidden_elements = $current_ignore_hidden
		SF.logout
	end

	

	it "TID014524 - Reconciliation - Auto-matching", :unmanaged => true  do
		gen_start_test "TID014524"		
		#"execute script as anonymous user" 
		create_additional_data = [ "CODATID014524Data.selectcompany();",
				"CODATID014524Data.createdata();",
				"CODATID014524Data.createdataExt1();",
				"CODATID014524Data.createdataExt2();",
				"CODATID014524Data.createdataExt3();",
				"CODATID014524Data.createdataExt4();",
				"CODATID014524Data.createdataExt5();",
				"CODATID014524Data.createdataExt6();",
				"CODATID014524Data.createdataExt7();",
				"CODATID014524Data.createdataExt8();",
				"CODATID014524Data.createdataExt9();",
				"CODATID014524Data.createdataExt10();",
				"CODATID014524Data.createdataExt11();",
				"CODATID014524Data.createdataExt12();",
				"CODATID014524Data.switchprofile();"]
		APEX.execute_commands create_additional_data		
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company AVAILABLE_COMPANIES , true
		$locale = gen_get_current_user_locale
		current_period = FFA.get_current_period
		current_date = FFA.get_current_formatted_date

		SF.tab $tab_transaction_reconciliations
		SF.click_button_new
		TRANRECON.wait_for_loading
		test_step "TST019812 - Run auto-match" do
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_eur
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			# Step 2 set field in right panel
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_usd
			# click button retrieve
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			expect(TRANRECON.is_button_disabled? $tranrecon_auto_match_button).to be false
			TRANRECON.click_button $tranrecon_auto_match_button
			TRANRECON.wait_for_loading
			expect(TRANRECON.lines_selected? $tranrecon_left_table, MERLIN_AUTO_SPAIN_LINES).to eq(true)
			expect(TRANRECON.lines_selected? $tranrecon_right_table, MERLIN_AUTO_USA_LINES).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, gen_locale_format_number(0.00)).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, gen_locale_format_number(-100.23)).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, gen_locale_format_number(-20.00)).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, gen_locale_format_number(100.23)).to eq(true)
		end

		test_step "TST019813 - Re-run auto-match" do
			gen_check_dependency "TST019812 - Run auto-match"

			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.reconciliation_unselect_line $tranrecon_left_table, 4
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 2
			TRANRECON.reconciliation_unselect_line $tranrecon_right_table, 3
			TRANRECON.click_button $tranrecon_auto_match_button
			TRANRECON.wait_for_loading
			expect(TRANRECON.lines_selected? $tranrecon_left_table, MERLIN_AUTO_SPAIN_LINES_RERUN).to eq(true)
			expect(TRANRECON.lines_selected? $tranrecon_right_table, MERLIN_AUTO_USA_LINES_RERUN).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, gen_locale_format_number(-222.22)).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, gen_locale_format_number(121.99)).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, gen_locale_format_number(-10.00)).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, gen_locale_format_number(90.23)).to eq(true)
		end

		test_step "TST019815 - Clear" do
			gen_check_dependency "TST019813 - Re-run auto-match"
			TRANRECON.click_button $tranrecon_clear_matches_button
			
			expect(TRANRECON.no_lines_selected? $tranrecon_left_table).to eq(true)
			expect(TRANRECON.no_lines_selected? $tranrecon_right_table).to eq(true)

			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, gen_locale_format_number(-100.23)).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, gen_locale_format_number(0.00)).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, gen_locale_format_number(80.23)).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, gen_locale_format_number(0.00)).to eq(true)
		end		
		gen_end_test "TID014524"
	end
end
