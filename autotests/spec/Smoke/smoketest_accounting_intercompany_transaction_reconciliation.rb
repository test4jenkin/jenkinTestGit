#--------------------------------------------------------------------#
# TID : TID018057
# Pre-Requisit: Org with basedata deployed and smoke base data scripts executed.
# Product Area: Intercompany- Transaction Reconciliation.
# Story: AC-2294
#--------------------------------------------------------------------#


describe "Smoke test:Intercompany Reconciliation", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		FFA.hold_base_data_and_wait
		gen_start_test "TID018057"
	end

	it "TID018057- Intercompany Reconciliation - Auto-matching"  do
		_cashentry_line1_value="160.00"
		_cashentry_line2_value="100.00"
		_cashentry_description = "TID018057 Cash Entry"
		current_period = FFA.get_current_period
		current_date = gen_date_plus_days 0
		_next_period = FFA.get_period_by_date Date.today.next_month
		puts "Additional Data: create intercompany definition"
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_spain , $bd_gla_bank_account_deposit_us, nil , nil , $bd_dim3_usd,$bd_dim4_usd ,$bd_gla_revaluation_reserve_bs_usd ,nil , nil , $bd_dim3_usd , $bd_dim4_usd
			SF.click_button_save
			page.has_css?($icd_intercompany_definition_number)
			expect(page).to have_css($icd_intercompany_definition_number)
			gen_report_test "Expected Intercompany definition for merlin auto usa  to be created successfully."
		end
		#1.2
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_usa , $bd_gla_revaluation_reserve_bs_usd, $bd_dim1_eur , $bd_dim2_eur , $bd_dim3_eur,$bd_dim4_eur ,$bd_gla_bank_account_deposit_us ,$bd_dim1_eur , $bd_dim2_eur , $bd_dim3_eur , $bd_dim4_eur
			SF.click_button_save
			page.has_css?($icd_intercompany_definition_number)
			expect(page).to have_css($icd_intercompany_definition_number)
			gen_report_test "Expected Intercompany definition for merlin auto spain  to be created successfully."
		end
		gen_start_test "TID018057"
		begin
			puts "TST027729: 1.2 Create and Post cash entry"
			SF.tab $tab_cash_entries
			SF.click_button_new
			CE.set_bank_account $bd_bank_account_santander_current_account
			CE.set_cash_entry_description _cashentry_description
			CE.set_reference "REF1"
			CE.line_set_account_name $bd_intercompany_usa_account
			FFA.click_new_line
			CE.line_set_payment_method_value 1 ,$bd_payment_method_cash
			CE.line_set_cashentryvalue 1,_cashentry_line1_value
			# Add2 line
			CE.line_set_account_name $bd_account_fastfit_ltd
			FFA.click_new_line
			CE.line_set_payment_method_value 2 ,$bd_payment_method_cash
			CE.line_set_cashentryvalue 2,_cashentry_line2_value
			FFA.click_save_post
			page.has_text?($bd_document_status_complete)
			cashentry_number = CE.get_cash_entry_number
			gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "TST027729: Expected cash entry status to be complete"
		end
		begin
			puts "TST027729: 1.3,1.4,1.5.:Start Processing of Intercompany Transfer and post new cash entry created."
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			FFA.click_edit_link_on_list_gird $label_ict_source_document_description , _cashentry_description
			ICT.set_destination_document_bank_account $bd_bank_account_bristol_checking_account , $company_merlin_auto_usa
			SF.click_button_save
			SF.select_view $bd_select_view_available
			SF.click_button_go
			ict_number = FFA.get_column_value_in_grid $label_ict_source_document_description , _cashentry_description , $label_ict_intercompany_transfer_number
			ICT.open_ICT_detail_page ict_number

			gen_compare  $bd_ict_status_available, ICT.get_processing_status , "TST027729: Expected ICT Processing status to be Available. "
			gen_compare cashentry_number ,ICT.get_source_cash_entry_number , "TST027729:Expected source cash entry in ICT as same as cash entry created in this TID" 

			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			FFA.select_row_in_list_gird $label_ict_source_document_description ,  _cashentry_description
			ICT.click_button_process
			ict_processing_message = FFA.ffa_get_info_message
			gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job

			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_complete_ict_cash_entry
			SF.click_button_go
			ICT.open_ICT_detail_page ict_number
			destination_cash_entry = ICT.get_destination_cash_entry_number
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			CE.open_cash_entry_detail_page destination_cash_entry
			FFA.click_post
			page.has_text?($bd_document_status_complete)
			gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "TST027729: Expected cash entry status to be complete"
		end	
		begin
			puts "TST027729: 1.6,1.7: Retrieve transaction reconciliation."
			MERLIN_AUTO_SPAIN_LINES = [
				[current_date, cashentry_number, '', 'ICT', '', 'EUR', "-160.00"]
			]
			MERLIN_AUTO_USA_LINES = [
				["160.00", current_date, destination_cash_entry, '', 'ICT', '', 'EUR']
			]
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain,$company_merlin_auto_usa] ,true
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			TRANRECON.wait_for_loading
			#set field in left panel
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_company_label, $company_merlin_auto_spain
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_period_label, _next_period
			TRANRECON.set_filter_field $tranrecon_left_filter, $tranrecon_gla_label, $bd_gla_revaluation_reserve_bs_usd
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			
			#set field in right panel
			TRANRECON.click_button $tranrecon_right_add_transaction_button
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_company_label, $company_merlin_auto_usa
			TRANRECON.set_filter_field $tranrecon_right_filter, $tranrecon_gla_label, $bd_gla_revaluation_reserve_bs_usd
			TRANRECON.click_button $filter_popup_retrieve_button
			TRANRECON.wait_for_loading
			gen_assert_displayed $tranrecon_matching_screen_pane_line_header
			# Assert the Left and right pane
			expect(TRANRECON.pane_lines_equal? $tranrecon_left_panel, MERLIN_AUTO_SPAIN_LINES).to eq(true)
			gen_report_test "Left Panel of transaction reconciliation showed same line item details as expected."
			expect(TRANRECON.pane_lines_equal? $tranrecon_right_panel, MERLIN_AUTO_USA_LINES).to eq(true)
			gen_report_test "Right Panel of transaction reconciliation showed same line item details as expected."
		end	
		begin
			puts "TST027729:1.8: Click on Auto reconciliation and verify that lines are selected."
			TRANRECON.click_button $tranrecon_auto_match_button
			# left pane lines
			TRANRECON.wait_for_loading
			expect(TRANRECON.line_selected? $tranrecon_left_table, 1 , true).to eq(true)
			gen_report_test "Line items at Left Panel of transaction reconciliation are selected"
			# right pane lines.
			expect(TRANRECON.line_selected? $tranrecon_right_table, 1 , true).to eq(true)
			gen_report_test "Line items at Right Panel of transaction reconciliation are selected"
		end
		gen_end_test "TID018057"
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID018057:Transaction Reconciliation Smoke Test"
		SF.logout
	end
end
