#--------------------------------------------------------------------#
#	TID : TID017863
# 	Pre-Requisite : smoketest_data_setup.rb , setup_smoketest_data_ext.rb
#  	Product Area:  Accounting - Chart of Accounts.
#--------------------------------------------------------------------#

describe "TID017863 Smoke Test:Merlin Auto Spaim-  verifies that auto populate local GLA functionality on TLIs of all documents, with local COA populated on owner company", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	#variables
	_gla_4001 = "4001"
    _gla_6000 = "6000"
	_reporting_code_local = "Local";
	current_date = Time.now.strftime("%d/%m/%Y")
	_line1 = 1
	_line2 = 2
	_line3 = 3
	_line4 = 4
	_line5 = 5
	_line6 = 6
	_line7 = 7
	# Document 
	_vendor_inv_number = "VIN0099"
	_value_106_86 = "106.86"
	_value_56 = "56.00"
	_value_45 = "45.00"
	_value_N_106_86 ="-106.86"
	_value_7_88 = "7.88"
	_value_2_80 = "2.80"
	_value_n0_90 = "-0.90"
	_value_n3_92 = "-3.92"
	_name_corporate = "Corporate"
	_name_french = "French"
	_coa_corporate_query = "SELECT ID, Name from #{ORG_PREFIX}ChartOfAccountsStructure__c  WHERE Name = '#{$sf_param_substitute}'"

	before :all do
		#Hold Base Data
		gen_start_test "TID017863"	
		FFA.hold_base_data_and_wait
		#Additional data section"
		begin
			# Create custom setting
			custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}AllowUseOfLocalGLAs__c = true);"
			custom_setting += "INSERT setting;"
			APEX.execute_commands [custom_setting]
			
			#create corporate  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_corporate
			COAS.set_default_corporate true
			COAS.set_active true
			SF.click_button_save
			gen_compare_has_content _name_corporate , true , "COA corporate created."
			
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_corporate )
			coa_corporate_id = APEX.get_field_value_from_soql_result "Id"
			create_corporate_gla = "#{ORG_PREFIX}codaGeneralLedgerAccount__c glaCorporate = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_4001}', #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = 'Corporate', #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_corporate_id}');"
			create_corporate_gla += "INSERT glaCorporate;"
			APEX.execute_commands [create_corporate_gla]
						
			gla_query = "SELECT ID from #{ORG_PREFIX}codaGeneralLedgerAccount__c  WHERE Name = '#{_gla_4001}'"
			APEX.execute_soql gla_query
			gla_corporate_id = APEX.get_field_value_from_soql_result "Id"
						
			#create french  chart of account structure
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_new
			COAS.set_name _name_french
			COAS.set_default_corporate false
			COAS.set_active false
			SF.click_button_save
			gen_compare_has_content _name_french , true , "COA french created."
			
			#creating Local GLAs
			APEX.execute_soql _coa_corporate_query.gsub($sf_param_substitute,_name_french )
			coa_french_id = APEX.get_field_value_from_soql_result "Id"
			
			gla_list_query = "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaList = new List<#{ORG_PREFIX}codaGeneralLedgerAccount__c>();"
			gla_list_query += "for(integer i=1;i<5;i++){"
			gla_list_query += "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla2 = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_6000}' + i, #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = '#{_reporting_code_local}' + i, #{ORG_PREFIX}ChartOfAccountsStructure__c='#{coa_french_id}');" 
			gla_list_query += "glaList.add(gla2);}"
			gla_list_query += "INSERT glaList;"			
			#updating the currency on GLA - 60002 and 60003
			gla_list_query += "if(glaList[1].Name=='60002' && glaList[2].Name == '60003')"
			gla_list_query += "{"
			gla_list_query += "glaList[1].CurrencyIsoCode = 'EUR';"
			gla_list_query += "glaList[2].CurrencyIsoCode = 'GBP';"
			gla_list_query += "}"
			gla_list_query += "UPDATE glaList;"
			APEX.execute_commands [gla_list_query]
						
			SF.tab $tab_chart_of_accounts_structures
			SF.wait_for_search_button
			SF.click_button_go
			SF.click_link _name_french
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button	
			COAS.set_default_corporate_gla _gla_4001
			COAS.set_default_local_gla "60001"
			COAS.set_active true
			SF.click_button_save			
			
			update_company = "#{ORG_PREFIX}codaCompany__c  company= [select ID from #{ORG_PREFIX}codaCompany__c WHERE NAME='#{$company_merlin_auto_spain}'];"
			update_company += "company.#{ORG_PREFIX}LocalChartOfAccountsStructure__c = '#{coa_french_id}';"
			update_company += "company.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = true;"
			update_company += "UPDATE company;"
			APEX.execute_commands [update_company]
			
			update_corporate_glas = "Set<String> corporateGla = new Set<String>();"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_account_payable_control_eur}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_vat_input}');"
			update_corporate_glas += "corporateGla.add('#{$bd_gla_vat_output}');"
			update_corporate_glas += "List<#{ORG_PREFIX}CODAGeneralLedgerAccount__c> corporateGLAs = [Select Id, Name from #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name in :corporateGla];"
			#add corporate chart of account structure in corporate glas
			update_corporate_glas += "for(#{ORG_PREFIX}CODAGeneralLedgerAccount__c corpGLA : corporateGLAs)"
			update_corporate_glas += "corpGLA.#{ORG_PREFIX}ChartOfAccountsStructure__c = '#{coa_corporate_id}';"
			update_corporate_glas += "update corporateGLAs;"
			APEX.execute_commands [update_corporate_glas]
						
			#create COA Mapping 1
			SF.tab $tab_chart_of_accounts_mappings
			COAM.select_corporate_gla $bd_gla_account_payable_control_eur
			COAM.select_local_gla "60002"
			#Compare result in mappings table before save
			_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
			_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
			gen_compare $bd_gla_account_payable_control_eur, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
			gen_compare "60002", _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
			COAM.click_on_save_button
			# Reload chart of accounts mapping UI after save action  and Compare result in mappings table after save and reloading the page
			SF.tab $tab_chart_of_accounts_mappings		
			_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
			_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
			gen_compare $bd_gla_account_payable_control_eur, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
			gen_compare "60002", _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
						
			#create COA Mapping 2
			COAM.select_corporate_gla $bd_gla_vat_input
			COAM.select_local_gla "60003"
			# Compare result in mappings table before save
			_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
			_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
			gen_compare $bd_gla_vat_input, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
			gen_compare "60003", _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
			COAM.click_on_save_button
			# Reload chart of accounts mapping UI after save action  and Compare result in mappings table after save and reloading the page
			SF.tab $tab_chart_of_accounts_mappings		
			_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '2', $coam_mappings_grid_corporate_gla_column
			_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '2', $coam_mappings_grid_local_gla_column
			gen_compare $bd_gla_vat_input, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 2 in Mappings grid'
			gen_compare "60003", _row1_local_gla_name, 'Comparing Local GLA Name in row 2 in Mappings grid'
			
			#create COA Mapping 3
			COAM.select_corporate_gla $bd_gla_vat_output
			COAM.select_local_gla "60004"
			# Compare result in mappings table before save
			_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
			_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
			gen_compare $bd_gla_vat_output, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
			gen_compare "60004", _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
			COAM.click_on_save_button
			# Reload chart of accounts mapping UI after save action  and Compare result in mappings table after save and reloading the page
			SF.tab $tab_chart_of_accounts_mappings		
			_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '3', $coam_mappings_grid_corporate_gla_column
			_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '3', $coam_mappings_grid_local_gla_column
			gen_compare $bd_gla_vat_output, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 3 in Mappings grid'
			gen_compare "60004", _row1_local_gla_name, 'Comparing Local GLA Name in row 3 in Mappings grid'			
		end	
	end

	it "TID017863-TST027380: Create a Payable Invoice and Verify auto populate local GLA functionality on payable invoice. " do
		gen_start_test "TST027380: Create a payable Invoice. "
		# Step 1.1
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PIN.set_account $bd_account_bmw_automobiles

			PIN.set_vendor_invoice_number _vendor_inv_number
			PIN.set_vendor_invoice_total _value_106_86
			
			#Add expense line - GLA
			PIN.set_expense_line_gla $bd_gla_account_receivable_control_gbp
			PIN.click_new_expense_line
			PIN.set_expense_line_net_value 1, _value_56
			PIN.set_expense_line_tax_code 1 , $bd_tax_code_vo_r_purchase
			PIN.check_expense_line_reverse_charge 1
			PIN.set_expense_line_output_tax_code 1 , $bd_tax_code_vo_ec_purchase
			# Add Product Line 
			PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PIN.click_product_new_line
			PIN.set_product_line_quantity 1, 1
			PIN.set_product_line_unit_price 1, _value_45
			PIN.set_product_line_tax_code 1, $bd_tax_code_vo_std_purchase
			PIN.check_prod_line_reverse_charge 1
			PIN.set_product_line_output_tax_code 1 , $bd_tax_code_apexcounty
			# Post the Payable Invoice
			FFA.click_save_post
			gen_compare $bd_document_status_complete , PIN.get_invoice_status , "TST027380: Expected Payable Invoice status to be complete. "
			# get transaction number
			pin_trx_number = PIN.get_invoice_transaction_number
			# Open transaction detail page
			PIN.click_transaction_link_and_wait
			TRANX.open_transaction_line_item_by_home_value _value_N_106_86
			validate_trans_lineItems "TST027380", pin_trx_number, $tranx_account_label, 1, $bd_gla_accounts_payable_control_eur, $bd_currency_eur, _value_N_106_86, "60002", $bd_currency_eur, _value_N_106_86
			TRANX.open_transaction_line_item_by_home_value _value_45
			validate_trans_lineItems "TST027380", pin_trx_number, $tranx_analysis_label, 2, $bd_gla_stock_parts, $bd_currency_gbp, "36.00", "60001", $bd_currency_usd, "67.50"
			TRANX.open_transaction_line_item_by_home_value _value_56
			validate_trans_lineItems "TST027380", pin_trx_number, $tranx_analysis_label, 3, $bd_gla_account_receivable_control_gbp, $bd_currency_gbp, "44.80", "60001", $bd_currency_usd, "84.00"
			TRANX.open_transaction_line_item_by_home_value _value_7_88
			validate_trans_lineItems "TST027380", pin_trx_number, $tranx_tax_label, 4, $bd_gla_vat_input, $bd_currency_gbp, "6.30", "60003", $bd_currency_gbp, "6.30"
			TRANX.open_transaction_line_item_by_home_value _value_2_80
			validate_trans_lineItems "TST027380", pin_trx_number, $tranx_tax_label, 5, $bd_gla_vat_input, $bd_currency_gbp, "2.24", "60003", $bd_currency_gbp, "2.24"
			TRANX.open_transaction_line_item_by_home_value _value_n0_90
			validate_trans_lineItems "TST027380", pin_trx_number, $tranx_tax_label, 6, $bd_gla_apextaxgla001, $bd_currency_usd, "-1.35", "60001", $bd_currency_usd, "-1.35"
			TRANX.open_transaction_line_item_by_home_value _value_n3_92
			validate_trans_lineItems "TST027380", pin_trx_number, $tranx_tax_label, 7, $bd_gla_vat_input, $bd_currency_gbp, "-3.14", "60003", $bd_currency_gbp, "-3.14"
		end		
		gen_end_test "TST027380: Create a payable Invoice. "
	end
	
	it "# Step TST027381 -Verify auto populate local GLA functionality on payable credit note." do		
		gen_start_test "TST027381"
		begin
			_vendor_pcrn_number = " VCRN0010"
			_value_56 = "56"
			_value_45 = "45"
						
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_payable_credit_notes
			SF.click_button_new
			PCR.set_account $bd_account_bmw_automobiles
			PCR.set_vendor_credit_note_number _vendor_pcrn_number
			PCR.set_payable_credit_note_date current_date
			
			#Add expense line - GLA
			PCR.set_expense_line_gla $bd_gla_account_receivable_control_gbp
			PCR.click_new_expense_line
			PCR.set_expense_line_net_value 1, _value_56
			PCR.set_expense_line_tax_code 1, $bd_tax_code_vo_r_purchase
			PCR.check_expense_line_reverse_charge 1
			PCR.set_expense_line_output_tax_code 1, $bd_tax_code_vo_ec_purchase
			
			# Add Product Line
			PCR.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
			PCR.click_product_new_line
			PCR.set_product_line_quantity 1, 1
			PCR.set_product_line_unit_price 1, _value_45
			PCR.set_product_line_tax_code 1, $bd_tax_code_vo_std_purchase
			PCR.check_prod_line_reverse_charge 1
			PCR.set_product_line_output_tax_code 1, $bd_tax_code_apexcounty
						
			PCR.set_vendor_credit_note_total _value_106_86
			# Post the Payable Invoice
			FFA.click_save_post
			gen_compare $bd_document_status_complete , PCR.get_credit_note_status , "TST027381: Expected Payable credit note status to be complete. "
			pcrn_trx_number = PCR.get_credit_note_transaction_number
						
			#Open transaction detail page
			PCR.click_transaction_number
			TRANX.open_transaction_line_item_by_home_value _value_106_86
			validate_trans_lineItems "TST027381", pcrn_trx_number,  $tranx_account_label, 1, $bd_gla_accounts_payable_control_eur, $bd_currency_eur, _value_106_86, "60002", $bd_currency_eur, _value_106_86
			TRANX.open_transaction_line_item_by_home_value "-45.00"
			validate_trans_lineItems "TST027381", pcrn_trx_number, $tranx_analysis_label,2, $bd_gla_stock_parts, $bd_currency_gbp, "-36.00", "60001", $bd_currency_usd, "-67.50"
			TRANX.open_transaction_line_item_by_home_value "-56.00"
			validate_trans_lineItems "TST027381", pcrn_trx_number, $tranx_analysis_label, 3, $bd_gla_account_receivable_control_gbp, $bd_currency_gbp, "-44.80", "60001", $bd_currency_usd, "-84.00"
			TRANX.open_transaction_line_item_by_home_value "-7.88"
			validate_trans_lineItems "TST027381", pcrn_trx_number, $tranx_tax_label, 4, $bd_gla_vat_input, $bd_currency_gbp, "-6.30", "60003", $bd_currency_gbp, "-6.30"
			TRANX.open_transaction_line_item_by_home_value "-2.80"
			validate_trans_lineItems "TST027381", pcrn_trx_number, $tranx_tax_label, 5, $bd_gla_vat_input, $bd_currency_gbp, "-2.24", "60003", $bd_currency_gbp, "-2.24"
			TRANX.open_transaction_line_item_by_home_value  "0.90"
			validate_trans_lineItems "TST027381", pcrn_trx_number,$tranx_tax_label, 6, $bd_gla_apextaxgla001, $bd_currency_usd, "1.35", "60001", $bd_currency_usd, "1.35"
			TRANX.open_transaction_line_item_by_home_value "3.92"
			validate_trans_lineItems "TST027381", pcrn_trx_number, $tranx_tax_label, 7, $bd_gla_vat_input, $bd_currency_gbp, "3.14", "60003", $bd_currency_gbp, "3.14"
		end
		gen_end_test "TST027381"
	end
	
	it "# Step TST027382 -Verify auto populate local GLA functionality on sales invoice." do	
		gen_start_test "TST027382"
		begin
			_line1_quantity_1=1
			_line1_amount_74_5 = "74.5"
			_value_164_14 = "164.14"
			  
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_cambridge_auto
			SIN.set_invoice_date current_date
			SIN.add_line _line1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , _line1_quantity_1, _line1_amount_74_5 , $bd_tax_code_vo_std_sales , nil , nil	
			FFA.click_save_post			
			inv_status = SIN.get_status
			sin_trx_number = SIN.get_transaction_number
			#Assert invoice status
			gen_compare $bd_document_status_complete , inv_status ,"TST027382:Expected sales invoice status to be Complete."
						
			# Open transaction detail page
			SIN.click_transaction_number
			#validations
			TRANX.open_transaction_line_item_by_home_value "109.43"  
			validate_trans_lineItems "TST027382", sin_trx_number, $tranx_account_label, 1, $bd_gla_account_receivable_control_usd, $bd_currency_usd, "164.14", "60001", $bd_currency_usd, "164.14"
			TRANX.open_transaction_line_item_by_home_value "-93.13"
			validate_trans_lineItems "TST027382", sin_trx_number, $tranx_analysis_label, 2, $bd_gla_sales_parts, $bd_currency_gbp, "-74.50", "60001", $bd_currency_usd, "-139.69"
			TRANX.open_transaction_line_item_by_home_value "-16.30"
			validate_trans_lineItems "TST027382", sin_trx_number, $tranx_tax_label, 3, $bd_gla_vat_output, $bd_currency_gbp, "-13.04", "60004", $bd_currency_usd, "-24.45"
		end
	end
	
	it "# Step TST027383 -Verify auto populate local GLA functionality on sales credit note." do				
		gen_start_test "TST027383"
		begin
			_line1=1
			_line1_quantity_1=1
			_line1_amount_74_5 = "74.5"
			_value_164_14 = "164.14"

			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCR.set_account $bd_account_cambridge_auto 
			FFA.click_account_toggle_icon
			SCR.set_creditnote_date current_date
			SCR.add_line _line1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , _line1_quantity_1 , _line1_amount_74_5 ,$bd_tax_code_vo_std_sales ,nil
			FFA.click_save_post			
			scr_status = SCR.get_credit_note_status
			scr_trx_number = SCR.get_transaction_number
			#Assert invoice status
			gen_compare $bd_document_status_complete , scr_status ,"TST027382:Expected SCRN status to be Complete."
			
			# Open transaction detail page
			SCR.click_transaction_number
			#validations
			TRANX.open_transaction_line_item_by_home_value "-109.43"
			validate_trans_lineItems "TST027383", scr_trx_number, $tranx_account_label, 1, $bd_gla_account_receivable_control_usd, $bd_currency_usd, "-164.14", "60001", $bd_currency_usd, "-164.14"
			TRANX.open_transaction_line_item_by_home_value "93.13"
			validate_trans_lineItems "TST027383", scr_trx_number, $tranx_analysis_label, 2, $bd_gla_sales_parts, $bd_currency_gbp, "74.50", "60001", $bd_currency_usd, "139.69"
			TRANX.open_transaction_line_item_by_home_value "16.30"
			validate_trans_lineItems "TST027383", scr_trx_number, $tranx_tax_label, 3, $bd_gla_vat_output, $bd_currency_gbp, "13.04", "60004", $bd_currency_usd, "24.45"
		end
	end
		
	it "# Step TST027384 -Verify auto populate local GLA functionality on Journals" do	
		gen_start_test "TST027384"
		begin
			_jnl_line1_amount_450 = "450.00"
			_jnl_line1_amount_780 = "780.00"
			_jln_line_ammount_9000 = "9,000.00"
			_jln_line_ammount_N_18506 = "-18,506.00"
			
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_journals
			SF.click_button_new
			JNL.set_journal_description "desc test"
			
			JNL.select_journal_line_type $bd_jnl_line_type_account_customer
			JNL.select_journal_line_value $bd_account_cambridge_auto
			JNL.click_journal_new_line
			JNL.line_set_journal_gla _line1, $bd_gla_stock_parts
			JNL.line_set_journal_amount _line1 , "6,660.00"
			
			JNL.select_journal_line_type $bd_jnl_line_type_account_vendor
			JNL.select_journal_line_value $bd_account_bmw_automobiles			
			JNL.click_journal_new_line
			JNL.line_set_journal_gla _line2, $bd_gla_stock_parts
			JNL.line_set_journal_amount _line2 , _jnl_line1_amount_450
			
			JNL.select_journal_line_type $bd_jnl_line_type_bank_account
			JNL.select_journal_line_value $bd_bank_account_santander_current_account	
			gen_wait_until_object $jnl_validate_button_locator
			JNL.click_journal_new_line
			JNL.line_set_journal_gla _line3, $bd_gla_account_receivable_control_gbp
			JNL.line_set_journal_amount _line3 , _jnl_line1_amount_780
			
			JNL.select_journal_line_type $bd_jnl_line_type_gla
			#JNL.select_journal_line_value $bd_bank_account_santander_current_account	
			gen_wait_until_object $jnl_validate_button_locator
			JNL.click_journal_new_line
			JNL.line_set_journal_gla _line4, $bd_gla_account_receivable_control_eur
			JNL.line_set_journal_amount _line4 , _jnl_line1_amount_780
			
			JNL.select_journal_line_type $bd_jnl_line_type_product_sales
			JNL.select_journal_line_value $bd_product_auto_com_clutch_kit_1989_dodge_raider
			gen_wait_until_object $jnl_validate_button_locator
			JNL.click_journal_new_line
			JNL.line_set_journal_gla _line5, $bd_gla_account_receivable_control_eur
			JNL.line_set_journal_amount _line5 , _jnl_line1_amount_780
			
			JNL.select_journal_line_type $bd_jnl_line_type_product_purchases
			JNL.select_journal_line_value $bd_product_auto_com_clutch_kit_1989_dodge_raider
			gen_wait_until_object $jnl_validate_button_locator
			JNL.click_journal_new_line
			JNL.line_set_journal_gla _line6, $bd_gla_stock_parts
			JNL.line_set_journal_amount _line6 , _value_56

			JNL.select_journal_line_type $bd_jnl_line_type_tax_code
			JNL.select_journal_line_value $bd_tax_code_apexcounty 
			gen_wait_until_object $jnl_validate_button_locator
			JNL.click_journal_new_line
			JNL.line_set_journal_gla _line7, $bd_gla_stock_parts
			JNL.line_set_journal_amount _line7 , _jln_line_ammount_9000
			
			JNL.select_journal_line_type $bd_jnl_line_type_gla
			#JNL.select_journal_line_value $bd_tax_code_apexcounty 
			gen_wait_until_object $jnl_validate_button_locator
			JNL.click_journal_new_line
			JNL.line_set_journal_gla 8, $bd_gla_stock_parts
			JNL.line_set_journal_amount 8 , _jln_line_ammount_N_18506
			#Save and Post
			gen_wait_until_object $jnl_validate_button_locator
			FFA.click_save_post
			gen_wait_until_object $jnl_journal_number
			jnl_name = JNL.get_journal_number
			jnl_status = JNL.get_journal_status
			jnl_trx_number = JNL.get_journal_transaction_number
			#Assert invoice status
			gen_compare $bd_document_status_complete , jnl_status ,"TST027383:Expected Journal to be Complete."
			
			# Open transaction detail page
			SIN.click_transaction_number
			TRANX.open_transaction_line_item_by_home_value "6,660.00"
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_account_label, 1, $bd_gla_stock_parts, $bd_currency_gbp, "5,328.00", "60001", $bd_currency_usd, "9,990.00"
			TRANX.open_transaction_line_item_by_home_value "450.00"
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_account_label, 2, $bd_gla_stock_parts, $bd_currency_gbp, "360.00", "60001", $bd_currency_usd, "675.00"
			TRANX.open_transaction_line_item_by_gla $bd_gla_account_receivable_control_gbp
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_analysis_label, 3, $bd_gla_account_receivable_control_gbp, $bd_currency_gbp, "624.00", "60001", $bd_currency_usd, "1,170.00"
			TRANX.open_transaction_line_item_by_home_value "56.00"
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_analysis_label, 5, $bd_gla_stock_parts, $bd_currency_gbp, "44.80", "60001", $bd_currency_usd, "84.00"
			TRANX.open_transaction_line_item_by_home_value "-18,506.00"
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_analysis_label, 7, $bd_gla_stock_parts, $bd_currency_gbp, "-14,804.80", "60001", $bd_currency_usd, "-27,759.00"
			TRANX.open_transaction_line_item_by_home_value "9,000.00"
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_tax_label, 8, $bd_gla_stock_parts, $bd_currency_gbp, "7,200.00", "60001", $bd_currency_usd, "13,500.00"
			
			tranx_soql_query = "SELECT ID, Name from #{ORG_PREFIX}codaTransactionLineItem__c  WHERE #{ORG_PREFIX}Transaction__r.Name = '#{jnl_trx_number}' AND #{ORG_PREFIX}HomeValue__c =780 AND #{ORG_PREFIX}GeneralLedgerAccount__r.Name = '#{$bd_gla_account_receivable_control_eur}'"
			condition_with_product = " AND #{ORG_PREFIX}Product__r.Name = '#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}'"
			condition_without_product = " AND #{ORG_PREFIX}Product__c=null"
			
			#validate Analysis Line with product 
			APEX.execute_soql tranx_soql_query + condition_with_product
			tranx_line_link = APEX.get_field_value_from_soql_result "Name"
			SF.tab $tab_journals
			SF.click_button_go
			SF.click_link jnl_name
			SF.wait_for_search_button
			SF.click_link jnl_trx_number
			SF.wait_for_search_button
			SF.click_link tranx_line_link
			SF.wait_for_search_button
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_analysis_label, 4, $bd_gla_account_receivable_control_eur, $bd_currency_eur, "780.00", "60001", $bd_currency_usd, "1,170.00"
			
			#validate Analysis Line without product 
			APEX.execute_soql tranx_soql_query + condition_without_product
			tranx_line_link = APEX.get_field_value_from_soql_result "Name"
			SF.tab $tab_journals
			SF.click_button_go
			SF.click_link jnl_name
			SF.wait_for_search_button
			SF.click_link jnl_trx_number
			SF.wait_for_search_button
			SF.click_link tranx_line_link
			SF.wait_for_search_button
			validate_trans_lineItems "TST027384", jnl_trx_number, $tranx_analysis_label, 6, $bd_gla_account_receivable_control_eur, $bd_currency_eur, "780.00", "60001", $bd_currency_usd, "1,170.00"
		end
	end

	it "# Step TST027385 -Verify auto populate local GLA functionality on cash entry." do	
		gen_start_test "TST027385"
		begin
			_line_amount_34 = "34.00"
			_value_N_51 = "-51.00"
			_value_51 = "51.00"
			
			login_user
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_cash_entries
			SF.click_button_new
			CE.select_cash_entry_type $bd_cash_entry_receipt_type
			CE.set_bank_account $bd_bank_account_santander_current_account
			CE.set_date current_date
			CE.set_currency $bd_currency_eur,$company_merlin_auto_spain
			CE.set_reference "REF1"
			
			CE.line_set_account_name $bd_account_cambridge_auto
			FFA.click_new_line
			CE.line_set_payment_method_value _line1 ,$bd_payment_method_electronic
			CE.line_set_cashentryvalue _line1,_line_amount_34
			
			FFA.click_save_post
			ce_status = CE.get_cash_entry_status
			ce_trx_number = CE.get_transaction_number
			#Assert ce status
			gen_compare $bd_document_status_complete , ce_status ,"TST027385:Expected ce to be Complete."
			
			# Open transaction detail page
			SIN.click_transaction_number
			TRANX.open_transaction_line_item_by_home_value "-34.00"
			validate_trans_lineItems "TST027385", ce_trx_number, $tranx_account_label, "1", $bd_gla_account_receivable_control_usd, $bd_currency_usd, _value_N_51, "60001", $bd_currency_usd, _value_N_51
			TRANX.open_transaction_line_item_by_home_value "34.00"
			validate_trans_lineItems "TST027385", ce_trx_number,  $tranx_analysis_label, "1", $bd_gla_bank_account_euros_us, $bd_currency_eur, _line_amount_34, "60001", $bd_currency_usd, _value_51
		end
	end

	after :all do
		login_user
		delete_data_script = ""
		delete_acc_setting = ""
		# purge  chart of account mapping and related transactions object.
		APEX.purge_object ["ChartOfAccountsMapping__c","codaTransaction__c"]
		# delete accounting settings which are added as a part of this script.
		delete_acc_setting += "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
		APEX.execute_commands [delete_acc_setting]
		
		# Purge other object separately to avoid Too Many SOQL error which appears due to single delete statement using FFA.delete_new_data_and_wait
		APEX.purge_object ["ChartOfAccountsStructure__c","codaTransaction__c","CodaInvoice__c","codaCreditNote__c","codaPurchaseInvoice__c",
		                   "codaPurchaseCreditNote__c","codaJournal__c","codaIntercompanyDefinition__c","codaIntercompanyTransfer__c"]
		
		# Delete Test script specific data separately.
        delete_data_script += "delete[SELECT Id FROM #{ORG_PREFIX}CODAGeneralLedgerAccount__c where Name='4001'or #{ORG_PREFIX}reportingCode__c like 'Local%' or #{ORG_PREFIX}reportingCode__c like 'SPAIN%' or #{ORG_PREFIX}reportingCode__c like 'USA%'];"
		APEX.execute_script delete_data_script
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID017863"
		SF.logout 
	end
end	

#open transaction line item and validate gla and local gla values
def validate_trans_lineItems test_step_number, trans_num , line_type, line_number, gla_name, gla_currency, gla_value, local_gla_name, local_gla_currency, local_gla_value
	#validation
	gen_compare gla_name, TRANX.get_line_item_gla_name , "#{test_step_number}:-#{line_type} Line #{line_number} -General Ledger Account  is correct"
	gen_compare gla_currency,TRANX.get_line_item_gla_currency_value , "#{test_step_number}:-#{line_type} Line #{line_number} -General Ledger Account Currency is correct"
	gen_compare gla_value, TRANX.get_line_item_gla_value , "#{test_step_number}:-#{line_type} Line #{line_number} -General Ledger Account Value is correct"
	gen_compare local_gla_name,TRANX.get_line_item_local_gla_name , "#{test_step_number}:-#{line_type} Line #{line_number}-Local General Ledger Account is correct"
	gen_compare local_gla_currency,TRANX.get_line_item_local_gla_currency_value , "#{test_step_number}:-#{line_type} Line #{line_number}-Local General Ledger Account Currency is correct"
	gen_compare local_gla_value, TRANX.get_line_item_local_gla_value , "#{test_step_number}:-#{line_type} Line #{line_number}-Local General Ledger Account Value is correct."
	# navigate back to transaction page
	SF.click_link trans_num
	SF.wait_for_search_button
end