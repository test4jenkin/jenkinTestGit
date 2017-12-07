#--------------------------------------------------------------------#
#	TID : TID020947
#	Pre-Requisite: Org with basedata deployed.
#	Product Area: Transaction Recon
#   driver= firefox rspec spec/UI/transaction_reconciliation/transaction_reconciliation_TID020947.rb -fh -o recon_ext.html
#   profile = firefox_profile1
#   OS_TYPE = windows
#--------------------------------------------------------------------#
describe "TID020947 - TID verifies that user is able to export transaction reconciliation to another source", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		gen_start_test "TID020947: TID verifies that user is able to export transaction reconciliation to another source."
		FFA.hold_base_data_and_wait
	end
	_transaction_reconciliation1_name = "TR1"
	_transaction_reconciliation2_name = "TR2"
	_tr1_number = ""
	_tr1_status = ""	
	XLS_TYPE_FILES = ".xls"
	
	it "Create data for the test, save the transaction reconciliation", :unmanaged => true  do
	
	# select Merlin Auto Spain for transaction reconciliation process.
		SF.logout
		gen_switch_to_driver $driver_firefox , FIREFOX_PROFILE1
		gen_wait_less
		login_user
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain], true
		
		begin
			_create_data = ["CODATID020947Data.selectCompany();", "CODATID020947Data.createData();"]
			APEX.execute_commands _create_data
		end
		
		gen_start_test "TST035421 - verify that user is able to export transaction reconciliation to PDF document file."
		begin
			# Step 1
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			# Verify that - export data button is disabled on page load.
			expect(TRANRECON.is_button_disabled? $tranrecon_export_data_button).to be true
			gen_report_test "expect export data disabled "
			
			# Step 2 set field in Left lable
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_postage_and_stationery
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			# Verify that - export data button is disabled on page load.
			expect(TRANRECON.is_button_disabled? $tranrecon_export_data_button).to be true
			gen_report_test "expect export data disabled "
			
			# Step 3 Select some lines from left panel
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 2
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 2
			
			# Verify that save button is enabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_save_button).to be false
			gen_report_test "expect Save Draft button is enabled "
			
			# click on Save Draft button
			TRANRECON.click_button $tranrecon_save_button
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _transaction_reconciliation1_name
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _transaction_reconciliation1_name
			TRANRECON.click_button $tranrecon_save_popup_save_button
			TRANRECON.wait_for_loading
			
			#verify that export data button gets enabled
			expect(TRANRECON.is_button_disabled? $tranrecon_export_data_button).to be false
			gen_report_test "expect export data enabled "

			#Click on export data(.PDF) button
			TRANRECON.click_button $tranrecon_export_data_button
			TRANRECON.click_adobe_pdf_export_data_button
			FFA.new_window do
				page.has_text?("TR1 Reconciliation Name")
				page.has_text?("1 Number of Left Transactions")
				expect(page).to have_content("TR1 Reconciliation Name")
				gen_report_test "Reconciliation name matched : - Passed"
				expect(page).to have_content("TR1 Reconciliation Description")
				gen_report_test "Reconciliation description matched : - Passed"
				expect(page).to have_content("Draft Reconciliation Status")
				gen_report_test "Reconciliation Status matched : - Passed"
				expect(page).to have_content("1 Number of Left Transactions")
				gen_report_test "Number of Left Reconciliation Transactions matched : - Passed"
				expect(page).to have_content("1 Number of Right Transactions")
				gen_report_test "Number of Right Reconciliation Transactions matched : - Passed"
				expect(page).to have_content("-522.50 Left Reconciled Total")
				gen_report_test "Left Reconciled Total matched : - Passed"
				expect(page).to have_content("400.00 Right Reconciled Total")
				gen_report_test "Right Reconciled Total matched : - Passed"
			end
		end	
		gen_end_test "TST035421 - verify that user is able to export transaction reconciliation to PDF document file."

		gen_start_test "TST035422 - verify that user is able to export transaction reconciliation to XLS document file."
		begin
			# Step 1
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			# Verify that - export data button is disabled on page load.
			expect(TRANRECON.is_button_disabled? $tranrecon_export_data_button).to be true
			gen_report_test "expect export data disabled "
			
			# Step 2 set field in Left lable
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_account_payable_control_eur
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_stock_parts
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_postage_and_stationery
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			# Verify that - export data button is disabled on page load.
			expect(TRANRECON.is_button_disabled? $tranrecon_export_data_button).to be true
			gen_report_test "expect export data disabled "
			
			# Step 3 Select some lines from left panel
			TRANRECON.select_row_for_reconciliation $tranrecon_left_table, 1
			TRANRECON.select_row_for_reconciliation $tranrecon_right_table, 1
			
			# Verify that save button is enabled.
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be false
			gen_report_test "expect Save Draft button is enabled "
			
			# click on Save Draft button
			TRANRECON.click_button $tranrecon_reconcile_button
			TRANRECON.set_popup_field $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _transaction_reconciliation2_name
			TRANRECON.set_popup_field $tranrecon_reconcile_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _transaction_reconciliation2_name
			TRANRECON.click_button $tranrecon_reconcile_popup_reconcile_button
			TRANRECON.wait_for_loading
			TRANRECON.wait_for_loading
			TRANRECON.wait_for_list_view
			_tr2_status = TRANRECON.get_tr_status_from_list_view _transaction_reconciliation2_name
			_tr2_number = TRANRECON.get_transaction_reconciliation_number_from_list_view _transaction_reconciliation2_name
			gen_compare $tranrecon_reconciled_label, _tr2_status, "Status matched on list view."
			
			#Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _transaction_reconciliation2_name
			TRANRECON.wait_for_loading
			
			#verify that export data button gets enabled
			expect(TRANRECON.is_button_disabled? $tranrecon_export_data_button).to be false
			gen_report_test "expect export data enabled "
			
			_number_of_excel_files_before = (gen_downloaded_files_names XLS_TYPE_FILES).count

			#Click on export data(.XLS) button
			TRANRECON.click_button $tranrecon_export_data_button
			TRANRECON.click_microsoft_excel_export_data_button
			
			_number_of_excel_files_after = (gen_downloaded_files_names XLS_TYPE_FILES).count
			
			# Compare the number of xls files created
			gen_compare _number_of_excel_files_before+1, _number_of_excel_files_after, "Comparing number of xls files before and after "
			gen_end_test "TST035422 - verify that user is able to export transaction reconciliation to XLS document file."
		end
	end	
	
	after :all do
		gen_switch_to_driver DRIVER , BROWSER_PROFILE
		login_user
		# Delete Test Data
		_delete_data = ["CODATID020947Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		# delete all newly downloaded files
		root_path = Dir.pwd
		if OS_TYPE == OS_WINDOWS
			file_path = root_path+$upload_file_path
			filepath = file_path.gsub("/", "\\")
		else
			filepath = root_path+$upload_file_path
		end	
		Dir.chdir(filepath)
		Dir.foreach(filepath) do |file_name|
			if file_name.include? "Transaction_Reconcilation"
				File.delete(file_name)
				puts 'Deleting '+file_name
			end	
		end
		Dir.chdir(root_path)
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID020947: TID verifies that user is able to export transaction reconciliation to another source."
	end
end
