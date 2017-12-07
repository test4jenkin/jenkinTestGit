#--------------------------------------------------------------------------------------------#
#	TID :TID013234, TID013382 
# 	Pre-Requisit: Org with basedata deployed.
#  	Product Area: Cash Matching
# 	Story: 23483
#--------------------------------------------------------------------------------------------#

describe "Smoke Test:Cash matching and Bank reconciliation.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	_line_number1 = 1
	_quantity_1 = 1
	_unit_price_10000 = 10000
	_bank_reconciliation_ref = "Bristol Statement Smoke Test"
	income_schedule = "IncScheUSD"
	paymentscedule_invoice_num = ""
	incomeschedule_invoice_num = ""
	cashentry_number = ""
	cashentry_number_ = ""
	cashentry_value_14531_25 = "14531.25"
	csv_file = "SmokeTestStatement.CSV"
	it "TID013234 Implemented : Smoke Test- Create sales invoice with payment schedule." do
		gen_start_test "TID013234"
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		
		begin
			# create current+1 year
			current_year = (Time.now).year
			next_year = current_year+1
			SF.tab $tab_years
			SF.select_view $bd_select_view_company_ff_merlin_auto_USA
			SF.click_button_go
			year_not_exist=true
			within(find($year_list_grid)) do
				if page.has_text?(next_year.to_s)
					year_not_exist=false
				end
			end
			puts "Next year need to be created: "+year_not_exist.to_s
			if year_not_exist
				SF.tab $tab_years
				SF.click_button_new
				YEAR.set_year_name next_year.to_s
				YEAR.set_start_date  "01/01/"+next_year.to_s
				YEAR.set_year_end_date  "31/12/"+next_year.to_s
				YEAR.set_number_of_periods "12"
				YEAR.select_period_calculation_basis $bd_period_calculation_basis_month_end
				SF.click_button_save
				SF.wait_for_search_button
				#calculate periods
				YEAR.click_calculate_periods_button
				gen_include $ffa_msg_calculate_period_confirmation, FFA.ffa_get_info_message , "TST017670: Expected a confirmation message for calculating periods."
				#confirm the process
				YEAR.click_calculate_periods_button
				gen_compare next_year.to_s , YEAR.get_year_name , "TST017670: Expected  periods  to be created successfully for year 2015. "
			end
		end
		gen_start_test "TST017019 : create sales invoice with payment schedule"  
		begin
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_algernon_partners_co
			FFA.click_new_line
			SIN.line_set_product_name _line_number1, $bd_product_sla_gold
			SIN.line_set_quantity _line_number1,_quantity_1
			SIN.line_set_unit_price _line_number1, _unit_price_10000
			SIN.set_payment_schedule $bd_payment_schedule_type_payment_schedule
			SIN.set_payment_schedule_number_of_payments "8"
			SIN.set_payment_schedule_interval_type $bd_payment_schedule_interval_monthly
			SIN.set_payment_schedule_first_due_date (Date.today).strftime("%d/%m/%Y")
			SIN.click_calculate_payment_schedule_button
			FFA.click_save_post
			paymentscedule_invoice_num = SIN.get_invoice_number
			gen_compare $bd_document_status_complete , SIN.get_status , "Expected sales invoice status to be complete"			
			gen_compare_has_xpath $sin_transaction_link, true, "Expected Transaction number to be generated for posted invoice."			
			SIN.click_transaction_number
			_trans_account_total = TRANX.get_account_total
			_trans_account_outstanding_total = TRANX.get_account_outstanding_total
			_trans_home_debit = TRANX.get_home_debits
			_trans_dual_debit = TRANX.get_dual_debits
			gen_compare "12,650.00" , _trans_account_total , "Expected sales invoice transaction account total 12,650"
			gen_compare "12,650.00" , _trans_account_outstanding_total , "Expected sales invoice transaction account outstanding total 12,650"
			gen_compare "25,300.00" , _trans_home_debit , "Expected sales invoice transaction home debit 25,300"
			gen_compare "25,300.00" , _trans_dual_debit , "Expected sales invoice transaction dual debit 25,300"
  		end
		gen_end_test "TID013234"
	
		gen_start_test "TID013382"
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		gen_start_test "TST017099 : create a sales invoice with income schedule"  
			
		begin
  			SF.tab $tab_income_schedule_definitions
			SF.click_button_new
			Incomeschedule.set_name income_schedule 
			Incomeschedule.set_num_of_journals "12"
			Incomeschedule.set_period_interval "1"
			Incomeschedule.set_gla $bd_gla_account_receivable_control_usd
			SF.click_button_save
			SF.tab $tab_income_schedule_definitions			
			gen_compare_has_content income_schedule, true,  "Expected Income schdule to be created successfully. "
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_algernon_partners_co
			SIN.set_currency $bd_currency_gbp
			FFA.click_new_line
			SIN.line_set_product_name _line_number1, $bd_product_sla_gold
			SIN.line_set_quantity _line_number1,_quantity_1
			SIN.line_set_unit_price _line_number1, _unit_price_10000
			SIN.line_set_income_schedule  _line_number1 , income_schedule
			FFA.click_save_post
			gen_compare $bd_document_status_ready_to_post , SIN.get_status , "expected invoice status to be ready to post"
			incomeschedule_invoice_num = SIN.get_invoice_number
			
			SF.tab $tab_background_posting_scheduler
			SF.wait_for_search_button
			SF.click_button $ffa_run_now_button
			SF.wait_for_apex_job  
			
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go	
			SIN.open_invoice_detail_page incomeschedule_invoice_num
			gen_compare $bd_document_status_complete , SIN.get_status , "Expected sales invoice status to be complete"			
		end
		gen_end_test "TID013382"

		gen_start_test "TID013384"
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		gen_start_test "TST017103 : Do Cash Matching of cash entry and invoices."  
		begin
			# 1.1
			begin
				SF.tab $tab_cash_entries
				SF.click_button_new
				SF.wait_for_search_button
				bank_account = CE.get_bank_account_name
				gen_compare $bd_bank_account_bristol_checking_account,bank_account , "Expected default bank Account for cash entry to be Bristol Checking Account. "
				CE.set_currency $bd_currency_gbp,$company_merlin_auto_usa			
				CE.set_payment_method $bd_payment_method_check
				CE.line_set_account_name $bd_account_algernon_partners_co
				FFA.click_new_line
				CE.line_set_cashentryvalue 1,cashentry_value_14531_25
				CE.click_update
				bankacc_value = CE.line_get_line_bankaccount_value 1
				FFA.click_save_post
				cashentry_number = CE.get_cash_entry_number
				
				SF.tab $tab_cash_entries
				SF.select_view $bd_select_view_all
				SF.click_button_go	
				CE.open_cash_entry_detail_page cashentry_number
				cashentry_status = CE.get_cash_entry_status
  				gen_compare $bd_document_status_complete , cashentry_status , "Expected cash entry status to be complete"			
			end		

			# 1.2 and 1.3
			begin
				SF.tab $tab_cash_matching
				CM.retrieve_cashmatching $bd_account_algernon_partners_co, $bd_currency_mode_document, $bd_currency_gbp				
				gen_compare_has_content cashentry_number, true, "Expected cash entry to be displayed for cash matching-> " + cashentry_number				
				gen_compare_has_content incomeschedule_invoice_num, true, "Expected Income schedule invoice number to be displayed for cash matching-> " +incomeschedule_invoice_num		
				gen_compare_has_content paymentscedule_invoice_num, true, "Expected payment schedule invoice number to be displayed for cash matching-> " +paymentscedule_invoice_num
				CM.select_cashentry_doc_for_matching cashentry_number, 1
				
				CM.select_trans_doc_for_matching paymentscedule_invoice_num, 1
				CM.select_trans_doc_for_matching paymentscedule_invoice_num, 2
				CM.set_trans_doc_paid_amount "300", 2
				CM.select_trans_doc_for_matching incomeschedule_invoice_num, 1
				match_total = CM.get_match_total 
				gen_compare "0.00" , match_total , "Expected match total 0.00"  			
				CM.click_commit_data
				gen_include $ffa_msg_cashmatching_completed_message,CM.get_cash_matching_commit_operation_message , "Expected Commit operation to be successfull"
				gen_include $ffa_msg_cashmatching_reference_message,CM.get_cash_matching_commit_operation_message , "Expected Commit operation to be successfull with a reference number: "+CM.get_cash_matching_commit_operation_message
			end
			
			# 1.4
			begin
				SF.tab $tab_cash_entries
				SF.click_button_new
				bank_account = CE.get_bank_account_name
				gen_compare $bd_bank_account_bristol_checking_account,bank_account , "Expected default bank Account for cash entry to be Bristol Checking Account. "
				CE.set_currency $bd_currency_gbp,$company_merlin_auto_usa			
				CE.set_payment_method $bd_payment_method_check
				CE.line_set_account_name $bd_account_algernon_partners_co
				FFA.click_new_line
				CE.line_set_cashentryvalue 1,"100"
				CE.click_update
				bankacc_value = CE.line_get_line_bankaccount_value 1
				FFA.click_save_post
				cashentry_number_ = CE.get_cash_entry_number
				
				SF.tab $tab_cash_entries
				SF.select_view $bd_select_view_all
				SF.click_button_go	
				CE.open_cash_entry_detail_page cashentry_number_
				cashentry_status = CE.get_cash_entry_status
  				gen_compare $bd_document_status_complete , cashentry_status , "Expected cash entry status  to be complete"			
				
			end		
			# 1.5 and 1.6
			begin
				SF.tab $tab_cash_matching
				CM.retrieve_cashmatching $bd_account_algernon_partners_co, $bd_currency_mode_document, $bd_currency_gbp
				page.has_text?(paymentscedule_invoice_num)# wait for the payable invoice and respective amount to be displayed on cash matching table.
				page.has_text?("100")				
				gen_compare_has_content cashentry_number_, true, "Expected cash entry to be displayed for cash matching-> " + cashentry_number_
				gen_compare_has_content paymentscedule_invoice_num, true, "Expected payment schedule invoice number to be displayed for cash matching-> " +paymentscedule_invoice_num
				page.has_text?(paymentscedule_invoice_num)
				CM.select_trans_doc_for_matching paymentscedule_invoice_num, 1
				CM.set_trans_doc_paid_amount "100", 1
				CM.select_cashentry_doc_for_matching cashentry_number_, 1
				match_total = CM.get_match_total
				gen_compare "0.00" , match_total , "Expected match total 0.00"  			
				CM.click_commit_data
				gen_include $ffa_msg_cashmatching_completed_message,CM.get_cash_matching_commit_operation_message , "Expected Commit operation to be successfull"
				gen_include $ffa_msg_cashmatching_reference_message,CM.get_cash_matching_commit_operation_message , "Expected Commit operation to be successfull with a reference number: "+CM.get_cash_matching_commit_operation_message
			end
			# 1.7
			begin
				SF.tab $tab_cash_matching
				CM.undo_cashmatching $bd_account_algernon_partners_co, $bd_currency_mode_document, $bd_currency_gbp, $bd_cashmatching_undoreason_matching_error
				FFA.wait_page_message $cashmatching_retrieving_message
				page.has_text?(paymentscedule_invoice_num) # wait for the payable invoice and respective amount to be displayed on cash matching table.
				page.has_text?("-100.00")
				CM.select_undo_doc_by_amount "-100.00"
				CM.click_commit_undomatching
				gen_include $ffa_msg_undocashmatching_completed_message,CM.get_cash_matching_commit_operation_message , "Expected undo matching  operation to be successfull"
				gen_include $ffa_msg_cashmatching_reference_message,CM.get_cash_matching_commit_operation_message , "Expected undo matching operation to be successfull with a reference number: "+CM.get_cash_matching_commit_operation_message
			end			
		end
		gen_end_test "TID013384"
		gen_start_test "TID013387"

		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		gen_start_test "TST017116 : Create a bank statement and process Bank reconciliation."  
		begin
			#1.1
			begin
				SF.tab $tab_bank_accounts
				SF.select_view $bd_select_view_company_ff_merlin_auto_USA
				SF.click_button_go
				BA.select_bank_account $bd_bank_account_bristol_checking_account 
				BA.bankstatementdef_click_button_new
				BA.bankstatementdef_set_file_delimiter $bd_bankstatementdef_file_delimiter_comma
				BA.bankstatementdef_set_date_format $bd_bankstatementdef_dateformat_ddmmyyyy
				BA.bankstatementdef_set_payment_receipt_format $bd_bankstatementdef_negative_payments_positive_receipts_format
				BA.bankstatementdef_set_decimal_separator $bd_bankstatementdef_seperator_period
				BA.bankstatementdef_set_start_row "2"
				BA.bankstatementdef_set_max_num_of_decimals "2"
				BA.bankstatementdef_set_date_position "1"
				BA.bankstatementdef_set_ref_position "2"
				BA.bankstatementdef_set_description_position "3"
				BA.bankstatementdef_set_amount_position "4"
				BA.bankstatementdef_click_save_button
				BA.get_bankstatement_definition_name
				gen_include "BSD" , BA.get_bankstatement_definition_name , "Expected a new bank statement definition to be created for Bristol check account Bank. Name - "+BA.get_bankstatement_definition_name
  			end
  			#1.2
  			begin
  				SF.tab $tab_bank_statements
  				SF.click_button_new
  				BS.set_bank_account $bd_bank_account_bristol_checking_account,$company_merlin_auto_usa
				today_plus5_date = (Date.today + 5).strftime("%d/%m/%Y")
  				BS.set_statement_date today_plus5_date
  				BS.set_reference _bank_reconciliation_ref
  				BS.set_opening_balance "0.00"
  				BS.set_closing_balance "29,062.50"
  				BS.import_statement_file csv_file 
  				BS.click_button_import
  				bank_statement_number = BS.get_bank_statement_number
				bank_statement_status = BS.get_bank_statement_status
				gen_compare $bd_document_status_imported , bank_statement_status , "Expected Bank statement status to be imported. "
  			end
			
  			#1.3,#1.4
  			begin
				SF.tab $tab_bank_statements  			
				SF.select_view $bd_select_view_all
				SF.click_button_go
				BS.open_bank_statement_detail_page bank_statement_number  			
				BS.click_button_reconcile
				# Click yes on confirmation page
				BS.click_button_reconcile_confirm
				BS.select_bank_statement_lines "Ref1"
				BS.select_bank_statement_lines "Ref3"
				BS.click_button_commit_selected_lines
				BS.click_complete_reconciliation_button
				SF.wait_for_apex_job
				SF.tab $tab_bank_statements  			
				SF.select_view $bd_select_view_all
				SF.click_button_go
				BS.open_bank_statement_detail_page bank_statement_number
				bank_statement_status = BS.get_bank_statement_status
				gen_compare $bd_document_status_reconciled , bank_statement_status , "Expected Bank Statement status to be reconciled"	
				SF.tab $tab_bank_reconciliations
				SF.select_view $bd_select_view_all
				SF.click_button_go
				BR.open_bank_reconciliation_detail_page _bank_reconciliation_ref
				bankstatement_reconciliation_status = BR.get_bank_reconciliation_status
				gen_compare $bd_document_status_complete , bankstatement_reconciliation_status , "Expected reconciliation status to be complete"				
  			end	  			
  		end
		gen_end_test "TID013387"
  	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID013234 and TID013382"
		SF.logout 
	end
end
