#--------------------------------------------------------------------#
#	TID : TID021512
#	Pre-Requisite: Org with basedata deployed.
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocation_progress_wizard_preview_panel_TID021512.rb -fh -o TID021512.html
#   Compatible with - Managed org.
#--------------------------------------------------------------------#
describe "TID021512 - This TID verify the progress bar along when Fixed type of allocation is selected for Posting allocation.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		gen_start_test "TID021512: Verify the progress bar along when Fixed type of allocation is selected for Posting allocation."
		FFA.hold_base_data_and_wait
	end
	
	it "Verify the progress bar along when Fixed type of allocation is selected for Posting allocation." do
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain], true
		
		_rule_name = "TID021512FixedAR"
		_variable_rule_name = "TID021512VariableAR"
		_basis_name = "TID021512Basis"
		_allocation_method_value_fixed = "Fixed"
		_allocation_method_value_variable = "Variable > Statistical"
		_namspace_prefix = ""
		_namspace_prefix += ORG_PREFIX
		
		if(_namspace_prefix != nil && _namspace_prefix != "" )
			_namspace_prefix = _namspace_prefix.gsub! "__", "."
		end	
		CURRENT_PERIOD = FFA.get_current_period
	begin	
		_gla_query = "SELECT ID, Name from #{ORG_PREFIX}codaGeneralLedgerAccount__c  WHERE Name = '#{$sf_param_substitute}'"
		_dim1_query = "SELECT ID, Name from #{ORG_PREFIX}codaDimension1__c  WHERE Name = '#{$sf_param_substitute}'"
		_dim2_query = "SELECT ID, Name from #{ORG_PREFIX}codaDimension2__c  WHERE Name = '#{$sf_param_substitute}'"
		_dim3_query = "SELECT ID, Name from #{ORG_PREFIX}codaDimension3__c  WHERE Name = '#{$sf_param_substitute}'"
		_dim4_query = "SELECT ID, Name from #{ORG_PREFIX}codaDimension4__c  WHERE Name = '#{$sf_param_substitute}'"
		_com_query = "SELECT ID, Name from #{ORG_PREFIX}codaCompany__c  WHERE Name = '#{$sf_param_substitute}'"
		
		APEX.execute_soql _com_query.gsub($sf_param_substitute,$company_merlin_auto_usa)
		_company_merlin_auto_usa = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _com_query.gsub($sf_param_substitute,$company_merlin_auto_spain)
		_company_merlin_auto_spain = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _com_query.gsub($sf_param_substitute,$company_merlin_auto_gb)
		_company_merlin_auto_gb = APEX.get_field_value_from_soql_result "Id"
		
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_postage_and_stationery)
		_bd_gla_postage_and_stationery = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_account_receivable_control_usd)
		_bd_gla_account_receivable_control_usd = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_account_receivable_control_eur)
		_bd_gla_account_receivable_control_eur = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_bank_account_euros_us)
		_bd_gla_bank_account_euros_us = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_bank_charge_us)
		_bd_gla_bank_charge_us = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_champage)
		_bd_gla_champage = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_apextaxgla001)
		_bd_gla_apextaxgla001 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _gla_query.gsub($sf_param_substitute,$bd_gla_bank_charge_gb)
		_bd_gla_bank_charge_gb = APEX.get_field_value_from_soql_result "Id"
		
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_apex_eur_001)
		_bd_apex_eur_001 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_apex_jpy_001)
		_bd_apex_jpy_001 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_apex_usd_001)
		_bd_apex_usd_001 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_dim1_new_york)
		_bd_dim1_new_york = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_dim1_european)
		_bd_dim1_european = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_dimension_queensland)
		_bd_dimension_queensland = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_dim1_eur)
		_bd_dim1_eur = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_dim1_gbp)
		_bd_dim1_gbp = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim1_query.gsub($sf_param_substitute,$bd_dim1_usd)
		_bd_dim1_usd = APEX.get_field_value_from_soql_result "Id"
		
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_apex_eur_002)
		_bd_apex_eur_002 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_apex_usd_002)
		_bd_apex_usd_002 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_chrysler_uk)
		_bd_chrysler_uk = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_chrysler_us)
		_bd_chrysler_us = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_classic_blonde_beer)
		_bd_classic_blonde_beer = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_dim2_jpy)
		_bd_dim2_jpy = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_dim2_eur)
		_bd_dim2_eur = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_wizard_smith_beer)
		_bd_wizard_smith_beer = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim2_query.gsub($sf_param_substitute,$bd_dim2_usd)
		_bd_dim2_usd = APEX.get_field_value_from_soql_result "Id"
		
		APEX.execute_soql _dim3_query.gsub($sf_param_substitute,$bd_apex_eur_003)
		_bd_apex_eur_003 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim3_query.gsub($sf_param_substitute,$bd_apex_usd_003)
		_bd_apex_usd_003 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim3_query.gsub($sf_param_substitute,$bd_sales_aud)
		_bd_sales_aud = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim3_query.gsub($sf_param_substitute,$bd_billy_ray)
		_bd_billy_ray = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim3_query.gsub($sf_param_substitute,$bd_sales_eur)
		_bd_sales_eur = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim3_query.gsub($sf_param_substitute,$bd_dim3_eur)
		_bd_dim3_eur = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim3_query.gsub($sf_param_substitute,$bd_dim3_usd)
		_bd_dim3_usd = APEX.get_field_value_from_soql_result "Id"
		
		
		APEX.execute_soql _dim4_query.gsub($sf_param_substitute,$bd_apex_eur_004)
		_bd_apex_eur_004 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim4_query.gsub($sf_param_substitute,$bd_apex_usd_004)
		_bd_apex_usd_004 = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim4_query.gsub($sf_param_substitute,$bd_brisbane)
		_bd_brisbane = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim4_query.gsub($sf_param_substitute,$bd_dim4_eur)
		_bd_dim4_eur = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim4_query.gsub($sf_param_substitute,$bd_harrogate)
		_bd_harrogate = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim4_query.gsub($sf_param_substitute,$bd_manchester_nh)
		_bd_manchester_nh = APEX.get_field_value_from_soql_result "Id"
		APEX.execute_soql _dim4_query.gsub($sf_param_substitute,$bd_dim4_usd)
		_bd_dim4_usd = APEX.get_field_value_from_soql_result "Id"
	end	
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
			_create_pinv1 += "inv.AccountInvoiceNumber = 'TID021512_001';"
			_create_pinv1 += "inv.InvoiceStatus = #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.enumInvoiceStatus.InProgress;"
			
			_create_pinv1 += "inv.LineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();"
			_create_pinv1 += "inv.LineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();"
						
			_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem prodLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			_create_pinv1 += "prodLine1.Product = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			_create_pinv1 += "prodLine1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_create_pinv1 += "prodLine1.Dimension3 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim3_eur}');"
			_create_pinv1 += "prodLine1.Quantity = 1.00;"
			_create_pinv1 += "prodLine1.UnitPrice = 74.5;"
			_create_pinv1 += "inv.LineItems.LineItemList.add(prodLine1);"
			
			_create_pinv1 += "#{_namspace_prefix}CODAAPICommon_9_0.Context context = new #{_namspace_prefix}CODAAPICommon_9_0.Context();"
			_create_pinv1 += "context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1', Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));"
			
			_create_pinv1 += "Id dto2Id = #{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, inv).Id;"
			_create_pinv1 += "#{_namspace_prefix}CODAAPICommon.Reference purchaseInvoiceIds = #{_namspace_prefix}CODAAPICommon.getRef(dto2Id, null);"
			_create_pinv1 += "#{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(context, purchaseInvoiceIds );"
			
			APEX.execute_script _create_pinv1
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful creation of PINV."
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa], true
			
			_create_pinv2 = ""
			_create_pinv2 += "Id bmwAccId;"
			_create_pinv2 += "for(Account acc : [select Name from Account]) {"
			_create_pinv2 += "if(acc.Name == '#{$bd_account_bmw_automobiles}')"
			_create_pinv2 += "{bmwAccId = acc.Id;break;}}"
			_create_pinv2 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice inv = new #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();"
			_create_pinv2 += "inv.Account = #{_namspace_prefix}CODAAPICommon.getRef(bmwAccId, '#{$bd_account_audi}');"
			_create_pinv2 += "inv.InvoiceDate = system.today();"
			_create_pinv2 += "inv.Period = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{CURRENT_PERIOD}');"
			_create_pinv2 += "inv.AccountInvoiceNumber = 'TID021512_002';"
			_create_pinv2 += "inv.InvoiceStatus = #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.enumInvoiceStatus.InProgress;"
			
			_create_pinv2 += "inv.LineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();"
			_create_pinv2 += "inv.LineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();"
						
			_create_pinv2 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem prodLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			_create_pinv2 += "prodLine1.Product = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			_create_pinv2 += "prodLine1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_create_pinv2 += "prodLine1.Dimension3 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim3_eur}');"
			_create_pinv2 += "prodLine1.Quantity = 1.00;"
			_create_pinv2 += "prodLine1.UnitPrice = 120.00;"
			_create_pinv2 += "prodLine1.InputVATCode = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_tax_code_vo_std_sales}');"
			_create_pinv2 += "inv.LineItems.LineItemList.add(prodLine1);"
			
			_create_pinv2 += "#{_namspace_prefix}CODAAPICommon_9_0.Context context = new #{_namspace_prefix}CODAAPICommon_9_0.Context();"
			_create_pinv2 += "context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1', Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));"
			
			_create_pinv2 += "Id dto2Id = #{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, inv).Id;"
			_create_pinv2 += "#{_namspace_prefix}CODAAPICommon.Reference purchaseInvoiceIds = #{_namspace_prefix}CODAAPICommon.getRef(dto2Id, null);"
			_create_pinv2 += "#{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(context, purchaseInvoiceIds );"
			
			APEX.execute_script _create_pinv2
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful creation of PINV."
			
			_create_rules ="#{ORG_PREFIX}AllocationRule__c alloc = new #{ORG_PREFIX}AllocationRule__c(#{ORG_PREFIX}Type__c= '#{$allocationrules_type_fixed_label}', Name = '#{_rule_name}', #{ORG_PREFIX}Description__c = 'Active allocation rule');"
			_create_rules += "insert alloc;"
			_create_rules += "alloc = [select Id, Name, #{ORG_PREFIX}Active__c from #{ORG_PREFIX}AllocationRule__c where Name = '#{_rule_name}' limit 1];"
			
			_create_rules += "list<#{ORG_PREFIX}FixedAllocationRuleLine__c> allocLines = new list<#{ORG_PREFIX}FixedAllocationRuleLine__c>();"
			
			_create_rules += "allocLines.add(new #{ORG_PREFIX}FixedAllocationRuleLine__c(#{ORG_PREFIX}AllocationRule__c = alloc.Id, #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_account_receivable_control_usd}', #{ORG_PREFIX}Split__c = 20.0000, #{ORG_PREFIX}Dimension1__c = '#{_bd_dim1_usd}', #{ORG_PREFIX}Dimension2__c = '#{_bd_dim2_usd}', #{ORG_PREFIX}Dimension3__c = '#{_bd_dim3_usd}', #{ORG_PREFIX}Dimension4__c = '#{_bd_dim4_usd}'));"
			
			_create_rules += "allocLines.add(new #{ORG_PREFIX}FixedAllocationRuleLine__c(#{ORG_PREFIX}AllocationRule__c = alloc.Id, #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_account_receivable_control_eur}', #{ORG_PREFIX}Split__c = 30.0000, #{ORG_PREFIX}Dimension1__c = '#{_bd_apex_eur_001}'));"
			
			_create_rules += "allocLines.add(new #{ORG_PREFIX}FixedAllocationRuleLine__c(#{ORG_PREFIX}AllocationRule__c = alloc.Id, #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_apextaxgla001}', #{ORG_PREFIX}Split__c = 40.0000, #{ORG_PREFIX}Dimension2__c = '#{_bd_apex_eur_002}'));"
			
			_create_rules += "allocLines.add(new #{ORG_PREFIX}FixedAllocationRuleLine__c(#{ORG_PREFIX}AllocationRule__c = alloc.Id, #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_bank_account_euros_us}', #{ORG_PREFIX}Split__c = 10.0000, #{ORG_PREFIX}Dimension3__c = '#{_bd_apex_eur_003}'));"
			
			_create_rules += "insert allocLines;"
			_create_rules += "alloc = [select Id, Name, #{ORG_PREFIX}Active__c from #{ORG_PREFIX}AllocationRule__c where Name = '#{_rule_name}' limit 1];"
			_create_rules += "alloc.#{ORG_PREFIX}Active__c = true;"
			_create_rules += "update alloc;"
			APEX.execute_script _create_rules
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful creation of fixed allocation rule."
			
			gen_report_test "Creating Basis."
			
			_create_basis = "#{ORG_PREFIX}StatisticalBasis__c basis = new #{ORG_PREFIX}StatisticalBasis__c(Name = '#{_basis_name}', #{ORG_PREFIX}Date__c = system.today(), #{ORG_PREFIX}UnitOfMeasure__c = '#{$sb_uom_picklist_people_label}');"
			_create_basis += "insert basis;"
			_create_basis += "list<#{ORG_PREFIX}StatisticalBasisLineItem__c> basisLines = new list<#{ORG_PREFIX}StatisticalBasisLineItem__c>();"
			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_spain}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_postage_and_stationery}', #{ORG_PREFIX}Dimension1__c = '#{_bd_apex_eur_001}', #{ORG_PREFIX}Dimension2__c = '#{_bd_apex_eur_002}', #{ORG_PREFIX}Dimension3__c = '#{_bd_apex_eur_003}', #{ORG_PREFIX}Dimension4__c = '#{_bd_apex_eur_004}', #{ORG_PREFIX}Value__c = 560));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_usa}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_bank_charge_us}', #{ORG_PREFIX}Dimension1__c = '#{_bd_apex_jpy_001}', #{ORG_PREFIX}Dimension2__c = '#{_bd_apex_usd_002}', #{ORG_PREFIX}Dimension3__c = '#{_bd_apex_usd_003}', #{ORG_PREFIX}Dimension4__c = '#{_bd_apex_usd_004}', #{ORG_PREFIX}Value__c = 570));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_spain}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_champage}', #{ORG_PREFIX}Dimension1__c = '#{_bd_apex_usd_001}', #{ORG_PREFIX}Dimension2__c = '#{_bd_chrysler_uk}', #{ORG_PREFIX}Dimension3__c = '#{_bd_billy_ray}', #{ORG_PREFIX}Dimension4__c = '#{_bd_brisbane}', #{ORG_PREFIX}Value__c = 580));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_spain}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_champage}', #{ORG_PREFIX}Dimension1__c = '#{_bd_dim1_eur}', #{ORG_PREFIX}Dimension2__c = '#{_bd_chrysler_us}', #{ORG_PREFIX}Dimension3__c = '#{_bd_billy_ray}', #{ORG_PREFIX}Dimension4__c = '#{_bd_dim4_eur}', #{ORG_PREFIX}Value__c = 590));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_usa}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_champage}', #{ORG_PREFIX}Dimension1__c = '#{_bd_dim1_gbp}', #{ORG_PREFIX}Dimension2__c = '#{_bd_classic_blonde_beer}', #{ORG_PREFIX}Dimension3__c = '#{_bd_dim3_eur}', #{ORG_PREFIX}Dimension4__c = '#{_bd_dim4_eur}', #{ORG_PREFIX}Value__c = 600));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_gb}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_apextaxgla001}', #{ORG_PREFIX}Dimension1__c = '#{_bd_dim1_european}', #{ORG_PREFIX}Dimension2__c = '#{_bd_dim2_eur}', #{ORG_PREFIX}Dimension3__c = '#{_bd_sales_aud}', #{ORG_PREFIX}Dimension4__c = '#{_bd_harrogate}', #{ORG_PREFIX}Value__c = 900));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_spain}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_bank_charge_gb}', #{ORG_PREFIX}Dimension1__c = '#{_bd_dim1_new_york}', #{ORG_PREFIX}Dimension2__c = '#{_bd_dim2_jpy}', #{ORG_PREFIX}Dimension3__c = '#{_bd_sales_eur}', #{ORG_PREFIX}Dimension4__c = '#{_bd_manchester_nh}', #{ORG_PREFIX}Value__c = 700));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  '#{_company_merlin_auto_spain}', #{ORG_PREFIX}GeneralLedgerAccount__c = '#{_bd_gla_bank_charge_gb}', #{ORG_PREFIX}Dimension1__c = '#{_bd_dimension_queensland}', #{ORG_PREFIX}Dimension2__c = '#{_bd_wizard_smith_beer}', #{ORG_PREFIX}Dimension3__c = '#{_bd_billy_ray}', #{ORG_PREFIX}Dimension4__c = '#{_bd_manchester_nh}', #{ORG_PREFIX}Value__c = 1.670));"

			_create_basis += "insert basisLines;"
			APEX.execute_script _create_basis
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
			
			gen_report_test "Creating variable allocation rule"
			_create_rules = "#{ORG_PREFIX}StatisticalBasis__c basis = [select id from #{ORG_PREFIX}StatisticalBasis__c where Name = '#{_basis_name}'];"
			_create_rules +="#{ORG_PREFIX}AllocationRule__c alloc = new #{ORG_PREFIX}AllocationRule__c(#{ORG_PREFIX}Type__c= '#{$allocationrules_type_variable_label}', Name = '#{_variable_rule_name}', #{ORG_PREFIX}Description__c = 'With Filters added', #{ORG_PREFIX}Active__c = true, #{ORG_PREFIX}StatisticalBasis__c = basis.Id, #{ORG_PREFIX}DistributionFields__c = '#{$allocationrules_gla_label};#{$allocationrules_dim1_label};#{$allocationrules_dim2_label};#{$allocationrules_dim3_label};#{$allocationrules_dim4_label}');"
			_create_rules += "insert alloc;"
			
			APEX.execute_script _create_rules
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- Successful creation of variable Allocation rule."
		end
		
		begin
			gen_start_test "TST037818 : Verify the progress bar flow when Method of Allocation is 'Fixed' in single company mode."
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain], true
			
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Retrieve Source is currently selected step."
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_allocation_method), "Allocation Method is currently inactive step."
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_distribute), "Distribute is currently inactive step."
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Post is currently inactive step."
			gen_assert_hidden $alloc_wizard_configure_basis
			Allocations.set_allocation_type $alloc_type_label
			
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} not visible in preview panel section."
			
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Retrieve Source is completed step."
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_allocation_method), "Allocation Method is currently selected step."
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_distribute), "Distribute is currently inactive step."
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Post is currently inactive step."
			gen_assert_hidden $alloc_wizard_configure_basis
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_fixed, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} not visible in preview panel section."
			
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Retrieve Source is completed step."
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Allocation Method is currently completed step."
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Distribut is currently selected step."
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Post is currently Inactive step."
			gen_assert_hidden $alloc_wizard_configure_basis
			Allocations.set_rule_name _rule_name
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step."
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step."
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step."
			gen_assert_hidden $alloc_wizard_configure_basis
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_fixed, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} visible in preview panel section."
			
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Selected step."
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			gen_assert_hidden $alloc_wizard_configure_basis
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_fixed, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} visible in preview panel section."
			
			Allocations.click_wizard_step $alloc_wizard_distribute
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			gen_assert_hidden $alloc_wizard_configure_basis
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_fixed, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} visible in preview panel section."
			
			gen_end_test "TST037818 : Verify the progress bar flow when Method of Allocation is 'Fixed' in single company mode."
		end
		begin
			_row1_TST037957 = "#{$bd_dim1_gbp} 600 40"
			_row2_TST037957 = "#{$bd_dim1_european} 900 60"
			_row3_TST037957 = "#{$bd_dim1_european} #{$bd_dim2_eur} 900 100"
			_row4_TST037957 = "#{$bd_dim1_gbp} 600 100"
			_row5_TST037957 = "#{$bd_dim1_gbp} #{$bd_classic_blonde_beer} 600 40"
			_row6_TST037957 = "#{$bd_dim1_european} #{$bd_dim2_eur} 900 60"
			_row7_TST037957 = "#{$bd_gla_champage} #{$bd_dim1_gbp} #{$bd_classic_blonde_beer} #{$bd_dim3_eur} #{$bd_dim4_eur} 600 40"
			_row8_TST037957 = "#{$bd_gla_apextaxgla001} #{$bd_dim1_european} #{$bd_dim2_eur} #{$bd_sales_aud} #{$bd_harrogate} 900 60"
			_row9_TST037957 = "#{$bd_gla_champage} #{$bd_dim1_gbp} #{$bd_classic_blonde_beer} #{$bd_dim3_eur} #{$bd_dim4_eur} 600 100"
			
			gen_start_test "TST037957 : Verify the progress bar flow when Method of Allocation is 'Variable' in single company mode"
			# Keeping continue from last begin block Go back to Allocation Method screen and select Variable. 
			# Currently user is in fixed allocation mode and on Distribute screen.
			Allocations.click_on_back_button
			# Select Allocation Method - Variable --> Statistical and click on Next button.
			Allocations.select_variable_allocation_method_button
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_variable, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} visible in preview panel section."
			
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_configure_basis), "Selected step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_distribute), "Inactive step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Inactive step"
			
			# Select Basis
			Allocations.select_statistical_bases _basis_name
			Allocations.select_distribution_fields [$alloc_dim1_label]
			
			# Setting filters
			Allocations.click_show_filter_button
			Allocations.click_add_filter_button
			Allocations.set_filter_values $allocationrules_dim1_label,$allocationrules_filter_operator_contains_label,'GBP'
			Allocations.click_add_filter_button
			Allocations.set_filter_values $allocationrules_dim1_label,$allocationrules_filter_operator_equals_label,$bd_dim1_european,2
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare _row1_TST037957, Allocations.get_allocation_rule_grid_row(1) ,"TST037957 Expected row 1 on Statistical Configuration grid"
			gen_compare _row2_TST037957, Allocations.get_allocation_rule_grid_row(2) ,"TST037957 Expected row 2 on Statistical Configuration grid"
			
			# Setting another distribution field 
			Allocations.select_distribution_fields [$alloc_dim2_label]
			
			# Select another filter
			Allocations.click_show_filter_button
			Allocations.click_add_filter_button
			Allocations.set_filter_values $allocationrules_dim2_label,$allocationrules_filter_operator_equals_label,$bd_dim2_eur,3
			gen_compare Allocations.get_displayed_filter_count, (Allocations.get_filter_count).to_s ,"Filter Count displayed is equal to the total filter applied"
			gen_compare "3", Allocations.get_displayed_filter_count ,"Filter Count displayed is equal to 3"
			Allocations.click_statistical_basis_configuration_page_preview_button
			
			# Compare grid row
			gen_compare _row3_TST037957, Allocations.get_allocation_rule_grid_row(1) ,"TST037957 Expected row 1 on Statistical Configuration grid"
			
			# Now delete the thrid filter and verify the grid again
			Allocations.click_show_filter_button
			Allocations.click_delete_filter_icon 3
			gen_compare Allocations.get_displayed_filter_count, (Allocations.get_filter_count).to_s ,"Filter Count displayed is equal to the total filter applied"
			gen_compare "2", Allocations.get_displayed_filter_count ,"Filter Count displayed is equal to 2"
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare _row5_TST037957, Allocations.get_allocation_rule_grid_row(1) ,"TST037957 Expected row 1 on Statistical Configuration grid"
			gen_compare _row6_TST037957, Allocations.get_allocation_rule_grid_row(2) ,"TST037957 Expected row 2 on Statistical Configuration grid"
			
			# Now change select the variable allocation rule and verify the filter funcationality again
			Allocations.select_variable_rule_name _variable_rule_name
			
			# Assert no filters are applied right now
			gen_compare "0", Allocations.get_displayed_filter_count ,"Filter Count displayed is equal to 0"
			
			# Select some filters and verify the grid
			Allocations.click_show_filter_button
			Allocations.click_add_filter_button
			Allocations.set_filter_values $allocationrules_dim1_label,$allocationrules_filter_operator_contains_label,'GBP'
			Allocations.click_add_filter_button
			Allocations.set_filter_values $allocationrules_dim1_label,$allocationrules_filter_operator_equals_label,$bd_dim1_european,2
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare _row7_TST037957, Allocations.get_allocation_rule_grid_row(1) ,"TST037957 Expected row 1 on Statistical Configuration grid"
			gen_compare _row8_TST037957, Allocations.get_allocation_rule_grid_row(2) ,"TST037957 Expected row 2 on Statistical Configuration grid"
			
			# Now delete the second filter and verify the grid again
			Allocations.click_show_filter_button
			Allocations.click_delete_filter_icon 2
			gen_compare Allocations.get_displayed_filter_count, (Allocations.get_filter_count).to_s ,"Filter Count displayed is equal to the total filter applied"
			gen_compare "1", Allocations.get_displayed_filter_count ,"Filter Count displayed is equal to 1"
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare _row9_TST037957, Allocations.get_allocation_rule_grid_row(1) ,"TST037957 Expected row 1 on Statistical Configuration grid"
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_variable, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label}visible in preview panel section."
			gen_compare _basis_name, Allocations.get_preview_panel_section_value($alloc_preview_panel_statistical_value_label),"#{$alloc_preview_panel_statistical_value_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} visible in preview panel section."
			
			Allocations.click_on_next_button
			_warning_message_screen3 = "You have edited the selected allocation rule, but have not saved your changes. Click Yes to update the rule. Click No to use the edited rule details for this allocation only and leave the original allocation rule unchanged."
			gen_compare _warning_message_screen3, FFA.get_sencha_popup_warning_message, "Warning message matched"
			FFA.sencha_popup_click_cancel
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Inactive step"
			
			Allocations.set_glas_in_distribute_to_gla_picklist [$bd_gla_accounts_payable_control_eur, $bd_gla_postage_and_stationery]
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_variable, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label}visible in preview panel section."
			gen_compare _basis_name, Allocations.get_preview_panel_section_value($alloc_preview_panel_statistical_value_label),"#{$alloc_preview_panel_statistical_value_label} value matched"
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare $alloc_multiple_glas_label, Allocations.get_preview_panel_section_value($alloc_preview_panel_distribute_to_glas_label),"#{$alloc_preview_panel_distribute_to_glas_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} visible in preview panel section."
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} visible in preview panel section."
			
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step"
			
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_allocation_method_label), "#{$alloc_preview_panel_allocation_method_label} visible in preview panel section."
			gen_compare _allocation_method_value_variable, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_statistical_value_label), "#{$alloc_preview_panel_statistical_value_label}visible in preview panel section."
			gen_compare _basis_name, Allocations.get_preview_panel_section_value($alloc_preview_panel_statistical_value_label),"#{$alloc_preview_panel_statistical_value_label} value matched"
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_distribute_to_glas_label), "#{$alloc_preview_panel_distribute_to_glas_label} not visible in preview panel section."
			gen_compare $alloc_multiple_glas_label, Allocations.get_preview_panel_section_value($alloc_preview_panel_distribute_to_glas_label),"#{$alloc_preview_panel_distribute_to_glas_label} value matched"
			gen_compare false, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_company_label), "#{$alloc_preview_panel_company_label} not visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_date_label), "#{$alloc_preview_panel_date_label} visible in preview panel section."
			gen_compare true, Allocations.is_preview_panel_section_displayed?($alloc_preview_panel_period_label), "#{$alloc_preview_panel_period_label} visible in preview panel section."
			
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Selected step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_distribute
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			Allocations.set_glas_in_distribute_to_gla_picklist [$bd_gla_accounts_payable_control_usd]
			
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step"
			
			Allocations.click_wizard_step $alloc_wizard_retrieve_source
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Selected step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_allocation_method
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_allocation_method), "Selected step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_configure_basis), "Selected step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_distribute
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_post
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step"
			
			gen_end_test "TST037957 : Verify the progress bar flow when Method of Allocation is 'Variable' in single company mode"
		end
		
		begin
			gen_start_test "TST037819: Verify the progress bar flow when Method of Allocation is 'Fixed' in multi company mode"
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa, $company_merlin_auto_spain], true
			
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Selected step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_allocation_method), "Inactive step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_distribute), "Inactive step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Inactive step"
			gen_assert_hidden $alloc_wizard_configure_basis
			
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_filterset_field_value 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.click_on_add_filter_group_button
			#filter 2
			Allocations.set_filterset_field_value 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_usa
			Allocations.set_filterset_field_value 2,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_audi
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field_value 2,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_allocation_method), "Selected step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_distribute), "Inactive step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Inactive step"
			gen_assert_hidden $alloc_wizard_configure_basis
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Inactive step"
			gen_assert_hidden $alloc_wizard_configure_basis
			Allocations.set_rule_name _rule_name
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step"
			gen_assert_hidden $alloc_wizard_configure_basis
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Selected step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			gen_assert_hidden $alloc_wizard_configure_basis
			
			Allocations.click_wizard_step $alloc_wizard_distribute
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			gen_assert_hidden $alloc_wizard_configure_basis
			gen_end_test "TST037819: Verify the progress bar flow when Method of Allocation is 'Fixed' in multi company mode"
		end
		begin
			gen_start_test "TST037958 : Verify the progress bar flow when Method of Allocation is 'Variable' in multi company mode."
			# Keeping continue from last begin block Go back to Allocation Method screen and select Variable. 
			# Currently user is in fixed allocation mode and on Distribute screen.
			Allocations.click_on_back_button
			# Select Allocation Method - Variable --> Statistical and click on Next button.
			Allocations.select_variable_allocation_method_button
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_configure_basis), "Selected step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_distribute), "Inactive step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Inactive step"
			
			Allocations.select_variable_rule_name _variable_rule_name
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_inactive_wizard_step?($alloc_wizard_post), "Inactive step"
			
			Allocations.set_glas_in_distribute_to_gla_picklist [$bd_gla_accounts_payable_control_eur, $bd_gla_postage_and_stationery]
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step"
			
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			Allocations.click_on_back_button
			
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Selected step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_distribute
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			Allocations.set_glas_in_distribute_to_gla_picklist [$bd_gla_accounts_payable_control_usd]
			
			Allocations.click_on_next_button
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step"
			
			Allocations.click_wizard_step $alloc_wizard_retrieve_source
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_retrieve_source), "Selected step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_allocation_method
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_allocation_method), "Selected step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_configure_basis), "Selected step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_distribute
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_distribute), "Selected step"
			gen_compare true, Allocations.is_partial_complete_wizard_step?($alloc_wizard_post), "Partially Completed step"
			
			Allocations.click_wizard_step $alloc_wizard_post
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_retrieve_source), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_allocation_method), "Completed step"
			gen_assert_displayed $alloc_wizard_configure_basis
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_configure_basis), "Completed step"
			gen_compare true, Allocations.is_complete_wizard_step?($alloc_wizard_distribute), "Completed step"
			gen_compare true, Allocations.is_selected_wizard_step?($alloc_wizard_post), "Selected step"
			
			gen_end_test "TST037958 : Verify the progress bar flow when Method of Allocation is 'Variable' in multi company mode."
		end
	end

	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID021512: Verify the progress bar along when Fixed type of allocation is selected for Posting allocation."
	end
end
		