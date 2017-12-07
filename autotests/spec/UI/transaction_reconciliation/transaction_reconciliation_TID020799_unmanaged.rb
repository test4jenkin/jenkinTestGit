#--------------------------------------------------------------------#
#	TID : TID020799
#	Pre-Requisit: Org with basedata deployed.
#	Product Area: Transaction Recon
#--------------------------------------------------------------------#
describe "TID020799 - TID verifies Transaction Reconciliation Save process.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		FFA.hold_base_data_and_wait
	end
	_transaction_reconciliation1_name = "TR1"
	_transaction_reconciliation2_name = "TR2"
	_tr1_number = ""
	_tr1_status = ""		
	it "Create data for the test, save the transaction reconciliation", :unmanaged => true do
		# Constants being used in TID.
		_gmt_offset = gen_get_current_user_gmt_offset
		_today = gen_get_current_date _gmt_offset
		_today_date = gen_locale_format_date _today, gen_get_current_user_locale
		begin
			_create_data = ["CODATID020799Data.selectCompany();", "CODATID020799Data.createData();", "CODATID020799Data.createDataExt1();", "CODATID020799Data.createDataExt2();", "CODATID020799Data.createDataExt3();", "CODATID020799Data.createDataExt4();", "CODATID020799Data.createDataExt5();"]
			APEX.execute_commands _create_data
			SF.wait_for_apex_job
		end
		# select Merlin Auto Spain and Merlin Auto USA for transaction reconciliation process.
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa], true
		gen_start_test "TST034909 - Verify that on Save a new Transaction Reconciliation Record is marked as Draft and checked lines become proposed." 
		begin
			# Step 1
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			# Verify that - Save Draft and Reconcile buttons are disabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_save_button).to be true
			gen_report_test "expect Save draft disabled "
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "expect Reconcile button disabled "
			# Step 2 set field in Left lable
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_sales_parts
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			# Step 2 set field in right panel
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_account_receivable_control_usd
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			# click button retrieve
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			# Verify that Save/Reconcile buttons are disabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_save_button).to be true
			gen_report_test "expect Save draft button disabled "
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "expect Reconcile button is disabled "
			# Step 3 Select some lines from left panel
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 2
			# Verify that Save/Reconcile button are still disabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_save_button).to be true
			gen_report_test "expect Save draft button is disabled "
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "expect Reconcile button is disabled "
			# Step 4 Now select 1 positive line from left as well as one positive line from right side, unselect negative line from left panel
			TRANRECON.reconciliation_unselect_line $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 2
			# Verify that save button is enabled now but reconcile button is still disabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_save_button).to be false
			gen_report_test "expect Save Draft button is enabled "
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be true
			gen_report_test "expect Reconcile button is disabled "
			# Step 5 click on Save Draft button
			TRANRECON.click_button $tranrecon_save_button
			# Verify popup is present with info message
			_save_info_message = TRANRECON.get_popup_info_message $tranrecon_save_popup_title
			gen_compare $tranrecon_save_popup_info_message, _save_info_message, "TST034909 - Verify info message in Save popup passed"
			# Save Draft button in popup is disabled, Name and Description fields are blank
			expect(TRANRECON.is_button_disabled? $tranrecon_save_popup_save_button).to be true
			gen_report_test "expect Save button in save popup is disabled "
			_save_popup_name_value = TRANRECON.get_popup_field_value $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_name_field
			_save_popup_description_value = TRANRECON.get_popup_field_value $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_description_field
			gen_compare "", _save_popup_name_value, "TST034909 - Verify Name field is blank in Save popup passed"
			gen_compare "", _save_popup_description_value, "TST034909 - Verify Decription field is blank in Save popup passed"
			# Step 6 click on Close button in Save Draft popup
			TRANRECON.click_button $tranrecon_save_or_reconcile_popup_cancel_button
			# Verify that Save Draft popup is closed now.
			expect(TRANRECON.is_popup_present? $tranrecon_save_popup_title).to be false
			gen_report_test "expect Save Draft popup is closed "
			# Step 7 Click on Save Draft button and fill Name and Description field with appropriate values and click on Save Draft button.
			TRANRECON.click_button $tranrecon_save_button
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _transaction_reconciliation1_name
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _transaction_reconciliation1_name
			TRANRECON.click_button $tranrecon_save_popup_save_button
			TRANRECON.wait_for_loading
			# Verify that Save Draft popup is closed now. and filter and retrieved buttons are disabled.
			expect(TRANRECON.is_popup_present? $tranrecon_save_popup_title).to be false
			gen_report_test "Save popup is not present"
			# Step 8 - Verify selected line information.
			# Click on line
			TRANRECON.click_tli_in_a_grid $tranrecon_left_table, 2
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				gen_compare $tranrecon_proposed_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_proposed_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
			end	
			# Check information on selected TLI in right table
			TRANRECON.click_tli_in_a_grid $tranrecon_right_table, 2
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				gen_compare $tranrecon_proposed_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_proposed_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
			end	
			
			# Step 9 - Verify Unchecked lines
			TRANRECON.click_tli_in_a_grid $tranrecon_left_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, false
				gen_compare "", _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected."
				gen_compare "", _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected."
				gen_compare "", _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end	
			# Check information on  TLI in right table
			TRANRECON.click_tli_in_a_grid $tranrecon_right_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, false
				gen_compare "", _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected."
				gen_compare "", _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected."
				gen_compare "", _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end	
			# Step 10 - Go to list view and check transaction reconciliation status
			TRANRECON.click_button $tranrecon_back_to_list_button
			TRANRECON.wait_for_list_view
			_tr1_status = TRANRECON.get_tr_status_from_list_view _transaction_reconciliation1_name
			_tr1_number = TRANRECON.get_transaction_reconciliation_number_from_list_view _transaction_reconciliation1_name
			gen_compare $tranrecon_draft_label, _tr1_status, "Status matched on list view."
			# Step 11 - Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _transaction_reconciliation1_name
			TRANRECON.wait_for_loading
			TRANRECON.click_tli_in_a_grid $tranrecon_left_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_proposed_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_proposed_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr1_number, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end	
			# Check information on TLI in right table
			TRANRECON.click_tli_in_a_grid $tranrecon_right_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_proposed_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_proposed_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr1_number, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end
			gen_end_test "TST034909 - Verify that on Save a new Transaction Reconciliation Record is marked as Draft and checked lines become proposed."
		end

		gen_start_test "TST034960 - Verify the Transaction Reconciliation Information on TLIs on Saving a Draft Status Transaction Reconciliation record." 
		begin
			# Step 1 - Go to a Transaction Reconciliation record with Draft status.
			SF.tab $tab_transaction_reconciliations
			SF.click_button_go
			TRANRECON.go_to_transaction_reconciliation_from_list_view _transaction_reconciliation1_name
			TRANRECON.wait_for_loading
			# Step 2 - Uncheck some already checked lines, check new lines, Unchecked first line in Left table, checked second line in Left table, 1 and 2 lines in Right table remained checked and unchecked respectivly.
			TRANRECON.reconciliation_unselect_line $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 2
			# Step 3 - Save the Transaction Reconciliation record and verify the new saved lines
			TRANRECON.click_button $tranrecon_save_button
			TRANRECON.click_button $tranrecon_save_popup_save_button
			TRANRECON.wait_for_loading
			# Check checked lines.
			TRANRECON.click_tli_in_a_grid $tranrecon_left_table, 2
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_proposed_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_proposed_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr1_number, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end	
			# Check information on TLI in right table
			TRANRECON.click_tli_in_a_grid $tranrecon_right_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, true
				gen_compare $tranrecon_proposed_label, _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected - #{$tranrecon_proposed_label}."
				gen_compare _today_date, _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected - #{_today_date}."
				gen_compare _tr1_number, _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end
			#Verify Unchecked lines
			TRANRECON.click_tli_in_a_grid $tranrecon_left_table, 1
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, false
				gen_compare "", _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected."
				gen_compare "", _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected."
				gen_compare "", _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end	
			# Check information on  TLI in right table
			TRANRECON.click_tli_in_a_grid $tranrecon_right_table, 2
			# Verify transaction reconciliation information on TLIs
			FFA.new_window do
				gen_wait_until_object $tranrecon_tli_header_2_text
				_transaction_reconciliation_status = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_status, false
				_transaction_reconciliation_date = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation_date, false
				_transaction_reconciliation = TRANRECON.get_tli_field_value $tranrecon_tli_transaction_reconciliation, false
				gen_compare "", _transaction_reconciliation_status, "#{$tranrecon_tli_transaction_reconciliation_status} filed value is found as expected."
				gen_compare "", _transaction_reconciliation_date, "#{$tranrecon_tli_transaction_reconciliation_date} filed value is found as expected."
				gen_compare "", _transaction_reconciliation, "#{$tranrecon_tli_transaction_reconciliation} filed value is found as expected."
			end
			TRANRECON.click_button $tranrecon_back_to_list_button
			TRANRECON.wait_for_list_view
			_tr1_status = TRANRECON.get_tr_status_from_list_view _transaction_reconciliation1_name
			gen_compare $tranrecon_draft_label, _tr1_status, "Status matched on list view."
			gen_end_test "TST034960 - Verify the Transaction Reconciliation Information on TLIs on Saving a Draft Status Transaction Reconciliation record."
		end	
	end
	
	after :all do
		login_user
		#Delete Test Data
		_destroy_data = ["CODATID020799Data.destroyData();"]
		APEX.execute_commands _destroy_data
		FFA.delete_new_data_and_wait
		SF.logout
	end
end
