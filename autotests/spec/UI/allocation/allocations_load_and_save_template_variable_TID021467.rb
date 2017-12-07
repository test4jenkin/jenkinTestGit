#--------------------------------------------------------------------#
#	TID : TID021467
#   Org Type : Managed and Unmanaged
#	Pre-Requisite: Org with basedata deployed
#	Product Area: Allocations
#   driver=firefox rspec spec/UI/allocation/allocations_load_and_save_template_variable_TID021467.rb -o TID021467.html
#   
#--------------------------------------------------------------------#
describe "TID021467 - Verify that user can create, save and load template for Allocation Type = Variable and Basis Type = Statistical", :type => :request do
	include_context "login"
	
	amount_value = "€(15.00)"
	allocation_rule_name_1 = "StatisticalAR_1"
	allocation_rule_description_1 = "Active Allocation Rule 1"
	todays_date = Date.today
	current_period = FFA.get_period_by_date todays_date
	basis_name_1 = "Head Count"
	basis_description_1 = "contains the headcount of people in different region"
	destination_document_description = "Testing Save & Load Template"
	destination_document_description_1 = "Testing Save & Load Template Update"
	destination_document_type = "Journals"
	template_name = "Template Variable Allocation"
	template_description = "Template for Variable Allocation Rule"
	rule_save_warning = "You have edited the selected allocation rule, but have not saved your changes. Click Yes to update the rule. Click No to use the edited rule details for this allocation only and leave the original allocation rule unchanged."
	template_success = FFA.fetch_label 'AllocationSaveTemplateSuccess'
	template_override = FFA.fetch_label 'AllocationOverWriteName'
	template_save_confirmation = FFA.fetch_label 'AllocationTemplateSaveConfirmation'
	dimension_1 = "Dimension 1"
	dimension_2 = "Dimension 2"
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
	
	#Create an active Statistical allocation rule 
	_active_allocation_rule = "List<#{ORG_PREFIX}codaDimension1__c> dim1Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension1__c WHERE Name IN ('#{$bd_dim1_new_york}','#{$bd_dim1_queensland}','#{$bd_dim1_tasmania}','#{$bd_dim1_massachusetts}') ORDER BY Name];"
	_active_allocation_rule += "List<#{ORG_PREFIX}codaDimension2__c> dim2Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension2__c WHERE Name IN ('#{$bd_dim2_usd}','#{$bd_apex_eur_002}') ORDER BY Name];"
		
	_active_allocation_rule += "#{ORG_PREFIX}StatisticalBasis__c basis = new #{ORG_PREFIX}StatisticalBasis__c();"
	_active_allocation_rule += "basis.Name = '#{basis_name_1}';"
	_active_allocation_rule += "basis.#{ORG_PREFIX}Description__c = '#{basis_description_1}';"
	_active_allocation_rule += "basis.#{ORG_PREFIX}UnitOfMeasure__c = 'People';"
	_active_allocation_rule += "basis.#{ORG_PREFIX}Date__c = System.today();"
	_active_allocation_rule += "insert basis;"
			
	_active_allocation_rule += "List<#{ORG_PREFIX}StatisticalBasisLineItem__c> lines = new List<#{ORG_PREFIX}StatisticalBasisLineItem__c>();"
	_active_allocation_rule += "lines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.Id, #{ORG_PREFIX}Dimension1__c = dim1Ids[0].Id, #{ORG_PREFIX}Dimension2__c = dim2Ids[0].Id, #{ORG_PREFIX}Value__c = 10));"
	_active_allocation_rule += "lines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.Id, #{ORG_PREFIX}Dimension1__c = dim1Ids[1].Id, #{ORG_PREFIX}Dimension2__c = dim2Ids[0].Id, #{ORG_PREFIX}Value__c = 20));"
	_active_allocation_rule += "lines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.Id, #{ORG_PREFIX}Dimension1__c = dim1Ids[2].Id, #{ORG_PREFIX}Dimension2__c = dim2Ids[0].Id, #{ORG_PREFIX}Value__c = 30));"
	_active_allocation_rule += "lines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.Id, #{ORG_PREFIX}Dimension1__c = dim1Ids[3].Id, #{ORG_PREFIX}Dimension2__c = dim2Ids[0].Id, #{ORG_PREFIX}Value__c = 40));"
	_active_allocation_rule += "lines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.Id, #{ORG_PREFIX}Dimension1__c = dim1Ids[0].Id, #{ORG_PREFIX}Dimension2__c = dim2Ids[1].Id, #{ORG_PREFIX}Value__c = 50));"
	_active_allocation_rule += "insert lines;"
				
	_active_allocation_rule += "#{ORG_PREFIX}AllocationRule__c allocationRule = new #{ORG_PREFIX}AllocationRule__c();"
	_active_allocation_rule += "allocationRule.Name = '#{allocation_rule_name_1}';"
	_active_allocation_rule += "allocationRule.#{ORG_PREFIX}Type__c = 'Variable';"
	_active_allocation_rule += "allocationRule.#{ORG_PREFIX}Active__c = true;"
	_active_allocation_rule += "allocationRule.#{ORG_PREFIX}StatisticalBasis__c = basis.Id;"
	_active_allocation_rule += "allocationRule.#{ORG_PREFIX}DistributionFields__c = 'Dimension 1 ;Dimension 2';"
	_active_allocation_rule += "insert allocationRule;"
		
	before :all do
		gen_start_test "TID021467 | Verify that user can create, save and load template for Allocation Type = Variable"
		begin
			# Hold Base Data
			FFA.hold_base_data_and_wait
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			#Execute Commands
			APEX.execute_commands [_post_with_API,_active_allocation_rule]
		end			
	end

	it "TID021467 | Verify that user can create, save and load template for Allocation Type = Variable" do
		begin
			gen_start_test "TST037667 : Verify that user can successfully save the template with Allocation method = Variable"
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
				gen_compare "€(15.00)",Allocations.get_total_value,"Value retrieved is €(15.00)"
				Allocations.select_variable_allocation_method_button
				
				#Set Allocation Rule
				Allocations.click_on_next_button
				Allocations.select_variable_rule_name allocation_rule_name_1
				gen_wait_until_object_disappear $page_loadmask_message

				#Provide the distribute to GLA field
				Allocations.click_on_next_button
				Allocations.select_distribute_to_gla_radio_button
				Allocations.set_glas_in_distribute_to_gla_picklist [$bd_gla_apexaccgla001]

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
				gen_compare template_success,Allocations.get_toast_message,"Success Template Save Toast message appears"
				
				#Verify that template is present on Allocation Template List View
				SF.tab $tab_allocation_template
				SF.click_button_go
				gen_compare_has_content template_name, true, "Expected #{template_name}is present"
				AllocationTemplate.open_allocation_template_detail_page template_name
				gen_compare true, Allocations.assert_filterset_gla_value(1,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd), "Expected GLA is #{$bd_gla_account_receivable_control_usd}"
				gen_compare "1", Allocations.get_filters_selected_value,"Number of filter selected is 1"
				gen_compare amount_value,Allocations.get_total_value,"Total value matched successfully"
				Allocations.click_on_next_button
				gen_compare true,Allocations.is_variable_allocation_method_selected?,"Variable option button is selected"
				Allocations.click_on_next_button

				#Verify the Variable Allocation Rule is displayed
				gen_compare allocation_rule_name_1,Allocations.get_variable_rule_name,"Allocation Rule is matched"

				#Go to Next Screen
				Allocations.click_on_next_button
				gen_compare true,Allocations.assert_distribute_to_gla_selected_value([$bd_gla_apexaccgla001]),"Expected Distribute to GLA Values found"
				
				#Go to Post Screen
				Allocations.click_on_next_button
				gen_compare destination_document_type,Allocations.get_destination_document_type,"Document type is #{destination_document_type}"
				gen_compare destination_document_description,Allocations.get_destination_document_description,"Template despription is #{destination_document_description}"
			gen_end_test "TST037667 : Verify that user can successfully save the template with Allocation method = Variable"
			
			gen_start_test "TST037668 : Verify the warning message when user edit the statistical Allocation Rule and save template"
				Allocations.click_on_back_button
				Allocations.click_on_back_button
				Allocations.remove_distribution_field "Dimension 2"

				#Saving the template
				Allocations.click_on_next_button
				gen_compare rule_save_warning,Allocations.get_error_message,"Warning Message to save Variable Allocation Rule displayed"
			gen_end_test "TST037668 : Verify the warning message when user edit the statistical Allocation Rule and save template"
			
			
			gen_start_test "TST037669 : Verify that Allocation Rule gets saved when user clicks Yes Button on Allocation Rule save warning message popup"
				Allocations.click_continue_button_on_popup
				gen_wait_until_object_disappear $page_loadmask_message
				Allocations.click_on_next_button
				Allocations.save_template
				gen_compare template_name,Allocations.get_popup_template_name,"Template Name is #{template_name}"
				gen_compare template_description,Allocations.get_popup_template_description,"Template Description is #{template_description}"
				Allocations.popup_save_template
				gen_compare template_override,Allocations.get_popup_template_message,"Message to override template is displayed"
				#Override the template
				Allocations.popup_save_template
				gen_compare template_success,Allocations.get_toast_message,"Success Template Save Toast message appears"

				#Verify the Allocation Rule
				SF.tab $tab_allocation_rules
				SF.click_button_go
				AllocationRules.open_allocation_rule_detail_page allocation_rule_name_1
				gen_compare false,AllocationRules.is_distribution_field_selected?(dimension_2),"Dimension 2 is not displayed in Distribution Field List"
				gen_compare true,AllocationRules.is_distribution_field_selected?(dimension_1),"Dimension 1 is displayed in Distribution Field List"
			gen_end_test "TST037669 : Verify that Allocation Rule gets saved when user clicks Yes Button on Allocation Rule save warning message popup"
			
			gen_start_test "TST037670 : Verify that Allocation Rule gets disassociated when user clicks No Button on Rule save warning message popup"
				#Verify the Loading of Allocation Template
				SF.tab $tab_allocations
				SF.click_button_new
				gen_wait_until_object_disappear $ffa_msg_loading
				Allocations.set_template template_name
				Allocations.load_template
				Allocations.click_on_next_button
				Allocations.click_on_next_button
				Allocations.select_distribution_fields [dimension_2]
				Allocations.click_on_next_button
				gen_compare rule_save_warning,Allocations.get_error_message,"Warning Message to save Variable Allocation Rule displayed"
				Allocations.click_no_button_on_popup
				gen_wait_until_object_disappear $page_loadmask_message
				Allocations.click_on_next_button
				Allocations.save_template
				Allocations.popup_save_template
				gen_compare template_override,Allocations.get_popup_template_message,"Message to override template is displayed"
				#Override the template
				Allocations.popup_save_template
				gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'
				
				#Verify the template
				SF.tab $tab_allocation_template
				SF.click_button_go
				AllocationTemplate.open_allocation_template_detail_page template_name
				Allocations.click_on_next_button
				Allocations.click_on_next_button
				gen_compare "",Allocations.get_variable_rule_name,"Allocation Rule is disassociated"
				gen_compare basis_name_1,Allocations.get_statistical_bases,"Statisitcal Basis #{basis_name_1} is present"
				gen_compare true,AllocationRules.is_distribution_field_selected?(dimension_1),"Dimension 1 is displayed in Distribution Field List"
				gen_compare true,AllocationRules.is_distribution_field_selected?(dimension_2),"Dimension 2 is displayed in Distribution Field List"
				Allocations.click_on_next_button
				gen_compare true,Allocations.assert_distribute_to_gla_selected_value([$bd_gla_apexaccgla001]),"Expected Distribute to GLA Values found"
			gen_end_test "TST037670 : Verify that Allocation Rule gets disassociated when user clicks No Button on Rule save warning message popup"
			
			gen_start_test "TST037969 : Verify the warning message on Post button if user changes any value in the template after loading it"
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
				gen_compare true,Allocations.is_variable_allocation_method_selected?,"Variable option button is selected"
				Allocations.click_on_next_button
						
				#Verify the values of Variable Allocation Rule is displayed
				gen_compare "",Allocations.get_variable_rule_name,"Allocation Rule is disassociated"
				gen_compare basis_name_1,Allocations.get_statistical_bases,"Statisitcal Basis #{basis_name_1} is present"
				gen_compare true,AllocationRules.is_distribution_field_selected?(dimension_1),"Dimension 1 is displayed in Distribution Field List"
				gen_compare true,AllocationRules.is_distribution_field_selected?(dimension_2),"Dimension 2 is displayed in Distribution Field List"
				Allocations.click_on_next_button
				gen_compare true,Allocations.assert_distribute_to_gla_selected_value([$bd_gla_apexaccgla001]),"Expected Distribute to GLA Values found"
				Allocations.click_on_next_button
				gen_compare destination_document_type,Allocations.get_destination_document_type,"Document type is #{destination_document_type}"
				gen_compare destination_document_description,Allocations.get_destination_document_description,"Template despription is #{destination_document_description}"
				Allocations.set_destination_document_description destination_document_description_1

				Allocations.click_on_post_button
				gen_compare template_save_confirmation,Allocations.get_error_message,'Save template Message popup is displayed'
				Allocations.click_continue_button_on_popup
				gen_wait_until_object_disappear $page_loadmask_message

				#Verify that template is saved
				SF.tab $tab_allocations
				SF.click_button_new
				gen_wait_until_object_disappear $ffa_msg_loading
				Allocations.set_template template_name
				Allocations.load_template
				Allocations.click_on_next_button
				Allocations.click_on_next_button
				Allocations.click_on_next_button
				Allocations.click_on_next_button
				gen_compare destination_document_description_1,Allocations.get_destination_document_description,"Template description is #{destination_document_description_1}"
			gen_end_test "TST037969 : Verify the warning message on Post button if user changes any value in the template after loading it"
		end
	end

	after :all do
		login_user
		# Delete Test Data
		_destroy_data = "delete[SELECT Id FROM #{ORG_PREFIX}AllocationTemplate__c];"
		_destroy_data_1 = "delete[SELECT Id FROM #{ORG_PREFIX}AllocationRule__c];"
		_destroy_data_1 += "delete[SELECT Id from #{ORG_PREFIX}StatisticalBasis__c];"     
		APEX.execute_commands [_destroy_data,_destroy_data_1]
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID021467 | Verify that user can create, save and load template for Allocation Type = Variable"
	end
end
	