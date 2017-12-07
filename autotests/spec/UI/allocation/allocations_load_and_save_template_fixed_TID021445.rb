#--------------------------------------------------------------------#
#	TID : TID021445
#   Org Type : Managed and Unmanaged
#	Pre-Requisite: Org with basedata deployed
#	Product Area: Allocations
#   driver=firefox rspec spec/UI/allocation/allocations_load_and_save_template_fixed_TID021445.rb -o TID021445.html
#   
#--------------------------------------------------------------------#
describe "TID021445 - Verify that user can create, save, edit and load template for Fixed Allocation Type", :type => :request do
	include_context "login"

	amount_value = "€(15.00)"
	allocation_rule_name_1 = "FixedAR_1"
	allocation_rule_description_1 = 'Active Allocation Rule 1'

	template_name = "Template Fixed Allocation"
	template_description = "Template for Fixed Allocation Rule"
	destination_document_description = "Testing Save & Load Template"
	destination_document_type = "Journals"
	todays_date = Date.today
	current_period = FFA.get_period_by_date todays_date
	template_success = FFA.fetch_label 'AllocationSaveTemplateSuccess'
	rule_save_warning = "You have edited the selected allocation rule, but have not saved your changes. Click Yes to update the rule. Click No to use the edited rule details for this allocation only and leave the original allocation rule unchanged."
	template_override = FFA.fetch_label 'AllocationOverWriteName'
	row_1 = "Accounts Receivable Control - EUR Apex EUR 001 Apex EUR 002 Apex EUR 003 Apex EUR 004 20 (3.00)"
	row_2 = "Accounts Receivable Control - USD Dim 1 USD 30 (4.50)"
	row_3 = "APEXTAXGLA001 Dim 2 USD 40 (6.00)"
	row_4 = "Bank Account - Euros US Dim 3 USD 10 (1.50)"
	updated_row_4 = "Bank Account - Euros US Dim 3 USD Apex EUR 004 10 (1.50)"
	row = "Bank Account - Euros US Dim 3 USD Apex EUR 004 10"

	_namspace_prefix = ""
	_namspace_prefix += ORG_PREFIX
	if(_namspace_prefix != nil && _namspace_prefix != "" )
		_namspace_prefix = _namspace_prefix.gsub! "__", "."
	end	
	
	#Creating Transaction
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
	_post_with_API += "  /* Analysis line*/"
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
	_active_allocation_rule += "allocRule.Name = '#{allocation_rule_name_1}';"
	_active_allocation_rule += "allocRule.#{ORG_PREFIX}Active__c = false;"
	_active_allocation_rule += "allocRule.#{ORG_PREFIX}Description__c = '#{allocation_rule_description_1}';"
	_active_allocation_rule += "insert allocRule;"
	
	_active_allocation_rule += "List<#{ORG_PREFIX}FixedAllocationRuleLine__c> allocFixedRuleLines = new List<#{ORG_PREFIX}FixedAllocationRuleLine__c>();"
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaIds = [SELECT Id FROM #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name IN ('#{$bd_gla_account_receivable_control_usd}','#{$bd_gla_account_receivable_control_eur}','#{$bd_gla_apextaxgla001}','#{$bd_gla_bank_account_euros_us}') ORDER BY Name];"
	_active_allocation_rule += "List<#{ORG_PREFIX}codaDimension1__c> dim1Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension1__c WHERE Name IN ('#{$bd_dim1_usd}','#{$bd_apex_eur_001}') ORDER BY Name];"
    _active_allocation_rule += "List<#{ORG_PREFIX}codaDimension2__c> dim2Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension2__c WHERE Name IN ('#{$bd_dim2_usd}','#{$bd_apex_eur_002}') ORDER BY Name];"
    _active_allocation_rule += "List<#{ORG_PREFIX}codaDimension3__c> dim3Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension3__c WHERE Name IN ('#{$bd_dim3_usd}','#{$bd_apex_eur_003}') ORDER BY Name];"
    _active_allocation_rule += "List<#{ORG_PREFIX}codaDimension4__c> dim4Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension4__c WHERE Name IN ('#{$bd_dim4_usd}','#{$bd_apex_eur_004}') ORDER BY Name];"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension1__c = dim1Ids[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension2__c = dim2Ids[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension3__c = dim3Ids[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Dimension4__c = dim4Ids[0].Id;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}Split__c = 20.00;"
	_active_allocation_rule += "fixedallocRuleLine.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine);"
	
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine1 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}Dimension1__c = dim1Ids[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}Split__c = 30.00;"
	_active_allocation_rule += "fixedallocRuleLine1.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine1);"
	
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine2 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[2].Id;"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}Dimension2__c = dim2Ids[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}Split__c = 40.00;"
	_active_allocation_rule += "fixedallocRuleLine2.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine2);"
	
	_active_allocation_rule += "#{ORG_PREFIX}FixedAllocationRuleLine__c fixedallocRuleLine3 = new #{ORG_PREFIX}FixedAllocationRuleLine__c();"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}GeneralLedgerAccount__c = glaIds[3].Id;"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}Dimension3__c = dim3Ids[1].Id;"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}Split__c = 10.00;"
	_active_allocation_rule += "fixedallocRuleLine3.#{ORG_PREFIX}AllocationRule__c = allocRule.Id;"
	_active_allocation_rule += "allocFixedRuleLines.add(fixedallocRuleLine3);"
	_active_allocation_rule += "insert allocFixedRuleLines;"
	
	_active_allocation_rule += "#{ORG_PREFIX}AllocationRule__c getAllocationRule = [SELECT #{ORG_PREFIX}Active__c FROM #{ORG_PREFIX}AllocationRule__c WHERE Id = :allocRule.Id];"
	_active_allocation_rule += "getAllocationRule.#{ORG_PREFIX}Active__c = true;"
	_active_allocation_rule += "update getAllocationRule;"
	
	before :all do
		gen_start_test "TID021445 - Verify that user can create, save and load template for Fixed Allocation Type"
		begin
			# Hold Base Data
			FFA.hold_base_data_and_wait
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true

			#Create and post sales invoice through API
			APEX.execute_commands [_post_with_API,_active_allocation_rule]
		end			
	end

	it "TID021445 : Verify that user can create, save, edit and load template for Fixed Allocation Type" do
		begin
			gen_start_test "TST037607 || Verify that user can create and save new template of Fixed Allocation Type with Fixed Allocation Rule"
				SF.tab $tab_allocations
				SF.click_button_new
				gen_wait_until_object_disappear $ffa_msg_loading
				
				#Verify that save template button is disabled when user has not entered any filter
				gen_wait_until_object $alloc_to_period_field
				expect(page.has_text?($alloc_retrieve_source_page_label)).to be true
				gen_report_test "Retrieve source page is displayed"
				
				Allocations.set_allocation_type $alloc_type_label
				gen_assert_disabled $alloc_template_save
				gen_report_test "Template Save button is disabled"
				
				#Set Allocation filter criteria 
				Allocations.set_timeperiod_period_selection '',current_period
				#Allocation filter 1
				Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
				
				#Select the Allocation Method
				Allocations.click_on_next_button
				gen_compare amount_value,Allocations.get_total_value,"Value retrieved is €(15.00)"
				Allocations.select_fixed_allocation_method_button
				
				#Set the Rule Name in the Allocation Rule Picklist
				Allocations.click_on_next_button
				Allocations.set_rule_name allocation_rule_name_1

				#Navigate to Preview and Post screen
				Allocations.click_on_next_button
				Allocations.set_destination_document_description destination_document_description
				Allocations.set_destination_document_type_value destination_document_type
				
				#Saving the template
				Allocations.save_template
				gen_assert_disabled $alloc_template_save_popup_save_button
				gen_report_test "Save Template popup save button is disabled"
				Allocations.set_popup_template_name template_name
				Allocations.set_popup_template_description template_description
				Allocations.popup_save_template
				gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'

				#Verify that template is present on Allocation Template List View
				SF.tab $tab_allocation_template
				SF.click_button_go
				gen_compare_has_content template_name, true, "Expected #{template_name}is present"
				AllocationTemplate.open_allocation_template_detail_page template_name
				gen_compare true, Allocations.assert_filterset_gla_value(1,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd), "Expected GLA is #{$bd_gla_account_receivable_control_usd}"
				gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected is 1"
				gen_compare amount_value,Allocations.get_total_value,"Total value matched successfully"
				Allocations.click_on_next_button
				gen_compare true,Allocations.is_fixed_allocation_method_selected?,"Fixed option button is selected"
				Allocations.click_on_next_button

				#Verify the values of Fixed Allocation Rule is displayed
				gen_compare allocation_rule_name_1,Allocations.get_selected_fixed_allocation_rule,"Allocation Rule is matched"
				gen_compare row_1, Allocations.get_fixed_distribution_grid_row(1),"Expected Row 1 is matched"
				gen_compare row_2, Allocations.get_fixed_distribution_grid_row(2),"Expected Row 2 is matched"
				gen_compare row_3, Allocations.get_fixed_distribution_grid_row(3),"Expected Row 3 is matched"
				gen_compare row_4, Allocations.get_fixed_distribution_grid_row(4),"Expected Row 4 is matched"

				#Go to Next Screen
				Allocations.click_on_next_button
				gen_compare destination_document_type,Allocations.get_destination_document_type,"Document type is #{destination_document_type}"
				gen_compare destination_document_description,Allocations.get_destination_document_description,"Template despription is #{destination_document_description}"
			gen_end_test "TST037607 || Verify that user can create and save new template of Fixed Allocation Type with Fixed Allocation Rule"

			gen_start_test "TST037608 || Verify the warning message when user edit the Fixed Allocation Rule and save template"
				Allocations.click_on_back_button
				Allocations.set_split_line_dimension4 4,$bd_apex_eur_004

				#Saving the Rule
				Allocations.click_on_next_button
				gen_compare rule_save_warning,Allocations.get_error_message,"Warning Message to save Fixed Allocation Rule displayed"
			gen_end_test "TST037608 || Verify the warning message when user edit the Fixed Allocation Rule and save template"
			
			gen_start_test "TST037609 || Verify that Allocation Rule gets saved when user clicks Yes Button on Rule save warning message popup"
				Allocations.click_continue_button_on_popup
				gen_wait_until_object_disappear $page_loadmask_message
				Allocations.save_template
				gen_compare template_name,Allocations.get_popup_template_name,"Template Name is #{template_name}"
				gen_compare template_description,Allocations.get_popup_template_description,"Template Description is #{template_description}"
				Allocations.popup_save_template
				gen_compare template_override,Allocations.get_popup_template_message,"Message to override template is displayed"
				#Override the template
				Allocations.popup_save_template
				gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'

				#Verify the Allocation Rule
				SF.tab $tab_allocation_rules
				SF.click_button_go
				AllocationRules.open_allocation_rule_detail_page allocation_rule_name_1

				gen_compare row,AllocationRules.get_allocation_rule_grid_row(4),"Expected row on Fixed Allocation Rule grid is saved"
			gen_end_test "TST037609 || Verify that Allocation Rule gets saved when user clicks Yes Button on Rule save warning message popup"

			gen_start_test "TST037970 || Verify that Allocation Rule gets disassociated when user clicks No Button on Rule save warning message popup"
				#Verify the Loading of Allocation Template
				SF.tab $tab_allocations
				SF.click_button_new
				gen_wait_until_object_disappear $ffa_msg_loading
				Allocations.set_template template_name
				Allocations.load_template
				gen_compare true, Allocations.assert_filterset_gla_value(1,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd), "Expected GLA is #{$bd_gla_account_receivable_control_usd}"
				gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected"
				gen_compare amount_value,Allocations.get_total_value,"Total value matched successfully"
				Allocations.click_on_next_button
				gen_compare true,Allocations.is_fixed_allocation_method_selected?,"Fixed option button is selected"
				Allocations.click_on_next_button

				#Verify the values of Fixed Allocation Rule is displayed
				gen_compare row_1, Allocations.get_fixed_distribution_grid_row(1),"Expected Row 1 is matched"
				gen_compare row_2, Allocations.get_fixed_distribution_grid_row(2),"Expected Row 2 is matched"
				gen_compare row_3, Allocations.get_fixed_distribution_grid_row(3),"Expected Row 3 is matched"
				gen_compare updated_row_4, Allocations.get_fixed_distribution_grid_row(4),"Expected Row 4 is matched"
				Allocations.set_split_line_dimension4 4,nil

				#Saving the template
				Allocations.click_on_next_button
				gen_compare rule_save_warning,Allocations.get_error_message,"Message to save Fixed Allocation Rule displayed"
				Allocations.click_no_button_on_popup
				gen_wait_until_object_disappear $page_loadmask_message
				Allocations.save_template
				Allocations.popup_save_template
				gen_compare template_override,Allocations.get_popup_template_message,"Message to override template is displayed"
				Allocations.popup_save_template
				gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'
				
				gen_compare destination_document_type,Allocations.get_destination_document_type,"Document type is #{destination_document_type}"
				gen_compare destination_document_description,Allocations.get_destination_document_description,"Template despription is #{destination_document_description}"

				#Verify the Disassociation
				SF.tab $tab_allocation_template
				SF.click_button_go
				gen_compare_has_content template_name, true, "Expected Allocation Template 2 is present"
				AllocationTemplate.open_allocation_template_detail_page template_name
				gen_compare true, Allocations.assert_filterset_gla_value(1,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd), "Expected GLA is #{$bd_gla_account_receivable_control_usd}"
				gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected"
				gen_compare amount_value,Allocations.get_total_value,"Total value matched successfully"
				Allocations.click_on_next_button
				gen_compare true,Allocations.is_fixed_allocation_method_selected?,"Fixed option button is selected"
				Allocations.click_on_next_button

				#Verify the values of Fixed Allocation Rule is displayed
				gen_compare "",Allocations.get_selected_fixed_allocation_rule,"Rule should be disassociated"
				gen_compare row_1, Allocations.get_fixed_distribution_grid_row(1),"Expected Row 1 is matched"
				gen_compare row_2, Allocations.get_fixed_distribution_grid_row(2),"Expected Row 2 is matched"
				gen_compare row_3, Allocations.get_fixed_distribution_grid_row(3),"Expected Row 3 is matched"
				gen_compare row_4, Allocations.get_fixed_distribution_grid_row(4),"Expected Row 4 is matched"
			gen_end_test "TST037970 || Verify that Allocation Rule gets disassociated when user clicks No Button on Rule save warning message popup"
		end
	end

	after :all do
		login_user
		#Delete Test Data
		_destroy_data = "delete[SELECT Id FROM #{ORG_PREFIX}AllocationTemplate__c];"
		_destroy_data_1 = "delete[SELECT Id FROM #{ORG_PREFIX}AllocationRule__c];" 
		APEX.execute_commands [_destroy_data,_destroy_data_1]
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID021445 - Verify that user can create, save, edit and load template for Fixed Allocation Type"
	end
end
	