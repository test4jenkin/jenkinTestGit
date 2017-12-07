# FinancialForce.com, inc. claims copyright in this software, its screen display designs and
# supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
# Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
# result in criminal or other legal proceedings.
# Copyright FinancialForce.com, inc. All rights reserved.

module Intercompany
extend Capybara::DSL

	#############################
	# Intercompany
	#############################

	##################################################
	# Selectors Group Structure
	##################################################

	$INTERCOMPANY_MENU_OPTION_VIEW_COMPANY_DETAILS = FFA.fetch_label 'GroupStructureCompanyMenuOptionDetails'
	$INTERCOMPANY_MENU_OPTION_VIEW_ALL_COMPANY_OWNERS = FFA.fetch_label 'GroupStructureCompanyMenuOptionOwners'
	$INTERCOMPANY_MENU_OPTION_VIEW_ALL_COMPANY_SUBSIDIARIES = FFA.fetch_label 'GroupStructureCompanyMenuOptionSubsidiaries'
=begin	$INTERCOMPANY_RECONCILIATION_TABLE_DATE_COLUMN = FFA.fetch_label 'TransactionReconciliationPageDateColumn'
	$INTERCOMPANY_RECONCILIATION_TABLE_DOCREF_COLUMN = FFA.fetch_label 'TransactionReconciliationPageDocReferenceColumn'
	$INTERCOMPANY_RECONCILIATION_TABLE_DESCRIPTION_COLUMN = FFA.fetch_label 'TransactionReconciliationPageDescriptionColumn'
	$INTERCOMPANY_RECONCILIATION_TABLE_ICT_COLUMN = FFA.fetch_label 'TransactionReconciliationPageICTColumn'
	$INTERCOMPANY_RECONCILIATION_TABLE_TLI_COLUMN = FFA.fetch_label 'TransactionReconciliationPageTLIColumn'
	$INTERCOMPANY_RECONCILIATION_TABLE_CURRENCY_COLUMN = FFA.fetch_label 'TransactionReconciliationPageCurrencyColumn'
	$INTERCOMPANY_RECONCILIATION_TABLE_AMOUNT_COLUMN = FFA.fetch_label 'TransactionReconciliationPageTitleAmountColumn'
=end
	$intercompany_grouped_tree_node = "div[data-ffxtype='centerpanel'] div[data-ffxtype='treechart'] a"
	$intercompany_ungrouped_tree_node = "div[data-ffxtype='footerpanel'] div[data-ffxtype='treechart'] a"
	$intercompany_tree_node = "//div[@data-ref='body']//a"
	$intercompany_relations_popup = "div[data-ffxtype='detailswindow']"
	$intercompany_relations_popup_body = "div[data-ffxtype='detailswindow'] div[data-ffxtype='tableview']"
	$intercompany_relations_popup_title = "div[data-ffxtype='detailswindow'] div[data-ffxtype='title'] div"
	$intercompany_relations_popup_row = "div[data-ffxtype='detailswindow'] tr"
	$intercompany_relations_popup_close_button = "//div[@data-ffxtype='detailswindow']//div[contains(@class, 'close')]"

	##################################################
	# Methods Group Structure
	##################################################

	def Intercompany.get_grouped_tree_nodes
		return all($intercompany_grouped_tree_node)
	end

	def Intercompany.get_ungrouped_tree_nodes
		return all($intercompany_ungrouped_tree_node)
	end

	def Intercompany.get_all_tree_nodes
		return all(:xpath, $intercompany_tree_node)
	end

	def Intercompany.find_node_with_name name
		return find(:xpath, $intercompany_tree_node + '[contains(text(),"' + name + '")]')
	end

	def Intercompany.get_node_name node
		return node.text
	end

	def Intercompany.close_relations_popup
		find(:xpath, $intercompany_relations_popup_close_button).click
	end

	###########################################################
	# - For Transaction Reconciliation,
	#		please use transactionreconciliation_helper.rb
	# - Selectors and Methods related to Transaction Reconciliation
	# 		process are commented for now in this helper 
	#		and will be removed once all the changes are done.
	##########################################################
=begin
	$TAB_INTERCOMPANY_RECONCILIATION_NAME = FFA.fetch_label #######

	$intercompany_reconciliation_filters_set = "div[data-ffid='leftFilter'] div[data-ref='body'], div[data-ffid='rightFilter'] div[data-ref='body']"
	$intercompany_reconciliation_filters_company_picklist = "div[data-ffid='Company']"
	$intercompany_reconciliation_filters_gla_picklist = "div[data-ffid='GLA']"
	@intercompany_reconciliation_filters_account_picklist = "div[data-ffid='Accounts'][data-ffxtype='combobox']"
	$intercompany_reconciliation_filters_left_pane_company_picklist = "div[data-ffid='leftPanel'] div[data-ffid='Company']"
	$intercompany_reconciliation_filters_picklist_click = "div[class*='arrow-trigger']"
	$intercompany_reconciliation_filters_picklist_input = "input"
	$intercompany_reconciliation_filters_picklist_list_element = "div[data-ffxtype='boundlist'] li"
	$intercompany_reconciliation_filters_left_pane_gla_picklist = "div[data-ffid='leftPanel'] div[data-ffid='GLA']"
	$intercompany_reconciliation_filters_left_pane_account_picklist = "div[data-ffid='leftPanel'] div[data-ffid='Accounts']"
	$intercompany_reconciliation_filters_left_pane_period_picklist = "div[data-ffid='leftPanel'] div[data-ffid='Period']"
	$intercompany_reconciliation_filters_period_picklist = "div[data-ffid='Period']"
	$intercompany_reconciliation_filters_picklist_option = "div[@data-ffxtype='boundlist']"
	$intercompany_reconciliation_filters_right_pane_company_picklist = "div[data-ffid='rightPanel'] div[data-ffid='Company']"
	$intercompany_reconciliation_filters_right_pane_gla_picklist = "div[data-ffid='rightPanel'] div[data-ffid='GLA']"
	$intercompany_reconciliation_filters_right_pane_period_picklist = "div[data-ffid='rightPanel'] div[data-ffid='Period']"
	$intercompany_reconciliation_filters_right_pane_account_picklist = "div[data-ffid='rightPanel'] div[data-ffid='Accounts']"
	$intercompany_reconciliation_matching_screen = "div[data-ffid='leftPanel'] div[data-ffid='leftTable'], div[data-ffid='rightPanel'] div[data-ffid='rightTable']"
	$intercompany_reconciliation_matching_screen_pane_company = "div[class='TREC-filter-header'] span:nth-child(1)"
	$intercompany_reconciliation_matching_screen_pane_gla = "div[class='TREC-filter-header'] span:nth-child(3)"
	$intercompany_reconciliation_matching_screen_pane_account = "div[class='TREC-filter-header'] span:nth-child(4)"
	$intercompany_reconciliation_matching_screen_left_pane_filter = "div[data-ffid='leftPanel'] div[data-ffid='selectionField']"
	$intercompany_reconciliation_matching_screen_right_pane_filter = "div[data-ffid='rightPanel'] div[data-ffid='selectionField']"
	$intercompany_reconciliation_matching_screen_left_pane_results_count = "div[data-ffid='leftPanel'] div[data-ffid='searchStatusBar']"
	$intercompany_reconciliation_matching_screen_right_pane_results_count = "div[data-ffid='rightPanel'] div[data-ffid='searchStatusBar']"
	#$intercompany_reconciliation_matching_screen_pane_retrieved_lines = "div[data-ffid='summaryTransactionSelected'] span[class*='amount']"
	$intercompany_reconciliation_matching_screen_pane_total_retrieved = "div[data-ffid = 'summary'] tr:nth-child(3) td:nth-child(2)"
	#$intercompany_reconciliation_matching_screen_pane_unreconciled = "div[data-ffid='summaryUnreconciled'] span[class*='amount']"
	#$intercompany_reconciliation_matching_screen_pane_reconciled = "div[data-ffid='summaryReconciled'] span[class*='amount']"
	$intercompany_reconciliation_matching_screen_pane_line = "div[id^='reconciliation-table'] div[data-ffxtype='tableview'] table"
	$intercompany_reconciliation_matching_screen_pane_line_checkbox = "div[class$='grid-row-checker']"
	$intercompany_reconciliation_matching_screen_pane_line_cell = "td[class$='grid-td']"
	$intercompany_reconciliation_matching_screen_pane_line_header = "div[data-ffxtype='headercontainer']"
	$intercompany_reconciliation_matching_screen_pane_line_header_column = "div[data-ffxtype$='column']"
	$intercompany_reconciliation_matching_screen_pane_period = "div[class='TREC-filter-header'] span:nth-child(2)"
	$intercompany_reconciliation_matching_screen_left_pane = "div[data-ffid='leftPanel']"
	$intercompany_reconciliation_matching_screen_right_pane = "div[data-ffid='rightPanel']"
	$intercompany_reconciliation_matching_screen_tab_title = "div[data-ffxtype='appnamelabel']"
	$intercompany_reconciliation_help_button = "a[data-ffxtype='helpbutton']"
	$intercompany_reconciliation_maximize_button = "a[data-ffxtype='fillbutton']"
	$intercompany_reconciliation_retrieve_button = "a[data-ffid='retriveButton']"
	$intercompany_reconciliation_run_auto_match_button = "a[data-ffid='autoMatchButton']"
	$intercompany_reconciliation_clear_button = "a[data-ffid='clearSelectionButton']"
	$intercompany_picklist_value_pattern = "//li/div[(text()='"+$sf_param_substitute+"')]"
	$intercompany_reconciliation_toggle_filters_button = "a[data-ffid='toggleFilterButton']"
=end
	##################################################
	# Methods Reconciliation
	##################################################
=begin ### these methods have been moved to transactionreconciliation_helper.rb
	def Intercompany.reconciliation_find_line pane, line_number
		SF.execute_script do
			within(pane) do
				return all($intercompany_reconciliation_matching_screen_pane_line)[line_number - 1]
			end
		end
	end

	def Intercompany.reconciliation_get_pane_line_columns pane
		within(pane) do
			within($intercompany_reconciliation_matching_screen_pane_line_header) do
				columns = all($intercompany_reconciliation_matching_screen_pane_line_header_column).to_a
				column_names = []
				columns.each do |element|
					if element.text.strip != ""
						column_names << element.text
					end
				end
				return column_names
			end
		end
	end
=end
=begin ### no need of these methods now
	def Intercompany.picklist_select_option picklist, option
		SF.execute_script do
			within(picklist) do
				find($intercompany_reconciliation_filters_picklist_input).set(option)
				find(:xpath, "//li[contains(text(),'" + option + "')]").click
			end
		end
	end

	def Intercompany.reconciliation_select_left_company company_name
		gen_wait_until_object_disappear $page_loadmask_message
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_left_pane_company_picklist, company_name
	end

	def Intercompany.reconciliation_select_left_gla gla_name
		gen_wait_until_object_disappear $page_loadmask_message
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_left_pane_gla_picklist, gla_name
	end
	##
	# Method Summary: Returns the count of GLA's present in the input field
	#
	# @param [String] gla_list to pass the list of gla's 
	#
	def Intercompany.reconciliation_get_matched_count_gla gla_list
		num_of_field_present_in_picklist = 0
		gla_list.each do |value|
			within($intercompany_reconciliation_filters_left_pane_gla_picklist) do				
				find($intercompany_reconciliation_filters_picklist_input).set(value)
				gen_wait_less #list takes few seconds to load.
				gen_tab_out $intercompany_reconciliation_filters_picklist_input				
				picklist_filtered_value = $intercompany_picklist_value_pattern.sub($sf_param_substitute,value.to_s)				
				if page.has_xpath?(picklist_filtered_value)
					num_of_field_present_in_picklist+=1
					SF.log_info "value is present in picklist: "+value
				else	
					SF.log_info "Value is not present in picklist: "+ value
				end				
			end
		end
		return num_of_field_present_in_picklist
	end
	
	def Intercompany.reconciliation_select_left_filter filter_name
		Intercompany.picklist_select_option $intercompany_reconciliation_matching_screen_left_pane_filter, filter_name
	end	
	
	def Intercompany.reconciliation_select_right_filter filter_name
		Intercompany.picklist_select_option $intercompany_reconciliation_matching_screen_right_pane_filter, filter_name
	end
	
	def Intercompany.reconciliation_select_left_account account_name
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_left_pane_account_picklist, account_name
	end
	
	def Intercompany.reconciliation_select_right_account account_name
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_right_pane_account_picklist, account_name
	end

	def Intercompany.reconciliation_select_left_period period_name
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_left_pane_period_picklist, period_name
	end

	def Intercompany.reconciliation_select_right_company company_name
		gen_wait_until_object_disappear $page_loadmask_message
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_right_pane_company_picklist, company_name
	end

	def Intercompany.reconciliation_select_right_gla gla_name
		gen_wait_until_object_disappear $page_loadmask_message
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_right_pane_gla_picklist, gla_name
	end

	def Intercompany.reconciliation_select_right_period period_name
		Intercompany.picklist_select_option $intercompany_reconciliation_filters_right_pane_period_picklist, period_name
	end

	def Intercompany.reconciliation_toggle_select_line pane, line_number
		within(Intercompany.reconciliation_find_line pane, line_number) do
			find($intercompany_reconciliation_matching_screen_pane_line_checkbox).click
		end
	end
	### This method has been moved transactionreconciliation_helper.rb with name TRANRECON.select_row_for_reconciliation
	def Intercompany.reconciliation_select_line pane, line_number
		line = Intercompany.reconciliation_find_line pane, line_number
		classes = line[:class]
		if not(classes.include? 'selected')
			Intercompany.reconciliation_toggle_select_line pane, line_number
		end
	end
	### This method has been moved transactionreconciliation_helper.rb with name TRANRECON.reconciliation_unselect_line
	def Intercompany.reconciliation_unselect_line pane, line_number
		line = Intercompany.reconciliation_find_line pane, line_number
		classes = line[:class]
		if classes.include? 'selected'
			Intercompany.reconciliation_toggle_select_line pane, line_number
		end
	end
	
	def Intercompany.reconciliation_toggle_filters
		find($intercompany_reconciliation_toggle_filters_button).click
	end

	def Intercompany.reconciliation_retrieve
		SF.execute_script do
			find($intercompany_reconciliation_retrieve_button).click
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		end
	end

	def Intercompany.reconciliation_run_auto_match
		SF.execute_script do
			find($intercompany_reconciliation_run_auto_match_button).click
		end
		gen_wait_less
	end

	def Intercompany.reconciliation_clear
		find($intercompany_reconciliation_clear_button).click
	end
=begin ### Methods moved to transactionreconciliation_helper.rb
	def Intercompany.line_references_equal? pane, line_number, number_of_references
		links = Intercompany.reconciliation_find_line(pane, line_number).all('a').to_a
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

	def Intercompany.line_selected? pane, line, selected
		SF.execute_script do
			classes = Intercompany.reconciliation_find_line(pane, line)[:class]
			is_selected = classes.include? 'selected'
			return selected == is_selected
		end
	end

	def Intercompany.pane_company_equals? pane, company
		within(pane) do
			company_name = find($intercompany_reconciliation_matching_screen_pane_company).text
			return company_name == company
		end
	end
	
	def Intercompany.pane_account_equals? pane, account
		within(pane) do
			account_name = find($intercompany_reconciliation_matching_screen_pane_account).text
			return account_name == account
		end
	end

	def Intercompany.pane_gla_equals? pane, gla
		within(pane) do
			gla_name = find($intercompany_reconciliation_matching_screen_pane_gla).text
			return gla_name == gla
		end
	end
	### This method has been moved to transactionreconciliation_helper.rb with name TRANRECON.pane_lines_equal?
	def Intercompany.pane_lines_equal? pane, expected_lines
		SF.execute_script do
			within(pane) do
				existent_lines = all($intercompany_reconciliation_matching_screen_pane_line).to_a
				if existent_lines.length != expected_lines.length
					puts "Transaction Reconciliation: Number of Lines Mismatch: Expected : #{expected_lines.length} Actual :#{existent_lines.length}"
					return false
				end
				expected_lines.each do |one_expected_line|
					following_line = existent_lines.shift
					one_expected_line.each do |one_expected_value|
						if !(following_line.has_content? one_expected_value)
							puts "Transaction Reconciliation: Line Data Mismatch: Expected content: #{one_expected_value} in :#{following_line}"
							return false
						end
					end
				end
			end
		end
		return true
	end

	def Intercompany.pane_period_equals? pane, period
		within(pane) do
			period_name = find($intercompany_reconciliation_matching_screen_pane_period).text
			return period_name == period
		end
	end

	def Intercompany.tab_title_equals? title
		return find($intercompany_reconciliation_matching_screen_tab_title).text == title
	end
	
	def Intercompany.left_search_result_count_equals? pane, expected_number_of_records
		within(pane) do
			actual_number_of_records = find($intercompany_reconciliation_matching_screen_left_pane_results_count).text
			return actual_number_of_records == expected_number_of_records
		end
	end
	
	def Intercompany.right_search_result_count_equals? pane, expected_number_of_records
		within(pane) do
			actual_number_of_records = find($intercompany_reconciliation_matching_screen_right_pane_results_count).text
			return actual_number_of_records == expected_number_of_records
		end
	end

	def Intercompany.tli_tables_columns_equal? expected_columns
		panes = [$intercompany_reconciliation_matching_screen_left_pane, $intercompany_reconciliation_matching_screen_right_pane]
		panes.each do |one_pane|
			existent_line_columns = Intercompany.reconciliation_get_pane_line_columns one_pane
			if !(existent_line_columns.sort == expected_columns.sort)
				return false
			end
		end

		return true
	end

=begin ### This functionality has been removed due to new UI amendments.	
	def Intercompany.pane_transactions_retrieved_equal? pane, number_of_lines
		within(pane) do
			retrieved_lines = find($intercompany_reconciliation_matching_screen_pane_retrieved_lines).text
			return retrieved_lines == number_of_lines
		end
	end
=end	
=begin ### This method has been moved to transactionreconciliation_helper.rb with name TRANRECON.summary_panel_total_retrieved_equal?
	def Intercompany.pane_total_retrieved_equal? pane, total_retrieved
		within(pane) do
			found_total_retrieved = find($intercompany_reconciliation_matching_screen_pane_total_retrieved).text
			return found_total_retrieved == gen_locale_format_number(total_retrieved)
		end
	end
=end
=begin ### This method has been moved to transactionreconciliation_helper.rb with name TRANRECON.summary_panel_remaining_amount_equal?
	def Intercompany.pane_unreconciled_equals? pane, unreconciled_amount
		within(pane) do
			found_unreconciled_amount = find($intercompany_reconciliation_matching_screen_pane_unreconciled).text
			return found_unreconciled_amount == gen_locale_format_number(unreconciled_amount)
		end
	end
=end
=begin ### This method has been moved to transactionreconciliation_helper.rb with name TRANRECON.summary_panel_selected_amount_equal?
	def Intercompany.pane_reconciled_equals? pane, reconciled_amount
		within(pane) do
			found_reconciled_amount = find($intercompany_reconciliation_matching_screen_pane_reconciled).text
			return found_reconciled_amount == gen_locale_format_number(reconciled_amount)
		end
	end

	def Intercompany.company_picklists_equals? number_of_picklists		
		picklists = all($intercompany_reconciliation_filters_company_picklist)		
		return picklists.length == number_of_picklists
	end

	def Intercompany.gla_picklists_equals? number_of_picklists
		picklists = all($intercompany_reconciliation_filters_gla_picklist)
		return picklists.length == number_of_picklists
	end
	
	def Intercompany.account_picklists_equals? number_of_picklists
		picklists = all($intercompany_reconciliation_filters_account_picklist)
		return picklists.length == number_of_picklists
	end

	def Intercompany.period_picklists_equals? number_of_picklists
		picklists = all($intercompany_reconciliation_filters_period_picklist)
		return picklists.length == number_of_picklists
	end

	def Intercompany.picklist_not_empty? picklist
		all_picklists = all(picklist)
		all_picklists.each do |one_picklist|
			within(one_picklist) do
				find($intercompany_reconciliation_filters_picklist_click).click
			end
			list_elements = all($intercompany_reconciliation_filters_picklist_list_element)
			within(one_picklist) do
				find($intercompany_reconciliation_filters_picklist_click).click
			end
			return list_elements.length > 0
		end
	end

	def Intercompany.picklist_empty? picklist
		all_picklists = all(picklist)
		all_picklists.each do |one_picklist|
			within(one_picklist) do
				find($intercompany_reconciliation_filters_picklist_click).click
			end
			list_elements = all($intercompany_reconciliation_filters_picklist_list_element)
			within(one_picklist) do
				find($intercompany_reconciliation_filters_picklist_click).click
			end
			return list_elements.length == 0
		end
	end

	def Intercompany.picklist_values_equal? picklist, values
		all_picklists = all(picklist)
		all_picklists.each do |one_picklist|
			within(one_picklist) do
				find($intercompany_reconciliation_filters_picklist_click).click
			end
			list_elements = all($intercompany_reconciliation_filters_picklist_list_element).to_a
			list_values = []
			list_elements.each do |one_list_element|
				list_values.push(one_list_element.text)
			end

			within(one_picklist) do
				find($intercompany_reconciliation_filters_picklist_click).click
			end

			if !(list_values.eql? values)
				return false
			end
		end

		return true
	end

	def Intercompany.no_companies?
		# Not the best way to check the picklist is empty, but it was impossible due to Sencha removing the list.
		Capybara.ignore_hidden_elements = false
		found = page.has_content? 'Merlin'
		Capybara.ignore_hidden_elements = true

		return !found
	end
=begin ### Methods moved to transactionreconciliation_helper.rb
	def Intercompany.lines_selected? pane, lines
		lines.each do |one_line|
			if !(Intercompany.line_selected? pane, one_line, true)
				return false
			end
		end
		return true
	end

	def Intercompany.no_lines_selected? pane
		return !(find(pane).has_selector? $intercompany_reconciliation_matching_screen_pane_line + ".selected")
	end
=end
end
