#--------------------------------------------------------------------#
#	TID : TID021393
#	Pre-Requisite: Org with basedata deployed.
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocation_statistical_distribution_TID021393.rb -fh -o TID021393.html
#   Compatible with - Managed org.
#--------------------------------------------------------------------#
describe "TID021393 - statistical allocation distribution through manual GLA allocation with different distribution fields combinations.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		gen_start_test "TID021393: Verify the statistical allocation distribution through manual GLA allocation with different distribution fields combinations."
		FFA.hold_base_data_and_wait
	end
	
	it "verifies the statistical allocation distribution through manual GLA allocation with different distribution fields combinations." do
		_statistical_config_grid_total_value = "4,501.67"
		_statistical_distribution_grid_total_value = "200"
		_total_percentage = "100"
		_post_screen_description = "TID021393 Description"
		_gmt_offset = gen_get_current_user_gmt_offset
		_locale = gen_get_current_user_locale
		_today = gen_get_current_date _gmt_offset
		_today_date = gen_locale_format_date _today, _locale
		_5daysfromtoday = gen_locale_format_date (Time.now + 60*60*24*5).gmtime.getlocal(_gmt_offset).to_date, _locale
		PREVIOUS_PERIOD1 = FFA.get_period_by_date Date.today<<1
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain], true
		
		_rows_TST037334 = ["#{$bd_apex_eur_001} 560 12.4398", "#{$bd_dim1_usd} 570 12.662", "#{$bd_apex_usd_001} 580 12.8841", "#{$bd_dim1_eur} 590 13.1062", "#{$bd_dim1_gbp} 600 13.3284", "#{$bd_dim1_european} 900 19.9926", "#{$bd_dim1_new_york} 700 15.5498", "#{$bd_dim1_south} 1.67 0.0371"]
		
		_rows_TST037335 = ["#{$bd_apex_usd_001} #{$bd_dim4_gbp} 580 12.8841", "#{$bd_dim1_eur} #{$bd_dim4_eur} 590 13.1062", "#{$bd_dim1_gbp} #{$bd_dim4_eur} 600 13.3284", "#{$bd_dim1_european} #{$bd_harrogate} 900 19.9926", "#{$bd_dim1_new_york} #{$bd_manchester_nh} 700 15.5498", "#{$bd_apex_eur_001} #{$bd_apex_eur_004} 560 12.4398", "#{$bd_dim1_usd} #{$bd_apex_usd_004} 570 12.662", "#{$bd_dim1_south} #{$bd_manchester_nh} 1.67 0.0371"]
		
		_rows_TST037336 = ["#{$bd_gla_champage} #{$bd_chrysler_uk} 580 12.8841", "#{$bd_gla_champage} #{$bd_chrysler_us} 590 13.1062", "#{$bd_gla_champage} #{$bd_dim2_ford_uk} 600 13.3284", "#{$bd_gla_apextaxgla001} #{$bd_dim2_eur} 900 19.9926", "#{$bd_gla_bank_charge_gb} #{$bd_dim2_usd} 700 15.5498", "#{$bd_gla_postage_and_stationery} #{$bd_apex_eur_002} 560 12.4398", "#{$bd_gla_bank_charge_us} #{$bd_apex_usd_002} 570 12.662", "#{$bd_gla_bank_charge_gb} #{$bd_wizard_smith_beer} 1.67 0.0371"]
		
		_rows_TST037787 = ["#{$bd_apex_usd_001} #{$bd_chrysler_uk} #{$bd_billy_ray} #{$bd_dim4_gbp} 580 12.8841", "#{$bd_dim1_eur} #{$bd_chrysler_us} #{$bd_billy_ray} #{$bd_dim4_eur} 590 13.1062", "#{$bd_dim1_gbp} #{$bd_dim2_ford_uk} #{$bd_dim3_eur} #{$bd_dim4_eur} 600 13.3284", "#{$bd_dim1_european} #{$bd_dim2_eur} #{$bd_sales_gbp} #{$bd_harrogate} 900 19.9926", "#{$bd_dim1_new_york} #{$bd_dim2_usd} #{$bd_sales_eur} #{$bd_manchester_nh} 700 15.5498", "#{$bd_apex_eur_001} #{$bd_apex_eur_002} #{$bd_apex_eur_003} #{$bd_apex_eur_004} 560 12.4398", "#{$bd_dim1_usd} #{$bd_apex_usd_002} #{$bd_apex_usd_003} #{$bd_apex_usd_004} 570 12.662", "#{$bd_dim1_south} #{$bd_wizard_smith_beer} #{$bd_billy_ray} #{$bd_manchester_nh} 1.67 0.0371"]
		
		_rows_TST037788 = ["#{$bd_gla_champage} 580 12.8841", "#{$bd_gla_champage} 590 13.1062", "#{$bd_gla_champage} 600 13.3284", "#{$bd_gla_apextaxgla001} 900 19.9926", "#{$bd_gla_bank_charge_gb} 700 15.5498", "#{$bd_gla_postage_and_stationery} 560 12.4398", "#{$bd_gla_bank_charge_us} 570 12.662", "#{$bd_gla_bank_charge_gb} 1.67 0.0371"]
		
		_distributed_rows_TST037334 = ["#{$bd_gla_account_payable_control_eur} #{$bd_apex_usd_001} 12.88 6.44", "#{$bd_gla_account_payable_control_eur} #{$bd_apex_eur_001} 12.44 6.22", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_south} 0.04 0.02", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_european} 19.99 9.99", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_new_york} 15.55 7.78", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_usd} 12.67 6.33", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_gbp} 13.32 6.66", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_eur} 13.11 6.55", "#{$bd_gla_postage_and_stationery} #{$bd_apex_usd_001} 12.88 6.44", "#{$bd_gla_postage_and_stationery} #{$bd_apex_eur_001} 12.44 6.22", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_south} 0.04 0.02", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_european} 19.99 9.99", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_new_york} 15.55 7.78", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_usd} 12.67 6.33", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_gbp} 13.32 6.66", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_eur} 13.11 6.55"]
		
		_distributed_rows_TST037335 = ["#{$bd_gla_account_payable_control_eur} #{$bd_apex_usd_001} #{$bd_dim4_gbp} 12.88 6.44", "#{$bd_gla_account_payable_control_eur} #{$bd_apex_eur_001} #{$bd_apex_eur_004} 12.44 6.22", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_south} #{$bd_manchester_nh} 0.04 0.02", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_european} #{$bd_harrogate} 19.99 9.99", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_new_york} #{$bd_manchester_nh} 15.55 7.78", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_usd} #{$bd_apex_usd_004} 12.67 6.33", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_gbp} #{$bd_dim4_eur} 13.32 6.66", "#{$bd_gla_account_payable_control_eur} #{$bd_dim1_eur} #{$bd_dim4_eur} 13.11 6.55", "#{$bd_gla_postage_and_stationery} #{$bd_apex_usd_001} #{$bd_dim4_gbp} 12.88 6.44", "#{$bd_gla_postage_and_stationery} #{$bd_apex_eur_001} #{$bd_apex_eur_004} 12.44 6.22", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_south} #{$bd_manchester_nh} 0.04 0.02", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_european} #{$bd_harrogate} 19.99 9.99", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_new_york} #{$bd_manchester_nh} 15.55 7.78", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_usd} #{$bd_apex_usd_004} 12.67 6.33", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_gbp} #{$bd_dim4_eur} 13.32 6.66", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_eur} #{$bd_dim4_eur} 13.11 6.55"]
		
		_distributed_rows_TST037336 = ["#{$bd_gla_account_payable_control_eur} #{$bd_apex_usd_002} 12.66 6.33", "#{$bd_gla_account_payable_control_eur} #{$bd_apex_eur_002} 12.44 6.22", "#{$bd_gla_account_payable_control_eur} #{$bd_dim2_ford_uk} 13.33 6.67", "#{$bd_gla_account_payable_control_eur} #{$bd_chrysler_uk} 12.88 6.44", "#{$bd_gla_account_payable_control_eur} #{$bd_chrysler_us} 13.11 6.55", "#{$bd_gla_account_payable_control_eur} #{$bd_wizard_smith_beer} 0.04 0.02", "#{$bd_gla_account_payable_control_eur} #{$bd_dim2_usd} 15.55 7.78", "#{$bd_gla_account_payable_control_eur} #{$bd_dim2_eur} 19.99 9.99", "#{$bd_gla_postage_and_stationery} #{$bd_apex_usd_002} 12.66 6.33", "#{$bd_gla_postage_and_stationery} #{$bd_apex_eur_002} 12.44 6.22", "#{$bd_gla_postage_and_stationery} #{$bd_dim2_ford_uk} 13.33 6.67", "#{$bd_gla_postage_and_stationery} #{$bd_chrysler_uk} 12.88 6.44", "#{$bd_gla_postage_and_stationery} #{$bd_chrysler_us} 13.11 6.55", "#{$bd_gla_postage_and_stationery} #{$bd_wizard_smith_beer} 0.04 0.02", "#{$bd_gla_postage_and_stationery} #{$bd_dim2_usd} 15.55 7.78", "#{$bd_gla_postage_and_stationery} #{$bd_dim2_eur} 19.99 9.99"]
		
		_distributed_rows_TST037785 = ["#{$bd_gla_postage_and_stationery} #{$bd_apex_usd_002} 25.32 12.66", "#{$bd_gla_postage_and_stationery} #{$bd_apex_eur_002} 24.88 12.44", "#{$bd_gla_postage_and_stationery} #{$bd_dim2_ford_uk} 26.66 13.33", "#{$bd_gla_postage_and_stationery} #{$bd_chrysler_uk} 25.77 12.88", "#{$bd_gla_postage_and_stationery} #{$bd_chrysler_us} 26.21 13.11", "#{$bd_gla_postage_and_stationery} #{$bd_wizard_smith_beer} 0.08 0.04", "#{$bd_gla_postage_and_stationery} #{$bd_dim2_usd} 31.09 15.54", "#{$bd_gla_postage_and_stationery} #{$bd_dim2_eur} 39.99 20"]
		
		_distributed_rows_TST037786 = ["#{$bd_gla_apextaxgla001} #{$bd_dim2_eur} 39.99 20", "#{$bd_gla_postage_and_stationery} #{$bd_apex_eur_002} 24.87 12.44", "#{$bd_gla_bank_charge_gb} #{$bd_wizard_smith_beer} 0.08 0.04", "#{$bd_gla_bank_charge_gb} #{$bd_dim2_usd} 31.1 15.55", "#{$bd_gla_bank_charge_us} #{$bd_apex_usd_002} 25.32 12.66", "#{$bd_gla_champage} #{$bd_dim2_ford_uk} 26.66 13.33", "#{$bd_gla_champage} #{$bd_chrysler_uk} 25.77 12.88", "#{$bd_gla_champage} #{$bd_chrysler_us} 26.21 13.11"]
		
		_distributed_rows_TST037787 = ["#{$bd_gla_postage_and_stationery} #{$bd_dim1_usd} #{$bd_apex_usd_002} #{$bd_apex_usd_003} #{$bd_apex_usd_004} 25.32 12.66", "#{$bd_gla_postage_and_stationery} #{$bd_apex_eur_001} #{$bd_apex_eur_002} #{$bd_apex_eur_003} #{$bd_apex_eur_004} 24.88 12.44", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_gbp} #{$bd_dim2_ford_uk} #{$bd_dim3_eur} #{$bd_dim4_eur} 26.66 13.33", "#{$bd_gla_postage_and_stationery} #{$bd_apex_usd_001} #{$bd_chrysler_uk} #{$bd_billy_ray} #{$bd_dim4_gbp} 25.77 12.88", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_eur} #{$bd_chrysler_us} #{$bd_billy_ray} #{$bd_dim4_eur} 26.21 13.11", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_south} #{$bd_wizard_smith_beer} #{$bd_billy_ray} #{$bd_manchester_nh} 0.08 0.04", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_new_york} #{$bd_dim2_usd} #{$bd_sales_eur} #{$bd_manchester_nh} 31.09 15.54", "#{$bd_gla_postage_and_stationery} #{$bd_dim1_european} #{$bd_dim2_eur} #{$bd_sales_gbp} #{$bd_harrogate} 39.99 20"]
		
		_distributed_rows_TST037788 = ["#{$bd_gla_apextaxgla001} 39.99 20", "#{$bd_gla_postage_and_stationery} 24.87 12.44", "#{$bd_gla_bank_charge_gb} 31.18 15.59", "#{$bd_gla_bank_charge_us} 25.32 12.66", "#{$bd_gla_champage} 78.64 39.32"]
		
		_basis_name = "TID021393Basis01"
		_namspace_prefix = ""
		_namspace_prefix += ORG_PREFIX
		
		if(_namspace_prefix != nil && _namspace_prefix != "" )
			_namspace_prefix = _namspace_prefix.gsub! "__", "."
		end	
		CURRENT_PERIOD = FFA.get_current_period
		
		begin
			gen_report_test "Creating data for Test"
			_create_basis = "#{ORG_PREFIX}StatisticalBasis__c basis = new #{ORG_PREFIX}StatisticalBasis__c(Name = '#{_basis_name}', #{ORG_PREFIX}Date__c = system.today(), #{ORG_PREFIX}UnitOfMeasure__c = '#{$sb_uom_picklist_people_label}');"
			_create_basis += "insert basis;"
			_create_basis += "map<string, string> idMap = new map<string, string>();"
			_create_basis += "set<String> companyNames = new set<String>();"
			_create_basis += "set<String> glaNames = new set<String>();"
			_create_basis += "set<String> dim1Names = new set<String>();"
			_create_basis += "set<String> dim2Names = new set<String>();"
			_create_basis += "set<String> dim3Names = new set<String>();"
			_create_basis += "set<String> dim4Names = new set<String>();"
			_create_basis += "companyNames.add('#{$company_merlin_auto_usa}');"
			_create_basis += "companyNames.add('#{$company_merlin_auto_spain}');"
			_create_basis += "companyNames.add('#{$company_merlin_auto_gb}');"
			_create_basis += "glaNames.add('#{$bd_gla_postage_and_stationery}');"
			_create_basis += "glaNames.add('#{$bd_gla_bank_charge_us}');"
			_create_basis += "glaNames.add('#{$bd_gla_champage}');"
			_create_basis += "glaNames.add('#{$bd_gla_apextaxgla001}');"
			_create_basis += "glaNames.add('#{$bd_gla_bank_charge_gb}');"
			_create_basis += "dim1Names.add('#{$bd_apex_eur_001}');"
			_create_basis += "dim1Names.add('#{$bd_dim1_usd}');"
			_create_basis += "dim1Names.add('#{$bd_apex_usd_001}');"
			_create_basis += "dim1Names.add('#{$bd_dim1_new_york}');"
			_create_basis += "dim1Names.add('#{$bd_dim1_european}');"
			_create_basis += "dim1Names.add('#{$bd_dim1_south}');"
			_create_basis += "dim1Names.add('#{$bd_dim1_eur}');"
			_create_basis += "dim1Names.add('#{$bd_dim1_gbp}');"
			_create_basis += "dim2Names.add('#{$bd_apex_eur_002}');"
			_create_basis += "dim2Names.add('#{$bd_apex_usd_002}');"
			_create_basis += "dim2Names.add('#{$bd_chrysler_uk}');"
			_create_basis += "dim2Names.add('#{$bd_chrysler_us}');"
			_create_basis += "dim2Names.add('#{$bd_dim2_ford_uk}');"
			_create_basis += "dim2Names.add('#{$bd_dim2_usd}');"
			_create_basis += "dim2Names.add('#{$bd_dim2_eur}');"
			_create_basis += "dim2Names.add('#{$bd_wizard_smith_beer}');"
			_create_basis += "dim3Names.add('#{$bd_apex_eur_003}');"
			_create_basis += "dim3Names.add('#{$bd_apex_usd_003}');"
			_create_basis += "dim3Names.add('#{$bd_sales_gbp}');"
			_create_basis += "dim3Names.add('#{$bd_billy_ray}');"
			_create_basis += "dim3Names.add('#{$bd_sales_eur}');"
			_create_basis += "dim3Names.add('#{$bd_dim3_eur}');"
			_create_basis += "dim4Names.add('#{$bd_apex_eur_004}');"
			_create_basis += "dim4Names.add('#{$bd_apex_usd_004}');"
			_create_basis += "dim4Names.add('#{$bd_dim4_gbp}');"
			_create_basis += "dim4Names.add('#{$bd_dim4_eur}');"
			_create_basis += "dim4Names.add('#{$bd_harrogate}');"
			_create_basis += "dim4Names.add('#{$bd_manchester_nh}');"
			_create_basis += "for(#{ORG_PREFIX}codaCompany__c record : [select Id, Name from #{ORG_PREFIX}codaCompany__c where Name in :companyNames]){"
			_create_basis += "idMap.put(record.Name, string.valueOf(record.Id));}"
			_create_basis += "for(#{ORG_PREFIX}codaGeneralLedgerAccount__c record : [select Id, Name from #{ORG_PREFIX}codaGeneralLedgerAccount__c where Name in :glaNames]){"
			_create_basis += "idMap.put(record.Name, string.valueOf(record.Id));}"
			_create_basis += "for(#{ORG_PREFIX}codaDimension1__c record : [select Id, Name from #{ORG_PREFIX}codaDimension1__c where Name in :dim1Names]){"
			_create_basis += "idMap.put(record.Name, string.valueOf(record.Id));}"
			_create_basis += "for(#{ORG_PREFIX}codaDimension2__c record : [select Id, Name from #{ORG_PREFIX}codaDimension2__c where Name in :dim2Names]){"
			_create_basis += "idMap.put(record.Name, string.valueOf(record.Id));}"
			_create_basis += "for(#{ORG_PREFIX}codaDimension3__c record : [select Id, Name from #{ORG_PREFIX}codaDimension3__c where Name in :dim3Names]){"
			_create_basis += "idMap.put(record.Name, string.valueOf(record.Id));}"
			_create_basis += "for(#{ORG_PREFIX}codaDimension4__c record : [select Id, Name from #{ORG_PREFIX}codaDimension4__c where Name in :dim4Names]){"
			_create_basis += "idMap.put(record.Name, string.valueOf(record.Id));}"
			_create_basis += "list<#{ORG_PREFIX}StatisticalBasisLineItem__c> basisLines = new list<#{ORG_PREFIX}StatisticalBasisLineItem__c>();"
			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_spain}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_postage_and_stationery}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_apex_eur_001}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_apex_eur_002}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_apex_eur_003}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_apex_eur_004}'), #{ORG_PREFIX}Value__c = 560));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_usa}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_bank_charge_us}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_dim1_usd}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_apex_usd_002}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_apex_usd_003}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_apex_usd_004}'), #{ORG_PREFIX}Value__c = 570));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_spain}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_champage}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_apex_usd_001}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_chrysler_uk}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_billy_ray}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_dim4_gbp}'), #{ORG_PREFIX}Value__c = 580));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_spain}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_champage}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_dim1_eur}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_chrysler_us}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_billy_ray}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_dim4_eur}'), #{ORG_PREFIX}Value__c = 590));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_usa}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_champage}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_dim1_gbp}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_dim2_ford_uk}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_dim3_eur}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_dim4_eur}'), #{ORG_PREFIX}Value__c = 600));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_gb}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_apextaxgla001}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_dim1_european}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_dim2_eur}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_sales_gbp}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_harrogate}'), #{ORG_PREFIX}Value__c = 900));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_spain}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_bank_charge_gb}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_dim1_new_york}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_dim2_usd}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_sales_eur}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_manchester_nh}'), #{ORG_PREFIX}Value__c = 700));"

			_create_basis += "basisLines.add(new #{ORG_PREFIX}StatisticalBasisLineItem__c(#{ORG_PREFIX}StatisticalBasis__c = basis.id, #{ORG_PREFIX}Company__c =  idMap.get('#{$company_merlin_auto_spain}'), #{ORG_PREFIX}GeneralLedgerAccount__c = idMap.get('#{$bd_gla_bank_charge_gb}'), #{ORG_PREFIX}Dimension1__c = idMap.get('#{$bd_dim1_south}'), #{ORG_PREFIX}Dimension2__c = idMap.get('#{$bd_wizard_smith_beer}'), #{ORG_PREFIX}Dimension3__c = idMap.get('#{$bd_billy_ray}'), #{ORG_PREFIX}Dimension4__c = idMap.get('#{$bd_manchester_nh}'), #{ORG_PREFIX}Value__c = 1.670));"

			_create_basis += "insert basisLines;"
			APEX.execute_script _create_basis
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
			
			_create_invoice1 = ""
			_create_invoice1 += "Id bmwAccId;"
			_create_invoice1 += "for(Account acc : [select Name from Account]) {"
			_create_invoice1 += "if(acc.Name == '#{$bd_account_bmw_automobiles}')"
			_create_invoice1 += "{bmwAccId = acc.Id;break;}}"
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice inv = new #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();"
			_create_invoice1 += "inv.Account = #{_namspace_prefix}CODAAPICommon.getRef(bmwAccId, '#{$bd_account_bmw_automobiles}');"
			_create_invoice1 += "inv.InvoiceDate = system.today();"
			_create_invoice1 += "inv.Period = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{CURRENT_PERIOD}');"
			_create_invoice1 += "inv.AccountInvoiceNumber = 'TID021393_001';"
			_create_invoice1 += "inv.InvoiceStatus = #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.enumInvoiceStatus.InProgress;"
			
			_create_invoice1 += "inv.ExpLineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItems();"
			_create_invoice1 += "inv.ExpLineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem>();"
						
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
			_create_invoice1 += "expLine1.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_gla_postage_and_stationery}');"
			_create_invoice1 += "expLine1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim1_usd}');"
			_create_invoice1 += "expLine1.Dimension2 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim2_usd}');"
			_create_invoice1 += "expLine1.Dimension3 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim3_usd}');"
			_create_invoice1 += "expLine1.Dimension4 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim4_usd}');"
			_create_invoice1 += "expLine1.NetValue = 200.00;"
			_create_invoice1 += "inv.ExpLineItems.LineItemList.add(expLine1);"
			
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine2 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
			_create_invoice1 += "expLine2.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_gla_account_receivable_control_usd}');"
			_create_invoice1 += "expLine2.NetValue = 400.00;"
			_create_invoice1 += "inv.ExpLineItems.LineItemList.add(expLine2);"
			
			_create_invoice1 += "#{_namspace_prefix}CODAAPICommon_9_0.Context context = new #{_namspace_prefix}CODAAPICommon_9_0.Context();"
			_create_invoice1 += "context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1', Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));"
			
			_create_invoice1 += "Id dto2Id = #{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, inv).Id;"
			_create_invoice1 += "#{_namspace_prefix}CODAAPICommon.Reference purchaseInvoiceIds = #{_namspace_prefix}CODAAPICommon.getRef(dto2Id, null);"
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(context, purchaseInvoiceIds );"
			
			APEX.execute_script _create_invoice1
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
		end	
		begin
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			#filter 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_postage_and_stationery
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension1_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim1_usd
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim2_usd
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension3_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim3_usd
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension4_field_object_label,$alloc_filter_set_multiselect_label,$bd_dim4_usd
			
			Allocations.click_on_next_button
			Allocations.select_variable_allocation_method_button
			Allocations.click_on_next_button
			gen_compare_has_content $alloc_sb_page_title_label, true, "Expected statistical basis configuration screen."
			# TST037334 - Verify the statistical allocation distribution through manual GLA allocation with only Dimension as distribution field criteria.
			gen_start_test "TST037334 - Verify the statistical allocation distribution through manual GLA allocation with only Dimension as distribution field criteria."
			Allocations.select_statistical_bases _basis_name
			Allocations.select_distribution_fields [$alloc_dim1_label]
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_config_grid_rows(_rows_TST037334), "TST037334 Expected rows on Statistical Configuration grid"
			gen_compare _total_percentage, Allocations.get_statistical_configuration_page_total_percentage, "Expected total percentage to be 100%"
			gen_compare _statistical_config_grid_total_value, Allocations.get_statistical_configuration_page_grid_total_value, "Expected total Value to be 4,501.67"
			
			Allocations.click_on_next_button
			gen_compare_has_content $alloc_label_statistical_distribution, true, "Expected statistical distribution screen."
			Allocations.set_glas_in_distribute_to_gla_picklist [$bd_gla_accounts_payable_control_eur, $bd_gla_postage_and_stationery]
			Allocations.click_statistical_distribution_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_distribution_grid_rows(_distributed_rows_TST037334), "TST037334 Expected rows on Statistical Distribution grid"
			gen_compare _total_percentage, Allocations.get_statistical_distribution_table_total_percentage, "TST037334 Expected total percentage to be 100%"
			gen_compare _statistical_distribution_grid_total_value, Allocations.get_statistical_distribution_table_total_amount, "TST037334 Expected total Value to be 200.00"
			
			gen_end_test "TST037334 - Verify the statistical allocation distribution through manual GLA allocation with only Dimension as distribution field criteria."
			
			# TST037335 Go back to Configuration screen and dimension 1 and dimension 4 distribution fields.
			gen_start_test "TST037335 - Go back to Configuration screen and dimension 1 and dimension 4 distribution fields."
			Allocations.click_on_back_button
			Allocations.select_distribution_fields [$alloc_dim4_label]
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_config_grid_rows(_rows_TST037335), "TST037335 Expected rows on Statistical Configuration grid"
			gen_compare _total_percentage, Allocations.get_statistical_configuration_page_total_percentage, "TST037335 Expected total percentage to be 100%"
			gen_compare _statistical_config_grid_total_value, Allocations.get_statistical_configuration_page_grid_total_value, "TST037335 Expected total Value to be 4,501.67"
			
			Allocations.click_on_next_button
			Allocations.click_statistical_distribution_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_distribution_grid_rows(_distributed_rows_TST037335), "TST037335 Expected rows on Statistical Distribution grid"
			gen_compare _total_percentage, Allocations.get_statistical_distribution_table_total_percentage, "TST037335 Expected total percentage to be 100%"
			gen_compare _statistical_distribution_grid_total_value, Allocations.get_statistical_distribution_table_total_amount, "TST037335 Expected total Value to be 200.00"
			
			gen_end_test "TST037335 - Go back to Configuration screen and dimension 1 and dimension 4 distribution fields."
			
			# TST037336 Go back to Configuration screen and select General Ledger Account and Dimension 2 distribution fields
			gen_start_test "TST037336 Go back to Configuration screen and select General Ledger Account and Dimension 2 distribution fields"
			Allocations.click_on_back_button
			Allocations.remove_distribution_field $alloc_dim4_label
			Allocations.remove_distribution_field $alloc_dim1_label
			Allocations.select_distribution_fields [$alloc_gla_label, $alloc_dim2_label]
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_config_grid_rows(_rows_TST037336), "TST037336 Expected rows on Statistical Configuration grid"
			gen_compare _total_percentage, Allocations.get_statistical_configuration_page_total_percentage, "TST037336 Expected total percentage to be 100%"
			gen_compare _statistical_config_grid_total_value, Allocations.get_statistical_configuration_page_grid_total_value, "TST037336 Expected total Value to be 4,501.67"
			
			Allocations.click_on_next_button
			Allocations.click_statistical_distribution_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_distribution_grid_rows(_distributed_rows_TST037336), "TST037336 Expected rows on Statistical Distribution grid"
			gen_compare _total_percentage, Allocations.get_statistical_distribution_table_total_percentage, "TST037336 Expected total percentage to be 100%"
			gen_compare _statistical_distribution_grid_total_value, Allocations.get_statistical_distribution_table_total_amount, "TST037336 Expected total Value to be 200.00"
			
			gen_end_test "TST037336 Go back to Configuration screen and select General Ledger Account and Dimension 2 distribution fields"
			
			# TST037785 - Verify the statistical distribution with distribution field as combination of Dimensions and General Ledger Account and Distribution GLA being populated from Source.
			
			gen_start_test "TST037785 - Verify the statistical distribution with distribution field as combination of Dimensions and General Ledger Account and Distribution GLA being populated from Source."
			
			# Select Copy GLAs from radio button
			Allocations.select_copy_glas_radio_button
			# Assert both Source and Basis are avaiable in Copy GLAs from picklist.
			gen_compare true, Allocations.assert_copy_glas_picklist_option_avaiable($alloc_copy_glas_picklist_from_source_label), "TST037785 Expected source available in Copy GLAs from picklist."
			gen_compare true, Allocations.assert_copy_glas_picklist_option_avaiable($alloc_copy_glas_picklist_from_basis_label), "TST037785 Expected Basis available in Copy GLAs from picklist."
			# Select Source in Copy GLAs from picklist
			Allocations.set_copy_glas_picklist $alloc_copy_glas_picklist_from_source_label
			Allocations.click_statistical_distribution_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_distribution_grid_rows(_distributed_rows_TST037785), "TST037785 Expected rows on Statistical Distribution grid"
			gen_compare _total_percentage, Allocations.get_statistical_distribution_table_total_percentage, "TST037785 Expected total percentage to be 100%"
			gen_compare _statistical_distribution_grid_total_value, Allocations.get_statistical_distribution_table_total_amount, "TST037785 Expected total Value to be 200.00"
			
			gen_end_test "TST037785 - Verify the statistical distribution with distribution field as combination of Dimensions and General Ledger Account and Distribution GLA being populated from Source."
			
			# TST037786 - Verify the statistical distribution with distribution field as combination of Dimensions and General Ledger Account and Distribution GLA being populated from Basis.
			
			gen_start_test "TST037786 - Verify the statistical distribution with distribution field as combination of Dimensions and General Ledger Account and Distribution GLA being populated from Basis."
			
			# Select Source in Copy GLAs from picklist
			Allocations.set_copy_glas_picklist $alloc_copy_glas_picklist_from_basis_label
			Allocations.click_statistical_distribution_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_distribution_grid_rows(_distributed_rows_TST037786), "TST037786 Expected rows on Statistical Distribution grid"
			gen_compare _total_percentage, Allocations.get_statistical_distribution_table_total_percentage, "TST037786 Expected total percentage to be 100%"
			gen_compare _statistical_distribution_grid_total_value, Allocations.get_statistical_distribution_table_total_amount, "TST037786 Expected total Value to be 200.00" 
			
			gen_end_test "TST037786 - Verify the statistical distribution with distribution field as combination of Dimensions and General Ledger Account and Distribution GLA being populated from Basis."
			
			# TST037787 - Verify the statistical distribution with distribution field as Multiple Dimensions and Distribution GLA being populated from Source
			
			gen_start_test "TST037787 - Verify the statistical distribution with distribution field as Multiple Dimensions and Distribution GLA being populated from Source."
			
			Allocations.click_on_back_button
			Allocations.remove_distribution_field $alloc_gla_label
			Allocations.select_distribution_fields [$alloc_dim1_label, $alloc_dim3_label, $alloc_dim4_label]
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_config_grid_rows(_rows_TST037787), "TST037787 Expected rows on Statistical Configuration grid"
			gen_compare _total_percentage, Allocations.get_statistical_configuration_page_total_percentage, "TST037787 Expected total percentage to be 100%"
			gen_compare _statistical_config_grid_total_value, Allocations.get_statistical_configuration_page_grid_total_value, "TST037787 Expected total Value to be 4,501.67"
			
			Allocations.click_on_next_button
			# Select Copy GLAs from radio button
			Allocations.select_copy_glas_radio_button
			# Check that Basis option is not avaiable in Copy GLAs from picklist
			gen_compare false, Allocations.assert_copy_glas_picklist_option_avaiable($alloc_copy_glas_picklist_from_basis_label), "TST037787 Expected no Basis available in Copy GLAs from picklist."
			Allocations.set_copy_glas_picklist $alloc_copy_glas_picklist_from_source_label
			Allocations.click_statistical_distribution_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_distribution_grid_rows(_distributed_rows_TST037787), "TST037787 Expected rows on Statistical Distribution grid"
			gen_compare _total_percentage, Allocations.get_statistical_distribution_table_total_percentage, "TST037787 Expected total percentage to be 100%"
			gen_compare _statistical_distribution_grid_total_value, Allocations.get_statistical_distribution_table_total_amount, "TST037787 Expected total Value to be 200.00"

			gen_end_test "TST037787 - Verify the statistical distribution with distribution field as Multiple Dimensions and Distribution GLA being populated from Source."	
			
			# TST037788 - Verify the statistical distribution with distribution field as General Ledger Account and Distribution GLA being populated from Basis.
			gen_start_test "TST037788 - Verify the statistical distribution with distribution field as General Ledger Account and Distribution GLA being populated from Basis."
			Allocations.click_on_back_button
			Allocations.select_distribution_fields [$alloc_gla_label]
			Allocations.remove_distribution_field $alloc_dim1_label
			Allocations.remove_distribution_field $alloc_dim2_label
			Allocations.remove_distribution_field $alloc_dim3_label
			Allocations.remove_distribution_field $alloc_dim4_label
			Allocations.click_statistical_basis_configuration_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_config_grid_rows(_rows_TST037788), "TST037788 Expected rows on Statistical Configuration grid"
			gen_compare _total_percentage, Allocations.get_statistical_configuration_page_total_percentage, "TST037788 Expected total percentage to be 100%"
			gen_compare _statistical_config_grid_total_value, Allocations.get_statistical_configuration_page_grid_total_value, "TST037788 Expected total Value to be 4,501.67"
			
			Allocations.click_on_next_button
			# Select Copy GLAs from radio button
			Allocations.select_copy_glas_radio_button
			# Check that Basis option is not avaiable in Copy GLAs from picklist
			gen_compare false, Allocations.assert_copy_glas_picklist_option_avaiable($alloc_copy_glas_picklist_from_source_label), "TST037788 Expected no Source available in Copy GLAs from picklist."
			Allocations.set_copy_glas_picklist $alloc_copy_glas_picklist_from_basis_label
			Allocations.click_statistical_distribution_page_preview_button
			gen_compare true, Allocations.compare_statistical_basis_distribution_grid_rows(_distributed_rows_TST037788), "TST037788 Expected rows on Statistical Distribution grid"
			gen_compare _total_percentage, Allocations.get_statistical_distribution_table_total_percentage, "TST037788 Expected total percentage to be 100%"
			gen_compare _statistical_distribution_grid_total_value, Allocations.get_statistical_distribution_table_total_amount, "TST037788 Expected total Value to be 200.00"
			
			_detail_page_allocation_type = "Variable > Statistical"
			_detail_page_description = "TID021393 Description"
			_detail_page_output = "Transactions"
			_detail_page_company = $company_merlin_auto_spain
			Allocations.click_on_next_button
			
			Allocations.set_destination_document_description _post_screen_description
			Allocations.set_destination_date_value _5daysfromtoday
			Allocations.set_destination_period_value PREVIOUS_PERIOD1
			
			Allocations.click_on_post_button
			gen_end_test "TST037788 - Verify the statistical distribution with distribution field as General Ledger Account and Distribution GLA being populated from Basis."	
		end
	end

	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID021393: Verify the statistical allocation distribution through manual GLA allocation with different distribution fields combinations."
	end
end
		