#--------------------------------------------------------------------#
#	TID : TID020874
#	Pre-Requisite: Org with basedata deployed.
#	Product Area: Transaction Reconciliation
#--------------------------------------------------------------------#
describe "TID020874 - Verify the Transaction Reconciliation Unreconcile Process.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		FFA.hold_base_data_and_wait
	end
	_TID020874_TR1 = "TID020874TR2"
	it "Verifies the Transaction Reconciliation Unreconcile process." , :unmanaged => true do
		begin
			_create_data = ["CODATID020848Data.selectCompany();", "CODATID020848Data.createData();", "CODATID020848Data.createDataExt1();", "CODATID020848Data.createDataExt2();", "CODATID020848Data.createDataExt3();", "CODATID020848Data.createDataExt4();", "CODATID020848Data.createDataExt5();"]
			APEX.execute_commands _create_data
			SF.wait_for_apex_job
		end
		# select Merlin Auto Spain and Merlin Auto USA for transaction reconciliation process.
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa], true
		begin
			gen_start_test "TST035156 - Verify that user is able to unreconcile those transaction reconcile record with status reconciled."
			# Step 1. Go to Transaction Reconciliations tab, click on new button
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			# Step 2. Select valid filters and click on retrieve button, verify expected.
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_sales_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_usd
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			# Now select a line from each panel with same amount (having different signs) and verify 
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_left_table
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_right_table
			TRANRECON.click_button $tranrecon_reconcile_button
			TRANRECON.wait_for_loading
			TRANRECON.set_popup_field $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _TID020874_TR1
			TRANRECON.set_popup_field $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _TID020874_TR1
			TRANRECON.click_button $tranrecon_reconcile_popup_reconcile_button
			TRANRECON.wait_for_loading
			TRANRECON.wait_for_list_view
			_tr2_status = TRANRECON.get_tr_status_from_list_view _TID020874_TR1
			_tr2_number = TRANRECON.get_transaction_reconciliation_number_from_list_view _TID020874_TR1
			gen_compare $tranrecon_reconciled_label, _tr2_status, "Status matched on list view."
			# Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID020874_TR1
			TRANRECON.wait_for_loading
			# Unreconcile button is disabled with 0 selected lines.
			expect(TRANRECON.is_button_disabled? $tranrecon_unreconcile_button).to be true
			gen_report_test "Unreconcile button is disabled "
			# Unreconcile button is disbabled when the lines from single side is selected.
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_left_table
			expect(TRANRECON.is_button_disabled? $tranrecon_unreconcile_button).to be true
			gen_report_test "Unreconcile button is disabled "
			# Unreconcile button is disabled when amount of selected lines in both tables does not balance.
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_left_table
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 1
			expect(TRANRECON.is_button_disabled? $tranrecon_unreconcile_button).to be true
			gen_report_test "Unreconcile button is disabled "
			# Unreconcile button is enabled when the amount of selected lines in both tables balances.
			TRANRECON.reconciliation_unselect_line $tranrecon_right_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 2
			expect(TRANRECON.is_button_disabled? $tranrecon_unreconcile_button).to be false
			gen_report_test "Unreconcile button is enabled now"
			# Click Unreconcile button and verify the info message being shown.
			TRANRECON.click_button $tranrecon_unreconcile_button
			_expected_unreconcile_popup_info_message = "You are about to unreconcile 2 transactions."# Merlin Auto Spain: 1 transactions totalling 100 Merlin Auto USA: 1 transactions totalling -100 Balance: 0"
			_actual_unreconcile_popup_info_message = TRANRECON.get_popup_info_message $tranrecon_unreconcile_popup_title
			gen_compare _expected_unreconcile_popup_info_message, _actual_unreconcile_popup_info_message, "TST035156 - Verify info message in Unreconcile popup"
			TRANRECON.click_button $tranrecon_save_or_reconcile_popup_cancel_button
			# Verify that already reconciled lines are not fetched in new Reconciliations.
			TRANRECON.click_button $tranrecon_back_to_list_button
			TRANRECON.wait_for_list_view
			# create new transaction reconciliation.
			SF.click_button_new
			TRANRECON.wait_for_loading
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_sales_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_usd
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			expect(TRANRECON.any_results_found_in_table? $tranrecon_left_table).to be true
			gen_report_test "No results Found in left table"
			expect(TRANRECON.any_results_found_in_table? $tranrecon_right_table).to be true
			gen_report_test "No results Found in Right table"
			# Unreconcile the above reconciled Reconciliation and check that uncreconciled lines are now avaiable to be retrieved.
			TRANRECON.click_button $tranrecon_back_to_list_button
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID020874_TR1
			TRANRECON.wait_for_loading
			# Select all rows to unreconcile
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_left_table
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_right_table
			_left_table_row1_tli = TRANRECON.get_grid_column_value $tranrecon_left_table, 1, $tranrecon_tli_column_header_label
			_left_table_row2_tli = TRANRECON.get_grid_column_value $tranrecon_left_table, 2, $tranrecon_tli_column_header_label
			_right_table_row1_tli = TRANRECON.get_grid_column_value $tranrecon_right_table, 1, $tranrecon_tli_column_header_label
			_right_table_row2_tli = TRANRECON.get_grid_column_value $tranrecon_right_table, 2, $tranrecon_tli_column_header_label
			TRANRECON.click_button $tranrecon_unreconcile_button
			TRANRECON.click_button $tranrecon_unreconcile_popup_unreconcile_button
			TRANRECON.wait_for_loading
			TRANRECON.wait_for_list_view
			# Check that no lines are avaiable in exisitng reconciliation
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID020874_TR1
			TRANRECON.wait_for_loading
			expect(TRANRECON.any_results_found_in_table? $tranrecon_left_table).to be true
			gen_report_test "No results Found in left table"
			expect(TRANRECON.any_results_found_in_table? $tranrecon_right_table).to be true
			gen_report_test "No results Found in Right table"
			TRANRECON.click_button $tranrecon_back_to_list_button
			# Create new TR and check that now the lines are retrieved.
			SF.click_button_new
			TRANRECON.wait_for_loading
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_sales_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_usd
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			_retrieved_left_table_row1_tli = TRANRECON.get_grid_column_value $tranrecon_left_table, 1, $tranrecon_tli_column_header_label
			_retrieved_left_table_row2_tli = TRANRECON.get_grid_column_value $tranrecon_left_table, 2, $tranrecon_tli_column_header_label
			_retrieved_right_table_row1_tli = TRANRECON.get_grid_column_value $tranrecon_right_table, 1, $tranrecon_tli_column_header_label
			_retrieved_right_table_row2_tli = TRANRECON.get_grid_column_value $tranrecon_right_table, 2, $tranrecon_tli_column_header_label
			gen_compare _left_table_row1_tli, _retrieved_left_table_row1_tli, "Compare retrieved line in left table row 1"
			gen_compare _left_table_row2_tli, _retrieved_left_table_row2_tli, "Compare retrieved line in left table row 2"
			gen_compare _right_table_row1_tli, _retrieved_right_table_row1_tli, "Compare retrieved line in Right table row 1"
			gen_compare _right_table_row2_tli, _retrieved_right_table_row2_tli, "Compare retrieved line in Right table row 2"
			gen_end_test "TST035156 - Verify that user is able to unreconcile those transaction reconcile record with status reconciled."
		end
	end
	
	after :all do
		login_user
		#Delete Test Data
		_destroy_data = ["CODATID020848Data.destroyData();"]
		APEX.execute_commands _destroy_data
		FFA.delete_new_data_and_wait
		SF.logout
	end
end