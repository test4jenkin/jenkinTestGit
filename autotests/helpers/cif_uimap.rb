#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

###################################################
# Parameter Substitution Symbol
###################################################
$cif_param_substitute='?'
############################
#CIF Commons
############################
CIF_DEFAULT_TIME_FOR_LOADING_MASK = 60
$cif_open_record = "table.list tbody tr:nth-child(2) th a"
$cif_save_button = "a[data-ffid='Save']"
$cif_edit_record_button = "a[data-ffid*='Edit']"
$cif_save_post_button = "a[data-ffid='SaveAndPost']"
$cif_post_button = "a[data-ffid='Post']"
$cif_continue_button = "a[data-ffid='ok']"
$cif_save_new_button = "a[data-ffid='SaveAndNew']"
$cif_save_post_new_button = "a[data-ffid='SavePostAndNew']"
$cif_discard_button  = "a[data-ffid='Discard']"
$cif_amend_button  = "//span[text()='Amend Document']/ancestor::a"
$cif_sharing_button = "a[data-ffid='Share']"
$cif_submit_for_approval_button = "a[data-ffid='Submit']"
$cif_clone_button = "a[data-ffid='Clone']"
$cif_discard_popup_discard_button = "a[data-ffid='DiscardBtn'] span:nth-of-type(2)"
$cif_convert_to_credit_note = "a[data-ffid='ConvertToCreditNote']"
$cif_cancel_button = "div[data-ffxtype='app-head'] a[data-ffid='cfvGoBackButton'] span span:nth-child(2)"
$cif_click_new_line_row = ".cfv-grid-rowdeletecolumn-image.cfv-grid-rowdeletecolumn-value"
$cif_click_delete_line_row = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") img[class$='rowdeletecolumn-image']"
$cif_click_copy_line_row = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") td[data-qtip='Copy Line'] div"
$cif_load_mask = "div[data-ffxtype=loadmask]"
$cif_calculations_wait_message = "Totals are out of date"
$cif_buttons_loading_wait_message = "Loading actions"
$cif_line_items_no_data_message = "No Data"
$cif_transaction_number= "div[data-ffid$='Transaction__c'] div:nth-child(2) div"
$cif_transaction_number_link = "div[data-ffid$='Transaction__c'] div:nth-child(2) div a"
$cif_continue_button_on_info_message_popup = "//span[text()='Continue']/ancestor::a"
$cif_header_document_number = "div[data-ffxtype='appnamelabel']"
$cif_toggle_button = "a[data-ffxtype='fillbutton']"
$cif_picklist_value_pattern = "//ul[@class='f-list-plain']//li[text()='#{$cif_param_substitute}']"
$tab_input_form_manager = "Input Form Manager"
$cif_related_list_toolbar_item_pattern = "//span[contains(text(),'"+$sf_param_substitute+"')]/ancestor::a"
$cif_related_list_collapse_icon = "img[class*='collapse']"
$cif_related_list_lines = "div[data-ffxtype='tableview'] table tr"
$cif_related_list_header_fields = "//div[@data-ffxtype='headercontainer']//div["+$sf_param_substitute+"]//span[text()='"+$sf_param_substitute+"']"
$cif_back_to_list_link = "a[data-ffid='cfvGoBackButton']"
$cif_related_list_new_event = "a[data-ffid='NewEvent']"
$cif_related_list_new_task = "a[data-ffid='NewTask']"
$cif_related_list_new_note = "a[data-ffid='NewNote']"
$cif_related_list_new_attachment = "a[data-ffid='NewAttachment']"
$cif_related_list_new_sales_order_custom_object = "a[data-ffid='NewcodaSalesOrderCustomObject__c']"
$cif_related_list_note_title = "input[id='Title']"
$cif_related_list_note_body = "textarea[id='Body']"
$cif_related_list_chatter_frame = "//iframe[contains(@src,'cfchatter')]"
$cif_related_list_chatter_box = "textarea[id='publishereditablearea']"
$cif_related_list_chatter_editor_frame = "//iframe[contains(@title, 'publisherRichTextEditor')]"
$cif_related_list_chatter_share_button = "input[id='publishersharebutton']"
$cif_related_list_chatter_editor_area = "body[class*='chatterPublisherRTE']"  
$cif_related_list_task_item_subject = "Subject"
$cif_related_list_custom_object_input = "//span[@class='lookupInput']/input"
$cif_related_list_toolbar = "div[data-ffxtype=cfv-related-toolbar]"
$cif_grid_row_value_on_input_page = "div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div"
$cif_grid_row_value_on_view_page = "div[data-ffxtype='grid-area'] div[class$='f-grid'] div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div"
$cif_discard_reason_textbox = "textarea[name='reason']"
$cif_pricebook_grid_row_value = "div[data-ffid = 'searchProductGrid'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div"
$cif_pricebook_grid_row_checkbox = "div[data-ffid = 'searchProductGrid'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div div"
$cif_pricebook_recently_added_items_grid_row_value = "div[data-ffid = 'recentProductsGrid'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div"
$cif_pricebook_recently_added_items_grid_row_checkbox = "div[data-ffid = 'recentProductsGrid'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div div"
$cif_clone_button_label = "Clone"
$cif_header_toast_message_box = "div[data-ffxtype='toast'] div[data-ref='body'] div div"
$cif_line_num_of_columns = "//div[@data-ffid='LineNumber__c']/ancestor::div[2]/div/div"
$cif_line_column_number_pattern = "//div[@data-ffid='LineNumber__c']/ancestor::div[2]/div/div["+$sf_param_substitute+"]//span"
# Changing default Sale Invoice visualforce page to CIF sencha pages  
$cif_page_sinv_new_edit = 'Custom Form - Sales Invoice - New/Edit [cfsalesinvoiceedit]'
$cif_page_sinv_view = 'Custom Form - Sales Invoice - View [cfsalesinvoiceview]'

# Changing default Sales Credit Note visualforce page to CIF sencha pages  
$cif_page_scrn_new_edit = 'Custom Form - Sales Credit Note - New/Edit [cfsalescreditnoteedit]'
$cif_page_scrn_view = 'Custom Form - Sales Credit Note - View [cfsalescreditnoteview]'

# Changing default Cash Entry visualforce page to CIF sencha pages  
$cif_page_ce_new_edit = 'Custom Form - Cash Entry - New/Edit [cfcashentryedit]'
$cif_page_ce_view = 'Custom Form - Cash Entry - View [cfcashentryview]'

# matched payments grid
$cif_grid_rows = "div[data-ffxtype=matchedpaymentsgrid] div[data-ffxtype=tableview] table"

# cif messages alias
$cif_msg_cannot_delete_related_list = "You cannot delete this related list."
$cif_msg_permanently_delete_related_list = "Permanently delete this related list for all users?"
$cif_msg_clone_document = FFA.fetch_label 'cf_CloneDocumentMsg'

#Labels
$cif_net_value_label = "Net Value"
# Value to store that local GLA feature is enabled on CIF UI or not
# Update the value of this to true if script is working on Local GLA feature or if local gla feature is enabled on org.
$cif_line_local_gla_enabled = false