#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

CIF_IFM_COLUMN_FIELD_SELECTION = 1
CIF_IFM_COLUMN_FORM_NAME = 2
CIF_IFM_COLUMN_DESCRIPTION = 3
CIF_IFM_COLUMN_DOCUMENT_TYPE = 4
CIF_IFM_COLUMN_FORM_TYPE = 5
CIF_IFM_COLUMN_LAST_MODIFIED = 6
CIF_IFM_COLUMN_LAST_MODIFIED_BY = 7
CIF_IFM_COLUMN_STATUS = 8

module CIF_IFM
  extend Capybara::DSL
  

################################
#CIF Input Form Manager locators
################################
  #Button
  $cif_ifm_new_button = "a[data-ffid=newButton]"
  $cif_ifm_clone_button = "a[data-ffid=cloneButton]"
  $cif_ifm_edit_button = "a[data-ffid=editButton]"
  $cif_ifm_delete_button = "a[data-ffid=deleteButton]"
  $cif_ifm_save_button = "a[data-ffid=saveButton]"
  $cif_ifm_continue_button = "div[data-ffalias='widget.toolbar'] div div a:nth-of-type(2)"
  $cif_ifm_continue_form_exception_button = "a[data-ffid=ok]"
  $cif_ifm_form_activate_button = "a[data-ffxtype='button']"
  $cif_ifm_cancel_button = "div[data-ffalias='widget.toolbar'] div div a:nth-of-type(1)"
  $cif_ifm_delete_no_button = "a[data-ffid=no]"
  $cif_ifm_delete_yes_button = "a[data-ffid=yes]"
  $cif_ifm_activate_button = 'div[data-ffxtype="cfe-manager-assignment"] div[data-ffxtype="toolbar"] a[data-ffxtype="button"]'

  #Input Form Locators
  $cif_ifm_new_form_popup = ("[data-ffxtype=cfe-manager-new]")
  $cif_ifm_document_type =  '//div[@data-ffxtype="cfe-manager-new"]//span[text()="Document Type"]/ancestor::label/following-sibling::div/div/div/following-sibling::div[contains(@class,"f-form-arrow-trigger")]'
  $cif_ifm_form_type =  "//span[text()='Form Type']/ancestor::label/following-sibling::div//label[text()='"+$cif_ifm_param_substitute+"']/..//input"
  $cif_ifm_form_type_span =  "//span[text()='Form Type']/ancestor::label/following-sibling::div//label[text()='"+$cif_ifm_param_substitute+"']/../span"
  $cif_ifm_document_name_input = 'div[data-ffxtype=appheaderbar] div[data-ffxtype=textfield] input'
  $cif_ifm_selected_company_list = "[data-ffxtype='tagfield']"
  $cif_ifm_company_list = "div[data-ffxtype='tagfield'] li div"
  $cif_ifm_grid = "div[data-ffxtype='grid'] div[data-ref='body']"
  $cif_ifm_select_company = "div[data-ffxtype='tagfield'] div[data-ref='inputWrap'] div[data-ref='listWrapper']"
  $cif_ifm_boundary_list = "div[data-ffxtype=boundlist]"
  $cif_ifm_field_type_selector = 'div[data-ffxtype=config-container] div[data-ffxtype=combo]'
  $cif_ifm_field_type_selector_drop_down = "div[data-ffxtype=config-container] div[data-ffxtype=combo] div[class*='f-form-arrow-trigger']"
  $cif_ifm_field_type_selector_input = 'div[data-ffxtype=config-container] div[data-ffxtype=combo] input'
  $cif_ifm_param_substitute = 'Replace Me'
  $cif_ifm_select_form_checkbox = "//div[text()='"+$cif_ifm_param_substitute+"']/../preceding-sibling::td/div/span[@class='f-grid-checkcolumn']"
  $cif_ifm_checkbox_checked = "//table[contains(concat(' ', @class, ' '), 'f-grid-item-selected')]//tr/td/div[text()='"
  $cif_ifm_form_grid = 'div[data-ffxtype="grid"]'
  $cif_ifm_add_or_edit_related_list_button = "a[data-ffid=AddEditRelatedListBtn]"
  $cif_ifm_adv_options= "//div[text()='Advanced Options']"
  $cif_ifm_field_config_button = "div[id='"+$cif_ifm_param_substitute+"'] div[data-ffid='configButton']"

  # List of available fields - drag fields off the form to here - used for both header and line items
  $cif_ifm_drag_off = "div[data-ffxtype='config-container'] div[data-ffxtype='tableview']"

  # Related List items
  $cif_ifm_related_list_attachments = "label[data-ffid=Attachments]"
  $cif_ifm_related_list_events = "label[data-ffid=Events]"
  $cif_ifm_related_list_files = "label[data-ffid=Files]"
  $cif_ifm_related_list_groups = "label[data-ffid=Groups]"
  $cif_ifm_related_list_history_sinv = "label[data-ffid=HistorySalesInvoice]"
  $cif_ifm_related_list_history_scrn = "label[data-ffid=HistorySalesCreditNote]"
  $cif_ifm_related_list_history_pinv = "label[data-ffid=HistoryPayableInvoice]"
  $cif_ifm_related_list_history_pcrn = "label[data-ffid=HistoryPayableCreditNote]"
  $cif_ifm_related_list_history_ce = "label[data-ffid=HistoryCashEntry]"
  $cif_ifm_related_list_history_journal = "label[data-ffid=HistoryJournal]"
  $cif_ifm_related_list_notes = "label[data-ffid=Notes]"
  $cif_ifm_related_list_tasks = "label[data-ffid=Tasks]"
  $cif_ifm_related_list_intercompany_transfers = "label[data-ffid=IntercompanyTransfers]"
  $cif_ifm_related_list_sales_order_custom_object = "label[data-ffid=SalesOrderCustomObject]"
  $cif_ifm_related_list = "label[data-ffid='"+$sf_param_substitute+"']"
  $cif_ifm_related_list_matched_payments = "div[data-ffid=MatchedPayments] input"
  #Related List Labels
  $cif_related_list_toolbar_label_attachments = "Attachments"
  $cif_related_list_toolbar_label_events = "Events"
  $cif_related_list_toolbar_label_files = "Files"
  $cif_related_list_toolbar_label_groups = "Groups"
  $cif_related_list_toolbar_label_chatter = "Chatter"
  $cif_related_list_toolbar_label_history_sales_invoice = "History: Sales Invoice"
  $cif_related_list_toolbar_label_history_sales_credit_note = "History: Sales Credit Note"
  $cif_related_list_toolbar_label_history_payable_invoice = "History: Payable Invoice"
  $cif_related_list_toolbar_label_history_payable_credit_note = "History: Payable Credit Note"
  $cif_related_list_toolbar_label_history_cash_entry = "History: Cash Entry" 
  $cif_related_list_toolbar_label_history_journal = "History: Journal"
  $cif_related_list_toolbar_label_notes = "Notes"
  $cif_related_list_toolbar_label_tasks = "Tasks"
  $cif_related_list_toolbar_label_intercompany_transfers = "Intercompany Transfers"
  $cif_related_list_toolbar_label_sales_order_custom_object = "Sales Order Custom Object"
  $cif_related_list_toolbar_label_lookups = "Lookups"
  $cif_related_list_toolbar_label_approval_history = "Approval History"
  $cif_related_list_toolbar_label_matched_payments = "Matched Payments"

  #Related List Action on Add or Edit Related List Popup Window
  $cif_related_list_action_delete = "Delete"
  $cif_related_list_action_edit = "Edit"

  #Related List toolbar parameters 
  $cif_related_list_toolbar_attachments = "Attachments"
  $cif_related_list_toolbar_notes  = "Notes"
  $cif_related_list_toolbar_tasks = "Tasks"
  $cif_related_list_toolbar_groups = "Groups"
  $cif_related_list_toolbar_events = "Events"
  $cif_related_list_toolbar_files = "Files"
  $cif_related_list_toolbar_chatter = "Chatter"
  $cif_related_list_toolbar_history_sales_invoice = "HistorySalesInvoice"
  $cif_related_list_toolbar_history_sales_credit_note = "HistorySalesCreditNote"
  $cif_related_list_toolbar_history_payable_invoice = "HistoryPayableInvoice"
  $cif_related_list_toolbar_history_payable_credit_note = "HistoryPayableCreditNote"
  $cif_related_list_toolbar_history_cash_entry =  "HistoryCashEntry"
  $cif_related_list_toolbar_history_journal = "HistoryJournal"
  $cif_related_list_toolbar_intercompany_transfers = "IntercompanyTransfers"
  $cif_related_list_toolbar_sales_order_custom_object = "SalesOrderCustomObject"
  $cif_related_list_toolbar_approval_history = "ApprovalHistory"
  
  # Related list form types
  $cif_ifm_form_type_input = "Input"
  $cif_ifm_form_type_view = "View"
  $cif_ifm_document_type_sales_invoice = "Sales Invoice"
  $cif_ifm_document_type_sales_credit_note = "Sales Credit Note" 
  $cif_ifm_document_type_payable_invoice = "Payable Invoice"
  $cif_ifm_document_type_payable_credit_note = "Payable Credit Note"
  $cif_ifm_document_type_cash_entry = "Cash Entry"
  $cif_ifm_document_type_journal = "Journal"

  # Read and Write locations in Related lists section
  $cif_related_list_toolbar = "div[data-ffxtype=cfv-related-toolbar]"
  $cif_related_list_new_event = "a[data-ffid='NewEvent']"
  $cif_related_list_new_task = "a[data-ffid='NewTask']"
  $cif_related_list_new_note = "a[data-ffid='NewNote']"
  $cif_related_list_new_attachment = "a[data-ffid='NewAttachment']"
  $cif_related_list_note_title = "input[id='Title']"
  $cif_related_list_chatter_frame = "//iframe[contains(@src,'cfchatter')]"
  $cif_related_list_chatter_box = "textarea[id='publishereditablearea']"
  $cif_related_list_chatter_editor_frame = "//iframe[contains(@title, 'publisherRichTextEditor')]"
  $cif_related_list_chatter_share_button = "input[id='publishersharebutton']"
  $cif_related_list_chatter_editor_area = "body[class*='chatterPublisherRTE']"  
  $cif_related_list_task_item_subject = "Subject"
  $cif_related_list_approval_history_frame = "//iframe[contains(@src,'cfapprovalhistorylist')]"
  $cif_related_list_approval_history_grid = ".list"
  $cif_related_list_approval_history_submit_button = "//input[contains(@value,'Submit for Approval')]"
  $cif_related_list_approval_history_recall_button = "//input[contains(@value,'Recall Approval Request')]"
  $cif_related_list_approval_history_approve_reject_link = "//a[contains(text(), 'Approve / Reject')]"
  $cif_related_list_approval_history_reassign_link = "//a[contains(text(), 'Reassign')]"
  $cif_related_list_approval_history_comments_textarea = "#Comments"
  $cif_related_list_approval_history_button = "//input[@title = '"+$cif_ifm_param_substitute+"']"
  $cif_related_list_approval_history_record_status = "div[class='relatedProcessHistory'] table[class='list'] tr[class='tertiaryPalette extraRow dataRow even first'] td:nth-of-type(6) span"
  $cif_related_list_approval_history_reassign_status = "table[class='list'] tr[class*='dataRow odd'] td:nth-of-type(2)"
  $cif_related_list_approval_history_action_approve = "Approve"
  $cif_related_list_approval_history_action_reject = "Reject"
  $cif_related_list_approval_history_action_recall_request = "Recall Approval Request"
  $cif_related_list_approval_history_action_reassign_request = "Reassign Approval Request"
  $cif_related_list_approval_history_status_approved = "Approved"
  $cif_related_list_approval_history_status_rejected = "Rejected"
  $cif_related_list_approval_history_status_pending = "Pending"
  $cif_related_list_approval_history_status_recalled = "Recalled"
  $cif_related_list_approval_history_status_reassigned = "Reassigned"

  #Related Lists Popup Window
  $cif_ifm_select_related_list_checkbox = "//div[text()='"+$cif_ifm_param_substitute+"']/../preceding-sibling::td/div/span[@class='f-grid-checkcolumn']"
  $cif_ifm_select_related_list_checkbox_checked = "//div[text()='"+$cif_ifm_param_substitute+"']/../preceding-sibling::td/div/span[contains(@class,'checked')]"
  $cif_ifm_related_list_delete = "//div[text()='"+$cif_ifm_param_substitute+"']/../following-sibling::td/div/div[@data-qtip='Delete']"
  $cif_ifm_related_list_delete_button = "a[data-ffid='yes']"
  $cif_ifm_related_list_delete_popup = ".f-message-box--alert"
  $cif_ifm_related_list_delete_popup_close = "div[data-ffxtype='header'] div[data-ffxtype='tool'] div[class$='close ']"
  $cif_ifm_related_list_delete_popup_msg = "div[class*='f-window-text']"
  $cif_ifm_related_list_edit = "//div[text()='"+$cif_ifm_param_substitute+"']/../following-sibling::td/div/div[@data-qtip='Edit']"
  $cif_ifm_related_list_window_ok_button = "a[data-ffid='OkBtn']"
  $cif_ifm_related_list_window_cancel_button = "a[data-ffid='CancelBtn']"
  $cif_ifm_related_list_window_create_new_related_list_button = '//span[text()="Create New Related List"]'

  #Related List Configuration Popup Window
  $cif_ifm_related_list_configuration_label_textbox = "div[data-ffid='labelRelatedList'] input"
  $cif_ifm_related_list_configuration_related_list_dropdown_input = "div[data-ffid='relatedListSelectCombo'] input"
  $cif_ifm_related_list_configuration_sort_field_dropdown = "div[data-ffid='sortField'] input"
  $cif_ifm_related_list_configuration_sort_direction_dropdown = "div[data-ffid='sortDirection'] input"
  $cif_ifm_related_list_configuration_available_fields = "//div[@data-ffid='fromGrid']//table//div[text()='"+$cif_ifm_param_substitute+"']"
  $cif_ifm_related_list_configuration_displayed_fields = "//div[@data-ffid='toGrid']//table//div[text()='"+$cif_ifm_param_substitute+"']"
  $cif_ifm_related_list_configuration_ok_button = "a[data-ffid='okButton']"
  $cif_ifm_related_list_configuration_cancel_button = "a[data-ffid='cancelButton']"
  $cif_ifm_related_list_configuration_add_all_button = "a[data-ffid='addAllBtn']"
  $cif_ifm_related_list_configuration_add_button = "a[data-ffid='addBtn']"
  $cif_ifm_related_list_configuration_remove_all_button = "a[data-ffid='removeAllBtn']"
  $cif_ifm_related_list_configuration_remove_button = "a[data-ffid='removeBtn']"
  $cif_ifm_related_list_configuration_move_top_button = "a[data-ffid='topBtn']"
  $cif_ifm_related_list_configuration_move_up_button = "a[data-ffid='upBtn']"
  $cif_ifm_related_list_configuration_move_down_button = "a[data-ffid='downBtn']"
  $cif_ifm_related_list_configuration_move_bottom_button = "a[data-ffid='bottomBtn']"

  #Account settings filter options
  $cif_ifm_account_type_other = 'Other';
  $cif_ifm_account_type_technology_partner = 'Technology Partner';
  $cif_ifm_account_type_installation_partner = 'Installation Partner';
  $cif_ifm_account_type_channer_partner = 'Channel Partner / Reseller';
  $cif_ifm_account_type_customer_channel = 'Customer - Channel';
  $cif_ifm_account_type_customer_direct = 'Customer - Direct';
  $cif_ifm_account_type_prospect = 'Prospect';

  #Account settings filter window
  $cif_ifm_account_filter_checkbox = "//div//label[text()='"+$cif_ifm_param_substitute+"']/../span"
  $cif_ifm_account_filter_apply_button = "a[data-ffid='applyButton']"
  $cif_ifm_include_all_account_type_radio_button = "//label[text()='Include These Account Types:']/ancestor::div[1]/span"

#############################################
# Helper methods for Input form manager
############################################
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
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
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
    CIF_IFM.click_edit_button
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

#
# Method Summary: Select the given form and click the Activate button
# @param [String] form_name                   Form name to search for
# @return N/A
#
  def CIF_IFM.select_all_company_and_activate_form form_name
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
    CIF_IFM.click_clone_button
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
      find($cif_ifm_delete_button).click
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

##
# Method Summary: Search and select the form from the input form manager list view.
# This can be done by searching the text of the unique column i.e form name in a row.
#
# @param [String] form_name               Name of the form that needs to select from the list.
#
  def CIF_IFM.select_input_form_manager_from_list(form_name)
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    page.has_css?("div[data-ffxtype='grid']")
    rowNumber = CIF.get_row_in_grid $cif_ifm_grid ,form_name, CIF_IFM_COLUMN_FORM_NAME
    find("#{"div[data-ffxtype='grid']"} table:nth-child(#{rowNumber}) tr:nth-of-type(1) td:nth-of-type(1) div span").click
    gen_wait_less
  end

##
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

    if _is_company_selected == true and find($cif_ifm_company_list).text == company_name
      find($cif_ifm_selected_company_list).find("li",:text => company_name).find("div:nth-child(2)").click
    end
    gen_wait_less
    find($cif_ifm_select_company).click
    find($cif_ifm_select_company).click
    page.has_css?($cif_ifm_boundary_list)
    find($cif_ifm_boundary_list).find("li",:text => company_name).click
    puts("Selected the company: #{company_name}")
    find($cif_ifm_select_company).click
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
# Method Summary: Select the document type from the list.
#
# @param [String] document_type          Name od the document to select.
#
  def CIF_IFM.select_document_type document_type
    find(:xpath,$cif_ifm_document_type).click
    find($cif_ifm_boundary_list).find("li",:text => document_type).click
  end

##
# Method Summary: Select the form type.
#
# @param [String] form_type          Text of the form type to select.
#
  def CIF_IFM.select_form_type form_type
    _form_type = $cif_ifm_form_type.sub($cif_ifm_param_substitute, form_type)
  	# It sometime treat the form type radio button as Input or Span,
  	# Handling both scenarios using Begin-resuce block.
  	begin
  		find(:xpath,_form_type).click
  	rescue
  		find(:xpath,$cif_ifm_form_type_span.sub($cif_ifm_param_substitute,form_type)).click
  	end
  end

##
# Method Summary: Create a new form type.
#
# @param [String] document_type      Name od the document to select
# @param [String] form_type          Text of the form type to select.
#
  def CIF_IFM.create_new_form_type document_type, form_type
	SF.execute_script do
		CIF_IFM.click_new_button
		CIF_IFM.select_document_type document_type
		CIF_IFM.select_form_type form_type
		CIF_IFM.click_continue_button
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	end
  end

##
# Method Summary: Create a new form type.
#
# @param [String] document_type      Name od the document to select
# @param [String] form_type          Text of the form type to select.
#
  def CIF_IFM.select_and_activate_form form_name, company_name
    CIF_IFM.select_input_form_manager_from_list form_name
    CIF_IFM.select_company company_name
    CIF_IFM.click_activate_button
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
# Method Summary: Set the form name.
#
# @param [String] form_name          Text to set the name of the form.
#
  def CIF_IFM.set_form_name form_name
    find($cif_ifm_document_name_input).click
    find($cif_ifm_document_name_input).set(form_name)
    
  end

##
# Method Summary: Click Add or Edit Related List button
#
  def CIF_IFM.click_add_or_edit_related_list_button
      find($cif_ifm_add_or_edit_related_list_button).click
  end

#
# Method Summary: Check if a given related list is selected/checked, deselects it if so
# Note: Returns empty array if none found
# @param [String] related_list_name                   Related list name to deselect
# @return N/A
#
def CIF_IFM.deselect_related_list_if_selected related_list_name
  __relatedlistChecked = false
  related_list = $cif_ifm_select_related_list_checkbox_checked.sub($cif_ifm_param_substitute, related_list_name)
  begin
    __relatedlistChecked = find(:xpath, related_list,:wait => DEFAULT_LESS_WAIT).visible?
    if __relatedlistChecked == true
      find(:xpath, related_list).click
    end
  rescue
    puts "#{related_list_name} not checked"
  end
end

#
# Method Summary: Select the Related lists
# @param [String] related_list_names                   List containing related list names
# @return N/A
#
def CIF_IFM.select_related_list related_list_names
  within_window (windows.last) do
    # Create a new array, put the xpath version of relatedlist name(s) into it.
    ary = Array.new()
    names = Array.new()
    related_list_names.each do |related_list|
    CIF_IFM.deselect_related_list_if_selected(related_list)
      __sub = $cif_ifm_select_related_list_checkbox.sub($cif_ifm_param_substitute, related_list)
      ary.push(__sub)
      names.push(related_list)
    end
    ary.each_with_index do |relatedlisttoselect,index|
        # Select the Related List
        puts "Selecting existing Related list : (#{names[index]}"
        find(:xpath, relatedlisttoselect).click
    end
  end
end

##
# Method Summary: Select a related list option  check/uncheck attachment on Related List
# @param [String] action                   Action to perform. Accepts two values = 'edit' & 'delete'
# @param [String] related_list_name        Name of the related list
#
#
  def CIF_IFM.edit_or_delete_related_list action,related_list_name
    within_window (windows.last) do
        if(action == $cif_related_list_action_delete)
          __sub = $cif_ifm_related_list_delete.sub($cif_ifm_param_substitute, related_list_name)
          find(:xpath, __sub).click
        else
          __sub = $cif_ifm_related_list_edit.sub($cif_ifm_param_substitute, related_list_name)
          find(:xpath, __sub).click
        end
    end
  end

##
# Method Summary: Click Delete button on Delete Popup
#
  def CIF_IFM.click_delete_on_delete_related_list_popup
    within_window (windows.last) do
      find($cif_ifm_related_list_delete_button).click
    end
  end

##
# Method Summary: Close delete message popup
#
  def CIF_IFM.close_delete_popup
    within(find($cif_ifm_related_list_delete_popup)) do
      find($cif_ifm_related_list_delete_popup_close).click
    end
  end

##
# Method Summary : Get the text message on delete related list popup
#  
  def CIF_IFM.get_message_on_delete_related_list_popup
    within(find($cif_ifm_related_list_delete_popup)) do
      return find($cif_ifm_related_list_delete_popup_msg).text
    end
  end

##
# Method Summary: Method to click new related list button
#
  def CIF_IFM.click_new_related_list_button_on_related_list
    within_window (windows.last) do
      find(:xpath, $cif_ifm_related_list_window_create_new_related_list_button).click
      gen_wait_less
    end
  end

##
# Method Summary: Method to update the existing set of related list
#
  def CIF_IFM.click_ok_button_on_related_list 
    within_window (windows.last) do
      find($cif_ifm_related_list_window_ok_button).click
    end
  end

##
# Method Summary: Method to set label of related list
#
# @param [String] label_name                   Name of the label
#
  def CIF_IFM.set_label_on_related_list_configuration label_name
    within_window (windows.last) do
      find($cif_ifm_related_list_configuration_label_textbox).click
      find($cif_ifm_related_list_configuration_label_textbox).set(label_name)
    end
  end

##
# Method Summary: Method to select related list from the picklist
#
# @param [String] related_list_name                   Name of the available related lists
#
  def CIF_IFM.set_list_name_on_related_list_configuration related_list_name 
    within_window (windows.last) do
      CIF.set_value_tab_out $cif_ifm_related_list_configuration_related_list_dropdown_input, related_list_name
    end
  end

##
# Method Summary: Method to select sorting field from the picklist
#
# @param [String] sort_field_name                   Name of the field to set as sorted field
#
  def CIF_IFM.set_sort_field_on_related_list_configuration  sort_field_name
    within_window (windows.last) do
      CIF.set_value_tab_out $cif_ifm_related_list_configuration_sort_field_dropdown, sort_field_name
    end
  end

##
# Method Summary: Method to move fields from available section to displayed section of related list configuration window
#
# @param [Boolean] all_fields                  Move all fields or just one field
# @param [String] field_list                   List of the field to move from
#
  def CIF_IFM.move_fields_from_available_to_displayed  all_fields,field_list
    within_window (windows.last) do
      if (all_fields == false )
        # Create a new array, put the xpath version of field name(s) into it.
        ary = Array.new()
        names = Array.new()
        field_list.each do |field_name|
          __sub = $cif_ifm_related_list_configuration_available_fields.sub($cif_ifm_param_substitute, field_name)
          ary.push(__sub)
          names.push(field_name)
        end
        ary.each_with_index do |fieldtoselect,index|
            # Select the Field
            SF.log_info "Selecting Field : (#{names[index]}"
            find(:xpath, fieldtoselect).click
            find($cif_ifm_related_list_configuration_add_button).click
        end
      else
        find($cif_ifm_related_list_configuration_add_all_button).click
      end
    end
  end

# Method Summary: Method to move fields from displayed section to available section of related list configuration window
#
# @param [Boolean] all_fields                  Move all fields or just one field
# @param [String] field_list                   List of the field to move from
#
  def CIF_IFM.move_fields_from_displayed_to_available  all_fields,field_list
    within_window (windows.last) do
      if (all_fields == false )
        # Create a new array, put the xpath version of field name(s) into it.
        ary = Array.new()
        names = Array.new()
        field_list.each do |field_name|
          __sub = $cif_ifm_related_list_configuration_displayed_fields.sub($cif_ifm_param_substitute, field_name)
          ary.push(__sub)
          names.push(field_name)
        end
        ary.each_with_index do |fieldtoselect,index|
            # Select the Field
            SF.log_info "Selecting Field : (#{names[index]}"
            find(:xpath, fieldtoselect).click
            find($cif_ifm_related_list_configuration_remove_button).click
        end
      else
        find($cif_ifm_related_list_configuration_remove_all_button).click
      end
    end
  end

##
# Method Summary: Method to save the related list
#
  def CIF_IFM.click_ok_button_related_list_configuration_popup 
    within_window (windows.last) do
      find($cif_ifm_related_list_configuration_ok_button).click
    end
  end

##
# Method Summary: Select a related list Matched Payments option  check/uncheck tasks on Related List.
#
  def CIF_IFM.select_related_list_matched_payments 
      find($cif_ifm_related_list_matched_payments).click
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
      # Click the dropdown arrow 
      find($cif_ifm_field_type_selector_drop_down).click
      # make selection from the list
      find($gen_f_list_plain).find("li",:text => field_type).click
      gen_tab_out ($cif_ifm_field_type_selector_input)
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
	# Added wait as field sometime fails to settle and drag_to tries to drag another field in the list thus creating error 
	gen_wait_less
  end

#######################################
# Buttons
#######################################

##
# Method Summary: Click the new button to create a new form..
#
  def CIF_IFM.click_new_button
	SF.retry_script_block do 
		page.has_css?($cif_ifm_new_button)
		find($cif_ifm_new_button).click
	end
    gen_wait_less
  end

##
# Method Summary: Click the clone button to clone an existing form..
#
  def CIF_IFM.click_clone_button
    find($cif_ifm_clone_button).click
    gen_wait_less
  end

##
# Method Summary: Click the edit button to edit an existing form..
#
  def CIF_IFM.click_edit_button
    find($cif_ifm_edit_button).click
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
# Method Summary: Click the delete button to delete an existing form..
#
  def CIF_IFM.click_delete_button
    find($cif_ifm_delete_button).click
    gen_wait_less
  end

##
# Method Summary: Click the continue button to navigate to the next screen during the form creation process.
#
  def CIF_IFM.click_continue_button
    find($cif_ifm_continue_button).click
  end

##
# Method Summary: Click the save button to save the form.
#
  def CIF_IFM.click_save_button
    find($cif_ifm_save_button).click
  end

##
# Method Summary: Click the activate button to activate the form.
#
  def CIF_IFM.click_activate_button
    find($cif_ifm_form_activate_button, :text => 'Activate').click
  end

##
# Method Summary: Click the deactivate button to deactivate the form.
#
  def CIF_IFM.click_deactivate_button
    find($cif_ifm_form_activate_button, :text => 'Deactivate').click
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
	SF.execute_script do
		#use .set because gen_send_key doesn't overwrite existing text
		find($cif_ifm_document_name_input).set(form_name)
		click_save_button
		CIF.wait_for_loading_mask_to_complete 10
	end
  end

  #
  # Method Summary: Click the config button on a header field in the Input Form Manager
  # @param [String] header_element_id     Id of the element
  # @return N/A
  #
  def CIF_IFM.open_config_for_header_element header_element_id
    _element_path = $cif_ifm_field_config_button.sub($cif_ifm_param_substitute, header_element_id)
    find(_element_path).click
  end

  #
  # Method Summary: chose radio button to enable optins to select accounts
  # @return N/A
   def CIF_IFM.choose_include_all_account_button
    SF.retry_script_block do
		find(:xpath,$cif_ifm_include_all_account_type_radio_button).click
	end
  end
  
  #
  # Method Summary: Select an account filter option in the Input Form Manager
  # @param [String] account_type     The account type to select
  # @return N/A
  #
  def CIF_IFM.select_account_filter_option account_type
	SF.retry_script_block do 
		_element_path = $cif_ifm_account_filter_checkbox.sub($cif_ifm_param_substitute, account_type)
		find(:xpath, _element_path).click
	end
  end

  #
  # Method Summary: Apply account settings in the Input Form Manager
  # @return N/A
  #
  def CIF_IFM.apply_account_settings
    within_window (windows.last) do
      find($cif_ifm_account_filter_apply_button).click
    end
  end
end
