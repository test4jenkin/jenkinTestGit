#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
module CIF
  extend Capybara::DSL

  #############################
  # CIF Helpers
  #############################
  ##
  #
  # Method Summary: Find the element and enter the value in to the field.
  #
  # @param [String] element_locator     ID, Name, Label, CSS or Xpath of a picklist field to find.
  # @param [String] value               Value to fill in to the input field.
  #
  def CIF.set_value(element_locator, value)
    page.has_css?(element_locator)
    find(element_locator).set('')
    find(element_locator).set(value)
  end

  ##
  #
  # Method Summary: Find the element, set the value and tab out from the input field.
  #
  # @param [String] element_locator     ID, Name, Label, CSS or Xpath of a picklist field to find.
  # @param [String] value               The required value to fill in.
  #
  def CIF.set_value_tab_out(element_locator, value)
    CIF.set_value element_locator, value
    gen_wait_less
	picklist_filtered_value = $cif_picklist_value_pattern.sub($cif_param_substitute,value.to_s) 
	if page.has_xpath?(picklist_filtered_value)
		find(:xpath , picklist_filtered_value).click
		gen_wait_less # wait to select the option get selected.
	end
	gen_tab_out element_locator
  end

  ##
  #
  # Method Summary: Find the element and returns the element text.
  #
  # @param [String] element_locator     ID, Name, Label, CSS or Xpath to find the element.
  #
  def CIF.get_text_of element_locator
    return find(element_locator).text    
  end

  ##
  # Method Summary: Select options from the pick list.
  # Note: Use this method if options are available in boundary list.
  #
  # @param [String] picklist_locator            ID, Name, Label, CSS or Xpath of a picklist field to find.
  # @param [String] value                       The required picklist value to select.
  #
  def CIF.select_pick_list picklist_locator,value
	CIF.set_value picklist_locator,value
	picklist_options_locator = $cif_picklist_value_pattern.sub($cif_param_substitute,value.to_s)
	find(:xpath, picklist_options_locator).click
  end
  ##
  # Method Summary: Enable the input locator when it is not visible 
  #
  # @param [String] picklist_input_locator		ID, Name, Label, CSS of a picklist field to enable.
  # @param [String] pick_list_locator       	The required picklist locator to enable picklist_input_locator
  #
  def CIF.enable_picklist_input_locator picklist_input_locator,pick_list_locator
	object_visible = gen_is_object_visible picklist_input_locator
	if (!object_visible)
		find(pick_list_locator).click
	end
  end
  ##
  # Method Summary: Checks the options from the pick list and return true incase of values are present else returns false
  #
  # @param [String] picklist_locator            ID, Name, Label, CSS or Xpath of a picklist field to find.
  # @param [String] value                       The required picklist value to check.
  #
  def CIF.check_pick_list picklist_locator,value
	CIF.set_value picklist_locator,value
	picklist_options_locator = $cif_picklist_value_pattern.sub($cif_param_substitute,value.to_s)
	return page.has_xpath?(picklist_options_locator,:wait => DEFAULT_LESS_WAIT)
  end
  ##
  #
  # Method Summary:  Method to Wait for Load Mask to disappear (could take full batch time of 5 mins)
  #
  # @param [Integer] seconds     Time in seconds to wait for the loading mask to disappear.
  #
  #

  def CIF.wait_for_loading_mask_to_complete seconds
    if seconds == nil
      seconds = DEFAULT_TIME_OUT
    end
    counter = 0
    begin
      _isMasked = page.has_css?($cif_load_mask)
    rescue
	  puts "Unable to see Load Mask."
    end
    if _isMasked == true
      puts "Waiting for Loading to complete..."
    end
    while _isMasked == true and counter < seconds do
      counter += 1
      sleep 1
      begin
        _isMasked = page.has_css?($cif_load_mask)
      rescue
        puts "Loading Complete."
        break
      end
    end
  end

  ##
  #
  # Method Summary: Method to wait for the info message to disappear.
  # Note: Info message means while calculations and buttons are loading on the screen specific messages appears on the screen until the loading or calculations completed.
  #
  # @param [String] content_message     Info messages that appears on the screen.
  #
  def CIF.wait_for_actions_to_complete content_message
    counter = 0
    loop do
      sleep 1
      counter += 1
      break if page.has_no_content?(content_message) or (counter >= DEFAULT_TIME_OUT)
    end
  end

  ##
  #
  # Method Summary: Method to wait for the total values to calculate.
  # Calculations messages should disappear after calculating the values.
  #
  #
  def CIF.wait_for_totals_to_calculate
    counter = 0
    loop do
      sleep 1
      counter += 1
      break if page.has_no_content?($cif_calculations_wait_message) or (counter >= DEFAULT_TIME_OUT)
    end
  end

  ##
  #
  # Method Summary: Wait for the buttons to load on the page.
  # Buttons on the page like Edit, Save, Save&Post etc.
  #
  #
  def CIF.wait_for_buttons_to_load
    counter = 0
    loop do
      sleep 1
      counter += 1
      break if page.has_no_content?($cif_buttons_loading_wait_message) or (counter >= DEFAULT_TIME_OUT)
    end
  end

  ##
  #
  # Method Summary: Method to select the required row from the grid and return it.
  # This can be done by searching the text of the unique column in a row and find the row.
  #
  # @param [String] grid_selector            ID, Name, Label, CSS or Xpath of the grid to find.
  # @param [String] search_text              Text to search in the column of each row to return the required row.
  # @param [Integer] col_number_search       Column number to search in every row.
  #
  def CIF.get_row_in_grid grid_selector, search_text, col_number_search
    # default search type  exact
    search_type = "exact"
    if search_text.end_with? "*"
      search_type = "partial"
    end
    allrows  = all("#{grid_selector} tr")
    row = 1
    while  row <= allrows.count
      cellvalue = find("#{grid_selector} table:nth-of-type(#{row}) tr td:nth-of-type(#{col_number_search})").text
      # exact mact
      if search_type == "exact"
        if search_text == cellvalue
          break
        end
        # partial match
      elsif search_type == "partial"
        if cellvalue.include? search_text.chomp('*')
          break
        end
      end
      row += 1
    end
    return row
  end

  ##
  #
  # Method Summary: Method to set discard reason in Discard Popup window.
  #
  # @param [String]  discard_text    Provide text to set on Discard Reason textbox in the Discard Popup
  #
  def CIF.set_discard_reason discard_text
    within_window (windows.last) do
      CIF.set_value($cif_discard_reason_textbox, discard_text)
    end
  end

  ###########################
  # Buttons
  ###########################
  ##
  #
  # Method Summary: Method to find and click the SAVE button.
  #
  #
  def CIF.click_save_button
	# In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
	if page.has_no_css?($cif_save_button ,:wait => DEFAULT_LESS_WAIT)
		CIF.click_toggle_button
	end
	page.has_css?($cif_save_button)
    find($cif_save_button).click
	#save button should disappear once page is refreshed.
    page.has_no_css?($cif_save_button)
  end
 
 ##
  #
  # Method Summary: Method to find and click the Convert to Credit note button.
  #
  #
  def CIF.click_convert_to_credit_note_button
	# In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
	if page.has_no_css?($cif_convert_to_credit_note ,:wait => DEFAULT_LESS_WAIT)
		CIF.click_toggle_button
	end
    find($cif_convert_to_credit_note).click
    page.has_css?($cif_save_button)
  end

  ##
  #
  # Method Summary: Method to find and click the SAVE & NEW button.
  #
  #
  def CIF.click_save_new_button
	# In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
	if page.has_no_css?($cif_save_new_button ,:wait => DEFAULT_LESS_WAIT)
		CIF.click_toggle_button
	end
    find($cif_save_new_button).click
    page.has_css?($cif_save_button)
  end

  ##
  #
  # Method Summary: Method to find and click the SAVE & POST button.
  #
  #
  def CIF.click_save_post_button
	# In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
	if page.has_no_css?($cif_save_post_button ,:wait => DEFAULT_LESS_WAIT)
		CIF.click_toggle_button
	end
    find($cif_save_post_button).click
	page.has_no_css?($cif_save_post_button, :visible=> false)
    CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
  end

  ##
  #
  # Method Summary: Method to find and click the SAVE, POST & NEW button.
  #
  #
  def CIF.click_save_post_new_button
    # In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
  	if page.has_no_css?($cif_save_post_new_button ,:wait => DEFAULT_LESS_WAIT)
  		CIF.click_toggle_button
  	end
    find($cif_save_post_new_button).click
	page.has_css?($cif_save_button)
    CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
  end
  
  ##
  #
  # Method Summary: Method to find and click POST button.
  #
  #
  def CIF.click_post_button
	 # In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
  	if page.has_no_css?($cif_post_button ,:wait => DEFAULT_LESS_WAIT)
  		CIF.click_toggle_button
  	end
    find($cif_post_button).click
	page.has_no_css?($cif_post_button)
	CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
  end
  ##
  #
  # Method Summary: Method to find and click the Edit button.
  #
  #
  def CIF.click_edit_button
	find($cif_edit_record_button).click
    CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
	page.has_css?($cif_save_button)
  end
  ##
  #
  # Method Summary: Method to find and click the GoBack button.
  #
  #
  def CIF.click_cancel_button
    find($cif_cancel_button).click
    gen_wait_less
	gen_accept_alert_if_present
  end

  ##
  #
  # Method Summary: Method to click Discard button on CIF pages.
  #
  #
  def CIF.click_discard_button
    find($cif_discard_button).click
    gen_wait_less
  end

  ##
  #
  # Method Summary: Method to click Amend button on CIF pages.
  #
  #
  def CIF.click_amend_button
	 # In case, line Item full view page is dispyaed, User need to click on toggle incon to display the button
  	if page.has_no_xpath?($cif_amend_button ,:wait => DEFAULT_LESS_WAIT)
  		CIF.click_toggle_button
		page.has_xpath?($cif_amend_button,:visible => true )
  	end
    find(:xpath, $cif_amend_button).click
    CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
  end

  ##
  #
  # Method Summary: Method to click Clone button on CIF pages.
  #
  #
  def CIF.click_clone_button
    find($cif_clone_button).click
  end

  ##
  #
  # Method Summary: Method to click Discard button on Discard Popup page.
  #
  #
  def CIF.click_popup_discard_button
    within_window (windows.last) do
      find($cif_discard_popup_discard_button).click
      CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
      CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
    end
  end

  ##
  #
  # Method Summary: Method to find and click the image icon to add a new row.
  #
  #
  def CIF.click_new_row
	SF.execute_script do
		CIF.wait_for_actions_to_complete $cif_line_items_no_data_message		
		find($cif_click_new_line_row).click
	end	
  end
  
  ##
  #
  # Method Summary: Method to find and click the image icon to delete a row by input parameter row number
  #
  # @param [Integer] line            Line number to delete.
  #
  def CIF.delete_row line
	SF.execute_script do
		CIF.wait_for_actions_to_complete $cif_line_items_no_data_message	
		row_to_delete = $cif_click_delete_line_row.gsub($sf_param_substitute, line.to_s)
		if(page.has_css?($cif_click_new_line_row))
		gen_wait_until_object row_to_delete
		find(row_to_delete).click
		else
		puts "No new row to delete"
		end
	end	
  end

  ##
  #
  # Method Summary: Method to find and click the image icon to copy a row by input parameter row number
  #
  # @param [Integer] line            Line number to copy.
  #
  def CIF.copy_row line
	SF.execute_script do
		CIF.wait_for_actions_to_complete $cif_line_items_no_data_message  
		row_to_copy = $cif_click_copy_line_row.gsub($sf_param_substitute, line.to_s)
		find(row_to_copy).click
	end
  end
  
  ##
  #
  # Method Summary: Method to click on continue.
  #
  #  
  def CIF.click_continue_button
	find(:xpath, $cif_continue_button_on_info_message_popup).click
  end

  ##
  #
  # Method Summary: Find a cell in line items of cif pages
  #
  #  
  def CIF.get_matching_object_ignoring_action_table object_to_click, line=1
    potential_records_to_click = object_to_click.gsub($sf_param_substitute, line.to_s)
    #get all the matches rather than the first one, there are two tables, one with the data, one with the actions
    all_potentials = all(potential_records_to_click).to_a
    record_to_click = nil;
    all_potentials.each do |potential|
      record_to_click = potential
      #it's the correct table if it doesn't have the new line button
      break if !(page.has_css?($cif_click_new_line_row))
    end
    return record_to_click
  end
  
  ##
  #
  # Method Summary: To activate the cell in line items of cif pages
  #
  #  
  def CIF.activate_line_field_item field_item, object_to_click, input_value, line=1
    SF.retry_script_block do
      object_visible = gen_is_object_visible field_item
      if (!object_visible)
        record_to_click = CIF.get_matching_object_ignoring_action_table object_to_click, line
        record_to_click.click
        gen_wait_less
      end
      CIF.set_value_tab_out field_item, input_value 
    end
  end
  
  ##
  #
  # Method Summary: Get the document number from the header.
  #
  #  
  def CIF.get_document_number_from_header 
	SF.execute_script do
		return find($cif_header_document_number).text.split(' ').last
	end
  end

  ##
  #
  # Method Summary: Get the toast message appearing at the top of the header.
  #
  #  
  def CIF.get_header_toast_message
    return find($cif_header_toast_message_box).text
  end

  ##
  #
  # Method Summary: toggle for change of view.
  #
  # 
  def CIF.click_toggle_button
	SF.execute_script do
		find($cif_toggle_button).click
    sleep (0.5)
	end
  end
  ##
  # Symbols supported for keys :cancel :help :backspace :tab :clear :return :enter :shift :control :alt :pause :escape :space :page_up :page_down :end :home :left 
  # :up :right :down :insert :delete :semicolon :equals :numpad0 :numpad1 :numpad2 :numpad3 :numpad4 :numpad5 :numpad6 :numpad7 :numpad8 :numpad9 :multiply - numeric 
  # keypad * :add - numeric keypad + :separator - numeric keypad 'separator' key ?? :subtract - numeric keypad - :decimal - numeric keypad . :divide - numeric keypad 
  # / :f1 :f2 :f3 :f4 :f5 :f6 :f7 :f8 :f9 :f10 :f11 :f12 :meta :command - alias of :meta
  # Don't pass parameter as a string
  def CIF.send_keys_on_page key_name  
	builder = page.driver.browser.action
	builder.send_keys(key_name).perform
	gen_wait_less # wait to select the option get selected.
  end
  ##
  #
  # Method Summary: Click on transaction link
  #
  #
  def CIF.click_transaction_link
	gen_wait_until_object $cif_transaction_number_link
	find($cif_transaction_number_link).click
  end
  
##
  #
  # Method Summary: select cif page for new/edit/view buttons
  # vf_page_name- Name of visual force page which need to be set.
  #
	def CIF.select_vf_page_for_cif_layout vf_page_name
		SF.choose_visualforce_page vf_page_name
	end
	
  ##  
  # Method Summary: Gets the count of matched value_lists passed in the parameter
  # 
  # @param [string] 	picklist_locator		This locator required incase the picklist_input_locator is not visible on the page
  # @param [string]     picklist_input_locator	Input is entered into it 
  # @param [string]		value_list				list of values provided
  # @param [string]		line[default = 1]		Line value required for specifying the line other than 1 to enter the data.
	def CIF.get_matched_count_picklist_value picklist_locator, picklist_input_locator, value_list, line=1
		matched_count = 0
		page.has_css?($cif_click_new_line_row)
		value_list.each do |value|
			record_to_click = picklist_locator.gsub($sf_param_substitute, line.to_s)
			CIF.enable_picklist_input_locator picklist_input_locator,record_to_click
			value_found = CIF.check_pick_list picklist_input_locator,value
			if value_found
				matched_count+=1
			else
				SF.log_info "Value is not present in picklist: "+ value
			end
		end
		return matched_count
	end
##
# Method Summary : click on the related list toolbar items, which are Attachments, Events, Files, Groups, History:Sales Invoice, Notes, Tasks, Chatter
# 
  def CIF.click_related_list_toolbar_item item_name
	SF.retry_script_block do 
		SF.execute_script do
			find(:xpath, $cif_related_list_toolbar_item_pattern.sub($sf_param_substitute, item_name)).click
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		end
	end
  end
##
# Method Summary : Collapse the related list toolbar view
#
  def CIF.click_to_collapse_related_list_toolbar_view
	SF.execute_script do
		if(page.has_css?($cif_related_list_collapse_icon))
			find($cif_related_list_collapse_icon).click
		end
	end
  end
##
# Method Summary : Get the count of lines
#  
  def CIF.get_count_of_lines_in_related_list_toolbar
	page.has_css? $cif_related_list_lines
	lines = all($cif_related_list_lines)	 
	return lines.count.to_s
  end
##
# Method Summary : Create New Note in the related list toolbar
#
# @param [String]  note_name            Text to set as title on the note
# @param [String]  note_body            Text to set as Body on the note
#
  def CIF.create_new_note_in_related_list note_name,note_body
    SF.execute_script do
		gen_wait_until_object $cif_related_list_new_note
		find($cif_related_list_new_note).click
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK 
		find($cif_related_list_note_title).set note_name
		find($cif_related_list_note_body).set note_body
		SF.click_button_save
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    end
  end
##
# Method Summary : Click on Back to list button
#  
  def CIF.click_back_to_list_button
	SF.execute_script do
		page.has_css? $cif_back_to_list_link
		find($cif_back_to_list_link).click
		SF.wait_for_search_button
	end
  end


##
# Method Summary : Verify the order of columns in related list popup on custom object
#  
# @param [List<String>]   field_list    List of fields to verify their order
# @param [Boolean]        is_present    [True/False] whether to determine the presence or absense of field at particular location
# return [List<String>]   result_list   Return Nil if fields are in right order else return the names
#
  def CIF.verify_related_list_field_order field_list, is_present
    result_list = Array.new()
    field_list.each_with_index do |field,index|
      column_num = index + 1
      column_to_search = $cif_related_list_header_fields.sub($sf_param_substitute, column_num.to_s)
      obj_locator = column_to_search.sub($sf_param_substitute, field)
      field_exist = page.has_xpath?(obj_locator)
      if (is_present && !field_exist)
        result_list.push(field + ' should exist at column number: ' + column_num.to_s)
      elsif (!is_present && field_exist)
        result_list.push(field + ' should not exist at column number: ' + column_num.to_s)
      end
    end
    return result_list
  end

  # return data for specified row and column
  def CIF.get_grid_data_col rowNumber, columnNumber
    return find($cif_grid_rows+" tr:nth-of-type(#{rowNumber}) td:nth-of-type(#{columnNumber})").text
  end

  # return data for specified row
  def CIF.get_grid_data_row rowNumber
    return find($cif_grid_rows+" tr:nth-of-type(#{rowNumber})").text
  end
  
  # return total no of rows (Grand total row not included)
  def CIF.get_grid_rows 
    rows = all($cif_grid_rows)
    return rows.size
  end

##
# Method Summary : Click Submit for approval button in the Approval History Related List
#  
  def CIF.click_related_list_submit_for_approval_button
    SF.execute_script do
      gen_wait_until_object $cif_related_list_approval_history_frame
      within_frame(find(:xpath, $cif_related_list_approval_history_frame)) do
        find(:xpath, $cif_related_list_approval_history_submit_button).click
        gen_alert_ok
      end
      gen_wait_until_object $cif_related_list_toolbar
    end
  end

##
# Method Summary : Click Recall Approval Request button in the Approval History Related List
#  
  def CIF.click_related_list_recall_approval_request_button
    SF.execute_script do
      gen_wait_until_object $cif_related_list_approval_history_frame
      within_frame(find(:xpath, $cif_related_list_approval_history_frame)) do
        find(:xpath, $cif_related_list_approval_history_recall_button).click
      end
    end
  end

##
# Method Summary : Click Approve/Reject/Recall button on the Approval History Record page
#  
# @param [String]   action    Specify the action as Approve/Reject/Recall 
# @param [String]   comments  Enter the comments in the Approval History page textarea
#
  def CIF.click_approval_history_action_button action, comments
    SF.execute_script do
      find($cif_related_list_approval_history_comments_textarea).set comments
      _related_list_action = $cif_related_list_approval_history_button.sub($cif_ifm_param_substitute,action.to_s)
      find(:xpath, _related_list_action).click
      gen_wait_until_object $cif_related_list_toolbar
    end
  end

##
# Method Summary : Reassign the Approval History Record on the Related List
#  
# @param [String]   next_approver    Name of the next approver which user want to reassign
#
  def CIF.click_approval_history_reassign_the_approval_request_button next_approver
    SF.execute_script do
      find(:xpath,$cif_related_list_custom_object_input).set ""
      find(:xpath,$cif_related_list_custom_object_input).set next_approver
      _related_list_action = $cif_related_list_approval_history_button.sub($cif_ifm_param_substitute,$cif_related_list_approval_history_action_reassign_request.to_s)
      find(:xpath, _related_list_action).click
      gen_wait_until_object $cif_related_list_toolbar
    end
  end

##
# Method Summary : Click Approve/Reject link on Approval History Related List
#  
  def CIF.click_related_list_approve_or_reject_link
    gen_wait_until_object $cif_related_list_approval_history_frame
    within_frame(find(:xpath, $cif_related_list_approval_history_frame)) do
      find(:xpath, $cif_related_list_approval_history_approve_reject_link).click
    end
  end

##
# Method Summary : Click Reassign link on Approval History Related List
#  
  def CIF.click_related_list_reassign_link
    gen_wait_until_object $cif_related_list_approval_history_frame
    within_frame(find(:xpath, $cif_related_list_approval_history_frame)) do
      find(:xpath, $cif_related_list_approval_history_reassign_link).click
    end
  end

##
# Method Summary : Get the Approval Status from the approval history related list
#  
  def CIF.get_related_list_approval_record_status
    gen_wait_until_object $cif_related_list_approval_history_frame
    within_frame(find(:xpath, $cif_related_list_approval_history_frame)) do
      return find($cif_related_list_approval_history_record_status).text
    end
  end

##
# Method Summary : Verify that the status of related list record when reassigned
#  
  def CIF.get_approval_related_list_reassign_status
    gen_wait_until_object $cif_related_list_approval_history_frame
    within_frame(find(:xpath, $cif_related_list_approval_history_frame)) do
      find($cif_related_list_approval_history_grid).hover
      return find($cif_related_list_approval_history_reassign_status).text
    end
  end

##
# Method Summary : Click Leave button on Save Changes popup
#  
  def CIF.click_leave_button_on_save_changes_popup
    find($cif_continue_button).click
  end
  
## 
# Method Summary : return the column number from line item grid of document as per the column name passed.
# @col_name = Name of the column for which column numner need to be retrieved.
##
	def CIF.get_line_column_number col_name
		total_line_cols = all(:xpath,$cif_line_num_of_columns).size
		SF.log_info "total number of columns = #{total_line_cols}"
		for j in 1..total_line_cols do
			col_value = $cif_line_column_number_pattern.sub($sf_param_substitute , j.to_s)
			cell_value = find(:xpath,col_value).text
			SF.log_info "value - #{cell_value}"
			# check for the column name value 
			if (cell_value == col_name)
				SF.log_info "value at column #{j}"
				return j
			end
		end
	end
	
	
end
