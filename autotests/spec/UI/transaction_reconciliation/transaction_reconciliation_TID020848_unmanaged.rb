#--------------------------------------------------------------------#
#	TID : TID020848
#	Pre-Requisit: Org with basedata deployed.
#	Product Area: Transaction Recon
#--------------------------------------------------------------------#
describe "TID020848 - Verify the Transaction Reconciliation Reconcile Process.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		FFA.hold_base_data_and_wait
	end
	_TID020848_TR2 = "TID020848TR1"
	_TID020848_TR1 = "TID020848TR2"
	_tr1_number = ""
	_tr1_status = ""
	_TST035077_sencha_popup_error_message = "You cannot select the same transaction line on both sides for reconciliation."	
	it "Create data for the test, Reconcile the transaction reconciliation", :unmanaged => true do
		# Constants being used in TID.
		_gmt_offset = gen_get_current_user_gmt_offset
		_today = gen_get_current_date _gmt_offset
		_today_date = gen_locale_format_date _today, gen_get_current_user_locale
		begin
			_create_data = ["CODATID020848Data.selectCompany();", "CODATID020848Data.createData();", "CODATID020848Data.createDataExt1();", "CODATID020848Data.createDataExt2();", "CODATID020848Data.createDataExt3();", "CODATID020848Data.createDataExt4();", "CODATID020848Data.createDataExt5();"]
			APEX.execute_commands _create_data
			SF.wait_for_apex_job
		end
		# select Merlin Auto Spain and Merlin Auto USA for transaction reconciliation process.
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa], true
		gen_start_test "TST035077 - Verify that the Transaction lines can't be reconciled to themselves." 
		begin
			# Step 1
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			# Select same data in right and left panel
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_sales_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_sales_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			# Verify that Save/Reconcile buttons are disabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_save_button).to be true
			gen_report_test "Save Draft button is disabled "
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "Reconcile button is disabled "
			# Select all lines from left and right grids
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_left_table
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_right_table
			# Verify that Save/Reconcile button are enabled now.
			expect(TRANRECON.is_button_disabled? $tranrecon_save_button).to be false
			gen_report_test "Save Draft button is enabled "
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be false
			gen_report_test "Reconcile button is enabled "
			# Click on Save button fill Name, Description fields and click on Save Draft button in popup
			TRANRECON.click_button $tranrecon_save_button
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _TID020848_TR2
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _TID020848_TR2
			TRANRECON.click_button $tranrecon_save_popup_save_button
			TRANRECON.wait_for_loading
			gen_compare _TST035077_sencha_popup_error_message, FFA.get_sencha_popup_error_message, "Save popup, same line can't be saved - "
			FFA.sencha_popup_click_continue
			TRANRECON.click_button $tranrecon_reconcile_button
			TRANRECON.click_button $tranrecon_reconcile_popup_reconcile_button
			TRANRECON.wait_for_loading
			gen_compare _TST035077_sencha_popup_error_message, FFA.get_sencha_popup_error_message, "Reconcile popup, same line can't be saved - "
			FFA.sencha_popup_click_continue
			gen_end_test "TST035077 - Verify that the Transaction lines can't be reconciled to themselves." 
		end

		gen_start_test "TST035075 - Verify Reconcile process for new Transaction Reconciliation record." 
		begin
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
			# In Right side
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_usd
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			# Verify that Reconcile buttons is disabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "Reconcile button is disabled "
			# Checek same amount same sign lines and save.
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 1
			# Verify that Reconcile buttons is disabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "Reconcile button is disabled "
			# Step 4. deselect above selected lines and verify expected.
			TRANRECON.reconciliation_unselect_line $tranrecon_left_table, 1
			TRANRECON.reconciliation_unselect_line $tranrecon_right_table, 1
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "Reconcile button is disabled "
			#Step 5. Now select a line from each panel with same amount (having different signs) and verify 
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 2
			# Now reconcile button is enabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be false
			gen_report_test "Reconcile button is enabled "
			TRANRECON.click_button $tranrecon_reconcile_button
			# Verify popup is present with info message
			__reconcile_info_message_expected = "You are about to reconcile 2 transactions."# Merlin Auto Spain: 1 transactions totalling 100 Merlin Auto USA: 1 transactions totalling -100 Balance: 0"
			_reconcile_info_message_actual = TRANRECON.get_popup_info_message $tranrecon_reconcile_popup_title
			puts _reconcile_info_message_actual
			gen_compare __reconcile_info_message_expected, _reconcile_info_message_actual, "TST035075 - Verify info message in Reconcile popup"
			# Reconcile button in popup is disabled, Name and Description fields are blank
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_popup_reconcile_button).to be true
			gen_report_test "Reconcile button in reconcile popup is disabled "
			_reconcile_popup_name_value = TRANRECON.get_popup_field_value $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_name_field
			_reconcile_popup_description_value = TRANRECON.get_popup_field_value $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_description_field
			gen_compare "", _reconcile_popup_name_value, "TST035075 - Verify Name field is blank in Reconcile popup"
			gen_compare "", _reconcile_popup_description_value, "TST035075 - Verify Decription field is blank in Reconcile popup"
			TRANRECON.set_popup_field $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _TID020848_TR1
			TRANRECON.set_popup_field $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _TID020848_TR1
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_popup_reconcile_button).to be false
			gen_report_test "Reconcile button in reconcile popup is enabled "
			TRANRECON.click_button $tranrecon_reconcile_popup_reconcile_button
			TRANRECON.wait_for_loading
			TRANRECON.wait_for_list_view
			_tr2_status = TRANRECON.get_tr_status_from_list_view _TID020848_TR1
			_tr2_number = TRANRECON.get_transaction_reconciliation_number_from_list_view _TID020848_TR1
			gen_compare $tranrecon_reconciled_label, _tr2_status, "Status matched on list view."
			# Step 9 - Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID020848_TR1
			TRANRECON.wait_for_loading
			# Step 10 - Open the TLIs and verify
			TRANRECON.click_tli_in_a_grid $tranrecon_left_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_reconciled_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_reconciled_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr2_number, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end	
			# Check information on TLI in right table
			TRANRECON.click_tli_in_a_grid $tranrecon_right_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_reconciled_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_reconciled_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr2_number, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end
			gen_end_test "TST035075 - Verify Reconcile process for new Transaction Reconciliation record."
		end
		gen_start_test "TST035076 - Verify Reconcile process for Drafted Transaction Reconciliation record." 
		begin
			# Create a Transaction Reconciliation with Draft status
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			# Select Left filter
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_sales_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			# Select filter right side
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_usd
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			# Select rows
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 1
			TRANRECON.click_button $tranrecon_save_button
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _TID020848_TR2
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _TID020848_TR2
			TRANRECON.click_button $tranrecon_save_popup_save_button
			TRANRECON.wait_for_loading
			TRANRECON.click_button $tranrecon_back_to_list_button
			TRANRECON.wait_for_list_view
			_tr1_status = TRANRECON.get_tr_status_from_list_view _TID020848_TR2
			_tr1_number = TRANRECON.get_transaction_reconciliation_number_from_list_view _TID020848_TR2
			gen_compare $tranrecon_draft_label, _tr1_status, "Status matched on list view."
			# Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID020848_TR2
			TRANRECON.wait_for_loading
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be false
			gen_report_test "Reconcile button is enabled "
			# Click on Reconcile popup and verify expected.
			TRANRECON.click_button $tranrecon_reconcile_button
			# Verify popup is present with info message
			__reconcile_info_message_expected_TST035076 = "You are about to reconcile 2 transactions."# Merlin Auto Spain: 1 transactions totalling -100 Merlin Auto USA: 1 transactions totalling 100 Balance: 0"
			_reconcile_info_message_actual_TST035076 = TRANRECON.get_popup_info_message $tranrecon_reconcile_popup_title
			puts _reconcile_info_message_actual_TST035076
			gen_compare __reconcile_info_message_expected_TST035076, _reconcile_info_message_actual_TST035076, "TST035076 - Verify info message in Reconcile popup"
			# Reconcile button in popup is enabled
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_popup_reconcile_button).to be false
			gen_report_test "Reconcile button in reconcile popup is enabled "
			TRANRECON.click_button $tranrecon_reconcile_popup_reconcile_button
			TRANRECON.wait_for_loading
			TRANRECON.wait_for_list_view
			_tr2_status_TST035076 = TRANRECON.get_tr_status_from_list_view _TID020848_TR2
			_tr2_number_TST035076 = TRANRECON.get_transaction_reconciliation_number_from_list_view _TID020848_TR2
			gen_compare $tranrecon_reconciled_label, _tr2_status_TST035076, "Status matched on list view."
			gen_compare _tr1_number, _tr2_number_TST035076, "#{_tr1_number} saved, #{_tr2_number_TST035076} reconciled "
			#Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID020848_TR2
			TRANRECON.wait_for_loading
			# Open the TLIs and verify
			TRANRECON.click_tli_in_a_grid $tranrecon_left_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_reconciled_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_reconciled_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr2_number_TST035076, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end	
			# Check information on TLI in right table
			TRANRECON.click_tli_in_a_grid $tranrecon_right_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_reconciled_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_reconciled_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr2_number_TST035076, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end
			gen_end_test "TST035076 - Verify Reconcile process for Drafted Transaction Reconciliation record."
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

