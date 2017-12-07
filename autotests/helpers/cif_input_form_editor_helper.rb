module CIF_IFM
  extend Capybara::DSL

  #Buttons


  # Buttons that are available when no/one/some forms are selected
  # Fields on new document dialog
  $cif_ifm_new_form_popup = ("[data-ffxtype=cfe-manager-new]")
  $cif_ifm_document_type =  '//div[@data-ffxtype="cfe-manager-new"]//span[text()="Document Type"]/ancestor::label/following-sibling::div/div/div/following-sibling::div[contains(@class,"f-form-arrow-trigger")]'
  $cif_ifm_continue_button = "div[data-ffalias='widget.toolbar'] div div a:nth-of-type(2)"
  $cif_ifm_continue_form_exception_button = "a[data-ffid=ok]"
  $cif_ifm_save_button = "a[data-ffid=saveButton]"
  $cif_ifm_document_name_input = 'div[data-ffxtype=appheaderbar] div[data-ffxtype=textfield] input'
  $cif_ifm_selected_company_list = "[data-ffxtype='tagfield']"
  $cif_ifm_company_list = "div[data-ffxtype='tagfield'] li div"
  $cif_ifm_grid = "div[data-ffxtype='grid'] div[data-ref='body']"
  $cif_ifm_form_activate_button = "a[data-ffxtype='button']"
  $cif_ifm_boundary_list = "div[data-ffxtype=boundlist]"

  $cif_ifm_new_button = "a[data-ffid=newButton]"
  $cif_ifm_edit_button = "//span[text()='Edit']"
  $cif_ifm_clone_button = "//span[text()='Clone']"
  $cif_ifm_delete_button = "//span[text()='Delete']"


  $cif_ifm_cancel_button = "div[data-ffalias='widget.toolbar'] div div a:nth-of-type(1)"
  $cif_ifm_continue_form_exception_button = "a[data-ffid=ok]"
  $cif_ifm_delete_no_button = "a[data-ffid=no]"
  $cif_ifm_delete_yes_button = "a[data-ffid=yes]"



  $cif_ifm_activate_button = 'div[data-ffxtype="cfe-manager-assignment"] div[data-ffxtype="toolbar"] a[data-ffxtype="button"]'
  $cif_ifm_select_all_companies = '//div[contains(@id,"radiofield")]//label[text()="All"]'





  # Header bar
  $cif_ifm_document_name_input = 'div[data-ffxtype=appheaderbar] div[data-ffxtype=textfield] input'

  # Journal Line Items / Journal Header Items / Other options available (for View)
  $cif_ifm_field_type_selector = 'div[data-ffxtype=config-container] div[data-ffxtype=combo]'
  $cif_ifm_field_type_selector_input = 'div[data-ffxtype=config-container] div[data-ffxtype=combo] input'


  $cif_ifm_param_substitute = 'Replace Me'

  #Journal Fields -  Available fields are in a <div> - Are the same for Header and Line Items
  $cif_ifm_field_add = '//div[text()="'+$cif_ifm_param_substitute+'"]'

  # These are necessary because they become a <span> when they're on the form,
  # rather than a <div> in the list of available fields. Possibly just for Header fields... Line fields have no spaces
  $cif_ifm_header_field_remove = '//span[text()="'+$cif_ifm_param_substitute+'"]'

  # Line fields are different, again.
  $cif_ifm_line_field_remove = '//div[contains(@data-ffid,"codaJournalLineItem__c")]//div[contains(@id,"'+$cif_ifm_param_substitute+'__c-textEl")]'

  #Input Form Manager checkboxes and grid
  # e.g //div[text()='Capybara-Generated Journal Input']/../preceding-sibling::td/div/div[@class='f-grid-row-checker']
  $cif_ifm_select_form_checkbox = "//div[text()='"+$cif_ifm_param_substitute+"']/../preceding-sibling::td/div/div[@class='f-grid-row-checker']"

  $cif_ifm_checkbox_checked = "//table[contains(concat(' ', @class, ' '), 'f-grid-item-selected')]//tr/td/div[text()='"
  $cif_ifm_form_grid = 'div[data-ffxtype="grid"]'

  #Containers - Drag stuff here
  $cif_ifm_first_new_row = "div[data-ffxtype='cfe-dd-container']:nth-of-type(2) div[data-ffid='rowDropTarget'] , div[data-ffxtype='droptarget']"
  $cif_ifm_new_row_next = "div[data-ffxtype='cfe-dd-container']:nth-of-type(3) div[data-ffid='sourceDropTarget'], div[data-ffxtype='droptarget']"
  $cif_ifm_totals_next = "div[data-ffxtype='panel']:nth-of-type(2) div[data-ffxtype='cfe-dd-container'], div[data-ffxtype='droptarget']"

  # List of available fields - drag fields off the form to here - used for both header and line items
  $cif_ifm_drag_off = "div[data-ffxtype='config-container'] div[data-ffxtype='tableview']"

    #Line Items - The headers - can drag fields to / from here.
  $cif_ifm_journal_line_headers = "div[data-ffxtype='tabpanel'] div[data-ref='body'] div[data-ffxtype='headercontainer']"


  #Methods
  ##
  #
  # Method Summary: Check if the forms supplied already exist
  # Note: Returns empty array if none found
  # @param [String] form_names                  Array of the form names to search for
  # @return [String] visibleForms               Array of the forms that were found, if any.
  #
  def CIF_IFM.check_if_forms_exist form_names
    CIF.wait_for_loading_mask_to_complete 5
    # iterate through the list of forms, if they can be found, add they to existing forms array
    visibleForms = Array.new()
    form_names.each do |form|
      begin
        __form_xpath = CIF_IFM.get_formname_xpath(form)
        __formExists = find(:xpath, __form_xpath).visible?
      if __formExists
        visibleForms.push(form)
        end
      rescue
        puts "Form: '#{form}' not found"
      end
    end
    return visibleForms
  end


  #
  # Method Summary: Get the full xpath of a form's checkbox, given a form name
  # @param [String] form_name                   Form name to search for
  # @return [String] __form_name_xpath          Xpath locator of form's checkbox
  #
  def CIF_IFM.get_formname_xpath form_name
  # if there isn't a form name supplied...return nil ?
      __form_name_xpath = $cif_ifm_select_form_checkbox.sub($cif_ifm_param_substitute, form_name)
      begin
        find(:xpath, __form_name_xpath).visible?
      rescue
        #puts "**Xpath** for #{form_name} not found"
      end
      # DEBUG: puts(__form_name_xpath)
      return __form_name_xpath
  end

  #
  # Method Summary: Remove spaces from an array of strings and return the modified array
  # @param [String] stringArray                 Array of strings to modify
  # @return [String] __spacesStrippedArray      Xpath locator of form's checkbox
  #
  def CIF_IFM.strip_spaces_from_strings stringArray
    __spacesStrippedArray = Array.new()
    stringArray.each do |theString|
      __spacesStrippedArray.push(theString.delete(' '))
    end
    return __spacesStrippedArray
  end


  #
  # Method Summary: Check if a given form is active, returns true of false
  # @param [String] form_name                   Form name to search for
  # @return [String] __isActive                 True or false, depending on whether or not the form is active.
  #
  def CIF_IFM.check_if_active form_name
    # Get the row number for the Form
    gen_wait_less
    __formRow = CIF.get_row_in_grid($cif_ifm_form_grid, form_name, 2)
    puts "#{form_name} found at row: #{__formRow}...check if Active"
    # Check if the Status field is "Active"
    _isActive = false
    begin
      __isActive = find(:xpath, "//table[#{__formRow}]/tbody/tr/td[8]/div[text()='Active']").visible?
    rescue
      puts "#{form_name} was not active... doing nothing"
    end
    return __isActive
  end


  #
  # Method Summary: Deactivates the form
  # @param [String] form_name                   Form name to deactivate
  # @return N/A
  #
  def CIF_IFM.deactivate form_name
    CIF_IFM.deselect_if_selected form_name
    __form_name_xpath = CIF_IFM.get_formname_xpath(form_name)
    # Deactivate!
    puts "#{form_name} was active. Deactivating..."
    find(:xpath, __form_name_xpath).click
    find(:css, $cif_ifm_activate_button).click
    CIF.wait_for_loading_mask_to_complete 5
  end


  #
  # Method Summary: Check if a given form is selected/checked, deselects it if so
  # Note: Returns empty array if none found
  # @param [String] form_name                   Form name to deselect
  # @return N/A
  #
  def CIF_IFM.deselect_if_selected form_name
    # Get the form name xpath
    __form_name_xpath = CIF_IFM.get_formname_xpath(form_name)
    __checkedXpath = "#{$cif_ifm_checkbox_checked}#{form_name}']"
      #Do some stuff...
      __formChecked = false
      begin
        __formChecked = find(:xpath, __checkedXpath).visible?
        if __formChecked == true
          find(:xpath, __form_name_xpath).click
        end
      rescue
        puts "#{form_name} not checked"
      end
    end



  #
  # Method Summary: Select a form then click the Edit button
  # @param [String] form_name                   Form name to edit
  # @return N/A
  #
  def CIF_IFM.select_and_edit_form form_name
    CIF_IFM.deselect_if_selected form_name
    __form_name_xpath = CIF_IFM.get_formname_xpath(form_name)
    # Check the box again
    find(:xpath, __form_name_xpath).click
    find(:xpath, $cif_ifm_edit_button).click
    CIF.wait_for_loading_mask_to_complete 5
  end


  #
  # Method Summary: Select the given form and click the Activate button
  # @param [String] form_name                   Form name to search for
  # @return N/A
  #
  def CIF_IFM.select_and_activate_form form_name
    CIF_IFM.deselect_if_selected form_name
    __form_name_xpath = CIF_IFM.get_formname_xpath(form_name)
     # Check the box again
    find(:xpath, __form_name_xpath).click
    find(:xpath, $cif_ifm_select_all_companies).click
    find(:css, $cif_ifm_activate_button).click
    CIF.wait_for_loading_mask_to_complete 5
  end

  #
  # Method Summary: Select the given form and click the Clone button
  # @param [String] form_name                   Form name to Activate
  # @return N/A
  #
  def CIF_IFM.select_and_clone_form form_name
    __form_name_xpath =  CIF_IFM.get_formname_xpath(form_name)
    CIF_IFM.deselect_if_selected(form_name)
    # Check the box again
    find(:xpath, __form_name_xpath).click
    find(:xpath, $cif_ifm_clone_button).click
    CIF.wait_for_loading_mask_to_complete 5
  end


  #
  # Method Summary: Select the given form and click the Delete button
  # @param [String] form_name                   Form name to Delete
  # @return N/A
  #
  def CIF_IFM.select_and_delete_forms form_names, really_delete
    # Create a new array, put the xpath version of formname(s) into it.
    ary = Array.new()
    names = Array.new()
    form_names.each do |form|
     CIF_IFM.deselect_if_selected(form)
      __sub = $cif_ifm_select_form_checkbox.sub($cif_ifm_param_substitute, form)
      ary.push(__sub)
      names.push(form)
    end
    ary.each_with_index do |formtodelete,index|
        # Select the form
        puts "Preparing to delete existing form: (#{names[index]}"
        find(:xpath, formtodelete).click
    end
      find(:xpath, $cif_ifm_delete_button).click
      if really_delete == "yes"
        find($cif_ifm_delete_yes_button).click
      else
        # Don't really want to delete - click no.
        find($cif_ifm_delete_no_button).click
      end
  end

  #
  # Method Summary: Select the given form and click the Activate button
  # @param [String] fields                   Array of fields to drag on/off the layout
  # @param [String] field_start              Start of the field locator(could be //span or /div)
  # @param [String] field_end                End of the field locator (different for line)
  # @param [String] drag_to_here             Where to drag the field to
  # @param [String] drag_to_there            Where to drag field to if not same as drag_to_here (used for Header fieds)
  # @return N/A
  #
  def CIF_IFM.drag_fields_on_layout fields, field_to_move, drag_to_here, drag_to_there
    ary = Array.new()
    # DEBUG: puts "Number of fields to fiddle with: #{fields.length}"
    fields.each do |field|
      __newfield = field_to_move.sub($cif_ifm_param_substitute, field)
      ary.push(__newfield)
    end
    # DEBUG: puts "Length of array ary = #{ary.length}" #<< DEBUG
    # DEBUG: ary.each_with_index {|val, index| puts "#{val} => #{index}" }
    count = 1
    ary.each do |fieldtodrag|
      if count == 1 # IF 1, then drag to new blank area, IF > 1 then will drag to the area we just "created"
        CIF_IFM.drag_to_destination(fieldtodrag, drag_to_here)
      else
        if drag_to_there != nil
          CIF_IFM.drag_to_destination(fieldtodrag, drag_to_there)
        else
          CIF_IFM.drag_to_destination(fieldtodrag, drag_to_here)
        end
      end
      count = count + 1
    end
  end

  #############################################
  # Helper methods for Input form manager
  ############################################
  ##
  #
  # Method Summary: Search and select the form from the input form manager list view.
  # This can be done by searching the text of the unique column i.e form name in a row.
  #
  # @param [String] form_name               Name of the form that needs to select from the list.
  #
  def CIF_IFM.select_input_form_manager_from_list(form_name)
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    page.has_css?("div[data-ffxtype='grid']")
    rowNumber = CIF_IFM.get_row_in_grid $cif_ifm_grid ,form_name, '2'
    find("#{"div[data-ffxtype='grid']"} table:nth-child(#{rowNumber}) tr:nth-of-type(1) td:nth-of-type(1) div div").click
    gen_wait_less
  end

  ##
  #
  # Method Summary: Select the company name to activate the form.
  # If the company that a user want to select is previously selected this method first deletes the company and select it again.
  #
  # @param [String] company_name          Text to set the company name.
  #
  def CIF_IFM.select_company(company_name)
    find($cif_ifm_select_company).click
    begin
      _is_company_selected = page.has_css?($cif_ifm_company_list)
    rescue
      puts "#{company_name} company is not preselected"
    end
    if _is_company_selected == true and find($cif_ifm_company_list).text == companyName
      find($cif_ifm_selected_company_list).find("li",:text => companyName).find("div:nth-child(2)").click
    end
    gen_wait_less
    find($cif_ifm_select_company).click
    find($cif_ifm_select_company).click
    page.has_css?($cif_ifm_boundary_list)
    find($cif_ifm_boundary_list).find("li",:text => companyName).click
    puts("Selected the company: #{companyName}")
  end

  ##
  #
  # Method Summary: Select the document type from the list.
  #
  # @param [String] document_type          Name od the document to select.
  #
  def CIF_IFM.select_document_type document_type
    find(:xpath,$cif_ifm_document_type).click
    find($cif_ifm_boundary_list).find("li",:text => document_type).click
  end

  ##
  #
  # Method Summary: Select the form type.
  #
  # @param [String] form_type          Text of the form type to select.
  #
  def CIF_IFM.select_form_type form_type
    _form_type = $cif_ifm_form_type.sub($cif_ifm_param_substitute, form_type)
    find(:xpath,_form_type).click
  end


  ##
  #
  # Method Summary: Set the form name.
  #
  # @param [String] form_name          Text to set the name of the form.
  #
  def CIF_IFM.set_form_name form_name
    find($cif_ifm_document_name_input).click
    find($cif_ifm_document_name_input).set(form_name)
  end


  #######################################
  # Buttons
  #######################################

  ##
  #
  # Method Summary: Click the new button to create a new  form..
  #
  def CIF_IFM.click_new_button
    SF.retry_script_block do 
		page.has_css?($cif_ifm_new_button)
		find($cif_ifm_new_button).click
	end
    CIF.wait_for_loading_mask_to_complete 5
  end

  ##
  #
  # Method Summary: Click the continue button to navigate to the next screen during the form creation process.
  #
  def CIF_IFM.click_continue_button
    find($cif_ifm_continue_button).click
  end

  ##
  #
  # Method Summary: Click the save button to save the form.
  #
  def CIF_IFM.click_save_button
    find($cif_ifm_save_button).click
  end

  ##
  #
  # Method Summary: Click the activate button to activate the form.
  #
  def CIF_IFM.click_activate_button
    find($cif_ifm_form_activate_button, :text => 'Activate').click
  end

  #
  # Method Summary: Attempt to save the layout without first entering a name
  # @param N/A
  # @return N/A
  #
  def CIF_IFM.verify_no_name_exception
    click_save_button
    find($cif_ifm_continue_form_exception_button).click
  end

  #
  # Method Summary: Click the New button in the Input Form Manager
  # @param [String] form_name     Name of the form to use
  # @return N/A
  #
  def CIF_IFM.verify_save_success form_name
    #use .set because gen_send_key doesn't overwrite existing text
	SF.execute_script do
		find($cif_ifm_document_name_input).set(form_name)
		click_save_button
		CIF.wait_for_loading_mask_to_complete 10
	end
  end

  #
  # Method Summary: Click the New button in the Input Form Manager
  # @param [String] doc_type      Type of Document; PINV, SINV, Journal, etc.
  # @param [String] form_type     Type of form; Input/view
  # @param [String] continue      Whether or not to cancel the New Form dialog
  # @return N/A
  #
  def CIF_IFM.newCIFLayout doc_type, form_type, continue
	SF.retry_script_block do 
  		find(:xpath, $cif_ifm_document_type).click
  		sleep 1 # wait for options to display
  		find($cif_ifm_boundary_list).find("li",:text => doc_type).click
  		# select form type
  		CIF_IFM.select_form_type form_type
  		if continue.downcase == "yes"
  		  find($cif_ifm_continue_button).click
  		else
  		  find($cif_ifm_cancel_button).click
  		  puts "Clicking the cancel button on the New Form Dialog"
  		end
    end
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

  #
  # Method Summary: Select the type of fields in the editor (Doc Type Header/Field/Other)
  # @param [String] field_type     Type of the field to select (header/lines/etc.)
  # @return N/A
  #
  def CIF_IFM.selectFields field_type
    # Should wait for the thing to be visible
    rc = page.has_css? ($cif_ifm_field_type_selector)
    if rc == true
    # Click the dropdown
    find($cif_ifm_field_type_selector).click
    # Click on the actual input field
    find($cif_ifm_field_type_selector_input).click
    # Enter "Journal Header Items" or "Journal Line Items"
    #use .set because gen_send_key doesn't overwrite.
    find($cif_ifm_field_type_selector_input).set(field_type)
    # Send the Enter key to make the selection valid, THEN send the down arrow key, because otherwise they'll disappear
    # when the field is left. Silly Sencha?
    gen_send_key($cif_ifm_field_type_selector_input, :return)
    gen_send_key($cif_ifm_field_type_selector_input, :arrow_down) #THIS is needed for some reason<<<< !!!
    end
  end


  #
  # Method Summary: Drag a field/object to another place on the form
  # @param [String] object      locator of the object
  # @param [String] destination locator of the destination
  # @return N/A
  #
  def CIF_IFM.drag_to_destination object, destination
    if object.start_with? "//"
      drag_source = find(:xpath, object)
    else
      drag_source = find(:css, object)
    end
    if destination.start_with? "//"
      drag_dest = find(:xpath, destination)
    else
      drag_dest = find(:css, destination)
    end
    # DEBUG: puts("Dragging from #{drag_source} to #{drag_dest}...") << DEBUG (not very useful, really - not human readable)
    drag_source.drag_to(drag_dest)
  end
  
  #
  # Method Summary : Verify the related list on input form editor
  # @param [List<String>]   related_list_name    Name of the Related List to be passed in a list
  # @param [Boolean]        is_present           [True/False] whether to determine the presence or absense of related list
  # return [List<String>]   result_list          Return Nil if related list is present/absent else array of fields which fails the test
  #
  def CIF_IFM.verify_related_list_on_ifm_editor related_list, is_present
	result_list = Array.new()
	related_list.each do |related_list_name|
    _trimmed_name = related_list_name.delete(' ')
    _trimmed_name_final = _trimmed_name.delete(':')
		obj_locator = $cif_ifm_related_list.sub($sf_param_substitute, _trimmed_name_final)
		related_list_exist = page.has_css?(obj_locator)
		if (is_present && !related_list_exist)
			result_list.push(related_list_name + ' should exist')
		elsif (!is_present && related_list_exist)
			result_list.push(related_list_name + ' should not exist')
		end
	end
	return result_list
  end
end # EOF


