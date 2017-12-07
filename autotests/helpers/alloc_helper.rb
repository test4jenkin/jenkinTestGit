# FinancialForce.com, inc. claims copyright in this software, its screen display designs and
# supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
# Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
# result in criminal or other legal proceedings.
# Copyright FinancialForce.com, inc. All rights reserved.

ALLOC_COLUMN_DELETE = 1
ALLOC_COLUMN_GLA = 2 
ALLOC_COLUMN_DIMENSION_1 = 3 
ALLOC_COLUMN_DIMENSION_2 = 4
ALLOC_COLUMN_DIMENSION_3 = 5
ALLOC_COLUMN_DIMENSION_4 = 6
ALLOC_COLUMN_PERCENTAGE = 7
# ALLOCATIONS_COLUMN_AMOUNT = 8

module Allocations
extend Capybara::DSL

#############################
# Allocations               #
#############################
$alloc_no_dimesion = '-- No Dimension --'
$alloc_retrieve_column_transaction = 'Transaction'
$alloc_type_label = 'Transactions'
$alloc_label = 'Allocations'
$alloc_period_label = 'Period'
$alloc_date_label ='Date'
$alloc_soft_date_label ='Soft Date'
$alloc_soft_period_label ='Soft Period'
$alloc_last_month_label ='Last Month'
$alloc_last_n_month_label ='Last N Months'
$alloc_last_n_days_label='Last N Days'
$alloc_last_period_label ='Last Period'
$alloc_last_n_period_label ='Last N Periods'
##################################################
# Selectors
##################################################
## Allocation filters header selectors ##
$alloc_allocation_type = "div[data-ffid='allocationType'] input"
$alloc_only_ict_checkbox = "div[data-ffid='onlyICTFilter'] input"
$alloc_only_ict_checkbox_span = "div[data-ffid='onlyICTFilter'] span[class*='f-form-checkbox']"
$alloc_only_ict_checkbox_unmanage = "//label[text()='Only Retrieve Intercompany Transactions']//ancestor::div[1]/span"
$alloc_only_ict_checkbox_manage = "//label[text()='Only Retrieve Intercompany Transactions']//ancestor::div[1]/input"
$alloc_only_ict_checkbox_disabled = "div[class*='f-form-item-no-label'][data-ffid='onlyICTFilter']"
$alloc_only_ict_checkbox_enabled = "div[data-ffid='onlyICTFilter'][class*='f-form-dirty']"
$alloc_timeperiod_selection_field = "input[name ='DateRangeTypeString']"
$alloc_from_period_field = "input[name='FromPeriodId']"
$alloc_to_period_field = "input[name='ToPeriodId']"
$alloc_from_date_field = "input[name='FromDateString']"
$alloc_to_date_field = "input[name='ToDateString']"
$alloc_soft_date_field = "input[name = 'SoftDateRangeTypeString']"
$alloc_soft_period_field = "input[name = 'SoftPeriodRangeTypeString']"
$alloc_n_value_user_input_field = "input[name='NValue']"
$alloc_to_period_value= "input[name='ToPeriodId']"
$alloc_popup = "div[data-ffid='retrievedLinesPopup']"
$alloc_popup_close = $alloc_popup + " img"
$alloc_retrieved_summary_rows_grid = "div[data-ffid='retrievedLines']"
$alloc_toast_panel = "div[data-ffxtype='toast']"

##Retrieve Source UI label##
$alloc_only_ict_checkbox_label = "div[data-ffid='onlyICTFilter'] label"
$alloc_retrieve_source_page_label = "Retrieve Source"
$alloc_allocation_type_label = "What do you want to allocate?"
$alloc_retrieve_source_timeperiod_label = "Timeperiod"
$alloc_retieve_source_timeperiod_from_label ="From"
$alloc_retieve_source_timeperiod_to_label ="To"
$alloc_from_to_label = "//*[text()='From-To']"

##Preview Panel
$alloc_preview_panel = "div[data-ffxtype='preview'] div[data-ffxtype='tool'] img"
$alloc_total_field = "//div[@data-ffxtype='preview']//span[contains(text(),'Total')]/following-sibling::span"
$alloc_distribution_allocation_method_value = "//span[text()='Allocation Method']/..//span[2]"
$alloc_distribution_date_value = "//span[text()='Date']/../span[2]"
$alloc_distribution_period_value = "//span[text()='Period']/../span[2]"
$alloc_value_retrieved_field = "//div[@data-ffxtype='preview']//span[contains(text(),'Value Retrieved')]/following-sibling::span"
$alloc_allocation_percent = ""
$alloc_other_gla_field = ""
$alloc_preview_panel_section_label = "//div[@data-ffxtype='preview']//span[contains(text(),'"+$sf_param_substitute+"')]"
$alloc_preview_panel_section_value = "//div[@data-ffxtype='preview']//span[contains(text(),'"+$sf_param_substitute+"')]/following-sibling::span"
$alloc_preview_panel_allocation_method_label = "Allocation Method"
$alloc_preview_panel_statistical_value_label = "Statistical Basis"
$alloc_preview_panel_distribute_to_glas_label = "Distribute to GLAs"
$alloc_preview_panel_company_label = "Company"
$alloc_preview_panel_date_label = "Date"
$alloc_preview_panel_period_label = "Period"
$alloc_multiple_glas_label = "Multiple GLAs"
## Allocation filter group field selectors ##
$alloc_filter_set = "div.test-filterSet"
$alloc_filter_set_field = "filterField"
$alloc_filter_set_company = "div[data-ffid='filterFieldcodaCompany__c1Equals'] input"
$alloc_filter_set_gla = "div[data-ffid='filterFieldcodaGeneralLedgerAccount__cMultiselect'] div[data-ref='listWrapper'] input"
$alloc_set_gla = "div[data-ffid$=filterFieldcodaGeneralLedgerAccount__c1Multiselect] input" 
$alloc_set_gla_to = "div[data-ffid='filterFieldcodaGeneralLedgerAccount__c1To'] input"
$alloc_set_gla_from = "div[data-ffid='filterFieldcodaGeneralLedgerAccount__c1From'] input"
$alloc_set_dimension1 = "div[data-ffid='filterFieldcodaDimension1__c1Multiselect'] input" 
$alloc_set_dimension1_to = "div[data-ffid='filterFieldcodaDimension1__c1To'] input"
$alloc_set_dimension1_from = "div[data-ffid='filterFieldcodaDimension1__c1From'] input"
$alloc_set_dimension2 = "div[data-ffid='filterFieldcodaDimension2__c1Multiselect'] input" 
$alloc_set_dimension2_to = "div[data-ffid='filterFieldcodaDimension2__c1To'] input"
$alloc_set_dimension2_from = "div[data-ffid='filterFieldcodaDimension2__c1From'] input"
$alloc_set_dimension3 = "div[data-ffid='filterFieldcodaDimension3__c1Multiselect'] input" 
$alloc_set_dimension3_to = "div[data-ffid='filterFieldcodaDimension3__c1To'] input"
$alloc_set_dimension3_from = "div[data-ffid='filterFieldcodaDimension3__c1From'] input"
$alloc_set_dimension4 = "div[data-ffid='filterFieldcodaDimension4__c1Multiselect'] input" 
$alloc_set_dimension4_to = "div[data-ffid='filterFieldcodaDimension4__c1To'] input"
$alloc_set_dimension4_from = "div[data-ffid='filterFieldcodaDimension4__c1From'] input"
$alloc_dimension_input_field_pattern = "div[id="+$sf_param_substitute+"]"
$alloc_dimension_pattern = "input[id="+$sf_param_substitute+"]"
$alloc_set_period_from = "div[data-ffid='filterFieldcodaPeriod__c1From'] input"
$alloc_set_period_to = "div[data-ffid='filterFieldcodaPeriod__c1To'] input"
$alloc_retrieve_source_total_filters_selected = "span[class*= 'ALLOC-filters-selected']"
$alloc_retrieve_popup_search_box = "div[data-ffid='searchField'] input"
$alloc_retrieve_popup_tlis_button = "a[data-ffid='detailTransactionBtn']"
$alloc_retrieved_gla_summary_link = "div[data-ffid='summaryGLA'] a"
$alloc_retrieved_gla_summary_popup = "div[data-ffid='retrievedLinesPopup']"
$alloc_retrieved_gla_summary_popup_table = "div[data-ffid='retrievedLinesTable']"
$alloc_retrieved_gla_summary_popup_close = "div[data-ffid='retrievedLinesPopup'] img[contains(@class, 'close')]"
$alloc_retrieved_gla_summary_popup_column = "div[data-ffid='retrievedLinesTable'] td"
$alloc_retrieved_gla_summary_popup_row = "div[data-ffid='retrievedLinesTable'] tr"
$alloc_popup = "div[data-ffid='retrievedLinesPopup']"
$alloc_popup_close = $alloc_popup + " img"
$alloc_retrieved_popup_table = $alloc_popup + " div[data-ffxtype='tableview'] table"
$alloc_retrieve_popup_row = "tr"
$alloc_retrieved_popup_row = "tbody tr"
$alloc_retrieved_summary_rows = $alloc_retrieved_summary_rows_grid + " div[data-ffxtype='tableview'] table tr[class$='f-grid-row']"
$alloc_retrieved_detail_rows = $alloc_retrieved_summary_rows_grid + " div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr[class*='f-grid-rowbody-tr'] table tr"
$alloc_retrieved_summary_row_expand = $alloc_retrieved_summary_rows_grid + " div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr[class$='f-grid-row'] td:nth-of-type(1) div[class='f-grid-row-expander']"
$alloc_picklist_value_pattern = "//li/div[(text()='"+$sf_param_substitute+"')]"
$alloc_fixed_rule_name_picklist_value_pattern = "//div[(text()='"+$sf_param_substitute+"')]"

## Allocation type selection selectors ##
$alloc_method_of_allocation_label = "Method of Allocation"
$alloc_method_of_allocation_basis_type_label = "Basis Type"
$alloc_fixed_allocation_method = "#fixedType"
$alloc_variable_allocation_method = "#variableType"
$alloc_select_fixed_allocation_method = "div[data-ffid='allocationMethodGroup'] input[componentid='fixedType']+span"
$alloc_select_variable_allocation_method = "div[data-ffid='allocationMethodGroup'] input[componentid='variableType']+span"
$alloc_sb_page_title_label = "Statistical Basis Configuration"

## Allocation fixed distribution selectors ##
$alloc_fixed_distribution_rule_name_picklist = "input[name = 'FixedAllocationRuleId']"
$alloc_fixed_distribution_not_distributed_amount = "div[data-ffid='summaryNONDIST'] span[class*= 'NONDIST'][class*= 'amount']"
$alloc_fixed_distribution_distributed_amount = "div[data-ffid='summaryDISTRIB'] span[class*= 'DISTRIB'][class*= 'amount']"
$alloc_fixed_distribution_dashboard_knob = "div[data-ffxtype='dashboard-knob']"
$alloc_fixed_distribution_total_percentage_field = "td[data-columnid='splitTableColumnPERCENT'] span[class*= 'ALLOC-grid-summary-value']"
$alloc_fixed_distribution_total_amount_field = "td[data-columnid='splitTableColumnAMOUNT'] span[class*= 'ALLOC-grid-summary-value']"
$alloc_split_table = "div[data-ffid=splitTable]"
$alloc_split_table_column = "div[data-ffid='splitTable'] table td"
$alloc_split_table_column_input = "input[name='<objectType>Id']"
$alloc_split_table_row = "div[data-ffid='splitTable'] table tr"
$alloc_split_line_gla =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOC_COLUMN_GLA})"
$alloc_split_line_gla_input =  "input[name = 'GeneralLedgerAccountId']"
$alloc_split_line_dimension1 =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_1})"
$alloc_split_line_dimension1_input =  "input[name = 'Dimension1Id']"
$alloc_split_line_dimension2 =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_2})"
$alloc_split_line_dimension2_input =  "input[name = 'Dimension2Id']"
$alloc_split_line_dimension3 =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_3})"
$alloc_split_line_dimension3_input =  "input[name = 'Dimension3Id']"
$alloc_split_line_dimension4 =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_4})"
$alloc_split_line_dimension4_input =  "input[name = 'Dimension4Id']"
$alloc_split_line_percentage =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOC_COLUMN_PERCENTAGE})"
$alloc_split_line_percentage_input =  "input[name = 'Percentage']"
$alloc_split_line_delete =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOC_COLUMN_DELETE})"
$alloc_split_line_delete_input = "td[data-columnid='splitTableColumnDEL'] div[class*= 'js-delete']"
$alloc_split_line_amount_input = "input[name = 'Amount']"
$alloc_set_dimension1_split = "table[data-ffid$=Dimension1Id] input"
$alloc_set_dimension2_split = "table[data-ffid$=Dimension2Id] input"
$alloc_set_dimension3_split = "table[data-ffid$=Dimension3Id] input"
$alloc_set_dimension4_split = "table[data-ffid$=Dimension4Id] input"
$alloc_set_percentage_split = "table[data-ffid$=Percentage] input"
$alloc_distribution_percentage_column_header = "div[data-ffid='splitTableColumnPERCENT']"
$alloc_distribution_percentage_menu_item_button = "div[data-ffid='splitTableColumnPERCENT'] div[class= 'f-column-header-trigger']"
$alloc_distribution_percentage_column_menu_item_spread_evenly = "//span[text()='Spread Evenly']"
$alloc_create_allocation_popup_cancel_button = "a[data-ffid = 'createAllocationCancelButton']"
$alloc_fixed_distribution_grid_row = "div[data-ffid='splitTable'] div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tbody tr"

## Allocation filter button selectors ##
$alloc_show_filters_button = "//span[contains(text(),'Show Filter')]/ancestor::a"
$alloc_hide_filters_button = "//span[contains(text(),'Hide Filter')]/ancestor::a"
$alloc_retrieve_source_filter_group_preview_button = "a[data-ffid='previewButton']"
$alloc_retrieve_source_filter_group_clear_All_button = "a[data-ffid ='clearAllButton']"
$alloc_retrieve_source_filter_group_clear_group_button = "div[data-ffid = 'clearGroup']"
$alloc_retrieve_source_filter_group_close_button = "div[data-ffxtype='tool'] img[class*= 'f-tool-close']"
$alloc_next_button="a[data-ffid='nextButton']"
$alloc_back_button="a[data-ffid='backButton']"
$alloc_retrieve_source_allocation_list_button = ""

## Allocation - filter group button on filter pop-up selectors ##
$alloc_add_filter_group_button = "a[data-ffid='addFilterButton']"
$alloc_filter_group_concertina_button = "img[class*= 'f-tool-collapse-top']"
$alloc_gla_selection_toggle_button = "div[data-ffid ='codaGeneralLedgerAccount__c1'] a"
$alloc_dimension1_selection_toggle_button = "div[data-ffid ='codaDimension1__c1'] a"
$alloc_dimension2_selection_toggle_button = "div[data-ffid ='codaDimension2__c1'] a"
$alloc_dimension3_selection_toggle_button = "div[data-ffid ='codaDimension3__c1'] a"
$alloc_dimension4_selection_toggle_button = "div[data-ffid ='codaDimension4__c1'] a"
$alloc_account_selection_toggle_button = "div[data-ffid ='Account1'] a"
$alloc_filter_set_multiselect_label = "Multiselect"
$alloc_filter_set_equals_label = "Equals"
$alloc_filter_set_from_label = "From"
$alloc_filter_set_to_label = "To"
$alloc_filter_set_gla_field_object_label = "codaGeneralLedgerAccount__c"
$alloc_filter_set_dimension1_field_object_label = "codaDimension1__c"
$alloc_filter_set_dimension2_field_object_label = "codaDimension2__c"
$alloc_filter_set_dimension3_field_object_label = "codaDimension3__c"
$alloc_filter_set_dimension4_field_object_label = "codaDimension4__c"
$alloc_filter_set_account_field_object_label = "Account"
$alloc_filter_set_company_field_object_label = "codaCompany__c"
$alloc_filter_set_period_field_object_label = "codaPeriod__c"
$alloc_label_method_of_allocation = "Method of Allocation"
$alloc_label_allocation_rule = "Allocation Rule"
$alloc_label_fixed_label = "Fixed"
$alloc_retrieve_source_filter_group = "div[data-ffxtype='filter-box']:nth-of-type("+$sf_param_substitute+")"
## Allocation save fixed/variable allocation rule pop up selectors
$alloc_save_fixed_allocation_rule_button = "a[data-ffid='fixedRuleSaveButton']"
$alloc_save_rule_pop_up = "div[data-ffid='saveRulePopupForm']"
$alloc_save_rule_pop_up_rule_name = $alloc_save_rule_pop_up+" div[data-ffid='nameField'] input"
$alloc_save_rule_pop_up_rule_description = $alloc_save_rule_pop_up+" div[data-ffid='descriptionField'] input"
$alloc_save_rule_pop_up_cancel_button = $alloc_save_rule_pop_up+" a[data-ffid='cancelPopupButton']"
$alloc_save_rule_pop_up_save_button = $alloc_save_rule_pop_up+" a[data-ffid='savePopupButton']"
$alloc_save_rule_pop_up_close_button = $alloc_save_rule_pop_up+" div[data-ffid='saveRulePopupForm'] img"

## Statistical Distribution (Screen 4) selectors ##
$alloc_distribute_to_gla_radio_button = "div[data-ffid='distributionPanel'] input[componentid='distributeToGLAsButton'] + span"
$alloc_distribute_to_gla_picklist = "input[componentid='distributedGLASelection']"
$alloc_distribute_to_gla_picklist_selection = "#distributedGLASelection-itemList li"
$alloc_copy_glas_radio_button = "div[data-ffid='distributionPanel'] input[componentid='copyGLAsButton'] + span"
$alloc_copy_glas_picklist = "input[componentid='copyFromSelection']"
$alloc_copy_glas_picklist_down_arrow = "div[id='copyFromSelection-trigger-picker']"
$alloc_copy_glas_picklist_from_source_label = "Source"
$alloc_copy_glas_picklist_from_basis_label = "Basis"
$alloc_label_statistical_distribution = "Statistical Distribution"
$alloc_copy_glas_picklist_option = "//li[text()='"+$sf_param_substitute+"']"
$alloc_statistical_distribution_table = "div[data-ffid='distributionPanel'] div[data-ffid='StatisticalRuleTable']"
$alloc_statistical_distribution_grid_row = $alloc_statistical_distribution_table+" div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tbody tr"
$alloc_statistical_distribution_grid_rows = $alloc_statistical_distribution_table+" div[data-ffxtype='tableview'] table tr"
$alloc_statistical_distribution_table_gla_column_value = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td[data-columnid='splitTableColumnGLA']"
$alloc_statistical_distribution_table_dim1_column_value = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td[data-columnid='splitTableColumnDIM1']"
$alloc_statistical_distribution_table_dim2_column_value = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td[data-columnid='splitTableColumnDIM2']"
$alloc_statistical_distribution_table_dim3_column_value = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td[data-columnid='splitTableColumnDIM3']"
$alloc_statistical_distribution_table_dim4_column_value = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td[data-columnid='splitTableColumnDIM4']"
$alloc_statistical_distribution_table_percentage_column_value = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td[data-columnid='allocationRuleTableColumnPercent']"
$alloc_statistical_distribution_table_amount_column_value = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td[data-columnid='splitTableColumnValue']"
$alloc_statistical_distribution_table_total_percentage =  $alloc_statistical_distribution_table +" div[data-ffid='summaryBar'] td[data-columnid='allocationRuleTableColumnPercent'] span[class = 'ALLOCRULE-grid-summary-value']"
$alloc_statistical_distribution_table_total_amount = $alloc_statistical_distribution_table +" div[data-ffid='summaryBar'] td[data-columnid='splitTableColumnValue'] span[class = 'ALLOCRULE-grid-summary-value']"
$alloc_statistical_distribution_table_row = $alloc_statistical_distribution_table + " table:nth-of-type("+$sf_param_substitute+") td"
$alloc_statistical_distribution_preview_button = "a[data-ffid='DistributionPreviewButton']"
##################### Statistical basis Configuration distribution (screen 3 selectors) ##################
# Labels 
$alloc_type_variable_label = "Variable"
$alloc_gla_label = "General Ledger Account"
$alloc_dim1_label = "Dimension 1"
$alloc_dim2_label = "Dimension 2"
$alloc_dim3_label = "Dimension 3"
$alloc_dim4_label = "Dimension 4"
$alloc_percentage_label = "Percentage (%)"
$alloc_value_label = "Value"
$alloc_filter_operator_contains_label = "Contains"
$alloc_filter_operator_equals_label = "Equals"
$alloc_filter_operator_not_equals_label = "Not Equals"

# Header
$alloc_variable_distribution_rule_name_picklist = "//div[@data-ffid='VariableRuleName']//input/../following-sibling::div "
$alloc_variable_distribution_rule_name_input = "div[data-ffid='VariableRuleName'] input"
$alloc_variable_distribution_statistical_basis_picklist = "div[data-ffid='StatisticalValues'] div div div[class*='f-form-arrow-trigger']"
$alloc_variable_statistical_bases_input = "div[data-ffid='StatisticalValues'] input"
$alloc_variable_distribution_field_input = "div[data-ffid='DistributionFields'] input"
$alloc_variable_distribution_field_selected = "//div[@data-ffid='DistributionFields']//li/div[contains(text(),'"+$sf_param_substitute+"')]"

# Buttons 
$alloc_variable_distribution_save_button = "a[data-ffid='CreateVariableRule']"
$alloc_variable_distribution_back_popup_yes_button = "a[data-ffid='ok']"
$alloc_variable_distribution_back_popup_no_button = "a[data-ffid='cancel']"
$alloc_variable_distribution_add_statistical_bases_button = "div[data-ffid='StatisticalAllocationheader'] a[data-ffid='CreateStatisticalValues']"

##################### Statistical basis Configuration distribution Grid (screen 3) section ##################
# Labels
$alloc_statistical_configuration_grid = "div[data-ffid='variableRuleSelection'] div[data-ffid='StatisticalRuleTable']"
$alloc_variable_distribution_grid_rows = $alloc_statistical_configuration_grid+" div[data-ffxtype='tableview'] table"
$alloc_variable_distribution_grid_row = $alloc_statistical_configuration_grid+" div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tbody tr"
$alloc_variable_distribution_rowcolumn_pattern_view_page = $alloc_statistical_configuration_grid+" div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div"
$alloc_variable_distribution_grid_total_percentage = $alloc_statistical_configuration_grid+" div[data-ffid='summaryBar'] td[data-columnid='allocationRuleTableColumnPercent'] span[class*='summary-value']"
$alloc_variable_distribution_grid_total_value = $alloc_statistical_configuration_grid+" div[data-ffid='summaryBar'] td[data-columnid='splitTableColumnValue'] span[class*='summary-value']"

# Popup
$alloc_variable_distribution_message_box = "div[data-ffxtype='messagebox']"
$alloc_variable_distribution_message_text = ".f-window-text"

# Toast
$alloc_variable_distribution_toast_message_box = "div[class*='f-window f-toast']"
$alloc_variable_distribution_toast_message = "label[class*='ALLOCRULE-toast-message']"
$alloc_toast_message_box = "div[class*='f-toast']"
$alloc_toast_message = "div[data-ffxtype='toast'] div:nth-of-type(2) div div"
$alloc_variable_distribution_toast_message_undo_button = "div[class*='f-window f-toast'] div[data-ffxtype='toolbar'] a[data-ffxtype='button']"
$alloc_variable_distribution_toast_message_close_button = "div[class*='f-window f-toast'] div[data-ffxtype='tool'] img"

## Allocation preview/post screen selectors 
$alloc_post_button = "a[data-ffid='postButton']"
$alloc_destination_type_name_field = "input[name='DestinationTypeName']"
$alloc_boundlist_container = "div.ALLOC-boundlist-container"
$alloc_boundlist_container_item = "div.f-boundlist-item"
$alloc_destination_company_field = "input[name='DestinationCompanyId']"
$alloc_destination_company_period_field = "input[name='PeriodId']"
$alloc_posting_description_field = "input[name='Description']"
$alloc_posting_date_field = "input[name='AllocationsDateAsString']"
$alloc_successful_popup = "div[data-ffid='successPopup']"
$alloc_successful_popup_new_allocation_button = "a[data-ffid='successNewAllocationButton']"
$alloc_successful_popup_view_transaction_button = "a[data-ffid='successViewTransactionButton']"
$alloc_posting_transaction_lines_preview = "div[data-ffxtype='transactionpreview']"
$alloc_accordion_panel_expand_icon = "img[class*='f-tool-expand-bottom']"
$alloc_accordion_panel_collapse_icon =  "img[class*= 'f-tool-collapse-top']"
$alloc_source_section_expand_collapse_icon = "div[data-groupname ='Source'] div"
$alloc_distribution_section_expand_collapse_icon = "div[data-groupname ='Distribution'] div"
$alloc_total_retrieved_and_distributed_rows = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tbody tr[class*='f-grid-row']"

## Wizard selectors
$alloc_wizard_retrieve_source = "li[data-ffid='Retrieve Source']"
$alloc_wizard_allocation_method = "li[data-ffid='Allocation Method']"
$alloc_wizard_configure_basis = "li[data-ffid='Configure Basis']"
$alloc_wizard_distribute = "li[data-ffid='Distribute']"
$alloc_wizard_post = "li[data-ffid='Post']"

########### Statistical Basis Configuration (screen 3) Filter Section fields ################
$alloc_statistical_basis_config_filter_selected_count = "div[data-ffid='FilterCount'] span[class*='ALLOC-filters-selected']"
$alloc_statistical_basis_config_filter_clear_all_button = "a[data-ffid='clearFilterButton']"
$alloc_variable_distribution_filter_preview_button = "a[data-ffid='PreviewButton']"
$alloc_statistical_basis_config_filter_show_filter_button = "//span[contains(text(),'Show Filter')]/ancestor::a"
$alloc_statistical_basis_config_filter_hide_filter_button = "//span[contains(text(),'Hide Filter')]/ancestor::a"
$alloc_statistical_basis_config_filter_add_filter_button = "a[data-ffid='addFilterButton']"
$alloc_statistical_basis_config_filter_close_button = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") a[data-ffid='closeButton']"
$alloc_statistical_basis_config_filter_field_input = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") div[data-ffid='FilterField'] input"
$alloc_statistical_basis_config_filter_operator_input = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") div[data-ffid='Operator'] input"
$alloc_statistical_basis_config_filter_value_input = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+") div[data-ffid='Value'] input"
$alloc_statistical_basis_config_filter_row = "div[data-ffxtype='allocrule-filter-box']:nth-of-type("+$sf_param_substitute+")"
$alloc_statistical_basis_config_filter_rows = "div[data-ffxtype='allocrule-filter-box']"

## Allocations Detail Screen Selectors ##
$alloc_detail_page_allocation_name_field = "//td[text()='Allocation Name']/..//div[1]"
$alloc_detail_page_allocation_method_field = "//td[text()='Allocation Method']/..//div[1]"
$alloc_detail_page_description_field = "//td[text()='Description']/..//div[1]"
$alloc_detail_page_output_field = "//td[text()='Output']/..//div[1]"
$alloc_detail_page_company_field = "input[name='Company']"
$alloc_detail_page_posting_date_field = "//td[text()='Posting Date']/..//div[1]"
$alloc_detail_page_posting_period_field = "//td[text()='Posting Period']/..//div[1]"
$alloc_detail_page_created_by_field = "input[name='CreatedBy']"
$alloc_detail_page_created_date_field = "input[name='CreatedDate']"
$alloc_detail_page_allocations_list_button = "a[data-ffid = 'btnAllocationsList']"
$alloc_detail_page_transactions_summary_grid = "div[data-ffxtype='transactions-summary-grid']"
$alloc_detail_page_journals_summary_grid = "div[data-ffxtype='journals-summary-grid']"
$alloc_detail_page_transactions_summary_table_row = $alloc_detail_page_transactions_summary_grid + " div[data-ref='body'] table:nth-of-type("+$sf_param_substitute+") tr"
$alloc_detail_page_transactions_summary_table_total_row = $alloc_detail_page_transactions_summary_grid + " div[data-ffid='summaryBar'] table td"
$alloc_detail_page_journals_summary_table_row = $alloc_detail_page_journals_summary_grid + " div[data-ref='body'] table:nth-of-type("+$sf_param_substitute+") td"
$alloc_detail_page_journals_summary_table_total_row = $alloc_detail_page_journals_summary_grid + " div[data-ffid='summaryBar'] table td"
$alloc_transaction_field = "//td[text()='"+$sf_param_substitute+"']/following-sibling::td[1]/div"
$alloc_label_allocation_name = "Allocation Name"

################### Allocation Template Load/Save Selectors ############################
$alloc_template_load = "a[data-ffid='templateLoadButton']"
$alloc_template_save = "a[data-ffid='templateSaveButton']"
$alloc_template_save_popup = "div[data-ffid='saveTemplatePopup']"
$alloc_template_save_popup_name = "div[data-ffid=saveTemplateName] input"
$alloc_template_save_popup_description = "div[data-ffid='saveTemplateDescription'] textarea"
$alloc_template_save_popup_save_button = "a[data-ffid=saveTemplateSaveButton]"
$alloc_template_save_popup_cancel_button = "a[data-ffid='saveTemplateCancelButton']"
$alloc_template_save_popup_message_box = "div[data-ffid='saveTemplateMessageBox']"
$alloc_template_select = "div[data-ffid='templateSelector'] input"
$alloc_rule_list = "//div[@data-ffxtype='boundlist']//li[text()='"+$sf_param_substitute+"']"
$alloc_transaction_header_label = "//h2[text()='Transaction Detail']"
$alloc_toggle_button = "a[data-ffxtype='fillbutton']"
###########################################################################################
#Allocation Filter set selection methods
##
#
# Method Summary: Build filter set selector for Allocations when criteria is in Multiselect format
#
# @param [String] objectName  Set object name which includes Company, Period, GLA, Dimension 1, Dimension 2, Dimension 3, Dimension 4
# @param [Integer] filterSetNumber Set Filter set position 
# @param [String] criteriaName Select criteria name which includes Equals, Multiselect
#
def Allocations.build_filterset_field_selector objectName, filterSetNumber, criteriaName
	return '[data-ffid="' + $alloc_filter_set_field + objectName + filterSetNumber.to_s + criteriaName + '"]'
end

##
#
# Method Summary: Set Allocation type in Allocation source selection criteria
#
# @param [String] allocation_type Select allocation type to set in what do you want to allocate picklist field
# Values for Allocation type picklist can have values Transactions or Reporting balances
#
def Allocations.set_allocation_type allocation_type
	SF.execute_script do
		find($alloc_allocation_type).click
		find($alloc_allocation_type).set allocation_type
		gen_wait_less
		gen_tab_out $alloc_allocation_type
	end
end

##
# Method Summary: Method to set PeriodTo single company
#
# @param [String] period Set To period field 
# 
def Allocations.set_period_to period
	find($alloc_period_to_input).set(period + "\t")
end

##
#
# Method Summary: Set From and To period values, when multicompany are selected
#
# @param [String] fromperiod_value  Select fromPeriod value in fromPeriod picklist
# @param [String] toperiod_value  Select toPeriod value in toPeriod picklist
#
def Allocations.set_period filter_position, fromperiod_value, toperiod_value
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[position - 1]
	targetFilterSet.click
	filter_set_position = 1
	within(targetFilterSet) do
		find($alloc_set_period_from).click
		find($alloc_set_period_from).set fromperiod_value
		find($alloc_set_period_to).click
		find($alloc_set_period_to).set toperiod_value
		gen_tab_out $alloc_set_period_to
	end
end

##
#
# Method Summary: Set TimePeriod in filter sets in case of single company allocation
#
# @param [String] timeperiod_value  Select timeperiod values in timeperiod picklist
# Values can be : Date, Period, Soft Date, Soft Period
#
def Allocations.set_timeperiod_value timeperiod_value
	SF.execute_script do
		find($alloc_timeperiod_selection_field).click
		find($alloc_timeperiod_selection_field).set timeperiod_value
		gen_wait_less # wait for dynamic fields associated to be populated on UI the basis of timeperiod value selection
		gen_tab_out $alloc_timeperiod_selection_field
	end
end

##
#
# Method Summary: Set From and To period values, when TimePeriod Selection = Period
#
# @param [String] fromperiod_value  Select fromPeriod value in fromPeriod picklist
# @param [String] toperiod_value  Select toPeriod value in toPeriod picklist
#
def Allocations.set_timeperiod_period_selection fromperiod_value, toperiod_value
	SF.execute_script do
		Allocations.set_timeperiod_value 'Period'
		find($alloc_from_period_field).click
		find($alloc_from_period_field).set fromperiod_value
		find($alloc_to_period_field).click
		find($alloc_to_period_field).set toperiod_value
		gen_tab_out $alloc_to_period_field
	end
end

##
#
# Method Summary: Set From and To Date values, when TimePeriod Selection = Date
#
# @param [String] fromdate_value  Select from Date value in from Date picklist
# @param [String] todate_value  Select to Date value in to Date picklist
#
def Allocations.set_timeperiod_date_selection fromdate_value, todate_value
	SF.execute_script do
		Allocations.set_timeperiod_value 'Date'
		find($alloc_from_date_field).click
		find($alloc_from_date_field).set fromdate_value
		find($alloc_to_date_field).click
		find($alloc_to_date_field).set todate_value
		gen_tab_out $alloc_to_date_field
	end
end

##
#
# Method Summary: Set Soft Date values, when TimePeriod Selection = Soft Date
#
# @param [String] softdate_value  Select soft date parameter value in Soft Date picklist
# @param [String] userinput_n_value  Set user defined soft date parameter in textbox
# Soft date picklist values are Current Month, Last Month, Last N Months, Last N Days
#
def Allocations.set_timeperiod_soft_date_selection softdate_value, userinput_n_value
	SF.execute_script do
		Allocations.set_timeperiod_value 'Soft Date'
		if(softdate_value == 'Current Month' || softdate_value == 'Last Month')
			find($alloc_soft_date_field).click
			find($alloc_soft_date_field).set softdate_value
		else 
			find($alloc_soft_date_field).click
			find($alloc_soft_date_field).set softdate_value
			gen_tab_out $alloc_soft_date_field
			gen_wait_until_object $alloc_n_value_user_input_field
			find($alloc_n_value_user_input_field).click
			find($alloc_n_value_user_input_field).set userinput_n_value
		end	
	end
end

##
#
# Method Summary: Set Soft Period values, when TimePeriod Selection = Soft Period
#
# @param [String] softperiod_value  Select soft period parameter value in Soft Period picklist
# @param [String] userinput_n_value  Set user defined soft period parameter in textbox
# Soft date picklist values are Current Period, Last Period, Last N Periods
#
def Allocations.set_timeperiod_soft_period_selection softperiod_value, userinput_n_value
	SF.execute_script do
		Allocations.set_timeperiod_value 'Soft Period'
		if(softperiod_value == 'Current Period' || softperiod_value == 'Last Period')
			find($alloc_soft_period_field).click
			find($alloc_soft_period_field).set softperiod_value
		else 
			find($alloc_soft_period_field).click
			find($alloc_soft_period_field).set softperiod_value
			gen_tab_out $alloc_soft_period_field
			gen_wait_until_object $alloc_n_value_user_input_field
			find($alloc_n_value_user_input_field).click
			find($alloc_n_value_user_input_field).set userinput_n_value
		end
	end
end

########################################################
#Filter set selection methods to set the filter criteria
########################################################

##
#
# Method Summary: Set company in filter sets in case of multi company allocation
#
# @param [String] company_name     Select company name to set in company picklist field
#
def Allocations.set_company_value company_name
	SF.execute_script do
		find($alloc_filter_set_company).click
		find($alloc_filter_set_company).set company_name
		gen_wait_less # wait for company name to filter in case on multi company allocation.
		gen_tab_out $alloc_filter_set_company
	end
	gen_wait_until_object_disappear $page_loadmask_message
end

#set filter set period
def Allocations.set_filterset_to to_date
	SF.execute_script do
		find($alloc_filter_set_period).set to_date
		gen_tab_out $alloc_filter_set_period
	end
end

##
#
# Method Summary: Method to set values in a filter group set
#
# @param [Integer] position Set Filter set position
# @param [String] type Set object name which includes Company, Period, GLA, Dimension 1, Dimension 2, Dimension 3, Dimension 4
# @param [String] criteria Select criteria name which includes Equals, Multiselect, From, To
# @param [String] value Set value for the object type and criteria selected
#
def Allocations.set_filterset_field position, type, criteria, value
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	if(page.has_css?$alloc_only_ict_checkbox)
		if(criteria == 'Multiselect' || criteria == 'Equals'|| criteria == 'From'|| criteria == 'To')
			selector = build_filterset_field_selector type, nil, criteria
		else
			selector = build_filterset_field_selector type, nil, criteria
		end
	else
		if(criteria == 'Multiselect' || criteria == 'Equals')
			selector = build_filterset_field_selector type, nil, criteria
		else
			selector = build_filterset_field_selector type, nil, criteria
		end
	end
	within(filter_set_element) do
		find(selector).click
		find(selector + ' input').set(value)
		## Results list takes a bit to get filtered.
		## This sleep will avoid double results.
		gen_wait_until_object_disappear $page_loadmask_message
		find(selector + ' input').native.send_keys(:tab)
	end
	gen_wait_until_object_disappear $page_loadmask_message
end

##
#
# Method Summary: Select GLA account to retrieve data from in allocations pool
#
# @param [String] general_ledger_account     Select GLA account to retrieve data in GLA picklist
#
def Allocations.set_gla general_ledger_account
	find($alloc_set_gla).click
	find($alloc_set_gla).set general_ledger_account
	gen_tab_out $alloc_set_gla
end

##
#
# Method Summary : Method to click the From - To button for Allocation GLA filter field
# @param [Integer] filter_set_position Set Filter set position
#
def Allocations.click_gla_filter_fromto_button filter_set_position
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(filter_set_position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		find($alloc_gla_selection_toggle_button).hover
		SF.retry_script_block do
			SF.execute_script do
				find($alloc_gla_selection_toggle_button).click
			end
		end		
		gen_wait_less
		find(:xpath,$alloc_from_to_label).click
	end
end

##
#
# Method Summary : Method to click the From - To button for Allocation Dimension 1 filter field
# @param [Integer] filter_set_position Set Filter set position
#
def Allocations.click_dimension1_filter_fromto_button filter_set_position
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(filter_set_position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		find($alloc_dimension1_selection_toggle_button).hover
		SF.retry_script_block do
			SF.execute_script do
				find($alloc_dimension1_selection_toggle_button).click
			end
		end
		gen_wait_less
		find(:xpath,$alloc_from_to_label).click
	end
end

##
#
# Method Summary : Method to click the From - To button for Allocation Dimension 2 filter field
# @param [Integer] filter_set_position Set Filter set position
#
def Allocations.click_dimension2_filter_fromto_button filter_set_position
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(filter_set_position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		find($alloc_dimension2_selection_toggle_button).hover
		SF.retry_script_block do
			SF.execute_script do
				find($alloc_dimension2_selection_toggle_button).click
			end
		end
		gen_wait_less
		find(:xpath,$alloc_from_to_label).click
	end
end

##
#
# Method Summary : Method to click the From - To button for Allocation Dimension 3 filter field
# @param [Integer] filter_set_position Set Filter set position
#
def Allocations.click_dimension3_filter_fromto_button filter_set_position
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(filter_set_position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		find($alloc_dimension3_selection_toggle_button).hover
		SF.retry_script_block do
			SF.execute_script do
				find($alloc_dimension3_selection_toggle_button).click
			end
		end
		gen_wait_less
		find(:xpath,$alloc_from_to_label).click
	end
end

##
#
# Method Summary : Method to click the From - To button for Allocation Dimension 4 filter field
# @param [Integer] position Set Filter set position
#
def Allocations.click_dimension4_filter_fromto_button position
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		find($alloc_dimension4_selection_toggle_button).hover
		SF.retry_script_block do
			SF.execute_script do
				find($alloc_dimension4_selection_toggle_button).click
			end
		end
		gen_wait_less
		find(:xpath,$alloc_from_to_label).click
	end
end

##
#
# Method Summary : Method to click the From - To button for Allocation account filter field
# @param [Integer] position Set Filter set position
#
def Allocations.click_account_filter_fromto_button position
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		find($alloc_account_selection_toggle_button).hover
		SF.retry_script_block do
			SF.execute_script do
				find($alloc_account_selection_toggle_button).click
			end
		end
		gen_wait_less
		find(:xpath,$alloc_from_to_label).click
	end
end

##
#
# Method Summary : Returns the Timeperiod picklist selected value
#
def Allocations.get_time_period_value
	return find($alloc_timeperiod_selection_field).value
end

##
#
# Method Summary : Returns the from period value
#
def Allocations.get_from_period_value
	return find($alloc_from_period_field).value
end

##
#
# Method Summary : Returns the To period value
#
def Allocations.get_to_period_value
	return find($alloc_to_period_field).value
end

##
#
# Method Summary : Returns the from Date value
#
def Allocations.get_from_date_value
	return find($alloc_from_date_field).value
end

##
#
# Method Summary : Returns the To Date value
#
def Allocations.get_to_date_value
	return find($alloc_to_date_field).value
end

##
#
# Method Summary : Returns the Soft Date picklist value
#
def Allocations.get_soft_date_value
	return find($alloc_soft_date_field).value
end

##
#
# Method Summary : Returns the Soft Period picklist value
#
def Allocations.get_soft_period_value
	return find($alloc_soft_period_field).value
end

##
#
# Method Summary : Returns the Allocation type value
#
def Allocations.get_allocation_type
	return find($alloc_allocation_type).value
end

##
#
# Method Summary: Method to clear values in a filter group set
#
# @param [Integer] position Set Filter set position
# @param [String] type Set object name which includes Company, Period, GLA, Dimension 1, Dimension 2, Dimension 3, Dimension 4
# @param [String] criteria Select criteria name which includes Equals, Multiselect, From, To
#
def Allocations.clear_filterset_field position, type, criteria
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	selector = build_filterset_field_selector type, nil, criteria

	within(filter_set_element) do
			find(selector + ' div[class$="close"]').click
	end
end

##
#
# Method Summary: Find the only intercompany transactions on source selection pop up header and check if the checkbox is checked or not.
#
def Allocations.is_only_intercompany_transactions_checkbox_checked?
	return page.has_css?($alloc_only_ict_checkbox_enabled)
end

##
#
# Method Summary: Find the Only Intercompany transactions checkbox field and set the value.
#
# @param [Boolean] check_only_ict	Check the  Only Intercompany transactions checkbox or not
#
def Allocations.click_only_intercompany_transactions_checkbox check_only_ict
	if(check_only_ict == true)
		if(Allocations.is_only_intercompany_transactions_checkbox_checked? == true)
			gen_tab_out $alloc_only_ict_checkbox
		else
			# It sometime treat the form type radio button as Input or Span,
			# Handling both scenarios using Begin-resuce block.
			begin
				find($alloc_only_ict_checkbox).click
			rescue
				find($alloc_only_ict_checkbox_span).click
			end
			gen_tab_out $alloc_only_ict_checkbox
		end
	elsif (check_only_ict == false)
		if(Allocations.is_only_intercompany_transactions_checkbox_checked? == true)
			# It sometime treat the form type radio button as Input or Span,
			# Handling both scenarios using Begin-resuce block.
			begin
				find($alloc_only_ict_checkbox).click
			rescue
				find($alloc_only_ict_checkbox_span).click
			end
			gen_tab_out $alloc_only_ict_checkbox
		else
			gen_tab_out $alloc_only_ict_checkbox
		end
	else
		raise "Given parameter value is not a boolean, it must be true/false"
	end
end

#Retrieve source page Methods#

##
#
# Method Summary: Click the Next button to navigate to apply allocation rule
#
def Allocations.click_on_next_button
	SF.execute_script do
		gen_wait_until_object $alloc_next_button
		find($alloc_next_button).click
		gen_wait_until_object_disappear $ffa_msg_loading
		# it takes sometime to finish loading
		gen_wait_less
	end
end

##
#
# Method Summary: Click the back button to navigate to previous page from current UI
#
def Allocations.click_on_back_button
	SF.execute_script do
		find($alloc_back_button).click
	end
end

##
#
# Method Summary: Click the Clear All button.
#
def Allocations.click_on_clear_all_button
	SF.execute_script do
		find($alloc_retrieve_source_filter_group_clear_All_button).click
	end
end

##
#
# Method Summary: Click the Show Filters button.
#
def Allocations.click_on_show_filters_button
	SF.execute_script do
		find(:xpath,$alloc_show_filters_button).click
	end
end

##
#
# Method Summary: Click the Hide Filters button.
#
def Allocations.click_on_hide_filters_button
	SF.execute_script do
		find(:xpath,$alloc_hide_filters_button).click
	end
end

##
#
# Method Summary: Click the Preview button.
#
def Allocations.click_on_preview_button
	SF.execute_script do
		find($alloc_retrieve_source_filter_group_preview_button).click
		gen_wait_until_object_disappear $alloc_retrieve_source_page_label
		gen_wait_until_object_disappear $page_loadmask_message
	end
end



##
#
# Method Summary: Click the Clear group button.
# @param [Integer] filter_set_position  filter's number is entered for which clear filter group actions needs to be performed
#
def Allocations.click_on_selected_filter_clear_group_button filter_set_position
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_retrieve_source_filter_group_clear_group_button).click
	end
end

##
#
# Method Summary: Click the Add Filter group button.
#
def Allocations.click_on_add_filter_group_button
	SF.execute_script do
		find($alloc_add_filter_group_button).click
		gen_wait_until_object $alloc_filter_set
		# wait for company picklist to get loaded
		gen_wait_less
	end
end

##
#
# Method Summary: Click the default close button of filter group(to delete the filter group set)
# @param [Integer] filter_set_position  filter's number is entered for which filter delete action needs to be performed
#
def Allocations.click_on_filter_group_close_button filter_set_position
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_retrieve_source_filter_group_close_button).click
	end
end

##
#
# Method Summary : Returns the values Retrieved  
#
def Allocations.get_values_retrieved 
	return find($alloc_values_retrived_field).text
end

##
#
# Method Summary : Returns the total value  
#
def Allocations.get_total_value 
	return find(:xpath, $alloc_total_field).text
end

#get distribution allocation method in right panel 
def Allocations.get_allocation_method 
	return find(:xpath, $alloc_distribution_allocation_method_value).text
end

#get distribution date in right panel 
def Allocations.get_distribution_date
	return find(:xpath, $alloc_distribution_date_value).text
end

#get distribution period in right panel 
def Allocations.get_distribution_period
	return find(:xpath, $alloc_distribution_period_value).text
end 

##
#
# Method Summary : Returns the value retrieved text  
#
def Allocations.get_value_retrieved
	return find(:xpath, $alloc_value_retrieved_field).text
end

def Allocations.toggle_filter_sets
	find($alloc_toggle_filters_button).click
end

##
# Method Summary: Identifies the filter block area depending upon the filter number is mentioned
#
# @param [String] filter_set_position    filter's number is entered
#
def Allocations.select_filter_set filter_set_position
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	return targetFilterSet
end

def Allocations.assert_filterset_gla_value num, criteria, value
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(num+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		if(criteria == $alloc_filter_set_multiselect_label || criteria == $alloc_filter_set_equals_label)
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_gla_field_object_label, nil, criteria).has_content?(value)
		else
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_gla_field_object_label, nil, criteria).has_content?(value)
		end
	end
end

def Allocations.assert_filterset_dim1_value num, criteria, value
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(num+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		if(criteria == $alloc_filter_set_multiselect_label || criteria == $alloc_filter_set_equals_label)
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension1_field_object_label, nil, criteria).has_content?(value)
		else
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension1_field_object_label, nil, criteria).has_content?(value)
		end
	end
end

def Allocations.assert_filterset_dim2_value num, criteria, value
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(num+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		if(criteria == $alloc_filter_set_multiselect_label || criteria == $alloc_filter_set_equals_label)
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension2_field_object_label, nil, criteria).has_content?(value)
		else
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension2_field_object_label, nil, criteria).has_content?(value)
		end
	end
end

def Allocations.assert_filterset_dim3_value num, criteria, value
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(num+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		if(criteria == $alloc_filter_set_multiselect_label || criteria == $alloc_filter_set_equals_label)
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension3_field_object_label, nil, criteria).has_content?(value)
		else
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension3_field_object_label, nil, criteria).has_content?(value)
		end
	end
end

def Allocations.assert_filterset_dim4_value num, criteria, value
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(num+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	within(filter_set_element) do
		if(criteria == $alloc_filter_set_multiselect_label || criteria == $alloc_filter_set_equals_label)
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension4_field_object_label, nil, criteria).has_content?(value)
		else
			return find(Allocations.build_filterset_field_selector $alloc_filter_set_dimension4_field_object_label, nil, criteria).has_content?(value)
		end
	end
end

## Retrieve - Need to be deleted
def Allocations.retrieve
	SF.execute_script do
		find($alloc_retrieve_button).click
		FFA.wait_page_message $ffa_msg_loading
		gen_wait_until_object_disappear $page_loadmask_message
	end
end

def Allocations.open_summary_by_gla
	SF.retry_script_block do
		SF.execute_script do
			find($alloc_retrieved_gla_summary_link).click
		end
	end
	gen_wait_until_object $alloc_retrieve_popup_search_box # wait for pop up to appear with information on it.
end

def Allocations.close_summary_by_gla
	find($alloc_retrieved_gla_summary_popup_close).click
end

def Allocations.set_search string_to_search
	find($alloc_retrieve_popup_search_box).set('')
	find($alloc_retrieve_popup_search_box).set(string_to_search)
	gen_wait_less
end

def Allocations.click_tlis_button
	find($alloc_retrieve_popup_tlis_button).click
	gen_wait_for_text $alloc_retrieve_column_transaction
end

def Allocations.assert_retrieved_values num
	return find(:xpath,$alloc_value_retrieved_field).has_content?(num.to_s)
end

def Allocations.assert_total_amount_value value
	SF.execute_script do
		return find(:xpath,$alloc_total_field).has_content?(value)
	end
end

def Allocations.assert_retrieved_summary_grid_rows expected_rows
	SF.execute_script do
		gen_wait_until_object $alloc_retrieved_summary_rows
		rows = all($alloc_retrieved_summary_rows)
		
		if rows.to_a.count != expected_rows.count
			puts "Bad number of rows: " + rows.to_a.count.to_s + " (expected " + expected_rows.count.to_s + ")"
			return false
		end

		content = ''
		rows.each do |one_row|
			content += one_row.text + ' '			
		end

		expected_rows.each do |one_row|
			if !(content.include? one_row)
				puts "Row not found: " + one_row
				puts "Existent rows: " + content
				return false
			end
		end
		return true
	end
end

def Allocations.assert_retrieved_detail_grid_rows row_number,expected_rows
	SF.execute_script do
		Allocations.expand_retrieved_summary_row row_number
		detail_rows = $alloc_retrieved_detail_rows.sub($sf_param_substitute,row_number.to_s)
		rows = all(detail_rows)
		
		if rows.to_a.count != expected_rows.count
			puts "Bad number of rows: " + rows.to_a.count.to_s + " (expected " + expected_rows.count.to_s + ")"
			return false
		end
		
		content = ''
		rows.each do |one_row|
			row = 
			content += one_row.text + ' '			
		end

		expected_rows.each do |one_row|
			if !(content.include? one_row)
				puts "Row not found: " + one_row
				puts "Existent rows: " + content
				return false
			end
		end
		Allocations.collapse_retrieved_summary_row row_number
		return true
	end
end

def Allocations.expand_retrieved_summary_row row_number
	element_to_click = $alloc_retrieved_summary_row_expand.sub($sf_param_substitute,row_number.to_s)
	find(element_to_click).click
	gen_wait_until_object_disappear $page_loadmask_message
end

def Allocations.collapse_retrieved_summary_row row_number
	element_to_click = $alloc_retrieved_summary_row_expand.sub($sf_param_substitute,row_number.to_s)
	find(element_to_click).click
end

def Allocations.get_retrieved_summary_row_number expected_row
	rows = all($alloc_retrieved_summary_rows)
	rows.each.with_index(1) do |one_row,i|
		row_content = one_row.text
		if (row_content.include? expected_row)
			return i
		end
	end
end

def Allocations.get_to_period_value
	SF.execute_script do
		return find($alloc_to_period_value).value
	end
end

def Allocations.set_only_intercompany_transactions_checkbox value
	SF.execute_script do
		if ORG_TYPE == UNMANAGED
			checkbox = find(:xpath,$alloc_only_ict_checkbox_unmanage)
		else 
			checkbox = find(:xpath,$alloc_only_ict_checkbox_manage)
		end
		current_classes = checkbox[:class]
		if (!(current_classes.include? "checked") and value) or ((current_classes.include? "checked") and !value)
			checkbox.click
		end
	end
end

##
#
# Method Summary : Returns the Filters selected value 
#
def Allocations.get_filters_selected_value
 return find($alloc_retrieve_source_total_filters_selected).text
end

##
#
# Method Summary : click on the preview panel 
#
def Allocations.click_on_preview_panel
  SF.execute_script do
		find($alloc_preview_panel).click
	end
end

##
#
# Method Summary: Returns the count of GLAs matched
# 
# @param [String] gla_list to pass the list of gla's
#
def Allocations.get_matched_count_gla gla_list
	num_of_field_present_in_picklist = 0
	gla_list.each do |value|			
		find($alloc_filter_set_gla).set(value)
		gen_wait_less #list takes few seconds to load.
		gen_tab_out $alloc_filter_set_gla				
		picklist_filtered_value = $alloc_picklist_value_pattern.sub($sf_param_substitute,value.to_s)				
		if page.has_xpath?(picklist_filtered_value)
			num_of_field_present_in_picklist+=1
			SF.log_info "value is present in picklist: "+value
		else	
			SF.log_info "Value is not present in picklist: "+ value
		end
	end
	return num_of_field_present_in_picklist
end

##
#
# Method Summary : Method to select fixed Allocation method 
#
def Allocations.select_fixed_allocation_method_button
	SF.execute_script do
		find($alloc_select_fixed_allocation_method).click
	end
end

##
#
# Method Summary : Method to select variable Allocation method 
#
def Allocations.select_variable_allocation_method_button
	SF.execute_script do
		find($alloc_select_variable_allocation_method).click
	end
end

##
#
# Method Summary : Method to check that Fixed Allocation method option button is selected or not
#
def Allocations.is_fixed_allocation_method_selected?
	element = find($alloc_fixed_allocation_method)
	is_checked = element[:class].include?($ffa_sencha_selected_checkbox_class)
	return is_checked
end

##
#
# Method Summary : Method to check that Variable Allocation method option button is selected or not
#
def Allocations.is_variable_allocation_method_selected?
	element = find($alloc_variable_allocation_method)
	is_checked = element[:class].include?($ffa_sencha_selected_checkbox_class)
	return is_checked
end

##
#
# Method Summary: Set Allocation type in Allocation source selection criteria
#
# @param [String] fixed_allocation_rule_name 		Select fixed allocation rules in rule name picklist
#
def Allocations.set_rule_name fixed_allocation_rule_name
	SF.retry_script_block do
		SF.execute_script do
			gen_wait_until_object $alloc_fixed_distribution_rule_name_picklist
			existing_rule = find($alloc_fixed_distribution_rule_name_picklist).value
			if existing_rule.to_s.empty?
				find($alloc_fixed_distribution_rule_name_picklist).click
				find($alloc_fixed_distribution_rule_name_picklist).set fixed_allocation_rule_name
				gen_tab_out $alloc_fixed_distribution_rule_name_picklist
				gen_wait_until_object_disappear $page_loadmask_message
				gen_wait_less
			else
				find($alloc_fixed_distribution_rule_name_picklist).click
				find($alloc_fixed_distribution_rule_name_picklist).set fixed_allocation_rule_name
				find($alloc_fixed_distribution_rule_name_picklist).click
				find($alloc_fixed_distribution_rule_name_picklist).set fixed_allocation_rule_name
				gen_tab_out $alloc_fixed_distribution_rule_name_picklist
				gen_wait_until_object_disappear $page_loadmask_message
				gen_wait_less
			end	
		end
	end
end

###
# Method Summary: Get the selected fixed allocation rule in the combobox
#
def Allocations.get_selected_fixed_allocation_rule
    return find($alloc_fixed_distribution_rule_name_picklist).value
end

###
# Method Summary: Get complete grid row by row number for Allocation Rule Table
#
# @param [Integer] row_number              Row Number of the grid[DEFAULT = 1]
#
def Allocations.get_fixed_distribution_grid_row row_number=1
    row_to_fetch = $alloc_fixed_distribution_grid_row.sub($sf_param_substitute,row_number.to_s)
    return find(row_to_fetch).text
end

##
#
# Method Summary : Returns the not distributed amount of fixed distribution screen
#
def Allocations.get_not_distributed_amount
	return find($alloc_fixed_distribution_not_distributed_amount).text
end

##
#
# Method Summary : Returns the distributed amount of fixed distribution screen
#
def Allocations.get_distributed_amount
	return find($alloc_fixed_distribution_distributed_amount).text
end

##
#
# Method Summary : Returns the percentage total of fixed distribution screen
#
def Allocations.get_fixed_distribution_total_percentage
	return find($alloc_fixed_distribution_total_percentage_field).text
end

##
#
# Method Summary : Returns the amount total of fixed distribution screen
#
def Allocations.get_fixed_distribution_total_amount
	return find($alloc_fixed_distribution_total_amount_field).text
end

# set General Ledger Account to transfer to.
def Allocations.set_gla_split row, gla_to
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOC_COLUMN_GLA})").click
	rescue
	end
	find($alloc_set_gla_to).set gla_to
	gen_tab_out $alloc_set_gla_to
end

# set Dimension1 in split table
def Allocations.set_dimension1_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_1})").click
	rescue
	end
	find($alloc_set_dimension1_split).set dimension
	gen_tab_out $alloc_set_dimension1_split
end

# set Dimension2 in split table
def Allocations.set_dimension2_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_2})").click
	rescue
	end
	find($alloc_set_dimension2_split).set dimension
	gen_tab_out $alloc_set_dimension2_split
end

# set Dimension3 in split table
def Allocations.set_dimension3_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_3})").click
	rescue
	end
	find($alloc_set_dimension3_split).set dimension
	gen_tab_out $alloc_set_dimension3_split
end

# set Dimension4 in split table
def Allocations.set_dimension4_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOC_COLUMN_DIMENSION_4})").click
	rescue
	end
	find($alloc_set_dimension4_split).set dimension
	gen_tab_out $alloc_set_dimension4_split
end

# set percentage split for each general ledger account.
def Allocations.set_percent_split row, percentage_split
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOC_COLUMN_PERCENTAGE})").click
	rescue
	end
	find($alloc_set_percentage_split).set percentage_split
	gen_tab_out $alloc_set_percentage_split
end

# Full line in one go (default fields)
def Allocations.set_split_all_in_one row, gen_ledger_to, percentage
	Allocations.set_split_line_gla row, gen_ledger_to
	Allocations.set_split_line_percentage row, percentage
end

def Allocations.assert_split_table_rows num
	rows = page.all($alloc_split_table_row)
	return (rows.count) == (num + 1)
end

def Allocations.assert_split_table_row_value num, value
	SF.execute_script do
		rows = page.all($alloc_split_table_row)
		return (rows[num - 1]).has_content?(value)
	end	
end

def Allocations.set_split_line_gla line, gla_value
	SF.execute_script do
		input_set = $alloc_split_line_gla_input.gsub($sf_param_substitute, line.to_s)
		object_visible = gen_is_object_visible input_set
		if (!object_visible)
			record_to_click = $alloc_split_line_gla.gsub($sf_param_substitute, line.to_s)		
			find(record_to_click).click
		end
		find(input_set).set gla_value
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		gen_tab_out input_set
	end
end

def Allocations.set_split_line_dimension1 line, dimension_value
	SF.execute_script do
		object_visible = gen_is_object_visible $alloc_split_line_dimension1_input
		if (!object_visible)
			record_to_click = $alloc_split_line_dimension1.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		find($alloc_split_line_dimension1_input).set dimension_value
		gen_wait_less
		gen_tab_out $alloc_split_line_dimension1_input
	end
end

def Allocations.set_split_line_dimension2 line, dimension_value
	SF.execute_script do
		object_visible = gen_is_object_visible $alloc_split_line_dimension2_input
		if (!object_visible)
			record_to_click = $alloc_split_line_dimension2.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		find($alloc_split_line_dimension2_input).set dimension_value
		gen_wait_less
		gen_tab_out $alloc_split_line_dimension2_input
	end
end

def Allocations.set_split_line_dimension3 line, dimension_value
	SF.execute_script do
		object_visible = gen_is_object_visible $alloc_split_line_dimension3_input
		if (!object_visible)
			record_to_click = $alloc_split_line_dimension3.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		find($alloc_split_line_dimension3_input).set dimension_value
		gen_wait_less
		gen_tab_out $alloc_split_line_dimension3_input
	end
end

def Allocations.set_split_line_dimension4 line, dimension_value
	SF.execute_script do
		object_visible = gen_is_object_visible $alloc_split_line_dimension4_input
		if (!object_visible)
			record_to_click = $alloc_split_line_dimension4.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		find($alloc_split_line_dimension4_input).set dimension_value
		gen_wait_less
		gen_tab_out $alloc_split_line_dimension4_input
	end
end

def Allocations.set_split_line_percentage line, percentage_value
	SF.execute_script do
		record_to_click = $alloc_split_line_percentage.gsub($sf_param_substitute, line.to_s)
		find(record_to_click).click
		find($alloc_split_line_percentage_input).set percentage_value
		gen_wait_less
		gen_tab_out $alloc_split_line_percentage_input
	end		
end

def Allocations.delete_split_line line
	SF.execute_script do
		record_to_click = $alloc_split_line_delete.gsub($sf_param_substitute, line.to_s)
		find(record_to_click).click
	end		
end 

##
#
# Method Summary : Method to perform spread evenly operation on distribution grid
#
def Allocations.click_spread_evenly_link
	SF.execute_script do
		find($alloc_distribution_percentage_column_header).hover
		find($alloc_distribution_percentage_menu_item_button).click
		find(:xpath, $alloc_distribution_percentage_column_menu_item_spread_evenly).click
	end
end

##### Save Rule pop up methods ############
##
# Method Summary: Method to set Rule name in save rule pop up
#
# @param [String] rule_name   Set rule name 
#
def Allocations.set_rule_name_in_pop_up rule_name
	SF.execute_script do
		find($alloc_save_rule_pop_up_rule_name).click
		find($alloc_save_rule_pop_up_rule_name).set rule_name
		gen_tab_out $alloc_save_rule_pop_up_rule_name
	end
end

##
# Method Summary: Method to set Rule description in save rule pop up
#
# @param [String] rule_description   Set rule description 
#
def Allocations.set_rule_description_in_pop_up rule_description
	SF.execute_script do
		find($alloc_save_rule_pop_up_rule_description).click
		find($alloc_save_rule_pop_up_rule_description).set rule_description
		gen_tab_out $alloc_save_rule_pop_up_rule_description
	end
end

##
#
# Method Summary : click on the save Allocation rule button 
#
def Allocations.click_on_save_allocation_rule_button
  SF.execute_script do
		find($alloc_save_fixed_allocation_rule_button).click
		gen_wait_until_object $alloc_save_rule_pop_up
	end
end

##
#
# Method Summary : click on the cancel button of save rule pop up
#
def Allocations.click_on_cancel_button_save_rule_pop_up
  SF.execute_script do
		find($alloc_save_rule_pop_up_cancel_button).click
	end
end

##
#
# Method Summary : click on the save button of save rule pop up
#
def Allocations.click_on_save_button_save_rule_pop_up
  SF.execute_script do
		find($alloc_save_rule_pop_up_save_button).click
		gen_wait_until_object_disappear $alloc_save_rule_pop_up
	end
end

##
#
# Method Summary : click on the cancel button of save rule pop up
#
def Allocations.click_on_create_allocation_popup_cancel_button
	gen_wait_until_object $alloc_create_allocation_popup_cancel_button
	find($alloc_create_allocation_popup_cancel_button).click
end

##
#
# Method Summary: Returns the count of Rule name matched
# 
# @param [String] rule_name_list to pass the list of rule names
#
def Allocations.get_matched_count_rule_names rule_name_list
	num_of_field_present_in_picklist = 0
	rule_name_list.each do |value|	
		find($alloc_fixed_distribution_rule_name_picklist).click
		gen_wait_less #list takes few seconds to load.
		find($alloc_fixed_distribution_rule_name_picklist).set(value)
		gen_wait_less
		find($alloc_fixed_distribution_rule_name_picklist).native.send_keys(:enter)
		gen_tab_out $alloc_fixed_distribution_rule_name_picklist
		gen_wait_until_object_disappear $page_loadmask_message
		picklist_filtered_value = find($alloc_fixed_distribution_rule_name_picklist).value
		if picklist_filtered_value.eql?(value)
			num_of_field_present_in_picklist+=1
			SF.log_info "value is present in picklist: "+value
		else	
			SF.log_info "Value is not present in picklist: "+ value
		end
	end
	return num_of_field_present_in_picklist
end

#### Statistical Distribution (Screen 4) methods #####

# click on preview button 
def	Allocations.click_statistical_distribution_page_preview_button
	find($alloc_statistical_distribution_preview_button).click
	gen_wait_until_object_disappear $page_loadmask_message
end

# Select Distribute to GLA radio button
def Allocations.select_distribute_to_gla_radio_button
	SF.execute_script do
		find($alloc_distribute_to_gla_radio_button).click
	end
end

# Select Copy Glas radio button
def Allocations.select_copy_glas_radio_button
	SF.execute_script do
		find($alloc_copy_glas_radio_button).click
	end
end

## Set glas in Distribute to Gla picklist
#
# Method - Summary : gla_names_list is an array of gla names which 
# user wants to set in Distribute to Gla picklist
#
def Allocations.set_glas_in_distribute_to_gla_picklist gla_names_list
	#find($alloc_distribute_to_gla_picklist).click
	Allocations.select_distribute_to_gla_radio_button
	gla_names_list.each do |gla_name|
		find($alloc_distribute_to_gla_picklist).set gla_name
		# wait for picklist to load
		gen_wait_until_object_disappear $page_loadmask_message
		find($alloc_distribute_to_gla_picklist).native.send_keys(:enter)
	end
	gen_tab_out $alloc_distribute_to_gla_picklist
end

## 
#  Method Summary- Assert the values in Distribute to GLA picklist
#
#  @param List<String>  expected_values       List of GLA Values that needs to be checked
#
def Allocations.assert_distribute_to_gla_selected_value expected_values
	gen_wait_for_enabled $alloc_statistical_distribution_preview_button
    rows = all($alloc_distribute_to_gla_picklist_selection)
    content = ''
    rows.each do |one_row|
        content += one_row.text + ' '            
    end
    expected_values.each do |one_row|
        if !(content.include? one_row)
            puts "Value not found: " + one_row
            puts "Existent Value: " + content
            return false
        end
    end
    return true
end

## Set value in Copy Glas picklist
#
# Method - Summary : picklist_option can be choosen from following
# $alloc_copy_glas_picklist_from_source_label
# $alloc_copy_glas_picklist_from_basis_label
#
def Allocations.set_copy_glas_picklist picklist_option
	Allocations.select_copy_glas_radio_button
	find($alloc_copy_glas_picklist).click
	find($alloc_copy_glas_picklist).set picklist_option
	# Picklist takes some time to load
	gen_wait_less
	find($alloc_copy_glas_picklist).native.send_keys(:enter)
	gen_tab_out $alloc_copy_glas_picklist
end

## Check if an option is present in Copy Glas picklist
#
# Method - Summary : option can be choosen from following
# $alloc_copy_glas_picklist_from_source_label
# $alloc_copy_glas_picklist_from_basis_label
#
def Allocations.assert_copy_glas_picklist_option_avaiable option
	find($alloc_copy_glas_picklist).native.send_keys(:arrow_down)
	picklist_option = $alloc_copy_glas_picklist_option.sub($sf_param_substitute, option.to_s)
	return page.has_xpath?(picklist_option)
end

## Get GLA value from Statistical Distribution table
#
# Method - Summary : mention row_number from which GLA
# value needs to be fetch
#
def Allocations.get_statistical_distribution_table_gla_value row_number
	gla_field = $alloc_statistical_distribution_table_gla_column_value.sub($sf_param_substitute, row_number.to_s)
	return find(gla_field).text
end

## Get Dim 1 value from Statistical Distribution table
#
# Method - Summary : mention row_number from which Dim 1
# value needs to be fetch
#
def Allocations.get_statistical_distribution_table_dim1_value row_number
	dim1_field = $alloc_statistical_distribution_table_dim1_column_value.sub($sf_param_substitute, row_number.to_s)
	return find(dim1_field).text
end

## Get Dim 2 value from Statistical Distribution table
#
# Method - Summary : mention row_number from which Dim 2
# value needs to be fetch
#
def Allocations.get_statistical_distribution_table_dim2_value row_number
	dim2_field = $alloc_statistical_distribution_table_dim2_column_value.sub($sf_param_substitute, row_number.to_s)
	return find(dim2_field).text
end

## Get Dim 3 value from Statistical Distribution table
#
# Method - Summary : mention row_number from which Dim 3
# value needs to be fetch
#
def Allocations.get_statistical_distribution_table_dim3_value row_number
	dim3_field = $alloc_statistical_distribution_table_dim3_column_value.sub($sf_param_substitute, row_number.to_s)
	return find(dim3_field).text
end

## Get Dim 4 value from Statistical Distribution table
#
# Method - Summary : mention row_number from which Dim 4
# value needs to be fetch
#
def Allocations.get_statistical_distribution_table_dim4_value row_number
	dim1_field = $alloc_statistical_distribution_table_dim4_column_value.sub($sf_param_substitute, row_number.to_s)
	return find(dim4_field).text
end

## Get Percentage value from Statistical Distribution table
#
# Method - Summary : mention row_number from which Percentage
# value needs to be fetch
#
def Allocations.get_statistical_distribution_table_percentage_value row_number
	percentage_field = $alloc_statistical_distribution_table_percentage_column_value.sub($sf_param_substitute, row_number.to_s)
	return find(percentage_field).text
end

## Get Amount value from Statistical Distribution table
#
# Method - Summary : mention row_number from which Amount
# value needs to be fetch
#
def Allocations.get_statistical_distribution_table_amount_value row_number
	amount_field = $alloc_statistical_distribution_table_amount_column_value.sub($sf_param_substitute, row_number.to_s)
	return find(amount_field).text
end
## Get all column values of a row of Statistical Distribution table
#
def Allocations.get_statistical_distribution_grid_row row_number=1
	row_to_fetch = $alloc_statistical_distribution_grid_row.sub($sf_param_substitute,row_number.to_s)
	return find(row_to_fetch).text
end
## Compare value in a row of Statistical Distribution table
#
# Method - Summary : expected_row_content is an array having value as follows
# [Expected Gla, Expected Dim 1, Expected Dim 2, Expected Dim 3, Expected Dim 4, Expected Percentage, Expected Amount]
# for ex: 
# ["Gla1", "East", "Norvay", "Software", "sales", "43", "142.56"]
# ["Gla1", "", "", "", "", "23", "67.34"]
#
def Allocations.compare_statistical_distribution_table_row row_number, expected_row_content
	all_columns = all($alloc_statistical_distribution_table_row.sub($sf_param_substitute, row_number.to_s))
	content_matched = true
	if all_columns.size == expected_row_content.size
		counter = 0
		all_columns.each do |column|
			if expected_row_content[counter] == column.text
				next
			else
				puts "Expected - #{expected_row_content[counter]} | Got - #{column.text}"
				content_matched = false
				break
			end	
			counter = counter + 1
		end
		return content_matched
	else	
		puts "Expected row content do not have same number of elements as shown in the grid."
		return false
	end	
end

# Get Statistical Distribution table Total percentage
def Allocations.get_statistical_distribution_table_total_percentage
	total_string = find($alloc_statistical_distribution_table_total_percentage).text
	percentage_value = total_string.split("%")[0]
	return percentage_value
end

# Get Statistical Distribution table Total Amount
def Allocations.get_statistical_distribution_table_total_amount
	return find($alloc_statistical_distribution_table_total_amount).text
end

## Statistical basis Configuration (Screen 3) Methods ##

# Method Summary: Select the Variable Rule Name from the list.
#
# @param [String] rule_name          Name of the Variable Rule to select.
#
def Allocations.select_variable_rule_name rule_name
    SF.execute_script do
		find(:xpath,$alloc_variable_distribution_rule_name_picklist).click
		find($alloc_variable_distribution_rule_name_input).set rule_name
		gen_tab_out $alloc_variable_distribution_rule_name_input
		gen_wait_until_object_disappear $page_loadmask_message
	end
end

# Method Summary: Get the selected Variable Rule Name 
#
#
def Allocations.get_variable_rule_name
	return find($alloc_variable_distribution_rule_name_input).value
end

# Method Summary: Select the Statistical Bases from the list.
#
# @param [String] bases_name          Name of the Statistical Bases to select.
#
def Allocations.select_statistical_bases bases_name
	SF.execute_script do
		find($alloc_variable_statistical_bases_input).click
		find($alloc_variable_statistical_bases_input).set bases_name
		gen_tab_out $alloc_variable_statistical_bases_input
	end
end

# Method Summary: Get the Statistical Bases from the list.
#
#
def Allocations.get_statistical_bases
	return find($alloc_variable_statistical_bases_input).value
end

###
# Method Summary: Select the Distribution Field from the list.
#
# @param [List<String>] field_names          List of the Distribution Field to select.
#
def Allocations.select_distribution_fields field_names
	field_names.each do |field_name|
		find($alloc_variable_distribution_field_input).set field_name
		gen_tab_out $alloc_variable_distribution_field_input
	end
end

###
# Method Summary: Remove the Field from the distibution list.
#
# @param [String] field_name          Name of the Distribution Field to remove.
#
def Allocations.remove_distribution_field field_name
	distribution_field_selected = $alloc_variable_distribution_field_selected.sub($sf_param_substitute, field_name)
	object_visible = gen_is_object_visible distribution_field_selected
	if (object_visible)
		close_distribution_field_icon = distribution_field_selected + '/following-sibling::div'
		find(:xpath,close_distribution_field_icon).click
	end
end

###
# Method Summary: Assert the Field in the distibution field list.
#
# @param [String] field_name          Field Name to be asserted in Distribution Field
#
def Allocations.is_distribution_field_selected? field_name
    distribution_field_selected = $alloc_variable_distribution_field_selected.sub($sf_param_substitute, field_name)
    object_visible = gen_is_object_visible distribution_field_selected
    return object_visible
end

###
# Method Summary: Click the Add Statistical Bases button
#
def Allocations.click_add_statistical_bases_button
    find($alloc_variable_distribution_add_statistical_bases_button).click
end

## Screen 3 Statistical basis Configuration Grid Section Methods ##

###
# Method Summary: Search the Grid of the Allocation Rule by entering the input and clicking search icon
#
# @param [Integer] input_value          	Input to search in the grid
#
def Allocations.search_grid input_value
	find($alloc_variable_distribution_filter_search_input).set input_value
	find(:xpath,$alloc_variable_distribution_filter_search_icon).click
end
###
# Method Summary: Get the total percentage on the grid toolbar of Allocation Rule Page
#
def Allocations.get_statistical_configuration_page_total_percentage
	total_string = find($alloc_variable_distribution_grid_total_percentage).text
	percentage_value = total_string.split("%")[0]
	return percentage_value
end

###
# Method Summary: Get the total value on the grid toolbar of Allocation Rule Page
#
def Allocations.get_statistical_configuration_page_grid_total_value
	return find($alloc_variable_distribution_grid_total_value).text
end

###
# Method Summary: Get the grid row value for the particular column for fixed type in the Allocation Rule View Page
#
# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
# @param [Integer] column_number        Column Number of the grid. Use Constants like ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN[DEFAULT = 1]
#
def Allocations.get_grid_row_value_by_column_view_page row_number=1,column_number=1 
	row_selector = $alloc_variable_distribution_rowcolumn_pattern_view_page.sub($sf_param_substitute,row_number.to_s)
	column_selector = row_selector.sub($sf_param_substitute,column_number.to_s)
	return find(column_selector).text
end


###
# Method Summary: Get complete grid row by row number for Allocation Rule Table
#
# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
#
def Allocations.get_allocation_rule_grid_row row_number=1
	row_to_fetch = $alloc_variable_distribution_grid_row.sub($sf_param_substitute,row_number.to_s)
	return find(row_to_fetch).text
end

###
# Method Summary: Get Number of grid rows
#
# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
#
def Allocations.get_count_of_grid_rows
	gen_wait_until_object $alloc_variable_distribution_grid_rows
	row_size = page.all($alloc_variable_distribution_grid_rows)
    return row_size.count
end


## Screen 3 Buttons methods ##

###
# Method Summary: Click the save button on Allocation Rule page
#
def Allocations.click_variable_distribution_save_button
	find($alloc_variable_distribution_save_button).click
	gen_wait_until_object_disappear $page_loadmask_message
	gen_wait_less
end

###
# Method Summary: Click on Preview button on Statistical Basis Configuration Page
#
def Allocations.click_statistical_basis_configuration_page_preview_button
	find($alloc_variable_distribution_filter_preview_button).hover
	gen_wait_less
	find($alloc_variable_distribution_filter_preview_button).click
	gen_wait_until_object_disappear $page_loadmask_message
end

###
# Method Summary: Click the clear all button on Allocation Rule page
#
def Allocations.click_clear_all_button
	find($alloc_variable_distribution_clear_all_button).click
end



## Screen 3 Popup Methods ##

###
# Method Summary: Get error mesaage on popup
#
def Allocations.get_error_message
	within($alloc_variable_distribution_message_box) do
		return find($alloc_variable_distribution_message_text).text
	end
end

###
# Method Summary: Click the Continue Button on the error message popup
#
def Allocations.click_continue_button_on_popup
	within($alloc_variable_distribution_message_box) do
		find($alloc_variable_distribution_back_popup_yes_button).click
	end
end

###
# Method Summary: Click the No Button on the error message popup
#
def Allocations.click_no_button_on_popup
    within($alloc_variable_distribution_message_box) do
        find($alloc_variable_distribution_back_popup_no_button).click
    end
end

## Toast Message Box Methods ##

###
# Method Summary: Get toast message
#
def Allocations.get_toast_message
	gen_wait_until_object $alloc_toast_message_box
	within($alloc_toast_message_box) do
	        return find($alloc_toast_message).text
	end
end

###
# Method Summary: Click the Undo Button on the toast message box
#
def Allocations.click_undo_button_on_toast_message_box
    within($alloc_toast_message_box) do
		find($alloc_variable_distribution_toast_message_undo_button).click
	end
end

###
# Method Summary: Click the Close Button on the toast message box
#
def Allocations.click_close_button_on_toast_message_box
	within($alloc_variable_distribution_toast_message_box) do
		find($alloc_variable_distribution_toast_message_close_button).click
		gen_wait_until_disappear $alloc_variable_distribution_toast_message_box
	end
end

####################Post Screen Methods############################
##
#
# Method Summary: Click the post button
#
def Allocations.click_on_post_button
	SF.execute_script do
		find($alloc_post_button).click
	end
	gen_wait_until_object_disappear $ffa_msg_loading
end

##
#
# Method Summary: Set destination company in posting details section
#
# @param [String] company_name     Select company name to set in company picklist field
#
def Allocations.set_destination_company_value company_name
	SF.execute_script do
		find($alloc_destination_company_field).click
		find($alloc_destination_company_field).set company_name
		gen_tab_out $alloc_destination_company_field
	end
end

##
#
# Method Summary: Set destination company period in posting details section
#
# @param [String] destination_company_period     Select periods in Period picklist populated on the basis of selected destination company.
#
def Allocations.set_destination_period_value destination_company_period
	SF.execute_script do
		find($alloc_destination_company_period_field).click
		find($alloc_destination_company_period_field).set destination_company_period
		gen_tab_out $alloc_destination_company_period_field
	end
end

##
#
# Method Summary: Set destination document description in posting details section
#
# @param [String] destination_document_description     Set description in posting details section
#
def Allocations.set_destination_document_description destination_document_description
	SF.execute_script do
		find($alloc_posting_description_field).set destination_document_description
		gen_tab_out $alloc_posting_description_field		
	end
end

##
#
# Method Summary: Get destination document description in posting details section
#
def Allocations.get_destination_document_description
    return find($alloc_posting_description_field).value
end

##
#
# Method Summary: Set destination document date in posting details section
#
# @param [String] destination_document_date     Set date in posting details section
#
def Allocations.set_destination_date_value destination_document_date
	SF.execute_script do
		find($alloc_posting_date_field).click
		find($alloc_posting_date_field).set destination_document_date
		gen_tab_out $alloc_posting_date_field
	end
end

##
#
# Method Summary: Set destination document type in posting details section
#
# @param [String] destination_document_type     Set values in create picklist of posting details section
# values can be : Transactions, Journals
#
def Allocations.set_destination_document_type_value destination_document_type
	SF.execute_script do
		find($alloc_destination_type_name_field).click
		find($alloc_destination_type_name_field).set destination_document_type
		gen_tab_out $alloc_destination_type_name_field
	end
end

##
#
# Method Summary: Get destination document description in posting details section
#
def Allocations.get_destination_document_type
    return find($alloc_destination_type_name_field).value
end

##
#
# Method Summary : click on view transaction button of pop up
#
def Allocations.click_view_transaction_popup_button
	SF.execute_script do
		find($alloc_successful_popup_view_transaction_button).click
		SF.wait_for_search_button
	end	
end

##
#
# Method Summary : Method to assert destination document date
#
def Allocations.assert_destination_document_date date
	date_field = find($alloc_posting_date_field)
	return date_field['value'] == date
end

##
#
# Method Summary : Method to assert destination document period
#
def Allocations.assert_destination_document_period period
	period_field = find($alloc_destination_company_period_field)
	return period_field['value'] == period
end

def Allocations.assert_create_popup_lines_preview expected_lines
	found_lines = find($alloc_posting_transaction_lines_preview).text

	expected_lines.each do |one_expected_line|
		if !found_lines.include? one_expected_line
			puts "Row not found: " + one_expected_line
			puts "Existent rows: " + found_lines
			return false
		end
	end
	return true
end

def Allocations.click_posting_transaction_lines_preview_panel
	find($alloc_posting_transaction_lines_preview).click
end

##
#
# Method Summary : Method to get the toast messages displayed on Allocation retrieve source UI
#
def Allocations.get_toast_message_retrieve
	return find($alloc_toast_panel).text
end

##
#
# Method Summary: Assert companies in multi-company mode allocation
#
# @param [String] company_list    Select destination company where destination document to be posted
#
def Allocations.assert_available_companies company_list
	find($alloc_destination_company_field).click
	found_company_list = find($alloc_boundlist_container).text
	company_list.each do |one_company|
		if(!found_company_list.include? one_company)
			return false
		end
	end
	return true
end

##
#
# Method Summary: Method to expand accordion pane create Allocation/preview section on post screen
#
def Allocations.click_on_accordion_panel_expand_button
	SF.execute_script do
		find($alloc_accordion_panel_expand_icon).click
	end
end

##
#
# Method Summary: Method to collapse accordion pane create Allocation/preview section on post screen
#
def Allocations.click_on_accordion_panel_collapse_button
	SF.execute_script do
		find($alloc_accordion_panel_collapse_icon).click
	end
end

##
#
# Method Summary: Method to click on expand/collapse icon of source section
#
def Allocations.click_on_source_section_expand_collapse_button
	SF.execute_script do
		find($alloc_source_section_expand_collapse_icon).click
	end
end

##
#
# Method Summary: Method to click on expand/collapse icon of distribution section
#
def Allocations.click_on_distribution_section_expand_collapse_button
	SF.execute_script do
		gen_scroll_to $alloc_distribution_section_expand_collapse_icon
		find($alloc_distribution_section_expand_collapse_icon).click
	end
end

##
#
# Method Summary: Get complete grid row by row number from preview table 
#
# @param [Integer] row_number          	Row Number of the grid[DEFAULT = 1]
#
def Allocations.get_allocation_preview_grid_row row_number=1
	row_to_fetch = $alloc_total_retrieved_and_distributed_rows.sub($sf_param_substitute,row_number.to_s)
	return find(row_to_fetch).text
end
## Wizard Methods ##
# For below methods choose step_locator from following
# $alloc_wizard_retrieve_source = "li[data-ffid='Retrieve Source']"
# $alloc_wizard_allocation_method = "li[data-ffid='Allocation Method']"
# $alloc_wizard_configure_basis = "li[data-ffid='Configure Basis']"
# $alloc_wizard_distribute = "li[data-ffid='Distribute']"
# $alloc_wizard_post = "li[data-ffid='Post']"
##

###
# Method Summary: Check if the Wizard step is selected (current) step or not
# For step_locator - see comment just below the Wizard Methods
#
def Allocations.is_selected_wizard_step? step_locator
	li_classes = find(step_locator)[:class]
	button_classes = find(step_locator + " button")[:class]
	span_classes = find(step_locator + " button span", :visible => false)[:class]
	if (li_classes.include? "f-is-selected")
		return true
	else
		return false
	end
end

###
# Method Summary: Check if the Wizard step is completed step or not
# For step_locator - see comment just below the Wizard Methods
#
def Allocations.is_complete_wizard_step? step_locator
	li_classes = find(step_locator)[:class]
	button_classes = find(step_locator + " button")[:class]
	span_classes = find(step_locator + " span", :visible => false)[:class]
	if (li_classes.include? "f-is-completed") and !(li_classes.include? "f-is-selected") and (button_classes.include? "f-has-icon") and (span_classes.include? "ffdc-icon-submit") and !(span_classes.include? "ffdc-icon-warning")
		return true
	else
		return false
	end
end
###
# Method Summary: Check if the Wizard step is partial complete step or not
# For step_locator - see comment just below the Wizard Methods
#
def Allocations.is_partial_complete_wizard_step? step_locator
	li_classes = find(step_locator)[:class]
	button_classes = find(step_locator + " button")[:class]
	span_classes = find(step_locator + " span", :visible => false)[:class]
	if (li_classes.include? "f-is-completed") and !(li_classes.include? "f-is-selected") and (button_classes.include? "f-has-icon") and !(span_classes.include? "ffdc-icon-submit") and (span_classes.include? "ffdc-icon-warning")
		return true
	else
		return false
	end
end
###
# Method Summary: Check if the Wizard step is inactive step or not
# For step_locator - see comment just below the Wizard Methods
#
def Allocations.is_inactive_wizard_step? step_locator
	li_classes = find(step_locator)[:class]
	button_classes = find(step_locator + " button")[:class]
	span_classes = find(step_locator + " button span", :visible => false)[:class]
	if !(li_classes.include? "f-is-completed") and !(button_classes.include? "f-has-icon") and !(span_classes.include? "ffdc-icon-submit") and !(span_classes.include? "ffdc-icon-warning")
		return true
	else
		return false
	end
end

###
# Method Summary: Click on the Wizard step mentioned by step_locator
# For step_locator - see comment just below the Wizard Methods
#
def Allocations.click_wizard_step step_locator
	find(step_locator + " button").click
end

###
# Method Summary: Check if Configure Bais Wizard step is visible or not
#
def Allocations.is_configure_basis_wizard_step_visible?
	styles = find($alloc_wizard_configure_basis, :visible => false)[:style]
	if !(styles.include? "display: none;")
	return true
	else
	return false
	end
end

## Preview Panel Methods##
# Chose section_label from the following
#$alloc_preview_panel_allocation_method_label = "Allocation Method"
#$alloc_preview_panel_statistical_value_label = "Statistical Basis"
#$alloc_preview_panel_distribute_to_glas_label = "Distribute to GLAs"
#$alloc_preview_panel_company_label = "Company"
#$alloc_preview_panel_date_label = "Date"
#$alloc_preview_panel_period_label = "Period"
#

###
# Method Summary: Check if a section available or not in the preview panel.
# see above comment section below the comment Preview Panel Methods for section_label values
#
def Allocations.is_preview_panel_section_displayed? section_label
	section_locator = $alloc_preview_panel_section_label.sub($sf_param_substitute,section_label.to_s)
	return page.has_xpath? (section_locator) 
end
###
# Method Summary: get section value from preview panel. 
# see above comment section below the comment Preview Panel Methods for section_label values
#
def Allocations.get_preview_panel_section_value section_label
	if is_preview_panel_section_displayed?(section_label)
		section_value_selector = $alloc_preview_panel_section_value.sub($sf_param_substitute,section_label.to_s)
		return find(:xpath, section_value_selector).text
	else
		raise "Preview Panel Section - #{section_label} not being displayed in Preview Panel."
	end	
end

## Statistical Basis Configuration (screen 3) Filter Section ##
###
# Method Summary: Click Clear All Filter button
#
def Allocations.click_clear_all_filter_button
	find($alloc_statistical_basis_config_filter_clear_all_button).click
end

###
# Method Summary: Click Show filter button on Filter Section of Variable Allocation Rule Page
#
def Allocations.click_show_filter_button
	find(:xpath,$alloc_statistical_basis_config_filter_show_filter_button).click
end

###
# Method Summary: Click Hide filter button on Filter Section of Variable Allocation Rule Page
#
def Allocations.click_hide_filter_button
	find(:xpath,$alloc_statistical_basis_config_filter_hide_filter_button).click
end

###
# Method Summary: Click Add Filter button to add a new filter
#
def Allocations.click_add_filter_button
	find($alloc_statistical_basis_config_filter_add_filter_button).click
end

###
# Method Summary: Click delete filter button next to the filter selected
# @param [Integer] row_num                Row Number of the filter to delete
#
def Allocations.click_delete_filter_icon row_num
	element_to_click = $alloc_statistical_basis_config_filter_close_button.sub($sf_param_substitute,row_num.to_s)
	find(element_to_click).click
end

###
# Method Summary: Set the filter field for the particular row
# @param [String]  field                  Field for which filter needs to be applied
# @param [Integer] row_num                Filter row number where field needs to be set
#
def Allocations.set_filter_field field,row_num
	element_to_click = $alloc_statistical_basis_config_filter_field_input.sub($sf_param_substitute,row_num.to_s)
	find(element_to_click).click
    find(element_to_click).set field
	gen_tab_out element_to_click
end

###
# Method Summary: Set the filter operator for the particular row
# @param [String]  operator               Operator to be applied on filter
# @param [Integer] row_num                Filter row number where operator needs to be set
#
def Allocations.set_filter_operator operator,row_num
	element_to_click = $alloc_statistical_basis_config_filter_operator_input.sub($sf_param_substitute,row_num.to_s)
	find(element_to_click).click
    find(element_to_click).set operator
    gen_tab_out element_to_click
end

###
# Method Summary: Set the filter value for the particular row
# @param [String]  value                  Operator to be set on filter
# @param [Integer] row_num                Filter row number where field needs to be set
#
def Allocations.set_filter_value value,row_num
	element_to_click = $alloc_statistical_basis_config_filter_value_input.sub($sf_param_substitute,row_num.to_s)
	find(element_to_click).click
    find(element_to_click).set value
    gen_tab_out element_to_click
end

###
# Method Summary: Get the filter count displayed in Filter Selected box
#
def Allocations.get_displayed_filter_count
	return find($alloc_statistical_basis_config_filter_selected_count).text
end

###
# Method Summary: Get the filter count
#
def Allocations.get_filter_count
	row_size = page.all($alloc_statistical_basis_config_filter_rows)
	return row_size.count
end

###
# Method Summary: Set the filter field, operator and value for the particular row
# @param [String]  field                   Field for which filter needs to be applied
# @param [String]  operator                Operator to be applied on filter
# @param [String]  value                   Value to be filtered
# @param [Integer] row_num                 Filter row number to be provided[DEFAULT = 1]
#
def Allocations.set_filter_values field,operator,value,row_num=1
	if(field != nil)
		Allocations.set_filter_field field,row_num
	end
	if(operator != nil)
		Allocations.set_filter_operator operator,row_num
	end
	if(value != nil)
		Allocations.set_filter_value value,row_num
	end
end

## Allocations Detail Screen Methods ##

## Compare a row in summary table on Allocation detail page
#
# Method - Summary : compare whole row having all columns value in an array as follows
# [Expected Transaction/Journal, Expected Home Debits, Expected Home Credits, Expected Dual Debits, Expected Dual Credits]
# for ex: 
# ["TRN", "311.75", "311.75", "423.23", "423.23"]
def Allocations.get_allocation_detail_page_transaction_summary_table_row row_number
	row_to_fetch = $alloc_detail_page_transactions_summary_table_row.sub($sf_param_substitute, row_number.to_s)
	fetched_row_text = find(row_to_fetch).text
	fetched_row_text_array = fetched_row_text.split(" ")
	if fetched_row_text_array[0].include? "TRN"
		fetched_row_text_array[0] = "TRN"
	end
	return fetched_row_text_array
end

#get allocation Name
def	Allocations.get_allocation_detail_page_allocation_name
	return find(:xpath,$alloc_detail_page_allocation_name_field).text
end

#get allocation method name
def	Allocations.get_allocation_detail_page_allocation_method
	return find(:xpath,$alloc_detail_page_allocation_method_field).text
end

#get allocation description
def	Allocations.get_allocation_detail_page_description
	return find(:xpath,$alloc_detail_page_description_field).text
end

#get allocation Output
def	Allocations.get_allocation_detail_page_output
	return find(:xpath,$alloc_detail_page_output_field).text
end

#get allocation company
def	Allocations.get_allocation_detail_page_company_value
	return find($alloc_detail_page_company_field).text
end

#get allocation Posting data
def	Allocations.get_allocation_detail_page_posting_date
	return find(:xpath,$alloc_detail_page_posting_date_field).text
end

#get allocation Posting period
def	Allocations.get_allocation_detail_page_posting_period
	return find(:xpath,$alloc_detail_page_posting_period_field).text
end

def	Allocations.get_allocation_detail_page_created_by_value
	return find($alloc_detail_page_created_by_field).value
end

def	Allocations.get_allocation_detail_page_created_date_value
	return find($alloc_detail_page_created_date_field).value
end

def Allocations.click_allocations_list_button
	find($alloc_detail_page_allocations_list_button).click
end

def Allocations.allocation_detail_page_click_transaction_link row_number
	transaction_link = $alloc_detail_page_transactions_summary_table_row.sub($sf_param_substitute,row_number.to_s)
	transaction_link = transaction_link.sub(") tr", ") td:nth-of-type(1) a")
	find(transaction_link).click
end

def	Allocations.get_transaction_field_value field_name, is_field_value_a_lookup
	field = $alloc_transaction_field.sub($sf_param_substitute, field_name)
		if is_field_value_a_lookup == true
			field = field +"/a"
		end
	return find(:xpath, field).text
end

def Allocations.wait_for_list_view
	gen_wait_for_text $alloc_label_allocation_name
end

def Allocations.go_to_allocation_from_list_view row_number
	column_number = gen_get_column_number_in_grid $alloc_label_allocation_name
	allocation_link = $page_grid_row_pattern.sub($sf_param_substitute, row_number.to_s).sub($sf_param_substitute, column_number.to_s)+" a"
	find(allocation_link).click
	gen_wait_until_object_disappear $page_loadmask_message
end

############# Template Methods#############
###
# Method Summary: Method to click Load template button on Allocations UI
# 
def Allocations.load_template
    SF.execute_script do
        find($alloc_template_load).click
        gen_wait_until_object_disappear $page_loadmask_message
    end
end

###
# Method Summary: Method to click Save template button on Allocations UI
# 
def Allocations.save_template
    find($alloc_template_save).click
end

###
# Method Summary: Set the template name on template picklist on Allocations UI
# @param [String]  template          Name of the Template
#
def Allocations.set_template template
    SF.execute_script do
        find($alloc_template_select).click
        find($alloc_template_select).set(template)
        gen_tab_out $alloc_template_select
    end
end

###
# Method Summary: Click the Save button on Save Template Popup
#
def Allocations.popup_save_template
	SF.retry_script_block do
		find($alloc_template_save_popup_save_button).click
		sleep 5
	end
end

###
# Method Summary: Click the Cancel button on Save Template Popup
#
def Allocations.popup_cancel_template
    find($alloc_template_save_popup_cancel_button).click
end

###
# Method Summary: Set the template name on Save template Popup
# @param [String]  template_name          Name of the Template
#
def Allocations.set_popup_template_name template_name
    within(find($alloc_template_save_popup)) do
        find($alloc_template_save_popup_name).set(template_name)
    end
end

###
# Method Summary: Set the template description on Save template Popup
# @param [String]  template_description          Description of the Template
#
def Allocations.set_popup_template_description template_description
    within(find($alloc_template_save_popup)) do
        find($alloc_template_save_popup_description).set(template_description)
    end
end

###
# Method Summary: Get the template name from the Save template Popup Name field
#
def Allocations.get_popup_template_name
    within(find($alloc_template_save_popup)) do
        return find($alloc_template_save_popup_name).value
    end
end

###
# Method Summary: Get the template description from the Save template Popup Description field
#
def Allocations.get_popup_template_description
    within(find($alloc_template_save_popup)) do
        return find($alloc_template_save_popup_description).text
    end
end

###
# Method Summary: Get the information message from the Save template Popup
#
def Allocations.get_popup_template_message
    within(find($alloc_template_save_popup)) do
        return find($alloc_template_save_popup_message_box).text
    end
end

##
#
# Method Summary: Method to set values in a filter group set
#
# @param [Integer] position Set Filter set position
# @param [String] type Set object name which includes Company, Period, GLA, Dimension 1, Dimension 2, Dimension 3, Dimension 4
# @param [String] criteria Select criteria name which includes Equals, Multiselect, From, To
# @param [String] value Set value for the object type and criteria selected
#
def Allocations.set_filterset_field_value position, type, criteria, value
	filter_set = $alloc_retrieve_source_filter_group.sub($sf_param_substitute,(position+1).to_s)
	gen_wait_until_object filter_set
	filter_set_element = find(filter_set)
	filter_set_element.click
	selector = build_filterset_field_selector type, '', criteria
	within(filter_set_element) do
		find(selector).click
		find(selector + ' input').set(value)
		## Results list takes a bit to get filtered.
		## This sleep will avoid double results.
		sleep 5
		find(selector + ' input').native.send_keys(:tab)
	end
	gen_wait_until_object_disappear $page_loadmask_message
end
##
#
# Method Summary: Method to click on new button from list view
# This method is added to wait until Loding icon is disappeared from screen
#
def Allocations.allocation_list_view_click_new_button
	SF.click_button_new
	gen_wait_until_object_disappear $ffa_msg_loading
	gen_wait_less
end

###
# Method Summary: Click the toggle expand/collapse button on Allocations page
#
def Allocations.click_toggle_button
	find($alloc_toggle_button).click
end

def Allocations.compare_statistical_basis_config_grid_rows rows
	all_rows = page.all($alloc_variable_distribution_grid_rows + " tr")
	index = 0
	rows_array = Array.new
	all_rows_matched = true
	all_rows.each do |row|
		rows_array[index] = row.text
		index += 1
	end
	rows.each do |row|
		if !(rows_array.include? row)
			all_rows_matched = false
			puts "No row contains - #{row}, present rows are - #{rows_array}"
			return all_rows_matched
		end	
	end
	return all_rows_matched
end

def Allocations.compare_statistical_basis_distribution_grid_rows rows
	all_rows = page.all($alloc_statistical_distribution_grid_rows)
	index = 0
	rows_array = Array.new
	all_rows_matched = true
	all_rows.each do |row|
		rows_array[index] = row.text
		index += 1
	end
	rows.each do |row|
		if !(rows_array.include? row)
			all_rows_matched = false
			puts "No row contains - #{row}, present rows are - #{rows_array}"
			return all_rows_matched
		end	
	end
	return all_rows_matched
end

#assert preview panel rows and check for existence , Method can be used if lines are unique , 
#if lines are not unique use method Allocations.get_allocation_preview_grid_row(index)
def Allocations.assert_preview_panel_distributed_rows? expected_lines
		line_found = false
		expected_lines.each do |one_expected_line|
		    line_found = false
			for index in 1..expected_lines.size
				if one_expected_line == Allocations.get_allocation_preview_grid_row(index)
					line_found = true
					SF.log_info "Preview Panel row #{one_expected_line} exists"
					break;
				end
			end
			if line_found == false
				#print all line grid line for debug purpose 
				for index in 1..expected_lines.size
					SF.log_info Allocations.get_allocation_preview_grid_row(index)
				end
				SF.log_info "element "+one_expected_line+ " not found ";
				raise "element "+one_expected_line+ " not found ";
			end
		end
		return line_found		
	end
end
