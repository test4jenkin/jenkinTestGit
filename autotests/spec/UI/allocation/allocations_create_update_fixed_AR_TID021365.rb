#--------------------------------------------------------------------#
#	TID : TID021365
#	Pre-Requisite: Org with basedata deployed.CODATID021365Data.cls should exists on org
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocations_create_update_fixed_AR_TID021365.rb -fh -o TID021365.html
#   
#--------------------------------------------------------------------#
describe "TID021365 - Verify the create and update of Fixed Allocation rules from pop up on Fixed distribution screen.", :type => :request do
include_context "login"
include_context "logout_after_each"
	current_year = Date.today.strftime("%Y")
	current_month = Date.today.strftime("%m")
	current_date = Date.today.strftime("%d")
	CURRENT_PERIOD = FFA.get_current_period
	NEXT_PERIOD = FFA.get_period_by_date Date.today>>1
	PERCENTAGE_125 = "125"
	PERCENTAGE_25 = "25"
	PERCENTAGE_40 = "40"
	PERCENTAGE_10 = "10"
	PERCENTAGE_20 = "20"
	PERCENTAGE_30 = "30"
	PERCENTAGE_50 = "50"
	PERCENTAGE_100 = "100"
	ACTIVE_FIXED_ALLOCATION_RULE_NAME_1 = "FixedAR_1"
	INACTIVE_FIXED_ALLOCATION_RULE_NAME_2 = "FixedAR_2"
	ACTIVE_FIXED_ALLOCATION_RULE_NAME_2 = "Test AR1"
	ACTIVE_FIXED_ALLOCATION_RULE_NAME_3 = "FixedAR_3"
	ALLOCATION_RULE_DESCRIPTION_1 = 'Active allocation rule 1';
    ALLOCATION_RULE_DESCRIPTION_2 = 'Inactive allocation rule 2';
	_rule_description_TST037246 = "Create a new fixed allocation rule"
	_rule_description_TST037246_2 = "New active fixed allocation rule"
	_sencha_warning_rule_with_unsaved_changes = "You have edited the selected allocation rule, but have not saved your changes. Click Yes to update the rule. Click No to use the edited rule details for this allocation only and leave the original allocation rule unchanged."
	_sencha_warning_multiple_fiscal_periods = "Selecting transactions by date range instead of period may result in retrieving transactions from multiple fiscal periods."
	_namspace_prefix = ""
	_namspace_prefix += ORG_PREFIX
	
	if(_namspace_prefix != nil && _namspace_prefix != "" )
		_namspace_prefix = _namspace_prefix.gsub! "__", "."
	end	
	
	_post_with_API = "Date currentDate = system.today();"
	_post_with_API += "#{_namspace_prefix}CODAAPICommon_10_0.Context context = new #{_namspace_prefix}CODAAPICommon_10_0.Context();"
	_post_with_API += " #{ORG_PREFIX}codaCompany__c compMerlinAutoSPAIN = [select id, name from #{ORG_PREFIX}codaCompany__c where name = '#{$company_merlin_auto_spain}'];"
	_post_with_API += "Account accCambridge = [Select id, name from Account where MirrorName__c = '#{$bd_account_cambridge_auto}'];" 
	_post_with_API += " #{ORG_PREFIX}codaGeneralLedgerAccount__c glaARCUSD = [Select id, name from #{ORG_PREFIX}codaGeneralLedgerAccount__c where name = '#{$bd_gla_account_receivable_control_usd}'];"
	_post_with_API += " #{ORG_PREFIX}codaGeneralLedgerAccount__c glaSalesParts = [Select id, name from #{ORG_PREFIX}codaGeneralLedgerAccount__c where name = '#{$bd_gla_sales_parts}'];"
	_post_with_API += " #{ORG_PREFIX}codaAccountingCurrency__c currEUR = [Select id, name from #{ORG_PREFIX}codaAccountingCurrency__c where name = '#{$bd_currency_eur}' and #{ORG_PREFIX}OwnerCompany__c = :compMerlinAutoSPAIN.Id];"
	_post_with_API += " Set<String> specialPeriods = new Set<String> {'000', '100', '101'};"
	_post_with_API += " #{ORG_PREFIX}codaPeriod__c period = [Select id, #{ORG_PREFIX}EndDate__c from #{ORG_PREFIX}codaPeriod__c where #{ORG_PREFIX}StartDate__c <= :currentDate and #{ORG_PREFIX}EndDate__c >= :currentDate and #{ORG_PREFIX}OwnerCompany__c = :compMerlinAutoSPAIN.Id and #{ORG_PREFIX}Closed__c = false and #{ORG_PREFIX}PeriodNumber__c not in :specialPeriods];"
	_post_with_API += " Product2 prodAutoCom = [select id, Description from Product2 where name = '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}'][0];"
	_post_with_API += " #{ORG_PREFIX}codaTaxCode__c CityTaxCodeSUT = [select id, #{ORG_PREFIX}Description__c from #{ORG_PREFIX}codaTaxCode__c where name = '#{$bd_tax_code_city_tax_code_sut}'];"
	_post_with_API += "  #{_namspace_prefix}TransactionService.AccountingTransaction trans = new #{_namspace_prefix}TransactionService.AccountingTransaction();"
	_post_with_API += " trans.setTransactionDate(currentDate);"
	_post_with_API += " trans.setPeriodId(period.Id);"
	_post_with_API += " trans.setTransactionType(#{_namspace_prefix}TransactionService.TransactionType.SALES_INVOICE);"
	_post_with_API += " List<#{_namspace_prefix}TransactionService.AccountingTransactionLine> transLines = new List<#{_namspace_prefix}TransactionService.AccountingTransactionLine>();"
	_post_with_API += "  /* Account Line */ "
	_post_with_API += "#{_namspace_prefix}TransactionService.AccountingTransactionLine line = new #{_namspace_prefix}TransactionService.AccountingTransactionLine();"
	_post_with_API += " line.setLineType(#{_namspace_prefix}TransactionService.TransactionLineType.ACCOUNT);"
	_post_with_API += " line.setAccountId(accCambridge.Id);"
	_post_with_API += " line.setDocumentValue(-15);"
	_post_with_API += " line.setDocumentCurrencyId(currEUR.Id);"
	_post_with_API += " line.setGeneralLedgerAccountId(glaARCUSD.Id);"
	_post_with_API += " line.setDueDate(currentDate+ 10);"
	_post_with_API += " transLines.add(line);"
	_post_with_API += "  /* Analisys line*/"
	_post_with_API += " line = new #{_namspace_prefix}TransactionService.AccountingTransactionLine();"
	_post_with_API += " line.setLineType(#{_namspace_prefix}TransactionService.TransactionLineType.ANALYSIS);"
	_post_with_API += " line.setDocumentValue(15);"
	_post_with_API += " line.setDocumentCurrencyId(currEUR.Id);"
	_post_with_API += " line.setGeneralLedgerAccountId(glaSalesParts.Id);"
	_post_with_API += " line.setProductId(prodAutoCom.Id);"
	_post_with_API += " transLines.add(line);"
	_post_with_API += " trans.TransactionLineItems = transLines;"
	_post_with_API += "  #{_namspace_prefix}TransactionService.PostOptions postOp = new #{_namspace_prefix}TransactionService.PostOptions();"
	_post_with_API += " postOp.DestinationCompanyId = compMerlinAutoSPAIN.Id;"
	_post_with_API += " List<ID> transIDs = #{_namspace_prefix}TransactionService.post(new List<#{_namspace_prefix}TransactionService.AccountingTransaction> {trans}, postOp);"
	
	#Create an active fixed allocation rule 
	_active_allocation_rule = "#{ORG_PREFIX}AllocationRule__c allocRule = new #{ORG_PREFIX}AllocationRule__c();"
	_active_allocation_rule += "allocRule.#{ORG_PREFIX}Type__c = '#{$allocationrules_type_fixed_label}';"
	_active_allocation_rule += "allocRule.Name = '#{ACTIVE_FIXED_ALLOCATION_RULE_NAME_1}';"
	_active_allocation_rule += "allocRule.#{ORG_PREFIX}Active__c = false;"
	_active_allocation_rule += "allocRule.#{ORG_PREFIX}Description__c = '#{ALLOCATION_RULE_DESCRIPTION_1}';"
	_active_allocation_rule += "insert allocRule;"
	
	_active_allocation_rule += "List<#{ORG_PREFIX}FixedAllocationRuleLine__c> allocFixedRuleLines = new List<#{ORG_PREFIX}FixedAllocationRuleLine__c>();"
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaIds = [SELECT Id FROM #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name IN ('#{$bd_gla_account_receivable_control_usd}','#{$bd_gla_account_receivable_control_eur}','#{$bd_gla_apextaxgla001}','#{$bd_gla_bank_account_euros_us}') ORDER BY Name];"
	_active_allocation_rule += "List<#{ORG_PREFIX}codaDimension1__c> dim1Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension1__c WHERE Name IN ('#{$bd_dim1_usd}','#{$bd_apex_eur_001}') ORDER BY Name];"
    _active_allocation_rule += "List<#{ORG_PREFIX}codaDimension2__c> dim2Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension2__c WHERE Name IN ('#{$bd_dim2_usd}','#{$bd_apex_eur_002}') ORDER BY Name];"
    _active_allocation_rule += "List<#{ORG_PREFIX}codaDimension3__c> dim3Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension3__c WHERE Name IN ('#{$bd_dim3_usd}','#{$bd_apex_eur_003}') ORDER BY Name];"
    _active_allocation_rule += "List<#{ORG_PREFIX}codaDimension4__c> dim4Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension4__c WHERE Name IN ('#{$bd_dim4_usd}','#{$bd_dim4_eur}') ORDER BY Name];"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension1__c = dim1Ids[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension2__c = dim2Ids[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension3__c = dim3Ids[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension4__c = dim4Ids[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Split__c = 20.00;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine);"
	
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine1 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}Dimension1__c = dim1Ids[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}Split__c = 30.00;"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine1);"
	
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine2 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[2].Id;"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}Dimension2__c = dim2Ids[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}Split__c = 40.00;"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine2);"
	
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine3 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[3].Id;"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}Dimension3__c = dim3Ids[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}Split__c = 10.00;"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine3);"
	_active_allocation_rule += "insert allocFixedRuleLines;"
	
	_active_allocation_rule += "#{ORG_PREFIX}AllocationRule__c getAllocationRule = [SELECT #{ORG_PREFIX}Active__c FROM #{ORG_PREFIX}AllocationRule__c WHERE Id = :allocRule.Id];"
	_active_allocation_rule += "getAllocationRule.#{ORG_PREFIX}Active__c = true;"
	_active_allocation_rule += "update getAllocationRule;"
	
	#Create an inactive fixed allocation rule
	_inactive_allocation_rule = "#{ORG_PREFIX}AllocationRule__c allocRule2 = new #{ORG_PREFIX}AllocationRule__c();"
	_inactive_allocation_rule += "allocRule2.#{ORG_PREFIX}Type__c = '#{$allocationrules_type_fixed_label}';"
	_inactive_allocation_rule += "allocRule2.Name = '#{INACTIVE_FIXED_ALLOCATION_RULE_NAME_2}';"
	_inactive_allocation_rule += "allocRule2.#{ORG_PREFIX}Active__c = false;"
	_inactive_allocation_rule += "allocRule2.#{ORG_PREFIX}Description__c = '#{ALLOCATION_RULE_DESCRIPTION_2}';"
	_inactive_allocation_rule += "insert allocRule2;"
	
	_inactive_allocation_rule += "List<#{ORG_PREFIX}FixedAllocationRuleLine__c> allocFixedRuleLines1 = new List<#{ORG_PREFIX}FixedAllocationRuleLine__c>();"
	_inactive_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine2 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_inactive_allocation_rule += "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glainactiveIds = [SELECT Id FROM #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name IN ('APEXACCGLA001','Apex Write Off GLA EUR') ORDER BY Name];"
	_inactive_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}GeneralLedgerAccount__c = glainactiveIds[1].Id;"
	_inactive_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}Split__c = 50.00;"
	_inactive_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}AllocationRule__c = allocRule2.Id;"
	_inactive_allocation_rule += "allocFixedRuleLines1.add(fixedallocRuleLine2);"
	
	_inactive_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine3 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_inactive_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}GeneralLedgerAccount__c = glainactiveIds[0].Id;"
	_inactive_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}Split__c = 50.00;"
	_inactive_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}AllocationRule__c = allocRule2.Id;"
	_inactive_allocation_rule += "allocFixedRuleLines1.add(fixedallocRuleLine3);"
	_inactive_allocation_rule += "insert allocFixedRuleLines1;"
	
	
	before :all do
	# Hold Base Data
	gen_start_test "TID021365 - Verify the create and update of Fixed Allocation rules from pop up on Fixed distribution screen."
	begin
		SF.app $accounting
		#Create and post sales invoice through API
		APEX.execute_commands [_post_with_API]
		script_status = APEX.get_execution_status_message
		gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
		
		#Create an active allocation rule
		APEX.execute_commands [_active_allocation_rule]
		script_status = APEX.get_execution_status_message
		gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
		
		#Create an inactive allocation rule
		APEX.execute_commands [_inactive_allocation_rule]
		script_status = APEX.get_execution_status_message
		gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
	end			
end

it "Verify the create and update of Fixed Allocation rules from pop up on Fixed distribution screen" do
	_gmt_offset = gen_get_current_user_gmt_offset
	_locale = gen_get_current_user_locale
	_today = gen_get_current_date _gmt_offset
	_today_date = gen_locale_format_date _today, _locale
	CURRENT_FORMATTED_DATE = _today_date
	gen_start_test "TST037246 - Verify the creation of Fixed Allocation rules from pop up on Fixed distribution screen."
	begin
		SF.tab $tab_allocations
		Allocations.allocation_list_view_click_new_button
		gen_report_test "UI loaded succesfully from list view."
		
		#Verify that Allocations UI get opened succesfully
		expect(page.has_text?($alloc_retrieve_source_page_label)).to be true
		gen_wait_until_object $alloc_to_period_field
		Allocations.set_allocation_type $alloc_type_label
		
		#Verify warning message displayed on selection of TimePeriod = Date 
		Allocations.set_timeperiod_value $alloc_date_label
		gen_compare _sencha_warning_multiple_fiscal_periods,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
		FFA.sencha_popup_click_continue
		
		#Set Allocation filter criteria 
		Allocations.set_timeperiod_date_selection '',CURRENT_FORMATTED_DATE
		#Allocation filter 1
		Allocations.set_filterset_field_value 1, $alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
		
		#Verify that user is navigated to Allocation method screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?($alloc_label_method_of_allocation)).to be true
		gen_report_test "User is navigated to Allocation method selection screen"
		
		#Verify that user is navigated to Fixed distribution screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?($alloc_label_allocation_rule)).to be true
		gen_report_test "User is navigated to Fixed distribution screen"
		
		#Verify that save fixed allocation rule button is disabled on page load
		gen_assert_disabled $alloc_save_fixed_allocation_rule_button
		
		#Set values in row 1 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 1, $bd_gla_postage_and_stationery
		Allocations.set_split_line_dimension1 1, $bd_apex_eur_001
		Allocations.set_split_line_dimension2 1, $bd_apex_eur_002
		Allocations.set_split_line_dimension3 1, $bd_apex_eur_003
		Allocations.set_split_line_dimension4 1, $bd_apex_eur_004
		Allocations.set_split_line_percentage 1, PERCENTAGE_125
		
		#Verify that save fixed allocation rule button still in disabled mode, since maximum allocation percentage is 100%
		gen_assert_disabled $alloc_save_fixed_allocation_rule_button
		
		#update values in row 1 of Manual Allocation distribution grid
		Allocations.set_split_line_percentage 1, PERCENTAGE_25
		
		#Set values in row 2 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 2, $bd_gla_account_payable_control_eur
		Allocations.set_split_line_dimension1 2, $bd_dim1_usd
		Allocations.set_split_line_dimension2 2, $bd_dim2_usd
		Allocations.set_split_line_dimension3 2, $bd_dim3_usd
		Allocations.set_split_line_dimension4 2, $bd_dim4_usd
		Allocations.set_split_line_percentage 2, PERCENTAGE_25
		
		#Set values in row 3 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 3, $bd_gla_accounts_payable_control_gbp
		Allocations.set_split_line_dimension1 3, $bd_dim1_gbp
		Allocations.set_split_line_percentage 3, PERCENTAGE_10
		
		#Set values in row 4 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 4, $bd_gla_account_receivable_control_eur
		Allocations.set_split_line_dimension2 4, $bd_dim2_gbp
		Allocations.set_split_line_percentage 4, PERCENTAGE_40
		
		#Perform spread evely operation
		Allocations.click_spread_evenly_link
		#Verify that save fixed allocation rule button will be in enabled mode.
		gen_assert_enabled $alloc_save_fixed_allocation_rule_button
		
		#Save allocation rule and set values in save allocation rule pop up
		Allocations.click_on_save_allocation_rule_button
		Allocations.set_rule_name_in_pop_up ACTIVE_FIXED_ALLOCATION_RULE_NAME_2
		Allocations.set_rule_description_in_pop_up _rule_description_TST037246
		Allocations.click_on_save_button_save_rule_pop_up
		
		#Verify that user will navigate back to distribute screen and allocation rule will be saved in active status
		expect(page.has_text?($alloc_label_allocation_rule)).to be true
		gen_report_test "User is navigated to Fixed distribution screen"
		
		#Update Fixed allocation rule = FixedAR_1
		Allocations.set_rule_name ACTIVE_FIXED_ALLOCATION_RULE_NAME_1
		Allocations.delete_split_line 1
		Allocations.delete_split_line 1
		Allocations.delete_split_line 1
		Allocations.delete_split_line 1
		Allocations.set_split_line_gla 1, $bd_gla_account_receivable_control_usd
		Allocations.set_split_line_dimension1 1, $bd_dim1_usd
		Allocations.set_split_line_dimension2 1, $bd_dim2_usd
		Allocations.set_split_line_dimension3 1, $bd_dim3_usd
		Allocations.set_split_line_dimension4 1, $bd_dim4_usd
		Allocations.set_split_line_percentage 1, PERCENTAGE_100
		
		#Verify that on providing new rule name and description, existing rule will remains same and new rule will be created.
		Allocations.click_on_save_allocation_rule_button
		Allocations.set_rule_name_in_pop_up ACTIVE_FIXED_ALLOCATION_RULE_NAME_3
		Allocations.set_rule_description_in_pop_up _rule_description_TST037246_2
		Allocations.click_on_save_button_save_rule_pop_up
		
		gen_end_test "TST037246 - Verify the creation of Fixed Allocation rules from pop up on Fixed distribution screen."
	end

	gen_start_test "TST037247 - Verify the update of an existing Fixed Allocation rules from pop up on Fixed distribution screen."
	begin
		SF.tab $tab_allocations
		Allocations.allocation_list_view_click_new_button
		gen_report_test "UI loaded succesfully from list view."
		
		#Verify that Allocations UI get opened succesfully
		expect(page.has_text?($alloc_retrieve_source_page_label)).to be true
		gen_wait_until_object $alloc_to_period_field
		Allocations.set_allocation_type $alloc_type_label
		
		#Verify warning message displayed on selection of TimePeriod = Date 
		Allocations.set_timeperiod_value $alloc_date_label
		gen_compare _sencha_warning_multiple_fiscal_periods,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
		FFA.sencha_popup_click_continue
		
		#Set Allocation filter criteria 
		Allocations.set_timeperiod_date_selection '',CURRENT_FORMATTED_DATE
		#Allocation filter 1
		Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
		#Verify that user is navigated to Allocation method screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?($alloc_label_method_of_allocation)).to be true
		gen_report_test "User is navigated to Allocation method selection screen"
		
		#Verify that user is navigated to Fixed distribution screen on selection of Next button
		Allocations.click_on_next_button
		expect(page.has_text?($alloc_label_allocation_rule)).to be true
		gen_report_test "User is navigated to Fixed distribution screen"
		
		#Verify that save fixed allocation rule button is disabled on page load
		gen_assert_disabled $alloc_save_fixed_allocation_rule_button
		
		#Select rule name from picklist "FixedAR_1"
		Allocations.set_rule_name ACTIVE_FIXED_ALLOCATION_RULE_NAME_1
		
		#Update distribution set for selected fixed allocation rule
		Allocations.set_split_line_percentage 1, PERCENTAGE_25
		Allocations.set_split_line_percentage 2, PERCENTAGE_25
		Allocations.set_split_line_percentage 3, PERCENTAGE_25
		Allocations.set_split_line_percentage 4, PERCENTAGE_25
		Allocations.click_on_next_button
		
		#Assert warning message displayed to user on clicking next button with unsaved changes in selected allocation rule
		gen_compare _sencha_warning_rule_with_unsaved_changes,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
		
		#Select yes button of sencha pop up warning message
		FFA.sencha_popup_click_ok
		
		# get back to distribute screen
		Allocations.click_on_back_button
		
		#Selected fixed allocation rule will be defined with new distribution paramerters defined
		Allocations.click_on_back_button
		Allocations.click_on_next_button
		Allocations.set_rule_name ACTIVE_FIXED_ALLOCATION_RULE_NAME_1
		
		#Assert values associated with selected fixed Allocation rule = FixedAR_1
		#Assert values in row 1 of Allocation distribution grid
		row_1_GLA = Allocations.assert_split_table_row_value 1, $bd_gla_account_receivable_control_usd
		row_1_Dimension1 = Allocations.assert_split_table_row_value 1, $bd_dim1_usd
		row_1_Dimension2 = Allocations.assert_split_table_row_value 1, $bd_dim2_usd
		row_1_Dimension3 = Allocations.assert_split_table_row_value 1, $bd_dim3_usd
		row_1_Dimension4 = Allocations.assert_split_table_row_value 1, $bd_dim4_usd
		row_1_percentage = Allocations.assert_split_table_row_value 1, PERCENTAGE_25
		row_1_amount = Allocations.assert_split_table_row_value 1, '3.75'
		
		gen_compare true, row_1_GLA, "Expected GLA is #{$bd_gla_account_receivable_control_usd}"
		gen_compare true, row_1_Dimension1, "Expected Dimension 1 is #{$bd_dim1_usd}"
		gen_compare true, row_1_Dimension2, "Expected Dimension 2 is #{$bd_dim2_usd}"
		gen_compare true, row_1_Dimension3, "Expected Dimension 3 is #{$bd_dim3_usd}"
		gen_compare true, row_1_Dimension4, "Expected Dimension 4 is #{$bd_dim4_usd}"
		gen_compare true, row_1_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_1_amount, "Expected amount is 3.75"
		
		#Assert values in row 2 of Allocation distribution grid
		row_2_GLA = Allocations.assert_split_table_row_value 2, $bd_gla_account_receivable_control_eur
		row_2_Dimension1 = Allocations.assert_split_table_row_value 2, $bd_apex_eur_001
		row_2_Dimension2 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension3 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension4 = Allocations.assert_split_table_row_value 2, ''
		row_2_percentage = Allocations.assert_split_table_row_value 2, PERCENTAGE_25
		row_2_amount = Allocations.assert_split_table_row_value 2, '3.75'
		
		gen_compare true, row_2_GLA, "Expected GLA is #{$bd_gla_account_receivable_control_eur}"
		gen_compare true, row_2_Dimension1, "Expected Dimension 1 is #{$bd_apex_eur_001}"
		gen_compare true, row_2_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_2_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_2_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_2_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_2_amount, "Expected amount is 3.75"
		
		#Assert values in row 3 of Allocation distribution grid
		row_3_GLA = Allocations.assert_split_table_row_value 3, $bd_gla_apextaxgla001
		row_3_Dimension1 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension2 = Allocations.assert_split_table_row_value 3, $bd_apex_eur_002
		row_3_Dimension3 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension4 = Allocations.assert_split_table_row_value 3, ''
		row_3_percentage = Allocations.assert_split_table_row_value 3, PERCENTAGE_25
		row_3_amount = Allocations.assert_split_table_row_value 3, '3.75'
		
		gen_compare true, row_3_GLA, "Expected GLA is #{$bd_gla_apextaxgla001}"
		gen_compare true, row_3_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_3_Dimension2, "Expected Dimension 2 is #{$bd_apex_eur_002}"
		gen_compare true, row_3_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_3_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_3_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_3_amount, "Expected amount is 3.75"
		
		#Assert values in row 4 of Allocation distribution grid
		row_4_GLA = Allocations.assert_split_table_row_value 4, $bd_gla_bank_account_euros_us
		row_4_Dimension1 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension2 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension3 = Allocations.assert_split_table_row_value 4, $bd_apex_eur_003
		row_4_Dimension4 = Allocations.assert_split_table_row_value 4, ''
		row_4_percentage = Allocations.assert_split_table_row_value 4, PERCENTAGE_25
		row_4_amount = Allocations.assert_split_table_row_value 4, '3.75'
		
		gen_compare true, row_4_GLA, "Expected GLA is #{$bd_gla_bank_account_euros_us}"
		gen_compare true, row_4_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_4_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_4_Dimension3, "Expected Dimension 3 is #{$bd_apex_eur_003}"
		gen_compare true, row_4_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_4_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_4_amount, "Expected amount is 3.75"
		
		#Update distribution set for selected fixed allocation rule
		Allocations.set_split_line_percentage 1, PERCENTAGE_10
		Allocations.set_split_line_percentage 2, PERCENTAGE_20
		Allocations.set_split_line_percentage 3, PERCENTAGE_30
		Allocations.set_split_line_percentage 4, PERCENTAGE_40
		Allocations.click_on_next_button
		
		#Assert warning message displayed to user on clicking next button with unsaved changes in selected allocation rule
		gen_compare _sencha_warning_rule_with_unsaved_changes,FFA.get_sencha_popup_warning_message,"warning message successfully matched"
		
		#Select no button of sencha pop up warning message
		FFA.sencha_popup_click_cancel
		
		# get back to distribute screen
		Allocations.click_on_back_button
		
		#Selected fixed allocation rule will be disassociated with current allocation process
		Allocations.click_on_back_button
		Allocations.click_on_next_button
		Allocations.set_rule_name ACTIVE_FIXED_ALLOCATION_RULE_NAME_2
		Allocations.set_rule_name ACTIVE_FIXED_ALLOCATION_RULE_NAME_1
		
		#Verify that rule will not get updated with new percentage parameters defined 
		#Assert values in row 1 of Allocation distribution grid
		row_1_GLA = Allocations.assert_split_table_row_value 1, $bd_gla_account_receivable_control_usd
		row_1_Dimension1 = Allocations.assert_split_table_row_value 1, $bd_dim1_usd
		row_1_Dimension2 = Allocations.assert_split_table_row_value 1, $bd_dim2_usd
		row_1_Dimension3 = Allocations.assert_split_table_row_value 1, $bd_dim3_usd
		row_1_Dimension4 = Allocations.assert_split_table_row_value 1, $bd_dim4_usd
		row_1_percentage = Allocations.assert_split_table_row_value 1, PERCENTAGE_25
		row_1_amount = Allocations.assert_split_table_row_value 1, '3.75'
		
		gen_compare true, row_1_GLA, "Expected GLA is #{$bd_gla_account_receivable_control_usd}"
		gen_compare true, row_1_Dimension1, "Expected Dimension 1 is #{$bd_dim1_usd}"
		gen_compare true, row_1_Dimension2, "Expected Dimension 2 is #{$bd_dim2_usd}"
		gen_compare true, row_1_Dimension3, "Expected Dimension 3 is #{$bd_dim3_usd}"
		gen_compare true, row_1_Dimension4, "Expected Dimension 4 is #{$bd_dim4_usd}"
		gen_compare true, row_1_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_1_amount, "Expected amount is 3.75"
		
		#Assert values in row 2 of Allocation distribution grid
		row_2_GLA = Allocations.assert_split_table_row_value 2, $bd_gla_account_receivable_control_eur
		row_2_Dimension1 = Allocations.assert_split_table_row_value 2, $bd_apex_eur_001
		row_2_Dimension2 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension3 = Allocations.assert_split_table_row_value 2, ''
		row_2_Dimension4 = Allocations.assert_split_table_row_value 2, ''
		row_2_percentage = Allocations.assert_split_table_row_value 2, PERCENTAGE_25
		row_2_amount = Allocations.assert_split_table_row_value 2, '3.75'
		
		gen_compare true, row_2_GLA, "Expected GLA is #{$bd_gla_account_receivable_control_eur}"
		gen_compare true, row_2_Dimension1, "Expected Dimension 1 is #{$bd_apex_eur_001}"
		gen_compare true, row_2_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_2_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_2_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_2_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_2_amount, "Expected amount is 3.75"
		
		#Assert values in row 3 of Allocation distribution grid
		row_3_GLA = Allocations.assert_split_table_row_value 3, $bd_gla_apextaxgla001
		row_3_Dimension1 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension2 = Allocations.assert_split_table_row_value 3, $bd_apex_eur_002
		row_3_Dimension3 = Allocations.assert_split_table_row_value 3, ''
		row_3_Dimension4 = Allocations.assert_split_table_row_value 3, ''
		row_3_percentage = Allocations.assert_split_table_row_value 3, PERCENTAGE_25
		row_3_amount = Allocations.assert_split_table_row_value 3, '3.75'
		
		gen_compare true, row_3_GLA, "Expected GLA is #{$bd_gla_apextaxgla001}"
		gen_compare true, row_3_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_3_Dimension2, "Expected Dimension 2 is #{$bd_apex_eur_002}"
		gen_compare true, row_3_Dimension3, "Expected Dimension 3 is blank"
		gen_compare true, row_3_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_3_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_3_amount, "Expected amount is 3.75"
		
		#Assert values in row 4 of Allocation distribution grid
		row_4_GLA = Allocations.assert_split_table_row_value 4, $bd_gla_bank_account_euros_us
		row_4_Dimension1 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension2 = Allocations.assert_split_table_row_value 4, ''
		row_4_Dimension3 = Allocations.assert_split_table_row_value 4, $bd_apex_eur_003
		row_4_Dimension4 = Allocations.assert_split_table_row_value 4, ''
		row_4_percentage = Allocations.assert_split_table_row_value 4, PERCENTAGE_25
		row_4_amount = Allocations.assert_split_table_row_value 4, '3.75'
		
		gen_compare true, row_4_GLA, "Expected GLA is #{$bd_gla_bank_account_euros_us}"
		gen_compare true, row_4_Dimension1, "Expected Dimension 1 is blank"
		gen_compare true, row_4_Dimension2, "Expected Dimension 2 is blank"
		gen_compare true, row_4_Dimension3, "Expected Dimension 3 is #{$bd_apex_eur_003}"
		gen_compare true, row_4_Dimension4, "Expected Dimension 4 is blank"
		gen_compare true, row_4_percentage, "Expected percentage is 25.00%"
		gen_compare true, row_4_amount, "Expected amount is 3.75"
		
		gen_end_test "TST037247 - Verify the update of an existing Fixed Allocation rules from pop up on Fixed distribution screen."
	end
end

after :all do
	login_user
	#Delete Test Data
	FFA.delete_new_data_and_wait
	SF.logout
	gen_end_test "TID021365 - Verify the create and update of Fixed Allocation rules from pop up on Fixed distribution screen."
end
end
	