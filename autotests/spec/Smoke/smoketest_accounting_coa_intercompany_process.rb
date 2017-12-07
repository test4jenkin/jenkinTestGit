#--------------------------------------------------------------------#
#	TID : TID019992
# 	Pre-Requisite : smoketest_data_setup.rb , setup_smoketest_data_ext.rb
#  	Product Area:  Accounting - Chart of Accounts.
#--------------------------------------------------------------------#

describe "TID019992 Smoke Test: TST032581_82_83_84:Verify that Local GLA is supported on all document with intercompany process for Sales Invoice and Sales Credite Note.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	#variables
	_gla_4001 = "4001"
    _gla_6000 = "6000"
	_gla_7000 = "7000"
	_reporting_code_local = "Local";
	current_date = Time.now.strftime("%d/%m/%Y")
	_name_corporate = "Corporate"
	_name_usa = "USA"
	_name_spain = "Spain"
	_name_french = "French"
	_coa_corporate_query = "SELECT ID, Name from #{ORG_PREFIX}ChartOfAccountsStructure__c  WHERE Name = '#{$sf_param_substitute}'"
	_sin_description = "SINV"
	_scrn_description = "SCRN"
	_pinv_description = "PINV"
	_pcrn_description = "PCRN"
	_jrnl_description = "JRNL"
	_line_description = "Line Description"
	
	_sin1_description = _sin_description+"1"
	_sin1_line1_description = _sin1_description + _line_description + "1"
	_sin1_line2_description = _sin1_description + _line_description + "2"
	_sin1_line3_description = _sin1_description + _line_description + "3"
	_sin1_line4_description = _sin1_description + _line_description + "4"
	_sin2_description = _sin_description+"2"
	_sin2_line1_description = _sin2_description + _line_description + "1"
	_sin2_line2_description = _sin2_description + _line_description + "2"
	_sin2_line3_description = _sin2_description + _line_description + "3"
	_sin2_line4_description = _sin2_description + _line_description + "4"
	_sin3_description = _sin_description+"3"
	_sin3_line1_description = _sin3_description + _line_description + "1"
	_sin3_line2_description = _sin3_description + _line_description + "2"
	_sin3_line3_description = _sin3_description + _line_description + "3"
	_sin3_line4_description = _sin3_description + _line_description + "4"
	_sin4_description = _sin_description+"4"
	_sin4_line1_description = _sin4_description + _line_description + "1"
	_sin4_line2_description = _sin4_description + _line_description + "2"
	_sin4_line3_description = _sin4_description + _line_description + "3"
	_sin4_line4_description = _sin4_description + _line_description + "4"
	
	_scr1_description = _scrn_description + "1"
	_scr1_line1_description = _scr1_description + _line_description + "1"
	_scr1_line2_description = _scr1_description + _line_description + "2"
	_scr1_line3_description = _scr1_description + _line_description + "3"
	_scr1_line4_description = _scr1_description + _line_description + "4"
	_scr2_description = _scrn_description + "2"
	_scr2_line1_description = _scr2_description + _line_description + "1"
	_scr2_line2_description = _scr2_description + _line_description + "2"
	_scr2_line3_description = _scr2_description + _line_description + "3"
	_scr2_line4_description = _scr2_description + _line_description + "4"
	_scr3_description = _scrn_description + "3"
	_scr3_line1_description = _scr3_description + _line_description + "1"
	_scr3_line2_description = _scr3_description + _line_description + "2"
	_scr3_line3_description = _scr3_description + _line_description + "3"
	_scr3_line4_description = _scr3_description + _line_description + "4"
	_scr4_description = _scrn_description + "4"
	_scr4_line1_description = _scr4_description + _line_description + "1"
	_scr4_line2_description = _scr4_description + _line_description + "2"
	_scr4_line3_description = _scr4_description + _line_description + "3"
	_scr4_line4_description = _scr4_description + _line_description + "4"

	_pinv1_description = _pinv_description + "1"
	_pinv1_line1_description= _pinv1_description + _line_description + "1"
	_pinv1_line2_description= _pinv1_description + _line_description + "2"
	_pinv1_line3_description= _pinv1_description + _line_description + "3"
	_pinv1_line4_description= _pinv1_description + _line_description + "4"
	
	_pinv2_description = _pinv_description + "2"
	_pinv2_line1_description= _pinv2_description + _line_description + "1"
	_pinv2_line2_description= _pinv2_description + _line_description + "2"
	_pinv2_line3_description= _pinv2_description + _line_description + "3"
	_pinv2_line4_description= _pinv2_description + _line_description + "4"
	
	_pcrn1_description = _pcrn_description + "1"
	_pcrn1_line1_description= _pcrn1_description + _line_description + "1"
	_pcrn1_line2_description= _pcrn1_description + _line_description + "2"
	_pcrn1_line3_description= _pcrn1_description + _line_description + "3"
	_pcrn1_line4_description= _pcrn1_description + _line_description + "4"
	
	_pcrn2_description = _pcrn_description + "2"
	_pcrn2_line1_description= _pcrn2_description + _line_description + "1"
	_pcrn2_line2_description= _pcrn2_description + _line_description + "2"
	_pcrn2_line3_description= _pcrn2_description + _line_description + "3"
	_pcrn2_line4_description= _pcrn2_description + _line_description + "4"
	
	_source_scr_number_label = "Source Sales Credit Note Number"
	_source_sin_number_label = "Source Sales Invoice Number"
	_source_document_description = "Source Document Description"
	
	_dim_type_dim2 = 'Dimension 2'
	_dim_type_dim3 = 'Dimension 3'
	_dim_type_na = "Not Applicable"
	_name_space_name= ORG_PREFIX.gsub("__", ".").sub(" ","") 
	
	_soql_sales_invoice_by_desc = "select Name from #{ORG_PREFIX}codaInvoice__c where #{ORG_PREFIX}InvoiceDescription__c ='#{$sf_param_substitute}'"
	_soql_sales_credit_note_by_desc = "select Name from #{ORG_PREFIX}codaCreditNote__c where #{ORG_PREFIX}CreditNoteDescription__c ='#{$sf_param_substitute}'"
	_soql_pinv_by_desc = "select Name from #{ORG_PREFIX}codaPurchaseInvoice__c where #{ORG_PREFIX}InvoiceDescription__c ='#{$sf_param_substitute}'"
	_soql_pcrn_by_desc = "select Name from #{ORG_PREFIX}codaPurchaseCreditNote__c where #{ORG_PREFIX}CreditNoteDescription__c ='#{$sf_param_substitute}'"
	# using below boolen value to revert the chnages as per the active status of the chart of accounts 
	is_chart_of_account_status_active = false 	
	before :all do
		#Hold Base Data
		gen_start_test "TID019992"	
		FFA.hold_base_data_and_wait
		#Additional data information"
		#Intercompany Definitions Spain to USA
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_usa ,$bd_gla_account_payable_control_eur, nil , $bd_dim2_eur , nil, nil ,$bd_gla_account_receivable_control_eur ,nil ,  $bd_dim2_eur , nil , nil
			SF.click_button_save
			page.has_css?($icd_intercompany_definition_number)
			expect(page).to have_css($icd_intercompany_definition_number)
			gen_report_test "Expected Intercompany definition for merlin auto Spain to USA  to be created successfully."
		end
		## Intercompany Definitions USA to Spain
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_spain , $bd_gla_account_payable_control_usd, nil , $bd_dim2_usd , nil,nil ,$bd_gla_account_receivable_control_usd ,nil , $bd_dim2_usd , nil , nil
			SF.click_button_save
			page.has_css?($icd_intercompany_definition_number)
			expect(page).to have_css($icd_intercompany_definition_number)
			gen_report_test "Expected Intercompany definition for merlin auto USA to Spain  to be created successfully."
		end
		
		begin
			##Allow use local GLA
			custom_setting ="list<#{ORG_PREFIX}codaAccountingSettings__c> settingList = [Select Id from #{ORG_PREFIX}codaAccountingSettings__c];"
			custom_setting +="#{ORG_PREFIX}codaAccountingSettings__c setting;"
			custom_setting +="if(settingList.size() == 0)"
			custom_setting +="{"
			custom_setting +="setting = new #{ORG_PREFIX}codaAccountingSettings__c();"
			custom_setting +="}"
			custom_setting +="else"
			custom_setting +="{"
			custom_setting +="setting = settingList[0];"
			custom_setting +="}"
			custom_setting += "setting.#{ORG_PREFIX}AllowUseOfLocalGLAs__c = true;"
			custom_setting += "setting.#{ORG_PREFIX}EnableOverrideProductGLA__c = true;"
			custom_setting += "UPSERT setting;"
			APEX.execute_commands [custom_setting]
			
			#create corporate  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_corporate
			COAS.set_default_corporate true
			COAS.set_active true
			SF.click_button_save
			gen_compare_has_content _name_corporate , true , "COA " +_name_corporate +" created."
			
			#create USA  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_usa
			COAS.set_default_corporate false
			COAS.set_active false
			SF.click_button_save
			gen_compare_has_content _name_usa , true , "COA " +_name_usa +" created."
			
			#create Spain  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_spain
			COAS.set_default_corporate false
			COAS.set_active false
			SF.click_button_save
			gen_compare_has_content _name_spain , true , "COA " +_name_spain +" created."
			
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_corporate )
			coa_corporate_id = APEX.get_field_value_from_soql_result "Id"
			
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_usa )
			coa_usa_id = APEX.get_field_value_from_soql_result "Id"
			
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_spain )
			coa_spain_id = APEX.get_field_value_from_soql_result "Id"
			
			gla_list_query = "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaList = new List<#{ORG_PREFIX}codaGeneralLedgerAccount__c>();"
			gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c glaCorporate = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_4001}', #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = 'Corporate1', #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_corporate_id}');"
			gla_list_query += "glaList.add(glaCorporate);"			
			gla_list_query += "for(integer i=1;i<=12;i++)"
			gla_list_query += "{"
			gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla2 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_6000}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_local}' + i, #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_spain_id}');" 
			gla_list_query += "glaList.add(gla2);"
			gla_list_query += "}"	

			gla_list_query += "for(integer i=1;i<=12;i++)"
			gla_list_query += "{"
			gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla3 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_7000}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_local}' + (i+12), #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_usa_id}');" 
			gla_list_query += "glaList.add(gla3);"
			gla_list_query += "}"	
			gla_list_query += "INSERT glaList;"		
			APEX.execute_commands [gla_list_query]
			
			#Active local COA = Spain
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_go
			SF.click_link _name_spain
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button	
			COAS.set_default_corporate_gla _gla_4001
			COAS.set_default_local_gla "60001"
			COAS.set_active true
			SF.click_button_save

			#Active local COA  = USA
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_go
			SF.click_link _name_usa
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button	
			COAS.set_default_corporate_gla _gla_4001
			COAS.set_default_local_gla "70001"
			COAS.set_active true
			SF.click_button_save

			update_corporate_glas = "Set<String> corporateGla = new Set<String>();"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_payable_control_eur}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_receivable_control_usd}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_receivable_control_eur}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_payable_control_usd}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_sales_parts}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_stock_parts}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_postage_and_stationery}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_vat_output}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_marketing}');"			
			update_corporate_glas += "List<#{ORG_PREFIX}CODAGeneralLedgerAccount__c> corporateGLAs = [Select Id, Name from #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name in :corporateGla];"
			#add corporate chart of account structure in corporate glas
			update_corporate_glas += "for(#{ORG_PREFIX}CODAGeneralLedgerAccount__c corpGLA : corporateGLAs)"
			update_corporate_glas += "corpGLA.#{ORG_PREFIX}ChartOfAccountsStructure__c = '#{coa_corporate_id}';"
			update_corporate_glas += "update corporateGLAs;"
			APEX.execute_commands [update_corporate_glas]
			
			#Create Spain COA mappings and USA COA Mappings
			glaString =  "Map<String, #{ORG_PREFIX}CODAGeneralLedgerAccount__c> glaMap = new Map<String, #{ORG_PREFIX}CODAGeneralLedgerAccount__c>();"
			glaString += "Set<String> glaSet = new Set<String>();"
			glaString += "glaSet.add('#{$bd_gla_account_payable_control_eur}');"
			glaString += "glaSet.add('#{$bd_gla_account_receivable_control_usd}');"
			glaString += "glaSet.add('#{$bd_gla_account_receivable_control_eur}');"
			glaString += "glaSet.add('#{$bd_gla_account_payable_control_usd}');"
			glaString += "glaSet.add('#{$bd_gla_sales_parts}');"
			glaString += "glaSet.add('#{$bd_gla_stock_parts}');"
			glaString += "glaSet.add('#{$bd_gla_postage_and_stationery}');"
			glaString += "glaSet.add('#{$bd_gla_vat_output}');"
			glaString += "glaSet.add('#{$bd_gla_marketing}');"			
			glaString += "glaSet.add('4001');"			
			glaString += "glaSet.add('60001');"			
			glaString += "glaSet.add('60002');"			
			glaString += "glaSet.add('60003');"			
			glaString += "glaSet.add('60004');"			
			glaString += "glaSet.add('60005');"			
			glaString += "glaSet.add('60006');"			
			glaString += "glaSet.add('60007');"			
			glaString += "glaSet.add('60008');"			
			glaString += "glaSet.add('60009');"			
			glaString += "glaSet.add('600010');"			
			glaString += "glaSet.add('600011');"			
			glaString += "glaSet.add('600012');"			
			glaString += "glaSet.add('70001');"			
			glaString += "glaSet.add('70002');"			
			glaString += "glaSet.add('70003');"			
			glaString += "glaSet.add('70004');"			
			glaString += "glaSet.add('70005');"			
			glaString += "glaSet.add('70006');"			
			glaString += "glaSet.add('70007');"
			glaString += "glaSet.add('70008');"
			glaString += "glaSet.add('70009');"
			glaString += "glaSet.add('700010');"
			glaString += "glaSet.add('700011');"
			glaString += "glaSet.add('700012');"
			glaString += "List<#{ORG_PREFIX}CODAGeneralLedgerAccount__c> glaList = [Select Name, Id from #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name in :glaSet];"
			glaString += "for(#{ORG_PREFIX}CODAGeneralLedgerAccount__c gla : glaList)"
			glaString += "glaMap.put(gla.Name, gla);"

			glaString += "Id dim2USD = [Select Id from #{ORG_PREFIX}codaDimension2__c Where Name='#{$bd_dim2_usd}'][0].Id;"
			glaString += "Id dim2EUR = [Select Id from #{ORG_PREFIX}codaDimension2__c Where Name='#{$bd_dim2_eur}'][0].Id;"
			glaString += "Id dim3USD = [Select Id from #{ORG_PREFIX}codaDimension3__c Where Name='#{$bd_dim3_usd}'][0].Id;"

			coa_mappings_spain = "List<#{ORG_PREFIX}ChartOfAccountsMapping__c> mappings = new List<#{ORG_PREFIX}ChartOfAccountsMapping__c>();"
			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping1 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping1.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('4001').Id;"
			coa_mappings_spain += "mapping1.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60001').Id;"
			coa_mappings_spain += "mappings.add(mapping1);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping2 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping2.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_eur}').Id;"
			coa_mappings_spain += "mapping2.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60002').Id;"
			coa_mappings_spain += "mappings.add(mapping2);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping3 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping3.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_eur}').Id;"
			coa_mappings_spain += "mapping3.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60003').Id;"
			coa_mappings_spain += "mapping3.#{ORG_PREFIX}Dimension2__c = dim2EUR;"
			coa_mappings_spain += "mappings.add(mapping3);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping4 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping4.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_usd}').Id;"
			coa_mappings_spain += "mapping4.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60004').Id;"
			coa_mappings_spain += "mappings.add(mapping4);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping5 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping5.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_eur}').Id;"
			coa_mappings_spain += "mapping5.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60005').Id;"
			coa_mappings_spain += "mappings.add(mapping5);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping6 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping6.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_eur}').Id;"
			coa_mappings_spain += "mapping6.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60006').Id;"
			coa_mappings_spain += "mapping6.#{ORG_PREFIX}Dimension2__c = dim2EUR;"
			coa_mappings_spain += "mappings.add(mapping6);" 

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping7 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping7.#{ORG_PREFIX}CorporateGLA__c =glaMap.get('#{$bd_gla_account_payable_control_usd}').Id;"
			coa_mappings_spain += "mapping7.#{ORG_PREFIX}LocalGLA__c =glaMap.get('60007').Id;"
			coa_mappings_spain += "mappings.add(mapping7);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping8 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping8.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_spain += "mapping8.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60008').Id;"
			coa_mappings_spain += "mappings.add(mapping8);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping9 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping9.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_marketing}').Id;"
			coa_mappings_spain += "mapping9.#{ORG_PREFIX}LocalGLA__c =glaMap.get('60008').Id;"
			coa_mappings_spain += "mapping9.#{ORG_PREFIX}Dimension2__c =dim2USD;"
			coa_mappings_spain += "mappings.add(mapping9);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping10 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping10.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_sales_parts}').Id;"
			coa_mappings_spain += "mapping10.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60009').Id;"
			coa_mappings_spain += "mappings.add(mapping10);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping11 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping11.#{ORG_PREFIX}CorporateGLA__c =glaMap.get('#{$bd_gla_stock_parts}').Id;"
			coa_mappings_spain += "mapping11.#{ORG_PREFIX}LocalGLA__c =glaMap.get('600010').Id;"
			coa_mappings_spain += "mappings.add(mapping11);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping12 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping12.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_vat_output}').Id;"
			coa_mappings_spain += "mapping12.#{ORG_PREFIX}LocalGLA__c =glaMap.get('600011').Id;"
			coa_mappings_spain += "mappings.add(mapping12);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping25 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping25.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_spain += "mapping25.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60009').Id;"
			coa_mappings_spain += "mapping25.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_spain += "mappings.add(mapping25);"
			insert_mappings = "insert mappings;"
			APEX.execute_commands [glaString + coa_mappings_spain+insert_mappings]
			
			coa_mappings_usa = "List<#{ORG_PREFIX}ChartOfAccountsMapping__c> mappings = new List<#{ORG_PREFIX}ChartOfAccountsMapping__c>();"
			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping13 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping13.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('4001').Id;"
			coa_mappings_usa += "mapping13.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70001').Id;"
			coa_mappings_usa += "mappings.add(mapping13);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping14 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping14.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_eur}').Id;"
			coa_mappings_usa += "mapping14.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70002').Id;"
			coa_mappings_usa += "mappings.add(mapping14);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping15 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping15.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_usd}').Id;"
			coa_mappings_usa += "mapping15.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70003').Id;"
			coa_mappings_usa += "mappings.add(mapping15);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping16 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping16.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_usd}').Id;"
			coa_mappings_usa += "mapping16.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70004').Id;"
			coa_mappings_usa += "mapping16.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping16);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping17 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping17.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_eur}').Id;"
			coa_mappings_usa += "mapping17.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70005').Id;"
			coa_mappings_usa += "mappings.add(mapping17);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping18 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping18.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_usd}').Id;"
			coa_mappings_usa += "mapping18.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70006').Id;"
			coa_mappings_usa += "mappings.add(mapping18);" 

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping19 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping19.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_usd}').Id;"
			coa_mappings_usa += "mapping19.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70007').Id;"
			coa_mappings_usa += "mapping19.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping19);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping20 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping20.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_usa += "mapping20.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70008').Id;"
			coa_mappings_usa += "mappings.add(mapping20);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping21 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping21.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_marketing}').Id;"
			coa_mappings_usa += "mapping21.#{ORG_PREFIX}LocalGLA__c =glaMap.get('70009').Id;"
			coa_mappings_usa += "mapping21.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping21);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping22 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping22.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_sales_parts}').Id;"
			coa_mappings_usa += "mapping22.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70009').Id;"
			coa_mappings_usa += "mappings.add(mapping22);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping23 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping23.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_sales_parts}').Id;"
			coa_mappings_usa += "mapping23.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700010').Id;"
			coa_mappings_usa += "mapping23.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping23);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping24 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping24.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_stock_parts}').Id;"
			coa_mappings_usa += "mapping24.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700011').Id;"
			coa_mappings_usa += "mappings.add(mapping24);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping27 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping27.#{ORG_PREFIX}CorporateGLA__c =  glaMap.get('#{$bd_gla_stock_parts}').Id;"
			coa_mappings_usa += "mapping27.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700012').Id;"
			coa_mappings_usa += "mapping27.#{ORG_PREFIX}Dimension3__c =dim3USD;"
			coa_mappings_usa += "mappings.add(mapping27);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping28 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping28.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_usa += "mapping28.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700012').Id;"
			coa_mappings_usa += "mapping28.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping28);"        
			
			APEX.execute_commands [glaString + coa_mappings_usa +insert_mappings]
			
			#Set local chart of account structures = Spain on company = merlin auto spain
			update_company = "#{ORG_PREFIX}codaCompany__c  company1= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_spain}'];"
			update_company += "company1.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_spain_id}';"
			update_company += "company1.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = true;"
			update_company += "UPDATE company1;"
			#also Set local chart of account structures = USA on company = merlin auto USA 
			update_company += "#{ORG_PREFIX}codaCompany__c  company2= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
			update_company += "company2.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_usa_id}';"
			update_company += "company2.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = true;"
			update_company += "UPDATE company2;"
			#Set the Use Local Account true for the current company(Merlin Auto Spain) 
			update_company += "#{ORG_PREFIX}codaUserCompany__c user_company =  [SELECT ID, Name , #{ORG_PREFIX}company__c from #{ORG_PREFIX}codaUserCompany__c where #{ORG_PREFIX}User__r.FirstName = 'System' AND #{ORG_PREFIX}User__r.LastName = 'Administrator' AND #{ORG_PREFIX}Company__r.Name = '#{$company_merlin_auto_spain}'][0];"
			update_company += "user_company.#{ORG_PREFIX}UseLocalAccount__c = true;"
			update_company += "UPDATE  user_company;"
			APEX.execute_commands [update_company]

			# Above code will make COAs active. Therefore making the is_chart_of_account_status_active as true so that in delete data
			# these COAs can be updated and deleted properly.
			is_chart_of_account_status_active = true
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			#Sales Invoices 1 and 2
			create_sales_invoices = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_invoices += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_invoices += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_cambridge_auto}'];"
			create_sales_invoices += "for (integer i = 1; i <= 2; i++)"
			create_sales_invoices += "{"
			create_sales_invoices += "#{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice dto = new #{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice();"
			create_sales_invoices += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_invoices += "dto.InvoiceDate = Date.today();" 
			create_sales_invoices += "dto.InvoiceCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"	
			create_sales_invoices += "dto.InvoiceDescription = '#{_sin_description}'+i;"
			create_sales_invoices += "dto.DeriveCurrency = false;"
			create_sales_invoices += "dto.DerivePeriod = true;"
			create_sales_invoices += "dto.DeriveDueDate = true;"
			create_sales_invoices += "dto.LineItems = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItems();"
			create_sales_invoices += "dto.LineItems.LineItemList = new List<#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem>();"
			create_sales_invoices += "for(integer count=1; count<=4;count++)"
			create_sales_invoices += "{"
			create_sales_invoices += "#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem lineItem = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem();"
			create_sales_invoices += "lineItem.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_invoices += "lineItem.Quantity = 1;"
			create_sales_invoices += "lineItem.UnitPrice = 100;"
			create_sales_invoices += "lineItem.TaxCode1 = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_tax_code_vo_std_sales}');" 
			create_sales_invoices += "lineItem.LineDescription = '#{_sin_description}'+ i + '#{_line_description}'+count ;"
			create_sales_invoices += "lineItem.TaxCode1 = null;"
			create_sales_invoices += "lineItem.TaxValue1= null;"
			create_sales_invoices += "if(count == 2 || count == 3){lineItem.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');}"
			create_sales_invoices += "dto.LineItems.LineItemList.add(lineItem);"
			create_sales_invoices += "}"
			create_sales_invoices += "Id dto2Id = #{_name_space_name}CODAAPISalesInvoice_10_0.CreateInvoice(context, dto).Id;"
			create_sales_invoices += "#{_name_space_name}CODAAPICommon.Reference salesInvoiceIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_invoices += "}"
			
			create_sales_credit_note = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_credit_note += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_credit_note += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_cambridge_auto}'];"
			create_sales_credit_note += "for (integer i = 1; i <= 2; i++)"
			create_sales_credit_note += "{"
			create_sales_credit_note += "/* Set up header information */"
			create_sales_credit_note += "#{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote dto = new #{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote();"
			create_sales_credit_note += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_credit_note += "dto.DeriveCurrency = false;"
			create_sales_credit_note += "dto.DerivePeriod = true;"
			create_sales_credit_note += "dto.DeriveDueDate = true ;"
			create_sales_credit_note += "dto.CreditNoteDate = Date.today();" 
			create_sales_credit_note += "dto.CreditNoteCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"
			create_sales_credit_note += "dto.CreditNoteDescription = '#{_scrn_description}'+i;"

			create_sales_credit_note += "/* Now for the lines */"
			create_sales_credit_note += "dto.LineItems = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItems();"
			create_sales_credit_note += "dto.LineItems.LineItemlist = new List<#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem>();"
			create_sales_credit_note += "for ( integer j = 1; j<=4; j++)"
			create_sales_credit_note += "{"
			create_sales_credit_note += "#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem lineDto = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem();"
			create_sales_credit_note += "lineDto.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_credit_note += "lineDto.Quantity = 1;"
			create_sales_credit_note += "lineDto.UnitPrice = 100;"
			create_sales_credit_note += "LineDto.TaxCode1 = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_tax_code_vo_std_sales}');"
			create_sales_credit_note += "LineDto.LineDescription = '#{_scrn_description}'+ i + '#{_line_description}'+j;"
			create_sales_credit_note += "if(j==2 || j==3)"
			create_sales_credit_note += "lineDto.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');"
			create_sales_credit_note += "dto.LineItems.LineItemlist.Add(lineDto);"
			create_sales_credit_note += "}"
			create_sales_credit_note += "Id dto2Id = #{_name_space_name}CODAAPISalesCreditNote_10_0.CreateCreditNote(context, dto).Id;"
			create_sales_credit_note += "#{_name_space_name}CODAAPICommon.Reference salesCreditNoteIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_credit_note += "}"
						
			#Create Payable invoice 1 and 2 with line items
			create_purchase_invoices = "#{_name_space_name}CODAAPICommon_9_0.Context context = new #{_name_space_name}CODAAPICommon_9_0.Context();"
			create_purchase_invoices += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_purchase_invoices += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_audi}'];"
			create_purchase_invoices += "for (Integer i=1; i<=2; i++)"
            create_purchase_invoices += "{"
            create_purchase_invoices += "#{_name_space_name}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice pinv = new  #{_name_space_name}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();"
            create_purchase_invoices += "pinv.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);" 
			create_purchase_invoices += "pinv.AccountInvoiceNumber = 'AIN#00'+string.valueof(DateTime.now().hour())+'-'+string.valueof(DateTime.now().minute())+'-'+string.valueof(DateTime.now().second())+'-'+string.valueof(DateTime.now().millisecond());"
			create_purchase_invoices += "pinv.InvoiceDate = System.today();"
			create_purchase_invoices += "pinv.DueDate= System.today()+5;"
			create_purchase_invoices += "pinv.InvoiceDescription = '#{_pinv_description}'+i;"
			
			create_purchase_invoices += "pinv.LineItems = new  #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();"
			create_purchase_invoices += "pinv.LineItems.LineItemList = new List< #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();"
			
			create_purchase_invoices += "#{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem lineItem = new  #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			create_purchase_invoices += "lineItem.Product = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_purchase_invoices += "lineItem.Quantity = 1;"
			create_purchase_invoices += "lineItem.UnitPrice = 100;"
			create_purchase_invoices += "lineItem.LineDescription = '#{_pinv_description}'+ i + '#{_line_description}'+ '3';"
			create_purchase_invoices += "pinv.LineItems.LineItemList.add(lineItem);"

			create_purchase_invoices += "#{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem lineItem2 = new  #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			create_purchase_invoices += "lineItem2.Product = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_purchase_invoices += "lineItem2.Quantity = 1;"
			create_purchase_invoices += "lineItem2.UnitPrice = 100;"
			create_purchase_invoices += "lineItem2.Dimension3 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 3 USD');"
			create_purchase_invoices += "lineItem.LineDescription = '#{_pinv_description}'+ i + '#{_line_description}'+ '4';"
			create_purchase_invoices += "pinv.LineItems.LineItemList.add(lineItem2);"

			create_purchase_invoices += "Id dto2Id = #{_name_space_name}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, pinv).Id;"
			create_purchase_invoices += "#{_name_space_name}CODAAPICommon.Reference purchaseInvoiceIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_purchase_invoices += "}"

			#Purchase credit Note
			create_purchase_credit_note = "#{_name_space_name}CODAAPICommon_7_0.Context context = new #{_name_space_name}CODAAPICommon_7_0.Context();"
			create_purchase_credit_note += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_purchase_credit_note += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_audi}'];"
			create_purchase_credit_note += "Decimal rnd = System.Math.Random();Integer periodNumber = System.Math.round(rnd*100)/10;"
			create_purchase_credit_note += "if ( periodNumber == 0 ) periodNumber = 11;"
			create_purchase_credit_note += "String periodString = string.valueof(Date.today().year());"
			create_purchase_credit_note += "if(periodNumber >= 10){"
			create_purchase_credit_note += "periodString = periodString +'/0'+string.valueof(periodNumber);}"
			create_purchase_credit_note += "else{"
			create_purchase_credit_note += "periodString = periodString +'/00'+string.valueof(periodNumber);}"
			create_purchase_credit_note += "for (integer i = 1; i <= 2; i++)"
			create_purchase_credit_note += "{"
			create_purchase_credit_note += "#{_name_space_name}CODAAPIPurchaseCreditNoteTypes_7_0.PurchaseCreditNote dto = new #{_name_space_name}CODAAPIPurchaseCreditNoteTypes_7_0.PurchaseCreditNote();"
			create_purchase_credit_note += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_purchase_credit_note += "dto.CreditNoteDate =  Date.newInstance(Date.today().year(), periodNumber, 5);"
			create_purchase_credit_note += "dto.DueDate = Date.newInstance(Date.today().year(), periodNumber, 28);"
			create_purchase_credit_note += "dto.Period = #{_name_space_name}CODAAPICommon.getRef(null, periodString);"
			create_purchase_credit_note += "dto.CreditNoteStatus = #{_name_space_name}CODAAPIPurchaseCreditNoteTypes_7_0.enumCreditNoteStatus.InProgress;"
			create_purchase_credit_note += "dto.CreditNoteDescription = '#{_pcrn_description}'+i;"
			create_purchase_credit_note += "dto.CreditNoteCurrency = #{_name_space_name}CODAAPICommon.getRef(null, 'EUR');"
			create_purchase_credit_note += "dto.AccountCreditNoteNumber = 'Ven#00'+string.valueof(DateTime.now().hour())+'-'+string.valueof(DateTime.now().minute())+'-'+string.valueof(DateTime.now().second())+'-'+string.valueof(DateTime.now().millisecond());"
			create_purchase_credit_note += "dto.LineItems = new #{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItems();"
			create_purchase_credit_note += "dto.LineItems.LineItemlist = new #{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItem[2];"
			create_purchase_credit_note += "dto.ExpLineItems = new #{_name_space_name}CODAAPIPurchaseCreditNoteExLineTypes_7_0.PurchaseCreditNoteExpLineItems();"
			create_purchase_credit_note += "dto.ExpLineItems.LineItemList = new List<#{_name_space_name}CODAAPIPurchaseCreditNoteExLineTypes_7_0.PurchaseCreditNoteExpLineItem>();"
			create_purchase_credit_note += "for(integer j=3; j<=4; j++)"
			create_purchase_credit_note += "{"
			create_purchase_credit_note += "#{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItem lineProdDto = new #{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItem();"
			create_purchase_credit_note += "lineProdDto.Quantity = 1;"
			create_purchase_credit_note += "lineProdDto.Product = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_purchase_credit_note += "lineProdDto.UnitPrice = 100;"
			create_purchase_credit_note += "lineProdDto.EditTaxValue = false;"
			create_purchase_credit_note += "lineProdDto.LineDescription = '#{_pcrn_description}'+ i + '#{_line_description}'+ j;"
			create_purchase_credit_note += "if(j==4)"
			create_purchase_credit_note += "lineProdDto.Dimension3 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 3 USD');"
			create_purchase_credit_note += "dto.LineItems.LineItemlist.add(lineProdDto);"
			create_purchase_credit_note += "}"
			create_purchase_credit_note += "#{_name_space_name}CODAAPIPurchaseCreditNote_7_0.CreatePurchaseCreditNote(context, dto);"
			create_purchase_credit_note += "}"
			
			#Sales Invoices 3 and 4
			create_sales_invoices2 = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_invoices2 += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_invoices2 += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_intercompany_usa_account}'];"
			create_sales_invoices2  += "for (integer i = 3; i <= 4; i++)"
			create_sales_invoices2 += "{"
			create_sales_invoices2 += "#{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice dto = new #{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice();"
			create_sales_invoices2 += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_invoices2 += "dto.InvoiceDate = Date.today();" 
			create_sales_invoices2 += "dto.InvoiceCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"			
			create_sales_invoices2 += "dto.DeriveCurrency = false;"
			create_sales_invoices2 += "dto.DerivePeriod = true;"
			create_sales_invoices2 += "dto.DeriveDueDate = true;"
			create_sales_invoices2 += "dto.InvoiceDescription = '#{_sin_description}'+i;"
			create_sales_invoices2 += "/*Line Item 1 */"
			create_sales_invoices2 += "dto.LineItems = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItems();"
			create_sales_invoices2 += "dto.LineItems.LineItemList = new List<#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem>();"
			create_sales_invoices2 += "for(integer count=1; count<=4;count++)"
			create_sales_invoices2 += "{"
			create_sales_invoices2 += "#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem lineItem = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem();"
			create_sales_invoices2 += "lineItem.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_invoices2 += "lineItem.Quantity = 1;"
			create_sales_invoices2 += "lineItem.UnitPrice = 100;"
			create_sales_invoices2 += "lineItem.LineDescription = '#{_sin_description}'+ i + '#{_line_description}'+count ;"
			create_sales_invoices2 += "lineItem.TaxCode1 = null;"
			create_sales_invoices2 += "lineItem.TaxValue1= null;"
			create_sales_invoices2 += "if(count == 2 || count == 3){lineItem.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');}"
			create_sales_invoices2 += "dto.LineItems.LineItemList.add(lineItem);"
			create_sales_invoices2 += "}"
			create_sales_invoices2 += "Id dto2Id = #{_name_space_name}CODAAPISalesInvoice_10_0.CreateInvoice(context, dto).Id;"
			create_sales_invoices2 += "#{_name_space_name}CODAAPICommon.Reference salesInvoiceIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_invoices2 += "}"			
			
			#Sales credit Note 3 and 4
			create_sales_credit_note2 = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_credit_note2 += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_credit_note2 += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_intercompany_usa_account}'];"
			create_sales_credit_note2 += "for (integer i = 3; i <= 4; i++)"
			create_sales_credit_note2 += "{"
			create_sales_credit_note2 += "/* Set up header information */"
			create_sales_credit_note2 += "#{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote dto = new #{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote();"
			create_sales_credit_note2 += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_credit_note2 += "dto.DeriveCurrency = false;"
			create_sales_credit_note2 += "dto.DerivePeriod = true;"
			create_sales_credit_note2 += "dto.DeriveDueDate = true ;"
			create_sales_credit_note2 += "dto.CreditNoteDate = Date.today();" 
			create_sales_credit_note2 += "dto.CreditNoteCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"
			create_sales_credit_note2 += "dto.CreditNoteDescription = '#{_scrn_description}'+i;"
			create_sales_credit_note2 += "/* Now for the lines */"
			create_sales_credit_note2 += "dto.LineItems = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItems();"
			create_sales_credit_note2 += "dto.LineItems.LineItemlist = new List<#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem>();"
			create_sales_credit_note2 += "for ( integer j = 1; j<=4; j++)"
			create_sales_credit_note2 += "{"
			create_sales_credit_note2 += "#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem lineDto = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem();"
			create_sales_credit_note2 += "lineDto.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_credit_note2 += "lineDto.Quantity = 1;"
			create_sales_credit_note2 += "lineDto.UnitPrice = 100;"
			create_sales_credit_note2 += "LineDto.LineDescription = '#{_scrn_description}'+ i + '#{_line_description}'+j;"
			create_sales_credit_note2 += "if(j==2 || j==3)"
			create_sales_credit_note2 += "lineDto.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');"
			create_sales_credit_note2 += "dto.LineItems.LineItemlist.Add(lineDto);"
			create_sales_credit_note2 += "}"
			create_sales_credit_note2 += "Id dto2Id = #{_name_space_name}CODAAPISalesCreditNote_10_0.CreateCreditNote(context, dto).Id;"
			create_sales_credit_note2 += "#{_name_space_name}CODAAPICommon.Reference salesCreditNoteIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_credit_note2 += "}"
			
			# #Add Expense line Item to Payable Invoices and PCRN
			addexp_line_items =  "Id gla6008 = [Select Id from #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name='60008'][0].id;"
			addexp_line_items += "Id usaCompany = [Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
			addexp_line_items += "Id dim2USD = [Select Id from #{ORG_PREFIX}codaDimension2__c Where Name='#{$bd_dim2_usd}'][0].Id;"
			addexp_line_items += "for(integer i=1; i<=2;i++)"
			addexp_line_items += "{"
			addexp_line_items += "List<#{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c> pinvExplineItemList = new list<#{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c>();"
			addexp_line_items += "for(integer j=1; j<=2;j++)"
			addexp_line_items += "{"
			addexp_line_items += "#{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c lineItem = new #{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c();"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = gla6008;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}NetValue__c = 10.00;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = usaCompany;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationNetValue__c = 2;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LineDescription__c = '#{_pinv_description}'+ i + '#{_line_description}'+ j;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}PurchaseInvoice__c = [Select Id from #{ORG_PREFIX}codaPurchaseInvoice__c where #{ORG_PREFIX}InvoiceDescription__c =:'#{_pinv_description}'+i][0].id;"
			addexp_line_items += "if(j==2)"
			addexp_line_items += "lineItem.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			addexp_line_items += "pinvExplineItemList.add(lineItem);"
			addexp_line_items += "}"
			addexp_line_items +="INSERT pinvExplineItemList;"

			addexp_line_items += "List<#{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c> pcrnExplineItemList = new list<#{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c>();"
			addexp_line_items += "for(integer j=1; j<=2;j++)"
			addexp_line_items += "{"
			addexp_line_items += "#{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c lineItem = new #{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c();"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = gla6008;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}NetValue__c = 10.00;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = usaCompany;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationNetValue__c = 2;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LineDescription__c = '#{_pcrn_description}'+ i + '#{_line_description}'+ j;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}PurchaseCreditNote__c = [Select Id from #{ORG_PREFIX}codaPurchaseCreditNote__c where #{ORG_PREFIX}CreditNoteDescription__c = :'#{_pcrn_description}'+i][0].id;"
			addexp_line_items += "if(j==2)"
			addexp_line_items += "lineItem.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			addexp_line_items += "pcrnExplineItemList.add(lineItem);"
			addexp_line_items += "}"
			addexp_line_items +="INSERT pcrnExplineItemList;"
			addexp_line_items += "}"
			
			APEX.execute_commands [create_sales_invoices, create_sales_credit_note, create_purchase_invoices, create_purchase_credit_note,create_sales_invoices2, create_sales_credit_note2, addexp_line_items]
												
			update_sinv_line_items = "list <#{ORG_PREFIX}codaInvoiceLineItem__c> invoiceLineItems;integer count=1;"
			update_scrn_line_items = "list <#{ORG_PREFIX}codaCreditNoteLineItem__c> scrnLineItems;integer count=1;"
			update_pinv_line_items = "list <#{ORG_PREFIX}codaPurchaseInvoiceLineItem__c> pinvLineItems;"
			update_pcrn_line_items = "list <#{ORG_PREFIX}codaPurchaseCreditNoteLineItem__c> pcrnLineItems;"
			for j in 1..4 do
				#update SINV Line Items destination
				update_sinv_line_items += "count=1;"
				update_sinv_line_items += "invoiceLineItems = [SELECT ID from #{ORG_PREFIX}codaInvoiceLineItem__c where #{ORG_PREFIX}Invoice__r.#{ORG_PREFIX}InvoiceDescription__c =:'#{_sin_description + j.to_s}' ORDER BY #{ORG_PREFIX}LineDescription__c];"
				update_sinv_line_items += "for(#{ORG_PREFIX}codaInvoiceLineItem__c lineItem :invoiceLineItems)"
				update_sinv_line_items += "{"
				if j<=2
					update_sinv_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = [Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
					update_sinv_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c = 1;"
					update_sinv_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c = 20.00;"
				end
				update_sinv_line_items += "if(count == 3 || count == 4)"
				update_sinv_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = [SELECT ID from #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name='60008'][0].Id;"
				update_sinv_line_items += "count++;"
				update_sinv_line_items += "}"
				update_sinv_line_items += "update invoiceLineItems;"
				
				#update SCRN Line Items destination
				update_scrn_line_items += "count=1;"
				update_scrn_line_items += "scrnLineItems = [SELECT ID from #{ORG_PREFIX}codaCreditNoteLineItem__c where #{ORG_PREFIX}CreditNote__r.#{ORG_PREFIX}CreditNoteDescription__c =:'#{_scrn_description + j.to_s}' ORDER BY #{ORG_PREFIX}LineDescription__c];"
				update_scrn_line_items += "for(#{ORG_PREFIX}codaCreditNoteLineItem__c lineItem :scrnLineItems)"
				update_scrn_line_items += "{"
				if j<=2
					update_scrn_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = [Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
					update_scrn_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c = 1;"	
					update_scrn_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c = 20.00;"
				end
				update_scrn_line_items += "if(count == 3 || count == 4)"
				update_scrn_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = [SELECT ID from #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name='60008'][0].Id;"
				update_scrn_line_items += "count++;"
				update_scrn_line_items += "}"
				update_scrn_line_items += "update scrnLineItems;"
			end
			#update PINV Line Items destination
			for j in 1..2 do
				update_pinv_line_items += "pinvLineItems = [SELECT ID from #{ORG_PREFIX}codaPurchaseInvoiceLineItem__c where #{ORG_PREFIX}PurchaseInvoice__r.#{ORG_PREFIX}InvoiceDescription__c =:'#{_pinv_description + j.to_s}'];"
				update_pinv_line_items += "for(#{ORG_PREFIX}codaPurchaseInvoiceLineItem__c lineItem :pinvLineItems)"
				update_pinv_line_items += "{"
				update_pinv_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c=[Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
				update_pinv_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c=1;"
				update_pinv_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c=20.00;"
				update_pinv_line_items += "}"
				update_pinv_line_items += "update pinvLineItems;"
				
				#update PCRN Line Items destination
				update_pcrn_line_items += "pcrnLineItems=[SELECT ID from #{ORG_PREFIX}codaPurchaseCreditNoteLineItem__c where #{ORG_PREFIX}PurchaseCreditNote__r.#{ORG_PREFIX}CreditNoteDescription__c =:'#{_pcrn_description + j.to_s}'];"
				update_pcrn_line_items += "for(#{ORG_PREFIX}codaPurchaseCreditNoteLineItem__c lineItem :pcrnLineItems )"
				update_pcrn_line_items += "{"
				update_pcrn_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c=[Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
				update_pcrn_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c=1;"
				update_pcrn_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c=20.00;"
				update_pcrn_line_items += "}"
				update_pcrn_line_items += "update pcrnLineItems;"
			end			
		
			APEX.execute_commands [update_sinv_line_items,update_scrn_line_items, update_pinv_line_items,update_pcrn_line_items]
		
			#create Journals
			for j in 1..2 do
				SF.tab $tab_journals
				SF.click_button_new
				JNL.set_journal_description _jrnl_description + j.to_s
				JNL.set_journal_reference 'JRN header'
				
				JNL.select_journal_line_type $bd_jnl_line_type_intercompany
				JNL.select_journal_line_value $company_merlin_auto_usa
				JNL.select_destination_line_type $label_jnl_destination_line_type_bank_account
				JNL.set_destination_line_type_value $label_jnl_destination_line_type_bank_account , $bd_bank_account_bristol_euros_account
				JNL.click_journal_new_line
				
				JNL.click_line_analysis_popup_icon 1
				JNL.set_general_ledger_account_in_analysis_popup 1, $bd_gla_marketing
				JNL.line_close_analysis_detail_popup
				JNL.line_set_journal_description  1 , _jrnl_description + j.to_s + _line_description + "1"
				JNL.line_set_journal_dimension2 1, $bd_dim2_usd
				JNL.line_set_journal_amount 1 , 10
								
				JNL.select_journal_line_type $bd_jnl_line_type_intercompany
				JNL.select_journal_line_value $company_merlin_auto_usa
				JNL.select_destination_line_type $label_jnl_destination_line_type_gla
				JNL.set_destination_line_type_value $label_jnl_destination_line_type_gla , $bd_gla_postage_and_stationery
				JNL.click_journal_new_line
				JNL.line_set_journal_amount 2 , -10
				JNL.line_set_journal_description 2 , _jrnl_description + j.to_s + _line_description + "2"
				FFA.click_save_post
				gen_wait_until_object $jnl_journal_number
			end			
		end	
		
		APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin1_description)
		sin1_name = APEX.get_field_value_from_soql_result "Name"
		#post SINV1
		SF.tab $tab_sales_invoices
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SIN.open_invoice_detail_page sin1_name
		SF.click_button $ffa_post_button
		
		APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin3_description)
		sin3_name = APEX.get_field_value_from_soql_result "Name"
		#post SINV3
		SF.tab $tab_sales_invoices
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SIN.open_invoice_detail_page sin3_name
		SF.click_button_edit
		FFA.click_account_toggle_icon
		SIN.set_account_dimension  $sin_dimension_2_label, $bd_dim2_eur
		FFA.click_account_toggle_icon
		SIN.line_set_tax_code  1 , ""
		SIN.line_set_tax_code  2 , ""
		SIN.line_set_tax_code  3 , ""
		SIN.line_set_tax_code  4 , ""
		SF.click_button $ffa_save_post_button
		
		APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr1_description)
		scn1_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_sales_credit_notes
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SF.click_link scn1_name
		SF.click_button $ffa_post_button
		
		APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr3_description)
		scn3_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_sales_credit_notes
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SF.click_link scn3_name
		SF.click_button_edit
		FFA.click_account_toggle_icon
		SCR.set_account_dimension  $scn_dimension_2_label, $bd_dim2_eur
		FFA.click_account_toggle_icon

		SCR.line_set_tax_code  1 , ""
		SCR.line_set_tax_code  2 , ""
		SCR.line_set_tax_code  3 , ""
		SCR.line_set_tax_code  4 , ""
		SF.click_button $ffa_save_post_button
		
		APEX.execute_soql _soql_pinv_by_desc.sub($sf_param_substitute , _pinv1_description)
		pinv1_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_payable_invoices
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		PIN.open_invoice_detail_page pinv1_name
		SF.wait_for_search_button
		SF.click_button $ffa_post_button
		
		APEX.execute_soql _soql_pcrn_by_desc.sub($sf_param_substitute , _pcrn1_description)
		pcrn1_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_payable_credit_notes
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SF.click_link pcrn1_name
		SF.wait_for_search_button
		SF.click_button $ffa_post_button		
		
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		
		#Execute the ICT created with available status
		SF.tab $tab_intercompany_transfers
		SF.select_view $bd_select_view_available
		SF.click_button_go
		FFA.listview_select_all 
		ICT.click_button_process
		ict_processing_message = FFA.ffa_get_info_message
		gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
		ICT.click_confirm_ict_process
		SF.wait_for_apex_job
				
		#Update USA ICDs as follows,Autopost - true, Autoprocess - true
		autopost = "#{ORG_PREFIX}codaCompany__c cmpny = [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
		autopost += "#{ORG_PREFIX}codaIntercompanyDefinition__c icd = [select Id, #{ORG_PREFIX}AutoProcess__c, #{ORG_PREFIX}AutoPost__c from #{ORG_PREFIX}codaIntercompanyDefinition__c where #{ORG_PREFIX}OwnerCompany__c =:cmpny.Id];"
        autopost += "icd.#{ORG_PREFIX}AutoProcess__c = true;"
        autopost += "icd.#{ORG_PREFIX}AutoPost__c = true;"
        autopost += "update icd;"
		APEX.execute_commands [autopost]
	end

	it "TID019992-TST027381: Verify the Payable invoice and created with intercompany account from Sales invoice." do
		gen_start_test "TST027381: Sales Invoice 3 and 4 validation "
		# Step 1.1
		begin
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin3_description)
			sin3_name = APEX.get_field_value_from_soql_result "Name"
			APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin4_description)
			sin4_name = APEX.get_field_value_from_soql_result "Name"
						
			#post SINV4
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SIN.open_invoice_detail_page sin4_name
			SF.click_button_edit
			FFA.click_account_toggle_icon
			SIN.set_account_dimension  $sin_dimension_2_label, $bd_dim2_eur
			FFA.click_account_toggle_icon
			SIN.line_set_tax_code  1 , ""
			SIN.line_set_tax_code  2 , ""
			SIN.line_set_tax_code  3 , ""
			SIN.line_set_tax_code  4 , ""
			SF.click_button $ffa_save_post_button
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			#Execute the ICT created with available status
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			FFA.listview_select_all 
			ICT.click_button_process
			ict_processing_message = FFA.ffa_get_info_message
			gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job
			
			for i in 1..2 do
				_line_description1 = ""
				_line_description2 = ""
				_line_description3 = ""
				_line_description4 = ""
				_sin_description = ""
				_sinv_name = ""
				if i==1
					line1_description = _sin3_line1_description
					line2_description = _sin3_line2_description
					line3_description = _sin3_line3_description
					line4_description = _sin3_line4_description
					_sin_description = _sin3_description
					_sinv_name = sin3_name
				else					
					line1_description = _sin4_line1_description
					line2_description = _sin4_line2_description
					line3_description = _sin4_line3_description
					line4_description = _sin4_line4_description
					_sin_description = _sin4_description
					_sinv_name = sin4_name
				end
				
				##validate ICT Line Items 
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_sales_invoice
				SF.click_button_go
				ict_number_sin = FFA.get_column_value_in_grid _source_sin_number_label , _sinv_name , $label_ict_intercompany_transfer_number
				gen_report_test "An ICT for #{_sinv_name} is available for processing."
		
				ICT.open_ICT_detail_page ict_number_sin						
				#Assert Line values for SIN3
				validate_ict_line_details ict_number_sin, line1_description ,  "100.00", "", "", ""
				validate_ict_line_details ict_number_sin, line2_description ,  "100.00", "", "", ""
				validate_ict_line_details ict_number_sin, line3_description ,  "100.00", $bd_gla_marketing, "", ""
				validate_ict_line_details ict_number_sin, line4_description ,  "100.00", $bd_gla_postage_and_stationery, "", ""
				
				## Assert the Account line item for Sales Invoice 3 and 4 
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				SIN.open_invoice_detail_page _sinv_name
				tranx_number = SIN.get_transaction_number
				SIN.click_transaction_number
				validate_transaction_line_data_values tranx_number,$label_trx_line_type_account, "500.00" , _sin_description , $bd_gla_accounts_payable_control_eur, "60006", "750.00", $bd_dim2_eur, ""

				##4. A Payable Invoice is created in USA corresponding to Sales Invoice 3 and 4
				APEX.execute_soql "Select Name from #{ORG_PREFIX}codaPurchaseInvoice__c WHERE #{ORG_PREFIX}AccountInvoiceNumber__c = '#{_sinv_name}'"
				pinv = APEX.get_field_value_from_soql_result "Name"
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				gen_compare_has_link pinv, true, "#{pinv} Payable invoice exists for Sales Invoice #{_sinv_name} - #{_sin_description}"			
			end			
		end		
		gen_end_test "end of test step TST027380-TST032581:"
	end
	
	it "TID019992-TST027382: Verify the Journal created with intercompany line from Sales invoice1 and Sales invoice 2" do
		gen_start_test "TST027382: Verify the Journal created with intercompany line from Sales invoice. "
		# Step 1.1
		begin
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin1_description)
			sin1_name = APEX.get_field_value_from_soql_result "Name"
			APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin2_description)
			sin2_name = APEX.get_field_value_from_soql_result "Name"
						
			##post SINV2
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SIN.open_invoice_detail_page sin2_name
			SF.click_button $ffa_post_button
						
			# #1. There is one intercompany transfer record for Sales Invoice 1 and one intercompany transfer record for Sales Invoice 2.
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			##Execute the ICT created with available status
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			FFA.listview_select_all 
			ICT.click_button_process
			ict_processing_message = FFA.ffa_get_info_message
			gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job
			
			##Validate ICT Transfer Line , TLIs and Journal Line Items for SINV 1 and 2 
			for i in 1..2 do
				sin_name = ""
				_line_description1 = ""
				_line_description2 = ""
				_line_description3 = ""
				_line_description4 = ""
				_sin_description = ""
				if i==1
					sin_name = sin1_name
					line1_description = _sin1_line1_description
					line2_description = _sin1_line2_description
					line3_description = _sin1_line3_description
					line4_description = _sin1_line4_description
					_sin_description = _sin1_description
				else
					sin_name = sin2_name
					line1_description = _sin2_line1_description
					line2_description = _sin2_line2_description
					line3_description = _sin2_line3_description
					line4_description = _sin2_line4_description
					_sin_description = _sin2_description
				end
				
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_centralized_sin
				SF.click_button_go
			
				ict_number_sin = FFA.get_column_value_in_grid _source_document_description , _sin_description , $label_ict_intercompany_transfer_number
				gen_report_test "An ICT for #{sin1_name} has processed."
				ICT.open_ICT_detail_page ict_number_sin
			
				##Assert Line values for SIN1
				validate_ict_line_details ict_number_sin, line1_description ,  "20.00", "", "", ""
				validate_ict_line_details ict_number_sin, line2_description ,  "20.00", "", $bd_dim2_usd, ""
				validate_ict_line_details ict_number_sin, line3_description ,  "20.00", $bd_gla_marketing, $bd_dim2_usd, ""
				validate_ict_line_details ict_number_sin, line4_description ,  "20.00", $bd_gla_postage_and_stationery, "", ""
				
				##2. TLI of Analysis type For Sales Invoice 1 and Sales invoice 2
				## Assert the Analysis line item for Sales Invoice
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				SIN.open_invoice_detail_page sin_name
				tranx_number = SIN.get_transaction_number
				SIN.click_transaction_number
				SF.wait_for_search_button
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-100.00" , line1_description, $bd_gla_sales_parts, "60009", "-150.00", "", ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-25.00" , line1_description, $bd_gla_account_receivable_control_eur, "60003", "-37.50", $bd_dim2_eur, ""			
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-100.00" , line2_description, $bd_gla_sales_parts, "60009", "-150.00", $bd_dim2_usd, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-25.00" , line2_description, $bd_gla_account_receivable_control_eur, "60003", "-37.50", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-100.00", line3_description, $bd_gla_marketing, "60008", "-150.00", $bd_dim2_usd, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-25.00", line3_description, $bd_gla_account_receivable_control_eur, "60003", "-37.50", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-100.00", line4_description, $bd_gla_postage_and_stationery, "60008", "-150.00", "", ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "-25.00", line4_description, $bd_gla_account_receivable_control_eur, "60003", "-37.50", $bd_dim2_eur, ""
				
				##A Journal is created in USA corresponding to Sales Invoice 1 and Sales Invoice 2.
				APEX.execute_soql "Select Name from #{ORG_PREFIX}codaJournal__c WHERE #{ORG_PREFIX}Reference__c = '#{sin_name}'"
				journal_name = APEX.get_field_value_from_soql_result "Name"
				
				##validate Journal Line Items for Sales Invoice  1. and 2
				SF.tab $tab_journals
				SF.click_button_go
				SF.click_link journal_name				
				SF.wait_for_search_button
				
				validate_journal_line line1_description , $bd_gla_sales_parts , "-20.00" , "70009" , "", ""
				validate_journal_line line2_description , $bd_gla_sales_parts , "-20.00" , "700010" , $bd_dim2_usd, ""
				validate_journal_line line3_description , $bd_gla_marketing , "-20.00" , "70009" ,  $bd_dim2_usd, ""
				validate_journal_line line4_description , $bd_gla_postage_and_stationery , "-20.00" , "70008" , "", ""
				validate_journal_line_values 5 , $bd_gla_account_payable_control_usd , "80.00" , "70007" , $bd_dim2_usd, ""
			end			
		end		
		gen_end_test "end of test step TST027380-TST032582:"
	end
		
	it "TST032583 : Verify the Payable credit note created with intercompany account from Sales Credit Note. "  do
		begin
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			# Retrieve the sales credit note name
			APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr3_description)
			scr3_name = APEX.get_field_value_from_soql_result "Name"
			
			APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr4_description)
			scr4_name = APEX.get_field_value_from_soql_result "Name"
			
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SF.click_link scr4_name
			SF.click_button_edit
			FFA.click_account_toggle_icon
			SCR.set_account_dimension  $scn_dimension_2_label, $bd_dim2_eur
			FFA.click_account_toggle_icon
			SCR.line_set_tax_code  1 , ""
			SCR.line_set_tax_code  2 , ""
			SCR.line_set_tax_code  3 , ""
			SCR.line_set_tax_code  4 , ""
			SF.click_button $ffa_save_post_button
						
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_complete_ict_sales_credit_note
			SF.click_button_go
			ict_number_scr3 = FFA.get_column_value_in_grid _source_scr_number_label , scr3_name , $label_ict_intercompany_transfer_number
			gen_report_test "An ICT for #{scr3_name} has processed"
			ICT.open_ICT_detail_page ict_number_scr3
			
			#Assert Line values for SIN1
			validate_ict_line_details ict_number_scr3, _scr3_line1_description ,  "100.00", "", "", ""
			validate_ict_line_details ict_number_scr3, _scr3_line2_description ,  "100.00", "", "", ""
			validate_ict_line_details ict_number_scr3, _scr3_line3_description ,  "100.00", $bd_gla_marketing, "", ""
			validate_ict_line_details ict_number_scr3, _scr3_line4_description ,  "100.00", $bd_gla_postage_and_stationery, "", ""
			
						
			# Assert the line items of ICT for the Sales credit note 4
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			ict_number_scr4 = FFA.get_column_value_in_grid _source_scr_number_label , scr4_name , $label_ict_intercompany_transfer_number
			gen_report_test "An ICT for #{scr4_name} is available for processing."
			ICT.open_ICT_detail_page ict_number_scr4
			
			#Assert Line values for SIN1
			validate_ict_line_details ict_number_scr4, _scr4_line1_description ,  "100.00", "", "", ""
			validate_ict_line_details ict_number_scr4, _scr4_line2_description ,  "100.00", "", "", ""
			validate_ict_line_details ict_number_scr4, _scr4_line3_description ,  "100.00", $bd_gla_marketing, "", ""
			validate_ict_line_details ict_number_scr4, _scr4_line4_description ,  "100.00", $bd_gla_postage_and_stationery, "", ""
			
			## Assert the Account line item for Sales credit notes
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SCR.open_credit_note_detail_page scr3_name
			SCR.get_transaction_number
			tranx_number = SCR.get_transaction_number
			SCR.click_transaction_number
			SF.wait_for_search_button
			validate_transaction_line_data_values tranx_number,$label_trx_line_type_account, "-500.00" , _scr3_description, $bd_gla_accounts_payable_control_eur, "60006", "-750.00", $bd_dim2_eur, ""
			
			## Assert the Account line item for Sales credit notes
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SCR.open_credit_note_detail_page scr4_name
			tranx_number = SCR.get_transaction_number
			SCR.click_transaction_number
			SF.wait_for_search_button
			validate_transaction_line_data_values tranx_number,$label_trx_line_type_account, "-500.00" , _scr4_description, $bd_gla_accounts_payable_control_eur, "60006", "-750.00", $bd_dim2_eur, ""
		end
		
		begin
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			# select scr 4 from list.
			FFA.select_row_in_list_gird  _source_scr_number_label , scr4_name  
			ICT.click_button_process
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job
			
			# Assert that journals are created.
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_complete_ict_sales_credit_note
			SF.click_button_go
			ICT.open_ICT_detail_page ict_number_scr3
			pcr3 = ICT.get_destination_payable_credit_note_number
			gen_include "PCR" , pcr3 , "Journal is created successfully for Sales credit note - #{scr3_name}"
			
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_complete_ict_sales_credit_note
			SF.click_button_go
			ICT.open_ICT_detail_page ict_number_scr4
			pcr4 = ICT.get_destination_payable_credit_note_number
			gen_include "PCR" , pcr4 , "Journal is created successfully for Sales credit note - #{scr4_name}"
		end
		gen_end_test "end of test step TST027380-TST032583:"
	end
	
	it "TID019992-TST032584 : Verify the Journal created with intercompany account from Sales Credit Note. " do
		scr_name = ""
		begin
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			# Retrieve the sales credit note name
			APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr1_description)
			scr1_name = APEX.get_field_value_from_soql_result "Name"
			
			APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr2_description)
			scr2_name = APEX.get_field_value_from_soql_result "Name"
						
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SF.click_link scr2_name
			SF.click_button $ffa_post_button
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			# select scr 4 from list.
			FFA.select_row_in_list_gird  _source_scr_number_label , scr2_name  
			ICT.click_button_process
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job

			#Run the code for two times to check the ICT line items, TLI s
			for i in 1..2 do
				line1_description = ""
				line2_description = ""
				line3_description = ""
				line4_description = ""
				_scr_description = ""
				scr_name = ""
				
				if i==1
					scr_name = scr1_name
					line1_description = _scr1_line1_description
					line2_description = _scr1_line2_description
					line3_description = _scr1_line3_description
					line4_description = _scr1_line4_description
					_scr_description = _scr1_description
				else
					scr_name = scr2_name
					line1_description = _scr2_line1_description
					line2_description = _scr2_line2_description
					line3_description = _scr2_line3_description
					line4_description = _scr2_line4_description
					_scr_description = _scr2_description
				end
				
				##Validate ICT Line Items
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_centralized_scn
				SF.click_button_go
				ict_number_scr = FFA.get_column_value_in_grid _source_document_description , _scr_description, $label_ict_intercompany_transfer_number
				gen_report_test "An ICT for #{scr1_name} has processed."
				ICT.open_ICT_detail_page ict_number_scr
				##Assert Line values for SCR
				validate_ict_line_details ict_number_scr, line1_description , "20.00", "", "", ""
				validate_ict_line_details ict_number_scr, line2_description , "20.00", "", $bd_dim2_usd, ""
				validate_ict_line_details ict_number_scr, line3_description , "20.00", $bd_gla_marketing, $bd_dim2_usd, ""
				validate_ict_line_details ict_number_scr, line4_description , "20.00", $bd_gla_postage_and_stationery, "", ""
				
				##Validate Transaction Line Items
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				SCR.open_credit_note_detail_page scr_name
				tranx_number = SCR.get_transaction_number
				SCR.click_transaction_number
				SF.wait_for_search_button
				
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "100.00" , line1_description, $bd_gla_sales_parts, "60009", "150.00", "", ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "25.00" , line1_description, $bd_gla_account_receivable_control_eur, "60003", "37.50", $bd_dim2_eur , ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "100.00",line2_description, $bd_gla_sales_parts, "60009", "150.00", $bd_dim2_usd , ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "25.00",line2_description, $bd_gla_account_receivable_control_eur, "60003", "37.50", $bd_dim2_eur , ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "100.00",line3_description, $bd_gla_marketing, "60008", "150.00", $bd_dim2_usd , ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "25.00",line3_description, $bd_gla_account_receivable_control_eur, "60003", "37.50", $bd_dim2_eur , ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "100.00",line4_description, $bd_gla_postage_and_stationery, "60008", "150.00", "" , ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "25.00",line4_description, $bd_gla_account_receivable_control_eur, "60003", "37.50", $bd_dim2_eur , ""
				
				## Assert that journals are created.
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_centralized_scn
				SF.click_button_go
				ict_number_scr = FFA.get_column_value_in_grid _source_document_description , _scr_description , $label_ict_intercompany_transfer_number
				ICT.open_ICT_detail_page ict_number_scr
				jnl = ICT.get_destination_journal_number
				gen_include "JNL" + j.to_s , jnl , "Journal is created successfully for Sales credit note - #{scr_name}"
			end
		end
		gen_end_test "end of test step TST027380-TST032584:"
	end

	after :all do
		# Revert all the changes which are done as part of this TID in before all method.
		login_user
		## Revert the changes on company object which are done for using chart of account structure and local GLA
		## revert only when COA are marked as active in before all base data.
		if is_chart_of_account_status_active
			revert_company_object_changes_for_local_gla 
		end
		# purge  chart of account mapping and related transactions object.
		APEX.purge_object ["ChartOfAccountsMapping__c","codaTransaction__c"]
		
		#Revert all the GLA changes
		revert_gla_object_changes
		
		# delete accounting settings which are added as a part of this script.
		delete = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
		APEX.execute_commands [delete]
		
		# Purge other object separately to avoid Too Many SOQL error which appears due to single delete statement using FFA.delete_new_data_and_wait
		APEX.purge_object ["ChartOfAccountsStructure__c","codaTransaction__c","CodaInvoice__c","codaCreditNote__c","codaPurchaseInvoice__c",
		                   "codaPurchaseCreditNote__c","codaJournal__c","codaIntercompanyDefinition__c","codaIntercompanyTransfer__c"]
		
		# Delete Test script specific data separately.
		delete_data_script = ""
        delete_data_script += "delete[SELECT Id FROM #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name='4001'or #{ORG_PREFIX}reportingCode__c like 'Local%' or #{ORG_PREFIX}reportingCode__c like 'SPAIN%' or #{ORG_PREFIX}reportingCode__c like 'USA%'];"
		APEX.execute_script delete_data_script
		
		#Delete Test Data
		FFA.delete_new_data_and_wait	
		gen_end_test "TID019992"
		SF.logout 
	end
end	


describe "TID019992 Smoke Test: TST032585_86_87 Verify that Local GLA is supported on all document with intercompany process for Payable Invocie,Credit Note and Journal.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	#variables
	_gla_4001 = "4001"
    _gla_6000 = "6000"
	_gla_7000 = "7000"
	_reporting_code_local = "Local";
	current_date = Time.now.strftime("%d/%m/%Y")
	_name_corporate = "Corporate"
	_name_usa = "USA"
	_name_spain = "Spain"
	_name_french = "French"
	_coa_corporate_query = "SELECT ID, Name from #{ORG_PREFIX}ChartOfAccountsStructure__c  WHERE Name = '#{$sf_param_substitute}'"
	_sin_description = "SINV"
	_scrn_description = "SCRN"
	_pinv_description = "PINV"
	_pcrn_description = "PCRN"
	_jrnl_description = "JRNL"
	_line_description = "Line Description"
	
	_sin1_description = _sin_description+"1"
	_sin1_line1_description = _sin1_description + _line_description + "1"
	_sin1_line2_description = _sin1_description + _line_description + "2"
	_sin1_line3_description = _sin1_description + _line_description + "3"
	_sin1_line4_description = _sin1_description + _line_description + "4"
	_sin2_description = _sin_description+"2"
	_sin2_line1_description = _sin2_description + _line_description + "1"
	_sin2_line2_description = _sin2_description + _line_description + "2"
	_sin2_line3_description = _sin2_description + _line_description + "3"
	_sin2_line4_description = _sin2_description + _line_description + "4"
	_sin3_description = _sin_description+"3"
	_sin3_line1_description = _sin3_description + _line_description + "1"
	_sin3_line2_description = _sin3_description + _line_description + "2"
	_sin3_line3_description = _sin3_description + _line_description + "3"
	_sin3_line4_description = _sin3_description + _line_description + "4"
	_sin4_description = _sin_description+"4"
	_sin4_line1_description = _sin4_description + _line_description + "1"
	_sin4_line2_description = _sin4_description + _line_description + "2"
	_sin4_line3_description = _sin4_description + _line_description + "3"
	_sin4_line4_description = _sin4_description + _line_description + "4"
	
	_scr1_description = _scrn_description + "1"
	_scr1_line1_description = _scr1_description + _line_description + "1"
	_scr1_line2_description = _scr1_description + _line_description + "2"
	_scr1_line3_description = _scr1_description + _line_description + "3"
	_scr1_line4_description = _scr1_description + _line_description + "4"
	_scr2_description = _scrn_description + "2"
	_scr2_line1_description = _scr2_description + _line_description + "1"
	_scr2_line2_description = _scr2_description + _line_description + "2"
	_scr2_line3_description = _scr2_description + _line_description + "3"
	_scr2_line4_description = _scr2_description + _line_description + "4"
	_scr3_description = _scrn_description + "3"
	_scr3_line1_description = _scr3_description + _line_description + "1"
	_scr3_line2_description = _scr3_description + _line_description + "2"
	_scr3_line3_description = _scr3_description + _line_description + "3"
	_scr3_line4_description = _scr3_description + _line_description + "4"
	_scr4_description = _scrn_description + "4"
	_scr4_line1_description = _scr4_description + _line_description + "1"
	_scr4_line2_description = _scr4_description + _line_description + "2"
	_scr4_line3_description = _scr4_description + _line_description + "3"
	_scr4_line4_description = _scr4_description + _line_description + "4"

	_pinv1_description = _pinv_description + "1"
	_pinv1_line1_description= _pinv1_description + _line_description + "1"
	_pinv1_line2_description= _pinv1_description + _line_description + "2"
	_pinv1_line3_description= _pinv1_description + _line_description + "3"
	_pinv1_line4_description= _pinv1_description + _line_description + "4"
	
	_pinv2_description = _pinv_description + "2"
	_pinv2_line1_description= _pinv2_description + _line_description + "1"
	_pinv2_line2_description= _pinv2_description + _line_description + "2"
	_pinv2_line3_description= _pinv2_description + _line_description + "3"
	_pinv2_line4_description= _pinv2_description + _line_description + "4"
	
	_pcrn1_description = _pcrn_description + "1"
	_pcrn1_line1_description= _pcrn1_description + _line_description + "1"
	_pcrn1_line2_description= _pcrn1_description + _line_description + "2"
	_pcrn1_line3_description= _pcrn1_description + _line_description + "3"
	_pcrn1_line4_description= _pcrn1_description + _line_description + "4"
	
	_pcrn2_description = _pcrn_description + "2"
	_pcrn2_line1_description= _pcrn2_description + _line_description + "1"
	_pcrn2_line2_description= _pcrn2_description + _line_description + "2"
	_pcrn2_line3_description= _pcrn2_description + _line_description + "3"
	_pcrn2_line4_description= _pcrn2_description + _line_description + "4"
	
	_source_scr_number_label = "Source Sales Credit Note Number"
	_source_sin_number_label = "Source Sales Invoice Number"
	_source_document_description = "Source Document Description"
	
	_dim_type_dim2 = 'Dimension 2'
	_dim_type_dim3 = 'Dimension 3'
	_dim_type_na = "Not Applicable"
	_name_space_name= ORG_PREFIX.gsub("__", ".").sub(" ","") 
	
	_soql_sales_invoice_by_desc = "select Name from #{ORG_PREFIX}codaInvoice__c where #{ORG_PREFIX}InvoiceDescription__c ='#{$sf_param_substitute}'"
	_soql_sales_credit_note_by_desc = "select Name from #{ORG_PREFIX}codaCreditNote__c where #{ORG_PREFIX}CreditNoteDescription__c ='#{$sf_param_substitute}'"
	_soql_pinv_by_desc = "select Name from #{ORG_PREFIX}codaPurchaseInvoice__c where #{ORG_PREFIX}InvoiceDescription__c ='#{$sf_param_substitute}'"
	_soql_pcrn_by_desc = "select Name from #{ORG_PREFIX}codaPurchaseCreditNote__c where #{ORG_PREFIX}CreditNoteDescription__c ='#{$sf_param_substitute}'"
	# using below boolen value to revert the chnages as per the active status of the chart of accounts 
	is_chart_of_account_status_active = false 	
	before :all do
		#Hold Base Data
		gen_start_test "TID019992"	
		FFA.hold_base_data_and_wait
		#Additional data information"
		#Intercompany Definitions Spain to USA
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_usa ,$bd_gla_account_payable_control_eur, nil , $bd_dim2_eur , nil, nil ,$bd_gla_account_receivable_control_eur ,nil ,  $bd_dim2_eur , nil , nil
			SF.click_button_save
			page.has_css?($icd_intercompany_definition_number)
			expect(page).to have_css($icd_intercompany_definition_number)
			gen_report_test "Expected Intercompany definition for merlin auto Spain to USA  to be created successfully."
		end
		## Intercompany Definitions USA to Spain
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_spain , $bd_gla_account_payable_control_usd, nil , $bd_dim2_usd , nil,nil ,$bd_gla_account_receivable_control_usd ,nil , $bd_dim2_usd , nil , nil
			SF.click_button_save
			page.has_css?($icd_intercompany_definition_number)
			expect(page).to have_css($icd_intercompany_definition_number)
			gen_report_test "Expected Intercompany definition for merlin auto USA to Spain  to be created successfully."
		end
		
		begin
			##Allow use local GLA
			custom_setting ="list<#{ORG_PREFIX}codaAccountingSettings__c> settingList = [Select Id from #{ORG_PREFIX}codaAccountingSettings__c];"
			custom_setting +="#{ORG_PREFIX}codaAccountingSettings__c setting;"
			custom_setting +="if(settingList.size() == 0)"
			custom_setting +="{"
			custom_setting +="setting = new #{ORG_PREFIX}codaAccountingSettings__c();"
			custom_setting +="}"
			custom_setting +="else"
			custom_setting +="{"
			custom_setting +="setting = settingList[0];"
			custom_setting +="}"
			custom_setting += "setting.#{ORG_PREFIX}AllowUseOfLocalGLAs__c = true;"
			custom_setting += "setting.#{ORG_PREFIX}EnableOverrideProductGLA__c = true;"
			custom_setting += "UPSERT setting;"
			APEX.execute_commands [custom_setting]
			
			#create corporate  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_corporate
			COAS.set_default_corporate true
			COAS.set_active true
			SF.click_button_save
			gen_compare_has_content _name_corporate , true , "COA " +_name_corporate +" created."
			
			#create USA  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_usa
			COAS.set_default_corporate false
			COAS.set_active false
			SF.click_button_save
			gen_compare_has_content _name_usa , true , "COA " +_name_usa +" created."
			
			#create Spain  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_spain
			COAS.set_default_corporate false
			COAS.set_active false
			SF.click_button_save
			gen_compare_has_content _name_spain , true , "COA " +_name_spain +" created."
			
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_corporate )
			coa_corporate_id = APEX.get_field_value_from_soql_result "Id"
			
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_usa )
			coa_usa_id = APEX.get_field_value_from_soql_result "Id"
			
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_spain )
			coa_spain_id = APEX.get_field_value_from_soql_result "Id"
			
			gla_list_query = "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaList = new List<#{ORG_PREFIX}codaGeneralLedgerAccount__c>();"
			gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c glaCorporate = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_4001}', #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = 'Corporate1', #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_corporate_id}');"
			gla_list_query += "glaList.add(glaCorporate);"			
			gla_list_query += "for(integer i=1;i<=12;i++)"
			gla_list_query += "{"
			gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla2 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_6000}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_local}' + i, #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_spain_id}');" 
			gla_list_query += "glaList.add(gla2);"
			gla_list_query += "}"	

			gla_list_query += "for(integer i=1;i<=12;i++)"
			gla_list_query += "{"
			gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla3 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_7000}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_local}' + (i+12), #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_usa_id}');" 
			gla_list_query += "glaList.add(gla3);"
			gla_list_query += "}"	
			gla_list_query += "INSERT glaList;"		
			APEX.execute_commands [gla_list_query]
			
			#Active local COA = Spain
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_go
			SF.click_link _name_spain
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button	
			COAS.set_default_corporate_gla _gla_4001
			COAS.set_default_local_gla "60001"
			COAS.set_active true
			SF.click_button_save

			#Active local COA  = USA
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_go
			SF.click_link _name_usa
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button	
			COAS.set_default_corporate_gla _gla_4001
			COAS.set_default_local_gla "70001"
			COAS.set_active true
			SF.click_button_save

			update_corporate_glas = "Set<String> corporateGla = new Set<String>();"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_payable_control_eur}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_receivable_control_usd}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_receivable_control_eur}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_payable_control_usd}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_sales_parts}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_stock_parts}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_postage_and_stationery}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_vat_output}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_marketing}');"			
			update_corporate_glas += "List<#{ORG_PREFIX}CODAGeneralLedgerAccount__c> corporateGLAs = [Select Id, Name from #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name in :corporateGla];"
			#add corporate chart of account structure in corporate glas
			update_corporate_glas += "for(#{ORG_PREFIX}CODAGeneralLedgerAccount__c corpGLA : corporateGLAs)"
			update_corporate_glas += "corpGLA.#{ORG_PREFIX}ChartOfAccountsStructure__c = '#{coa_corporate_id}';"
			update_corporate_glas += "update corporateGLAs;"
			APEX.execute_commands [update_corporate_glas]
			
			#Create Spain COA mappings and USA COA Mappings
			glaString =  "Map<String, #{ORG_PREFIX}CODAGeneralLedgerAccount__c> glaMap = new Map<String, #{ORG_PREFIX}CODAGeneralLedgerAccount__c>();"
			glaString += "Set<String> glaSet = new Set<String>();"
			glaString += "glaSet.add('#{$bd_gla_account_payable_control_eur}');"
			glaString += "glaSet.add('#{$bd_gla_account_receivable_control_usd}');"
			glaString += "glaSet.add('#{$bd_gla_account_receivable_control_eur}');"
			glaString += "glaSet.add('#{$bd_gla_account_payable_control_usd}');"
			glaString += "glaSet.add('#{$bd_gla_sales_parts}');"
			glaString += "glaSet.add('#{$bd_gla_stock_parts}');"
			glaString += "glaSet.add('#{$bd_gla_postage_and_stationery}');"
			glaString += "glaSet.add('#{$bd_gla_vat_output}');"
			glaString += "glaSet.add('#{$bd_gla_marketing}');"			
			glaString += "glaSet.add('4001');"			
			glaString += "glaSet.add('60001');"			
			glaString += "glaSet.add('60002');"			
			glaString += "glaSet.add('60003');"			
			glaString += "glaSet.add('60004');"			
			glaString += "glaSet.add('60005');"			
			glaString += "glaSet.add('60006');"			
			glaString += "glaSet.add('60007');"			
			glaString += "glaSet.add('60008');"			
			glaString += "glaSet.add('60009');"			
			glaString += "glaSet.add('600010');"			
			glaString += "glaSet.add('600011');"			
			glaString += "glaSet.add('600012');"			
			glaString += "glaSet.add('70001');"			
			glaString += "glaSet.add('70002');"			
			glaString += "glaSet.add('70003');"			
			glaString += "glaSet.add('70004');"			
			glaString += "glaSet.add('70005');"			
			glaString += "glaSet.add('70006');"			
			glaString += "glaSet.add('70007');"
			glaString += "glaSet.add('70008');"
			glaString += "glaSet.add('70009');"
			glaString += "glaSet.add('700010');"
			glaString += "glaSet.add('700011');"
			glaString += "glaSet.add('700012');"
			glaString += "List<#{ORG_PREFIX}CODAGeneralLedgerAccount__c> glaList = [Select Name, Id from #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name in :glaSet];"
			glaString += "for(#{ORG_PREFIX}CODAGeneralLedgerAccount__c gla : glaList)"
			glaString += "glaMap.put(gla.Name, gla);"

			glaString += "Id dim2USD = [Select Id from #{ORG_PREFIX}codaDimension2__c Where Name='#{$bd_dim2_usd}'][0].Id;"
			glaString += "Id dim2EUR = [Select Id from #{ORG_PREFIX}codaDimension2__c Where Name='#{$bd_dim2_eur}'][0].Id;"
			glaString += "Id dim3USD = [Select Id from #{ORG_PREFIX}codaDimension3__c Where Name='#{$bd_dim3_usd}'][0].Id;"

			coa_mappings_spain = "List<#{ORG_PREFIX}ChartOfAccountsMapping__c> mappings = new List<#{ORG_PREFIX}ChartOfAccountsMapping__c>();"
			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping1 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping1.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('4001').Id;"
			coa_mappings_spain += "mapping1.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60001').Id;"
			coa_mappings_spain += "mappings.add(mapping1);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping2 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping2.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_eur}').Id;"
			coa_mappings_spain += "mapping2.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60002').Id;"
			coa_mappings_spain += "mappings.add(mapping2);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping3 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping3.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_eur}').Id;"
			coa_mappings_spain += "mapping3.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60003').Id;"
			coa_mappings_spain += "mapping3.#{ORG_PREFIX}Dimension2__c = dim2EUR;"
			coa_mappings_spain += "mappings.add(mapping3);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping4 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping4.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_usd}').Id;"
			coa_mappings_spain += "mapping4.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60004').Id;"
			coa_mappings_spain += "mappings.add(mapping4);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping5 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping5.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_eur}').Id;"
			coa_mappings_spain += "mapping5.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60005').Id;"
			coa_mappings_spain += "mappings.add(mapping5);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping6 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping6.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_eur}').Id;"
			coa_mappings_spain += "mapping6.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60006').Id;"
			coa_mappings_spain += "mapping6.#{ORG_PREFIX}Dimension2__c = dim2EUR;"
			coa_mappings_spain += "mappings.add(mapping6);" 

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping7 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping7.#{ORG_PREFIX}CorporateGLA__c =glaMap.get('#{$bd_gla_account_payable_control_usd}').Id;"
			coa_mappings_spain += "mapping7.#{ORG_PREFIX}LocalGLA__c =glaMap.get('60007').Id;"
			coa_mappings_spain += "mappings.add(mapping7);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping8 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping8.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_spain += "mapping8.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60008').Id;"
			coa_mappings_spain += "mappings.add(mapping8);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping9 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping9.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_marketing}').Id;"
			coa_mappings_spain += "mapping9.#{ORG_PREFIX}LocalGLA__c =glaMap.get('60008').Id;"
			coa_mappings_spain += "mapping9.#{ORG_PREFIX}Dimension2__c =dim2USD;"
			coa_mappings_spain += "mappings.add(mapping9);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping10 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping10.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_sales_parts}').Id;"
			coa_mappings_spain += "mapping10.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60009').Id;"
			coa_mappings_spain += "mappings.add(mapping10);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping11 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping11.#{ORG_PREFIX}CorporateGLA__c =glaMap.get('#{$bd_gla_stock_parts}').Id;"
			coa_mappings_spain += "mapping11.#{ORG_PREFIX}LocalGLA__c =glaMap.get('600010').Id;"
			coa_mappings_spain += "mappings.add(mapping11);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping12 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping12.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_vat_output}').Id;"
			coa_mappings_spain += "mapping12.#{ORG_PREFIX}LocalGLA__c =glaMap.get('600011').Id;"
			coa_mappings_spain += "mappings.add(mapping12);"

			coa_mappings_spain += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping25 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_spain += "mapping25.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_spain += "mapping25.#{ORG_PREFIX}LocalGLA__c = glaMap.get('60009').Id;"
			coa_mappings_spain += "mapping25.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_spain += "mappings.add(mapping25);"
			insert_mappings = "insert mappings;"
			APEX.execute_commands [glaString + coa_mappings_spain+insert_mappings]
			
			coa_mappings_usa = "List<#{ORG_PREFIX}ChartOfAccountsMapping__c> mappings = new List<#{ORG_PREFIX}ChartOfAccountsMapping__c>();"
			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping13 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping13.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('4001').Id;"
			coa_mappings_usa += "mapping13.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70001').Id;"
			coa_mappings_usa += "mappings.add(mapping13);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping14 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping14.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_eur}').Id;"
			coa_mappings_usa += "mapping14.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70002').Id;"
			coa_mappings_usa += "mappings.add(mapping14);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping15 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping15.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_usd}').Id;"
			coa_mappings_usa += "mapping15.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70003').Id;"
			coa_mappings_usa += "mappings.add(mapping15);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping16 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping16.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_receivable_control_usd}').Id;"
			coa_mappings_usa += "mapping16.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70004').Id;"
			coa_mappings_usa += "mapping16.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping16);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping17 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping17.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_eur}').Id;"
			coa_mappings_usa += "mapping17.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70005').Id;"
			coa_mappings_usa += "mappings.add(mapping17);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping18 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping18.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_usd}').Id;"
			coa_mappings_usa += "mapping18.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70006').Id;"
			coa_mappings_usa += "mappings.add(mapping18);" 

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping19 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping19.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_account_payable_control_usd}').Id;"
			coa_mappings_usa += "mapping19.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70007').Id;"
			coa_mappings_usa += "mapping19.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping19);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping20 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping20.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_usa += "mapping20.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70008').Id;"
			coa_mappings_usa += "mappings.add(mapping20);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping21 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping21.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_marketing}').Id;"
			coa_mappings_usa += "mapping21.#{ORG_PREFIX}LocalGLA__c =glaMap.get('70009').Id;"
			coa_mappings_usa += "mapping21.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping21);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping22 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping22.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_sales_parts}').Id;"
			coa_mappings_usa += "mapping22.#{ORG_PREFIX}LocalGLA__c = glaMap.get('70009').Id;"
			coa_mappings_usa += "mappings.add(mapping22);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping23 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping23.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_sales_parts}').Id;"
			coa_mappings_usa += "mapping23.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700010').Id;"
			coa_mappings_usa += "mapping23.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping23);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping24 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping24.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_stock_parts}').Id;"
			coa_mappings_usa += "mapping24.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700011').Id;"
			coa_mappings_usa += "mappings.add(mapping24);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping27 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping27.#{ORG_PREFIX}CorporateGLA__c =  glaMap.get('#{$bd_gla_stock_parts}').Id;"
			coa_mappings_usa += "mapping27.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700012').Id;"
			coa_mappings_usa += "mapping27.#{ORG_PREFIX}Dimension3__c =dim3USD;"
			coa_mappings_usa += "mappings.add(mapping27);"

			coa_mappings_usa += "#{ORG_PREFIX}ChartOfAccountsMapping__c mapping28 = new #{ORG_PREFIX}ChartOfAccountsMapping__c();"
			coa_mappings_usa += "mapping28.#{ORG_PREFIX}CorporateGLA__c = glaMap.get('#{$bd_gla_postage_and_stationery}').Id;"
			coa_mappings_usa += "mapping28.#{ORG_PREFIX}LocalGLA__c = glaMap.get('700012').Id;"
			coa_mappings_usa += "mapping28.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			coa_mappings_usa += "mappings.add(mapping28);"        
			
			APEX.execute_commands [glaString + coa_mappings_usa +insert_mappings]
			
			#Set local chart of account structures = Spain on company = merlin auto spain
			update_company = "#{ORG_PREFIX}codaCompany__c  company1= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_spain}'];"
			update_company += "company1.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_spain_id}';"
			update_company += "company1.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = true;"
			update_company += "UPDATE company1;"
			#also Set local chart of account structures = USA on company = merlin auto USA 
			update_company += "#{ORG_PREFIX}codaCompany__c  company2= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
			update_company += "company2.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_usa_id}';"
			update_company += "company2.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = true;"
			update_company += "UPDATE company2;"
			#Set the Use Local Account true for the current company(Merlin Auto Spain) 
			update_company += "#{ORG_PREFIX}codaUserCompany__c user_company =  [SELECT ID, Name , #{ORG_PREFIX}company__c from #{ORG_PREFIX}codaUserCompany__c where #{ORG_PREFIX}User__r.FirstName = 'System' AND #{ORG_PREFIX}User__r.LastName = 'Administrator' AND #{ORG_PREFIX}Company__r.Name = '#{$company_merlin_auto_spain}'][0];"
			update_company += "user_company.#{ORG_PREFIX}UseLocalAccount__c = true;"
			update_company += "UPDATE  user_company;"
			APEX.execute_commands [update_company]

			# Above code will make COAs active. Therefore making the is_chart_of_account_status_active as true so that in delete data
			# these COAs can be updated and deleted properly.
			is_chart_of_account_status_active = true
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			#Sales Invoices 1 and 2
			create_sales_invoices = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_invoices += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_invoices += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_cambridge_auto}'];"
			create_sales_invoices += "for (integer i = 1; i <= 2; i++)"
			create_sales_invoices += "{"
			create_sales_invoices += "#{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice dto = new #{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice();"
			create_sales_invoices += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_invoices += "dto.InvoiceDate = Date.today();" 
			create_sales_invoices += "dto.InvoiceCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"	
			create_sales_invoices += "dto.InvoiceDescription = '#{_sin_description}'+i;"
			create_sales_invoices += "dto.DeriveCurrency = false;"
			create_sales_invoices += "dto.DerivePeriod = true;"
			create_sales_invoices += "dto.DeriveDueDate = true;"
			create_sales_invoices += "dto.LineItems = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItems();"
			create_sales_invoices += "dto.LineItems.LineItemList = new List<#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem>();"
			create_sales_invoices += "for(integer count=1; count<=4;count++)"
			create_sales_invoices += "{"
			create_sales_invoices += "#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem lineItem = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem();"
			create_sales_invoices += "lineItem.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_invoices += "lineItem.Quantity = 1;"
			create_sales_invoices += "lineItem.UnitPrice = 100;"
			create_sales_invoices += "lineItem.TaxCode1 = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_tax_code_vo_std_sales}');" 
			create_sales_invoices += "lineItem.LineDescription = '#{_sin_description}'+ i + '#{_line_description}'+count ;"
			create_sales_invoices += "lineItem.TaxCode1 = null;"
			create_sales_invoices += "lineItem.TaxValue1= null;"
			create_sales_invoices += "if(count == 2 || count == 3){lineItem.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');}"
			create_sales_invoices += "dto.LineItems.LineItemList.add(lineItem);"
			create_sales_invoices += "}"
			create_sales_invoices += "Id dto2Id = #{_name_space_name}CODAAPISalesInvoice_10_0.CreateInvoice(context, dto).Id;"
			create_sales_invoices += "#{_name_space_name}CODAAPICommon.Reference salesInvoiceIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_invoices += "}"
			
			create_sales_credit_note = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_credit_note += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_credit_note += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_cambridge_auto}'];"
			create_sales_credit_note += "for (integer i = 1; i <= 2; i++)"
			create_sales_credit_note += "{"
			create_sales_credit_note += "/* Set up header information */"
			create_sales_credit_note += "#{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote dto = new #{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote();"
			create_sales_credit_note += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_credit_note += "dto.DeriveCurrency = false;"
			create_sales_credit_note += "dto.DerivePeriod = true;"
			create_sales_credit_note += "dto.DeriveDueDate = true ;"
			create_sales_credit_note += "dto.CreditNoteDate = Date.today();" 
			create_sales_credit_note += "dto.CreditNoteCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"
			create_sales_credit_note += "dto.CreditNoteDescription = '#{_scrn_description}'+i;"

			create_sales_credit_note += "/* Now for the lines */"
			create_sales_credit_note += "dto.LineItems = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItems();"
			create_sales_credit_note += "dto.LineItems.LineItemlist = new List<#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem>();"
			create_sales_credit_note += "for ( integer j = 1; j<=4; j++)"
			create_sales_credit_note += "{"
			create_sales_credit_note += "#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem lineDto = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem();"
			create_sales_credit_note += "lineDto.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_credit_note += "lineDto.Quantity = 1;"
			create_sales_credit_note += "lineDto.UnitPrice = 100;"
			create_sales_credit_note += "LineDto.TaxCode1 = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_tax_code_vo_std_sales}');"
			create_sales_credit_note += "LineDto.LineDescription = '#{_scrn_description}'+ i + '#{_line_description}'+j;"
			create_sales_credit_note += "if(j==2 || j==3)"
			create_sales_credit_note += "lineDto.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');"
			create_sales_credit_note += "dto.LineItems.LineItemlist.Add(lineDto);"
			create_sales_credit_note += "}"
			create_sales_credit_note += "Id dto2Id = #{_name_space_name}CODAAPISalesCreditNote_10_0.CreateCreditNote(context, dto).Id;"
			create_sales_credit_note += "#{_name_space_name}CODAAPICommon.Reference salesCreditNoteIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_credit_note += "}"
						
			#Create Payable invoice 1 and 2 with line items
			create_purchase_invoices = "#{_name_space_name}CODAAPICommon_9_0.Context context = new #{_name_space_name}CODAAPICommon_9_0.Context();"
			create_purchase_invoices += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_purchase_invoices += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_audi}'];"
			create_purchase_invoices += "for (Integer i=1; i<=2; i++)"
            create_purchase_invoices += "{"
            create_purchase_invoices += "#{_name_space_name}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice pinv = new  #{_name_space_name}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();"
            create_purchase_invoices += "pinv.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);" 
			create_purchase_invoices += "pinv.AccountInvoiceNumber = 'AIN#00'+string.valueof(DateTime.now().hour())+'-'+string.valueof(DateTime.now().minute())+'-'+string.valueof(DateTime.now().second())+'-'+string.valueof(DateTime.now().millisecond());"
			create_purchase_invoices += "pinv.InvoiceDate = System.today();"
			create_purchase_invoices += "pinv.DueDate= System.today()+5;"
			create_purchase_invoices += "pinv.InvoiceDescription = '#{_pinv_description}'+i;"
			
			create_purchase_invoices += "pinv.LineItems = new  #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();"
			create_purchase_invoices += "pinv.LineItems.LineItemList = new List< #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();"
			
			create_purchase_invoices += "#{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem lineItem = new  #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			create_purchase_invoices += "lineItem.Product = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_purchase_invoices += "lineItem.Quantity = 1;"
			create_purchase_invoices += "lineItem.UnitPrice = 100;"
			create_purchase_invoices += "lineItem.LineDescription = '#{_pinv_description}'+ i + '#{_line_description}'+ '3';"
			create_purchase_invoices += "pinv.LineItems.LineItemList.add(lineItem);"

			create_purchase_invoices += "#{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem lineItem2 = new  #{_name_space_name}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			create_purchase_invoices += "lineItem2.Product = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_purchase_invoices += "lineItem2.Quantity = 1;"
			create_purchase_invoices += "lineItem2.UnitPrice = 100;"
			create_purchase_invoices += "lineItem2.Dimension3 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 3 USD');"
			create_purchase_invoices += "lineItem.LineDescription = '#{_pinv_description}'+ i + '#{_line_description}'+ '4';"
			create_purchase_invoices += "pinv.LineItems.LineItemList.add(lineItem2);"

			create_purchase_invoices += "Id dto2Id = #{_name_space_name}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, pinv).Id;"
			create_purchase_invoices += "#{_name_space_name}CODAAPICommon.Reference purchaseInvoiceIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_purchase_invoices += "}"

			#Purchase credit Note
			create_purchase_credit_note = "#{_name_space_name}CODAAPICommon_7_0.Context context = new #{_name_space_name}CODAAPICommon_7_0.Context();"
			create_purchase_credit_note += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_purchase_credit_note += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_account_audi}'];"
			create_purchase_credit_note += "Decimal rnd = System.Math.Random();Integer periodNumber = System.Math.round(rnd*100)/10;"
			create_purchase_credit_note += "if ( periodNumber == 0 ) periodNumber = 11;"
			create_purchase_credit_note += "String periodString = string.valueof(Date.today().year());"
			create_purchase_credit_note += "if(periodNumber >= 10){"
			create_purchase_credit_note += "periodString = periodString +'/0'+string.valueof(periodNumber);}"
			create_purchase_credit_note += "else{"
			create_purchase_credit_note += "periodString = periodString +'/00'+string.valueof(periodNumber);}"
			create_purchase_credit_note += "for (integer i = 1; i <= 2; i++)"
			create_purchase_credit_note += "{"
			create_purchase_credit_note += "#{_name_space_name}CODAAPIPurchaseCreditNoteTypes_7_0.PurchaseCreditNote dto = new #{_name_space_name}CODAAPIPurchaseCreditNoteTypes_7_0.PurchaseCreditNote();"
			create_purchase_credit_note += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_purchase_credit_note += "dto.CreditNoteDate =  Date.newInstance(Date.today().year(), periodNumber, 5);"
			create_purchase_credit_note += "dto.DueDate = Date.newInstance(Date.today().year(), periodNumber, 28);"
			create_purchase_credit_note += "dto.Period = #{_name_space_name}CODAAPICommon.getRef(null, periodString);"
			create_purchase_credit_note += "dto.CreditNoteStatus = #{_name_space_name}CODAAPIPurchaseCreditNoteTypes_7_0.enumCreditNoteStatus.InProgress;"
			create_purchase_credit_note += "dto.CreditNoteDescription = '#{_pcrn_description}'+i;"
			create_purchase_credit_note += "dto.CreditNoteCurrency = #{_name_space_name}CODAAPICommon.getRef(null, 'EUR');"
			create_purchase_credit_note += "dto.AccountCreditNoteNumber = 'Ven#00'+string.valueof(DateTime.now().hour())+'-'+string.valueof(DateTime.now().minute())+'-'+string.valueof(DateTime.now().second())+'-'+string.valueof(DateTime.now().millisecond());"
			create_purchase_credit_note += "dto.LineItems = new #{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItems();"
			create_purchase_credit_note += "dto.LineItems.LineItemlist = new #{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItem[2];"
			create_purchase_credit_note += "dto.ExpLineItems = new #{_name_space_name}CODAAPIPurchaseCreditNoteExLineTypes_7_0.PurchaseCreditNoteExpLineItems();"
			create_purchase_credit_note += "dto.ExpLineItems.LineItemList = new List<#{_name_space_name}CODAAPIPurchaseCreditNoteExLineTypes_7_0.PurchaseCreditNoteExpLineItem>();"
			create_purchase_credit_note += "for(integer j=3; j<=4; j++)"
			create_purchase_credit_note += "{"
			create_purchase_credit_note += "#{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItem lineProdDto = new #{_name_space_name}CODAAPIPurchaseCreditNoteLineTypes_7_0.PurchaseCreditNoteLineItem();"
			create_purchase_credit_note += "lineProdDto.Quantity = 1;"
			create_purchase_credit_note += "lineProdDto.Product = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_purchase_credit_note += "lineProdDto.UnitPrice = 100;"
			create_purchase_credit_note += "lineProdDto.EditTaxValue = false;"
			create_purchase_credit_note += "lineProdDto.LineDescription = '#{_pcrn_description}'+ i + '#{_line_description}'+ j;"
			create_purchase_credit_note += "if(j==4)"
			create_purchase_credit_note += "lineProdDto.Dimension3 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 3 USD');"
			create_purchase_credit_note += "dto.LineItems.LineItemlist.add(lineProdDto);"
			create_purchase_credit_note += "}"
			create_purchase_credit_note += "#{_name_space_name}CODAAPIPurchaseCreditNote_7_0.CreatePurchaseCreditNote(context, dto);"
			create_purchase_credit_note += "}"
			
			#Sales Invoices 3 and 4
			create_sales_invoices2 = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_invoices2 += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_invoices2 += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_intercompany_usa_account}'];"
			create_sales_invoices2  += "for (integer i = 3; i <= 4; i++)"
			create_sales_invoices2 += "{"
			create_sales_invoices2 += "#{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice dto = new #{_name_space_name}CODAAPIInvoiceTypes_10_0.Invoice();"
			create_sales_invoices2 += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_invoices2 += "dto.InvoiceDate = Date.today();" 
			create_sales_invoices2 += "dto.InvoiceCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"			
			create_sales_invoices2 += "dto.DeriveCurrency = false;"
			create_sales_invoices2 += "dto.DerivePeriod = true;"
			create_sales_invoices2 += "dto.DeriveDueDate = true;"
			create_sales_invoices2 += "dto.InvoiceDescription = '#{_sin_description}'+i;"
			create_sales_invoices2 += "/*Line Item 1 */"
			create_sales_invoices2 += "dto.LineItems = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItems();"
			create_sales_invoices2 += "dto.LineItems.LineItemList = new List<#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem>();"
			create_sales_invoices2 += "for(integer count=1; count<=4;count++)"
			create_sales_invoices2 += "{"
			create_sales_invoices2 += "#{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem lineItem = new #{_name_space_name}CODAAPIInvoiceLineItemTypes_10_0.InvoiceLineItem();"
			create_sales_invoices2 += "lineItem.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_invoices2 += "lineItem.Quantity = 1;"
			create_sales_invoices2 += "lineItem.UnitPrice = 100;"
			create_sales_invoices2 += "lineItem.LineDescription = '#{_sin_description}'+ i + '#{_line_description}'+count ;"
			create_sales_invoices2 += "lineItem.TaxCode1 = null;"
			create_sales_invoices2 += "lineItem.TaxValue1= null;"
			create_sales_invoices2 += "if(count == 2 || count == 3){lineItem.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');}"
			create_sales_invoices2 += "dto.LineItems.LineItemList.add(lineItem);"
			create_sales_invoices2 += "}"
			create_sales_invoices2 += "Id dto2Id = #{_name_space_name}CODAAPISalesInvoice_10_0.CreateInvoice(context, dto).Id;"
			create_sales_invoices2 += "#{_name_space_name}CODAAPICommon.Reference salesInvoiceIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_invoices2 += "}"			
			
			#Sales credit Note 3 and 4
			create_sales_credit_note2 = "#{_name_space_name}CODAAPICommon_10_0.Context context = new #{_name_space_name}CODAAPICommon_10_0.Context();"
			create_sales_credit_note2 += "context.CompanyName = '#{$company_merlin_auto_spain}';"
			create_sales_credit_note2 += "Account acc = [select Id, Name from Account where MirrorName__c ='#{$bd_intercompany_usa_account}'];"
			create_sales_credit_note2 += "for (integer i = 3; i <= 4; i++)"
			create_sales_credit_note2 += "{"
			create_sales_credit_note2 += "/* Set up header information */"
			create_sales_credit_note2 += "#{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote dto = new #{_name_space_name}CODAAPICreditNoteTypes_10_0.CreditNote();"
			create_sales_credit_note2 += "dto.Account = #{_name_space_name}CODAAPICommon.getRef(acc.Id, null);"
			create_sales_credit_note2 += "dto.DeriveCurrency = false;"
			create_sales_credit_note2 += "dto.DerivePeriod = true;"
			create_sales_credit_note2 += "dto.DeriveDueDate = true ;"
			create_sales_credit_note2 += "dto.CreditNoteDate = Date.today();" 
			create_sales_credit_note2 += "dto.CreditNoteCurrency = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_currency_gbp}');"
			create_sales_credit_note2 += "dto.CreditNoteDescription = '#{_scrn_description}'+i;"
			create_sales_credit_note2 += "/* Now for the lines */"
			create_sales_credit_note2 += "dto.LineItems = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItems();"
			create_sales_credit_note2 += "dto.LineItems.LineItemlist = new List<#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem>();"
			create_sales_credit_note2 += "for ( integer j = 1; j<=4; j++)"
			create_sales_credit_note2 += "{"
			create_sales_credit_note2 += "#{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem lineDto = new #{_name_space_name}CODAAPICreditNoteLineItemTypes_10_0.CreditNoteLineItem();"
			create_sales_credit_note2 += "lineDto.Product = #{_name_space_name}CODAAPICommon.getRef(null,  '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			create_sales_credit_note2 += "lineDto.Quantity = 1;"
			create_sales_credit_note2 += "lineDto.UnitPrice = 100;"
			create_sales_credit_note2 += "LineDto.LineDescription = '#{_scrn_description}'+ i + '#{_line_description}'+j;"
			create_sales_credit_note2 += "if(j==2 || j==3)"
			create_sales_credit_note2 += "lineDto.Dimension2 = #{_name_space_name}CODAAPICommon.getRef(null, 'Dim 2 USD');"
			create_sales_credit_note2 += "dto.LineItems.LineItemlist.Add(lineDto);"
			create_sales_credit_note2 += "}"
			create_sales_credit_note2 += "Id dto2Id = #{_name_space_name}CODAAPISalesCreditNote_10_0.CreateCreditNote(context, dto).Id;"
			create_sales_credit_note2 += "#{_name_space_name}CODAAPICommon.Reference salesCreditNoteIds = #{_name_space_name}CODAAPICommon.getRef(dto2Id, null);"
			create_sales_credit_note2 += "}"
			
			# #Add Expense line Item to Payable Invoices and PCRN
			addexp_line_items =  "Id gla6008 = [Select Id from #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name='60008'][0].id;"
			addexp_line_items += "Id usaCompany = [Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
			addexp_line_items += "Id dim2USD = [Select Id from #{ORG_PREFIX}codaDimension2__c Where Name='#{$bd_dim2_usd}'][0].Id;"
			addexp_line_items += "for(integer i=1; i<=2;i++)"
			addexp_line_items += "{"
			addexp_line_items += "List<#{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c> pinvExplineItemList = new list<#{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c>();"
			addexp_line_items += "for(integer j=1; j<=2;j++)"
			addexp_line_items += "{"
			addexp_line_items += "#{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c lineItem = new #{ORG_PREFIX}codaPurchaseInvoiceExpenseLineItem__c();"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = gla6008;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}NetValue__c = 10.00;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = usaCompany;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationNetValue__c = 2;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LineDescription__c = '#{_pinv_description}'+ i + '#{_line_description}'+ j;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}PurchaseInvoice__c = [Select Id from #{ORG_PREFIX}codaPurchaseInvoice__c where #{ORG_PREFIX}InvoiceDescription__c =:'#{_pinv_description}'+i][0].id;"
			addexp_line_items += "if(j==2)"
			addexp_line_items += "lineItem.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			addexp_line_items += "pinvExplineItemList.add(lineItem);"
			addexp_line_items += "}"
			addexp_line_items +="INSERT pinvExplineItemList;"

			addexp_line_items += "List<#{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c> pcrnExplineItemList = new list<#{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c>();"
			addexp_line_items += "for(integer j=1; j<=2;j++)"
			addexp_line_items += "{"
			addexp_line_items += "#{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c lineItem = new #{ORG_PREFIX}codaPurchaseCreditNoteExpLineItem__c();"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = gla6008;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}NetValue__c = 10.00;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = usaCompany;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}DestinationNetValue__c = 2;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}LineDescription__c = '#{_pcrn_description}'+ i + '#{_line_description}'+ j;"
			addexp_line_items += "lineItem.#{ORG_PREFIX}PurchaseCreditNote__c = [Select Id from #{ORG_PREFIX}codaPurchaseCreditNote__c where #{ORG_PREFIX}CreditNoteDescription__c = :'#{_pcrn_description}'+i][0].id;"
			addexp_line_items += "if(j==2)"
			addexp_line_items += "lineItem.#{ORG_PREFIX}Dimension2__c = dim2USD;"
			addexp_line_items += "pcrnExplineItemList.add(lineItem);"
			addexp_line_items += "}"
			addexp_line_items +="INSERT pcrnExplineItemList;"
			addexp_line_items += "}"
			
			APEX.execute_commands [create_sales_invoices, create_sales_credit_note, create_purchase_invoices, create_purchase_credit_note,create_sales_invoices2, create_sales_credit_note2, addexp_line_items]
												
			update_sinv_line_items = "list <#{ORG_PREFIX}codaInvoiceLineItem__c> invoiceLineItems;integer count=1;"
			update_scrn_line_items = "list <#{ORG_PREFIX}codaCreditNoteLineItem__c> scrnLineItems;integer count=1;"
			update_pinv_line_items = "list <#{ORG_PREFIX}codaPurchaseInvoiceLineItem__c> pinvLineItems;"
			update_pcrn_line_items = "list <#{ORG_PREFIX}codaPurchaseCreditNoteLineItem__c> pcrnLineItems;"
			for j in 1..4 do
				#update SINV Line Items destination
				update_sinv_line_items += "count=1;"
				update_sinv_line_items += "invoiceLineItems = [SELECT ID from #{ORG_PREFIX}codaInvoiceLineItem__c where #{ORG_PREFIX}Invoice__r.#{ORG_PREFIX}InvoiceDescription__c =:'#{_sin_description + j.to_s}' ORDER BY #{ORG_PREFIX}LineDescription__c];"
				update_sinv_line_items += "for(#{ORG_PREFIX}codaInvoiceLineItem__c lineItem :invoiceLineItems)"
				update_sinv_line_items += "{"
				if j<=2
					update_sinv_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = [Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
					update_sinv_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c = 1;"
					update_sinv_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c = 20.00;"
				end
				update_sinv_line_items += "if(count == 3 || count == 4)"
				update_sinv_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = [SELECT ID from #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name='60008'][0].Id;"
				update_sinv_line_items += "count++;"
				update_sinv_line_items += "}"
				update_sinv_line_items += "update invoiceLineItems;"
				
				#update SCRN Line Items destination
				update_scrn_line_items += "count=1;"
				update_scrn_line_items += "scrnLineItems = [SELECT ID from #{ORG_PREFIX}codaCreditNoteLineItem__c where #{ORG_PREFIX}CreditNote__r.#{ORG_PREFIX}CreditNoteDescription__c =:'#{_scrn_description + j.to_s}' ORDER BY #{ORG_PREFIX}LineDescription__c];"
				update_scrn_line_items += "for(#{ORG_PREFIX}codaCreditNoteLineItem__c lineItem :scrnLineItems)"
				update_scrn_line_items += "{"
				if j<=2
					update_scrn_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c = [Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
					update_scrn_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c = 1;"	
					update_scrn_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c = 20.00;"
				end
				update_scrn_line_items += "if(count == 3 || count == 4)"
				update_scrn_line_items += "lineItem.#{ORG_PREFIX}LocalGLA__c = [SELECT ID from #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name='60008'][0].Id;"
				update_scrn_line_items += "count++;"
				update_scrn_line_items += "}"
				update_scrn_line_items += "update scrnLineItems;"
			end
			#update PINV Line Items destination
			for j in 1..2 do
				update_pinv_line_items += "pinvLineItems = [SELECT ID from #{ORG_PREFIX}codaPurchaseInvoiceLineItem__c where #{ORG_PREFIX}PurchaseInvoice__r.#{ORG_PREFIX}InvoiceDescription__c =:'#{_pinv_description + j.to_s}'];"
				update_pinv_line_items += "for(#{ORG_PREFIX}codaPurchaseInvoiceLineItem__c lineItem :pinvLineItems)"
				update_pinv_line_items += "{"
				update_pinv_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c=[Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
				update_pinv_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c=1;"
				update_pinv_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c=20.00;"
				update_pinv_line_items += "}"
				update_pinv_line_items += "update pinvLineItems;"
				
				#update PCRN Line Items destination
				update_pcrn_line_items += "pcrnLineItems=[SELECT ID from #{ORG_PREFIX}codaPurchaseCreditNoteLineItem__c where #{ORG_PREFIX}PurchaseCreditNote__r.#{ORG_PREFIX}CreditNoteDescription__c =:'#{_pcrn_description + j.to_s}'];"
				update_pcrn_line_items += "for(#{ORG_PREFIX}codaPurchaseCreditNoteLineItem__c lineItem :pcrnLineItems )"
				update_pcrn_line_items += "{"
				update_pcrn_line_items += "lineItem.#{ORG_PREFIX}DestinationCompany__c=[Select Id from #{ORG_PREFIX}CodaCompany__c where Name='#{$company_merlin_auto_usa}'][0].id;"
				update_pcrn_line_items += "lineItem.#{ORG_PREFIX}DestinationQuantity__c=1;"
				update_pcrn_line_items += "lineItem.#{ORG_PREFIX}DestinationUnitPrice__c=20.00;"
				update_pcrn_line_items += "}"
				update_pcrn_line_items += "update pcrnLineItems;"
			end			
		
			APEX.execute_commands [update_sinv_line_items,update_scrn_line_items, update_pinv_line_items,update_pcrn_line_items]
		
			#create Journals
			for j in 1..2 do
				SF.tab $tab_journals
				SF.click_button_new
				JNL.set_journal_description _jrnl_description + j.to_s
				JNL.set_journal_reference 'JRN header'
				
				JNL.select_journal_line_type $bd_jnl_line_type_intercompany
				JNL.select_journal_line_value $company_merlin_auto_usa
				JNL.select_destination_line_type $label_jnl_destination_line_type_bank_account
				JNL.set_destination_line_type_value $label_jnl_destination_line_type_bank_account , $bd_bank_account_bristol_euros_account
				JNL.click_journal_new_line
				
				JNL.click_line_analysis_popup_icon 1
				JNL.set_general_ledger_account_in_analysis_popup 1, $bd_gla_marketing
				JNL.line_close_analysis_detail_popup
				JNL.line_set_journal_description  1 , _jrnl_description + j.to_s + _line_description + "1"
				JNL.line_set_journal_dimension2 1, $bd_dim2_usd
				JNL.line_set_journal_amount 1 , 10
								
				JNL.select_journal_line_type $bd_jnl_line_type_intercompany
				JNL.select_journal_line_value $company_merlin_auto_usa
				JNL.select_destination_line_type $label_jnl_destination_line_type_gla
				JNL.set_destination_line_type_value $label_jnl_destination_line_type_gla , $bd_gla_postage_and_stationery
				JNL.click_journal_new_line
				JNL.line_set_journal_amount 2 , -10
				JNL.line_set_journal_description 2 , _jrnl_description + j.to_s + _line_description + "2"
				FFA.click_save_post
				gen_wait_until_object $jnl_journal_number
			end			
		end	
		
		APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin1_description)
		sin1_name = APEX.get_field_value_from_soql_result "Name"
		#post SINV1
		SF.tab $tab_sales_invoices
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SIN.open_invoice_detail_page sin1_name
		SF.click_button $ffa_post_button
		
		APEX.execute_soql _soql_sales_invoice_by_desc.sub($sf_param_substitute , _sin3_description)
		sin3_name = APEX.get_field_value_from_soql_result "Name"
		#post SINV3
		SF.tab $tab_sales_invoices
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SIN.open_invoice_detail_page sin3_name
		SF.click_button_edit
		FFA.click_account_toggle_icon
		SIN.set_account_dimension  $sin_dimension_2_label, $bd_dim2_eur
		FFA.click_account_toggle_icon
		SIN.line_set_tax_code  1 , ""
		SIN.line_set_tax_code  2 , ""
		SIN.line_set_tax_code  3 , ""
		SIN.line_set_tax_code  4 , ""
		SF.click_button $ffa_save_post_button
		
		APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr1_description)
		scn1_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_sales_credit_notes
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SF.click_link scn1_name
		SF.click_button $ffa_post_button
		
		APEX.execute_soql _soql_sales_credit_note_by_desc.sub($sf_param_substitute , _scr3_description)
		scn3_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_sales_credit_notes
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SF.click_link scn3_name
		SF.click_button_edit
		FFA.click_account_toggle_icon
		SCR.set_account_dimension  $scn_dimension_2_label, $bd_dim2_eur
		FFA.click_account_toggle_icon

		SCR.line_set_tax_code  1 , ""
		SCR.line_set_tax_code  2 , ""
		SCR.line_set_tax_code  3 , ""
		SCR.line_set_tax_code  4 , ""
		SF.click_button $ffa_save_post_button
		
		APEX.execute_soql _soql_pinv_by_desc.sub($sf_param_substitute , _pinv1_description)
		pinv1_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_payable_invoices
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		PIN.open_invoice_detail_page pinv1_name
		SF.wait_for_search_button
		SF.click_button $ffa_post_button
		
		APEX.execute_soql _soql_pcrn_by_desc.sub($sf_param_substitute , _pcrn1_description)
		pcrn1_name = APEX.get_field_value_from_soql_result "Name"
		SF.tab $tab_payable_credit_notes
		SF.select_view $bd_select_view_all 
		SF.click_button_go
		SF.click_link pcrn1_name
		SF.wait_for_search_button
		SF.click_button $ffa_post_button		
		
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		
		#Execute the ICT created with available status
		SF.tab $tab_intercompany_transfers
		SF.select_view $bd_select_view_available
		SF.click_button_go
		FFA.listview_select_all 
		ICT.click_button_process
		ict_processing_message = FFA.ffa_get_info_message
		gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
		ICT.click_confirm_ict_process
		SF.wait_for_apex_job
				
		#Update USA ICDs as follows,Autopost - true, Autoprocess - true
		autopost = "#{ORG_PREFIX}codaCompany__c cmpny = [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
		autopost += "#{ORG_PREFIX}codaIntercompanyDefinition__c icd = [select Id, #{ORG_PREFIX}AutoProcess__c, #{ORG_PREFIX}AutoPost__c from #{ORG_PREFIX}codaIntercompanyDefinition__c where #{ORG_PREFIX}OwnerCompany__c =:cmpny.Id];"
        autopost += "icd.#{ORG_PREFIX}AutoProcess__c = true;"
        autopost += "icd.#{ORG_PREFIX}AutoPost__c = true;"
        autopost += "update icd;"
		APEX.execute_commands [autopost]
	end

	it "TST032585 : Verify the Payable credit note created with intercompany account from Payable Invoice. " do
		begin	
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
						
			## Retrieve the sales credit note name
			APEX.execute_soql _soql_pinv_by_desc.sub($sf_param_substitute , _pinv1_description)
			pinv1_name = APEX.get_field_value_from_soql_result "Name"
			
			APEX.execute_soql _soql_pinv_by_desc.sub($sf_param_substitute , _pinv2_description)
			pinv2_name = APEX.get_field_value_from_soql_result "Name"

			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			PIN.open_invoice_detail_page pinv2_name
			SF.click_button $ffa_post_button
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			##Execute the ICT created with available status
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			FFA.listview_select_all 
			ICT.click_button_process
			ict_processing_message = FFA.ffa_get_info_message
			gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job
	
			# Assert the ICT line Items , TLI and Journal Line Items 
			for j in 1..2 do
				line1_description = ""
				line2_description = ""
				line3_description = ""
				line4_description = ""
				_pinv_description = ""
				pinv_name = ""
				if j == 1
					pinv_name = pinv1_name
					line1_description = _pinv1_line1_description
					line2_description = _pinv1_line2_description
					line3_description = $bd_product_auto_com_clutch_kit_1989_dodge_raider
					line4_description = _pinv1_line4_description
					_pinv_description = _pinv1_description
				else
					pinv_name = pinv2_name
					line1_description = _pinv2_line1_description
					line2_description = _pinv2_line2_description
					line3_description = $bd_product_auto_com_clutch_kit_1989_dodge_raider
					line4_description = _pinv2_line4_description
					_pinv_description = _pinv2_description
				end
				
				##validate ICT Line Items 
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_centralized_pin
				SF.click_button_go
				ict_number_pinv = FFA.get_column_value_in_grid _source_document_description , _pinv_description , $label_ict_intercompany_transfer_number
				gen_report_test "An ICT for #{pinv_name} is processed."
				ICT.open_ICT_detail_page ict_number_pinv
				
				validate_ict_line_details ict_number_pinv, line1_description , "2.00", $bd_gla_postage_and_stationery, "", ""
				validate_ict_line_details ict_number_pinv, line2_description , "2.00", $bd_gla_marketing, $bd_dim2_usd, ""
				validate_ict_line_details ict_number_pinv, line3_description , "20.00", "", "", $bd_dim3_usd				
				validate_ict_line_details ict_number_pinv, line4_description , "20.00", "", "", ""
				
				##validate TLIs
				SF.tab $tab_payable_invoices
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				PIN.open_invoice_detail_page pinv_name
				tranx_number = PIN.get_invoice_transaction_number
				PIN.click_transaction_link_and_wait
				
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "8.00", line1_description, $bd_gla_postage_and_stationery, "60008", "12.00", "", ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label, "2.00", line1_description, $bd_gla_account_payable_control_eur, "60006", "3.00", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label,  "8.00", line2_description, $bd_gla_marketing, "60008", "12.00", $bd_dim2_usd, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label,  "2.00", line2_description, $bd_gla_account_payable_control_eur, "60006", "3.00", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label,  "80.00", line3_description, $bd_gla_stock_parts, "600010", "120.00", "", $bd_dim3_usd
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label,  "20.00", line3_description, $bd_gla_account_payable_control_eur, "60006", "30.00", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label,  "80.00", line4_description, $bd_gla_stock_parts, "600010", "120.00", "", ""
				validate_transaction_line_data_values tranx_number,$tranx_analysis_label,  "20.00", line4_description, $bd_gla_account_payable_control_eur, "60006", "30.00", $bd_dim2_eur, ""				
			
				#A Journal is created in USA corresponding to Payable Invoice 1 and 2.
				APEX.execute_soql "Select Name from #{ORG_PREFIX}codaJournal__c WHERE #{ORG_PREFIX}Reference__c = '#{pinv_name}'"
				journal_name = APEX.get_field_value_from_soql_result "Name"
									
				SF.tab $tab_journals
				SF.click_button_go
				SF.click_link journal_name
				SF.wait_for_search_button				
				
				validate_journal_line line1_description , $bd_gla_postage_and_stationery , "2.00" , "70008" , "", ""
				validate_journal_line line2_description , $bd_gla_marketing , "2.00" , "70009" , $bd_dim2_usd, ""
				validate_journal_line line4_description , $bd_gla_stock_parts , "20.00" , "700011" , "", ""
				validate_journal_line line3_description , $bd_gla_stock_parts , "20.00" , "700012" , "", $bd_dim3_usd
				validate_journal_line_values 5 , $bd_gla_account_receivable_control_usd , "-44.00" , "70004" , $bd_dim2_usd, ""
			end			
		end
		gen_end_test "end of test step TST027380-TST032585:"
	end


	it "TST032586 : Verify the Journal created with intercompany line from Payable Credit Note. " do			
		begin	
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			## Retrieve the sales credit note name
			APEX.execute_soql _soql_pcrn_by_desc.sub($sf_param_substitute , _pcrn1_description)
			pcrn1_name = APEX.get_field_value_from_soql_result "Name"
			
			APEX.execute_soql _soql_pcrn_by_desc.sub($sf_param_substitute , _pcrn2_description)
			pcrn2_name = APEX.get_field_value_from_soql_result "Name"
			SF.tab $tab_payable_credit_notes
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SF.click_link pcrn2_name
			SF.click_button $ffa_post_button
							
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			##Execute the ICT created with available status
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			FFA.listview_select_all 
			ICT.click_button_process
			ict_processing_message = FFA.ffa_get_info_message
			gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job
			
			## Validate ICT , TLI and Journal Line Items 
			for j in 1..2 do
				_line_description1 = ""
				_line_description2 = ""
				_line_description3 = ""
				_line_description4 = ""
				_pcrn_description = ""
				 pcrn_name = ""
				if j == 1
					 pcrn_name = pcrn1_name
					_line_description1 = _pcrn1_line1_description
					_line_description2 = _pcrn1_line2_description
					_line_description3 = _pcrn1_line3_description
					_line_description4 = _pcrn1_line4_description
					_pcrn_description = _pcrn1_description
				else
					pcrn_name = pcrn2_name
					_line_description1 = _pcrn2_line1_description
					_line_description2 = _pcrn2_line2_description
					_line_description3 = _pcrn2_line3_description
					_line_description4 = _pcrn2_line4_description
					_pcrn_description = _pcrn2_description
				end
				
				##Validate Inter company transfer
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_centralized_pcn
				SF.click_button_go
				ict_number_pcrn = FFA.get_column_value_in_grid _source_document_description , _pcrn_description , $label_ict_intercompany_transfer_number
				gen_report_test "An ICT for #{pcrn_name} is processed."
				
				ICT.open_ICT_detail_page ict_number_pcrn
				validate_ict_line_details ict_number_pcrn, _line_description1 ,  "2.00", $bd_gla_postage_and_stationery, "",""
				validate_ict_line_details ict_number_pcrn, _line_description2 ,  "2.00", $bd_gla_marketing, $bd_dim2_usd	,""	
				validate_ict_line_details ict_number_pcrn, _line_description3 ,  "20.00", "", ""	,""	
				validate_ict_line_details ict_number_pcrn, _line_description4 ,  "20.00", "", ""	,$bd_dim3_usd	
								
				## Assert the line items for PCRN
				SF.tab $tab_payable_credit_notes
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				SF.click_link pcrn_name
				tranx_number = PCR.get_credit_note_transaction_number
				PCR.click_transaction_number
				
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-8.00",_line_description1 , $bd_gla_postage_and_stationery, "60008", "-12.00", "", ""
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-2.00",_line_description1, $bd_gla_account_payable_control_eur, "60006", "-3.00", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-8.00",_line_description2, $bd_gla_marketing, "60008", "-12.00", $bd_dim2_usd, ""
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-2.00",_line_description2, $bd_gla_account_payable_control_eur, "60006", "-3.00", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-80.00",_line_description3, $bd_gla_stock_parts, "600010", "-120.00", "", ""
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-20.00",_line_description3, $bd_gla_account_payable_control_eur, "60006", "-30.00", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-80.00",_line_description4, $bd_gla_stock_parts, "600010", "-120.00", "", $bd_dim3_usd
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-20.00",_line_description4, $bd_gla_account_payable_control_eur, "60006", "-30.00", $bd_dim2_eur, ""
						
				##A Journal is created in USA corresponding to Payable Invoice 1 and 2.
				APEX.execute_soql "Select Name from #{ORG_PREFIX}codaJournal__c WHERE #{ORG_PREFIX}Reference__c = '#{pcrn_name}'"
				journal_name = APEX.get_field_value_from_soql_result "Name"
			  
				##validate Journal Line Items for Payable Credit Note 1. and 2
				SF.tab $tab_journals
				SF.click_button_go
				SF.click_link journal_name
				SF.wait_for_search_button
				
				validate_journal_line _line_description1 , $bd_gla_postage_and_stationery , "-2.00" , "70008" , "", ""
				validate_journal_line _line_description2 , $bd_gla_marketing , "-2.00" , "70009" , $bd_dim2_usd, ""
				validate_journal_line _line_description3 , $bd_gla_stock_parts , "-20.00" , "700011" , "", ""
				validate_journal_line _line_description4 , $bd_gla_stock_parts , "-20.00" , "700012" , "", $bd_dim3_usd
				validate_journal_line_values 5 , $bd_gla_account_receivable_control_usd, "44.00" , "70004" , $bd_dim2_usd, ""
			end
		end
		gen_end_test "end of test step TST027380-TST032582:"
	end
	
	it "TST032587 : Verify the Journal created on process a intercompany transfer record generated through journal with intercompany line. " do
		begin	
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			query_to_get_jrnl1 = "select Name from #{ORG_PREFIX}codaJournal__c where #{ORG_PREFIX}JournalDescription__c ='#{_jrnl_description + "1" }' AND #{ORG_PREFIX}reference__c='JRN header'"
			query_to_get_jrnl2 = "select Name from #{ORG_PREFIX}codaJournal__c where #{ORG_PREFIX}JournalDescription__c ='#{_jrnl_description + "2"}' AND  #{ORG_PREFIX}reference__c='JRN header'"
			# Retrieve the sales credit note name
			APEX.execute_soql query_to_get_jrnl1
			jrnl1_name = APEX.get_field_value_from_soql_result "Name"
			
			APEX.execute_soql query_to_get_jrnl2
			jrnl2_name = APEX.get_field_value_from_soql_result "Name"
			
			ict_number_jrnl = ""		
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			for j in 1..2 do
				jrnl_name = ""
				SF.tab $tab_intercompany_transfers
				SF.select_view $bd_select_view_complete_ict_journals
				SF.click_button_go
				if j==1
					ict_number_jrnl = FFA.get_column_value_in_grid _source_document_description , _jrnl_description+"1" , $label_ict_intercompany_transfer_number
					jrnl_name = jrnl1_name
				else
					ict_number_jrnl = FFA.get_column_value_in_grid _source_document_description , _jrnl_description+"2" , $label_ict_intercompany_transfer_number
					jrnl_name = jrnl2_name
				end
				_jnl_line1_description = _jrnl_description + j.to_s + _line_description+"1"
				_jnl_line2_description = _jrnl_description + j.to_s + _line_description+"2"
				
				gen_report_test "An ICT for #{ict_number_jrnl} is available for processing."
				ICT.open_ICT_detail_page ict_number_jrnl
				
				validate_ict_line_details ict_number_jrnl, _jnl_line1_description ,  "10.00", $bd_gla_marketing,  $bd_dim2_usd,""
				validate_ict_line_details ict_number_jrnl, _jnl_line2_description ,  "-10.00", $bd_gla_postage_and_stationery, "",""					
			
				##valdate Journals
				SF.tab $tab_journals
				SF.select_view $bd_select_view_all 
				SF.click_button_go
				SF.click_link jrnl_name
				tranx_number = JNL.get_journal_transaction_number
				SF.click_link tranx_number
				SF.wait_for_search_button
				
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"10.00",_jnl_line1_description, $bd_gla_account_payable_control_eur, "60006", "15.00", $bd_dim2_eur, ""
				validate_transaction_line_data_values tranx_number, $tranx_analysis_label,"-10.00",_jnl_line2_description, $bd_gla_account_payable_control_eur, "60006", "-15.00", $bd_dim2_eur, ""
				
				##A 4. A journal is created as follows:
				APEX.execute_soql "Select Name from #{ORG_PREFIX}codaJournal__c WHERE #{ORG_PREFIX}Reference__c = '#{jrnl_name}'"
				journal_name1 = APEX.get_field_value_from_soql_result "Name"
			
				SF.tab $tab_journals
				SF.click_button_go
				SF.click_link journal_name1
				SF.wait_for_search_button
				
				validate_journal_line _jnl_line1_description , $bd_gla_marketing , "10.00" , "70009" , $bd_dim2_usd, ""
				validate_journal_line _jnl_line2_description , $bd_gla_postage_and_stationery , "-10.00" , "70008" , "", ""			
			end
		end
		gen_end_test "end of test step TST027380-TST032586:"
	end

	after :all do
		# Revert all the changes which are done as part of this TID in before all method.
		login_user
		## Revert the changes on company object which are done for using chart of account structure and local GLA
		## revert only when COA are marked as active in before all base data.
		if is_chart_of_account_status_active
			revert_company_object_changes_for_local_gla 
		end
		# purge  chart of account mapping and related transactions object.
		APEX.purge_object ["ChartOfAccountsMapping__c","codaTransaction__c"]
		
		#Revert all the GLA changes
		revert_gla_object_changes
		
		# delete accounting settings which are added as a part of this script.
		delete = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
		APEX.execute_commands [delete]
		
		# Purge other object separately to avoid Too Many SOQL error which appears due to single delete statement using FFA.delete_new_data_and_wait
		APEX.purge_object ["ChartOfAccountsStructure__c","codaTransaction__c","CodaInvoice__c","codaCreditNote__c","codaPurchaseInvoice__c",
		                   "codaPurchaseCreditNote__c","codaJournal__c","codaIntercompanyDefinition__c","codaIntercompanyTransfer__c"]
		
		# Delete Test script specific data separately.
		delete_data_script = ""
        delete_data_script += "delete[SELECT Id FROM #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name='4001'or #{ORG_PREFIX}reportingCode__c like 'Local%' or #{ORG_PREFIX}reportingCode__c like 'SPAIN%' or #{ORG_PREFIX}reportingCode__c like 'USA%'];"
		APEX.execute_script delete_data_script
		
		#Delete Test Data
		FFA.delete_new_data_and_wait	
		gen_end_test "TID019992"
		SF.logout 
	end
end


#validate ICT line details
def validate_ict_line_details ict_number, ict_line_description ,  expected_amount, expected_line_gla, expected_dim2, expected_dim3
	#Assert Line values for line
	ICT.open_ict_line_item_by_line_description ict_line_description
	gen_compare expected_amount , ICT.get_ict_line_amount_value ,"Expected value to be #{expected_amount}. "
	gen_compare expected_line_gla , ICT.get_ict_line_gla_value ,"Expected GLA value to be #{expected_line_gla }. "
	gen_compare expected_dim2 , ICT.get_ict_line_dim2_value ,"Expected Dimension 2 value to be #{expected_dim2}."
	gen_compare expected_dim3 , ICT.get_ict_line_dim3_value ,"Expected Dimension 3 value to be #{expected_dim3}."
	# Back to ICT detail page
	SF.click_link ict_number
end

#validate transaction line Item
def validate_transaction_line_data_values tranx_number,line_type,home_value , line_description, line_item_gla_name, local_gla_name, local_gla_value, expected_dim2, expected_dim3
	page.has_text?(tranx_number)
    TRANX.open_transaction_line_item_by_home_value_line_description  home_value, line_description
	SF.wait_for_search_button
	gen_compare line_item_gla_name , TRANX.get_line_item_gla_name ,"Expected GLA value to be #{line_item_gla_name}."
	gen_compare local_gla_name , TRANX.get_line_item_local_gla_name ,"Expected Local GLA value to be #{local_gla_name}. "
	gen_compare local_gla_value , TRANX.get_line_item_local_gla_value ,"Expected local GLA value to be #{local_gla_value}."
	gen_compare expected_dim2 , TRANX.get_line_item_dimension2_value ,"Expected Dimension 2 value to be #{expected_dim2}."
	gen_compare expected_dim3 , TRANX.get_line_item_dimension3_value ,"Expected Dimension 3 value to be #{expected_dim3}."
	gen_compare line_type ,	TRANX.get_line_item_line_type_value ,"Expected line type value to be #{line_type}."
	SF.click_link tranx_number
	page.has_text?(tranx_number)
end

#get journal line validate journal line  get actual values and compare with expected values
def validate_journal_line line_description , expected_gla_name , expected_amount_value , expected_local_gla_name , expected_dim2, expected_dim3
	#get actual line value
	line_number = JNL.line_get_journal_line_item_number_by_description expected_gla_name, line_description
	validate_journal_line_values line_number , expected_gla_name , expected_amount_value , expected_local_gla_name , expected_dim2, expected_dim3
end

def validate_journal_line_values line_number , expected_gla_name , expected_amount_value , expected_local_gla_name , expected_dim2, expected_dim3
	#get actual line value
	actual_gla_name = JNL.line_get_journal_gla  line_number
	actual_journal_amount = JNL.line_get_journal_line_value line_number
	JNL.click_line_analysis_popup_icon line_number
	actual_local_gla = JNL.line_get_local_gla  line_number
	JNL.line_close_analysis_detail_popup
	actual_dimension2 = JNL.line_get_journal_dimension2  line_number
	actual_dimension3 = JNL.line_get_journal_dimension3  line_number
    #assert actual with expected	
	gen_compare  expected_gla_name , actual_gla_name , "Expected Journal Line item #{line_number} gla  #{expected_gla_name} "
	gen_compare  expected_amount_value , actual_journal_amount , "Expected Journal Line Item #{line_number} amount  #{expected_amount_value} "
	gen_compare  expected_local_gla_name , actual_local_gla ,  "Expected Journal Line item #{line_number} local gla #{expected_local_gla_name} "
	gen_compare  expected_dim2 , actual_dimension2 ,  "Expected Journal Line item #{line_number} Dimension 2 value #{expected_dim2}"
	gen_compare  expected_dim3 , actual_dimension3 ,  "Expected Journal Line item #{line_number} Dimension 3 value #{expected_dim3}"
end

# revert all the changes of company object which are done as apart of this TID 
def revert_company_object_changes_for_local_gla 
	_name_corporate = "Corporate"
	_name_usa = "USA"
	_name_spain = "Spain"
	_name_french = "French"
	_coa_corporate_query = "SELECT ID, Name from #{ORG_PREFIX}ChartOfAccountsStructure__c  WHERE Name = '#{$sf_param_substitute}'"
	# Updated coda company object for local GLA
	APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_corporate )
	coa_corporate_id = APEX.get_field_value_from_soql_result "Id"
	
	APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_usa )
	coa_usa_id = APEX.get_field_value_from_soql_result "Id"
	
	APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_spain )
	coa_spain_id = APEX.get_field_value_from_soql_result "Id"
	#Set local chart of account structures = Spain on company = merlin auto spain
	update_company = ""
	update_company += "#{ORG_PREFIX}codaCompany__c  company1= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_spain}'];"
	update_company += "company1.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_spain_id}';"
	update_company += "company1.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = false;"
	update_company += "UPDATE company1;"
	#also Set local chart of account structures = USA on company = merlin auto USA 
	update_company += "#{ORG_PREFIX}codaCompany__c  company2= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
	update_company += "company2.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_usa_id}';"
	update_company += "company2.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = false;"
	update_company += "UPDATE company2;"
	#Set the Use Local Account false for the current company(Merlin Auto Spain) 
	update_company += "#{ORG_PREFIX}codaUserCompany__c user_company =  [SELECT ID, Name , #{ORG_PREFIX}company__c from #{ORG_PREFIX}codaUserCompany__c where #{ORG_PREFIX}User__r.FirstName = 'System' AND #{ORG_PREFIX}User__r.LastName = 'Administrator' AND #{ORG_PREFIX}Company__r.Name = '#{$company_merlin_auto_spain}'][0];"
	update_company += "user_company.#{ORG_PREFIX}UseLocalAccount__c = false;"
	update_company += "UPDATE  user_company;"
	APEX.execute_commands [update_company]

end

# It will revert all the changes done ona GLA to make use of local GLAs
def revert_gla_object_changes
	# Update GLAs
		update_corporate_glas = "Set<String> corporateGla = new Set<String>();"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_account_payable_control_eur}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_account_receivable_control_usd}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_account_receivable_control_eur}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_account_payable_control_usd}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_sales_parts}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_stock_parts}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_postage_and_stationery}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_vat_output}');"
		update_corporate_glas += "corporateGla.add('#{$bd_gla_marketing}');"   
		update_corporate_glas += "List<#{ORG_PREFIX}CODAGeneralLedgerAccount__c> corporateGLAs = [Select Id, Name from #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name in :corporateGla];"
		#add corporate chart of account structure in corporate glas
		update_corporate_glas += "for(#{ORG_PREFIX}CODAGeneralLedgerAccount__c corpGLA : corporateGLAs)"
		update_corporate_glas += "corpGLA.#{ORG_PREFIX}ChartOfAccountsStructure__c = null;"
		update_corporate_glas += "update corporateGLAs;"
		APEX.execute_commands [update_corporate_glas]

		#Revert local chart of account structures = Spain on company = merlin auto spain
		update_company = "#{ORG_PREFIX}codaCompany__c  company1= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_spain}'];"
		update_company += "company1.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = null;"
		update_company += "company1.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = false;"
		update_company += "UPDATE company1;"
		#Revert Set local chart of account structures = USA on company = merlin auto USA 
		update_company += "#{ORG_PREFIX}codaCompany__c  company2= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
		update_company += "company2.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = null;"
		update_company += "company2.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c =  false;"
		update_company += "UPDATE company2;"
		#Revert the Use Local Account true for the current company(Merlin Auto Spain) 
		update_company += "#{ORG_PREFIX}codaUserCompany__c user_company =  [SELECT ID, Name , #{ORG_PREFIX}company__c from #{ORG_PREFIX}codaUserCompany__c where #{ORG_PREFIX}User__r.FirstName = 'System' AND #{ORG_PREFIX}User__r.LastName = 'Administrator' AND #{ORG_PREFIX}Company__r.Name = '#{$company_merlin_auto_spain}'][0];"
		update_company += "user_company.#{ORG_PREFIX}UseLocalAccount__c = false;"
		update_company += "UPDATE  user_company;"
		APEX.execute_commands [update_company]

		#Revert USA ICDs as follows,Autopost - true, Autoprocess - true
		autopost = "#{ORG_PREFIX}codaCompany__c cmpny = [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
		autopost += "#{ORG_PREFIX}codaIntercompanyDefinition__c icd = [select Id, #{ORG_PREFIX}AutoProcess__c, #{ORG_PREFIX}AutoPost__c from #{ORG_PREFIX}codaIntercompanyDefinition__c where #{ORG_PREFIX}OwnerCompany__c =:cmpny.Id];"
		autopost += "icd.#{ORG_PREFIX}AutoProcess__c = false;"
		autopost += "icd.#{ORG_PREFIX}AutoPost__c = false;"
		autopost += "update icd;"
		APEX.execute_commands [autopost]
end
