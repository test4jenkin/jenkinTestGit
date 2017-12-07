#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisit: Org with basedata deployed.
#  	Product Area: ffa smoke test data setup 
# 	Story:  
#--------------------------------------------------------------------#

describe "Smoke Test - Setup", :type => :request do
	include_context "login"	
	last_year_value = (Time.now).year - 1
	first_day_date_of_last_year= "01/01/"+last_year_value.to_s
	_field_label = "customText"
	_field_length = 15
	_prod_name = $bd_product_centric_rear_brake_hose_1987_1989_dodge_raider
	
	it "Enable Tabs for visibility in All Tabs[MANAGED]" do
		SF.app $accounting
		SF.tab $tab_select_company				
		FFA.select_company [$company_merlin_auto_spain] ,true		
		puts "Set Visibility of tabs enabled required"
		if  ORG_TYPE != MANAGED
			SF.display_tab_in_All_Tabs $tab_bank_reconciliations, $ffa_custom_setting_tab_default_on
			SF.display_tab_in_All_Tabs $tab_sales_tax_calculation_settings, $ffa_custom_setting_tab_default_on		
			SF.display_tab_in_All_Tabs $tab_sub_analysis_mapping, $ffa_custom_setting_tab_default_on
		end
	end
	
	it "Setup step 10:Update Opportunity and add a new product line" do
		login_user
		puts "Setup step 10"
		SF.retry_script_block do
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity $bd_opp_pyramid_emergency_generators
			OPP.view_opp_product $bd_product_bendix_front_brake_pad_1975_83_chrysler_cordoba
			SF.click_button_delete
			gen_alert_ok
		end
		OPP.click_add_product
		OPP.product_select $bd_product_bendix_front_brake_pad_1975_83_chrysler_cordoba
		SF.click_button $ffa_select_button
		OPP.set_product_quantity $bd_product_bendix_front_brake_pad_1975_83_chrysler_cordoba, 10
		OPP.set_product_date $bd_product_bendix_front_brake_pad_1975_83_chrysler_cordoba, first_day_date_of_last_year
		SF.click_button_save
		SF.wait_for_search_button
	end
	
	it "Setup step 11.1:Adding product in standard price book" do
		login_user		
		puts "Adding product in standard price book for unmanaged org."
		_centric_rear_brake_list_price_usd_400 = "USD 400.00"
		SF.tab $tab_price_book
		SF.wait_for_search_button
		SF.click_button_go
		page.has_text?($product_pricebook_standard_label)
		SF.click_link $product_pricebook_standard_label				
		SF.click_button $ffa_add_button
		find($product_add_pricebook_search).set $bd_product_centric_rear_brake_hose_1987_1989_dodge_raider
		find($product_add_pricebook_save_button).click
		gen_wait_less # wait for the result screen to get refresh with updated search results
		FFA.listview_select_all 
		SF.click_button $ffa_select_button
		SF.wait_for_search_button
		pricebook_list_price_checkboxId = find(:xpath,$product_add_pricebook_list_price_checkbox_pattern.sub($sf_param_substitute,_centric_rear_brake_list_price_usd_400))[:id]
		check pricebook_list_price_checkboxId
		SF.click_button $ffa_save_button
		SF.wait_for_search_button
	end
	
	it "Setup step 11.2:Clone an Opportunity without product" do
		login_user
		SF.retry_script_block do 
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity $bd_opp_pyramid_emergency_generators
			OPP.click_clone_without_product
			OPP.set_opportunity_name $bd_opp_pyramid_emergency_generators_2
			SF.click_button_save
		end
	end
	it "Setup step 11.3:Add a product in cloned opportunity" do
		login_user
		SF.tab $tab_opportunities
		OPP.all_opportunities_view
		SF.click_button_go
		OPP.view_opportunity $bd_opp_pyramid_emergency_generators_2
		OPP.click_add_product
		# If two pricebook are active in org, user has to select one of the pricebook before selecting the product.
		if (page.has_css?($product_select_pricebook_dropdown,:wait => DEFAULT_LESS_WAIT))
			OPP.select_price_book $label_standard_pricebook
			SF.click_button_save
		end
		OPP.product_select _prod_name
		SF.click_button "Select"
		OPP.set_product_quantity _prod_name, 10
		OPP.set_product_date _prod_name, first_day_date_of_last_year
		SF.click_button_save
		SF.wait_for_search_button
		OPP.view_opp_product _prod_name
		OPP.view_opp_product_schedule_click_delete
		SF.wait_for_search_button
	end
	
	it "Setup step 14:Add remote site setting for avalara" do
		login_user
		SF.remote_site_settings_create_new
		SF.remote_site_settings_set_site_name "AVALARA"
		SF.remote_site_settings_set_site_url "https://development.avalara.net"
		SF.remote_site_settings_set_disable_protocol_security "true"		
		SF.click_button_save
		SF.wait_for_search_button
	end
	
	it "Setup step 16:Add sales tax calculation settings" do
		login_user
		SF.tab $tab_sales_tax_calculation_settings
		SalesTaxCalc.set_enable_external_sales_tax_calculation "false"		
		SalesTaxCalc.set_account_number "1100092360"
		SalesTaxCalc.set_connection_url "https://development.avalara.net"
		SalesTaxCalc.set_license_key "4C228AB7A7B81685"
		SalesTaxCalc.set_summary_tax_code "AVALARA"
		SalesTaxCalc.set_record_full_sales_tax_details "true"
		SalesTaxCalc.set_address_validation_filter "US,CA"
		SF.click_button_save
		SF.wait_for_search_button
	end

	it "Setup step 18:New custom setting for as of aging report" do
		login_user
		SF.new_custom_setting $ffa_custom_setting_as_of_aging_report_settings
		SF.click_button_save 
		SF.wait_for_search_button
	end
	
	it "Setup step 19:Layout Update-Add OnHold field in Transaction Line Item" do
		login_user
		_layout_name = "Transaction Line Item Layout"
		_field_to_add = ["On Hold"]
		SF.edit_layout_add_field $ffa_object_transaction_line_item, _layout_name, $sf_layout_panel_fields, _field_to_add, $sf_edit_page_layout_target_position
		SF.wait_for_search_button
	end

	it "Setup step 20.1:create text type field in sales invoice" do
		login_user
		SF.create_text_type_field $ffa_object_sales_invoice, _field_label, _field_length
	end
	
	it "Setup step 20.2:create text type field in sales invoice line item" do
		login_user
		SF.create_text_type_field $ffa_object_sales_invoice_line_item, _field_label, _field_length
	end
	
	it "Setup step 20.3:create text type field in transaction" do
		login_user
		SF.create_text_type_field $ffa_object_transaction, _field_label, _field_length
	end
	
	it "Setup step 20.4:create text type field in transaction line item" do
		login_user
		SF.create_text_type_field $ffa_object_transaction_line_item, _field_label, _field_length
	end
	
	it "Setup step 21:Set sub analysis mapping" do
		login_user
		SF.tab $tab_sub_analysis_mapping
		page.has_button?('Save')
		SAM.click_new_mapping_icon
		SAM.set_derive_transaction_line_item true
		SAM.select_sales_invoice_header _field_label
		SAM.select_sales_invoice_line_item _field_label
		SAM.select_transaction_header _field_label
		SAM.select_transaction_line_item _field_label
		SF.click_button_save
		SF.wait_for_search_button
	end
	
	it "Setup step 22:create new currency CAD if not present and make it active" do
		login_user
		_is_active_curr = SF.is_active_currency $bd_currency_cad
		if _is_active_curr == false
			SF.create_currency $bd_currency_cad, "1.00", 2
			_is_active_curr = SF.is_active_currency $bd_currency_cad
		end
		gen_compare true , _is_active_curr , "Expected currency should be active"
	end

	it "Setup step 23:Add Fields to Inter company Layout " do
		login_user
		_layout_name = "Intercompany Cash Entry Layout"
		_field_to_add = ["Destination Document Bank Account"]
		SF.edit_layout_add_field $ffa_object_intercompany_transfer, _layout_name, $sf_layout_panel_fields, _field_to_add, $sf_edit_page_layout_target_position
	end 
end
