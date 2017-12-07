#--------------------------------------------------------------------#
#	TID : TID021088
# 	Pre-Requisit: org with base data and deploy CODATID021088Data.cls on org
#  	Product Area: Accounting - Transaction Reconciliation
# 	Story: AC-2234
#--------------------------------------------------------------------#

describe "TID021088 - Verify the volume for Transaction Reconciliations", :type => :request do
	include_context "login"
	
	before :all do
		#Hold Base Data
		gen_start_test  "TID021088-Volume Support for Transaction Reconciliation"
		FFA.hold_base_data_and_wait
	end
	_TID021088_TR1 = "TID021088TR1"
	_from_GLA = "VolumeAccGLA1"
	_to_GLA = "VolumeProdGLA999"
	_from_Period_left = "2013/001"
	_to_Period_left = "2015/006"
	_from_Period_right = "2015/007"
	_to_Period_right = "2017/012"
	_tr1_status = ""
	it "Execute Script as Admin user , Post Sales Invoices and Payable Invoices " do
		begin
			#"Execute Script as Admin user" 
			create_data = [ "CODATID021088Data.selectCompany();",
				"CODATID021088Data.createData();"]
				APEX.execute_commands create_data
				
			create_sales_invoices = ["CODATID021088Data.createDataExt1();",
				"CODATID021088Data.createDataExt2();",
				"CODATID021088Data.createSalesInvoice(0,0,5,Date.newInstance(2013, 1, 1));",
				"CODATID021088Data.createSalesInvoice(395,5,10,Date.newInstance(2013, 6, 1));",
				"CODATID021088Data.createSalesInvoice(790,10,15,Date.newInstance(2013, 11, 1));",
				"CODATID021088Data.createSalesInvoice(1185,15,20,Date.newInstance(2014, 4, 1));",
				"CODATID021088Data.createSalesInvoice(1580,20,25,Date.newInstance(2014, 9, 1));",
				"CODATID021088Data.createSalesInvoice(1975,25,30,Date.newInstance(2015, 2, 1));"]
				APEX.execute_commands create_sales_invoices
			
			post_sales_invoices = ["CODATID021088Data.postSalesInvoices(5);",
				"CODATID021088Data.postSalesInvoices(5);",
				"CODATID021088Data.postSalesInvoices(5);",
				"CODATID021088Data.postSalesInvoices(5);",
				"CODATID021088Data.postSalesInvoices(5);",
				"CODATID021088Data.postSalesInvoices(5);"]
				APEX.execute_commands post_sales_invoices
				
			create_payable_invoices = ["CODATID021088Data.createDataExt3();",
				"CODATID021088Data.createPinvs(0,0,10,Date.newInstance(2015, 7, 1));",
				"CODATID021088Data.createPinvs(790,10,20,Date.newInstance(2016, 5, 1));",
				"CODATID021088Data.createPinvs(1580,20,30,Date.newInstance(2017, 3, 1));"]
				APEX.execute_commands create_payable_invoices	
				
			post_payable_invoices = ["CODATID021088Data.postPurchaseInvoices(10);",
				"CODATID021088Data.postPurchaseInvoices(10);",
				"CODATID021088Data.postPurchaseInvoices(10);"]
				APEX.execute_commands post_payable_invoices
			#wait for apex jobs to complete
			SF.wait_for_apex_job
		end
		
		# select Merlin Auto Spain and Merlin Auto GB for transaction reconciliation process.
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_gb], true
		test_step "TST036022 - Verify that the Transaction lines with 2000 TLIs are reconciled and unreconciled" do
		# Step 1
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			# Select TLIs in left panel
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.click_gla_filter_fromto_button $tranrecon_left_filter
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_from_label, _from_GLA
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_to_label, _to_GLA
			TRANRECON.click_period_filter_fromto_button $tranrecon_left_filter
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_period_from_label, _from_Period_left
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_period_to_label, _to_Period_left
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_gb
			TRANRECON.click_gla_filter_fromto_button $tranrecon_right_filter
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_from_label, _from_GLA
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_to_label, _to_GLA
			TRANRECON.click_period_filter_fromto_button $tranrecon_right_filter
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_period_from_label, _from_Period_right
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_period_to_label, _to_Period_right
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
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_name_field, _TID021088_TR1
			TRANRECON.set_popup_field $tranrecon_save_popup_title, $tranrecon_save_or_reconcile_popup_description_field, _TID021088_TR1
			TRANRECON.click_button $tranrecon_save_popup_save_button
			TRANRECON.wait_for_loading
			#####verify the popup message on running the batch
			_success_message_after_running_batch = "The Transaction Reconciliation process has started. You will receive an email when it is complete."
			gen_compare _success_message_after_running_batch,FFA.get_sencha_popup_success_message,"Save Draft - Comparing the popup message on running batch"
			TRANRECON.click_continue_button 
			TRANRECON.wait_for_list_view
			_tr1_status = TRANRECON.get_tr_status_from_list_view _TID021088_TR1
			gen_compare $tranrecon_inprogress_label, _tr1_status, "Save Draft - Status matched on list view before batch completion."
			SF.wait_for_apex_job
			SF.tab $tab_transaction_reconciliations
			SF.click_button_go
			TRANRECON.wait_for_list_view
			TRANRECON.wait_for_loading
			_tr1_status = TRANRECON.get_tr_status_from_list_view _TID021088_TR1
			gen_compare $tranrecon_draft_label, _tr1_status, "Save Draft - Status matched on list view after batch completion."
			
			# Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID021088_TR1
			TRANRECON.wait_for_loading
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_button).to be false
			gen_report_test "Reconcile button is enabled "
			gen_wait_until_object_disappear $page_loadmask_message
			# Click on Reconcile popup and verify expected.
			TRANRECON.click_button $tranrecon_reconcile_button
			# Verify popup is present with info message
			_reconcile_info_message_actual_TST036022 = TRANRECON.get_popup_info_message $tranrecon_reconcile_popup_title
			puts _reconcile_info_message_actual_TST036022
			gen_compare $tranrecon_reconcile_pop_info_message_expected.sub($sf_param_substitute,"4800"), _reconcile_info_message_actual_TST036022, "TST036022 - Verify info message in Reconcile popup"

			# Reconcile button in popup is enabled
			expect(TRANRECON.is_button_disabled? $tranrecon_reconcile_popup_reconcile_button).to be false
			gen_report_test "Reconcile button in reconcile popup is enabled "
			TRANRECON.click_button $tranrecon_reconcile_popup_reconcile_button
			TRANRECON.wait_for_loading
			#####verify the popup message on running the batch
			gen_compare _success_message_after_running_batch,FFA.get_sencha_popup_success_message,"Reconcile - Comparing the popup message on running batch"
			TRANRECON.click_continue_button 
			TRANRECON.wait_for_list_view
			_tr1_status_TST036022 = TRANRECON.get_tr_status_from_list_view _TID021088_TR1
			gen_compare $tranrecon_reconciling_label, _tr1_status_TST036022, "Reconcile - Status matched on list view before batch complete."
			SF.wait_for_apex_job
			SF.tab $tab_transaction_reconciliations
			SF.click_button_go
			TRANRECON.wait_for_list_view
			TRANRECON.wait_for_loading
			_tr1_status_TST036022 = TRANRECON.get_tr_status_from_list_view _TID021088_TR1
			gen_compare $tranrecon_reconciled_label, _tr1_status_TST036022, "Reconcile - Status matched on list view after batch complete."
			
			# Go to detail page of Transaction Reconciliation record.
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID021088_TR1
			TRANRECON.wait_for_loading
			gen_wait_until_object_disappear $page_loadmask_message
			
			# Select all lines from left and right grids
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_left_table
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_right_table
			TRANRECON.click_on_column_header $tranrecon_right_table,$tranrecon_amount_header_column_name
			TRANRECON.reconciliation_unselect_line $tranrecon_left_table,1
			TRANRECON.reconciliation_unselect_line $tranrecon_left_table,2
			TRANRECON.reconciliation_unselect_line $tranrecon_right_table,1
			TRANRECON.reconciliation_unselect_line $tranrecon_right_table,2
			expect(TRANRECON.is_button_disabled? $tranrecon_unreconcile_button).to be false
			gen_report_test "Unreconcile button is enabled now"
			
			# Click Unreconcile button and verify the info message being shown.
			TRANRECON.click_button $tranrecon_unreconcile_button
			_actual_unreconcile_popup_info_message = TRANRECON.get_popup_info_message $tranrecon_unreconcile_popup_title
			gen_compare $tranrecon_partial_unreconcile_pop_info_message_expected.sub($sf_param_substitute,"4796"), _actual_unreconcile_popup_info_message, "TST036022 - Verify info message in Unreconcile popup"
			TRANRECON.click_button $tranrecon_unreconcile_popup_unreconcile_button
			TRANRECON.wait_for_loading
			#####verify the popup message on running the batch
			gen_compare _success_message_after_running_batch,FFA.get_sencha_popup_success_message,"Partial Unreconcile - Comparing the popup message on running batch"
			TRANRECON.click_continue_button 
			TRANRECON.wait_for_list_view
			_tr1_status_TST036022 = TRANRECON.get_tr_status_from_list_view _TID021088_TR1
			gen_compare $tranrecon_unreconciling_label, _tr1_status_TST036022, "Partial Unreconcile - Status matched on list view before batch complete."
			SF.wait_for_apex_job
			SF.tab $tab_transaction_reconciliations
			SF.click_button_go
			TRANRECON.wait_for_list_view
			TRANRECON.wait_for_loading
			_tr1_status_TST036022 = TRANRECON.get_tr_status_from_list_view _TID021088_TR1
			gen_compare $tranrecon_reconciled_label, _tr1_status_TST036022, "Partial Unreconcile - Status matched on list view after batch complete."
			SF.tab $tab_transaction_reconciliations
			SF.click_button_go
			TRANRECON.wait_for_list_view
			#unreconcile the remaining tlis
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID021088_TR1
			TRANRECON.wait_for_loading
			gen_wait_until_object_disappear $page_loadmask_message
			# Select all remaining lines from left and right grids
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_left_table
			TRANRECON.select_all_rows_for_reconciliation $tranrecon_right_table
			expect(TRANRECON.is_button_disabled? $tranrecon_unreconcile_button).to be false
			TRANRECON.click_button $tranrecon_unreconcile_button
			_actual_unreconcile_popup_info_message = TRANRECON.get_popup_info_message $tranrecon_unreconcile_popup_title
			gen_compare $tranrecon_unreconcile_pop_info_message_expected.sub($sf_param_substitute,"4"), _actual_unreconcile_popup_info_message, "TST036022 - Verify info message in Unreconcile popup"
			TRANRECON.click_button $tranrecon_unreconcile_popup_unreconcile_button
			TRANRECON.wait_for_loading
			TRANRECON.wait_for_list_view
			_tr1_status_TST036022 = TRANRECON.get_tr_status_from_list_view _TID021088_TR1
			gen_compare $tranrecon_unreconciled_label, _tr1_status_TST036022, "Unreconcile - Status matched on list view."
			
			# Check that no lines are avaiable in exisitng reconciliation
			TRANRECON.go_to_transaction_reconciliation_from_list_view _TID021088_TR1
			TRANRECON.wait_for_loading
			gen_wait_until_object_disappear $page_loadmask_message
			expect(TRANRECON.any_results_found_in_table? $tranrecon_left_table).to be true
			gen_report_test "No results Found in left table"
			expect(TRANRECON.any_results_found_in_table? $tranrecon_right_table).to be true
			gen_report_test "No results Found in Right table"
			TRANRECON.click_button $tranrecon_back_to_list_button
			gen_end_test "TST036022 - Verify that user is able to unreconcile those transaction reconcile record with status reconciled."
			SF.logout
		end
	end
	after :all do
		login_user
		#Delete Test Data
		SF.retry_script_block do
			delete_data = [ "CODATID021088Data.destroyData();",
							"CODATID021088Data.destroyDataExt1();"]				
			APEX.execute_commands delete_data
		end	
		gen_end_test "TID021088-Volume Support for Transaction Reconciliation"	
	end
end
