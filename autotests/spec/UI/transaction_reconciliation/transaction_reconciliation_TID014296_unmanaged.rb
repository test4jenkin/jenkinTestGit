#--------------------------------------------------------------------#
# TID : TID014296
# Pre-Requisit: Org with basedata deployed. Deploy CODATID014296Data.cls on org.
# Product Area: Intercompany
# Story: 25020
#--------------------------------------------------------------------#


describe "Intercompany Reconciliation", :type => :request do

	include_context "login"
	include_context "logout_after_each"
	# Test setup
	before(:all) do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		## Intercompany Reconciliation does a lot of asynchronous requests.
		## Let's be a little patient.
		$current_default_wait_time = Capybara.default_wait_time
		## We do not want to take hidden elements into account
		$current_ignore_hidden = Capybara.ignore_hidden_elements

		Capybara.default_wait_time = 10
		Capybara.ignore_hidden_elements = true
	end

	it "TID014296 - Reconciliation - Set up and retrieve", :unmanaged => true  do
		gen_start_test "TID014296"
		
		# "execute script as anonymous user" 
		create_additional_data = [ "Delete [Select Id from IdentifierMapping__c];",
				"CODATID014296Data.selectcompany();",
				"CODATID014296Data.createdata();",
				"CODATID014296Data.createdataExt1();",
				"CODATID014296Data.createdataExt2();",
				"CODATID014296Data.createdataExt3();",
				"CODATID014296Data.createdataExt4();",
				"CODATID014296Data.createdataExt5();",
				"CODATID014296Data.createdataExt6();",
				"CODATID014296Data.createdataExt7();",
				"CODATID014296Data.createdataExt8();",
				"CODATID014296Data.createdataExt9();",
				"CODATID014296Data.switchprofile();"]
		APEX.execute_commands create_additional_data	
		
		$locale = gen_get_current_user_locale
		TOTAL_SUM_MERLIN_AUTO_SPAIN = gen_locale_format_number(-100.23)
		TOTAL_SUM_MERLIN_AUTO_USA = gen_locale_format_number(100.23)
		CURRENT_DATE = FFA.get_current_formatted_date
		AVAILABLE_COMPANIES = [ $company_merlin_auto_spain, $company_merlin_auto_usa, $company_merlin_auto_gb ]
		SF.tab $tab_select_company
		FFA.select_company AVAILABLE_COMPANIES, true
		CURRENT_PERIOD = FFA.get_current_period
		MERLIN_AUTO_SPAIN_LINES = [
			[CURRENT_DATE, 'JNL', '', '', '', 'EUR', gen_locale_format_number(100.23)],
			[CURRENT_DATE, 'JNL', 'JRN Line 3', '', '', 'EUR', gen_locale_format_number(10)],
			[CURRENT_DATE, 'CSH', 'CE IC Line 1', 'ICT', '', 'EUR', gen_locale_format_number(-100.23)],
			[CURRENT_DATE, 'JNL', 'JRN Line 4 with very long description. This text should make an ellipsis appear and we\'ll be able to see the rest of the text by hovering the field.', '', '', 'EUR', gen_locale_format_number(-110.23)]
		]
		MERLIN_AUTO_USA_LINES = [
			[gen_locale_format_number(100.23), CURRENT_DATE, 'CSH', '', 'ICT', '', 'EUR']
		]
		TLI_TABLES_COLUMNS = [
			$TRANRECON_TABLE_DATE_COLUMN.upcase,
			$TRANRECON_TABLE_DOCREF_COLUMN.upcase,
			$TRANRECON_TABLE_DESCRIPTION_COLUMN.upcase,
			$TRANRECON_TABLE_ICT_COLUMN.upcase,
			$TRANRECON_TABLE_TLI_COLUMN.upcase,
			$TRANRECON_TABLE_CURRENCY_COLUMN.upcase,
			$TRANRECON_TABLE_AMOUNT_COLUMN.upcase
		]

		SF.tab $tab_transaction_reconciliations
		SF.click_button_new
		TRANRECON.wait_for_loading
		gen_start_test "TST019262 - Filters - Check UI elements are displayed"
		begin
			expect(TRANRECON.tab_title_equals? $TRANSACTION_RECONCILIATION_SCREEN_NAME).to eq(true)
			gen_assert_displayed $tranrecon_help_button
			gen_assert_displayed $tranrecon_maximize_button
			expect(TRANRECON.is_button_displayed? $tranrecon_auto_match_button).to be true
			expect(TRANRECON.is_button_displayed? $tranrecon_clear_matches_button).to be true
		end
		gen_end_test "TST019262 - Filters - Check UI elements are displayed"
		
		gen_start_test "TST019265 - Filters - Picklists values"
		begin
			# click on left Add Transaction button to see left filter options
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			expect(TRANRECON.picklist_values_equal? $tranrecon_left_filter, $tranrecon_company_label, AVAILABLE_COMPANIES).to eq(true)
			gen_assert_disabled $tranrecon_filters_period_picklist
			expect(TRANRECON.picklist_not_empty? $tranrecon_left_filter, $tranrecon_gla_label).to eq(true)
			TRANRECON.click_button $filter_popup_close_button
			# click on right Add Transaction button to see left filter options
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			expect(TRANRECON.picklist_values_equal? $tranrecon_right_filter, $tranrecon_company_label, AVAILABLE_COMPANIES).to eq(true)
			gen_assert_disabled $tranrecon_filters_period_picklist
			expect(TRANRECON.picklist_not_empty? $tranrecon_right_filter, $tranrecon_gla_label).to eq(true)
			TRANRECON.click_button $filter_popup_close_button
		end
		gen_end_test "TST019265 - Filters - Picklists values"
		
		gen_start_test "TST019266 - Filters - Retrieve"
		begin
		
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
			
			expect(TRANRECON.pane_company_equals? $tranrecon_left_panel, $company_merlin_auto_spain).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_left_panel, $bd_gla_account_receivable_control_eur).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_left_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_left_panel, MERLIN_AUTO_SPAIN_LINES).to eq(true)

			expect(TRANRECON.pane_company_equals? $tranrecon_right_panel, $company_merlin_auto_usa).to eq(true)
			expect(TRANRECON.pane_gla_equals? $tranrecon_right_panel, $bd_gla_account_payable_control_usd).to eq(true)
			expect(TRANRECON.pane_period_equals? $tranrecon_right_panel, CURRENT_PERIOD).to eq(true)
			expect(TRANRECON.summary_panel_total_retrieved_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.pane_lines_equal? $tranrecon_right_panel, MERLIN_AUTO_USA_LINES).to eq(true)
		end
		gen_end_test "TST019266 - Filters - Retrieve"

		gen_start_test "TST019263 - Matching - Check UI elements are displayed"
		begin
			gen_assert_displayed $tranrecon_help_button
			gen_assert_displayed $tranrecon_maximize_button
			expect(TRANRECON.tli_tables_columns_equal? $tranrecon_left_panel, TLI_TABLES_COLUMNS).to eq(true)
			expect(TRANRECON.tli_tables_columns_equal? $tranrecon_right_panel, TLI_TABLES_COLUMNS).to eq(true)
		end
		gen_end_test "TST019263 - Matching - Check UI elements are displayed"
		
		gen_start_test "TST019267 - Matching - Row selection"
		begin
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1

			expect(TRANRECON.line_selected? $tranrecon_left_table, 1, true).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -200.46).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, 100.23).to eq(true)

			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 1

			expect(TRANRECON.line_selected? $tranrecon_right_table, 1, true).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)

			TRANRECON.reconciliation_unselect_line $tranrecon_left_table, 1

			expect(TRANRECON.line_selected? $tranrecon_left_table, 1, false).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, 0.00).to eq(true)

			TRANRECON.reconciliation_unselect_line $tranrecon_right_table, 1

			expect(TRANRECON.line_selected? $tranrecon_right_table, 1, false).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 0.00).to eq(true)

			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 2
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 3
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 4

			expect(TRANRECON.line_selected? $tranrecon_left_table, 1, true).to eq(true)
			expect(TRANRECON.line_selected? $tranrecon_left_table, 2, true).to eq(true)
			expect(TRANRECON.line_selected? $tranrecon_left_table, 3, true).to eq(true)
			expect(TRANRECON.line_selected? $tranrecon_left_table, 4, true).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_left_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_left_summary_panel, -100.23).to eq(true)

			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 1

			expect(TRANRECON.line_selected? $tranrecon_right_table, 1, true).to eq(true)
			expect(TRANRECON.summary_panel_remaining_amount_equal? $tranrecon_right_summary_panel, 0.00).to eq(true)
			expect(TRANRECON.summary_panel_selected_amount_equal? $tranrecon_right_summary_panel, 100.23).to eq(true)
		end
		gen_end_test "TST019267 - Matching - Row selection"
		
		gen_start_test "TST019268 - Matching - References"
		begin
			expect(TRANRECON.line_references_equal? $tranrecon_left_table, 4, 2).to eq(true)
		end
		gen_end_test "TST019268 - Matching - References"
		
		gen_start_test "TST019269 - Company validations"
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain], true
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			expect(TRANRECON.picklist_values_equal? $tranrecon_left_filter, $tranrecon_company_label, [$company_merlin_auto_spain]).to eq(true)
			TRANRECON.click_button $filter_popup_close_button
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			expect(TRANRECON.picklist_values_equal? $tranrecon_right_filter, $tranrecon_company_label, [$company_merlin_auto_spain]).to eq(true)
			TRANRECON.click_button $filter_popup_close_button
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa], true
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			expect(TRANRECON.picklist_values_equal? $tranrecon_left_filter, $tranrecon_company_label, [$company_merlin_auto_spain, $company_merlin_auto_usa]).to eq(true)
			TRANRECON.click_button $filter_popup_close_button
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			expect(TRANRECON.picklist_values_equal? $tranrecon_right_filter, $tranrecon_company_label, [$company_merlin_auto_spain, $company_merlin_auto_usa]).to eq(true)
			TRANRECON.click_button $filter_popup_close_button
			
			SF.tab $tab_select_company
			FFA.deselect_all_companies
			SF.tab $tab_transaction_reconciliations

			expect(TRANRECON.no_companies?).to eq(true)
		end
		gen_end_test "TST019269 - Company validations"
		gen_end_test "TID014296"
	end
	
	after(:all) do
		login_user
		SF.retry_script_block do
			delete_data = [ "CODATID014296Data.destroyData();"]				
			APEX.execute_commands delete_data
		end
		# Restore previous environment variables.
		Capybara.default_wait_time = $current_default_wait_time
		Capybara.ignore_hidden_elements = $current_ignore_hidden
		FFA.delete_new_data_and_wait
		SF.logout
	end
end
