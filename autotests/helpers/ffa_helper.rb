 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module FFA  
extend Capybara::DSL

FFALABELSFILE = "../source/src/labels/CustomLabels.labels"
$transaction_tli_related_list = "//div.listRelatedObject[//h3//text() = 'Transaction Line Items']]"
$transaction_tli_go_to_list_link = "//a[contains(text(), 'Go to list')]"
$transaction_tli_full_related_list = "div.listRelatedObject"
$transaction_tli_full_related_list_line_id_link = "tr.dataRow th.dataCell a"

# Package Prefix
$ffa_erp_package_prefix = "fferpcore__"
#############################
# ffa common 
#############################
# this will fetch a label text by its key
	labelfile = File.open(FFALABELSFILE)
	LABELDOC = Nokogiri::XML(labelfile)
	LABELDOC.remove_namespaces!

	def FFA.fetch_label key
		return LABELDOC.xpath("//labels/fullName[text()='" + key + "']/../value").to_s.sub('<value>', '').sub('</value>', '')
	end

# this will click on the top section on the screen (requried some time if the tab out does not triggered the action)
	def FFA.click_out
		find($page_empty_div).click
		sleep 1
	end
# tabs by label
	def FFA.click_tab_by_label tab_label
		find(:button_by_label,tab_label).click # :button_by_label is a custom selector
		if DEBUGGING_MESSAGES == true 
			puts "clicking tab #{tab_label}"
		end 
		gen_wait_less
	end 
# tabs on the grid 
	def FFA.click_grid_tab_by_label tab_label
		SF.execute_script do
			find(:grid_tab_by_label,tab_label).click # :grid_tab_by_label is a custom selector
			if DEBUGGING_MESSAGES == true 
				puts "clicking grid tab #{tab_label}"
			end
		end
		gen_wait_less
	end 
	def FFA.click_button_by_label button_label
		find(:button_by_label,button_label).click # :button_by_label is a custom selector
		if DEBUGGING_MESSAGES == true 
			puts "clicking button #{button_label}"
		end
		gen_wait_less
	end 
# click on object who's identifier is passed to the method 
	def FFA.click_object_wait object
		SF.execute_script do
			find(object).click
		end
		gen_wait_less
	end 
# get a column by header text 	
	def FFA.get_column_by_header column_header_text
		return find(:xpath , "//span[text()='#{column_header_text}']")
	end

# return the no of rows in the list view
	def FFA.ffa_listview_get_rows 
		rows = all($page_vf_table_rows)
		return rows.size 
	end
# salesforce listview select all check box 
	def FFA.listview_select_all 
		check $page_all_check_box
	end 
# check if its a custom object and does not have c2g__ already as a prefix,then prefix it with c2g__
	def FFA.prefix_custom_object object_to_prefix
		if ORG_TYPE.downcase == "managed"
			if ((object_to_prefix.end_with? "__c" or object_to_prefix.end_with? "__r") and (!(object_to_prefix.start_with? "c2g__")))
				object_to_prefix  = ORG_PREFIX + object_to_prefix
			end
		end 
		return object_to_prefix
	end 
# delete a record from the list view 
	def FFA.delete_record record_name
			SF.click_button_go
			while(page.has_content?(record_name))
				click_link 'Del'
				gen_alert_ok
			end
	end
# delete all record in the list view
	def FFA.delete_all_record 
		counter = 0
		SF.click_button_go
			while(page.has_css?($page_vf_table_rows)) and counter < DEFAULT_TIME_OUT
				click_link 'Del'
				sleep 1
				gen_alert_ok
				counter += 1
			end
	end
# click on currency toggle exchange rate to set/view dual rate
	def FFA.click_currency_rate_toggle_icon
		find($currency_toggle_exchange_rate_icon).click
	end
# click on Account toggle icon to view dimensions of account
	def FFA.click_account_toggle_icon
		SF.execute_script do
			find($account_toggle_icon).click
		end
	end
# click on Product toggle icon to view dimensions notes and analusis
	def FFA.click_product_toggle_icon line
		line = line-1
		if(page.has_button?($sf_save_button))
			vat = $product_note_analysis_toggle_icon_input+"VAT:#{line}"+$product_note_analysis_toggle_icon_input_end
			sut = $product_note_analysis_toggle_icon_input+"SUT:#{line}"+$product_note_analysis_toggle_icon_input_end
			find(vat, sut).click
		else
			_product_toggle_icon = $product_note_analysis_toggle_icon_input+":#{line}"+$product_note_analysis_toggle_icon_input_end
			find(_product_toggle_icon).click
		end
	end
#############################
# ffa sync methods
#############################

# yellow tool tip style message on (Vf pages)
	def FFA.wait_page_message message
		counter = 0
		# wait for yellow spining message to appear
		page.has_css?($page_spinning_message)
		begin 
			msg = find($page_spinning_message).text
		rescue 
			if DEBUGGING_MESSAGES == true 
				puts "Didn't find the pop up..."
			end 
		end 
		while msg == message and counter < DEFAULT_TIME_OUT do 
			counter += 1
			sleep 1
			if DEBUGGING_MESSAGES == true 
				puts "waiting for =>> #{msg}"
			end 
			begin
				msg = find($page_spinning_message).text
			rescue 
				break
			end
		end
		if DEBUGGING_MESSAGES == true 
			puts "DONE !!!"
		end 
	end

# pop up  message on the (sencha screen)
# e.g Loading Metadata saving ...
	def FFA.wait_for_popup_msg_sync message
		counter = 0
		begin 
			msg = find($page_loadmask_message).text
		rescue 
			if DEBUGGING_MESSAGES == true 
				puts "Unable to grab pop up..."
			end 
		end 
		while msg == message and counter < DEFAULT_TIME_OUT do 
			counter += 1
			sleep 1
			if DEBUGGING_MESSAGES == true 
				puts "waiting for =>> #{msg}"
			end 
			begin
				msg = find($page_loadmask_message).text
			rescue 
				break
			end
		end
		if DEBUGGING_MESSAGES == true 
			puts "DONE !!!"
		end 
	end

#############################
# ffa messages 
#############################
# get the success message from the VF page
	def FFA.get_success_message 
		return find($page_vf_success_panel).text 
	end 
# get the error message from the VF page
	def FFA.get_error_message 
		return find($page_vf_error_panel).text 
	end 
# get the error message from the VF page
	def FFA.get_error_message2 
		return find($page_vf_error_panel2).text 
	end 
	
# get the info message from the VF page
	def FFA.ffa_get_info_message 
		SF.execute_script do
			return find($page_vf_message_text).text 
		end
	end 
# get the error message from the sencha screen
	def FFA.get_sencha_popup_error_message 
		return find($page_sencha_popup_error_message).text 
	end
# get the warning message from the sencha screen
	def FFA.get_sencha_popup_warning_message 
		return find($page_sencha_popup_warning_message).text 
	end
# get the success message from the sencha screen
	def FFA.get_sencha_popup_success_message
		return find($page_sencha_popup_success_message).text
	end
# get the information message on page
	def FFA.get_page_info_message
		return find($page_vf_information_text).text
	end
	# get Error Message in FFA
	def FFA.get_box_error_message
		return find($page_error_box).text 
	end

#############################
# ffa buttons 
#############################
	def FFA.click_post
		SF.click_action $ffa_post_button	
	end

	def FFA.click_save_post
		SF.execute_script do
			page.has_button?($ffa_save_post_button)
			first(:button, $ffa_save_post_button).click
			gen_wait_until_object_disappear $ffa_processing_button_locator
		end
	end

	def FFA.click_discard
		SF.execute_script do
			page.has_button?($ffa_discard_button)
			first(:button, $ffa_discard_button).click
			gen_wait_until_object_disappear $ffa_processing_button_locator
		end
		SF.wait_for_search_button
	end

	def FFA.click_classic_view
		SF.click_action $ffa_classic_view_button
	end
	
	def FFA.click_amend_document
		SF.execute_script do
			page.has_button?($ffa_amend_document_button)
			first(:button, $ffa_amend_document_button).click
			SF.wait_for_search_button
		end
	end
	
	def FFA.click_manage_line
		SF.click_action $ffa_manage_line_button
		page.has_css?($doc_new_line_button)
	end
	
	def FFA.click_post_match
		SF.click_action $ffa_post_match
		page.has_button?($ffa_match)
	end
	
	def FFA.click_match
		SF.execute_script do
			SF.retry_script_block do
				first(:button, $ffa_match).click
			end
			SF.wait_for_search_button 
		end
	end
	
	def FFA.click_continue
		SF.execute_script do
			page.has_button?($ffa_continue)
			first(:button, $ffa_continue).click
		end
		SF.wait_for_search_button
	end
	
	def FFA.click_print_pdf
		SF.execute_script do 
			SF.click_action $ffa_print_pdf_button
			gen_wait_until_object_disappear $ffa_processing_button_locator
		end
		gen_wait_less # wait for the new browser to appear , before switching to it.
	end
# on opportunity page 
	def FFA.click_create_invoice
		page.has_button?($ffa_create_invoice_button)
		first(:button, $ffa_create_invoice_button).click
		SF.wait_for_search_button
	end

	def FFA.click_convert
		page.has_button?($ffa_convert_button)
		first(:button, $ffa_convert_button).click
		SF.wait_for_search_button
	end
#############################
# ffa buttons sencha screens
#############################

	def FFA.toolbar_save
		SF.execute_script do
			find($ffa_toolbar_save).click 
		end
	end
	def FFA.toolbar_edit
		find($ffa_toolbar_edit).click 
	end
	def FFA.toolbar_save_and_run
		SF.execute_script do
			find($ffa_toolbar_save_and_run).click 
		end
	end

	def FFA.toolbar_save_sync sync_message 
		FFA.toolbar_save
		FFA.wait_for_popup_msg_sync sync_message
	end

	def FFA.toolbar_save_and_build
		find($ffa_toolbar_save_and_build).click
		FFA.wait_for_popup_msg_sync $ffa_msg_saving
	end

	def FFA.toolbar_clone
		find($ffa_toolbar_clone).click
	end

	def FFA.toolbar_back_to_list
		find($ffa_toolbar_back_to_list).click 
	end

	def FFA.sencha_popup_click_continue 
		find($page_sencha_popup_continue).click
		SF.wait_for_search_button
	end 

	def FFA.sencha_popup_click_ok
		find($page_sencha_popup_ok).click
		SF.wait_for_search_button
	end 

	def FFA.sencha_popup_click_cancel
		find($page_sencha_popup_cancel).click
	end 
	# click on sench button where data-ffid = no
	def FFA.sencha_popup_click_no
		find($page_sencha_popup_no).click
	end 
	# click on sench button where data-ffid = yes
	def FFA.sencha_popup_click_yes
		find($page_sencha_popup_yes).click
	end 
	def FFA.toolbar_full_screen
		find($ffa_toolbar_full_screen).click 
	end

#############################
# Select Company
#############################
# Method to select or deselect company / companies 
# e.g
#FFA.select_company [$company_apex_comp_eur,$company_merlin_auto_aus] ,true
#FFA.select_company [$company_merlin_auto_aus],false
# first argument as list of company / companies, second argument as true or false  
	def FFA.select_company compnay_name , select_deselect
		SF.execute_script do
			page.has_css?($select_company_company_table)
			# de select all the existing companies 
			FFA.deselect_all_companies
			# select companies
			compnay_name.each do |comp|
				row =1
				while  row <= (all($select_company_total_num_of_companies)).count
					company_name = find($select_company_company_name_pattern.sub($sf_param_substitute,row.to_s)).text
					if comp == company_name
						find($select_company_company_checkbox_pattern.sub($sf_param_substitute,row.to_s)).set(select_deselect)
					end
					row+=1
				end
			end
		end
		SF.click_button_save
		# check that company saved successfully
		page.has_content?($ffa_msg_saved_successfully)
	end
	
#############################
#Is Company selected
#############################
# Method to check company is selected or not
	def FFA.is_company_selected company_name
		is_selected = false
		SF.execute_script do
			page.has_css?($select_company_company_table)
			# iterate all companies
			row =1
			while  row <= (all($select_company_total_num_of_companies)).count
				comp = find($select_company_company_name_pattern.sub($sf_param_substitute,row.to_s)).text
				if comp == company_name
					status =  find($select_company_company_checkbox_pattern.sub($sf_param_substitute,row.to_s))[:checked]
					if(status == "checked" || status == "true")
						is_selected = true
					end
					break
				end
				row+=1
			end			
		end
		return is_selected		
	end
	
	# de select all selected companies 
	def FFA.deselect_all_companies 
		allcompanies  = all($select_company_all_checkboxes)
			allcompanies.each do |elem| 
			elem.set(false)
		end 
	end

	def FFA.select_company_tab
		SF.tab $tab_select_company
		page.has_css?($select_company_company_table)
	end
################################################################################
# selection component (used in inquiry template , online inquries tabs) 
################################################################################

# click on the edit icon for field when it is already added / draged in the filter component 
	def FFA.selection_component_filter_edit
		find($selection_component_filter_drop_zone_edit).click 
	end 
# remove the field from the filter component (first field in the filter)
	def FFA.selection_component_filter_remove
		find($selection_component_filter_drop_zone_delete).click 
	end 
# Drag a field in the section component (Dark Blue Field Button)
	def FFA.selection_component_add_field
		field = find($selection_component_filter_field)
		dropzone = find($selection_component_filter_drop_zone)
		gen_drag_drop field, dropzone
		FFA.selection_component_filter_edit
	end 
# Set the value for "Field" on Filter Criteria pop up dialogue
	def FFA.selection_component_set_filter_field filter_field
		find($selection_component_filter_criteria_field).set  filter_field
		gen_tab_out $selection_component_filter_criteria_field
	end 
# Set the value for "Operator" on Filter Criteria pop up dialogue
	def FFA.selection_component_set_filter_operator filter_operator
		find($selection_component_filter_criteria_operator).set  filter_operator
		gen_tab_out $selection_component_filter_criteria_operator 
	end 
# Set the value for "Value" on Filter Criteria pop up dialogue
	def FFA.selection_component_set_filter_value_from filter_value_from 
		find($selection_component_filter_criteria_value_from).set filter_value_from
		gen_tab_out $selection_component_filter_criteria_value_from 
	end
# Set the value for "To" on Filter Criteria pop up dialogue
	def FFA.selection_component_set_filter_value_to filter_value_to
		find($selection_component_filter_criteria_value_to).set filter_value_to
		gen_tab_out $selection_component_filter_criteria_value_to 
	end
# fill in the Filter Criteria pop dialogue with specified values (selection prompt)
	def FFA.selection_component_set_filter field ,operator , value_from , value_to , prompt 
		FFA.selection_component_set_filter_field field
		FFA.selection_component_set_filter_operator operator
		FFA.selection_component_set_filter_value_from value_from
		if value_to != nil
			FFA.selection_component_set_filter_value_to value_to
		end 
		if prompt != nil
			find($selection_component_filter_criteria_prompt).click 
		end 
		find($selection_component_filter_criteria_ok).click 
		page.has_no_css? $selection_component_filter_criteria_ok
	end 
################################################################################
# formula component (used in dataview , inquiry template and online inquries) 
################################################################################
#  This method will be used to identify the drop zone for dragged items 
# drop_zone (Add, Subtract,Multiply or Divide)
# drop_location (if there are multiple drop zone specify by number where to drop 1,2,3,4)
# drop_bracket specify where to drop on openning or closing bracket.
Add = "Add"
Subtract = "Subtract"
Multiply = "Multiply"
Divide =  "Divide"
OpenBracket =  "OpenBracket"
CloseBracket =  "CloseBracket"
Number = "Number"
Field = "Field"
Column = "Column"
# drop_zone are DropZone, First and Last Drop zones  
# workout the dropzone for operators and values (Number,Field,Column) based on provided drop zone and index,location
	def FFA.formula_drop_zone  drop_zone ,drop_location 
		if drop_zone == "DropZone"
			drop_area = $formula_component_drop_zone_text 
		elsif drop_zone == "First"
			drop_area = $formula_component_drop_zone_first 	
		elsif drop_zone == "Last"
			drop_area = $formula_component_drop_zone_last 
		elsif drop_zone == "Loc"
			drop_area = $formula_component_drop_zone 
			drop_area = drop_area.sub "nnn",String(drop_location)
		end 
		return find(drop_area)
	end 
# drag the operator into the drop zone 
# by default drop on the last drop zoe i.e build formula from left to right
	def FFA.formula_drag_operator operator ,  operator_drop_zone = "Last" ,drop_location = 1 
		# Pick up the right operator 
		if operator == FFA::Add
			source =  $formula_component_add_source
		elsif  operator == FFA::Subtract
			source = $formula_component_subtract_source
		elsif  operator == FFA::Multiply
			source = $formula_component_multiply_source
		elsif  operator == FFA::Divide
			source = $formula_component_divide_source
		elsif  operator == FFA::OpenBracket
			source = $formula_component_open_bracket_source
		elsif  operator == FFA::CloseBracket
			source = $formula_component_close_bracket_source
		end 
		# Operator selector 
		source_selector = find(source)
		# workout where to drop the operator 
		dropzone = FFA.formula_drop_zone  operator_drop_zone , drop_location 
		gen_drag_drop source_selector, dropzone
	end 
# drag the value into the drop zone 
# by default drop on the last drop zoe i.e build formula from left to right
	def FFA.formula_drag_value value_type ,value_to_set, value_drop_zone = "Last", drop_location = 1 
		# workout the operands 
		if value_type == FFA::Number
			source = $formula_component_number_value_source
			source_input = $formula_component_number_value_input
		elsif  value_type == FFA::Field
			source = $formula_component_field_value_source
			source_input =  $formula_component_field_value_input
		elsif  value_type == FFA::Column
			source = $formula_component_column_value_source
			source_input = $formula_component_column_value_input
		end
		# get the selector for operands 
		source_selector = find(source)
		# workout where to drop operand 
		dropzone = FFA.formula_drop_zone  value_drop_zone ,drop_location
		# drag and drop 
		gen_drag_drop source_selector, dropzone
		# set the value 
		FFA.formula_set_value source_input, value_to_set
	end 
# set the value for Number ,Field and Column in Edit Mode 
	def FFA.formula_set_value input_selector , value 
		find(input_selector).set value
		gen_tab_out input_selector
		find($formula_component_add_source).click 

	end 
# Click on Reapply Formula on Grouped Rows (default is on)
	def FFA.formula_set_decimal_places decimal_places 
		find($formula_component_decimal_places).set decimal_places
		gen_tab_out $formula_component_decimal_places
	end 
# Click on formula form cancel button
	def FFA.formula_cancel_button
		find($formula_component_cancel_button).click
	end 
# Click on formula form cancel button
	def FFA.formula_clear_button
		find($formula_component_clear_button).click
	end
# Click on formula form reset button
	def FFA.formula_reset_button
		find($formula_component_reset_button).click
	end 
# Click on formula form save button 
	def FFA.formula_ok_button
		find($formula_component_ok_button).click
	end 
# Set the whole formula in one go on formula field
	def FFA.open_formula_window field_title
		# find the row based on formula tilte
		row = gen_get_row_in_grid $inquiry_template_column_grid ,field_title, INQUIRY_TEMPLATE_COLUMN_TITLE
		find("#{$inquiry_template_column_grid} table:nth-of-type(#{row}) tr td:nth-of-type(#{INQUIRY_TEMPLATE_COLUMN_FORMULA}) img").click 
		page.has_css?($formula_component_window)
	end
# add formula field
	def FFA.add_formula_column field_name , field_title, field_mode
		# add new field 	
		InquiryTemplate.add
		# set the column type to formula 
		InquiryTemplate.set_type field_name , "Formula"
		# set the title of filed 
		InquiryTemplate.set_title field_name , field_title
		# set mode of the field 
		InquiryTemplate.set_mode  field_name , field_mode
		# set formula on the filed
		FFA.open_formula_window field_title
	end 
	# Return the formula error message
	def FFA.formula_get_error_message 
		page.has_css? $formula_component_error
		find($formula_component_error).hover
		error_message = gen_get_tool_tip
		return error_message
	end 
	# drag provided object to formula bin 
	def FFA.formula_drag_to_bin bin_object
		bin = find($formula_component_bin)
		gen_drag_drop bin_object, bin
	end 
	# return the full formula 
	def FFA.formula_get_formula 
		return find($formula_component_container).text 
	end 

#############################
# prime doc common 
#############################
	def FFA.append_company_type line , line_field 
		vat = $doc_line_input+"VAT:#{line}"+line_field+"VAT"+$doc_line_input_end
		sut = $doc_line_input+"SUT:#{line}"+line_field+"SUT"+$doc_line_input_end
		return vat+","+sut
	end 

	def FFA.append_expense_line_company_type line , line_field 
		vat = $doc_expense_line_input+"VAT:#{line}"+line_field+"VAT"+$doc_line_input_end
		sut = $doc_expense_line_input+"SUT:#{line}"+line_field+"SUT"+$doc_line_input_end
		return vat+","+sut
	end
	
	def FFA.substitute_document_number substitute_string  
		return substitute_string.gsub!(/(SIN|SCN|PIN|PCN|JRN|CSH|TRN)[0-9]{6}/,'XX')
	end 
# New  Line Items 
	def FFA.click_new_line
		SF.execute_script do
			find($doc_new_line_button).click 
			FFA.wait_page_message $ffa_msg_adding_line
		end
	end

# get status of document
	def FFA.get_document_status field_name
		SF.execute_script do
			return find(:xpath, field_name).text
		end
	end

#############################
# get column value in listview grid
# search_text - text which need to be searched in col_name_to_search column.
# col_name_to_search- name of column where search_text need to be searched.
# col_name_to_return - name of that column  which value need to be returned.
#############################
	def FFA.get_column_value_in_grid col_name_to_search , search_text , col_name_to_return
		col_to_search_position = gen_get_column_number_in_grid col_name_to_search
		SF.log_info "Column to search-#{col_name_to_search} position is - #{col_to_search_position}"
		col_to_return_position = gen_get_column_number_in_grid col_name_to_return
		SF.log_info "Column to return: #{col_name_to_return}  position  is - #{col_to_return_position}"
		row_position = gen_get_row_number_in_grid search_text, col_to_search_position
		SF.log_info "Row number where searct text :#{search_text} is present under column #{col_name_to_search}  is - #{row_position}"
		list_grid_row_pattern = $page_grid_row_pattern.sub($sf_param_substitute,row_position.to_s )
		# if column to return is =1, It will be displayed as header cell(th) instead of normal cell(td).
		#  so replacing td with th before retrieving the results.
		if (SF.org_is_lightning and col_to_return_position == 3)
			list_grid_row_pattern = list_grid_row_pattern.sub("td" ,"th")
			# There is only one th cell present intable for document name cell, So making the value as 1.
			col_to_return_position = 1
		end
		# In lightning org result table, cells(td) in a row(tr) starts from second cell in result table. 
		# first cell is displayed as header cell(th).
		if (SF.org_is_lightning and col_to_return_position > 3)
			col_to_return_position = col_to_return_position-1
		end	
		return find(list_grid_row_pattern.sub($sf_param_substitute	,col_to_return_position.to_s )).text
	end

#############################
# select a single row  in listview grid
# search_text - text which need to be searched in col_name_to_search column.
# col_name_to_search- name of column where search_text need to be searched.
#############################
	def FFA.select_row_in_list_gird col_name_to_search , search_text 
		col_to_search_position = gen_get_column_number_in_grid col_name_to_search
		row_position = gen_get_row_number_in_grid search_text, col_to_search_position
		find($page_grid_select_checkbox_pattern.sub($sf_param_substitute,row_position.to_s )).click
	end  
	
#############################
# Click on Edit link on list grid for specific row on results page
# search_text - text which need to be searched in col_name_to_search column.
# col_name_to_search- name of column where search_text need to be searched.
#############################
 	def FFA.click_edit_link_on_list_gird col_name_to_search , search_text 
  		col_to_search_position = gen_get_column_number_in_grid col_name_to_search
  		row_position = gen_get_row_number_in_grid search_text, col_to_search_position
		page.has_css?($page_grid_edit_link_pattern.gsub($sf_param_substitute,row_position.to_s ))
		SF.retry_script_block do 
			find($page_grid_edit_link_pattern.gsub($sf_param_substitute,row_position.to_s )).click
		end
		# On Lightning Org, edit link is displayed under dropdown. Selecting edit action from dropdown
		if(SF.org_is_lightning)
			SF.retry_script_block do 
				sleep 1 # wait for option to be displayed
				page.has_css?($sf_lightning_grid_row_edit_link)
				find($sf_lightning_grid_row_edit_link).click
				page.has_css?($sf_lightning_new_form_window_close_icon)
			end
		end
		SF.wait_for_search_button
 	end 	
################################
# select row checkbox in grid
################################		
 	def FFA.select_row_from_grid row_name_to_select
 		find(:xpath,$page_grid_row_checkbox.sub($sf_param_substitute,row_name_to_select)).click
 	end
	
# click toggle exchange rates icon
	def FFA.click_toggle_exchange_rates
		SF.execute_script do 
			find($ffa_toggle_exchange_rates_icon).click
		end
	end

############################################
# setup as of aging report settings
############################################
	def FFA.as_of_aging_report_setting_create_new
		SF.admin $sf_setup
		click_link "Develop"
		click_link "Custom Settings"
		click_link $ffa_custom_setting_as_of_aging_report_settings
		page.has_button?($sf_new_button)
		SF.click_button_new
		SF.wait_for_search_button
	end	

#############################
# create new view to display selected fields on result grid table.
# view_name -name of the view.
# fields_name - array of the fields which need to be selected for display
#############################
	def FFA.create_new_view view_name , fields_name
		find(:xpath,$sf_list_create_new_view_link).click
		page.has_css?($view_name_input)
		# set name ane unique name
		find($view_name_input).set view_name
		# doing tab out will auto fill the unique name
		gen_tab_out $view_name_input
		# Add fields for display.
		for j in 0..fields_name.size do
			element_list = all($view_element_list)  
			for i in 1..element_list.size do
				option_fields_name = find($view_option_field_name_pattern.sub($sf_param_substitute,i.to_s)).text
				if(fields_name[j]==option_fields_name)
					find($view_option_field_name_pattern.sub($sf_param_substitute,i.to_s)).click 
					find($view_right_arrow_icon).click
					break
				end
			end
		end
		SF.click_button_save
	end
	
#############################
# edit view and add fields
#############################
	def FFA.edit_view_add_fields fields_name, position_to_add =:"2"
		find($sf_list_view_edit_link).click
		gen_wait_less
		total_items_to_add = fields_name.size
		total_items_in_list = all($view_element_selected_fields_list).size
		
		if (total_items_in_list < position_to_add)
			position_to_add = total_items_in_list
		end
	  
		for j in 0..fields_name.size do
			element_list = all($view_element_list)  
			for i in 1..element_list.size do
				option_fields_name = find($view_option_field_name_pattern.sub($sf_param_substitute,i.to_s)).text
				if(fields_name[j]==option_fields_name)
					find($view_option_field_name_pattern.sub($sf_param_substitute,i.to_s)).click 
					find($view_right_arrow_icon).click 
					#Move to Position
					total_items_in_list = total_items_in_list + 1 
					field_position_to_set = total_items_in_list - position_to_add
					field_position = 1
					while field_position < field_position_to_set
						find($sf_edit_view_up_img_icon).click
						field_position += 1
					end      
					position_to_add = position_to_add + 1;
					break
				end
			end
		end
		SF.click_button_save		
		SF.wait_for_search_button
	end

#############################
# edit view and Add and remove fields
#############################
	def FFA.edit_view_add_remove_fields _fields_names_to_add , _fields_names_to_remove, field_position_to_add =:"2"
		find($sf_list_view_edit_link).click
		gen_wait_less
		#remove fields
		for j in 0.._fields_names_to_remove.size do
			element_list = all($view_element_selected_fields_list)		
			for i in 1..element_list.size do
				option_fields_name = find($view_option_selected_field_name_pattern.sub($sf_param_substitute,i.to_s)).text
				if(_fields_names_to_remove[j]==option_fields_name)
					find($view_option_selected_field_name_pattern.sub($sf_param_substitute,i.to_s)).click	
					find($view_left_arrow_icon).click
					break
				end
			end
		end
		SF.click_button_save	
		SF.wait_for_search_button
		#Add fields
		FFA.edit_view_add_fields _fields_names_to_add,field_position_to_add	
	end

#####################################
#upload file
###################################
	def FFA.upload_file import_field_id,file_name
		if OS_TYPE == OS_WINDOWS
			file_path=$upload_file_path + file_name
			pwd = Dir.pwd + file_path
			win_pwd=pwd.gsub("/", "\\")
		else 
			file_path=$upload_file_path + file_name
			win_pwd=Dir.pwd + file_path
		end
		puts "importing file: "+win_pwd
		attach_file(import_field_id, win_pwd)		
 	end
 

#############################
# To select period from period look up icon as per company name passed
# lookup_icon_name- name/locator of lookup icon, its values changes on every page).
# search_period - Period which user want to select, left it nil if user want to set current period
# company_name - name of the company to which period belongs
#############################
	def FFA.select_period_from_lookup lookup_icon_name, search_period, company_name
		SF.execute_script do
			find(lookup_icon_name).click
		end
		sleep 1# wait for the look up to appear
		within_window(windows.last) do
			page.has_text?($lookup_search_frame_lookup_text)
			period = search_period
			page.driver.browser.switch_to.frame $lookup_search_frame
			fill_in $lookup_search_text, with: period 
			SF.click_button_go
			SF.wait_for_search_button
			page.driver.browser.switch_to.default_content
			page.driver.browser.switch_to.frame $lookup_result_frame 
			rownum=2
			while rownum <= all($lookup_results_table_rows).count
				if company_name == find($lookup_company_column_pattern.sub($sf_param_substitute , rownum.to_s)).text
					find($lookup_period_column_pattern.sub($sf_param_substitute , rownum.to_s)).click
					SF.wait_for_search_button
					break
				end
			rownum+=1
			end
		end
	end

#############################
# To select year from the year look up.
#lookup_icon_name - locator of look up icon
# search_year - year which user want to searchFrame
# company_name- name of the company
#############################
	def FFA.select_year_from_lookup lookup_icon_name, search_year , company_name
		find(lookup_icon_name).click			
		sleep 1# wait for the look up to appear
		within_window(windows.last) do
			page.has_text?($lookup_search_frame_lookup_text)
			SF.retry_script_block do
				page.driver.browser.switch_to.frame $lookup_search_frame
			end
			fill_in $lookup_search_text, with: search_year 
			SF.click_button_go			
			SF.retry_script_block do
				page.driver.browser.switch_to.default_content
				page.driver.browser.switch_to.frame $lookup_result_frame
				rownum=2
				while rownum <= all($lookup_results_table_rows).count
					if company_name == find($lookup_year_company_column_pattern.sub($sf_param_substitute , rownum.to_s)).text						
						find($lookup_year_column_pattern.sub($sf_param_substitute , rownum.to_s)).click
						SF.wait_for_search_button
						break
					end
					rownum+=1
				end				
			end
		end
	end

#############################
# To select User  from the user profile look up.
#lookup_icon_name - locator of look up icon
# User 
#############################
	def FFA.select_user_from_lookup lookup_icon_name, user_name
		if (SF.org_is_lightning)
			SF.fill_in_lookup $usercompany_user_label , user_name
		else 
			find(lookup_icon_name).click
			sleep 1# wait for the look up to appear
			within_window(windows.last) do
				page.has_text?($lookup_search_frame_lookup_text)
				page.driver.browser.switch_to.frame $lookup_search_frame
				fill_in $lookup_search_text, with: user_name 
				SF.click_button_go
				SF.wait_for_search_button
				page.driver.browser.switch_to.default_content
				page.driver.browser.switch_to.frame $lookup_result_frame
				page.has_text?(user_name)  			
				SF.click_link user_name
			end
		end
	end

	
#############################
# To select tax code  from the tax code look up.
#lookup_icon_name - locator of look up icon
# tax_code_value - name of the tax code
#############################
	def FFA.select_tax_code_from_lookup lookup_icon_name, tax_code_value
		SF.execute_script do
			find(lookup_icon_name).click
		end
		sleep 1# wait for the look up to appear
		within_window(windows.last) do
			page.has_text?($lookup_search_frame_lookup_text)
			page.driver.browser.switch_to.frame $lookup_search_frame
			fill_in $lookup_search_text, with: tax_code_value 
			SF.click_button_go
			SF.wait_for_search_button
			page.driver.browser.switch_to.default_content
			page.driver.browser.switch_to.frame $lookup_result_frame
			page.has_text?(tax_code_value)  			
			SF.click_link tax_code_value
		end
	end
###################################
#select currency from lookup
####################################
 	def FFA.select_currency_from_lookup lookup_icon_name, search_value, company
 		SF.execute_script do
			find(lookup_icon_name).click
		end
		sleep 1# wait for the look up to appear
		within_window(windows.last) do
			page.has_text?($lookup_search_frame_lookup_text)
			page.driver.browser.switch_to.frame $lookup_search_frame
			fill_in $lookup_search_text, with: search_value	
			SF.click_button_go
			SF.retry_script_block do
				page.driver.browser.switch_to.default_content
				page.driver.browser.switch_to.frame $lookup_result_frame
			end
			find(:xpath,$currency_lookup_element.sub($sf_param_substitute,company)).click
		end
	end

#########################################
# Methods to hold base Data in org
#########################################
	def FFA.hold_base_data_and_wait
		job_id_for_queued_job_query = "select Id, Name from Account where MirrorName__c = 'SysTestLoadDataFinal'"
		APEX.execute_soql job_id_for_queued_job_query
		soql_results = APEX.get_execution_status_message
		expected_result_with_one_item = "totalSize\":1,"
		# Delete identifier mapping table data.
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			#Delete IdentifierMapping__c in case previous running job left some records
			_delete_data = ["delete [select id from #{ORG_PREFIX}IdentifierMapping__c];"]
			APEX.execute_commands _delete_data
		end
		if !(soql_results.include? expected_result_with_one_item)
			puts "#Hold Base Data"
			# Store the current page URL to visit again in case of lightening org.
			current_page_url = page.current_url
			page.has_css? $tab_all_tabs_locator
			SF.tab $tab_basedatajob
			SF.execute_script do
				gen_wait_until_object $apex_hold_base_data_button
				find($apex_hold_base_data_button).click
				page.has_css?($page_vf_message_text)
			end
			visit current_page_url
			SF.wait_for_search_button
			SF.wait_for_apex_job
		else
			puts "No Need to hold data as Org Data already recorded, to re-record ORG data delete account SysTestLoadDataFinal and try again"
		end
	end
	
	def FFA.delete_new_data_and_wait
		puts "#Delete Test Data"
		FFA.delete_data_with_sda_access do
			current_page_url = page.current_url
			page.has_css? $tab_all_tabs_locator
			SF.tab $tab_basedatajob
			SF.execute_script do
				gen_wait_until_object $apex_delete_new_data_button
				find($apex_delete_new_data_button).click
			end
			visit current_page_url
			SF.wait_for_search_button
			SF.wait_for_apex_job
		end
	end
	
#############################
# To select Bank Account from bank account lookup icon as per company name passed
# lookup_icon_name- name/locator of lookup icon, its values changes on every page).
# bank_account_name - Period which user want to select
# company_name - name of the company to which bank account belongs
#############################
	def FFA.select_bank_account_from_lookup lookup_icon_name, search_value, company
 		if(SF.org_is_lightning and page.has_no_css?($sf_lightening_iframe_locator, :wait => DEFAULT_LESS_WAIT))
			SF.fill_in_lookup $label_ict_destination_doc_bank_account,search_value
		else
			SF.execute_script do
				find(lookup_icon_name).click
			end
			sleep 1# wait for the look up to appear
			within_window(windows.last) do
				page.has_text?($lookup_search_frame_lookup_text)
				page.driver.browser.switch_to.frame $lookup_search_frame
				fill_in $lookup_search_text, with: search_value	
				SF.click_button_go
				SF.wait_for_search_button
				page.driver.browser.switch_to.default_content
				page.driver.browser.switch_to.frame $lookup_result_frame			
				find(:xpath,$lookup_bank_account_pattern.sub($sf_param_substitute,company)).click
			end
		end
	end

#########################################
# Method to reopen specified year and its preceding years
#########################################
	def FFA.open_closed_year year_to_open, company_name
		FFA.delete_data_with_sda_access do
			reopen_year_apex_script = ""
			if(ORG_TYPE == UNMANAGED) 
				reopen_year_apex_script = "CODAUnitOfWork.createAndSetCurrent();"
				reopen_year_apex_script += "CODAContext.enableSupportAccess();"
			end
			reopen_year_apex_script += "string yearToOpen = '" + year_to_open.to_s + "';"		
			reopen_year_apex_script += "string companyName = '" + company_name.to_s + "';"
			reopen_year_apex_script += ""+ORG_PREFIX+"CodaYear__c year = [select ID, "+ORG_PREFIX+"EndDate__c from "+ORG_PREFIX+"CodaYear__c WHERE Name=:yearToOpen][0];"
			reopen_year_apex_script += ""+ORG_PREFIX+"codaCompany__c company = [select ID,name from "+ORG_PREFIX+"codaCompany__c WHERE Name=:companyName][0];"
			reopen_year_apex_script += "List<"+ORG_PREFIX+"CodaYear__c> yearsAndPeriods= [SELECT c.Id,"+ORG_PREFIX+"Status__c, (SELECT Id,"+ORG_PREFIX+"Closed__c From "+ORG_PREFIX+"Periods__r where "+ORG_PREFIX+"Closed__c = true) from "+ORG_PREFIX+"CodaYear__c c where "+ORG_PREFIX+"OwnerCompany__c = :company.Id and "+ORG_PREFIX+"EndDate__c <= :year."+ORG_PREFIX+"EndDate__c];"
			reopen_year_apex_script += "List<"+ORG_PREFIX+"codaPeriod__c> periodsToOpen = new List<"+ORG_PREFIX+"codaPeriod__c>();"
			reopen_year_apex_script += "for ("+ORG_PREFIX+"CodaYear__c yearDto : yearsAndPeriods)"
			reopen_year_apex_script += "{"
			reopen_year_apex_script += "yearDto."+ORG_PREFIX+"Status__c = 'Open';"
			reopen_year_apex_script += "for("+ORG_PREFIX+"codaPeriod__c periodDto : yearDto."+ORG_PREFIX+"Periods__r)"
			reopen_year_apex_script += "{"
			reopen_year_apex_script += "periodDto."+ORG_PREFIX+"Closed__c = false;"
			reopen_year_apex_script += "periodsToOpen.add(periodDto);"
			reopen_year_apex_script += "}"
			reopen_year_apex_script += "}"
			reopen_year_apex_script += "Update yearsAndPeriods;"
			reopen_year_apex_script += "update periodsToOpen;"
			if(ORG_TYPE == UNMANAGED) 
				reopen_year_apex_script += "CODAContext.disableSupportAccess();"
			end
			puts "Reopening year-"+ year_to_open.to_s
			APEX.execute_script reopen_year_apex_script
		end
	end

# get current period
	def FFA.get_current_period
		return Date.today.year.to_s + "/" + Date.today.month.to_s.rjust(3, "0")
	end
	
	def FFA.get_period_by_date the_date
		return the_date.year.to_s + "/" + the_date.month.to_s.rjust(3, "0")
	end

	def FFA.get_current_formatted_date
		locale = $locale ? $locale : gen_get_current_user_locale
		return gen_locale_format_date Time.now, locale
	end
##################################
# delete line items
##################################
	def FFA.click_cross_link_to_delete_line_item line_number
		line = line_number-1
		delete_link = $ffa_cross_link_to_delete.gsub($sf_param_substitute, line.to_s)
		find(delete_link).click
		FFA.wait_page_message $ffa_msg_removing_line
	end

# Add specified number of days in given date.
	def FFA.add_days_to_date given_date , days_to_add
		locale = $locale ? $locale : gen_get_current_user_locale
		new_date = given_date + (60*60*24*days_to_add.to_i)
		return gen_locale_format_date new_date, locale
	end

	def FFA.assert_transaction date, period, description, company, expected_tlis
		found_date = SF.get_std_view_field("Transaction Date")
		found_period = SF.get_std_view_field("Period")
		found_description = SF.get_std_view_field("Document Description")
		found_company = SF.get_std_view_field("Company")

		if found_company != company or found_description != description or found_period != period or found_date != date
			puts "Incorrect header values. Found is: Date = " + found_date + ", Decsription = " + found_description + ", Period = " + found_period + ", Company = " + found_company
			puts "Expected was: Date = " + date + ", Decsription = " + description + ", Period = " + period + ", Company = " + company
			return false
		end

		return FFA.assert_transaction_line_items expected_tlis
	end

	def FFA.assert_transaction_line_items expected_tlis
		within find(:xpath, $transaction_tli_related_list) do
			find(:xpath, $transaction_tli_go_to_list_link).click
		end
		all_tlis = all($transaction_tli_full_related_list + " " + $transaction_tli_full_related_list_line_id_link)
		all_tlis.each do |one_link|
			ref = one_link[:href]
			link_value = one_link.text
			within_window open_new_window do
				visit ref
				found_line = SF.get_std_view_field("Line Type") + " " + SF.get_std_view_field("Company")
					+ " " + SF.get_std_view_field("Home Value") + " " + SF.get_std_view_field("Home Currency")
					+ " " + SF.get_std_view_field("Dual Value") + " " + SF.get_std_view_field("Dual Currency")
					+ " " + SF.get_std_view_field("General Ledger Account") + " " + SF.get_std_view_field("General Ledger Account Value")
					+ " " + SF.get_std_view_field("Dimension 1") + " " + SF.get_std_view_field("Dimension 1 Value")
					+ " " + SF.get_std_view_field("Dimension 2") + " " + SF.get_std_view_field("Dimension 2 Value")
					+ " " + SF.get_std_view_field("Dimension 3") + " " + SF.get_std_view_field("Dimension 3 Value")
					+ " " + SF.get_std_view_field("Dimension 4") + " " + SF.get_std_view_field("Dimension 4 Value")
					+ " " + SF.get_std_view_field("Matching Status")
				if !expected_tlis.include? found_line
					puts "Incorrect tli: " + link_value + " with values [" + found_line + "]. Expected lines: " + expected_tlis
					return false
				end
				page.current_window.close
			end
		end
		return true
	end
	
	# sencha general methods

	#marked check box as checked if it is not
	#element_locator should be valid css 
	def FFA.sencha_check(element_locator)
		element = find(element_locator)
		is_checked = element[:class].include?("f-form-cb-checked")
		if(!is_checked)
			SF.log_info "clicking on checkbox - #{element}"
			element.click
		end
	end

	#unchecked check box
	#element_locator should be valid css 
	def FFA.sencha_uncheck(element_locator)
		element = find(element_locator)
		is_checked = element[:class].include?("f-form-cb-checked")
		if(is_checked)
			element.click
		end
	end
	
	#check if secnha checkbox is checked or not.
	#element_locator should be valid css 
	def FFA.is_sencha_check (element_locator)
		element = find(element_locator)
		is_checked = element[:class].include?("f-form-cb-checked")
		SF.log_info "Checkbox is checked?-  #{is_checked}"
		return is_checked
	end
	
	# Execute code on new window
	def FFA.new_window (&block)
		within_window (page.driver.browser.window_handles.last) do
			SF.execute_script do
				block.call()
			end
			# If new instance of browser is opened,close it.
			FFA.close_new_window
		end
	end
	
	# If any new window is opened after clicking on a button, Below method will close that window.
	def FFA.close_new_window
		num_of_windows =  page.driver.browser.window_handles.length
		SF.log_info "Number of windows opened: #{num_of_windows}"
		# On lightning org, when user click on print PDF from standard object view, PDF is opened in same browser and not in separate browser 
		# as in non lightning org. So taking the count of browser and closing only if a new instance of browser is present.
		if (num_of_windows !=1)
			page.current_window.close
		end
	end	
	
	#Close the sencha pop-up 
	def FFA.close_sencha_popup
		find($page_sencha_popup_close).click
	end
	
	# Activate or Deactivate the pricebook
	# pricebook_name = Name of the Price book.
	# is_active = boolean argument:true /false ; true to activate the pricebook.
	def FFA.activate_pricebook pricebook_name , is_active
		pricebook_activate_link = $ffa_pricebook_activate_link_pattern.sub($sf_param_substitute,pricebook_name)
		#Activate the Price book
		if is_active
			if (page.has_xpath?(pricebook_activate_link.sub($sf_param_substitute,"Activate") ,:wait => DEFAULT_LESS_WAIT))
				find(:xpath,pricebook_activate_link.sub($sf_param_substitute,"Activate")).click
				SF.wait_for_search_button
			else
				SF.log_info "Price book #{pricebook_name} is already Activated."
			end
		else 
			if (page.has_xpath?(pricebook_activate_link.sub($sf_param_substitute,"Deactivate") ,:wait => DEFAULT_LESS_WAIT))
				find(:xpath,pricebook_activate_link.sub($sf_param_substitute,"Deactivate")).click
				SF.wait_for_search_button
			else
				SF.log_info "Price book #{pricebook_name} is already De-activated."
			end
		end
			
	end
	
	# # # #
	# Pre-requisite: User with alias *smok* should exist on org and SDA key should be enabled for this admin user(can be done through subscribe access).
	# For managed org, enabling SDA is disabled due to security reasons. To overcome the problem of deleting data on managed org, we are creating a separate
	# admin user with alias smok and last name like SmokeDelete, and ebaling SDA key for this user so that whenever any task need to be performed with SDA enabled.
	# we can use this user to perform it on org.
	# # # #
	# Below code will execute the code as user=SmokeDelete if its managed org and logout to resume execution as normal admin user.
	# For unmanaged org, it will just execute the code of block and resume the execution.
	def FFA.delete_data_with_sda_access  (&block)
		#For manage org, we have to login with another user which has SDA key enabled.
		if (ORG_TYPE == MANAGED)
			SF.login_as_user $bd_user_smoke_admin_user_alias
			puts "Executing the code with support access on managed org."
		end
		#Execute the code to delete data from org.
		block.call()
		#logout from SDA key enabled user to resume script execution
		if (ORG_TYPE == MANAGED)
			SF.logout
			login_user
		end
	end
end


