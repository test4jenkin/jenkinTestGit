#--------------------------------------------------------------------#
# TID : TID017680
# Pre-Requisit: Org with basedata deployed; Deploy CODATID017680Data.cls on org.
# Product Area: Intercompany
# Story: 30634
#--------------------------------------------------------------------#


describe "Intercompany Reconciliation", :type => :request do

	include_context "login"
	include_context "logout_after_each"
	# Test setup
	before(:all) do
		## Intercompany Reconciliation does a lot of asynchronous requests.
		## Let's be a little patient.
		$current_default_wait_time = Capybara.default_wait_time
		## We do not want to take hidden elements into account
		$current_ignore_hidden = Capybara.ignore_hidden_elements

		Capybara.default_wait_time = 10
		Capybara.ignore_hidden_elements = true
		FFA.hold_base_data_and_wait
	end

	after(:all) do
		login_user
		## Restore previous environment variables.
		destroy_test_data = [ "CODATID017680Data.destroyData();"]						
		APEX.execute_commands destroy_test_data	
		Capybara.default_wait_time = $current_default_wait_time
		Capybara.ignore_hidden_elements = $current_ignore_hidden
		FFA.delete_new_data_and_wait
		SF.logout
	end

	it "TID017680 - Reconciliation - Set up and retrieve", :unmanaged => true  do
		gen_start_test "TID017680"
		
		"Execute Script as Anonymous user" 
			create_basedata_for_TID = [ "CODATID017680Data.selectCompany();",
						"CODATID017680Data.createData();",
						"CODATID017680Data.createDataExt1();",
						"CODATID017680Data.createDataExt2();",
						"CODATID017680Data.createDataExt3();",
						"CODATID017680Data.createDataExt4();",
						"CODATID017680Data.createDataExt5();",
						"CODATID017680Data.createDataExt6();",
						"CODATID017680Data.createDataExt7();",
						"CODATID017680Data.createDataExt8();",
						"CODATID017680Data.createDataExt9();",
						"CODATID017680Data.createDataExt10();",
						"CODATID017680Data.switchProfile();"]	
			APEX.execute_commands create_basedata_for_TID
		
		$locale = gen_get_current_user_locale
		TOTAL_SUM_MERLIN_AUTO_SPAIN = gen_locale_format_number(-100.23)
		TOTAL_SUM_MERLIN_AUTO_USA = gen_locale_format_number(100.23)
		_gmt_offset = gen_get_current_user_gmt_offset
		CURRENT_DATE = gen_locale_format_date (gen_get_current_date _gmt_offset)
		MULTIPLE_ACCOUNTS = "Multiple Accounts"
		MULTIPLE_GLAS = "Multiple GLAs"
		AVAILABLE_COMPANIES = [ $company_merlin_auto_spain, $company_merlin_auto_usa, $company_merlin_auto_gb ]
		CURRENT_PERIOD = FFA.get_current_period
		MERLIN_AUTO_SPAIN_LINES1 = [
			[CURRENT_DATE, 'CSH', 'CE IC Line 1', 'ICT', '', 'EUR', gen_locale_format_number(-100.23)]
		]
		MERLIN_AUTO_SPAIN_LINES2 = [
			[CURRENT_DATE, 'CSH', 'CE IC Line 1', 'ICT', '', 'EUR', gen_locale_format_number(-100.23)],
			[CURRENT_DATE, 'JNL', 'JRN Line 4 with very long description. This text should make an ellipsis appear and we\'ll be able to see the rest of the text by hovering the field.', '', '', 'EUR', gen_locale_format_number(-110.23)]
		]
		MERLIN_AUTO_USA_LINES1 = [
			[gen_locale_format_number(100.23), CURRENT_DATE, 'CSH', '', 'ICT', '', 'EUR']
		]
		MERLIN_AUTO_USA_LINES2 = [
			[gen_locale_format_number(100.23), CURRENT_DATE, 'CSH', '', 'ICT', '', 'EUR'],
			[gen_locale_format_number(-110.23), CURRENT_DATE, 'JNL', '', '', '', 'EUR']
		]
		MERLIN_AUTO_SPAIN_LINES3 = [
			[CURRENT_DATE, 'JNL', 'JRN Line 4 with very long description. This text should make an ellipsis appear and we\'ll be able to see the rest of the text by hovering the field.', '', '', 'EUR', gen_locale_format_number(-110.23)]
		]
		MERLIN_AUTO_USA_LINES3 = [
			[gen_locale_format_number(-110.23), CURRENT_DATE, 'JNL', '', '', '', 'EUR']
		]
		
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain,$company_merlin_auto_usa] , true
		SF.tab $tab_transaction_reconciliations
		SF.click_button_new
		TRANRECON.wait_for_loading
		
		gen_start_test "TST026834 - Filters - Retrieve"
		begin
		
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_eur
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_account_label, "Merlin USA Account"
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_usd
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_account_label, "Merlin Spain Account"
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			expect(TRANRECON.pane_company_equals? $tranrecon_left_panel, $company_merlin_auto_spain).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_left_panel, $bd_gla_account_receivable_control_eur).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_left_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_left_panel, "Merlin USA Account").to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_left_panel, MERLIN_AUTO_SPAIN_LINES1).to eq(true)

			gen_report_test "Assert that Search values are proper as per single account filter in left panel"
			
			expect(TRANRECON.pane_company_equals? $tranrecon_right_panel, $company_merlin_auto_usa).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_right_panel, $bd_gla_account_payable_control_usd).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_right_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_right_panel, "Merlin Spain Account").to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_right_panel, MERLIN_AUTO_USA_LINES1).to eq(true)
			
			gen_report_test "Assert that Search values are proper as per single account filter in right panel"
			
			TRANRECON.click_button $tranrecon_left_retrieve_edit_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_account_label, $bd_account_audi
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_retrieve_edit_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_eur
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_account_label, $bd_account_audi
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading

			expect(TRANRECON.pane_company_equals? $tranrecon_left_panel, $company_merlin_auto_spain).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_left_panel, $bd_gla_account_receivable_control_eur).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_left_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_left_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_left_summary_panel, -210.46).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -210.46).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_left_panel, MERLIN_AUTO_SPAIN_LINES2).to eq(true)

			gen_report_test "Assert that Search values are proper as per multiple account filter in left panel"
			
			expect(TRANRECON.pane_company_equals? $tranrecon_right_panel, $company_merlin_auto_usa).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_right_panel, MULTIPLE_GLAS).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_right_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_right_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_right_summary_panel, -10.00).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, -10.00).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_right_panel, MERLIN_AUTO_USA_LINES2).to eq(true)
			
			gen_report_test "Assert that Search values are proper as per multiple account filter in right panel"
		end
		
		gen_start_test "TST027651 - Filters"
		begin
			
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 1
			
			TRANRECON.select_show_filter_in_pane $tranrecon_left_panel, $tranrecon_show_filter_show_selected
			TRANRECON.select_show_filter_in_pane $tranrecon_right_panel, $tranrecon_show_filter_show_selected
			
			expect(TRANRECON.line_selected? $tranrecon_left_table, 1, true).to eq(true)
			expect(TRANRECON.pane_company_equals? $tranrecon_left_panel, $company_merlin_auto_spain).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_left_panel, $bd_gla_account_receivable_control_eur).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_left_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_left_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_left_summary_panel, -210.46).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -110.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_left_panel, MERLIN_AUTO_SPAIN_LINES1).to eq(true)
			expect(TRANRECON.found_result_count_equals? $tranrecon_left_panel, $ffa_msg_search_results_ouput_text.sub($sf_param_substitute,1.to_s)).to eq(true)

			gen_report_test "Assert that Search values are proper as per 'Show Selected' filter in left panel"
			
			expect(TRANRECON.line_selected? $tranrecon_right_table, 1, true).to eq(true)
			expect(TRANRECON.pane_company_equals? $tranrecon_right_panel, $company_merlin_auto_usa).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_right_panel, MULTIPLE_GLAS).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_right_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_right_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_right_summary_panel, -10.00).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, -110.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_right_panel, MERLIN_AUTO_USA_LINES1).to eq(true)
			expect(TRANRECON.found_result_count_equals? $tranrecon_right_panel, $ffa_msg_search_results_ouput_text.sub($sf_param_substitute,1.to_s)).to eq(true)
			
			gen_report_test "Assert that Search values are proper as per 'Show Selected' filter in right panel"
			
			TRANRECON.select_show_filter_in_pane $tranrecon_left_panel, $tranrecon_show_filter_show_deselected
			TRANRECON.select_show_filter_in_pane $tranrecon_right_panel, $tranrecon_show_filter_show_deselected
			
			expect(TRANRECON.line_selected? $tranrecon_left_table, 1, false).to eq(true)
			expect(TRANRECON.pane_company_equals? $tranrecon_left_panel, $company_merlin_auto_spain).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_left_panel, $bd_gla_account_receivable_control_eur).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_left_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_left_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_left_summary_panel, -210.46).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -110.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_left_panel, MERLIN_AUTO_SPAIN_LINES3).to eq(true)
			expect(TRANRECON.found_result_count_equals? $tranrecon_left_panel, $ffa_msg_search_results_ouput_text.sub($sf_param_substitute,1.to_s)).to eq(true)

			gen_report_test "Assert that Search values are proper as per 'Show Deselected' filter in left panel"
			
			expect(TRANRECON.line_selected? $tranrecon_right_table, 1, false).to eq(true)
			expect(TRANRECON.pane_company_equals? $tranrecon_right_panel, $company_merlin_auto_usa).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_right_panel, MULTIPLE_GLAS).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_right_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_right_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_right_summary_panel, -10.00).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, -110.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_right_panel, MERLIN_AUTO_USA_LINES3).to eq(true)
			expect(TRANRECON.found_result_count_equals? $tranrecon_right_panel, $ffa_msg_search_results_ouput_text.sub($sf_param_substitute,1.to_s)).to eq(true)
			
			gen_report_test "Assert that Search values are proper as per 'Show Deselected' filter in right panel"
			
			TRANRECON.select_show_filter_in_pane $tranrecon_left_panel, $tranrecon_show_filter_show_all
			TRANRECON.select_show_filter_in_pane $tranrecon_right_panel, $tranrecon_show_filter_show_all
			
			expect(TRANRECON.line_selected? $tranrecon_left_table, 1, true).to eq(true)
			expect(TRANRECON.line_selected? $tranrecon_left_table, 2, false).to eq(true)
			expect(TRANRECON.pane_company_equals? $tranrecon_left_panel, $company_merlin_auto_spain).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_left_panel, $bd_gla_account_receivable_control_eur).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_left_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_left_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_left_summary_panel, -210.46).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -110.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_left_panel, MERLIN_AUTO_SPAIN_LINES2).to eq(true)
			expect(TRANRECON.found_result_count_equals? $tranrecon_left_panel, $ffa_msg_search_results_ouput_text.sub($sf_param_substitute,2.to_s)).to eq(true)

			gen_report_test "Assert that Search values are proper as per 'Show All' filter in left panel"
			
			expect(TRANRECON.line_selected? $tranrecon_right_table, 1, true).to eq(true)
			expect(TRANRECON.line_selected? $tranrecon_right_table, 2, false).to eq(true)
			expect(TRANRECON.pane_company_equals? $tranrecon_right_panel, $company_merlin_auto_usa).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_right_panel, MULTIPLE_GLAS).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_right_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.pane_account_equals? $tranrecon_right_panel, MULTIPLE_ACCOUNTS).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_right_summary_panel, -10.00).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, -110.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_right_panel, MERLIN_AUTO_USA_LINES2).to eq(true)
			expect(TRANRECON.found_result_count_equals? $tranrecon_right_panel, $ffa_msg_search_results_ouput_text.sub($sf_param_substitute,2.to_s)).to eq(true)
			
			gen_report_test "Assert that Search values are proper as per 'Show All' filter in right panel"
		end
		gen_end_test "TID017680"
	end
end
