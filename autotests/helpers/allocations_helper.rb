# FinancialForce.com, inc. claims copyright in this software, its screen display designs and
# supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
# Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
# result in criminal or other legal proceedings.
# Copyright FinancialForce.com, inc. All rights reserved.

ALLOCATIONS_COLUMN_DELETE = 1
ALLOCATIONS_COLUMN_GLA = 2 
ALLOCATIONS_COLUMN_DIMENSION_1 = 3 
ALLOCATIONS_COLUMN_DIMENSION_2 = 4
ALLOCATIONS_COLUMN_DIMENSION_3 = 5
ALLOCATIONS_COLUMN_DIMENSION_4 = 6
ALLOCATIONS_COLUMN_PERCENTAGE = 7
ALLOCATIONS_COLUMN_AMOUNT = 8

module Allocations
extend Capybara::DSL

#############################
# Allocations               #
#############################
$alloc_no_dimesion = '-- No Dimension --'
$alloc_retrieve_column_transaction = 'Transaction'

##################################################
# Selectors
##################################################
## Allocation filters header selectors ##

$alloc_values_retrived_field = "div[data-ffid='valueRetrieved'] div[class*= 'ALLOC-display-value-default']"
$alloc_total_field = "div[data-ffid='total'] div[class*= 'ALLOC-display-value-default']"
$alloc_allocation_type = "div[data-ffid='allocationType'] input"
$alloc_only_ict_checkbox_label = "div[data-ffid='onlyICTFilter'] label"
$alloc_only_ict_checkbox = "div[data-ffid='onlyICTFilter'] input"
$alloc_only_ict_checkbox_disabled = "div[class*='f-form-item-no-label'][data-ffid='onlyICTFilter']"
$alloc_only_ict_checkbox_enabled = "div[class*='f-form-dirty'][data-ffid='onlyICTFilter']"
$alloc_timeperiod_selection_field = "input[name ='DateRangeTypeString']"
$alloc_from_period_field = "input[name='FromPeriodId']"
$alloc_to_period_field = "input[name='ToPeriodId']"
$alloc_from_date_field = "input[name='FromDateString']"
$alloc_to_date_field = "input[name='ToDateString']"
$alloc_soft_date_field = "input[name = 'SoftDateRangeTypeString']"
$alloc_soft_period_field = "input[name = 'SoftPeriodRangeTypeString']"
$alloc_n_value_user_input_field = "input[name='NValue']"

## Allocation filter group field selectors ##
$alloc_filter_set_company = "div[data-ffid='filterFieldcodaCompany__c1Equals'] input"
$alloc_filter_set_gla = "div[data-ffid='filterFieldcodaGeneralLedgerAccount__cMultiselect'] div[data-ref='listWrapper'] input"
$alloc_filter_set_dimension1 = "div[data-ffid='filterFieldcodaDimension1__c1Multiselect'] div[data-ref='listWrapper'] input"
$alloc_filter_set_dimension2 = "div[data-ffid='filterFieldcodaDimension2__c1Multiselect'] div[data-ref='listWrapper'] input"
$alloc_filter_set_dimension3 = "div[data-ffid='filterFieldcodaDimension3__c1Multiselect'] div[data-ref='listWrapper'] input"
$alloc_filter_set_dimension4 = "div[data-ffid='filterFieldcodaDimension4__c1Multiselect'] div[data-ref='listWrapper'] input"
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
$alloc_source_selection_pop_up = "div[data-ffid='sourceSelectionPopup']"
$alloc_source_selection_pop_up_filters_selected_field = "div[data-ffid='filterSelected'] div[class*= 'ALLOC-source-selection-display-value-default']"

#######old labels#########
$alloc_date_from_input = "table[data-ffid='dateFrom'] input"
$alloc_date_to_input = "table[data-ffid='dateTo'] input"
$alloc_filter_set = "div.test-filterSet"
$alloc_filter_set_field = "filterField"
$alloc_filter_set_add_button = "a[data-ffid='addFilterButton']"
$alloc_only_ict_checkbox_unmanage = "//label[text()='Only Intercompany Transactions']//ancestor::div[1]/span"
$alloc_only_ict_checkbox_manage = "//label[text()='Only Intercompany Transactions']//ancestor::div[1]/input"
$alloc_period_from_input = "table[data-ffid='periodFrom']"
$alloc_period_to_input = "table[data-ffid='ToPeriodId'] input"
$alloc_radio_select_date = "table[class*='selectDateRadio']"
$alloc_radio_select_period = "table[class*='selectPeriodRadio']"
$alloc_multiselect_label = "//*[text()='Multi-select']"
$alloc_from_to_label = "//*[text()='From-To']"

## Allocation filter button selectors ##
$alloc_add_source_button = "a[data-ffid='addSource']"
$alloc_change_button = "a[data-ffid='change']"
$alloc_source_selection_pop_up_cancel_button = "a[data-ffid='cancelButton']"
$alloc_source_selection_pop_up_retrieve_button = "a[data-ffid='retrieveDataButton']"
$alloc_source_selection_pop_up_clear_All_button = "a[data-ffid ='clearAllButton']"
$alloc_source_selection_pop_up_clear_group_button = "div[data-ffid = 'clearGroup']"
$alloc_source_selection_pop_up_default_close_button = "div[data-ffxtype='source-selection'] img[class*= 'f-tool-close']"

## Allocation - filter group button on filter pop-up selectors ##
$alloc_add_filter_group_button = "a[data-ffid='addFilterButton']"
$alloc_clear_group_button = "div[data-ffid='clearGroup']"
$alloc_filter_group_concertina_button = "img[class*= 'f-tool-collapse-top']"
$alloc_filter_group_close_button = "div[data-ffxtype='filter-box'] img[class*= 'f-tool-close']"
$alloc_gla_selection_toggle_button = "div[data-ffid ='codaGeneralLedgerAccount__c1'] a"
$alloc_dimension1_selection_toggle_button = "div[data-ffid ='codaDimension1__c1'] a"
$alloc_dimension2_selection_toggle_button = "div[data-ffid ='codaDimension2__c1'] a"
$alloc_dimension3_selection_toggle_button = "div[data-ffid ='codaDimension3__c1'] a"
$alloc_dimension4_selection_toggle_button = "div[data-ffid ='codaDimension4__c1'] a"

###################
$alloc_create_allocation_button = "a[data-ffid='createAllocationButton']"
$alloc_create_allocation_popup = "div[data-ffid='createAllocationPopup']"
$alloc_create_allocation_popup_cancel_button = "a[data-ffid='createAllocationCancelButton']"
$alloc_create_allocation_popup_create_button = "a[data-ffid='createAllocationCreateButton']"
$alloc_create_allocation_popup_description = "div[data-ffid='createAllocationPopup'] div[data-ffid='Description'] input"
$alloc_create_allocation_popup_period = "div[data-ffid='createAllocationPopup'] div[data-ffid='PeriodId'] input"
$alloc_create_allocation_popup_transaction_date = "div[data-ffid='createAllocationPopup'] div[data-ffid='AllocationsDateAsString'] input"
$alloc_create_allocation_popup_destination_company = "div[data-ffid='createAllocationPopup'] div[data-ffid='DestinationCompanyId'] input"
$alloc_create_allocation_popup_lines_preview = "div[data-ffxtype='transactionpreview']"

$alloc_retrieve_button = "a[data-ffid='retrieveDataButton']"
$alloc_retrieve_popup_search_box = "div[data-ffid='searchField'] input"
$alloc_retrieve_popup_tlis_button = "a[data-ffid='detailTransactionBtn']"
$alloc_retrieved_gla_summary_link = "div[data-ffid='summaryGLA'] a"
$alloc_retrieved_gla_summary_popup = "div[data-ffid='retrievedLinesPopup']"
$alloc_retrieved_gla_summary_popup_table = "div[data-ffid='retrievedLinesTable']"
$alloc_retrieved_gla_summary_popup_close = "div[data-ffid='retrievedLinesPopup'] img[contains(@class, 'close')]"
$alloc_retrieved_gla_summary_popup_column = "div[data-ffid='retrievedLinesTable'] td"
$alloc_retrieved_gla_summary_popup_row = "div[data-ffid='retrievedLinesTable'] tr"
$alloc_distributed_amount = "div[data-ffid='summaryDISTRIB']"
$alloc_notdistributed_amount = "div[data-ffid='summaryNONDIST']"
$alloc_retrieved_total_amount = "div[data-ffid='summaryTOTAL']"
$alloc_retrieved_distributed_amount = "div[data-ffid='summaryDISTRIB']"
$alloc_retrieved_values_counter = "div[data-ffid='summaryGLA']"
$alloc_popup = "div[data-ffid='retrievedLinesPopup']"
$alloc_popup_close = $alloc_popup + " img"
$alloc_retrieved_popup_table = $alloc_popup + " div[data-ffxtype='tableview'] table"
$alloc_retrieve_popup_row = "tr"
$alloc_retrieved_popup_row = "tbody tr"
$alloc_split_table = "div[data-ffid=splitTable]"
$alloc_split_table_column = "div[data-ffid='splitTable'] table td"
$alloc_split_table_column_input = "input[name='<objectType>Id']"
$alloc_split_table_row = "div[data-ffid='splitTable'] table tr"
$alloc_successful_popup = "div[data-ffid='successPopup']"
$alloc_successful_popup_new_allocation_button = "a[data-ffid='successNewAllocationButton']"
$alloc_successful_popup_view_transaction_button = "a[data-ffid='successViewTransactionButton']"
$alloc_template_load = "a[data-ffid='templateLoadButton']"
$alloc_template_save = "a[data-ffid='templateSaveButton']"
$alloc_template_save_popup = "div[data-ffid='saveTemplatePopup']"
$alloc_template_save_popup_name = "div[data-ffid=saveTemplateName] input"
$alloc_template_save_popup_description = "table[data-ffid='saveTemplateDescription']"
$alloc_template_save_popup_save_button = "a[data-ffid=saveTemplateSaveButton]"
$alloc_template_save_popup_cancel_button = "a[data-ffid='saveTemplateCancelButton']"
$alloc_template_save_popup_message_box = "div[data-ffid='saveTemplateMessageBox']"
$alloc_template_select = "div[data-ffid='templateSelector'] input"
$alloc_toggle_filters_button = "a[data-ffid='toggleFilterButton']"
$alloc_select_alloation_template = "table[data-ffid='templateSelector'] tbody input"
$alloc_load_button = "//span[text() = 'Load']"
$alloc_dimension1_value = "table[data-ffid='filterFieldcodaDimension1__c1Multiselect'] tbody input"
$alloc_split_line_gla =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOCATIONS_COLUMN_GLA})"
$alloc_split_line_gla_input =  "input[name = 'GeneralLedgerAccountId']"
$alloc_split_line_dimension1 =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOCATIONS_COLUMN_DIMENSION_1})"
$alloc_split_line_dimension1_input =  "input[name = 'Dimension1Id']"
$alloc_split_line_dimension2 =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOCATIONS_COLUMN_DIMENSION_2})"
$alloc_split_line_dimension2_input =  "input[name = 'Dimension2Id']"
$alloc_split_line_percentage =  "div[data-ffid='splitTable'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{ALLOCATIONS_COLUMN_PERCENTAGE})"
$alloc_split_line_percentage_input =  "input[name = 'Percentage']"
$alloc_split_line_amount_input = "input[name = 'Amount']"
$alloc_to_period_value= "input[name='ToPeriodId']"
$alloc_dimension1_input = "//table[contains(@data-ffid, 'filterFieldcodaDimension1')]"
$alloc_select_gla_filter = "div[data-ffid$=codaGeneralLedgerAccount__c1] table tbody td :nth-of-type(2) :nth-of-type(1)"
$alloc_set_gla_to = "table[data-ffid$=GeneralLedgerAccountId] input"
$alloc_set_dimension1_split = "table[data-ffid$=Dimension1Id] input"
$alloc_set_dimension2_split = "table[data-ffid$=Dimension2Id] input"
$alloc_set_dimension3_split = "table[data-ffid$=Dimension3Id] input"
$alloc_set_dimension4_split = "table[data-ffid$=Dimension4Id] input"
$alloc_set_percentage_split = "table[data-ffid$=Percentage] input"
$alloc_boundlist_container = "div.ALLOC-boundlist-container"
$alloc_boundlist_container_item = "div.f-boundlist-item"
$alloc_create_allocation_popup_company = "input[name='DestinationCompanyId']"
$alloc_filter_set_period = "div[data-ffid='filterFieldcodaPeriod__c1To'] input"
$alloc_picklist_value_pattern = "//li/div[(text()='"+$sf_param_substitute+"')]"

#Allocation Filter set methods
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

def Allocations.set_dimension1_value dimension_value
	id = find(:xpath, $alloc_dimension1_input)[:id]
	id_value = id+"-emptyEl"
	input_value = id+"-inputEl"
	find($alloc_dimension_input_field_pattern.sub($sf_param_substitute,id_value)).click
	find($alloc_dimension_pattern.sub($sf_param_substitute,input_value)).set dimension_value
	gen_wait_less
	gen_tab_out $alloc_dimension_pattern.sub($sf_param_substitute,input_value)
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

##
#
# Method Summary: Set gla in filter set gla
#
# @param [String] gla_value  Set GLA value in filter set GLA field
#	
#
def Allocations.set_filterset_gla_field gla_value
	SF.execute_script do
		find($alloc_filter_set_gla).click			
		find($alloc_filter_set_gla).set gla_value
		gen_wait_less
		gen_tab_out $alloc_filter_set_gla	
	end
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
# Method Summary: Set Dimension 1 in filter set Dimension 1
#
# @param [String] dimension1_value     Set Dimension 1 value in filter set Dimension 1 field
#	
#	
#
def Allocations.set_filterset_dimension1_field dimension1_value
	SF.execute_script do
		find($alloc_filter_set_dimension1).click			
		find($alloc_filter_set_dimension1).set dimension1_value
		gen_wait_less
		gen_tab_out $alloc_filter_set_dimension1	
	end
end

##
#
# Method Summary: Set Dimension 2 in filter set Dimension 2
#
# @param [String] dimension2_value     Set Dimension 2 value in filter set Dimension 2 field
#	
#	
#
def Allocations.set_filterset_dimension2_field dimension2_value
	SF.execute_script do
		find($alloc_filter_set_dimension2).click			
		find($alloc_filter_set_dimension2).set dimension2_value
		gen_wait_less
		gen_tab_out $alloc_filter_set_dimension2	
	end
end

##
#
# Method Summary: Set Dimension 3 in filter set Dimension 3
#
# @param [String] dimension3_value     Set Dimension 3 value in filter set Dimension 3 field
#	
#	
#
def Allocations.set_filterset_dimension3_field dimension3_value
	SF.execute_script do
		find($alloc_filter_set_dimension3).click			
		find($alloc_filter_set_dimension3).set dimension3_value
		gen_wait_less
		gen_tab_out $alloc_filter_set_dimension3	
	end
end

##
#
# Method Summary: Set Dimension 4 in filter set Dimension 4
#
# @param [String] dimension4_value     Set Dimension 4 value in filter set Dimension 4 field
#	
#	
#
def Allocations.set_filterset_dimension4_field dimension4_value
	SF.execute_script do
		find($alloc_filter_set_dimension4).click			
		find($alloc_filter_set_dimension4).set dimension4_value
		gen_wait_less
		gen_tab_out $alloc_filter_set_dimension4	
	end
end

##
#
# Method Summary : Method to click the From - To button for Allocation GLA filter field
# @param [Integer] filter_set_position Set Filter set position
#
def Allocations.click_gla_filter_fromto_button filter_set_position
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_gla_selection_toggle_button).click
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
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_dimension1_selection_toggle_button).click
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
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_dimension2_selection_toggle_button).click
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
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_dimension3_selection_toggle_button).click
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
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_dimension4_selection_toggle_button).click
		gen_wait_less
		find(:xpath,$alloc_from_to_label).click
	end
end

##
#
# Method Summary : Returns the Filters selected value 
#
def Allocations.get_filters_selcted_value
 return find($alloc_source_selection_pop_up_filters_selected_field).text
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

# set General Ledger Account to transfer to.
def Allocations.set_gla_split row, gla_to
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOCATIONS_COLUMN_GLA})").click
	rescue
	end
	find($alloc_set_gla_to).set gla_to
	gen_tab_out $alloc_set_gla_to
end

# set Dimension1 in split table
def Allocations.set_dimension1_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOCATIONS_COLUMN_DIMENSION_1})").click
	rescue
	end
	find($alloc_set_dimension1_split).set dimension
	gen_tab_out $alloc_set_dimension1_split
end

# set Dimension2 in split table
def Allocations.set_dimension2_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOCATIONS_COLUMN_DIMENSION_2})").click
	rescue
	end
	find($alloc_set_dimension2_split).set dimension
	gen_tab_out $alloc_set_dimension2_split
end

# set Dimension3 in split table
def Allocations.set_dimension3_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOCATIONS_COLUMN_DIMENSION_3})").click
	rescue
	end
	find($alloc_set_dimension3_split).set dimension
	gen_tab_out $alloc_set_dimension3_split
end

# set Dimension4 in split table
def Allocations.set_dimension4_split row, dimension
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOCATIONS_COLUMN_DIMENSION_4})").click
	rescue
	end
	find($alloc_set_dimension4_split).set dimension
	gen_tab_out $alloc_set_dimension4_split
end

# set percentage split for each general ledger account.
def Allocations.set_percent_split row, percentage_split
	begin
		find("#{$alloc_split_table} tr:nth-of-type(#{row}) td:nth-of-type(#{ALLOCATIONS_COLUMN_PERCENTAGE})").click
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

# set allocation template name
def Allocations.set_template_name template_name
	SF.execute_script do
		find($alloc_template_save_popup_name).set template_name
		gen_tab_out $alloc_template_save_popup_name
	end
end

# set allocation template description
def Allocations.set_template_desc template_desc
	fill_in 'Description:', with: template_desc
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
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[position - 1]
	selector = build_filterset_field_selector type, position, criteria

	within(targetFilterSet) do
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
		find($alloc_only_ict_checkbox).click
		gen_tab_out $alloc_only_ict_checkbox
		end
	elsif (check_only_ict == false)
		if(Allocations.is_only_intercompany_transactions_checkbox_checked? == true)
		find($alloc_only_ict_checkbox).click
		gen_tab_out $alloc_only_ict_checkbox
		else
		gen_tab_out $alloc_only_ict_checkbox
		end
	else
		raise "Given parameter value is not a boolean, it must be true/false"
	end
end

#Allocation Methods#

##
#
# Method Summary: Click the Add Source button.
#
#
def Allocations.click_on_add_source_button
	SF.execute_script do
		find($alloc_add_source_button).click
		gen_wait_until_object $alloc_source_selection_pop_up
	end
end

##
#
# Method Summary: Click the Cancel button.
#
#
def Allocations.click_on_cancel_button
	SF.execute_script do
		find($alloc_source_selection_pop_up_cancel_button).click
		gen_wait_until_object_disappear $alloc_source_selection_pop_up
	end
end

##
#
# Method Summary: Click the Retrieve button.
#
#
def Allocations.click_on_retrieve_button
	SF.execute_script do
		find($alloc_source_selection_pop_up_retrieve_button).click
		gen_wait_until_object_disappear $alloc_source_selection_pop_up
	end
end

##
#
# Method Summary: Click the Clear All button.
#
#
def Allocations.click_on_clear_all_button
	SF.execute_script do
		find($alloc_source_selection_pop_up_clear_All_button).click
	end
end

##
#
# Method Summary: Click the Clear group button.
# @param [Integer] filter_set_position  filter's number is entered for which clear filter group actions needs to be performed
#
#
def Allocations.click_on_selected_filter_clear_group_button filter_set_position
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_source_selection_pop_up_clear_group_button).click
	end
end

##
#
# Method Summary: Click the Add Filter group button.
#
#
def Allocations.click_on_add_filter_group_button
	SF.execute_script do
		find($alloc_add_filter_group_button).click
	end
end

##
#
# Method Summary: Click the default close button of filter group(to delete the filter group set)
# @param [Integer] filter_set_position  filter's number is entered for which filter delete action needs to be performed
#
#
def Allocations.click_on_filter_group_close_button filter_set_position
	gen_wait_until_object $alloc_filter_set
	filterSets = page.all($alloc_filter_set)
	targetFilterSet = filterSets[filter_set_position - 1]
	targetFilterSet.click
	within(targetFilterSet) do
		find($alloc_source_selection_pop_up_default_close_button).click
		gen_wait_more
	end
end

##
#
# Method Summary: Click the Change button to edit the filter set criteria
#
#
def Allocations.click_on_change_button
	SF.execute_script do
		find($alloc_change_button).click
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
	return find($alloc_total_field).text
end

def Allocations.add_filter_set
	find($alloc_filter_set_add_button).click
	sleep 1 # Wait for second filter options to appear.
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

def Allocations.assert_filterset_gla_value num, type, value
	targetFilterSet = Allocations.select_filter_set num
	within(targetFilterSet) do
		return find(Allocations.build_filterset_field_selector 'codaGeneralLedgerAccount__c', num, type).has_content?(value)
	end
end

def Allocations.assert_filterset_dim1_value num, type, value
	targetFilterSet = Allocations.select_filter_set num
	within(targetFilterSet) do
		return find(Allocations.build_filterset_field_selector 'codaDimension1__c', num, type).has_content?(value)
	end
end

def Allocations.assert_filterset_dim2_value num, type, value
	targetFilterSet = Allocations.select_filter_set num
	within(targetFilterSet) do
		return find(Allocations.build_filterset_field_selector 'codaDimension2__c', num, type).has_content?(value)
	end
end

def Allocations.assert_filterset_dim3_value num, type, value
	targetFilterSet = Allocations.select_filter_set num
	within(targetFilterSet) do
		return find(Allocations.build_filterset_field_selector 'codaDimension3__c', num, type).has_content?(value)
	end
end

def Allocations.assert_filterset_dim4_value num, type, value
	targetFilterSet = Allocations.select_filter_set num
	within(targetFilterSet) do
		return find(Allocations.build_filterset_field_selector 'codaDimension4__c', num, type).has_content?(value)
	end
end

## Retrieve
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
	sleep 1# wait for pop up to appear with information on it.
end

def Allocations.close_summary_by_gla
	find($alloc_retrieved_gla_summary_popup_close).click
end

def Allocations.assert_retrieved_values num
	return find($alloc_retrieved_values_counter).has_content?(num.to_s)
end

def Allocations.assert_total_amount_value value
	SF.execute_script do
		return find($alloc_retrieved_total_amount).has_content?(value)
	end
end

def Allocations.assert_distributed_amount dis_amount
	SF.execute_script do
		return find($alloc_retrieved_distributed_amount).has_content?(dis_amount)
	end
end

def Allocations.assert_not_distributed_amount num
	return find($alloc_notdistributed_amount).has_content?(num.to_s)
end

def Allocations.assert_popup_rows expected_rows
	SF.execute_script do
		gen_wait_until_object $alloc_retrieved_popup_table + ' ' + $alloc_retrieve_popup_row
		rows = all($alloc_retrieved_popup_table + ' ' + $alloc_retrieve_popup_row)
		
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

def Allocations.close_popup_rows
	SF.execute_script do
		find($alloc_popup_close).click
	end
end

## Split

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
		gen_wait_less
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

def Allocations.set_split_line_percentage line, percentage_value
	SF.execute_script do
		record_to_click = $alloc_split_line_percentage.gsub($sf_param_substitute, line.to_s)
		find(record_to_click).click
		find($alloc_split_line_percentage_input).set percentage_value
		gen_wait_less
		gen_tab_out $alloc_split_line_percentage_input
	end		
end
## Create allocation
def Allocations.create_allocation
	SF.execute_script do
		find($alloc_create_allocation_button).click
		gen_wait_until_object_disappear $page_loadmask_message
	end
end

def Allocations.confirm_allocation_creation
	SF.execute_script do
		find($alloc_create_allocation_popup_create_button).click
		gen_wait_until_object_disappear $page_loadmask_message
	end
end

## Templates
def Allocations.set_template template
	SF.execute_script do
		find($alloc_template_select).click
		find($alloc_template_select).set(template)
		## Results list takes a bit to get filtered.
		## This sleep will avoid double results.
		sleep 1
		find($alloc_template_select).native.send_keys(:tab)
	end
end

def Allocations.load_template
	SF.execute_script do
		find($alloc_template_load).click
		gen_wait_until_object_disappear $page_loadmask_message
	end
end

def Allocations.save_template
	find($alloc_template_save).click
end

def Allocations.popup_save_template
	find($alloc_template_save_popup_save_button).click
	FFA.wait_page_message $ffa_msg_saving
end

def Allocations.click_view_transaction_popup_button
	SF.execute_script do
		find($alloc_successful_popup_view_transaction_button).click
		SF.wait_for_search_button
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

def Allocations.set_create_popup_company value
	SF.execute_script do
		find($alloc_create_allocation_popup_destination_company).set(value)
		gen_tab_out $alloc_create_allocation_popup_destination_company
	end
	gen_wait_until_object_disappear $page_loadmask_message
end

def Allocations.set_create_popup_description value
	SF.execute_script do
		find($alloc_create_allocation_popup_description).set (value + "\t")
	end
end

def Allocations.set_create_popup_date value
	SF.execute_script do
		find($alloc_create_allocation_popup_transaction_date).set(value)
	end
end

def Allocations.set_create_popup_period value
	SF.execute_script do
		find($alloc_create_allocation_popup_period).set(value + "\t")
	end
end

def Allocations.assert_create_popup_available_companies company_list
	sleep 5
	find($alloc_create_allocation_popup_company).click
	sleep 5
	found_company_list = find($alloc_boundlist_container).text
	company_list.each do |one_company|
		if(!found_company_list.include? one_company)
			return false
		end
	end
	return true
end

def Allocations.assert_create_popup_date date
	date_field = find($alloc_create_allocation_popup_transaction_date)
	return date_field['value'] == date
end

def Allocations.assert_create_popup_period period
	period_field = find($alloc_create_allocation_popup_period)
	return period_field['value'] == period
end

def Allocations.assert_create_popup_lines_preview expected_lines
	found_lines = find($alloc_create_allocation_popup_lines_preview).text

	expected_lines.each do |one_expected_line|
		if !found_lines.include? one_expected_line
			puts "Row not found: " + one_expected_line
			puts "Existent rows: " + found_lines
			return false
		end
	end
	return true
end

def Allocations.set_search string_to_search
	find($alloc_retrieve_popup_search_box).set('')
	find($alloc_retrieve_popup_search_box).set(string_to_search)
	sleep 5 #Waits for the frontend to update results
end

def Allocations.click_tlis_button
	find($alloc_retrieve_popup_tlis_button).click
	gen_wait_for_text $alloc_retrieve_column_transaction
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

# to click on the cancel button of the create allocation pop up.
def Allocations.click_create_allocation_pupup_cancel_button
	find($alloc_create_allocation_popup_cancel_button).click
end
end