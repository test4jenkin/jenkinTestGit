#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

module NEWPAY
extend Capybara::DSL
###################################################
# Parameter Substitution Symbol
###################################################
$sf_param_substitute='?'
##################################################
# New Payments Status  #
##################################################
$newpay_status_new = 'NEW'
$newpay_status_proposed = 'PROPOSED'
$newpay_status_media_prepared = 'MEDIA PREPARED'
$newpay_status_preparing_media_error = 'PREPARING MEDIA ERROR'
$newpay_status_preparing_for_media = 'PREPARING FOR MEDIA'
$newpay_status_ready_to_post = 'READY TO POST'
$newpay_status_matched = 'MATCHED'
$newpay_status_error = 'ERROR'
$newpay_status_discarded = 'DISCARDED'
$newpay_status_part_canceled = 'PART CANCELED'
$newpay_status_canceled = 'CANCELED'
##################################################
# New Payments Check Number Status  #
##################################################
$newpay_check_status_valid = 'Valid'
$newpay_check_status_void = 'Void'
$newpay_check_status_cash_entry = 'Cash Entry'
##################################################
# New Payments Selectors  #
##################################################
$newpay_main= "[data-ffxtype='app-main']"
$newpay_tab_navigation= "div[data-ffid='tabNavigation']"
$newpay_assert_output_text = "matching values"
$newpay_detail_panel= "div[data-ffid='detailsPanel']"
$newpay_proposal_panel= " div[data-ffid='proposalPanel']"
$newpay_selecttransactions_panel= "div[data-ffid='transselPanel']"
$newpay_review_panel= "div[data-ffid='reviewPanel']"
$newpay_summary_panel_dataffid_access = "div[data-ffid='summaryPanel']"

$newpay_label_access = " label span"
$newpay_f_form_display_field_class_access= " div.f-form-display-field"
$newpay_expand_picklist_class_access = " .f-form-trigger"
$newpay_input_access = " input"
$newpay_f_form_item_label_default_class_access= " .f-form-item-label-default"
$newpay_testTip_access= " .testTip"


$newpay_currency_prepare_data_panel_dataffid_access= " div[data-ffid='prepareDataPanel']"
$newpay_confirm_checks_panel_dataffid_access=  "div[data-ffid='confirmChecksPanel']"
$newpay_checknumber_panel_dataffid_access = "div[data-ffid='numberingChecksContainer']"

$data_qtip_access = 'data-qtip'
$data_li_access = ' li'
$data_dataffid_access = ' data-ffid'
$data_a_access = ' a'
$newpay_proposal_payment_name = "//div[contains(text(), 'Proposal')]"
$newpay_toast_message = "//div[data-ffxtype='toast']"
$newpay_payment_detail_template_dataffid_access = "div[data-ffid='payDetailTemplate']"
$newpay_payment_checkbox = '.f-grid-checkcolumn'
$newpay_dismiss_popup = "[data-ffid='dismissPopup']"
$newpay_dismiss_popup_checkbox = $newpay_dismiss_popup + " [data-ffxtype='checkboxfield'] .f-form-checkbox"
$newpay_grid_row_lock = ".ffdc-icon-lock"

##################################################
# New Payments Details  #
##################################################
$newpay_bank_account_dataffid_access= " div[data-ffid='BankAccount']"
$newpay_payment_date_dataffid_access= " div[data-ffid='PaymentDate']"
$newpay_period_dataffid_access= " div[data-ffid='Period']"
$newpay_discount_date_dataffid_access= " div[data-ffid='DiscountDate']"
$newpay_payment_currency_dataffid_access= " div[data-ffid='PaymentCurrency']"
$newpay_payment_media_dataffid_access= " div[data-ffid='PaymentMedia']"
$newpay_settlement_discount_dataffid_access= " div[data-ffid='SettlementDiscount']"
$newpay_currency_write_off_dataffid_access= " div[data-ffid='CurrencyWriteOff']"
$newpay_settlement_disc_dim1_access = " div[data-ffid='SettlementDiscountDim1']"
$newpay_settlement_disc_dim2_access = " div[data-ffid='SettlementDiscountDim2']"
$newpay_settlement_disc_dim3_access = " div[data-ffid='SettlementDiscountDim3']"
$newpay_settlement_disc_dim4_access = " div[data-ffid='SettlementDiscountDim4']"
$newpay_currency_write_off_dim1_access = " div[data-ffid='CurrencyWriteOffDim1']"
$newpay_currency_write_off_dim2_access = " div[data-ffid='CurrencyWriteOffDim2']"
$newpay_currency_write_off_dim3_access = " div[data-ffid='CurrencyWriteOffDim3']"
$newpay_currency_write_off_dim4_access = " div[data-ffid='CurrencyWriteOffDim4']"
$newpay_settlement_disc_button_dataffid_access= " div[data-ffid='buttonSettlDiscDimensions'] a"
$newpay_currency_write_off_button_dataffid_access= " div[data-ffid='buttonCurrWriteDimensions'] a"
$newpay_detail_sett_disc_dim_button = $newpay_detail_panel + $newpay_settlement_disc_button_dataffid_access
$newpay_detail_writeoff_dim_button = $newpay_detail_panel + $newpay_currency_write_off_button_dataffid_access

##################################################
# Select transactions. Access to classes #
##################################################
$newpay_due_date_options_class_access= " .test-dueDate"
$newpay_ac_pay_cont_GLAs_options_class_access= " .test-accountPayableControlGLA"
$newpay_vendor_invoice_number_options_class_access= " .test-vendorInvoiceNumber"
$newpay_vendor_name_options_class_access= " .test-vendorName"
$newpay_payable_invoice_number_options_class_access= " .test-payableInvoiceNumber"

$newpay_detail_button_next = "a[data-ffid='navigationNext']";
$newpay_detail_button_back = "a[data-ffid='navigationBack']";
$newpay_detail_button_prepareData = $newpay_currency_prepare_data_panel_dataffid_access + " a[data-ffid='prepareDataButton']";
$newpay_checks_confirm_button_dataffid_access= $newpay_confirm_checks_panel_dataffid_access + " a[data-ffid='confirmChecksButton']";

$newpay_selecttrans_filter_form = $newpay_selecttransactions_panel + " [data-ffxtype='filter-form']"
$newpay_selecttrans_selection_grid = $newpay_selecttransactions_panel + " [data-ffxtype='selection-grid']"
$newpay_selecttrans_tag_field_items_class_access = ' .f-tagfield-item-text'
$newpay_selecttrans_Toduedate_dataffid_access = " div[data-ffid='dueDate']";
$newpay_selecttrans_payment_method_dataffid_access = " div[data-ffid='paymentMethod']";
$newpay_selecttrans_payment_methodlist_dataffid_access = " div[data-ffid='paymentMethodList']";
$newpay_selecttrans_APC_GLA_dataffid_access = " div[data-ffid='accountPayableControlGLA']";
$newpay_selecttrans_APC_GLA_close_icon = "//div[text()='"+$sf_param_substitute+"']/../div[@class='f-tagfield-item-close']"
$newpay_selecttrans_vendor_name_dataffid_access = " div[data-ffid='vendorName']";
$newpay_selecttrans_vendor_invoice_number_dataffid_access = " div[data-ffid='vendorInvoiceNumber']"
$newpay_selecttrans_payable_invoice_number_dataffid_access = " div[data-ffid='payableInvoiceNumber']"
$newpay_selecttrans_document_currency_dataffid_access = " div[data-ffid='DOCUMENT_CURRENCY']"
$newpay_selecttrans_due_date_fromto_option_dataffid_access = " div[data-ffid='FromTo']"
$newpay_selecttrans_due_date_to_option_dataffid_access = " div[data-ffid='To']"
$newpay_selecttrans_duedate_dataffid_access = " div[data-ffid='dueDate']"
$newpay_selecttrans_ac_pay_cont_GLAs_dataffid_access = " div[data-ffid='accountPayableControlGLA']"
$newpay_selecttrans_criteriaButton_dataffid_access = " a[data-ffid='criteriaButton']"
$newpay_selecttransactions_retrieveTransButton_dataffid_access = " a[data-ffid='retrieveTransButton']"
$newpay_selecttransactions_addtoproposal_dataffid_access = " a[data-ffid='actionBtn']"
$newpay_selecttransactions_show_hide_filters_button_dataffid_access = " a[data-ffid='toggleFiltersButton']"
$newpay_selecttransactions_criteria_menu = "[data-ffid='criteriaMenu']"
$newpay_selecttransactions_contains_dataffid_access = $newpay_selecttransactions_criteria_menu + " div[data-ffid='CONTAINS']"
$newpay_selecttransactions_equals_dataffid_access = $newpay_selecttransactions_criteria_menu + " div[data-ffid='EQUALS']"
$newpay_selecttransactions_fromto_dataffid_access = $newpay_selecttransactions_criteria_menu + " div[data-ffid='FROM_TO']"
$newpay_selecttransactions_multiselect_dataffid_access = $newpay_selecttransactions_criteria_menu + " div[data-ffid='MULTISELECT']"
$newpay_selecttransactions_to_dataffid_access = $newpay_selecttransactions_criteria_menu + " div[data-ffid='TO']"
$newpay_selecttransactions_summary_bar_dataffid_access = " div[data-ffid='summaryBar']"
$newpay_selecttransactions_summary_bar_discount_value = " span[data-column='Discount']"
$newpay_selecttransactions_summary_bar_outstanding_value = " span[data-column='OutstandingValue']"
$newpay_selecttransactions_summary_bar_payment_value = " span[data-column='PaymentValue']"
$newpay_selecttransactions_message_box = "//div[@data-ffxtype ='messagebox']"
$newpay_selecttransactions_on_hold_transactions = "//*[@class='ffdc-icon-lock']/../../.."
$newpay_back_to_payments_home_Button_dataffid_access = "//a[@data-ffid='goToPaymentHomeBtn']"
$newpay_selecttransactions_on_hold_document_pattern= "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td[1]//div[@data-qtip='On Hold']"
$newpay_selecttransactions_header_checkbox = "div[data-ffxtype='headercontainer'] div[data-ffxtype='checkboxcolumn'] div div div div"
$newpay_selecttransactions_transaction_checkbox= "//div[contains(@class, 'ff-grid-row-checker')]"
##################################################
# Review page #
##################################################
$newpay_review_edit_proposal_slider_dataffid = "//label[text()='Edit Proposal']"
$newpay_review_edit_proposal_checked_on = "//div[@data-ffid='toggleEditButton' and contains(@class, 'f-form-cb-checked')]"
$newpay_review_bottom_panel_remove_from_proposal = "//div[@data-ffid='transactionGridBar']"
$newpay_review_grid_checkbox = "//div[@class='f-grid-row-checker']"
$newpay_review_remove_from_proposal_button = $newpay_review_panel + $newpay_selecttransactions_addtoproposal_dataffid_access;
$newpay_review_message_box_docs_selected_not_removed_back = "//div[@data-ffxtype='messagebox']//div[@data-ffxtype='toolbar']//a[@data-ffid='cancel']"
$newpay_review_message_box_docs_selected_not_removed_continue = "//div[@data-ffxtype='messagebox']//div[@data-ffxtype='toolbar']//a[@data-ffid='ok']"
$newpay_review_grid_empty = "//div[@class='f-grid-empty']"
$newpay_expand_account_docs = "//div[@data-ffxtype='tableview']//tr[contains(@class, 'f-grid-group-hd-collapsed')]//div[contains(@class,'f-grid-group-title')]"

$newpay_selecttrans_Toduedate = $newpay_selecttransactions_panel + $newpay_selecttrans_Toduedate_dataffid_access + $newpay_input_access;
$newpay_selecttrans_payment_method = $newpay_selecttransactions_panel + $newpay_selecttrans_payment_method_dataffid_access + $newpay_input_access;
$newpay_selecttrans_payment_method_expand = $newpay_selecttransactions_panel + $newpay_selecttrans_payment_method_dataffid_access + $newpay_expand_picklist_class_access;
$newpay_selecttrans_payment_methodList = $newpay_selecttransactions_panel + $newpay_selecttrans_payment_methodlist_dataffid_access + $data_li_access;
$newpay_selecttrans_APC_GLA = $newpay_selecttransactions_panel + $newpay_selecttrans_APC_GLA_dataffid_access + $newpay_input_access;
$newpay_selecttrans_APC_GLA_get_selected = $newpay_selecttransactions_panel + $newpay_selecttrans_APC_GLA_dataffid_access + $newpay_selecttrans_tag_field_items_class_access;
$newpay_selecttrans_vendor_name = $newpay_selecttransactions_panel + $newpay_selecttrans_vendor_name_dataffid_access + $newpay_input_access;
$newpay_selecttrans_vendor_name_get_selected = $newpay_selecttransactions_panel + $newpay_selecttrans_vendor_name_dataffid_access + $newpay_selecttrans_tag_field_items_class_access;
$newpay_selecttrans_vendor_invoice_number = $newpay_selecttransactions_panel + $newpay_selecttrans_vendor_invoice_number_dataffid_access + $newpay_input_access;
$newpay_selecttrans_payable_invoice_number =$newpay_selecttransactions_panel + $newpay_selecttrans_payable_invoice_number_dataffid_access + $newpay_input_access;
$newpay_selecttrans_document_currency = $newpay_selecttransactions_panel + $newpay_selecttrans_document_currency_dataffid_access + $newpay_f_form_display_field_class_access;
$newpay_selecttransactions_summary_bar_discount_total = $newpay_selecttransactions_panel + $newpay_selecttransactions_summary_bar_dataffid_access + $newpay_selecttransactions_summary_bar_discount_value
$newpay_selecttransactions_summary_bar_outstanding_total = $newpay_selecttransactions_panel + $newpay_selecttransactions_summary_bar_dataffid_access + $newpay_selecttransactions_summary_bar_outstanding_value
$newpay_selecttransactions_summary_bar_payment_total = $newpay_selecttransactions_panel + $newpay_selecttransactions_summary_bar_dataffid_access + $newpay_selecttransactions_summary_bar_payment_value


$newpay_detail_payment_date = $newpay_detail_panel + $newpay_payment_date_dataffid_access + $newpay_input_access
$newpay_detail_period = $newpay_detail_panel + $newpay_period_dataffid_access + $newpay_input_access
$newpay_detail_discount_date = $newpay_detail_panel + $newpay_discount_date_dataffid_access + $newpay_input_access
$newpay_detail_bank_account = $newpay_detail_panel + $newpay_bank_account_dataffid_access  + $newpay_input_access
$newpay_detail_payment_currency = $newpay_detail_panel + $newpay_payment_currency_dataffid_access + $newpay_input_access
$newpay_detail_payment_media = $newpay_detail_panel + $newpay_payment_media_dataffid_access + $newpay_input_access
$newpay_detail_settlement_discount = $newpay_detail_panel + $newpay_settlement_discount_dataffid_access + $newpay_input_access
$newpay_detail_currency_write_off = $newpay_detail_panel + $newpay_currency_write_off_dataffid_access + $newpay_input_access
$newpay_detail_settlement_discount_dim1 = $newpay_detail_panel + $newpay_settlement_disc_dim1_access + $newpay_input_access
$newpay_detail_settlement_discount_dim2 = $newpay_detail_panel + $newpay_settlement_disc_dim2_access + $newpay_input_access
$newpay_detail_settlement_discount_dim3 = $newpay_detail_panel + $newpay_settlement_disc_dim3_access + $newpay_input_access
$newpay_detail_settlement_discount_dim4 = $newpay_detail_panel + $newpay_settlement_disc_dim4_access + $newpay_input_access
$newpay_detail_currency_write_off_dim1 = $newpay_detail_panel + $newpay_currency_write_off_dim1_access + $newpay_input_access
$newpay_detail_currency_write_off_dim2 = $newpay_detail_panel + $newpay_currency_write_off_dim2_access + $newpay_input_access
$newpay_detail_currency_write_off_dim3 = $newpay_detail_panel + $newpay_currency_write_off_dim3_access + $newpay_input_access
$newpay_detail_currency_write_off_dim4 = $newpay_detail_panel + $newpay_currency_write_off_dim4_access + $newpay_input_access
$newpay_detail_payment_detail_template = $newpay_payment_detail_template_dataffid_access + $newpay_input_access

$newpay_selecttrans_due_date_filteroptions_dataffid_access = $newpay_due_date_options_class_access + $data_dataffid_access
$newpay_review_prepare_check_button="//span[text()='Prepare Checks']"
$newpay_review_prepare_confirm_check_button="//a[@data-ffid='detailsWarningNext']//span[text()='Prepare Checks']"
$newpay_post_and_match_button= "a[data-qtip*='Post and Match process']"
##################################################
# post and match popup  #
##################################################

$newpay_postandmatch_window = "div[data-ffxtype ='postandmatch-window'] "
$newpay_postandmatch_period_field_dataffid_access = "div[data-ffxtype ='periodField'] "
$newpay_postandmatch_save_button_dataffid_access= " a[data-ffid='saveButton']"
$newpay_postandmatch_back_button_dataffid_access= " a[data-ffid='backButton']"
$newpay_postandmatch_postandmatch_button_dataffid_access= " a[data-ffid='postAndMatchButton']"

$newpay_postandmatch_save_button = $newpay_postandmatch_window + $newpay_postandmatch_save_button_dataffid_access
$newpay_postandmatch_back_button = $newpay_postandmatch_window + $newpay_postandmatch_back_button_dataffid_access
$newpay_postandmatch_postandmatch_button = $newpay_postandmatch_window + $newpay_postandmatch_postandmatch_button_dataffid_access
$newpay_postandmatch_period_field = $newpay_postandmatch_window + $newpay_postandmatch_period_field_dataffid_access + $newpay_input_access


##################################################
# Summary page  #
##################################################
$newpay_inline_error_message_post_and_match = "div[data-ffxtype='inline-error'] .f-notify-text"
$newpay_error_Handling_Button = "a[data-ffid='errorHandlingButton']"
$newpay_inline_success_message_post_and_match = "div[data-ffxtype='inline-success'] .f-notify-text"
$newpay_progress_window = "div[data-ffxtype='progress-window']"


$newpay_summary_toolbar = "[data-ffid='summaryToolbar']"
$newpay_summary_toolbar_resubmit = "[data-ffid='errorHandlingMenu'] [data-ffid='resubmit'] a"
$newpay_summary_toolbar_discard = "[data-ffid='errorHandlingMenu'] [data-ffid='discard'] a"
$newpay_summary_toolbar_cancel = $newpay_summary_toolbar + " [data-ffid='cancelButton']"
$newpay_summary_toolbar_cancel_menu = "[data-ffid='cancelMenu']"
$newpay_summary_toolbar_cancel_all = $newpay_summary_toolbar_cancel_menu + " [data-ffid='cancelAll']"
$newpay_summary_toolbar_cancel_selected = $newpay_summary_toolbar_cancel_menu + " [data-ffid='cancelSelected']"

$newpay_summary_grid = $newpay_summary_panel_dataffid_access + " div[data-ffid='accountsGrid']"
$newpay_summary_grid_accounts = $newpay_summary_grid + " .f-grid-row"
$newpay_summary_grid_accounts_selected = $newpay_summary_grid + " .f-grid-item-selected"
$newpay_summary_grid_checkbox_column_header = $newpay_summary_grid + ' .f-column-header-checkbox'

$newpay_summary_postandmatch_success_msg = "div[data-ffxtype='inline-success']"
$newpay_summary_proposed_account_header_column= "div[data-ffxtype='headercontainer'] div[data-ffid='AccountName']"

$newpay_summary_cancel_popup = "[data-ffxtype='cancel-popup']"
$newpay_summary_cancel_popup_reason = $newpay_summary_cancel_popup + " [data-ffid='CancelReason'] textarea"
$newpay_summary_cancel_popup_confirm_button = $newpay_summary_cancel_popup + " [data-ffid='confirmPopup']"
$newpay_summary_cancel_popup_confirm_button_disabled = $newpay_summary_cancel_popup_confirm_button + ".f-btn-disabled"




##################################################
# New Payment Proposal  #
##################################################
$newpay_f_proposal_status_class_access= " span"
$newpay_f_proposal_number_class_access= " .f-proposal-number"
$newpay_f_proposal_total_class_access= " .f-proposal-total"
$newpay_proposal_status_dataffid_access= " span[data-ffid='proposalStatus']"
$newpay_proposal_status_dataffid_label_access= " div[data-ffid='proposalStatusLabel']"
$newpay_proposal_period_dataffid_access= " div[data-ffid='Period']"
$newpay_proposal_company_dataffid_access= " [data-ffid='CompanyName']"
$newpay_document_proposed_dataffid_access= " div[data-ffid='proposalDocumentProposed']"
$newpay_payment_total_dataffid_access= " div[data-ffid='proposalPaymentTotal']"
$newpay_discount_total_dataffid_access= " div[data-ffid='proposalDiscountPaymentTotal']"
$newpay_vendors_proposed_dataffid_access= " div[data-ffid='proposalVendorsProposed']"
$newpay_settlement_disc_dim_tooltip_dataffid_access= " span[id='settlementDiscountDimTooltip']"
$newpay_currency_write_off_dim_tooltip_dataffid_access= " span[id='currencyWriteOffDimTooltip']"


$newpay_proposal_payment_date = $newpay_proposal_panel + $newpay_payment_date_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_discount_date = $newpay_proposal_panel + $newpay_discount_date_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_bank_account = $newpay_proposal_panel + $newpay_bank_account_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_payment_currency = $newpay_proposal_panel + $newpay_payment_currency_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_payment_media = $newpay_proposal_panel + $newpay_payment_media_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_settlement_discount = $newpay_proposal_panel + $newpay_settlement_discount_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_currency_write_off = $newpay_proposal_panel + $newpay_currency_write_off_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_settlement_discount_dim1 = $newpay_proposal_panel + $newpay_settlement_disc_dim1_access + $newpay_f_form_display_field_class_access
$newpay_proposal_settlement_discount_dim2 = $newpay_proposal_panel + $newpay_settlement_disc_dim2_access + $newpay_f_form_display_field_class_access
$newpay_proposal_settlement_discount_dim3 = $newpay_proposal_panel + $newpay_settlement_disc_dim3_access + $newpay_f_form_display_field_class_access
$newpay_proposal_settlement_discount_dim4 = $newpay_proposal_panel + $newpay_settlement_disc_dim4_access + $newpay_f_form_display_field_class_access
$newpay_proposal_currency_write_off_dim1 = $newpay_proposal_panel + $newpay_currency_write_off_dim1_access + $newpay_f_form_display_field_class_access
$newpay_proposal_currency_write_off_dim2 = $newpay_proposal_panel + $newpay_currency_write_off_dim2_access + $newpay_f_form_display_field_class_access
$newpay_proposal_currency_write_off_dim3 = $newpay_proposal_panel + $newpay_currency_write_off_dim3_access + $newpay_f_form_display_field_class_access
$newpay_proposal_currency_write_off_dim4 = $newpay_proposal_panel + $newpay_currency_write_off_dim4_access + $newpay_f_form_display_field_class_access
$newpay_proposal_status = $newpay_proposal_panel + $newpay_proposal_status_dataffid_access
$newpay_proposal_number = $newpay_proposal_panel + $newpay_document_proposed_dataffid_access + $newpay_f_proposal_number_class_access
$newpay_proposal_total = $newpay_proposal_panel + $newpay_payment_total_dataffid_access + $newpay_f_proposal_total_class_access
$newpay_proposal_discount_total = $newpay_proposal_panel + $newpay_discount_total_dataffid_access + $newpay_f_form_item_label_default_class_access
$newpay_proposal_vendors_proposed = $newpay_proposal_panel + $newpay_vendors_proposed_dataffid_access + $newpay_f_proposal_number_class_access
$newpay_proposal_period = $newpay_proposal_panel + $newpay_proposal_period_dataffid_access + $newpay_f_form_display_field_class_access
$newpay_proposal_company = $newpay_proposal_panel + $newpay_proposal_company_dataffid_access + $newpay_f_form_display_field_class_access

##################################################
# Select transactions. Access to buttons #
##################################################
$newpay_selecttrans_due_date_options_button = $newpay_selecttransactions_panel + $newpay_selecttrans_duedate_dataffid_access + $newpay_selecttrans_criteriaButton_dataffid_access; 
$newpay_selecttrans_acc_pay_cont_GLAs_options_button = $newpay_selecttransactions_panel + $newpay_selecttrans_ac_pay_cont_GLAs_dataffid_access + $newpay_selecttrans_criteriaButton_dataffid_access; 
$newpay_selecttrans_vendor_name_options_button = $newpay_selecttransactions_panel + $newpay_selecttrans_vendor_name_dataffid_access + $newpay_selecttrans_criteriaButton_dataffid_access; 
$newpay_selecttrans_vendor_invoice_number_options_button = $newpay_selecttransactions_panel + $newpay_selecttrans_vendor_invoice_number_dataffid_access + $newpay_selecttrans_criteriaButton_dataffid_access; 
$newpay_selecttrans_payable_invoice_number_options_button = $newpay_selecttransactions_panel + $newpay_selecttrans_payable_invoice_number_dataffid_access + $newpay_selecttrans_criteriaButton_dataffid_access; 
$newpay_selecttrans_payment_method_options_button = $newpay_selecttransactions_panel + $newpay_selecttrans_payment_method_dataffid_access + $newpay_selecttrans_criteriaButton_dataffid_access; 
$newpay_selecttrans_retrieve_transactions_button = $newpay_selecttransactions_panel + $newpay_selecttransactions_retrieveTransButton_dataffid_access;
$newpay_selecttrans_show_hide_filters_button = $newpay_selecttransactions_panel + $newpay_selecttransactions_show_hide_filters_button_dataffid_access;
$newpay_selecttrans_add_to_proposal_button = $newpay_selecttransactions_panel + $newpay_selecttransactions_addtoproposal_dataffid_access;
##################################################
# Access to Payment Details Labels#
##################################################
 
$newpay_detail_payment_date_label = $newpay_detail_panel + $newpay_payment_date_dataffid_access + $newpay_label_access
$newpay_detail_bank_account_label = $newpay_detail_panel + $newpay_bank_account_dataffid_access + $newpay_label_access
$newpay_detail_payment_currency_label = $newpay_detail_panel + $newpay_payment_currency_dataffid_access + $newpay_label_access
$newpay_detail_payment_media_label = $newpay_detail_panel + $newpay_payment_media_dataffid_access + $newpay_label_access
$newpay_detail_settlement_discount_label = $newpay_detail_panel + $newpay_settlement_discount_dataffid_access + $newpay_label_access
$newpay_detail_currency_write_off_label = $newpay_detail_panel + $newpay_currency_write_off_dataffid_access + $newpay_label_access
$newpay_detail_settlement_discount_dim1_label = $newpay_detail_panel + $newpay_settlement_disc_dim1_access + $newpay_label_access
$newpay_detail_settlement_discount_dim2_label = $newpay_detail_panel + $newpay_settlement_disc_dim2_access + $newpay_label_access
$newpay_detail_settlement_discount_dim3_label = $newpay_detail_panel + $newpay_settlement_disc_dim3_access + $newpay_label_access
$newpay_detail_settlement_discount_dim4_label = $newpay_detail_panel + $newpay_settlement_disc_dim4_access + $newpay_label_access
$newpay_detail_currency_write_off_dim1_label = $newpay_detail_panel + $newpay_currency_write_off_dim1_access + $newpay_label_access
$newpay_detail_currency_write_off_dim2_label = $newpay_detail_panel + $newpay_currency_write_off_dim2_access + $newpay_label_access
$newpay_detail_currency_write_off_dim3_label = $newpay_detail_panel + $newpay_currency_write_off_dim3_access + $newpay_label_access
$newpay_detail_currency_write_off_dim4_label = $newpay_detail_panel + $newpay_currency_write_off_dim4_access + $newpay_label_access

##################################################
# Access to Payment Proposal Labels#
##################################################

$newpay_proposal_payment_total_label = $newpay_proposal_panel + $newpay_payment_total_dataffid_access + $newpay_f_form_item_label_default_class_access 
$newpay_proposal_payment_document_proposed_label = $newpay_proposal_panel + $newpay_document_proposed_dataffid_access + $newpay_f_form_item_label_default_class_access
$newpay_proposal_payment_vendors_proposed_label = $newpay_proposal_panel + $newpay_vendors_proposed_dataffid_access + $newpay_f_form_item_label_default_class_access
$newpay_proposal_payment_date_label = $newpay_proposal_panel + $newpay_payment_date_dataffid_access + $newpay_label_access
$newpay_proposal_bank_account_label = $newpay_proposal_panel + $newpay_bank_account_dataffid_access + $newpay_label_access
$newpay_proposal_payment_proposal_status_label = $newpay_proposal_panel + $newpay_proposal_status_dataffid_label_access
$newpay_proposal_payment_currency_label = $newpay_proposal_panel + $newpay_payment_currency_dataffid_access + $newpay_label_access
$newpay_proposal_payment_media_label = $newpay_proposal_panel + $newpay_payment_media_dataffid_access + $newpay_label_access
$newpay_proposal_settlement_discount_label = $newpay_proposal_panel + $newpay_settlement_discount_dataffid_access + $newpay_label_access
$newpay_proposal_currency_write_off_label = $newpay_proposal_panel + $newpay_currency_write_off_dataffid_access + $newpay_label_access


##################################################
# Access to Payment Proposal Dimensions Values#
##################################################
$newpay_proposal_settlement_discount_dimensions = $newpay_proposal_panel + $newpay_settlement_disc_dim_tooltip_dataffid_access
$newpay_proposal_currency_write_off_dimensions = $newpay_proposal_panel + $newpay_currency_write_off_dim_tooltip_dataffid_access

$newpay_proposal_settlement_discount_dimensions_value = "div[data-ffid='settlementDiscountDimTooltip'] div[class='f-text-nowrap']"
$newpay_proposal_currency_write_off_dimensions_value = "div[data-ffid='currencyWriteOffDimTooltip'] div[class='f-text-nowrap']"


$newpay_account_line_items_query = "Select #{ORG_PREFIX}Account__r.Name from #{ORG_PREFIX}codaPaymentAccountLineItem__c where #{ORG_PREFIX}Payment__r.Name = '" + $sf_param_substitute + "'"
$newpay_line_items_query = "Select #{ORG_PREFIX}Account__r.Name, #{ORG_PREFIX}TransactionValue__c from #{ORG_PREFIX}codaPaymentLineItem__c where #{ORG_PREFIX}Payment__r.Name = '" + $sf_param_substitute + "'"
$newpay_transaction_line_items_query = "Select #{ORG_PREFIX}MatchingStatus__c from #{ORG_PREFIX}codaTransactionLineItem__c where Id IN (select #{ORG_PREFIX}transactionlineitem__c from #{ORG_PREFIX}codaPaymentLineItem__c where #{ORG_PREFIX}payment__r.Name = '" + $sf_param_substitute + "')"
$newpay_transaction_line_items_by_trx_reference_query = "Select #{ORG_PREFIX}MatchingStatus__c from #{ORG_PREFIX}codaTransactionLineItem__c where #{ORG_PREFIX}LineType__c = 'Account' and #{ORG_PREFIX}transaction__r.DocumentReference__c = '" + $sf_param_substitute + "'"
$newpay_media_summary_items_query = "Select #{ORG_PREFIX}Account__r.Name, #{ORG_PREFIX}PaymentValue__c, #{ORG_PREFIX}PaymentReference__c from #{ORG_PREFIX}codaPaymentMediaSummary__c where #{ORG_PREFIX}PaymentMediaControl__r.Payment__r.Name = '" + $sf_param_substitute + "'"
$newpay_check_numbers_query = "Select #{ORG_PREFIX}CheckNumber__c, #{ORG_PREFIX}Account__r.Name, #{ORG_PREFIX}PaymentValue__c, #{ORG_PREFIX}Status__c from #{ORG_PREFIX}codaCheckNumber__c where #{ORG_PREFIX}CheckRange__r.CheckRangeName__c = '" + $sf_param_substitute + "'"
$newpay_check_range_query = "Select Name from #{ORG_PREFIX}codaCheckRange__c where #{ORG_PREFIX}CheckRangeName__c = '" + $sf_param_substitute + "'"
$newpay_payment_number_query = "Select #{ORG_PREFIX}Name, #{ORG_PREFIX}Description__c from #{ORG_PREFIX}codaPayment__c where #{ORG_PREFIX}Description__c = '" + $sf_param_substitute + "'"
##################################################
# Access to Payment Check Number#
##################################################
$newpay_numbering_checks_header_label = "div[data-ffid='numberingChecksHeader']"
$newpay_check_number_input =  "[data-ffid='CheckNumber'] input"
$newpay_print_checks_renumber_down_button = "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]//td[@data-columnid='renumberdowncolumn']/div"
$newpay_void_checks_grid = "div[data-ffid='voidChecksGrid']"
$newpay_void_checks_grid_header = "div[data-ffid='voidChecksGrid'] [data-ffxtype='header']"
$newpay_check_numbering_detail_text = "//*[text()='Check Numbering Detail']"
$newpay_checknumber_grid = "div[data-ffid='checkNumberingGrid']"
$newpay_access_to_check_number = $newpay_checknumber_grid + " table:nth-of-type(#{$sf_param_substitute}) tr td:nth-of-type(3)"
$newpay_access_to_check_number_icon = $newpay_checknumber_grid + " table:nth-of-type(#{$sf_param_substitute}) tr td:nth-of-type(4) div[class$= 'ffdc-icon-move-down']"

# load below locators also for lightning org, this contains extra locators  which are 
# specific to lightning org or override non lightning locators using same variable name.

###### REMOVE lightning
if (SF.org_is_lightning)
	$newpay_detail_payment_number_link = "//a[text()='"+$sf_param_substitute+"']"
	$newpay_detail_dialog_box_locator = "div[id='dialogBoxMiddle']"
end
###### REMOVE lightning

# Methods for entering data in the payment detail panel
	def NEWPAY.focus_out
		find("[data-ffxtype='app-main']").click
	end


# Set payment date
	def NEWPAY.set_payment_date payment_date
		find($newpay_detail_payment_date).set payment_date
		find($newpay_detail_payment_date).click
		NEWPAY.focus_out
		NEWPAY.wait_for_period
	end

	def NEWPAY.wait_for_period
		_period_input = find("[data-ffid='detailsPanel'] [data-ffid='Period'] input")
		gen_execute_script do
			counter = 0
			loop do
				period = _period_input.value
				is_not_empty = !period.to_s.empty?
				counter += 1
				sleep 1
				break if is_not_empty or (counter >= DEFAULT_TIME_OUT)
			end
		end
	end

# Set discount date
	def NEWPAY.set_discount_date date
		find($newpay_detail_discount_date).set ''
		find($newpay_detail_discount_date).set date
		gen_tab_out $newpay_detail_discount_date
	end

	def NEWPAY.set_combo_value combo_input, value
		_item_selector = "//*[@data-ffxtype='boundlist']//li[text()='#{value}']"
		_input = find(combo_input)

		_input.find(:xpath, "../..").find('.f-form-trigger').click
		_input.set ''
		_input.set value

		gen_wait_until_object _item_selector
		find(:xpath, _item_selector).click
		NEWPAY.focus_out
	end

	def NEWPAY.set_bank_account bank_account_name
		NEWPAY.set_combo_value($newpay_detail_bank_account, bank_account_name);
	end

	# select payment detail template
	def NEWPAY.set_payment_detail_template paymentDetailTemplate
		NEWPAY.set_combo_value($newpay_detail_payment_detail_template, paymentDetailTemplate);
	end

# set payment currency
	def NEWPAY.set_payment_currency payment_currency
		NEWPAY.set_combo_value($newpay_detail_payment_currency, payment_currency);
	end

# set payment method on the payment details page
	def NEWPAY.set_payment_media payment_media
		NEWPAY.set_combo_value($newpay_detail_payment_media, payment_media);
	end

#Setting data for defining when and how to pay.
	def NEWPAY.set_when_and_how_to_pay payment_date, bank_account_name, payment_media
		if payment_date != nil
			NEWPAY.set_payment_date payment_date
		end
		if bank_account_name != nil
			NEWPAY.set_bank_account bank_account_name
		end
		if payment_media != nil
			NEWPAY.set_payment_media payment_media
		end
	end

# Set settlement discount
	def NEWPAY.set_settlement_discount gla_name
		NEWPAY.set_combo_value($newpay_detail_settlement_discount, gla_name);
	end

# Set Currency Write-off
	def NEWPAY.set_currency_write_off gla_name
		NEWPAY.set_combo_value($newpay_detail_currency_write_off, gla_name);
	end

# set settlement discount Dimension 1
	def NEWPAY.set_settlement_discount_dim1 dimension_name
		NEWPAY.set_combo_value($newpay_detail_settlement_discount_dim1, dimension_name);
	end

# set settlement discount Dimension 2
	def NEWPAY.set_settlement_discount_dim2 dimension_name
		NEWPAY.set_combo_value($newpay_detail_settlement_discount_dim2, dimension_name);
	end

# Set settlement discount Dimension 3
	def NEWPAY.set_settlement_discount_dim3 dimension_name
		NEWPAY.set_combo_value($newpay_detail_settlement_discount_dim3, dimension_name);
	end

# Set settlement discount Dimension 4
	def NEWPAY.set_settlement_discount_dim4 dimension_name
		NEWPAY.set_combo_value($newpay_detail_settlement_discount_dim4, dimension_name);
	end

#Setting general ledgers accounts (GLAs) for settlement discounts.
	def NEWPAY.set_glas_for_settlement_discounts_and_write_offs set_disc_gla_name, set_disc_dim1, set_disc_dim2, set_disc_dim3, set_disc_dim4
		if set_disc_gla_name != nil
			NEWPAY.set_settlement_discount set_disc_gla_name
		end
		if curr_wrt_off_gla_name != nil
			NEWPAY.set_currency_write_off curr_wrt_off_gla_name
		end
		if set_disc_dim1 != nil
			NEWPAY.set_settlement_discount_dim1 set_disc_dim1
		end
		if set_disc_dim2 != nil
			NEWPAY.set_settlement_discount_dim2 set_disc_dim2
		end
		if set_disc_dim3 != nil
			NEWPAY.set_settlement_discount_dim3 set_disc_dim3
		end
		if set_disc_dim4 != nil
			NEWPAY.set_settlement_discount_dim4 set_disc_dim4
		end
	end
# set Dimension 1
	def NEWPAY.set_currency_write_off_dim1 dimension_name
		NEWPAY.set_combo_value($newpay_detail_currency_write_off_dim1, dimension_name);
	end
# set Dimension 2
	def NEWPAY.set_currency_write_off_dim2 dimension_name
		NEWPAY.set_combo_value($newpay_detail_currency_write_off_dim2, dimension_name);
	end
# Set Dimension 3
	def NEWPAY.set_currency_write_off_dim3 dimension_name
		NEWPAY.set_combo_value($newpay_detail_currency_write_off_dim3, dimension_name);
	end
# Set Dimension 4
	def NEWPAY.set_currency_write_off_dim4 dimension_name
		NEWPAY.set_combo_value($newpay_detail_currency_write_off_dim4, dimension_name);
	end
#Setting general ledgers accounts (GLAs) for currency write-offs.
	def NEWPAY.set_glas_for_write_offs curr_wrt_off_gla_name, cur_wrt_off_dim1, cur_wrt_off_dim2, cur_wrt_off_dim3, cur_wrt_off_dim4
		if curr_wrt_off_gla_name != nil
			NEWPAY.set_currency_write_off curr_wrt_off_gla_name
		end
		if cur_wrt_off_dim1 != nil
			NEWPAY.set_currency_write_off_dim1 cur_wrt_off_dim1
		end
		if cur_wrt_off_dim2 != nil
			NEWPAY.set_currency_write_off_dim2 cur_wrt_off_dim2
		end
		if cur_wrt_off_dim3 != nil
			NEWPAY.set_currency_write_off_dim3 cur_wrt_off_dim3
		end
		if cur_wrt_off_dim4 != nil
			NEWPAY.set_currency_write_off_dim4 cur_wrt_off_dim4
		end
	end

#buttons
# click on post and match button on Print checks
	def NEWPAY.click_post_match_button
		SF.retry_script_block do 
			find($newpay_post_and_match_button).click
		end
		gen_wait_until_object_disappear $page_loadmask_message
	end
# click on back button (post and match window)
	def NEWPAY.click_postandmatch_back_button
		SF.retry_script_block do
			SF.execute_script do
				find($newpay_postandmatch_back_button).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end

# click on save button (post and match window)
	def NEWPAY.click_postandmatch_save_button
		SF.retry_script_block do
			SF.execute_script do
				find($newpay_postandmatch_save_button).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end

# click on post and match button 
	def NEWPAY.click_postandmatch_button
		SF.retry_script_block do
			SF.execute_script do
				find($newpay_postandmatch_postandmatch_button).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end

# click on Show Dimensions button for showing Dimensions associated to Settlement Discount GLA
	def NEWPAY.click_sett_disc_dim_button
		find($newpay_detail_sett_disc_dim_button).click
	end

# click on Show Dimensions button for showing Dimensions associated to Write-Off GLA
	def NEWPAY.click_writeoff_dim_button
		find($newpay_detail_writeoff_dim_button).click
	end

# click on Next button 
	def NEWPAY.click_next_button
		SF.retry_script_block do
			SF.execute_script do
				find($newpay_detail_button_next).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object $newpay_proposal_payment_date
			SF.wait_for_search_button
		end
	end

# click on Back button 
	def NEWPAY.click_back_button
		SF.retry_script_block do
			SF.execute_script do
				find($newpay_detail_button_back).click
			end
			gen_wait_until_object $newpay_proposal_payment_date
		end
	end

# click on Prepare Media Tables button 
	def NEWPAY.click_prepareData_button
		SF.retry_script_block do
			SF.execute_script do
				find($newpay_detail_button_prepareData).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end

# click on Prepare check button
	def NEWPAY.click_prepare_check_button
		SF.retry_script_block do
			SF.execute_script do
				find(:xpath , $newpay_review_prepare_check_button).click
			end
			# wait for the loading to complete on review page
			gen_wait_until_object_disappear $page_loadmask_message	
		end
	end
# confirm prepare check button
	def NEWPAY.click_confirm_prepare_check_button
		SF.retry_script_block do
			SF.execute_script do
				find(:xpath , $newpay_review_prepare_confirm_check_button).click
			end
			# wait for the loading to complete on review page
			gen_wait_until_object_disappear $page_loadmask_message	
		end
	
	end
# click on Prepare Media Tables button 
	def NEWPAY.click_confirm_button
		SF.retry_script_block do
			SF.execute_script do
				find($newpay_checks_confirm_button_dataffid_access).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end

#Methods for verifying values in Payment panel.
# verify Payment Date value
	def NEWPAY.get_proposal_payment_date_value
		return find($newpay_proposal_payment_date).text
	end
# verify Payment Date value
	def NEWPAY.get_proposal_period_value
		return find($newpay_proposal_period).text
	end
# verify bank account value
	def NEWPAY.get_proposal_payment_bank_account_value
		return find($newpay_proposal_bank_account).text
	end
# verify Payment Currency value
	def NEWPAY.get_proposal_payment_currency_value
		return find($newpay_proposal_payment_currency).text
	end
# verify Payment Media value
	def NEWPAY.get_proposal_payment_media_value
		return find($newpay_proposal_payment_media).text
	end
# verify Settlement Discount value
	def NEWPAY.get_proposal_settlement_discount_value
		return find($newpay_proposal_settlement_discount).text
	end
# verify currency write off value
	def NEWPAY.get_proposal_currency_write_off_value
		return find($newpay_proposal_currency_write_off).text
	end
# verify Status value
	def NEWPAY.get_proposal_status_value
		return find($newpay_proposal_status).text
	end
# verify Transactions proposed value
	def NEWPAY.get_proposal_document_proposed_value
		return find($newpay_proposal_number).text
	end
# verify Payment Total
	def NEWPAY.get_proposal_total_value
		return find($newpay_proposal_total).text
	end
# verify Vendors Proposed value
	def NEWPAY.get_proposal_vendors_proposed_value
		return find($newpay_proposal_vendors_proposed).text
	end
#verify Discount Total
	def NEWPAY.get_proposal_discount_total_value
		return find($newpay_proposal_discount_total).text
	end
#verify Company Name
	def NEWPAY.get_proposal_company_value
		return find($newpay_proposal_company).text
	end
	

#Methods for verifying tooltips
# verify currency write off dimensions values in payment proposal panel
	def NEWPAY.get_proposal_settlement_discount_dimensions_value
		find($newpay_proposal_settlement_discount_dimensions).click
		sleep 3
		existingDimensions = all($newpay_proposal_settlement_discount_dimensions_value).to_a
		result = '';
		puts "Result: "
		existingDimensions.each do |value|
			puts "Line content: " + value.text
			result = result + value.text
		end
		return result
	end

# verify currency write off dimensions values in payment proposal panel
	def NEWPAY.get_proposal_currency_write_off_dimensions_value
		find($newpay_proposal_currency_write_off_dimensions).click
		sleep 3
		existingDimensions = all($newpay_proposal_currency_write_off_dimensions_value).to_a
		result = '';
		puts "Result: "
		existingDimensions.each do |value|
			puts "Line content: " + value.text
			result = result + value.text
		end
		return result
	end



#Methods for setting values in the Select transactions tab.
# Set Due Date
	def NEWPAY.set_due_date value
		find($newpay_selecttrans_Toduedate).set value
		gen_tab_out $newpay_selecttrans_Toduedate
	end
# Set Payment Method
	def NEWPAY.set_payment_method value
		find($newpay_selecttrans_payment_method).set value
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
		gen_tab_out $newpay_selecttrans_payment_method
	end
# Set Accounts Payable Control GLA
	def NEWPAY.set_APC_GLA value
		find($newpay_selecttrans_APC_GLA).set value
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
		gen_tab_out $newpay_selecttrans_APC_GLA
	end
# Set Vendor Name
	def NEWPAY.set_vendor_name value
		find($newpay_selecttrans_vendor_name).set value
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
		gen_tab_out $newpay_selecttrans_vendor_name
	end
# Set Vendor Invoice Number
	def NEWPAY.set_vendor_invoice_number value
		find($newpay_selecttrans_vendor_invoice_number).set value
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
		gen_tab_out $newpay_selecttrans_vendor_invoice_number
	end
# Set Payable Invoice Number
	def NEWPAY.set_payable_invoice_number value
		find($newpay_selecttrans_payable_invoice_number).set value
		FFA.wait_for_popup_msg_sync $ffa_msg_loading
		gen_tab_out $newpay_selecttrans_payable_invoice_number
	end

# Set filter options to Contains
	def NEWPAY.set_filter_options_to_contains filterOptionCss
		gen_scroll_to filterOptionCss
		find(filterOptionCss).click
		find($newpay_selecttransactions_contains_dataffid_access).click
	end

	def NEWPAY.set_filter_options_to_fromTo filterOptionCss 
		gen_scroll_to filterOptionCss
		find(filterOptionCss).click
		find($newpay_selecttransactions_fromto_dataffid_access).click
	end

	def NEWPAY.set_filter_options_to_equals filterOptionCss 
		gen_scroll_to filterOptionCss
		find(filterOptionCss).click
		find($newpay_selecttransactions_equals_dataffid_access).click
	end

	def NEWPAY.set_filter_options_to_multiselect filterOptionCss 
		gen_scroll_to filterOptionCss
		find(filterOptionCss).click
		find($newpay_selecttransactions_multiselect_dataffid_access).click
	end

#post and match

	# click on Confirm Period.
	def NEWPAY.postandmatch_confirm_period period
		SF.retry_script_block do
				cad = period[0,period.length-2]
				find($newpay_postandmatch_period_field).set cad
				FFA.wait_for_popup_msg_sync $ffa_msg_loading
				find(:xpath,"//li[text()='#{period}']").click
		end
	end

#Methods for getting values in the Select transactions tab.
# Get Payment Method
	def NEWPAY.get_selecttransactions_payment_method
		return find($newpay_selecttrans_payment_method).value
	end

# Get all the options of a picklist: it is needed the selector for clicking on the icon to expand the picklist, and the css for accessing to its values
	def NEWPAY.get_picklist_values expandPicklistCss, picklistValues
		find(expandPicklistCss).click
		all_picklists = page.all(picklistValues)
		list_elements = all_picklists.to_a
		list_values = []
		list_elements.each do |one_list_element|
			list_values.push(one_list_element.text)
		end
		return list_values
	end

# Given a css returns all the selected items.
	def NEWPAY.get_multi_selected_picklist_options picklistcss
		all_picklists = all(picklistcss)
		list_elements = all_picklists.to_a
		list_values = []
		list_elements.each do |one_list_element|
			list_values.push(one_list_element.text)
		end
		return list_values
	end
# Get all selected Account Payable control GLAs
	def NEWPAY.get_selecttransactions_APC_GLA_all_selected_options
		SF.retry_script_block do
			return NEWPAY.get_multi_selected_picklist_options $newpay_selecttrans_APC_GLA_get_selected
		end
	end

# Get all selected Vendor Names
	def NEWPAY.get_selecttransactions_vendor_name_all_selected_options
		return NEWPAY.get_multi_selected_picklist_options $newpay_selecttrans_vendor_name_get_selected
	end
# Get Vendor Invoice number
	def NEWPAY.get_selecttransactions_vendor_invoice_number
		return find($newpay_selecttrans_vendor_invoice_number).value
	end
# Get Payable Invoice number
	def NEWPAY.get_selecttransactions_payable_invoice_number
		return find($newpay_selecttrans_payable_invoice_number).value
	end
# Get Document Currency
	def NEWPAY.get_selecttransactions_document_currency
		return find($newpay_selecttrans_document_currency).text
	end
# Get Due date filter options
	def NEWPAY.get_selecttransactions_duedate_filter_options
		return NEWPAY.get_picklist_values $newpay_selecttrans_due_date_options_button, $newpay_selecttrans_due_date_filteroptions_dataffid_access
	end
# Get Payable account payable control GLA filter options
	def NEWPAY.get_selecttransactions_acc_pay_cont_GLAs_filter_options
		return NEWPAY.get_picklist_values $newpay_selecttrans_acc_pay_cont_GLAs_options_button, $newpay_selecttrans_ac_pay_cont_GLAs_dataffid_access
	end
# Get vendor name filter options
	def NEWPAY.get_selecttransactions_vendor_name_filter_options
		return NEWPAY.get_picklist_values $newpay_selecttrans_vendor_name_options_button, $newpay_selecttrans_vendor_name_dataffid_access
	end
# Get Payable vendor invoice filter options
	def NEWPAY.get_selecttransactions_vendor_invoice_number_filter_options
		return NEWPAY.get_picklist_values $newpay_selecttrans_vendor_invoice_number_options_button, $newpay_selecttrans_vendor_invoice_number_dataffid_access
	end
# Get Payable Invoice number filter options
	def NEWPAY.get_selecttransactions_payable_invoice_number_filter_options
		return NEWPAY.get_picklist_values $newpay_selecttrans_payable_invoice_number_options_button, $newpay_selecttrans_payable_invoice_number_dataffid_access
	end

#Methods for retrieving transactions:

# Click on retrieve transaction button
	def NEWPAY.click_retrieve_trans_button
		SF.retry_script_block do 
			find($newpay_selecttrans_retrieve_transactions_button).click
			gen_wait_until_object_disappear $page_loadmask_message
			gen_wait_until_object $newpay_retrieved_docs_table
		end
	end

# Click on hide filters or show filters button
	def NEWPAY.click_show_hide_filters_button
		find($newpay_selecttrans_show_hide_filters_button).click
	end

	def NEWPAY.assert_filters_visibility shouldFilterBeVisible
		page.assert_selector($newpay_selecttrans_filter_form, :visible => shouldFilterBeVisible)
		page.assert_selector($newpay_selecttrans_selection_grid, :visible => !shouldFilterBeVisible)
	end

# select all line from ransactions table using header checkboxcolumn
	def NEWPAY.select_header_checkbox
		SF.retry_script_block do 
			find($newpay_selecttransactions_header_checkbox).hover
			sleep 1
			find($newpay_selecttransactions_header_checkbox).click
		end
	end
$table_tr = "tr"
$newpay_retrieved_docs_table = $newpay_selecttransactions_panel + " div[data-ffxtype='tableview'] table"
$newpay_retrieved_docs_columnHeader = $newpay_selecttransactions_panel + " div[data-ffxtype='selection-grid'] .f-column-header"
$newpay_retrieved_docs_document_number_dataffid_access = " div[data-ffid='DocumentNumber']";
$newpay_selecttrans_document_number = $newpay_selecttransactions_panel + $newpay_retrieved_docs_document_number_dataffid_access;
$newpay_review_docs_table = $newpay_review_panel + " div[data-ffxtype='tableview'] table"

# click on Column Headers for sorting the retrieved documents
	def NEWPAY.click_document_column_header css_column
		SF.retry_script_block do
			SF.execute_script do
				find(css_column).click
			end
			gen_wait_until_object_disappear $page_loadmask_message
		end
	end

# Compare expected column names with the retrieved.
	def NEWPAY.assert_retrieved_table_header expected_rows
		gen_wait_until_object $newpay_retrieved_docs_table
		rows = all($newpay_retrieved_docs_columnHeader)
		if rows.to_a.count != expected_rows.count
			puts "Bad number of rows: " + rows.to_a.count.to_s + " (expected " + expected_rows.count.to_s + ")"
			return false
		end
		list_values = []
		rows.each do |one_list_element|
			list_values.push(one_list_element.text)
			puts "received: " + one_list_element.text
		end

		expected_rows.each do |one_list_element|
			puts "expected: " + one_list_element
		end
		if !(list_values.eql? expected_rows)
			puts "Column header does not match with expected. "
			return false
		else
			puts "Column header matches with expected."
			return true
		end
	end

	def NEWPAY.assert_retrieved_rows? expected_lines
		gen_wait_until_object $newpay_retrieved_docs_table
		existent_lines = all($newpay_retrieved_docs_table + ' ' + $table_tr).to_a
		if existent_lines.length != expected_lines.length
			puts "Number of Lines Mismatch: Expected : #{expected_lines.length} Actual :#{existent_lines.length}"
			return false
		end
		existent_lines.each do |one_existent_line|
			puts "Line content: " + one_existent_line.text
		end
		expected_lines.each do |one_expected_line|
			
			following_line = existent_lines.shift
			following_line = following_line.text
			one_expected_line.each do |one_expected_value|
				if !((following_line).include?(one_expected_value))
					puts "Line Data Mismatch: Expected content: #{one_expected_value} in :#{following_line}"
					puts "expected: " + one_expected_value
					puts "received: " + following_line
					return false
				else
					puts "expected: " + one_expected_value
					puts "received: " + following_line
				end
			end
		end
		return true
	end

	def NEWPAY.assert_rows_review? expected_lines
		gen_wait_until_object $newpay_review_docs_table
		existent_lines = all($newpay_review_docs_table + ' ' + $table_tr).to_a
		if existent_lines.length != expected_lines.length
			puts "Number of Lines Mismatch: Expected : #{expected_lines.length} Actual :#{existent_lines.length}"
			return false
		end
		existent_lines.each do |one_existent_line|
			puts "Line content: " + one_existent_line.text
		end
		expected_lines.each do |one_expected_line|
			
			following_line = existent_lines.shift
			following_line = following_line.text
			one_expected_line.each do |one_expected_value|
				if !((following_line).include?(one_expected_value))
					puts "Line Data Mismatch: Expected content: #{one_expected_value} in :#{following_line}"
					puts "expected: " + one_expected_value
					puts "received: " + following_line
					return false
				else
					puts "expected: " + one_expected_value
					puts "received: " + following_line
				end
			end
		end
		return true
	end

	def NEWPAY.assert_retrieved_onhold_rows? value
		gen_wait_until_object $newpay_retrieved_docs_table
		element = find(:xpath, $newpay_selecttransactions_on_hold_transactions).text()
		return element.include? value
	end

	def NEWPAY.get_document_number_given_vendor_inv_number vendor_inv_number, payable_inv_number
		gen_wait_until_object $newpay_retrieved_docs_table
		existent_lines = all($newpay_retrieved_docs_table + ' ' + $table_tr).to_a

		list_values = []
		existent_lines.each do |one_existent_line|
			if (one_existent_line.has_content? vendor_inv_number)
				list_values.push(one_existent_line.text)
				row_list = all(one_existent_line.text).to_a
				row_list.each do |one_row_element|
					if (one_row_element.has_content? payable_inv_number)
							return one_row_element.text
					end
				end
			end
		end
		return 'not found'
	end

	# select those lines whose Vendor Document Number is in line_values array
	def NEWPAY.select_lines line_values
		gen_wait_until_object $newpay_retrieved_docs_table
		NEWPAY.expand_account_docs
		existent_lines = all($newpay_retrieved_docs_table + ' ' + $table_tr).to_a

		within ('tr') do
			line_values.each do |one_line|
				find(:xpath, "//*[text()='" + one_line + "']/../..//div[contains(@class,'ff-grid-row-checker')]").click
			end
		end
	end

	# select those lines whose Vendor Document Number is in line_values array
	def NEWPAY.select_lines_review_grid line_values
		gen_wait_until_object $newpay_review_docs_table
		NEWPAY.expand_account_docs
		existent_lines = all($newpay_review_docs_table + ' ' + $table_tr).to_a

		within ('tr') do
			line_values.each do |one_line|
				find(:xpath, "//*[text()='" + one_line + "']/../..//div[contains(@class, 'ff-grid-row-checker')]").click
			end
		end
	end

	# retrieve the line whose Vendor Document Number is document_number
	def NEWPAY.retrieve_line_values document_number
		gen_wait_until_object $newpay_retrieved_docs_table
		existent_lines = all($newpay_retrieved_docs_table + ' ' + $table_tr).to_a

		within ('tr') do
			line_values.each do |one_line|
				puts 'one_line= ' + one_line
				find(:xpath, "//*[text()='" + one_line + "']/../..")
			end
		end
	end

	# Click on add to proposal button
	def NEWPAY.click_add_to_proposal_button
		find($newpay_selecttrans_add_to_proposal_button).click
		gen_wait_until_object_disappear $page_loadmask_message
	end

	# returns text beside add to proposal button is there aren't lines selected
	def NEWPAY.assert_text_beside_addtoproposal_no_trans_selectd text
		selector = "//div[text()= '" + text + "']"
		return page.assert_selector(:xpath, selector)
	end

	# returns text beside add to proposal button is there are lines selected
	def NEWPAY.get_text_beside_addtoproposal_trans_selected text
		text_vendors = ' vendors'
		text_transactions = ' transactions selected, from '
		selector = "//div[contains(text(), '" + text_transactions + "') and contains(text(), '" + text_vendors + "')]//span"
		values = all(:xpath, selector).to_a
		if values.length != 3
			puts "Number of values for text beside AddToProposal button Mismatch: Expected : 2 Actual :#{values.length}"
			return false
		end
		text_result = values[0].text + text_transactions + values[1].text + text_vendors + ' ' + values[3].text
		return (text == text_result)
	end

	# returns an array with Discount Total, Outstanding Total, Payment Value Total
	def NEWPAY.summaryByAccount
		summaryValues = Array.new 
		summaryValues.insert(0, find($newpay_selecttransactions_summary_bar + "//" + newpay_selecttransactions_summary_bar_discount_dataffid_access + "//span"))
		summaryValues.insert(1, find($newpay_selecttransactions_summary_bar + "//" + newpay_selecttransactions_summary_bar_outstanding_dataffid_access + "//span"))
		summaryValues.insert(2, find($newpay_selecttransactions_summary_bar + "//" + newpay_selecttransactions_summary_bar_payment_value_dataffid_access + "//span"))
		newpay_selecttransactions_panel
	end

	# returns an array with Discount Total, Outstanding Total, Payment Value Total
	def NEWPAY.summaryTotals values
		summaryValues = Array.new 
		summaryValues.insert(0, find($newpay_selecttransactions_summary_bar_discount_total).text)
		summaryValues.insert(1, find($newpay_selecttransactions_summary_bar_outstanding_total).text)
		summaryValues.insert(2, find($newpay_selecttransactions_summary_bar_payment_total).text)
		puts "summaryValues = " + summaryValues.to_s
		puts "values = " + values.to_s
		return (values == summaryValues)
		
	end

	def NEWPAY.get_payment_name
		name = find(:xpath, $newpay_proposal_payment_name).text
		return (name.match(/PAY\d{6}/)).to_s
	end

	def NEWPAY.get_account_from_paymentaccountlineitem payment_name
		field_names = Array.new ['Name']
		APEX.execute_soql $newpay_account_line_items_query.gsub($sf_param_substitute, payment_name)
		return APEX.get_field_values_from_result field_names
	end

	def NEWPAY.get_line_from_paymentlineitem payment_name
		field_names = Array.new ['Name', 'TransactionValue__c']
		APEX.execute_soql $newpay_line_items_query.gsub($sf_param_substitute, payment_name)
		return APEX.get_field_values_from_result field_names
	end

	def NEWPAY.get_matchingStatus_from_transactionlineitem payment_name
		field_names = Array.new ['MatchingStatus__c']
		APEX.execute_soql $newpay_transaction_line_items_query.gsub($sf_param_substitute, payment_name)
		return APEX.get_field_values_from_result field_names
	end

	def NEWPAY.get_matchingStatus_from_transaction_reference value
		field_names = Array.new ['MatchingStatus__c']
		APEX.execute_soql $newpay_transaction_line_items_by_trx_reference_query.gsub($sf_param_substitute, value)
		return APEX.get_field_values_from_result field_names
	end

	def NEWPAY.get_toast_message
		gen_wait_until_object "//div[@data-ffxtype='toast']"
		return find(:xpath, "//div[@data-ffxtype='toast']").text
	end

	def NEWPAY.get_message_box_text
		return find(:xpath, $newpay_selecttransactions_message_box).text
	end

	def NEWPAY.click_message_box
		return find(:xpath, $newpay_selecttransactions_message_box + "//span[text()='Continue']").click
	end

	# Click on remove from proposal button
	def NEWPAY.click_remove_from_proposal_button
		find($newpay_review_remove_from_proposal_button).click
		gen_wait_until_object_disappear $page_loadmask_message
	end

	# Click on edit proposal slider
	def NEWPAY.click_edit_proposal
		SF.retry_script_block do 
			find(:xpath, $newpay_review_edit_proposal_slider_dataffid).hover
			find(:xpath, $newpay_review_edit_proposal_slider_dataffid).click
			NEWPAY.expand_account_docs
		end
	end

	def NEWPAY.get_message_grid_empty
		return find(:xpath, $newpay_review_grid_empty).text
	end

	def NEWPAY.click_message_box_go_back
		return find(:xpath, $newpay_review_message_box_docs_selected_not_removed_back).click
	end

	def NEWPAY.click_message_box_discard_continue
		return find(:xpath, $newpay_review_message_box_docs_selected_not_removed_continue).click
	end

	# returns if the line is selected or not
	def NEWPAY.is_checked_line line
		selector = "//tr[contains(@class,'ff-grid-item-selected')]//*[text()='" + line + "']"
		page.has_xpath?(selector)
	end

	# Click on back to payments home button
	def NEWPAY.click_back_to_payments_home
		return find(:xpath, $newpay_back_to_payments_home_Button_dataffid_access).click
	end

	def NEWPAY.expand_account_docs
		list_elements = all(:xpath, $newpay_expand_account_docs).to_a
		no_items = list_elements.length
		for i in 1..no_items do
			find(:xpath, $newpay_expand_account_docs).click
		end
	end

	def NEWPAY.get_check_number_header_label
		return find($newpay_numbering_checks_header_label).text
	end

	def NEWPAY.assert_retrieved_check_numbers? expected_lines
		gen_wait_until_object $newpay_checknumber_grid
		existent_lines = all($newpay_checknumber_grid + ' ' + $table_tr).to_a
		if existent_lines.length != expected_lines.length
			puts "Number of Lines Mismatch: Expected : #{expected_lines.length} Actual :#{existent_lines.length}"
			return false
		end
		existent_lines.each do |one_existent_line|
			puts "Line content: " + one_existent_line.text
		end
		expected_lines.each do |one_expected_line|
			following_line = existent_lines.shift
			following_line = following_line.text
			one_expected_line.each do |one_expected_value|
				if !((following_line).include?(one_expected_value))
					puts "Line Data Mismatch: Expected content: #{one_expected_value} in :#{following_line}"
					puts "expected: " + one_expected_value
					puts "received: " + following_line
					return false
				else
					puts "expected: " + one_expected_value
					puts "received: " + following_line
				end
			end
		end
		return true
	end

	def NEWPAY.get_line_from_paymentmediasummary payment_name
		field_names = Array.new ['Account__r.Name', 'PaymentValue__c', 'PaymentReference__c']
		APEX.execute_soql $newpay_media_summary_items_query.gsub($sf_param_substitute, payment_name)
		return APEX.get_field_values_from_result field_names
	end

	def NEWPAY.get_check_number_from_check_range check_range
		field_names = Array.new ['CheckNumber__c, Account__r.Name', 'PaymentValue__c', 'Status__c']
		APEX.execute_soql $newpay_check_numbers_query.gsub($sf_param_substitute, check_range)
		return APEX.get_field_values_from_result field_names
	end

	def NEWPAY.get_checkrange_name check_range
		field_names = Array.new ['Name']
		APEX.execute_soql $newpay_check_range_query.gsub($sf_param_substitute, check_range)
		return APEX.get_field_values_from_result field_names
	end

	# overwrite check number for an specific account
	def NEWPAY.overwrite_check_number account_name, value
		gen_wait_until_object $newpay_checknumber_grid
		row = gen_get_row_in_grid $newpay_checknumber_grid ,account_name, 1
		NEWPAY.overwrite_check_number_from_row_index row, value
	end

	# overwrite first check number from a given row index
	def NEWPAY.overwrite_check_number_from_row_index row, value
		gen_wait_until_object $newpay_checknumber_grid
		_check_number_grid = find($newpay_checknumber_grid)

		_check_number_grid.find("table:nth-of-type(#{row}) tr td:nth-of-type(3)").click 
		find($newpay_check_number_input).set value
		_check_number_grid.click #blur
	end

	def NEWPAY.expand_void_checks
		SF.retry_script_block do
			find($newpay_void_checks_grid_header).click
			gen_wait_until_object $newpay_void_checks_grid_header + ' [data-ffxtype="tool"] .f-tool-collapse-top'
		end
	end

	def NEWPAY.collapse_void_checks
		SF.retry_script_block do
			find($newpay_void_checks_grid_header).click
			gen_wait_until_object $newpay_void_checks_grid_header + ' [data-ffxtype="tool"] .f-tool-expand-bottom'
		end
	end

	def NEWPAY.assert_present_void_checks void_checks
		NEWPAY.expand_void_checks
		existent_lines = all($newpay_void_checks_grid + ' ' + $table_tr).to_a
		
		if existent_lines.length != void_checks.length
			puts "Number of Lines Mismatch: Expected : #{void_checks.length} Actual :#{existent_lines.length}"
			return false
		end

		void_checks_grid = find($newpay_void_checks_grid)
		for i  in 0..void_checks.length-1
			row = (i + 1).to_s
		     puts "Validate check number"
		     _check_number = void_checks_grid.find("table:nth-of-type(#{row}) td:nth-of-type(1) .f-grid-cell-inner").text
			if (_check_number != void_checks[i].to_s.rjust(6, '0'))
				return false
			end
			puts "Validate Void is checked"
			if (void_checks_grid.has_no_selector?("table:nth-of-type(#{row}) td:nth-of-type(2) .f-form-cb-checked[data-ffxtype='radio']"))
				return false
			end
			puts "Validate Manual check is unchecked"
			if (void_checks_grid.has_selector?("table:nth-of-type(#{row}) td:nth-of-type(3) .f-form-cb-checked[data-ffxtype='radio']"))
				return false
			end
		end

		NEWPAY.collapse_void_checks
		
		return true
	end

	# click on the renumber down (arrow) in a specific row
	def NEWPAY.click_renumber_down account_name
		gen_wait_until_object $newpay_checknumber_grid
		row = gen_get_row_in_grid $newpay_checknumber_grid ,account_name, 1
		puts "gen_get_row_in_grid= " + row.to_s
		find( $newpay_checknumber_grid + " table:nth-of-type(#{row}) td:nth-of-type(4) .ffdc-icon-move-down").click
	end

	def NEWPAY.click_renumber_down_from_row_index index
		gen_wait_until_object $newpay_checknumber_grid
		row = index
		$newpay_access_to_check_number_icon = $newpay_checknumber_grid + " table:nth-of-type(#{row}) tr td:nth-of-type(4) div[class$= 'ffdc-icon-move-down']"
		find($newpay_access_to_check_number_icon).click
	end

	def NEWPAY.click_manual_check check_number
		selector = "//*[text()='" + check_number.to_s.rjust(6, '0') + "']/../../td[3]//span[contains(@class,'f-form-radio')]"
		find(:xpath, selector).click
	end

	def NEWPAY.get_payment_name_from_paymentsTab description
		field_names = Array.new ['Name']
		APEX.execute_soql $newpay_payment_number_query.gsub($sf_param_substitute, description)
		return APEX.get_field_values_from_result field_names
	end

	def NEWPAY.assert_summary_lines expected_lines
		gen_wait_until_object $newpay_summary_grid_accounts
		existent_lines = all($newpay_summary_grid_accounts).to_a
		if existent_lines.length != expected_lines.length
			puts "Number of Lines Mismatch: Expected : #{expected_lines.length} Actual :#{existent_lines.length}"
			return false
		end

		existent_lines.each do |one_existent_line|
			puts "Line content: " + one_existent_line.text
		end
		expected_lines.each do |one_expected_line|
			following_line = existent_lines.shift
			following_line = following_line.text
			one_expected_line.each do |one_expected_value|
				if !((following_line).include?(one_expected_value))
					puts "Line Data Mismatch: Expected content: #{one_expected_value} in :#{following_line}"
					puts "expected: " + one_expected_value
					puts "received: " + following_line
					return false
				else
					puts "expected: " + one_expected_value
					puts "received: " + following_line
				end
			end
		end
		return true
	end


	def NEWPAY.assert_summary_lines_extended expected_lines
		_account_grid_selector = "div[data-ffid='accountsGrid']"
		_grid_collapsed_selector = '.f-grid-row-collapsed'

		gen_wait_until_object _account_grid_selector
		_account_grid = find(_account_grid_selector)
		_is_collapsed = _account_grid.has_css?(_grid_collapsed_selector)

		if _is_collapsed
			#Expand all accounts
			_newpay_summary_grid_accounts_contracted = _account_grid_selector + ' ' + _grid_collapsed_selector
			gen_wait_until_object _newpay_summary_grid_accounts_contracted
			existent_lines = all(_newpay_summary_grid_accounts_contracted).to_a

			existent_lines.each do |one_existent_line|
				one_existent_line.find('.f-grid-row-expander').click
				gen_wait_until_object_disappear $page_loadmask_message
			end
		end
		

		gen_wait_until_object $newpay_summary_grid_accounts
		existent_lines = all($newpay_summary_grid_accounts).to_a

		if existent_lines.length != expected_lines.length
			puts "Number of Lines Mismatch: Expected : #{expected_lines.length} Actual :#{existent_lines.length}"
			return false
		end

		expected_lines.each do |one_expected_line|
			following_line = existent_lines.shift
			following_line = following_line.text
			one_expected_line.each do |one_expected_value|
				if !((following_line).include?(one_expected_value))
					puts "Line Data Mismatch: Expected content: #{one_expected_value} in :#{following_line}"
					puts "expected: " + one_expected_value
					puts "received: " + following_line
					return false
				else
					puts "expected: " + one_expected_value
					puts "received: " + following_line
				end
			end
		end
		return true
	end

	def NEWPAY.get_newpay_summary_grid_row_index_by_account_name account_name
		_account_rows = find($newpay_summary_grid).all($newpay_summary_grid_accounts)
		_account_rows_array = _account_rows.to_a
		_index = -1

		for i in 0.._account_rows_array.length-1 do
			if _account_rows_array[i].has_css?('a', :text => "#{account_name}")
				return i
			end
		end
		return _index
	end

	def NEWPAY.get_newpay_summary_grid_account_by_account_name account_name
		_index = get_newpay_summary_grid_row_index_by_account_name account_name
		return all($newpay_summary_grid_accounts).to_a[_index]
	end

	def NEWPAY.select_newpay_summary_account account_name
		NEWPAY.get_newpay_summary_grid_account_by_account_name(account_name).find($newpay_payment_checkbox).click
	end

	# Get inline message error derived from post and match process
	def NEWPAY.get_inline_error_post_and_match
		message = find($newpay_inline_error_message_post_and_match).text
		return message
	end

	# Get inline success message derived from post and match process
	def NEWPAY.get_inline_success_post_and_match
		message = find($newpay_inline_success_message_post_and_match).text
		return message
	end

		# Click on error handling button
	def NEWPAY.click_error_handling_button
		find($newpay_error_Handling_Button).click
	end

	def NEWPAY.get_tooltip_text_in_account_grid (rowIndex, targetSelector)
		message = find("div[data-ffid='accountsGrid'] table:nth-of-type(#{rowIndex}) " + targetSelector)['data-qtip']
		return message
	end

	def NEWPAY.get_error_message_post_and_match rowIndex
		return NEWPAY.get_tooltip_text_in_account_grid(rowIndex, ".ffdc-icon-error")
	end

	def NEWPAY.get_discarded_tooltip rowIndex
		return NEWPAY.get_tooltip_text_in_account_grid(rowIndex, ".ffdc-icon-discard")
	end

	def NEWPAY.get_canceled_tooltip rowIndex
		return NEWPAY.get_tooltip_text_in_account_grid(rowIndex, ".ffdc-icon-discard")
	end

	def NEWPAY.assert_cancel_selected_text_button
		_selected_count = all($newpay_summary_grid_accounts_selected).to_a.length
		_expected_text = "Selected (#{_selected_count})"
		find($newpay_summary_toolbar_cancel).click
		gen_wait_until_object $newpay_summary_toolbar_cancel_selected
		_button_text = find($newpay_summary_toolbar_cancel_selected).text

		if _button_text != _expected_text
			puts "Cancel Button Text Mismatch: Expected : #{_expected_text} Actual :#{_button_text}"
			return false
		end

		return true;
	end

	def NEWPAY.include_account_cancel_reason (account_name, cancel_reason)
		_acc_index = NEWPAY.get_newpay_summary_grid_row_index_by_account_name account_name
		_cancel_tooltip = NEWPAY.get_canceled_tooltip _acc_index+1
		return _cancel_tooltip.include? cancel_reason
	end

	def NEWPAY.is_account_lock_selected account_name
		_account_row = NEWPAY.get_newpay_summary_grid_account_by_account_name(account_name)
		return _account_row.has_css?($newpay_grid_row_lock)
	end

	def NEWPAY.fill_cancel_popup reason_text
		gen_wait_until_object $newpay_summary_cancel_popup
		find($newpay_summary_cancel_popup_reason).set(reason_text)
		gen_wait_until_object_disappear $newpay_summary_cancel_popup_confirm_button_disabled
		find($newpay_summary_cancel_popup_confirm_button).click
	end
	

		# Relaunch post and Match
	def NEWPAY.relaunch_post_and_match
		find($newpay_error_Handling_Button).click
		find($newpay_summary_toolbar_resubmit).click
	end

		# Launch Cancel All
	def NEWPAY.launch_cancel_all
		if(page.has_no_css?($newpay_summary_toolbar_cancel_all))
			find($newpay_summary_toolbar_cancel).click
		end
		gen_wait_until_object $newpay_summary_toolbar_cancel_all
		find($newpay_summary_toolbar_cancel_all).click
	end

		# Launch Cancel Selected
	def NEWPAY.launch_cancel_selected
		if(page.has_no_css?($newpay_summary_toolbar_cancel_selected))
			find($newpay_summary_toolbar_cancel).click
		end
		gen_wait_until_object $newpay_summary_toolbar_cancel_selected
		find($newpay_summary_toolbar_cancel_selected).click
	end

		# Discard Errors
	def NEWPAY.discard_errors
		find($newpay_error_Handling_Button).click
		find($newpay_summary_toolbar_discard).click
		find("[data-ffxtype='messagebox'] [data-ffid='ok']").click
	end

		# Open a existing payment by description
	def NEWPAY.open_payment_by_description description
		_payment_name = ((NEWPAY.get_payment_name_from_paymentsTab description).to_s).match(/PAY\d{6}/).to_s
		NEWPAY.open_payment_by_payment_name _payment_name
		return _payment_name
	end

		# Open a existing payment by payment name
	def NEWPAY.open_payment_by_payment_name payment_name
		SF.tab $tab_payments
		puts "- Opening Payment: " + payment_name
		SF.select_view $bd_select_view_all
		SF.click_button_go
		SF.wait_for_search_button
		SF.click_link payment_name
		gen_wait_until_object_disappear $page_loadmask_message

	end

		# Execute commands
	def NEWPAY.execute_commands commands
		all_tabs = gen_open_link_in_new_tab "All Tabs"
		within_window all_tabs do
			APEX.execute_commands commands
		end
	end

		# No show again popup
	def NEWPAY.no_show_again_and_prepare_checks
		find($newpay_dismiss_popup_checkbox).click
		find($newpay_dismiss_popup).find(' [data-ffid="detailsWarningNext"]').click
	end

	def NEWPAY.wait_for_status status
		_status_selector = "//*[@data-ffid='proposalStatus'][text() = '" + status + "']"
		gen_wait_until_object _status_selector
	end
	
	#remove selected account Payable Control glas
	#gla_to_remove - remove gla from list
	def NEWPAY.remove_selected_APC_GLA gla_to_remove
		close_icon = $newpay_selecttrans_APC_GLA_close_icon.gsub($sf_param_substitute,gla_to_remove)
		find(:xpath,close_icon).click
	end
	
end