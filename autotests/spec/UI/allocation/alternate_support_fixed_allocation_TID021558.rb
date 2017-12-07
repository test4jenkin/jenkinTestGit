#--------------------------------------------------------------------#
# TID: TID021558
# Pre-Requisite: Org with basedata deployed
# Product Area: Accounting - Allocations
# Story: 40888
# To run: driver=firefox rspec -fd -c spec/UI/allocation/alternate_support_fixed_allocation_TID021558.rb -fh -o TID021558.html
#--------------------------------------------------------------------#


describe "TID021558: Verify that user is able to perform fixed allocation process with Alternate account feature ON", :type => :request do
include_context "login"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		
		#Create custom setting
		custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}AllowUseOfLocalGLAs__c = true);"
		custom_setting += "INSERT setting;"
		APEX.execute_commands [custom_setting]
	end
	
	it "TID021558 - Alternate account support for fixed allocation " do
	gla_column_label = "GENERAL LEDGER ACCOUNT"
	#variables
	_gla_400 = "400"
	_gla_4001 = "4001"
	_gla_4002 = "4002"
	_gla_4003 = "4003"
    _gla_6000 = "6000"
	_gla_7000 = "7000"
	_french_local_gla_1 = "60001"
	_french_local_gla_2 = "60002"
	_french_local_gla_3 = "60003"
	_french_local_gla_4 = "60004"
	_french_local_gla_5 = "60005"
	_spain_local_gla_1 = "70001"
	_spain_local_gla_2 = "70002"
	_spain_local_gla_3 = "70003"
	_spain_local_gla_4 = "70004"
	_spain_local_gla_5 = "70005"
	_corporate_gla_4001 = '4001'
	_corporate_gla_4002 = '4002'
	_local_gla_60001 = '60001'
	_local_gla_60002 = '60002'
	_local_gla_60003 = '60003'
	_local_gla_60004 = '60004'
	_local_gla_60005 = '60005'
	_local_gla_70001 = '70001'
	_local_gla_70002 = '70002'
	_local_gla_70003 = '70003'
	_local_gla_70004 = '70004'
	_local_gla_70005 = '70005'
	_dim_type_dim1 = 'Dimension 1'
	_dim_type_dim2 = 'Dimension 2'
	_dim_type_dim3 = 'Dimension 3'
	_dim_type_dim4 = 'Dimension 4'
	_dim_type_not_applicable = 'Not Applicable'
	_french_local_gla_with_reporting_code_1 = "60001 - French local GLA1"
	_french_local_gla_with_reporting_code_2 = "60002 - French local GLA2"
	_french_local_gla_with_reporting_code_3 = "60003 - French local GLA3"
	_french_local_gla_with_reporting_code_4 = "60004 - French local GLA4"
	_french_local_gla_with_reporting_code_5 = "60005 - French local GLA5"
	_percentage_100 = "100.00%"
	_local_fixed_allocation_rule_name = "Local fixed AR_1"
	_fixed_allocation_rule_1 = "Spain local fixed AR_1"
	_fixed_allocation_rule_description = "Spain local fixed allocation rule"
	_local_fixed_allocation_rule_description = "Local fixed allocation rule"
	_local_gla_mandatory = "You must enter a Local GLA on allocation rule lines."
	_error_message = "You must enable Allow Use of Local GLAs in the Accounting Settings (FF) custom setting if you want to edit this allocation rule."
	_col_name_to_search = "Name"
	_reporting_code_corporate = "Corporate GLA"
	_reporting_code_local_1 = "French local GLA";
	_reporting_code_local_2 = "Spain local GLA";
	current_date = Time.now.strftime("%d/%m/%Y")
	CURRENT_PERIOD = FFA.get_current_period
	# Document 
	_vendor_inv_number = "VIN0099"
	_name_corporate = "Corporate"
	_name_french = "French"
	_name_spain = "Spain"
	_coa_corporate_query = "SELECT ID, Name from #{ORG_PREFIX}ChartOfAccountsStructure__c  WHERE Name = '#{$sf_param_substitute}'"
	#List view
	_position_to_add_field = 7
	_is_local_field = ["Is Local"]

	_namspace_prefix = ""
	_namspace_prefix += ORG_PREFIX
	
	if(_namspace_prefix != nil && _namspace_prefix != "" )
		_namspace_prefix = _namspace_prefix.gsub! "__", "."
	end
	
	#Select company = merlin auto spain
	SF.tab $tab_select_company
	FFA.select_company [$company_merlin_auto_spain] ,true
		
	#create corporate  chart of account structure
	SF.tab $tab_chart_of_accounts_structures
	SF.wait_for_search_button
	SF.click_button_new
	COAS.set_name _name_corporate
	COAS.set_default_corporate true
	COAS.set_active true
	SF.click_button_save
	gen_compare_has_content _name_corporate , true , "COA corporate created."
	
	#creating corporate GLAs
	APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_corporate )
	coa_corporate_id = APEX.get_field_value_from_soql_result "Id"
	
	gla_list_query_2 = "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaList2 = new List<#{ORG_PREFIX}codaGeneralLedgerAccount__c>();"
	gla_list_query_2 += "for(integer i=1;i<=3;i++){"
	gla_list_query_2 += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla2 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_400}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_corporate}' + i, #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_corporate_id}');" 
	gla_list_query_2 += "glaList2.add(gla2);}"
	gla_list_query_2 += "INSERT glaList2;"			
	APEX.execute_commands [gla_list_query_2]
	
	#create french  chart of account structure
	SF.tab $tab_chart_of_accounts_structures
	SF.wait_for_search_button
	SF.click_button_new
	COAS.set_name _name_french
	COAS.set_default_corporate false
	COAS.set_active false
	SF.click_button_save
	gen_compare_has_content _name_french , true , "COA french created."
	
	#creating Local GLAs for COA = French
	APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_french )
	coa_french_id = APEX.get_field_value_from_soql_result "Id"
	
	gla_list_query = "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaList = new List<#{ORG_PREFIX}codaGeneralLedgerAccount__c>();"
	gla_list_query += "for(integer i=1;i<=5;i++){"
	gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla2 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_6000}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_local_1}' + i, #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_french_id}');" 
	gla_list_query += "glaList.add(gla2);}"
	gla_list_query += "INSERT glaList;"			
	APEX.execute_commands [gla_list_query]
	
	#create spain  chart of account structure
	SF.tab $tab_chart_of_accounts_structures
	SF.wait_for_search_button
	SF.click_button_new
	COAS.set_name _name_spain
	COAS.set_default_corporate false
	COAS.set_active false
	SF.click_button_save
	gen_compare_has_content _name_spain , true , "COA spain created."
	
	#creating Local GLAs for COA = Spain
	APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_spain )
	coa_spain_id = APEX.get_field_value_from_soql_result "Id"
	
	gla_list_query_1 = "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaList1 = new List<#{ORG_PREFIX}codaGeneralLedgerAccount__c>();"
	gla_list_query_1 += "for(integer i=1;i<=5;i++){"
	gla_list_query_1 += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla2 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_7000}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_local_2}' + i, #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_spain_id}');" 
	gla_list_query_1 += "glaList1.add(gla2);}"
	gla_list_query_1 += "INSERT glaList1;"			
	APEX.execute_commands [gla_list_query_1]
	
	#Activate COA = French
	SF.tab $tab_chart_of_accounts_structures
	SF.wait_for_search_button
	SF.click_button_go
	SF.click_link _name_french
	SF.wait_for_search_button
	SF.click_button_edit
	SF.wait_for_search_button	
	COAS.set_default_corporate_gla _gla_4001
	COAS.set_default_local_gla _french_local_gla_1
	COAS.set_active true
	SF.click_button_save			
	
	#Activate COA = Spain
	SF.tab $tab_chart_of_accounts_structures
	SF.wait_for_search_button
	SF.click_button_go
	SF.click_link _name_spain
	SF.wait_for_search_button
	SF.click_button_edit
	SF.wait_for_search_button	
	COAS.set_default_corporate_gla _gla_4002
	COAS.set_default_local_gla _spain_local_gla_1
	COAS.set_active true
	SF.click_button_save
	
	#Update local chart of account struture on company detail view page for company = Merlin auto spain
	update_company = "#{ORG_PREFIX}codaCompany__c  company= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_spain}'];"
	update_company += "company.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_french_id}';"
	update_company += "UPDATE company;"
	APEX.execute_commands [update_company]
	
	#Update local chart of account struture on company detail view page for company = Merlin auto USA
	update_company1 = "#{ORG_PREFIX}codaCompany__c  company1= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_usa}'];"
	update_company1 += "company1.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_spain_id}';"
	update_company1 += "UPDATE company1;"
	APEX.execute_commands [update_company1]
	
	SF.tab $tab_chart_of_accounts_mappings
	CIF.click_toggle_button
	#create COA Mapping 1
	COAM.select_dimension_type _dim_type_dim1
	COAM.select_dimension_value $bd_apex_eur_001
	COAM.select_corporate_gla _gla_4001
	COAM.select_local_gla _french_local_gla_2
	
	#create COA Mapping 2
	COAM.select_dimension_type _dim_type_dim2
	COAM.select_dimension_value $bd_apex_eur_002
	COAM.select_corporate_gla _gla_4001
	COAM.select_local_gla _french_local_gla_3
		
	#create COA Mapping 3
	COAM.select_dimension_type _dim_type_not_applicable
	COAM.select_corporate_gla _gla_4001
	COAM.select_local_gla _french_local_gla_5
	
	#create COA Mapping 4
	COAM.select_dimension_type _dim_type_dim3
	COAM.select_dimension_value $bd_dim3_eur
	COAM.select_corporate_gla _gla_4002
	COAM.select_local_gla _french_local_gla_4
		
	#create COA Mapping 5
	COAM.select_dimension_type _dim_type_dim1
	COAM.select_dimension_value $bd_apex_eur_001
	COAM.select_corporate_gla _gla_4003
	COAM.select_local_gla _french_local_gla_4
		
	#create COA Mapping 6
	COAM.select_dimension_type _dim_type_dim1
	COAM.select_dimension_value $bd_apex_eur_001
	COAM.select_corporate_gla _gla_4001
	COAM.select_local_gla _spain_local_gla_2
	
	#create COA Mapping 7
	COAM.select_dimension_type _dim_type_dim3
	COAM.select_dimension_value $bd_dim3_eur
	COAM.select_corporate_gla _gla_4002
	COAM.select_local_gla _spain_local_gla_4
	
	#create COA Mapping 8
	COAM.select_dimension_type _dim_type_not_applicable
	COAM.select_corporate_gla _gla_4001
	COAM.select_local_gla _spain_local_gla_5
	
	#create COA Mapping 9
	COAM.select_dimension_type _dim_type_dim2
	COAM.select_dimension_value $bd_apex_eur_002
	COAM.select_corporate_gla _gla_4001
	COAM.select_local_gla _spain_local_gla_3
	
	#create COA Mapping 10
	COAM.select_dimension_type _dim_type_dim1
	COAM.select_dimension_value $bd_apex_eur_001
	COAM.select_corporate_gla _gla_4003
	COAM.select_local_gla _spain_local_gla_4
	
	#Save COA mappings created
	COAM.click_on_save_button
	CIF.click_toggle_button

	#Create PINV document
	begin
	gen_report_test "Creating data for Test"
	_create_pinv1 = ""
	_create_pinv1 += "Id bmwAccId;"
	_create_pinv1 += "for(Account acc : [select Name from Account]) {"
	_create_pinv1 += "if(acc.Name == '#{$bd_account_bmw_automobiles}')"
	_create_pinv1 += "{bmwAccId = acc.Id;break;}}"
	_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice inv = new #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();"
	_create_pinv1 += "inv.Account = #{_namspace_prefix}CODAAPICommon.getRef(bmwAccId, '#{$bd_account_bmw_automobiles}');"
	_create_pinv1 += "inv.InvoiceDate = system.today();"
	_create_pinv1 += "inv.Period = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{CURRENT_PERIOD}');"
	_create_pinv1 += "inv.AccountInvoiceNumber ='TID021558_002';"
	_create_pinv1 += "inv.InvoiceStatus = #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.enumInvoiceStatus.InProgress;"
	
	_create_pinv1 += "inv.ExpLineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItems();"
	_create_pinv1 += "inv.ExpLineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem>();"
				
	_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
	_create_pinv1 += "expLine1.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'4003');"
	_create_pinv1 += "expLine1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_apex_eur_001}');"
	_create_pinv1 += "expLine1.NetValue = 100.00;"
	_create_pinv1 += "expLine1.InputVATCode = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_tax_code_vo_r_purchase}');"
	_create_pinv1 += "expLine1.TaxValue1 = 5.00;"
	_create_pinv1 += "inv.ExpLineItems.LineItemList.add(expLine1);"
	
	_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine2 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
	_create_pinv1 += "expLine2.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'4002');"
	_create_pinv1 += "expLine2.Dimension3 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim3_eur}');"
	_create_pinv1 += "expLine2.NetValue = 230.00;"
	_create_pinv1 += "expLine2.InputVATCode = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_tax_code_vo_r_purchase}');"
	_create_pinv1 += "expLine2.TaxValue1 = 11.50;"
	_create_pinv1 += "inv.ExpLineItems.LineItemList.add(expLine2);"
	
	_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine3 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
	_create_pinv1 += "expLine3.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'4001');"
	_create_pinv1 += "expLine3.Dimension2 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_apex_eur_002}');"
	_create_pinv1 += "expLine3.NetValue = 450.00;"
	_create_pinv1 += "expLine3.InputVATCode = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_tax_code_vo_r_purchase}');"
	_create_pinv1 += "expLine3.TaxValue1 = 22.50;"
	_create_pinv1 += "inv.ExpLineItems.LineItemList.add(expLine3);"
	
	_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine4 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
	_create_pinv1 += "expLine4.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'4001');"
	_create_pinv1 += "expLine4.NetValue = 560.00;"
	_create_pinv1 += "expLine4.InputVATCode = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_tax_code_vo_r_purchase}');"
	_create_pinv1 += "expLine4.TaxValue1 = 28.00;"
	_create_pinv1 += "inv.ExpLineItems.LineItemList.add(expLine4);"
	
	_create_pinv1 += "#{_namspace_prefix}CODAAPICommon_9_0.Context context = new #{_namspace_prefix}CODAAPICommon_9_0.Context();"
	_create_pinv1 += "context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1', Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));"
	
	_create_pinv1 += "Id dto2Id = #{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, inv).Id;"
	_create_pinv1 += "#{_namspace_prefix}CODAAPICommon.Reference purchaseInvoiceIds = #{_namspace_prefix}CODAAPICommon.getRef(dto2Id, null);"
	_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(context, purchaseInvoiceIds);"
	
	APEX.execute_commands [_create_pinv1]
	gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful creation of PINV."	
	end 
	
	# Update user company for company = Merlin auto spain
	_update_user_company_1 = "#{ORG_PREFIX}CodaUserCompany__c usercomp = [select Id, #{ORG_PREFIX}UseLocalAccount__c from #{ORG_PREFIX}codaUserCompany__c where #{ORG_PREFIX}Company__r.Name = '#{$company_merlin_auto_spain}' and #{ORG_PREFIX}User__c = :UserInfo.getUserId()]; usercomp.#{ORG_PREFIX}UseLocalAccount__c = true; update usercomp;"
	updateUserCompany1 = [_update_user_company_1]
	APEX.execute_commands updateUserCompany1
	
	# Update user company for company = Merlin auto USA
	_update_user_company_2 = "#{ORG_PREFIX}CodaUserCompany__c usercomp = [select Id, #{ORG_PREFIX}UseLocalAccount__c from #{ORG_PREFIX}codaUserCompany__c where #{ORG_PREFIX}Company__r.Name = '#{$company_merlin_auto_usa}' and #{ORG_PREFIX}User__c = :UserInfo.getUserId()]; usercomp.#{ORG_PREFIX}UseLocalAccount__c = true; update usercomp;"
	updateUserCompany2 = [_update_user_company_2]
	APEX.execute_commands updateUserCompany2
		
	SF.tab $tab_allocations
	Allocations.allocation_list_view_click_new_button
	begin
		gen_start_test "TST037960 - Verify that user is able to perform fixed allocation process with creating new fixed allocation rule with local GLAs through Pop up"
		
		#filter 1
		Allocations.set_filterset_field 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label, _local_gla_60004
		Allocations.set_filterset_field 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_001
		Allocations.click_on_add_filter_group_button
		#filter 2
		Allocations.set_filterset_field 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,_local_gla_60004
		Allocations.set_filterset_field 2,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_eur
		Allocations.click_on_add_filter_group_button
		#filter 3
		Allocations.set_filterset_field 3,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,_local_gla_60003
		Allocations.set_filterset_field 3,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
		Allocations.click_on_add_filter_group_button
		#filter 4
		Allocations.set_filterset_field 4,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,_local_gla_60005
		Allocations.click_on_preview_button
		
		#Navigate to Allocation method screen
		Allocations.click_on_next_button
		
		#Navigate to fixed distribution screen
		Allocations.click_on_next_button
		
		#Toggle to full screen
		CIF.click_toggle_button
		
		#Set values in row 1 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 1, _local_gla_60001
		Allocations.set_split_line_dimension1 1, $bd_apex_eur_001
		
		#Set values in row 2 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 2, _local_gla_60001
		
		#Set values in row 3 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 3, _local_gla_60003
		
		#Set values in row 4 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 4, _local_gla_60004
		
		#Set values in row 5 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 5, _local_gla_60005
		
		#Set values in row 6 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 6, _local_gla_60004
		Allocations.set_split_line_dimension1 6, $bd_apex_eur_001
		
		#Set values in row 7 of Manual Allocation distribution grid
		Allocations.set_split_line_gla 7, _local_gla_60004
		Allocations.set_split_line_dimension3 7, $bd_dim3_eur
		
		#Perform spread evenly operation on fixed distribution screen
		Allocations.click_spread_evenly_link
		
		#Save fixed allocation rule with alternate account feature ON
		Allocations.click_on_save_allocation_rule_button
		Allocations.set_rule_name_in_pop_up _local_fixed_allocation_rule_name
		Allocations.set_rule_description_in_pop_up _local_fixed_allocation_rule_description
		Allocations.click_on_save_button_save_rule_pop_up
		
		Allocations.click_on_next_button
		
		#Expand Allocation post screen preview section
		Allocations.click_on_accordion_panel_expand_button
		
		#Expand source and distribution sections 
		Allocations.click_on_source_section_expand_collapse_button
		Allocations.click_on_distribution_section_expand_collapse_button
		
		_row1_source_TST037960 = "#{_french_local_gla_with_reporting_code_3} #{$bd_apex_eur_002} 450.00" 
		_row2_source_TST037960 = "#{_french_local_gla_with_reporting_code_4} #{$bd_dim3_eur} 230.00"
		_row3_source_TST037960 = "#{_french_local_gla_with_reporting_code_4} #{$bd_apex_eur_001} 100.00"
		_row4_source_TST037960 = "#{_french_local_gla_with_reporting_code_5} 560.00"
		_row1_distribution_TST037960 = "#{_french_local_gla_with_reporting_code_4} #{$bd_dim3_eur} 191.43"
		_row2_distribution_TST037960 = "#{_french_local_gla_with_reporting_code_4} #{$bd_apex_eur_001} 191.43"
		_row3_distribution_TST037960 = "#{_french_local_gla_with_reporting_code_5} 191.43"
		_row4_distribution_TST037960 = "#{_french_local_gla_with_reporting_code_4} 191.42"
		_row5_distribution_TST037960 = "#{_french_local_gla_with_reporting_code_3} 191.43"
		_row6_distribution_TST037960 = "#{_french_local_gla_with_reporting_code_1} 191.43"
		_row7_distribution_TST037960 = "#{_french_local_gla_with_reporting_code_1} #{$bd_apex_eur_001} 191.43"
		
		#Assert the values in source and distribution section on preview grid.
		gen_compare _row1_source_TST037960, Allocations.get_allocation_preview_grid_row(1) ,"TST037960 Expected row 1 on preview grid"
		gen_compare _row2_source_TST037960, Allocations.get_allocation_preview_grid_row(2) ,"TST037960 Expected row 2 on preview grid"
		gen_compare _row3_source_TST037960, Allocations.get_allocation_preview_grid_row(3) ,"TST037960 Expected row 3 on preview grid"
		gen_compare _row4_source_TST037960, Allocations.get_allocation_preview_grid_row(4) ,"TST037960 Expected row 4 on preview grid"
		gen_compare _row1_distribution_TST037960, Allocations.get_allocation_preview_grid_row(5) ,"TST037960 Expected row 5 on preview grid"
		gen_compare _row2_distribution_TST037960, Allocations.get_allocation_preview_grid_row(6) ,"TST037960 Expected row 6 on preview grid"
		gen_compare _row3_distribution_TST037960, Allocations.get_allocation_preview_grid_row(7) ,"TST037960 Expected row 7 on preview grid"
		gen_compare _row4_distribution_TST037960, Allocations.get_allocation_preview_grid_row(8) ,"TST037960 Expected row 8 on preview grid"
		gen_compare _row5_distribution_TST037960, Allocations.get_allocation_preview_grid_row(9) ,"TST037960 Expected row 9 on preview grid"
		gen_compare _row6_distribution_TST037960, Allocations.get_allocation_preview_grid_row(10) ,"TST037960 Expected row 10 on preview grid"
		gen_compare _row7_distribution_TST037960, Allocations.get_allocation_preview_grid_row(11) ,"TST037960 Expected row 11 on preview grid"
		CIF.click_toggle_button
		
		#Post allocation document created
		Allocations.click_on_post_button
		
		#Drag Is Local field to list view and verify it's value
		SF.tab $tab_allocation_rules
		SF.click_button_go
		FFA.edit_view_add_fields _is_local_field,_position_to_add_field
		gen_compare_has_xpath $allocationrules_is_local_checked,true,'Is Local checkbox is checked on list view for local allocation rules'
		
		#Navigate to Local fixed allocation rule detail page
		AllocationRules.open_allocation_rule_detail_page _local_fixed_allocation_rule_name
		
		#Assert company field should be populated on fixed allocation rule created with alternate account feature ON
		gen_compare true, AllocationRules.assert_company_field_value($company_merlin_auto_spain), "Company field value is matched"
		gen_report_test "Verified Merlin auto spain is disaplaying on allocation rule company header"
		
		_row1_allocation_rule_TST037960 = "#{_french_local_gla_with_reporting_code_1} #{$bd_apex_eur_001} 14.2857"
		_row2_allocation_rule_TST037960 = "#{_french_local_gla_with_reporting_code_1} 14.2857"
		_row3_allocation_rule_TST037960 = "#{_french_local_gla_with_reporting_code_3} 14.2857"
		_row4_allocation_rule_TST037960 = "#{_french_local_gla_with_reporting_code_4} 14.2858"
		_row5_allocation_rule_TST037960 = "#{_french_local_gla_with_reporting_code_5} 14.2857"
		_row6_allocation_rule_TST037960 = "#{_french_local_gla_with_reporting_code_4} #{$bd_apex_eur_001} 14.2857"
		_row7_allocation_rule_TST037960 = "#{_french_local_gla_with_reporting_code_4} #{$bd_dim3_eur} 14.2857"
		
		#Assert local fixed allocation rule lines
		gen_compare _row1_allocation_rule_TST037960,AllocationRules.get_allocation_rule_grid_row(1),"Expected row on Fixed Allocation Rule grid is verified"
		gen_compare _row2_allocation_rule_TST037960,AllocationRules.get_allocation_rule_grid_row(2),"Expected row on Fixed Allocation Rule grid is verified"
		gen_compare _row3_allocation_rule_TST037960,AllocationRules.get_allocation_rule_grid_row(3),"Expected row on Fixed Allocation Rule grid is verified"
		gen_compare _row4_allocation_rule_TST037960,AllocationRules.get_allocation_rule_grid_row(4),"Expected row on Fixed Allocation Rule grid is verified"
		gen_compare _row5_allocation_rule_TST037960,AllocationRules.get_allocation_rule_grid_row(5),"Expected row on Fixed Allocation Rule grid is verified"
		gen_compare _row6_allocation_rule_TST037960,AllocationRules.get_allocation_rule_grid_row(6),"Expected row on Fixed Allocation Rule grid is verified"
		gen_compare _row7_allocation_rule_TST037960,AllocationRules.get_allocation_rule_grid_row(7),"Expected row on Fixed Allocation Rule grid is verified"
	gen_end_test "TST037960 - Verify that user is able to perform fixed allocation process with creating new fixed allocation rule with local GLAs through Pop up"
	end
	
	begin
		gen_start_test "TST037971 - Verify that only local fixed allocation rule will be displayed in Allocation rule picklist with alternate account feature ON and vice versa."
		SF.tab $tab_allocation_rules
		SF.click_button_go
		AllocationRules.open_allocation_rule_detail_page _local_fixed_allocation_rule_name
		
		#Click edit button
		AllocationRules.click_edit_button
		
		#Company picklist field should be in disabled mode
		gen_assert_disabled $allocationrules_company_field
		gen_compare true, page.has_text?($allocationrules_local_gla_label), "Local Gla Label text is present."
		gen_report_test "Local GLA label should be displayed in allocation rules grid"
		
		#Select clear All button
		AllocationRules.click_clear_all_button
		
		#Company picklist field should be in enabled mode 
		gen_assert_enabled $allocationrules_company_field
		
		#Assert the values in local GLA picklist
		_assert_french_local_gla_present = AllocationRules.is_gla_values_present [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004,_local_gla_60005 ],1
		gen_compare 5, _assert_french_local_gla_present, "Local GLA - 60001,60002,60003,60004,60005 should be present"
		_assert_corporate_gla_should_not_present = AllocationRules.is_gla_values_present [ _corporate_gla_4001,_corporate_gla_4002 ],1
		gen_compare 0,_assert_corporate_gla_should_not_present,"corporate GLA - 4001, 4002 should not be present"
		_assert_spain_local_gla_should_not_present = AllocationRules.is_gla_values_present [ _local_gla_70001,_local_gla_70002,_local_gla_70003,_local_gla_70004,_local_gla_70005 ],1
		gen_compare 0,_assert_spain_local_gla_should_not_present,"Local GLA - 70001,70002,70003,70004,70005 should not be present"
		
		#Set company = null on allocation rule UI
		AllocationRules.set_company_name ''
		
		#GLA grid will be displayed to user
		gen_compare true, page.has_text?(gla_column_label), "Gla Label text is present."
		gen_report_test "General Ledger Account label should be displayed in allocation rules grid"
		
		#Assert the values in GLA picklist
		_assert_french_local_gla_should_not_present_1 = AllocationRules.is_gla_values_present [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004,_local_gla_60005 ],1
		gen_compare 0, _assert_french_local_gla_should_not_present_1, "Local GLA - 60001,60002,60003,60004,60005 should not be present"
		_assert_corporate_gla_should_present_1 = AllocationRules.is_gla_values_present [ _corporate_gla_4001,_corporate_gla_4002 ],1
		gen_compare 2,_assert_corporate_gla_should_present_1,"corporate GLA - 4001, 4002 should be present"
		_assert_spain_local_gla_should_not_present_1 = AllocationRules.is_gla_values_present [ _local_gla_70001,_local_gla_70002,_local_gla_70003,_local_gla_70004,_local_gla_70005 ],1
		gen_compare 0,_assert_spain_local_gla_should_not_present_1,"Local GLA - 70001,70002,70003,70004,70005 should not be present"
		
		#Set company = Merlin auto USA on Allocation rule UI
		AllocationRules.set_company_name $company_merlin_auto_usa
		
		#Local GLA grid will be displayed to user
		gen_compare true, page.has_text?($allocationrules_local_gla_label), "Local Gla Label text is present."
		gen_report_test "Local GLA label should be displayed in allocation rules grid"
		
		#Assert the values in local GLA picklist
		_assert_spain_local_gla_should_present_2 = AllocationRules.is_gla_values_present [ _local_gla_70001,_local_gla_70002,_local_gla_70003,_local_gla_70004,_local_gla_70005 ],1
		gen_compare 5,_assert_spain_local_gla_should_present_2,"Local GLA - 70001,70002,70003,70004,70005 should be present"
		_assert_french_local_gla_should_not_present_2 = AllocationRules.is_gla_values_present [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004,_local_gla_60005 ],1
		gen_compare 0,_assert_french_local_gla_should_not_present_2,"Local GLA - 60001,60002,60003,60004,60005 should not be present"
		_assert_corporate_gla_should_not_present_2 = AllocationRules.is_gla_values_present [ _corporate_gla_4001,_corporate_gla_4002 ],1
		gen_compare 0,_assert_corporate_gla_should_not_present_2,"corporate GLA - 4001, 4002 should not be present"
		
		gen_end_test "TST037971 - Verify that only local fixed allocation rule will be displayed in Allocation rule picklist with alternate account feature ON and vice versa."
	end
	
	begin
		gen_start_test "TST037972 - Verify the validations on Allocation rule with Alternate account feature ON."
		#Update user company for company = Merlin auto spain
		_update_user_company_1 = "#{ORG_PREFIX}CodaUserCompany__c usercomp = [select Id, #{ORG_PREFIX}UseLocalAccount__c from #{ORG_PREFIX}codaUserCompany__c where #{ORG_PREFIX}Company__r.Name = '#{$company_merlin_auto_spain}' and #{ORG_PREFIX}User__c = :UserInfo.getUserId()]; usercomp.#{ORG_PREFIX}UseLocalAccount__c = false; update usercomp;"
		updateUserCompany1 = [_update_user_company_1]
		APEX.execute_commands updateUserCompany1
		
		SF.tab $tab_allocation_rules
		SF.click_button_go
		FFA.click_edit_link_on_list_gird _col_name_to_search , _local_fixed_allocation_rule_name
		gen_include _error_message, FFA.get_error_message2, "Expected error message on edit action is:\"#{_error_message}\""
		gen_report_test "Expected error message verified"
		
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		
		#Error Message 1
		SF.tab $tab_allocation_rules
		SF.click_button_new		
		AllocationRules.select_rule_type $allocationrules_type_fixed_label
		AllocationRules.set_rule_name ""
		AllocationRules.set_company_name $company_merlin_auto_usa
		AllocationRules.click_save_button
		gen_include $allocationrules_message_name_required , AllocationRules.get_error_message , "Expected Allocation Rule Mandatory Name Validation"
		AllocationRules.click_continue_button_on_popup

		#Error Message 2
		AllocationRules.set_rule_name _local_fixed_allocation_rule_name
		AllocationRules.set_company_name $company_merlin_auto_usa
		AllocationRules.click_save_button
		gen_include $allocationrules_message_name_already_exist , AllocationRules.get_error_message , "Expected Allocation Rule Existing Name Validation"
		AllocationRules.click_continue_button_on_popup
		
		#Error Message 3
		AllocationRules.set_rule_name _fixed_allocation_rule_1
		AllocationRules.set_rule_description _fixed_allocation_rule_description
		AllocationRules.set_fixed_rule_line_dim1 $bd_dim1_usd
		AllocationRules.click_save_button
		gen_include _local_gla_mandatory , AllocationRules.get_error_message , "Expected Mandatory local GLA Validation"
		AllocationRules.click_continue_button_on_popup
		
		#Save allocation rule successfully
		AllocationRules.set_fixed_rule_line_gla _local_gla_70002,1
		AllocationRules.set_fixed_rule_line_percentage _percentage_100 , 1
		AllocationRules.click_save_button
		
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		gen_end_test "TST037972 - Verify the validations on Allocation rule with Alternate account feature ON."
	end	
end

after :all do
	login_user
	delete_data_script = ""
	
	# Delete Test script specific data separately.
	delete_data_script += "delete[SELECT Id FROM #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name='4001'or #{ORG_PREFIX}reportingCode__c like 'Spain%' or #{ORG_PREFIX}reportingCode__c like 'French%' or #{ORG_PREFIX}reportingCode__c like 'Corporate%'];"
	APEX.execute_script delete_data_script
		
	#Delete Test Data
	FFA.delete_new_data_and_wait
	SF.logout
end
end