 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module CRV
extend Capybara::DSL
##################################
# Currency Revaluation (VF pages)#
##################################

##################################
# Selctors
##################################
$crv_unrealized_gain_losses_gla = "input[id$='GLAinput']"	
$crv_dimension_analysis = "select[id$='DimensionAnalysisSelect']"
$crv_analysis = "select[id$='GroupLevelSelect']"
$crv_revaluation_type = "select[id$='RevalSelect']"
$crv_gla_selection_automatically_select_all_gla_radio_button = "input[id$='BalanceSheet-GLA-Options:0']"
$crv_gla_selection_pick_gla_to_include_radio_button = "input[id$='BalanceSheet-GLA-Options:1']"
$crv_exclude_from_selection_radio_button = "input[id$='alreadyRevaluedBehaviour:0']"
$crv_fail_with_an_error_radio_button = "input[id$='alreadyRevaluedBehaviour:1']"
$crv_gla_list_pattern = "label[for$='glaRepeat:"+$sf_param_substitute+":glaChkBox']"
$crv_gla_list_checkbox = "input[id$='glaRepeat:"+$sf_param_substitute+":glaChkBox']"
$crv_balance_sheet_posting_period = "a[id*=':postingPeriodBalanceSheet']"
$crv_balance_sheet_to_period = "a[id*='toPeriodBalanceSheet']"
$crv_balance_sheet_from_period = "a[id*='fromPeriodBalanceSheet']"
$crv_balance_sheet_reversal_period = "a[id*='reversalPeriodBalanceSheet']"
$crv_dual_rate = "input[Id*='homeToDualSection'][type='text'][class='calcHomeDoc']"
$crv_revalue_checkbox_dual_currency = "input[Id*='homeToDualSection'][type='checkbox'][class='rateChkBox']"
$crv_document_rate_pattern = "input[id$='doc_rates:"+$sf_param_substitute+":txtHomeDoc']"
$crv_exchange_rate_list_grid= "table[id$='doc_rates'] tbody[id$='doc_rates:tb'] tr"
$crv_exchange_rate_document_currency_column = $crv_exchange_rate_list_grid + ":nth-of-type("+$sf_param_substitute+") td:nth-of-type(2)"
$crv_autopost_checkbox = "input[id$='postOnSubmit']"
$crv_number_pattern = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[@title='"+$sf_param_substitute+"']"
$crv_validating_exchange_rate_message= "Validating exchange rate"
$crv_generate_and_post_button= "input[id$=':bottom:generateAndPost']"
$crv_pick_gla_from_options_for_revaluation = "//label[text()='"+$sf_param_substitute+"']/ancestor::div[1]/input"
$crv_balance_sheet_checkbox = "input[id*=':BalanceSheet']"
$crv_income_statement_checkbox = "input[id*=':IncomeStatement']"
$crv_balance_sheet_options= "select[id*='customPeriodFrom']"
$crv_retrieve_data_button = "input[id$=':RetrieveData']"
$crv_group_post_button = "input[name='post']"
$crv_group_visualforce_post_button = "input[id*=':post']"
$crv_dimension_analysis_copy_from_source_radio_button= "input[value*='Copy from Source']"
$crv_summary_analysis_summary_level_radio_button = "input[value*='Summary Level']"
$crv_summary_analysis_detail_level_radio_button = "input[value*='Detail Level']"
$crv_confirmation_message_generate_button = "input[id$=':generate']:nth-of-type(3)"
$crv_confirmation_message_generate_and_post_button = "input[id$=':postNow']"
$crv_currency_revaluation_group_status = "//td[text()='Status']/following::td[1]/div | //span[text()='Status']/ancestor::div[1]/following::div[1]/div/span"
$crv_pick_gla_from_options_for_revaluation_pattern = "input[id$='"+$sf_param_substitute+"']"
$crv_export_as_button = "input[id*='exportReportBtn']"
$crv_tli_pop_up_close_button = "td[class*='tran-popup-buttonpanel'] input[id$='cancel']"
$crv_export_as_csv_file_button = "div[onmousedown*='csv']"
$crv_export_as_microsoft_excel_button = "div[onmousedown*='xls']"
$crv_export_as_adobe_pdf_button = "div[onmousedown*='pdf']"
$crv_bottom_generate_button = "input[Value='Generate'][Id*='bottom:generate']"
$crv_ignore_unused_currency_checkbox = "input[id$=':ignoreUnusedCurrencies']"
$crv_income_statement_period_from = "a[id*='fromPeriodIncomeStatement']"
$crv_income_statement_period_to = "a[id*='toPeriodIncomeStatement']"
$crv_income_statement_trx_posted_to_period = "a[id*=':postingPeriodIncomeStatement']"
$crv_income_statement_trx_reversal_period = "a[id*=':reversalPeriodIncomeStatement']"
# Currency Revaluation Page
$crv_document_to_home_row_content_pattern = "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]"
$crv_home_to_dual_row_content_pattern = "//label[contains(text(),'"+$sf_param_substitute+"')]/ancestor::tr[1]"
#Transaction Line Items Popup
$crv_trx_pop_up_rows = "tbody[id*=':transDetailTable']"
$crv_trx_line_item_row_data = "//td[6][text()='"+$sf_param_substitute+"']/ancestor::tr[1]"
# labels
$crv_generate_button_label = "Generate"
$crv_document_exchange_rate_label = "Document Exchange Rate"
$crv_revaluation_group_label = "Group"
$crv_export_as_button_label = "Export As"

#methods

## Revaluation Criteria Page
# select unrealized gains losses gla
	def CRV.set_unrealized_gains_losses_gla gla_value
		gen_wait_until_object $crv_unrealized_gain_losses_gla
		SF.execute_script do
			find($crv_unrealized_gain_losses_gla).set gla_value
			gen_tab_out $crv_unrealized_gain_losses_gla
		end
	end 
	
# select Dimensions analysis
	def CRV.set_dimension_analysis dimension_analysis_value
		find($crv_dimension_analysis).select dimension_analysis_value
		gen_tab_out $crv_dimension_analysis
	end
		
#select Analysis value
	def CRV.set_analysis analysis_value
		find($crv_analysis).select analysis_value
		gen_tab_out $crv_analysis
	end
	
# select revaluation type
	def CRV.set_revaluation_type reval_type_value
		find($crv_revaluation_type).select reval_type_value
		gen_tab_out $crv_revaluation_type
	end
	
# choose automatically select all GLA  radio button
	def CRV.choose_automatically_select_all_gla 
		find($crv_gla_selection_automatically_select_all_gla_radio_button).click
	end
# choose let me pick which GLA to include radio button
	def CRV.choose_pick_gla_to_include
		SF.execute_script do
			find($crv_gla_selection_pick_gla_to_include_radio_button).click
			FFA.wait_page_message "Loading GLAs"
		end
	end	

# choose Action on duplicate - Exclude from selection radio button
	def CRV.choose_exclude_from_selection_action
		SF.execute_script do
			find($crv_exclude_from_selection_radio_button).click
		end
	end

# Check ignore unused currency checkbox
	def CRV.check_ignore_unused_currency_checkbox 
		SF.execute_script do
			find($crv_ignore_unused_currency_checkbox).set(true)
		end
	end
	
# choose Action on duplicate - Error radio button
	def CRV.choose_error_action
		find($crv_fail_with_an_error_radio_button).click
	end
	
# select balance sheet From period 
	def CRV.select_period_from period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_balance_sheet_from_period, period_name, company_name
		end
	end
	
# select balance sheet To period 
	def CRV.select_period_to period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_balance_sheet_to_period, period_name, company_name
		end
	end
# select balance sheet posting period
	def CRV.select_posting_period period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_balance_sheet_posting_period, period_name, company_name
		end
	end

# select balance sheet reversal period
	def CRV.select_reversal_period period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_balance_sheet_reversal_period, period_name, company_name
		end
	end
	
## select General ledger account page
# General Ledger Account Selection page
	def CRV.get_general_ledger_account gla_sequence_number
		gla_sequence_number-=1
		return find($crv_gla_list_pattern.sub($sf_param_substitute,gla_sequence_number.to_s)).text
	end
# get general ledger account select checkbox status
	def CRV.get_gla_checkbox_status gla_sequence_number
		gla_sequence_number-=1
		return has_checked_field?(find($crv_gla_list_checkbox.sub($sf_param_substitute,gla_sequence_number.to_s))[:id]) 
	end
		
## Currency Revalue Page
# Uncheck/check Revalue checkbox dual curreny Home to Dual section
	def CRV.set_checkbox_dual_currency
		find($crv_revalue_checkbox_dual_currency).click
		gen_wait_until_object $crv_bottom_generate_button
	end
# set dual rate
	def CRV.set_dual_rate dual_value
		find($crv_dual_rate).set dual_value
		gen_tab_out $crv_dual_rate
		FFA.wait_page_message $crv_validating_exchange_rate_message
	end

# set document rate as per document currency exchange rate
	def CRV.set_document_rate document_currency , document_rate
		SF.execute_script do
			rownum =1
			while rownum <= all($crv_exchange_rate_list_grid).count
				doc_currency = find($crv_exchange_rate_document_currency_column.sub($sf_param_substitute,rownum.to_s)).text
				if document_currency == doc_currency
					row=rownum-1
					find($crv_document_rate_pattern.sub($sf_param_substitute,row.to_s)).set document_rate
					gen_tab_out $crv_document_rate_pattern.sub($sf_param_substitute,row.to_s)
				end
			rownum+=1
			end
			FFA.wait_page_message $crv_validating_exchange_rate_message
		end
	end

# get row content of Document to Home UI table
	def CRV.get_doc_to_home_row_data doc_currency_pair_label
		return find(:xpath,$crv_document_to_home_row_content_pattern.sub($sf_param_substitute,doc_currency_pair_label)).text
	end
	
# get rwo content Home to Dual UI table
	def CRV.get_home_to_dual_row_data currency_label
		return find(:xpath,$crv_home_to_dual_row_content_pattern.sub($sf_param_substitute,currency_label)).text
	end
	
# get number of transaction line item displayed on pop-up
	def CRV.get_num_of_trx_line_items
		SF.retry_script_block do 
			return all($crv_trx_pop_up_rows).size
		end	
	end

# get row data from transaction line popup 
# doc_value(String) = document currency as paramater
	def CRV.get_trx_line_item_data doc_value
		return find(:xpath,$crv_trx_line_item_row_data.sub($sf_param_substitute,doc_value)).text
	end
# select autopost checkbox as true
	def CRV.select_autopost_checkbox 
		find($crv_autopost_checkbox).click
	end
#buttons
# click OK button to process Currency revaluation
	def CRV.click_ok_button
		SF.click_button "Ok"
		SF.wait_for_search_button
	end
# click next button and wait
	def CRV.click_next
		SF.click_button "Next"
		SF.wait_for_search_button
	end
# click submit button
	def CRV.click_submit_button
		SF.click_button "Submit"
		SF.wait_for_search_button
	end
	
# click on retrieve Data button	
	def CRV.click_retrieve_data_button
		SF.execute_script do
			find($crv_retrieve_data_button).click
		end
		SF.wait_for_search_button
		gen_wait_until_object $crv_revalue_checkbox_dual_currency
	end
# click on Generate button
	def CRV.click_generate_button
		SF.click_button $crv_generate_button_label
		sleep 1 #wait for the confirmation pop-up to appear on screen
	end
# click on generate and post button to post the document simultaneously
	def CRV.click_generate_and_post_button
		SF.execute_script do
			find($crv_generate_and_post_button).click
		end
		sleep 1# wait for confirmation prompt message to appear
	end
# click generate button on confirmation message 
	def CRV.click_confirm_message_generate_button
		SF.execute_script do
			find($crv_confirmation_message_generate_button).click
		end
		SF.wait_for_search_button
	end
# click generate button on confirmation message 
	def CRV.click_confirm_message_generate_and_post_button
		SF.execute_script do
			find($crv_confirmation_message_generate_and_post_button).click
		end
		SF.wait_for_search_button
	end
# click Export As button on currency transaction pop up
	def CRV.click_export_as_button
		SF.retry_script_block do
			find($crv_export_as_button).click
		end
	end
# click Close button on currency transaction pop up
	def CRV.click_tli_pop_up_close_button
		find($crv_tli_pop_up_close_button).click
	end	
# click CSV File (.csv) option on Export As button
	def CRV.click_csv_file_export_as_button
		find($crv_export_as_csv_file_button).click
		SF.wait_less
		gen_wait_for_download_to_complete
	end	
# click Microsoft Excel (.xls) option on Export As button
	def CRV.click_microsoft_excel_export_as_button
		find($crv_export_as_microsoft_excel_button).click
		SF.wait_less
		gen_wait_for_download_to_complete
	end
# click Adobe PDF (.pdf) option on Export As button
	def CRV.click_adobe_pdf_export_as_button
		find($crv_export_as_adobe_pdf_button).click	
	end	
# open Currency revaluation detail page
	def CRV.open_currency_revaluation_detail_page crv_number
	    find(:xpath , $crv_number_pattern.gsub( $sf_param_substitute , crv_number.to_s)).click
		SF.wait_for_search_button
	end

# Check Balance sheet checkbox
	def CRV.check_balance_sheet_checkbox 
		SF.execute_script do
			find($crv_balance_sheet_checkbox).set(true)
			sleep 1 # wait for option under balance sheet to be displayed.
		end
	end

# select Balance Sheet Period From value
	def CRV.select_balance_sheet_period_value balance_sheet_value
		SF.execute_script do
			find($crv_balance_sheet_options).select balance_sheet_value
		end
	end

# Check Income Statement checkbox
	def CRV.check_income_statement_checkbox 
		SF.execute_script do
			find($crv_income_statement_checkbox).set(true)
			sleep 1 # wait for option under balance sheet to be displayed.
		end
	end

# select Income Statement From period 
	def CRV.select_IS_period_from period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_income_statement_period_from, period_name, company_name
		end
	end
	
# select Income Statement To period 
	def CRV.select_IS_period_to period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_income_statement_period_to, period_name, company_name
		end
	end
# select Income Statement posting period
	def CRV.select_IS_posting_period period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_income_statement_trx_posted_to_period, period_name, company_name
		end
	end	

# select Income Statement reversal period
	def CRV.select_IS_reversal_period period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $crv_income_statement_trx_reversal_period, period_name, company_name
		end
	end
	
# Pick GLAs fron list to include it in revaluation	
	def CRV.pick_gla_from_list gla_name
		SF.execute_script do
			gla_to_select = $crv_pick_gla_from_options_for_revaluation.sub($sf_param_substitute,gla_name)
			gla_id = find(:xpath,gla_to_select)[:id]
			find($crv_pick_gla_from_options_for_revaluation_pattern.sub($sf_param_substitute,gla_id)).set(true)
		end
	end
# Choose option from dimension analysis
	def CRV.choose_copy_from_source_radio_button
		SF.execute_script do
			find($crv_dimension_analysis_copy_from_source_radio_button).click
		end
	end
# CHoose summary analysis-summary level radio button	
	def CRV.choose_summary_level_radio_button
		SF.execute_script do
			find($crv_summary_analysis_summary_level_radio_button).click
		end
	end
# Choose summary analysis-detail level radio button	
	def CRV.choose_detail_level_radio_button
		find($crv_summary_analysis_detail_level_radio_button).click
	end	
# currency revaluation group status
	def CRV.get_currency_revaluation_group_status
		return find(:xpath,$crv_currency_revaluation_group_status).text		
	end
	
# click on currency revaluation group post button	
	def CRV.click_group_post_button
		SF.execute_script do
			find($crv_group_post_button).click
			gen_wait_until_object $crv_group_visualforce_post_button
			find($crv_group_visualforce_post_button).click
		end
	end
	
#click document currency	
	def CRV.click_document_currency document_currency_link
		SF.click_link document_currency_link
		FFA.wait_page_message $ffa_msg_loading_transaction_line_detail
	end
end