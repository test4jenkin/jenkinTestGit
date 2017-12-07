#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

module TRANRECON
extend Capybara::DSL
####################################################### Selectors ###################################################################
####### Fields ###########
$TRANSACTION_RECONCILIATION_SCREEN_NAME = 'Transaction Reconciliation'
$tranrecon_left_panel = "div[data-ffid='leftPanel']"
$tranrecon_right_panel = "div[data-ffid='rightPanel']"
$tranrecon_left_filter = "leftFilterPopup"
$tranrecon_right_filter = "rightFilterPopup"
$tranrecon_closed_filter_popup = "div[data-ffid='"+$sf_param_substitute+"'][class*='f-hidden-offsets']"
$tranrecon_company_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='Company'] input[Name = 'Company']"
$tranrecon_filters_period_picklist = "div[data-ffid='Period'] input"
$tranrecon_period_multiselect_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='Period'] input[Name = 'PeriodMultiselect']"
$tranrecon_period_from_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='Period'] input[Name = 'PeriodFrom']"
$tranrecon_period_to_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='Period'] input[Name = 'PeriodTo']"
$tranrecon_gla_multiselect_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='GLA'] input[Name = 'GLAMultiselect']"
$tranrecon_gla_from_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='GLA'] input[Name = 'GLAFrom']"
$tranrecon_gla_to_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='GLA'] input[Name = 'GLATo']"
$tranrecon_account_field = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='Accounts'] input[Name = 'Accounts']"
$tranrecon_loading_icon = "//div[text()='Loading']"
$tranrecon_prepopulated_period_close_button = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='Period'] li[data-selectionindex='0'] div[class='f-tagfield-item-close']"
####### Buttons ###########
$tranrecon_left_add_transaction_button = "leftTransactionAddBtn"
$tranrecon_left_retrieve_edit_button = "leftRetrieveEditBtn"
$tranrecon_right_add_transaction_button = "rightTransactionAddBtn"
$tranrecon_right_retrieve_edit_button = "rightRetrieveEditBtn"
$filter_popup_retrieve_button = "retrieveBtn"
$filter_popup_close_button = "closeBtn"
$tranrecon_back_to_list_button = "backToListButton"
$tranrecon_continue_button = "a[data-ffid = 'ok']"
$tranrecon_save_button = "saveButton"
$tranrecon_auto_match_button = "autoMatchButton"
$tranrecon_clear_matches_button = "clearSelectionButton"
$tranrecon_reconcile_button = "reconcileButton"
$tranrecon_unreconcile_button = "unreconcileButton"
$tranrecon_save_popup_save_button = "savePopupButton"
$tranrecon_reconcile_popup_reconcile_button = "reconcilePopupButton"
$tranrecon_unreconcile_popup_unreconcile_button = "unreconcilepopupbutton"
$tranrecon_save_or_reconcile_popup_cancel_button = "cancelPopupButton"
$tranrecon_button = "a[data-ffid= '"+$sf_param_substitute+"']"
$tranrecon_button_disabled = "a[data-ffid= '"+$sf_param_substitute+"'][class*='f-btn-disabled']"
$tranrecon_period_selection_toggle_button = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='Period'] a"
$tranrecon_gla_selection_toggle_button = "div[data-ffid = '"+$sf_param_substitute+"'] div[data-ffid='GLA'] a"
$tranrecon_export_data_button = "exportButton"
$tranrecon_export_data_adobe_pdf_button = "//*[text()='Adobe PDF (.pdf)']"
$tranrecon_export_data_microsoft_excel_button = "//*[text()='Microsoft Excel (.xls)']"

########### Grid fields ################
$tranrecon_left_table = "leftTable"
$tranrecon_right_table = "rightTable"
$tranrecon_table = "div[data-ffid='"+$sf_param_substitute+"']"
$tranrecon_grid_select_all_checkbox = "div[data-ffid='"+$sf_param_substitute+"'] div[data-ffxtype='headercontainer'] div[class*='f-column-header-checkbox'] span[class='f-column-header-checkbox']"
$tranrecon_grid_header_column = "div[data-ffid='"+$sf_param_substitute+"'] span[class*='column-header-text']"
$tranrecon_grid_header_column_name = "div[data-ffid='"+$sf_param_substitute+"'] div[data-ffid='"+$sf_param_substitute+"']" 
## general column will be the one having information like plain text, date any number etc.
$tranrecon_grid_column = "div[data-ffid='"+$sf_param_substitute+"'] div[data-ref='body'] table:nth-of-type("+$sf_param_substitute+") td:nth-of-type("+$sf_param_substitute+") div"
$tranrecon_no_results_found_element = "//div[@data-ffid='"+$sf_param_substitute+"']//div[@data-ref='body']//div[text()='No Results Found']"
############### Save/Reconcile Popup ###############
$tranrecon_save_popup_title = "Save Draft"
$tranrecon_reconcile_popup_title = "Reconcile"
$tranrecon_unreconcile_popup_title = "Unreconcile"
$tranrecon_save_or_reconcile_popup_name_field = "nameField"
$tranrecon_save_or_reconcile_popup_description_field = "descriptionField"
$tranrecon_save_popup_info_message = "Save a draft to complete later."
$tranrecon_popup_title = "//div[text()='"+$sf_param_substitute+"' and contains(@class, 'f-title-text')]"
$tranrecon_popup_info_message = $tranrecon_popup_title +"//ancestor::div[@data-ffxtype='header']/following-sibling::div/div[@data-ref='body']//child::div[@data-ffid='tlisSummary']//div[@data-ref='innerCt']"
$tranrecon_save_or_reconcile_popup_field = $tranrecon_popup_title +"//ancestor::div[@data-ffxtype='header']/following-sibling::div/div[@data-ref='body']//div[@data-ffid='"+$sf_param_substitute+"']//input"

############## Transaction Line Item information ##############
$tranrecon_tli_header_2_text = "//h2[text()='Transaction Line Item Detail']"
$tranrecon_tli_field = "//td[text()='"+$sf_param_substitute+"']/following-sibling::td[1]/div"
$tranrecon_tli_transaction_reconciliation = "Transaction Reconciliation"
$tranrecon_tli_transaction_reconciliation_date = "Transaction Reconciliation Date"
$tranrecon_tli_transaction_reconciliation_status = "Transaction Reconciliation Status"
############## Transaction Reconciliation List View ######################
$tranrecon_first_row_column = "#ext-gen11 div[class*='x-grid3-row-first'] tr td:nth-of-type("+$sf_param_substitute+") div"

############### Transaction Reconciliation Labels ##############
$tranrecon_draft_label = "Draft"
$tranrecon_reconciled_label = "Reconciled"
$tranrecon_inprogress_label = "In Progress"
$tranrecon_reconciling_label = "Reconciling"
$tranrecon_unreconciling_label = "Unreconciling"
$tranrecon_unreconciled_label = "Unreconciled"
$tranrecon_proposed_label = "Proposed"
$tranrecon_company_label = "Company"
$tranrecon_gla_label = "GLA"
$tranrecon_account_label = "Account"
$tranrecon_period_label = "Period"
$tranrecon_gla_from_label = "GLAFrom"
$tranrecon_gla_to_label = "GLATo"
$tranrecon_period_from_label = "PeriodFrom"
$tranrecon_period_to_label = "PeriodTo"
$tranrecon_multiselect_label = "//*[text()='Multi-select']"
$tranrecon_from_to_label = "//*[text()='From-To']"
$tranrecon_tli_column_header_label = "Transaction Line"
################### Selectors moved from Intercompany Helper ######################################################
$tranrecon_summary_panel_retrieved_value = "div[data-ffid = 'summary'] tr:nth-child(3) td:nth-child(2)"
$tranrecon_summary_panel_remaining_value = "div[data-ffid = 'summary'] tr:nth-child(2) td:nth-child(2)"
$tranrecon_summary_panel_selected_value = "div[data-ffid = 'summary'] tr:nth-child(1) td:nth-child(2)"
$tranrecon_left_summary_panel = "div[data-ffid = 'leftSummary']"
$tranrecon_right_summary_panel = "div[data-ffid = 'rightSummary']"
$tranrecon_tli_table_line = "div[id^='reconciliation-table'] div[data-ffxtype='tableview'] table"
$tranrecon_filter_company = "div[class='TREC-filter-header'] span:nth-child(1)"
$tranrecon_filter_gla = "div[class='TREC-filter-header'] span:nth-child(3)"
$tranrecon_filter_account = "div[class='TREC-filter-header'] span:nth-child(4)"
$tranrecon_filter_period = "div[class='TREC-filter-header'] span:nth-child(2)"
$tranrecon_fount_results_count = "div[data-ffxtype='statusbar'] div[data-ffxtype='tbtext']"
$tranrecon_show_filter = "input[name='selectionField']"
$tranrecon_show_filter_show_all = "All"
$tranrecon_show_filter_show_selected = "Selected"
$tranrecon_show_filter_show_deselected = "Unselected"
$tranrecon_tab_title = "div[data-ffxtype='appnamelabel']"
$tranrecon_help_button = "a[data-ffxtype='helpbutton']"
$tranrecon_maximize_button = "a[data-ffxtype='fillbutton']"
$tranrecon_filters_picklist_click = "div[class*='arrow-trigger']"
$tranrecon_filters_picklist_list_element = "div[data-ffxtype='boundlist'] li"
$tranrecon_matching_screen_pane_line_header = "div[data-ffxtype='headercontainer']"
$tranrecon_matching_screen_pane_line_header_column = "div[data-ffxtype$='column']"
$tranrecon_amount_header_column_name = "amount"
$TRANRECON_TABLE_DATE_COLUMN = FFA.fetch_label 'TransactionReconciliationPageDateColumn'
$TRANRECON_TABLE_DOCREF_COLUMN = FFA.fetch_label 'TransactionReconciliationPageDocReferenceColumn'
$TRANRECON_TABLE_DESCRIPTION_COLUMN = FFA.fetch_label 'TransactionReconciliationPageDescriptionColumn'
$TRANRECON_TABLE_ICT_COLUMN = FFA.fetch_label 'TransactionReconciliationPageICTColumn'
$TRANRECON_TABLE_TLI_COLUMN = FFA.fetch_label 'TransactionReconciliationPageTLIColumn'
$TRANRECON_TABLE_CURRENCY_COLUMN = FFA.fetch_label 'TransactionReconciliationPageCurrencyColumn'
$TRANRECON_TABLE_AMOUNT_COLUMN = FFA.fetch_label 'TransactionReconciliationPageTitleAmountColumn'
$tranrecon_reconcile_pop_info_message_expected = "You are about to reconcile "+$sf_param_substitute+" transactions."
$tranrecon_partial_unreconcile_pop_info_message_expected = "You are about to unreconcile "+$sf_param_substitute+" transactions."
$tranrecon_unreconcile_pop_info_message_expected = "You are about to unreconcile all "+$sf_param_substitute+" transactions. Click \"Unreconcile\" to confirm."
$tranrecon_picklist_value_pattern = "//li/div[(text()='"+$sf_param_substitute+"')]"
######################################################### Methods ##########################################################
################################### get/Set Save/Reconcile Popup ####################################
# Use following for popup_name variable
# $tranrecon_save_popup_title = "Save Draft"
# $tranrecon_reconcile_popup_title = "Reconcile"
# $tranrecon_unreconcile_popup_title = "Unreconcile"
# Use following as field_name
# $tranrecon_save_or_reconcile_popup_name_field = "nameField"
# $tranrecon_save_or_reconcile_popup_description_field = "descriptionField"
########################################################################################################
	def TRANRECON.set_popup_field popup_name, field_name, value
		pop_field = $tranrecon_save_or_reconcile_popup_field.sub($sf_param_substitute, popup_name).sub($sf_param_substitute, field_name)
		find(:xpath, pop_field).set value
		gen_wait_less
	end
	
	def TRANRECON.get_popup_field_value popup_name, field_name
		pop_field = $tranrecon_save_or_reconcile_popup_field.sub($sf_param_substitute, popup_name).sub($sf_param_substitute, field_name)
		return find(:xpath, pop_field).text
	end
	
	def TRANRECON.get_popup_info_message popup_name
		info_panel = $tranrecon_popup_info_message.sub($sf_param_substitute, popup_name)
		return find(:xpath, info_panel).text
	end
	
	def TRANRECON.is_popup_present? popup_name
		if popup_name.casecmp($tranrecon_save_popup_title)
			return page.has_css?($tranrecon_button.sub($sf_param_substitute, $tranrecon_save_popup_save_button))
		elsif popup_name.casecmp($tranrecon_reconcile_popup_title)
			return page.has_css?($tranrecon_button.sub($sf_param_substitute, $tranrecon_reconcile_popup_reconcile_button))
		elsif popup_name.casecmp($tranrecon_unreconcile_popup_title)
			return page.has_css?($tranrecon_button.sub($sf_param_substitute, $tranrecon_unreconcile_popup_unreconcile_button))	
		end	
	end
################################### Set filter fields #####################################
# panel - $tranrecon_left_filter, $tranrecon_right_filter
# field_name - Company, Period, PeriodFrom, PeriodTo, GLA, GLAFrom, GLATo, Account
###################################################################################
	def TRANRECON.set_filter_field panel, field_name, field_value
		SF.execute_script do 
			field = String.new
			if field_name.casecmp('Company') == 0
				field = $tranrecon_company_field.sub($sf_param_substitute, panel)
			elsif field_name.casecmp('Period') == 0	
				field = $tranrecon_period_multiselect_field.sub($sf_param_substitute, panel)
			elsif field_name.casecmp('PeriodFrom') == 0	
				field = $tranrecon_period_from_field.sub($sf_param_substitute, panel)
			elsif field_name.casecmp('PeriodTo') == 0	
				field = $tranrecon_period_to_field.sub($sf_param_substitute, panel)
			elsif field_name.casecmp('GLA') == 0	
				field = $tranrecon_gla_multiselect_field.sub($sf_param_substitute, panel)
			elsif field_name.casecmp('GLAFrom') == 0	
				field = $tranrecon_gla_from_field.sub($sf_param_substitute, panel)	
			elsif field_name.casecmp('GLATo') == 0	
				field = $tranrecon_gla_to_field.sub($sf_param_substitute, panel)
			elsif field_name.casecmp('Account') == 0	
				field = $tranrecon_account_field.sub($sf_param_substitute, panel)
			end
				
			if !field.to_s.empty?
				SF.retry_script_block do
					find(field).click
					find(field).set(field_value)
					find(field).native.send_keys(:enter)
					gen_tab_out field
				end
			end	
		end
	end

#################### Click on Button ###########################
#Use following buttons as button_name
#$tranrecon_back_to_list_button = "backToListButton"
#$tranrecon_filters_button = "toggleFilterButton"
#$tranrecon_retrieve_button = "retriveButton"
#$tranrecon_save_button = "saveButton"
#$tranrecon_auto_match_button = "autoMatchButton"
#$tranrecon_clear_matches_button = "clearSelectionButton"
#$tranrecon_reconcile_button = "reconcileButton"
#$tranrecon_save_popup_save_button = "savePopupButton"
#$tranrecon_reconcile_popup_reconcile_button = "reconcilePopupButton"
#$tranrecon_save_or_reconcile_popup_cancel_button = "cancelPopupButton"
#$tranrecon_unreconcile_popup_unreconcile_button 
################################################################
	def TRANRECON.click_button button_name
		SF.execute_script do 
			SF.retry_script_block do
				button = $tranrecon_button.sub($sf_param_substitute, button_name)
				find(button).click
			end
		end
	end
	def TRANRECON.is_button_disabled? button_name
		return page.has_css? ($tranrecon_button_disabled.sub($sf_param_substitute, button_name))
	end
	def TRANRECON.is_button_displayed? button_name
		return page.has_css? ($tranrecon_button.sub($sf_param_substitute, button_name))
	end
	
############# Click on Continue button when batch is running for volume data#####################	
	def TRANRECON.click_continue_button
		SF.retry_script_block do
			find($tranrecon_continue_button).click
		end
	end
	
############# Select the filter option From-To for GLA or Period#####################
	def TRANRECON.click_gla_filter_fromto_button filter_popup_name
		filter_popup_name = $tranrecon_gla_selection_toggle_button.sub($sf_param_substitute, filter_popup_name)
		SF.retry_script_block do
			find(filter_popup_name).click
			find(:xpath,$tranrecon_from_to_label).click
		end
	end
	
	def TRANRECON.click_period_filter_fromto_button filter_popup_name
		filter_popup_name = $tranrecon_period_selection_toggle_button.sub($sf_param_substitute, filter_popup_name)
		SF.retry_script_block do
			find(filter_popup_name).click
			find(:xpath,$tranrecon_from_to_label).click
		end
	end
############# Resolve column #####################
	def TRANRECON.get_column table, row_number, column_type
		row_number = row_number.to_s
		column_number = TRANRECON.get_column_number_by_header_name table, column_type
		field = $tranrecon_grid_column.sub($sf_param_substitute, table).sub($sf_param_substitute, row_number).sub($sf_param_substitute, column_number.to_s)
		if column_type.casecmp('Date') == 0 || column_type.casecmp('Description') == 0 || column_type.casecmp('Currency') == 0  || column_type.casecmp('Amount') == 0 || column_type.casecmp('Checkbox') == 0
			field = field
		elsif column_type.casecmp('Document Reference') == 0 || column_type.casecmp('Intercompany Transfer') == 0 || column_type.casecmp($tranrecon_tli_column_header_label) == 0
			field = field + " a"
		end
		return field
	end
	
	def TRANRECON.click_on_column_header table,header_name
		header_field = $tranrecon_grid_header_column_name.sub($sf_param_substitute, table).sub($sf_param_substitute,header_name)
		SF.retry_script_block do
			find(header_field).click
		end
	end
	
	def TRANRECON.get_column_number_by_header_name table, header_name
		header_name = header_name.downcase
		header_field = $tranrecon_grid_header_column.sub($sf_param_substitute, table)
		all_header_cols_in_grid =  all(header_field)
		col_num=1
		if header_name.casecmp('Checkbox') == 0
			if table.casecmp($tranrecon_left_table) == 0
				return 8
			elsif table.casecmp($tranrecon_right_table) == 0
				return 1
			end
		else
			all_header_cols_in_grid.each do |header_col|  
				col_header_name = header_col.text
				col_header_name = col_header_name.downcase
				if (header_name.casecmp(col_header_name)==0)
					break
				end
				col_num+=1
			end
			if(table==$tranrecon_right_table)
				return col_num+1
			else
				return col_num
			end
		end	
	end	
############### Get Column Number by Column Header Name ##################
############################################# Get grid Column Value ######################################################
# table - leftTable, rightTable
# row_number - row number
# column_number - column number for which you want the get the value
# column_type - Date, Document Reference, Description, Intercompany Transfer, Transaction Line, Currency, Amount, Checkbox
##########################################################################################################################
	def	TRANRECON.get_grid_column_value table, row_number, column_type
		field = get_column table, row_number, column_type
		find(field).text
	end
############# Select row for reconciliation Process ##############
# table - $tranrecon_left_table = leftTable, $tranrecon_right_table = rightTable
# row_number - row number
##################################################################
	def TRANRECON.select_row_for_reconciliation table, row_number
		field = String.new
		field = get_column table, row_number, "Checkbox"
		table_element = $tranrecon_table.sub($sf_param_substitute, table)
		line = TRANRECON.reconciliation_find_line table_element, row_number
		classes = line[:class]
		if not(classes.include? 'selected')
			find(field).click
		end	
	end
	def TRANRECON.reconciliation_unselect_line table, row_number
		field = String.new
		field = get_column table, row_number, "Checkbox"
		table_element = $tranrecon_table.sub($sf_param_substitute, table)
		line = TRANRECON.reconciliation_find_line table_element, row_number
		classes = line[:class]
		if classes.include? 'selected'
			find(field).click
		end	
	end
	def TRANRECON.reconciliation_find_line table, row_number
		SF.execute_script do
			within(table) do
				return all($tranrecon_tli_table_line)[row_number - 1]
			end
		end
	end
	def TRANRECON.line_references_equal? table, row_number, number_of_references
		table_element = $tranrecon_table.sub($sf_param_substitute, table)
		links = TRANRECON.reconciliation_find_line(table_element, row_number).all('a').to_a
		if links.length != number_of_references
			return false
		end

		links.each do |one_link|
			text_to_check = one_link.text
			one_link.click
			gen_wait_for_new_window
			within_window(windows.last) do
				if find('h2.pageDescription').text != text_to_check
					return false
				end
				page.current_window.close
			end
		end

		return true
	end
	def TRANRECON.line_selected? table, row_number, selected
		SF.execute_script do
			table_element = $tranrecon_table.sub($sf_param_substitute, table)
			classes = TRANRECON.reconciliation_find_line(table_element, row_number)[:class]
			is_selected = classes.include? 'selected'
			return selected == is_selected
		end
	end
	def TRANRECON.lines_selected? table, lines
		lines.each do |one_line|
			if !(TRANRECON.line_selected? table, one_line, true)
				return false
			end
		end
		return true
	end

	def TRANRECON.no_lines_selected? table
		table_element = $tranrecon_table.sub($sf_param_substitute, table)
		return !(find(table_element).has_selector? $tranrecon_tli_table_line + ".f-grid-item-selected")
	end
############## Select all rows for reconciliation ################
# $tranrecon_left_table = "leftTable"
# $tranrecon_right_table = "rightTable"
##################################################################
	def TRANRECON.select_all_rows_for_reconciliation table
		select_all_checkbox = $tranrecon_grid_select_all_checkbox.sub($sf_param_substitute, table)
		find(select_all_checkbox).click
	end
############## Wait for Loading icon to disappear ################
	def TRANRECON.wait_for_loading
		SF.execute_script do 
			if page.has_xpath?($tranrecon_loading_icon)
				puts "Waiting for Loading to complete."
				gen_wait_until_object_disappear $tranrecon_loading_icon
				puts "Loding completed."
			else
				puts "No Loading icon found."
			end	
		end
	end	
############## Wait for list view to appear ####################
def TRANRECON.wait_for_list_view
	gen_wait_for_text "Transaction Reconciliation Name"
end	
############### Clear pre populated period ########################
	def TRANRECON.clear_pre_populated_period panel
		close_button = $tranrecon_prepopulated_period_close_button.sub($sf_param_substitute, panel)
		find(close_button).click
	end
############### Get Reconciliation Information from Transaction Line Item in the grid ##########################
# field_name - should be the field label of the field of Transaction Line Item whose value you want to get
# is_field_a_lookup - boolean paramenter, pass 'true' if the field mentioning the 'field_name' is of lookup type else pass 'false'
################################################################################################################
	def TRANRECON.get_transaction_line_reconciliation_info table, row_number, field_name, is_field_a_lookup
		tli_column = TRANRECON.get_column table, row_number, "Transaction Line"	
		find(tli_column).click
		FFA.new_window do
			gen_wait_until_object $tranrecon_tli_header_2_text
			field = $tranrecon_tli_field.sub($sf_param_substitute, field_name)
			if is_field_a_lookup == true
				field = field +"/a"
			end
			return find(field).text
		end
	end
	
#################### Click on a TLI in a particular row ############################
	def TRANRECON.click_tli_in_a_grid table, row_number
		tli_column = TRANRECON.get_column table, row_number, "Transaction Line"	
		find(tli_column).click
	end
#################### Get TLI field value #########################
	def TRANRECON.get_tli_field_value field_name, is_field_value_a_lookup
		field = $tranrecon_tli_field.sub($sf_param_substitute, field_name)
			if is_field_value_a_lookup == true
				field = field +"/a"
			end
		return find(:xpath, field).text
	end	
################# List View Methods #########################
################# Get Transaction Reconciliation Status by Reconciliation Name ###################
	def TRANRECON.get_tr_status_from_list_view recon_name
		column_number_recon_name = gen_get_column_number_in_grid "Reconciliations Name"
		row_number = gen_get_row_number_in_grid  recon_name, column_number_recon_name
		column_number_status = gen_get_column_number_in_grid "Status"
		field = String.new
		if row_number == 1
			field = $tranrecon_first_row_column.sub($sf_param_substitute, column_number_status.to_s)
		elsif row_number > 1
			field = $page_grid_row_pattern.sub($sf_param_substitute, row_number.to_s).sub($sf_param_substitute, column_number_status.to_s)+" div"
		end	
		return find(field).text
	end
################## Get Transaction Reconciliation Name column value by Reconciliations Name ###################################
 	def TRANRECON.get_transaction_reconciliation_number_from_list_view recon_name
		column_number_recon_name = gen_get_column_number_in_grid "Reconciliations Name"
		row_number = gen_get_row_number_in_grid  recon_name, column_number_recon_name
		column_number = gen_get_column_number_in_grid "Transaction Reconciliation Name"
		field = String.new
		if row_number == 1
			field = $tranrecon_first_row_column.sub($sf_param_substitute, column_number.to_s) + " span"
		elsif row_number > 1
			field = $page_grid_row_pattern.sub($sf_param_substitute, row_number.to_s).sub($sf_param_substitute, column_number.to_s)+" div span"
		end	
		return find(field).text
	end
################## Go to Transaction Reconciliation Detail Page by Name ######################
	def TRANRECON.go_to_transaction_reconciliation_from_list_view recon_name
		column_number_recon_name = gen_get_column_number_in_grid "Reconciliations Name"
		row_number = gen_get_row_number_in_grid  recon_name, column_number_recon_name
		column_number_tran_recon_name = gen_get_column_number_in_grid "Transaction Reconciliation Name"
		field = String.new
		if row_number == 1
			field = $tranrecon_first_row_column.sub($sf_param_substitute, column_number_tran_recon_name.to_s) + " a"
		elsif row_number > 1
			field = $page_grid_row_pattern.sub($sf_param_substitute, row_number.to_s).sub($sf_param_substitute, column_number_tran_recon_name.to_s)+" div a"
		end	
		find(field).click
	end
#################### Check if result retrieved in table ###################
# table_name = $tranrecon_left_table, $tranrecon_right_table
##################################################################
	def TRANRECON.any_results_found_in_table? table_name
		field = $tranrecon_no_results_found_element.sub($sf_param_substitute, table_name)
		return page.has_xpath?(field)
	end	
##### click Microsoft Excel (.xls) option to Export reconciled/saved transaction line items #####
	def TRANRECON.click_microsoft_excel_export_data_button
		find(:xpath, $tranrecon_export_data_microsoft_excel_button).click
		gen_wait_less # wait for the new window to open which will initiate the process of downlaoding document
		gen_wait_for_download_to_complete
	end
	  
##### click Adobe PDF (.pdf) option to Export reconciled/saved transaction line items ######
	def TRANRECON.click_adobe_pdf_export_data_button
		find(:xpath, $tranrecon_export_data_adobe_pdf_button).click	
		sleep 1 # wait for the new window to appear before switching on it.
	end

################################### Select show filter ##############################################
# pane :- choose from - $tranrecon_left_panel, $tranrecon_right_panel
# value :- choose from - $tranrecon_show_filter_show_all, $tranrecon_show_filter_show_selected, $tranrecon_show_filter_show_deselected
# for example - TRANRECON.select_show_filter_in_pane $tranrecon_left_panel, $tranrecon_show_filter_show_selected
#####################################################################################################
	def TRANRECON.select_show_filter_in_pane pane, value
		within(pane) do
			find($tranrecon_show_filter).click
			find($tranrecon_show_filter).set(value)
			find($tranrecon_show_filter).native.send_keys(:enter)
		end
	end
################################ Methods moved from Intercompany helper #######################################

####################################### Check Retrieved amount #######################################
# summary_panel - $tranrecon_left_summary_panel, $tranrecon_right_summary_panel
# total_retrieved - Decimal amount to be compared with the Retrieved amount exist in the given summary_panel
############################################################################################################
    def TRANRECON.summary_panel_total_retrieved_equal? summary_panel, total_retrieved
        within(summary_panel) do
            found_total_retrieved = find($tranrecon_summary_panel_retrieved_value).text
            return found_total_retrieved == gen_locale_format_number(total_retrieved)
        end
    end
####################################### Check Remaining (Unreconciled) amount #######################################
# summary_panel - $tranrecon_left_summary_panel, $tranrecon_right_summary_panel
# unreconciled_amount - Decimal amount to be compared with the Remaining amount exist in the given summary_panel
############################################################################################################
    def TRANRECON.summary_panel_remaining_amount_equal? summary_panel, unreconciled_amount
        within(summary_panel) do
            found_total_remaining = find($tranrecon_summary_panel_remaining_value).text
            return found_total_remaining == gen_locale_format_number(unreconciled_amount)
        end
    end
####################################### Check Selected (Reconciled) amount #######################################
# summary_panel - $tranrecon_left_summary_panel, $tranrecon_right_summary_panel
# reconciled_amount - Decimal amount to be compared with the Remaining amount exist in the given summary_panel
############################################################################################################
    def TRANRECON.summary_panel_selected_amount_equal? summary_panel, reconciled_amount
        within(summary_panel) do
            found_total_selected = find($tranrecon_summary_panel_selected_value).text
			if(reconciled_amount != "-")
				return found_total_selected == gen_locale_format_number(reconciled_amount)
			else
				return found_total_selected == reconciled_amount
			end	
        end
    end
################################################# compare values of tli existing in the table ################################################
# pane = $tranrecon_left_panel, $tranrecon_right_panel
# expected_lines = arrays of values to be expected in multiple lines for ex. 
# MERLIN_AUTO_SPAIN_LINES2 = [
#			[CURRENT_DATE, 'CSH', 'CE IC Line 1', 'ICT', '', 'EUR', gen_locale_format_number(-100.23)],
#			[CURRENT_DATE, 'JNL', 'JRN Line 4 with very long description. This text should make an ellipsis appear and we\'ll be able to see the rest of the text by hovering the field.', '', '', 'EUR', gen_locale_format_number(-110.23)]
#		]
# expected_lines = MERLIN_AUTO_SPAIN_LINES2
##############################################################################################################################################
	def TRANRECON.pane_lines_equal? pane, expected_lines
		SF.execute_script do
			within(pane) do
				existent_lines = all($tranrecon_tli_table_line).to_a
				if existent_lines.length != expected_lines.length
					puts "Transaction Reconciliation: Number of Lines Mismatch: Expected : #{expected_lines.length} Actual :#{existent_lines.length}"
					return false
				end
				expected_lines.each do |one_expected_line|
					following_line = existent_lines.shift
					actual_line_value = following_line.text
					one_expected_line.each do |one_expected_value|
						if !(actual_line_value.include? one_expected_value)
							puts "Transaction Reconciliation: Line Data Mismatch: Expected content: #{one_expected_value} in :#{actual_line_value}"
							return false
						end
					end
				end
			end
		end
		return true
	end
####################### Methods to check value in saved Filter section #############################
# pane = $tranrecon_left_panel, $tranrecon_right_panel
####################################################################################################	
	def TRANRECON.pane_company_equals? pane, company
		within(pane) do
			company_name = find($tranrecon_filter_company).text
			return company_name == company
		end
	end
	
	def TRANRECON.pane_account_equals? pane, account
		within(pane) do
			account_name = find($tranrecon_filter_account).text
			return account_name == account
		end
	end

	def TRANRECON.pane_gla_equals? pane, gla
		within(pane) do
			gla_name = find($tranrecon_filter_gla).text
			return gla_name == gla
		end
	end
	
	def TRANRECON.pane_period_equals? pane, period
		within(pane) do
			period_name = find($tranrecon_filter_period).text
			return period_name == period
		end
	end
	
	def TRANRECON.found_result_count_equals? pane, expected_number_of_records
		within(pane) do
			actual_number_of_records = find($tranrecon_fount_results_count).text
			return actual_number_of_records == expected_number_of_records
		end
	end
	
	def TRANRECON.tab_title_equals? title
		return find($tranrecon_tab_title).text == title
	end
################### Compare retrieve popup filter picklist values #####################
# filter_popup - $tranrecon_left_filter, $tranrecon_right_filter
# popup - $tranrecon_left_filter, $tranrecon_right_filter
# field_name - $tranrecon_company_label = "Company", $tranrecon_gla_label = "GLA", 
#				$tranrecon_account_label = "Account", $tranrecon_period_label = "Period"
# values - values will be a list of expected values for example - 
# [$company_merlin_auto_spain, $company_merlin_auto_usa] for company picklist
#######################################################################################
	def TRANRECON.is_filter_pop_up_opened? filter_popup
		popup = $tranrecon_closed_filter_popup.sub($sf_param_substitute, filter_popup)
		return page.has_no_css?(popup)
	end
	
	def TRANRECON.picklist_not_empty? popup, field_name
		if TRANRECON.is_filter_pop_up_opened? popup
			field = String.new
			if field_name.casecmp('Company') == 0
				field = $tranrecon_company_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('Period') == 0	
				field = $tranrecon_period_multiselect_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('PeriodFrom') == 0	
				field = $tranrecon_period_from_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('PeriodTo') == 0	
				field = $tranrecon_period_to_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('GLA') == 0	
				field = $tranrecon_gla_multiselect_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('GLAFrom') == 0	
				field = $tranrecon_gla_from_field.sub($sf_param_substitute, popup)	
			elsif field_name.casecmp('GLATo') == 0	
				field = $tranrecon_gla_to_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('Account') == 0	
				field = $tranrecon_account_field.sub($sf_param_substitute, popup)
			end
			field = field.split(" input")[0]
			#find(field.to_s).click
			within(field) do
				find($tranrecon_filters_picklist_click).click
			end
			list_elements = all($tranrecon_filters_picklist_list_element)
			within(field) do
				find($tranrecon_filters_picklist_click).click
			end
			return list_elements.length > 0
		end	
	end

	def TRANRECON.picklist_empty? popup, field_name
		if TRANRECON.is_filter_pop_up_opened? popup
			field = String.new
			if field_name.casecmp('Company') == 0
				field = $tranrecon_company_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('Period') == 0	
				field = $tranrecon_period_multiselect_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('PeriodFrom') == 0	
				field = $tranrecon_period_from_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('PeriodTo') == 0	
				field = $tranrecon_period_to_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('GLA') == 0	
				field = $tranrecon_gla_multiselect_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('GLAFrom') == 0	
				field = $tranrecon_gla_from_field.sub($sf_param_substitute, popup)	
			elsif field_name.casecmp('GLATo') == 0	
				field = $tranrecon_gla_to_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('Account') == 0	
				field = $tranrecon_account_field.sub($sf_param_substitute, popup)
			end
			field = field.split(" input")[0]
			#find(field.to_s).click
			within(field) do
				find($tranrecon_filters_picklist_click).click
			end
			list_elements = all($tranrecon_filters_picklist_list_element)
			within(field) do
				find($tranrecon_filters_picklist_click).click
			end
			return list_elements.length == 0
		end
	end

	def TRANRECON.picklist_values_equal? popup, field_name, values
		if TRANRECON.is_filter_pop_up_opened? popup
			field = String.new
			if field_name.casecmp('Company') == 0
				field = $tranrecon_company_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('Period') == 0	
				field = $tranrecon_period_multiselect_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('PeriodFrom') == 0	
				field = $tranrecon_period_from_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('PeriodTo') == 0	
				field = $tranrecon_period_to_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('GLA') == 0	
				field = $tranrecon_gla_multiselect_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('GLAFrom') == 0	
				field = $tranrecon_gla_from_field.sub($sf_param_substitute, popup)	
			elsif field_name.casecmp('GLATo') == 0	
				field = $tranrecon_gla_to_field.sub($sf_param_substitute, popup)
			elsif field_name.casecmp('Account') == 0	
				field = $tranrecon_account_field.sub($sf_param_substitute, popup)
			end
			field = field.split(" input")[0]
			#find(field.to_s).click
			within(field) do
				find($tranrecon_filters_picklist_click).click
			end
			list_elements = all($tranrecon_filters_picklist_list_element).to_a
			list_values = []
			list_elements.each do |one_list_element|
				list_values.push(one_list_element.text)
			end
			within(field) do
				find($tranrecon_filters_picklist_click).click
			end
			# Comparing the expected and actual values irrespective of order they appearing.
			if !((list_values.sort).eql? (values.sort))
				return false
			end
			return true
		end
	end
	
	def TRANRECON.tli_tables_columns_equal? panel, expected_columns
		existent_line_columns = TRANRECON.reconciliation_get_pane_line_columns panel
			if !(existent_line_columns.sort == expected_columns.sort)
				return false
			end
		return true
	end
	
	def TRANRECON.reconciliation_get_pane_line_columns pane
		within(pane) do
			within($tranrecon_matching_screen_pane_line_header) do
				columns = all($tranrecon_matching_screen_pane_line_header_column).to_a
				column_names = []
				columns.each do |element|
					if element.text.strip != "" and element[:style]!="display: none;"
						column_names << element.text
					end
				end
				return column_names
			end
		end
	end
	
	def TRANRECON.no_companies?
		# Not the best way to check the picklist is empty, but it was impossible due to Sencha removing the list.
		Capybara.ignore_hidden_elements = false
		found = page.has_content? 'Merlin'
		Capybara.ignore_hidden_elements = true

		return !found
	end
	
##
# Method Summary: Returns the count of GLA's present in the input field
#
# @param [String] gla_list to pass the list of gla's 
#
	def TRANRECON.reconciliation_get_matched_count_gla popup, gla_list
		num_of_field_present_in_picklist = 0
		if TRANRECON.is_filter_pop_up_opened? popup
			field = $tranrecon_gla_multiselect_field.sub($sf_param_substitute, popup)
		    gla_list.each do |value|
			find(field).set(value)
			gen_wait_less #list takes few seconds to load.
			gen_tab_out field  
			picklist_filtered_value = $tranrecon_picklist_value_pattern.sub($sf_param_substitute,value.to_s)    
				if page.has_xpath?(picklist_filtered_value)
				num_of_field_present_in_picklist+=1
				SF.log_info "value is present in picklist: "+value
				else 
				SF.log_info "Value is not present in picklist: "+ value
				end
		   end
		   return num_of_field_present_in_picklist
		end
	end
end