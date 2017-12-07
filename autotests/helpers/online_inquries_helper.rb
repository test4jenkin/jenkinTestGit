 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

# Note : Online Inquries has been renamed to Action Views its just been a lable change every where in code its referred as online inquries

module OLI
extend Capybara::DSL
#############################
# online Inquries   (Action Views)
#############################
# run the online inquries by clicking on inquiry template name 
###################################################
# Selectors 
###################################################
# icons 
$online_inquiries_header_sort_icon = "span#toolsAndSettingsHeaderSortIcon"
$online_inquiries_header_filter_icon = "span#toolsAndSettingsHeaderFilterIcon"
$online_inquiries_header_column_filter_icon = "span[class$=image-filter]"
$online_inquiries_header_drill_icon = "span[class$=drill-indicator]"
$online_inquiries_header_formatting_icon = "span[class$=image-formatting]"

# buttons 
$online_inquiries_prompt_select_button = "a[data-ffid=promptSelectButton]"
$online_inquiries_prompt_reset_button = "a[data-ffid=promptResetButton]"
$online_inquiries_prompt_cancel_button = "a[data-ffid=promptCancelButton]"
$online_inquiries_start_action = "img[data-qtip='Start Action']"

$online_inquiries_grand_total_checkbox = "table[data-ffid=grandTotals] input"
$online_inquiries_summarize_duplicate_rows_table ="table[data-ffid=aggregationCheckBox]" 
$online_inquiries_summarize_duplicate_rows_table_checkbox =$online_inquiries_summarize_duplicate_rows_table+" "+"input" 

$online_inquiries_filter_button = "a[data-ffid=applyFilterButton]"
$online_inquiries_clear_button = "a[data-ffid=clearFilterButton]"
$online_inquiries_retrieve_retrieve_button = "a[data-ffid=retrieveButton]"
$online_inquiries_retrieve_reset_button = "a[data-ffid=resetRetrieveButton]"

# Objects 
$online_inquiries_tab = "a[data-ffxtype=tab]:nth-of-type(nnn)"
$online_inquiries_tabs = "a[data-ffxtype=tab]"
$online_inquiries_tab_new =  "[data-ffid=addTab]"
$online_inquiries_tab_close = "a[data-ffxtype=tab]:nth-of-type(nnn) > span[class=f-tab-close-btn]" 
$online_inquiries_new_tab_inquiry_template = "[data-ffid=addNewTabCombo] input"
$online_inquiries_new_tab_ok = "a[data-ffid=addNewTabOkButton]"
$online_inquiries_new_tab_cancel = "a[data-ffid=addNewTabCancelButton]"
$online_inquiries_actions = "div[data-ffid=toolsAndSettingsActionsPanel]"

# online inquiries Tool bar 
$online_inquiries_toolbar_button_not_selected = "[class$=selector]" # grey
$online_inquiries_toolbar_button_selected = "[class$=selector-selected]" # blue 
$online_inquiries_toolbar_button_active = "[class$=selector-active]" # yellow 
$online_inquiries_toolbar_filter = "div[data-ffid=filterSetting] span"
$online_inquiries_toolbar_sort = "div[data-ffid=sortSetting] span"
$online_inquiries_toolbar_show_hide = "div[data-ffid=showHideSetting] span"
$online_inquiries_toolbar_grand_total = "div[data-ffid=grandTotals] span"
$online_inquiries_toolbar_summarize = "div[data-ffid=aggregation] span"
$online_inquiries_toolbar_show_document_count = "div[data-ffid=showDocumentCount] span"
$online_inquiries_toolbar_auto_scroll = "div[data-ffid=autoScroll] span"
$online_inquiries_toolbar_view_rcp = "div[data-ffid=rcpSetting] span"
$online_inquiries_toolbar_my_settings = "div[data-ffid=mySettings] span"
$online_inquiries_toolbar_remember = "div[data-ffid=rememberMySettingsMenuItem] span"
$online_inquiries_toolbar_restore = "div[data-ffid=restoreMySettingsMenuItem] span"
$online_inquiries_toolbar_reset = "div[data-ffid=resetSettingsToDefaultMenuItem] span"
$online_inquiries_toolbar_action = "div[data-ffid=actionTool] span"
$online_inquiries_toolbar_query = "div[data-ffid=soqlQueryButton] span"
$online_inquiries_toolbar_export = "div[data-ffid=exportTool] span"
$online_inquiries_toolbar_retrieve = "div[data-ffid=retrieveTool] span"
$online_inquiries_toolbar_message_toaster = "div[data-ffid=saveSettingsToaster]"


# online inquiries 
# online inquiries prompt screen 
$online_inquiries_prompt_panel = "div[data-ffid='promptFilterPanel']"
$online_inquiries_prompt_title = $online_inquiries_prompt_panel + " > div:first-child"
$online_inquiries_prompt_all_fields = "label[data-ffid=promptFieldLabel]"
$online_inquiries_prompt_all_operators = "label[data-ffid=promptOperator]"
$online_inquiries_prompt_all_fields_values = " table[data-ffid=promptFromValue] input"

# online inquries sort tab
# shared objects with  Sorting and grouping component

# online inquries Query tab
$online_inquiries_query = "div[data-ffid=soqlQueryWindow]:not([style='display: none;'])"
$online_inquiries_query_field = $online_inquiries_query + " " + "[data-ffid=displaySoqlQueryField]"

# Grid 
$online_inquiries_grid_main = "div[data-ffid=inquirygrid]"
$online_inquiries_active_tab = "[data-ffxtype=avGridTab]:not([style*='display: none;'])"
$online_inquiries_flag_column_header = "div[data-ffid=actionViewsFlag] span"
$online_inquiries_grid = "div[data-ffid=inquirygrid]" 
$online_inquiries_table = $online_inquiries_grid + " table"
$online_inquiries_grid_all_rows = $online_inquiries_grid+" tr"
$online_inquiries_grid_all_rows_no_grand_totals = "div[data-ffid=inquirygrid] div[data-ffxtype='tableview'] table"
$online_inquiries_grid_flagged_row =  "div img[class$='grid-flag-row']"
$online_inquiries_grid_not_flagged_row = "div img[class='undefined']"
$online_inquiries_grid_not_flaggable_row = "ffrrcp-grid-check-disabled"
$online_inquiries_grid_grand_total_row = "div[data-ffid=summaryBar] table tbody tr"
$online_inquiries_grid_header = "//div[@data-ffid='inquirygrid']//div[@data-ffxtype='headercontainer']"

# grid menu
$online_inquiries_grid_menu = "div[data-ffxtype='menu']" 
$online_inquiries_grid_menu_columns = "div[data-ffid='columnItem'] a"
$online_inquiries_grid_menu_formatting = "div[data-ffid='MenuItemCF'] a"
$online_inquiries_grid_menu_checked_items = "//div[@data-ffxtype='menucheckitem']"
$online_inquiries_grid_menu_items = "//div[@data-ffxtype='menuitem']"

# Actions 
$online_inquiries_actions_grid = "div[data-ffid=toolsAndSettingsActionsGrid]"
$online_inquiries_action_due_date_parameter = "[data-ffid='DUEDATE'] input"
$online_inquiries_action_parameter_ok = "a[data-ffid=parameterSelectButton]"
$online_inquiries_action_parameter_cancel = "a[data-ffid=parameterCancelButton]"
$online_inquries_undo_reason = "input[name='Undo Reason']"

# Action Views Import / Export Action Views 
#Export 
## replace $sf_param_substitute with checkbox label to access that checkbox.
$online_inquiries_results_export_options_checkbox_pattern = "//label[text()='"+$sf_param_substitute+"']/ancestor::div[1]/input"
$online_inquiries_results_export_options_checkbox_pattern_span = "//label[text()='"+$sf_param_substitute+"']/ancestor::div[1]/span"

# Button 
$online_inquiries_export_button  = "a[data-ffid=exportButton]"
$online_inquiries_export_download_button  = "a[data-ffid=exportButtonFile]"

# Objects
$online_inquiries_export_export_name = "[data-ffid=nameField] input"
$online_inquiries_export_all_check_box = "div[data-ffid = availableTemplateSelection] span"
$online_inquiries_export_avaliable_template_grid = "[data-ffid=availableTemplateGrid] table"
$online_inquiries_export_selected_template_grid = "[data-ffid=selectedTemplateBaggageGrid] table"
$online_inquiries_export_all_baggage_grid =  "[data-ffid=allBaggageGrid] table"

# Import 
# Button 
$online_inquiries_import_upload_button  = "a[data-ffid=importButtonFile]"
$online_inquiries_import_file_button  = "div[data-ffid=selectFileButton] input"
#Objects  
$online_inquiries_import_avaliable_template_grid = "[data-ffid=availableTemplateGrid]"
$online_inquiries_import_selected_template_grid = "[data-ffid=selectedTemplateBaggageGrid]"
$online_inquiries_import_all_baggage_grid =  "[data-ffid=allBaggageGrid]"

# Related Content pane Run time 
$online_inquiries_rcp_menu = "[data-ffid=rcpMenuRadio]"
$online_inquiries_rcp_menu_items = "[data-ffid=rcpSelection]"
$online_inquiries_rcp_menu_items_button = "//label[text()='nnn']/preceding-sibling::input"
$online_inquiries_rcp_panel = "div[data-ffid=rcppanel]"
$online_inquiries_rcp_select_list = "table[data-ffid=rcpCombo] input"
$online_inquiries_rcp_label = "div[data-ffid=rcpPanelLabel]"
$online_inquiries_rcp_close_button = "a[data-ffid=rcpclosebutton]"
$online_inquiries_rcp_refresh_button = "a[data-ffid=rcprefreshbutton]"
$online_inquiries_rcp_fields_label =  $online_inquiries_rcp_panel+ " div[data-ffxtype=panel] [data-ffxtype=header] "
$online_inquiries_rcp_ghost_component = $online_inquiries_rcp_panel + " " + "div[data-ffid$=Card] div[class*='rcp-ghost-component']"
$online_inquiries_rcp_alert_icon = $online_inquiries_rcp_panel + " " + "div[data-ffid$=Card] div[class*='image-rcp-alert']"
$online_inquiries_rcp_error_message  = $online_inquiries_rcp_panel + " " + "div[data-ffid$=Card] label[class*='rcp-info-component-label']"
$online_inquiries_rcp_component_right_handle = "div[class*='rcp-component-drag-right']"
$online_inquiries_rcp_component_left_handle ="div[class*='rcp-component-drag-left']"
$online_inquiries_rcp_address_card = "div[data-ffxtype=addressCard]"
$online_inquiries_rcp_address_edit = "div[data-ffid='rcpAddressEdit'] img[class*='f-tool-rcp-edit']"
$online_inquiries_rcp_address_map_link = "div[class*=rcp-address-maptoggle]"
$online_inquiries_rcp_address_google_map = "div[data-ffid=googleMapCard]"
$online_inquiries_rcp_display_field = "div[id*='displayfield']"
$online_inquiries_rcp_save_button = "a[data-ffid=saveButton]"
$online_inquiries_rcp_cancel_button = "a[data-ffid=cancelButton]"
$online_inquiries_rcp_contacts = $online_inquiries_rcp_panel + " " + "div[data-ffid='contactCard'] div[class*='rcp-contacts-card-outer']"
$online_inquiries_rcp_contacts_edit = "div[class*='rcp-contacts-edit']"
$online_inquiries_rcp_glow_ccolumn = "div[class*='RCP-column-glow']"
$online_inquiries_rcp_address_components = "div[data-ffxtype=addressCard]"
$online_inquiries_rcp_contact_components = "div[data-ffid=IdContacts]"
$online_inquiries_rcp_chatter_iframe = "div[data-ffid='chatterFrame'] iframe"
$online_inquiries_rcp_chatter_newpage_links = "a:not([href^='javascript']) "
$online_inquiries_rcp_matchcomp_document_view = "div[data-ffid=matchedDocumentView]"
$online_inquiries_rcp_matchcomp_document_view_all_links = $online_inquiries_rcp_matchcomp_document_view + " a"
$online_inquiries_rcp_matchcomp_source_doc  = "div[data-ffid=sourceDocumentView]"
$online_inquiries_rcp_matchcomp_match_history  = "div[data-ffid=matchingHistoryList]"
$online_inquiries_rcp_matchcomp_history_back = "div[class=ffarcp-matching-history-back]"
$online_inquiries_rcp_matchcomp_show_more_link = "div[class='ffarcp-matching-history-show-more ffarcp-fake-anchor']"
$online_inquiries_rcp_matchcomp_show_related_link = "div[class='ffarcp-matching-history-show-related ffarcp-fake-anchor']"
$online_inquiries_rcp_matchcomp_status = "div[class*='ffarcp-matching-history-payment-status']"
$online_inquiries_rcp_search_input = "div[data-ffid=searchBar] input"
$online_inquiries_rcp_search_input_button = "[data-ffid=filterText] div[id*=search]"
$online_inquiries_rcp_search_from_date = "[data-ffid=fromDate] input"
$online_inquiries_rcp_search_to_date = "[data-ffid=toDate] input"
$online_inquiries_rcp_search_grid = "div[data-ffid=accountDocumentGrid]"
$online_inquiries_rcp_search_grid_rows = $online_inquiries_rcp_search_grid + "  tr"

Small = "Small"
Medium = "Medium"
Large = "Large"
LeftHandle = "left"
RightHandle = "right"
BillingAddress = "Billing_Address"
ShippingAddress = "Shipping_Address"

###################################################
# Methods 
###################################################
	# Toolbar > Filter  
	def OLI.toolbar_filter
		find($online_inquiries_toolbar_filter).click 
		page.has_css? ($online_inquiries_clear_button)
	end 
	# Toolbar > sort 
	def OLI.toolbar_sort
		FFA.click_object_wait $online_inquiries_toolbar_sort
	end
	# Toolbar > show hide
	def OLI.toolbar_show_hide
		FFA.click_object_wait $online_inquiries_toolbar_show_hide
	end
	# Toolbar > grand totals
	def OLI.toolbar_grand_total
		FFA.click_object_wait $online_inquiries_toolbar_grand_total
	end
	# Toolbar > summarize
	def OLI.toolbar_summarize
		FFA.click_object_wait $online_inquiries_toolbar_summarize
	end
	# Toolbar > automatic scroll 
	def OLI.toolbar_auto_scroll
		FFA.click_object_wait $online_inquiries_toolbar_auto_scroll
	end
	# Toolbar > View RCP 
	def OLI.toolbar_show_rcp
		FFA.click_object_wait $online_inquiries_toolbar_view_rcp
	end

	# Tootbar > Save My Settings 
	def OLI.toolbar_save_settings
		find($online_inquiries_toolbar_remember).click
		FFA.wait_for_popup_msg_sync $ffa_msg_saving_your_settings
		page.has_css?($online_inquiries_toolbar_message_toaster)
	end 
	#  Toolbar > -  Restore My Settings
	def OLI.toolbar_restore_settings
		find($online_inquiries_toolbar_restore).click
		FFA.wait_for_popup_msg_sync $ffa_msg_loading_metadata
		page.has_css?($online_inquiries_toolbar_message_toaster)
		gen_wait_less
	end 
	#  Toolbar > - Reset Settings to Default
	def OLI.toolbar_reset_settings
		find($online_inquiries_toolbar_reset).click
		page.has_css? ($page_sencha_popup_ok)
		FFA.sencha_popup_click_ok
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
		page.has_css?($online_inquiries_toolbar_message_toaster)
	end 
	#  Toolbar > Action
	def OLI.toolbar_action
		FFA.click_object_wait $online_inquiries_toolbar_action
	end
	#  Tootbar > Query
	def OLI.toolbar_query
		FFA.click_object_wait $online_inquiries_toolbar_query
	end
	#  Tootbar > Export 
	def OLI.toolbar_export
		FFA.click_object_wait $online_inquiries_toolbar_export
	end 
	#  Tootbar > Retrieve  
	def OLI.toolbar_retrieve
		find($online_inquiries_toolbar_retrieve).click 
		page.has_css? ($online_inquiries_retrieve_retrieve_button)
	end 

	def OLI.run inq_template_name
		SF.execute_script do
			within("div.apexp") do
				gen_click_link_and_wait inq_template_name
			end 	
			FFA.wait_for_popup_msg_sync $ffa_msg_loading
		end
	end
	#Document count  button
	def OLI.click_document_count
		find($online_inquiries_toolbar_show_document_count).click
	end
	def OLI.get_column_titles
 		return find(:xpath,$online_inquiries_grid_header).text 
 	end 

	# edit the selected inquiry template from OLI (Action views)
	def OLI.edit_inquiry_template
		FFA.toolbar_edit
		page.has_css?($inquiry_template_dataview)
	end
	# run oli when there are prompts on inquiry templae and wait for select button
	def OLI.run_with_prompts inq_template_name
		within("div.apexp") do
			gen_click_link_and_wait inq_template_name
		end
		page.has_css? $online_inquiries_prompt_select_button
	end
	# set the selector /prompt value on prompt page for online inquries 
	def OLI.prompt_set_selector selector_name , selector_value
		begin 
			input_object = find(:xpath , "//label[text()='#{selector_name}']/following-sibling::div//input")
		rescue 
			input_object = find(:xpath , "//label[text()='#{selector_name}']/following-sibling::div//textarea")
		end 
		input_object.set selector_value
	end
	# remove selector /prompt on prompt page for online inquries 
	def OLI.prompt_remove_selector selector_name
		input_object = find(:xpath , "//label[text()='#{selector_name}']/following-sibling::div[@data-ffid='promptRemove']/a/span")
		input_object.click
	end
	# return the no of selectors / prompts 
	def OLI.prompt_get_selector
		selector = all($online_inquiries_prompt_all_fields)
		return selector.size
	end 
	# return all the selectors titles(in grey bar)
	def OLI.get_prompt_titles
		titles = Array.new 
			alltitles  = all($online_inquiries_prompt_title)
			alltitles.each do |title|
				titles.push(title.text)
			end
		return  titles
	end 

	def OLI.prompt_click_button_select 
		find($online_inquiries_prompt_select_button).click
		gen_wait_less
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end 

	def OLI.click_button_reset 
		find($online_inquiries_prompt_reset_button).click
		sleep 5 
	end 

	def OLI.click_button_cancel
		find($online_inquiries_prompt_cancel_button).click
	end 
	# Main online inquries screen  

	# open new tab
	def OLI.new_tab 
		find($online_inquiries_tab_new).click
		page.has_css? $online_inquiries_new_tab_inquiry_template
	end 
	# set inquiry template and click ok
	def OLI.new_tab_set_inquiry_template inquiry_template
		find($online_inquiries_new_tab_inquiry_template).set inquiry_template
		gen_tab_out $online_inquiries_new_tab_inquiry_template
		find($online_inquiries_new_tab_ok).click 
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end 
	# open a tab by index
	def OLI.open_tab tab_number
		find($online_inquiries_tab.sub "nnn",tab_number.to_s).click 
	end 

	def OLI.close_tab tab_number
		find($online_inquiries_tab_close.sub "nnn",tab_number.to_s).click 
	end 

	# return data for whole grid
	def OLI.get_grid_data
		return find($online_inquiries_grid).text
	end
	# return data for specified row
	def OLI.get_grid_data_row rowNumber
		SF.execute_script do
			return find($online_inquiries_grid+" table:nth-of-type(#{rowNumber})" + " "+ "tr").text
		end
	end
	# return data for specified row in table 
	def OLI.get_table_data_row rowNumber
		return find($online_inquiries_table+":nth-of-type(#{rowNumber})").text
	end

	# return total no of rows (Grand total row not included)
	def OLI.get_grid_rows 
		SF.execute_script do
			rows = all($online_inquiries_grid_all_rows_no_grand_totals)
			return rows.size
		end
	end
	# Return the grand row totals
	def OLI.get_grand_totals 
		return  find($online_inquiries_grid_grand_total_row).text 
	end
	# sort by column header just by clicking on it 
	def OLI.sort_by_column sort_by_column_header_name
		FFA.click_tab_by_label sort_by_column_header_name
		gen_wait_less
	end 

	# Filter - Apply filter 
	def OLI.click_apply_filter
		find($online_inquiries_filter_button).click 
		gen_wait_less
	end 
	# Online Inquries > Tools and Settings  > Filter - Clear button 
	def OLI.filter_click_clear
		find($online_inquiries_clear_button).click 
		gen_wait_less
	end 
	# Filter Methods 
	# set the filter by draging the column name in the filter component (online inquries)
	def OLI.set_filter field ,operator , value_from , value_to 
		filter_col = FFA.get_column_by_header field
		dropzone = find($selection_component_filter_drop_zone)
		gen_drag_drop filter_col, dropzone
		FFA.selection_component_filter_edit
		FFA.selection_component_set_filter_operator operator
		if value_from != nil
			FFA.selection_component_set_filter_value_from value_from
		end	
		if value_to != nil
			FFA.selection_component_set_filter_value_to value_to
		end 
		find($selection_component_filter_criteria_ok).click 
		gen_wait_less
		OLI.click_apply_filter
	end 
	# Set the filter for flagged column (drag and set the values provided)
	def OLI.set_filter_for_flag_col operator, value_from
		filter_col = find($online_inquiries_flag_column_header)
		dropzone = find($selection_component_filter_drop_zone)
		gen_drag_drop filter_col, dropzone
		FFA.selection_component_filter_edit
		FFA.selection_component_set_filter_operator operator
		if value_from == true 
			find($selection_component_filter_criteria_value_from).click
		end 
		find($selection_component_filter_criteria_ok).click 
		gen_wait_less 
		OLI.click_apply_filter
	end 

	# Sort - Add Sort
	def OLI.sort_click_button_add_sort
		InquiryTemplate.sort_click_button_add_sort
	end 
	#  Sort - Clear Sort
	def OLI.sort_click_button_clear_sort
		InquiryTemplate.sort_click_button_clear_sort
	end 
	#  Sort - Apply Sort
	def OLI.sort_click_button_apply_sort
		SF.execute_script do
			find($sorting_grouping_apply_sort_button).click
		end
		gen_wait_less
	end 
	# Sort remove
	def OLI.sort_remove column_no 
		InquiryTemplate.sort_remove column_no 
	end 
	#  Sort - Move Up
	def OLI.sort_move_up column_no 
		InquiryTemplate.move_sort_up column_no 
	end 
	# Sort - Move Down 
	def OLI.sort_move_down column_no 
		InquiryTemplate.sort_move_down column_no 
	end 
	# Sort - set sort column
	def OLI.set_sort_field column_no,sort_field
		InquiryTemplate.set_sort_field column_no,sort_field
	end 
	# Sort - Set the display field  
	def OLI.set_sort_field column_no,sort_field
		InquiryTemplate.set_sort_field column_no,sort_field
	end 
	# Sort - Set the sort Order field 
	def OLI.set_sort_order column_no,sort_by
		InquiryTemplate.set_sort_order column_no,sort_by
	end
	#  Sort - Check Group By
	def OLI.click_group_by column_no
		InquiryTemplate.click_group_by column_no
	end
	# Sort - Check hide
	def OLI.click_hide column_no
		InquiryTemplate.click_hide column_no
	end
	# Add a sort field with possible values 
	def OLI.add_sort column_no,sort_by_field , sort_order , group_by , hide_details , apply_sort
		InquiryTemplate.add_sort column_no,sort_by_field , sort_order , group_by , hide_details
		if apply_sort == true 
			OLI.sort_click_button_apply_sort
		end 	
	end 

	# drag a column in the sort area 
	def OLI.sort_drag_column column_header
		filter_col = FFA.get_column_by_header column_header
		dropzone = find($sorting_grouping_area_drop_zone)
		gen_drag_drop filter_col, dropzone
	end

	# Retrieve - Retrieve
	def OLI.retrieve_click_button_retrieve
		find($online_inquiries_retrieve_retrieve_button).click 
		gen_wait_less
	end 
	# Retrieve -  Reset button
	def OLI.retrieve_click_button_reset
		find($online_inquiries_retrieve_reset_button).click 
		gen_wait_less
	end 
	# Query 
	def OLI.get_query
		return find($online_inquiries_query_field).text
	end 
	# Flagging on the Grid 
	# flag the the row on grid by the row number 
	def OLI.set_flag_for_row  rowNumber
		return find($online_inquiries_table + ":nth-of-type(#{rowNumber}) "+ "tr td:nth-of-type(1)").click
	end
	# check that the row is flagged 
	def OLI.check_row_flagged rowNumber
		flag_column = 1 
		rc = page.has_css?($online_inquiries_table + ":nth-of-type(#{rowNumber}) "+ "tr td:nth-of-type(#{flag_column})"+" "+$online_inquiries_grid_flagged_row)
		return rc 
	end 
	# check that row is not flagged 
	def OLI.check_row_not_flagged rowNumber
		flag_column = 1 
		rc = page.has_css?($online_inquiries_table + ":nth-of-type(#{rowNumber}) "+ "tr td:nth-of-type(#{flag_column})"+" "+$online_inquiries_grid_not_flagged_row)
		return rc 
	end 
	# check that the row is not flaggable 
	def OLI.check_row_not_flaggable rowNumber
		flag_column = 1 
		rc = page.has_css?($online_inquiries_table + ":nth-of-type(#{rowNumber}) "+ "tr td:nth-of-type(#{flag_column})"+"[class*=#{$online_inquiries_grid_not_flaggable_row}]")
		return rc 

	end 
	
	# open /launch menu from the column header
	# column_name is the name of column from where to access the menu
	def OLI.column_header_menu_open column_name
		begin 
			find(:xpath , $online_inquiries_grid_header+"//span[text()='#{column_name}']").click 
			find(:xpath , $online_inquiries_grid_header+"//span[text()='#{column_name}']/following::div").click 
		rescue 
			find(:xpath , $online_inquiries_grid_header+"//div[text()='#{column_name}']").click 
			find(:xpath , $online_inquiries_grid_header+"//div[text()='#{column_name}']/following::div").click 
		end 
	end 
	# select an option from the column header menu
	# menu_option is the option to choose from menu
	def OLI.column_header_menu column_name , menu_option
		OLI.column_header_menu_open column_name
		if menu_option != "Show Errors"
			within($online_inquiries_grid_menu) do 
				find(:xpath ,$online_inquiries_grid_menu_items + "//span[text()='#{menu_option}']").click
			end 
		else 
			within($online_inquiries_grid_menu) do 
				find(:xpath ,$online_inquiries_grid_menu_checked_items + "//span[text()='#{menu_option}']").click
			end 
		end 
	end 
	# Hide or Un Hide columns 
	def OLI.column_header_menu_hide_unhide column_name , menu_option 
		OLI.column_header_menu_open column_name
		within($online_inquiries_grid_menu) do 
			find($online_inquiries_grid_menu_columns).click
			find(:xpath ,$online_inquiries_grid_menu_checked_items + "//span[text()='#{menu_option}']").click
		end 
	end 
	
	# Conditional Formatting
	def OLI.column_header_menu_formatting column_name , menu_option 
		OLI.column_header_menu_open column_name
		within($online_inquiries_grid_menu) do 
			find($online_inquiries_grid_menu_formatting).click
			find(:xpath ,$online_inquiries_grid_menu_items + "//span[text()='#{menu_option}']").click
		end 
	end
	def OLI.formatting_click_button_ok
		InquiryTemplate.formatting_click_button_ok
	end 
	# set the formatting for a column in OLI(Action voew)
	def OLI.column_conditional_formatting column, operator, value_from , value_to , text_color_true,fill_color_true,text_color_false,fill_color_false
		OLI.column_header_menu_formatting column, "Edit column"
		InquiryTemplate.formatting_set_operator operator
		InquiryTemplate.formatting_set_from_value value_from
		if value_to != nil 
			InquiryTemplate.formatting_set_to_value value_to
		end 
		if text_color_true != nil 
			InquiryTemplate.formatting_set_text_color_condition_true text_color_true
		end 
		if fill_color_true != nil 
			InquiryTemplate.formatting_set_fill_color_condition_true fill_color_true
		end 
		if text_color_false != nil 
			InquiryTemplate.formatting_set_text_color_condition_false text_color_false
		end 
		if fill_color_false != nil 
			InquiryTemplate.formatting_set_fill_color_condition_false fill_color_false
		end 
		InquiryTemplate.formatting_click_button_ok
	end

	# validate the formatting of cells in online inquries (text color and background color)
	def OLI.check_cell_formatting row , col , to_have_not_to_have, text_color , fill_color
		if text_color != nil
			text_color = "color:##{text_color};"
		end 
		if fill_color != nil
			fill_color = "background-color:##{fill_color}"
		end 
		style = String(text_color) + String(fill_color)
		SF.execute_script do
			if to_have_not_to_have == "to_have"
				return  page.has_css?($online_inquiries_grid_all_rows_no_grand_totals+":nth-of-type(#{row}) td:nth-of-type(#{col}) div[style*='#{style}']")
			elsif  to_have_not_to_have == "not_to_have"
				return page.has_css?($online_inquiries_grid_all_rows_no_grand_totals+":nth-of-type(#{row}) td:nth-of-type(#{col}) div[style*='#{style}']")
			end
		end
	end 
	
	def OLI.drill_on_cell row , col
		SF.execute_script do
			find($online_inquiries_grid_all_rows_no_grand_totals+":nth-of-type(#{row}) td:nth-of-type(#{col})").click 
			FFA.wait_for_popup_msg_sync $ffa_msg_loading
		end
	end

	def OLI.drill_ledger_inquiry row,col,inquiry_template 
		OLI.grid_cell_actions row , col , "right_click"
		gen_click_link_and_wait inquiry_template 
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end 

	def OLI.select_cell row , col 
		find($online_inquiries_table+":nth-of-type(#{row}) tr :nth-of-type(#{col})").click 
	end
	
	def OLI.grid_cell_actions row , col , action
		if action == "click" 
			find($online_inquiries_grid_all_rows_no_grand_totals+":nth-of-type(#{row}) td:nth-of-type(#{col})").click
		elsif action == "hover" 
			find($online_inquiries_grid_all_rows_no_grand_totals+":nth-of-type(#{row}) td:nth-of-type(#{col})").hover
		elsif action == "right_click" 
			el = page.driver.browser.find_element(:css , $online_inquiries_grid_all_rows_no_grand_totals+":nth-of-type(#{row}) td:nth-of-type(#{col})")
			page.driver.browser.action.context_click(el).perform
		end
	end 

# set the name for exported file	
	def OLI.set_template_results_export_file_name filename
		SF.execute_script do
			fill_in "Filename" , with: filename
		end
	end

# pass checkbox_labels as array.
	def OLI.check_export_options_checkbox checkbox_labels 
		SF.execute_script do
			checkbox_labels.each do |checkbox|
				begin 
					find(:xpath , $online_inquiries_results_export_options_checkbox_pattern.sub($sf_param_substitute,checkbox)).click
				rescue
					find(:xpath , $online_inquiries_results_export_options_checkbox_pattern_span.sub($sf_param_substitute,checkbox)).click
				end
			end
		end
	end
# click on export data button to export the template results	
	def OLI.click_inquiry_template_result_export_data_button
		SF.execute_script do
			find($online_inquiries_export_button).click
			FFA.wait_for_popup_msg_sync $ffa_msg_exporting
		end
		gen_wait_less # Wait for file to be exported successfully on machine.
	end

	# OLI Actions Tab 
	# click ook on action parameter popup
		# Start action
	def OLI.start_action_on_row row 
		find($online_inquiries_actions_grid+" tr:nth-of-type(#{row}) "+$online_inquiries_start_action).click
		page.has_css?($page_loadmask_message)
		FFA.wait_for_popup_msg_sync $ffa_msg_starting_action 
	end
	#Runs first action
	def OLI.start_action
		OLI.start_action_on_row 1
	end

	def OLI.action_parameter_ok 
		find($online_inquiries_action_parameter_ok).click 
		FFA.wait_for_popup_msg_sync $ffa_msg_starting_action 
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end 
	# click cancel on action parameter popup
	def OLI.action_parameter_cancel 
		find($online_inquiries_action_parameter_cancel).click 
	end 
	# set the new date for due date action in Action views 
	def OLI.action_set_due_date new_due_date
		find($online_inquiries_action_due_date_parameter).set new_due_date
		OLI.action_parameter_ok 
	end 

	def OLI.undo_reason undo_reason
		find($online_inquries_undo_reason).set undo_reason
	end
	# online inquries / Action Views export module 
	module OLI::Export
		extend Capybara::DSL
		# set the export name on export screen 
		def Export.set_export_name export_name
			find($online_inquiries_export_export_name).set export_name
		end 
		# check export all 
		def Export.check_export_all 
			find($online_inquiries_export_all_check_box).click
		end 
		def Export.click_download
			find($online_inquiries_export_download_button).click 
			FFA.wait_for_popup_msg_sync $ffa_msg_getting_templates
			gen_wait_less # wait for file to be downloaded.
		end 
	end 
	# online inquries / Action Views Import module 
	module OLI::Import
		extend Capybara::DSL
		def Import.upload
			find($online_inquiries_import_upload_button).click 
		end 
		def Import.browse_choose_file
			find($online_inquiries_import_file_button).click 
		end 
	end 

# RCP Panel related methods in action views 
	# get the filed value by it's name 
	def OLI.get_rcp_display_field_value field_name 
		selector = find(:ffid,field_name)
		return selector.find("[data-ffid='valueField']").text 
	end 
	# get the value for specified field
	def OLI.get_field_value field_name 
		selector = find("[data-ffid='#{field_name}']")
		return selector.find("input").value 
	end 
	# set the specified value for field
	def OLI.set_field_value field_name , field_value 
		selector = find("[data-ffid='#{field_name}']")
		return selector.find("input").set field_value
	end 
	# select rcp from the list
	def OLI.select_rcp rcp_name
		find($online_inquiries_toolbar_view_rcp).click 
		OLI.toolbar_show_rcp
		find($online_inquiries_rcp_menu).find($online_inquiries_rcp_menu_items).find(:xpath,($online_inquiries_rcp_menu_items_button.sub "nnn",rcp_name)).click 
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end 
	# get the rcp list items 
	def OLI.get_rcp_list
		listitems = find($online_inquiries_rcp_menu).all($online_inquiries_rcp_menu_items).collect(&:text)
		return listitems
	end 
	#  get the rcp header / label 
	def OLI.get_rcp_panel_label 
		return find($online_inquiries_rcp_label).text 
	end 
	#  Close rcp 
	def OLI.rcp_close
		find($online_inquiries_rcp_close_button).click 
		gen_wait_less
	end
	#  Refresh rcp 
	def OLI.rcp_refresh
		find($online_inquiries_rcp_refresh_button).click 
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end

	# Click rcp action coloum by row number 
	def OLI.open_rcp_by_row row 
		col = 1 
		find($online_inquiries_grid_all_rows_no_grand_totals+":nth-of-type(#{row}) td:nth-of-type(#{col}) img").click
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end 
	# Click rcp action coloum by searching value in a specified column 
	def OLI.open_rcp search_text , search_col
		row = gen_get_row_in_grid $online_inquiries_active_tab + " " + $online_inquiries_grid, search_text, search_col 
		OLI.open_rcp_by_row row 
	end  
	# click / choose tabs in rcp panel 
	def OLI.open_rcp_tab tab_name 
		within($online_inquiries_rcp_panel) do 
			FFA.click_tab_by_label tab_name
		end 
	end 
	# click popup Save Button 
	def OLI.rcp_popup_save_button
		find($online_inquiries_rcp_save_button).click 
		FFA.wait_for_popup_msg_sync $ffa_msg_saving
	end 
	# click popup Cancel Button 
	def OLI.rcp_popup_cancel_button
		find($online_inquiries_rcp_cancel_button).click 
	end 
	# get the no of single fields displayed on rcp
	def OLI.get_all_fields 
		fields  = all($online_inquiries_rcp_fields_label)
		return fields.size 
	end 
	# return then name of fileds displayed on the rcp 
	def OLI.get_all_fields_name 
		fields  = all($online_inquiries_rcp_fields_label)
		allfields = Array.new 
		fields.each {|x| allfields.push(x.text)}
		return allfields
	end 
	# get the error message on rcp tab
	def OLI.get_rcp_error_message 
		return find($online_inquiries_rcp_error_message).text 
	end 
	# calculate the rcp size at runtime 
	def OLI.calculate_rcp_size inquiryGridWidth , size 
		if size ==OLI::Small
			rcpSize = 2
		elsif size == OLI::Medium
			rcpSize = 4
		elsif size == OLI::Large
			rcpSize = 6
		end 
		expectedrcpwidth = (inquiryGridWidth.to_i / (rcpSize + (6 - rcpSize))) * rcpSize
		return expectedrcpwidth
	end 
	# get the actual size of rcp component 
	def OLI.get_rcp_size 
		width =  gen_get_element_style_property $online_inquiries_rcp_panel , "width" 
		return width.strip.to_i
	end 
	# get the tooltip on rcp fields 
	def OLI.get_rcp_field_quicktip  field_name
		selector = find("[data-ffid='#{field_name}']")
		selector.hover 
		rc  = gen_get_quick_tip
		return rc 
	end 
	# drag the resize handle to the other components to resize the component
	# source_component component name who's drag handle you want to drag
	# target_component name of component where to want to drop
	# which_handle left or right drang handle 
	def OLI.rcp_resize_component source_component, target_component , which_handle
		source  = find(:ffid,source_component)
		target = find(:ffid,target_component)
		source.hover 
		if which_handle == OLI::RightHandle
			handle = find($online_inquiries_rcp_component_right_handle)
		elsif which_handle == OLI::LeftHandle
			handle = find($online_inquiries_rcp_component_left_handle)
		end 
		gen_drag_drop handle , target
		sleep 0.5
	end 
	# Address Component 
	# get address at run time 
	def OLI.get_rcp_address address_field 
		selector = find(:ffid,address_field)
		return selector.text 
	end 
	# edit the address field 
	def OLI.rcp_click_edit_address address_field 
		selector = find(:ffid,address_field)
		selector.find($online_inquiries_rcp_address_edit).click 
	end 
	# edit the address field 
	def OLI.rcp_click_google_map address_field 
		selector = find(:ffid,address_field)
		selector.find($online_inquiries_rcp_address_map_link).click 
	end 
	# Edit the address at run time in actionviews 
	def OLI.edit_address address_type , street , city ,state , postcode , country , saveflag=true 
		# click edit button for address
		OLI.rcp_click_edit_address  address_type
		if address_type == OLI::BillingAddress 
			addressprefix = "Billing"
		elsif address_type == OLI::ShippingAddress 
			addressprefix = "Shipping"
		end 
		if street!= nil 
			OLI.set_field_value "#{addressprefix}Street" , street
		end 
		if city != nil 
			OLI.set_field_value "#{addressprefix}City" ,city
		end 

		if state != nil 
			OLI.set_field_value "#{addressprefix}State" , state
		end 

		if postcode != nil 
			OLI.set_field_value "#{addressprefix}PostalCode" ,postcode
		end 

		if country != nil
			OLI.set_field_value "#{addressprefix}Country" , country
		end 
		if saveflag == true  
			OLI.rcp_popup_save_button
		end 
	end 
	# contacts component
	# get all contacts
	def OLI.get_rcp_contacts  
		all_contacts = all($online_inquiries_rcp_contacts).collect(&:text)
		return all_contacts 
	end 
	# edit the contact by its name 
	def OLI.rcp_click_edit_contact contact_name 
		find(:div_by_value,contact_name).find($online_inquiries_rcp_contacts_edit).click 
	end 
	# edit contact at rutime in actionviews
	def OLI.rcp_edit_contact edit_contact_name ,first_name ,last_name , title , phone , email,saveflag=true 
		OLI.rcp_click_edit_contact  edit_contact_name
		if first_name != nil 
			OLI.set_field_value "FirstName" , first_name
		end 
		if last_name != nil 
			OLI.set_field_value "LastName" ,last_name
		end 
		if title != nil 
			OLI.set_field_value "Title" , title
		end 
		if phone != nil  
			OLI.set_field_value "Phone" , phone
		end 
		if email != nil  
			OLI.set_field_value "Email" , email
		end 
		if saveflag == true
			OLI.rcp_popup_save_button
		end 
	end 
	#######################
	# chatter compopnent 
	#######################
	# post in chatter rcp 
	def OLI.rcp_chatter_post post_text 
		chatter_rcp_frame = find($online_inquiries_rcp_chatter_iframe)
		within_frame(chatter_rcp_frame) do 
			Chatter.share_post post_text
		end 
	end 
	#######################
	# Matched Payment Component 
	#######################
	# get the details for source document 
	def OLI.rcp_matched_get_source_doc show_more = true 
		# by default always show more and get detail
		if show_more == true 
			OLI.rcp_matched_show_more_less "SOURCE"
		end 
		rc =  find($online_inquiries_rcp_matchcomp_source_doc).text 
		rc = FFA.substitute_document_number rc # strip out the documnets numbers
		return rc 
	end 
	# get the detial of matching history 
	def OLI.rcp_matched_get_matched_doc show_more = true 
		# by default always show more and get detail
		if show_more == true 
			OLI.rcp_matched_show_more_less "MATCHED"
		end 
		rc = find($online_inquiries_rcp_matchcomp_match_history).text 
		rc = FFA.substitute_document_number rc # strip out the documnets numbers
		return rc 
	end 
	# click button show more or show less in source documnet or matched documents
	def  OLI.rcp_matched_show_more_less source_history 
		if source_history.upcase == "SOURCE"
			within $online_inquiries_rcp_matchcomp_source_doc do 
				find($online_inquiries_rcp_matchcomp_show_more_link).click
			end 
		elsif source_history.upcase == "MATCHED"
			within $online_inquiries_rcp_matchcomp_match_history do 
				find($online_inquiries_rcp_matchcomp_show_more_link).click
			end 
		end 
	end 
	# click on the show matched to link 
	def OLI.rcp_matched_show_matched_to 
		find($online_inquiries_rcp_matchcomp_show_related_link).click 
		FFA.wait_page_message $ffa_msg_loading
	end 
	# click history back button 
	def OLI.rcp_matched_history_back
		find($online_inquiries_rcp_matchcomp_history_back).click 
	end 
	# set the search field to look for documents 
	# click_enter = click will click search icon 
	# click_enter = enter will press the enter button 
	def OLI.rcp_matched_search_document search_document ,click_enter="click"
		find($online_inquiries_rcp_search_input).set search_document
		if click_enter == "click"
			find($online_inquiries_rcp_search_input_button).click 
		elsif click_enter.downcase == "enter"
			page.driver.browser.action.send_keys(:return).perform 
		end 
		FFA.wait_page_message $ffa_msg_loading
	end 
	# get the number of rows returned in search table 
	def OLI.rcp_matched_get_no_of_rows 
		rows = gen_get_grid_rows $online_inquiries_rcp_search_grid
		return rows 
	end 
	# return the row data in searched table
	def OLI.rcp_matched_get_searched_row row_number
		row = gen_grid_data_row $online_inquiries_rcp_search_grid , row_number
		return row 
	end 
	# set the from date on Account matched component 
	def OLI.rcp_matched_set_from_date from_date 
		find($online_inquiries_rcp_search_from_date).set from_date
	end 
	# set the to date on Account matched component 
	def OLI.rcp_matched_set_to_date to_date 
		find($online_inquiries_rcp_search_to_date).set to_date
	end
	# Click rcp action coloum by searching value in a specified column 
	def OLI.rcp_matched_select_document search_text , search_col
		col = 1
		row = gen_get_row_in_grid $online_inquiries_rcp_search_grid, search_text, search_col 
		find($online_inquiries_rcp_search_grid +" table:nth-of-type(#{row}) tr td:nth-of-type(#{col})").click
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
	end  
end 
