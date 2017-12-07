#--------------------------------------------------------------------#
#   TID : TID020710
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: Payable Invoice CIF
#   driver=firefox rspec -fd -c spec/UI/cif_tests/cif_payable_invoice_TID020710.rb -fh -o result_cif_payable_invoice_TID020710.html
#--------------------------------------------------------------------#

describe "TID020710-This TID verifies the Enable Reverse Charge on Payable Invoice header in CIF layout.", :type => :request do
  include_context "login"
  include_context "logout_after_each"

	before :all do
		#Hold Base Data
		gen_start_test "TID020710: This TID verifies the Enable Reverse Charge on Payable Invoice header in CIF layout."
		FFA.hold_base_data_and_wait
	end
  
  it "Create,Save,Post payable invoice in Custom Input Form mode" do

    # login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_spain],true
	
	begin
		_update_company = "#{ORG_PREFIX}CodaCompany__c comp = [select Id, #{ORG_PREFIX}EnablePlaceOfSupplyRules__c from #{ORG_PREFIX}codaCompany__c where Name = 'Merlin Auto Spain'];" 
		_update_company += "comp.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = true; "
		_update_company += "update comp;"
		updateCompany = [ _update_company]
		puts _update_company
		APEX.execute_script _update_company
	end
	
    # #TST034563  - Verify that Enable Reverse Charge on PIN is enabled and output fields are available on expense and product line if Enable Place of Supply on document owner company is enabled.
    gen_start_test "TST034563 - Verify that Enable Reverse Charge on PIN is enabled and output fields are available on expense and product line if Enable Place of Supply on document owner company is enabled."
    begin
		_invoice_number = 'VIN#TST034563'
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		expect(CIF_PINV.is_pinv_enable_reverse_charge_checkbox_checked?).to be (true)
		CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
		CIF_PINV.set_pinv_invoice_currency $bd_currency_eur
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.is_pinv_expense_line_reverse_charge_checkbox_unchecked?
		_expense_output_tax_code = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_expense_line_output_tax_code_column_number
		_expense_output_tax_rate = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_expense_line_output_tax_rate_column_number
		_expense_output_tax_value = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_expense_line_output_tax_value_column_number
		
		gen_compare '', _expense_output_tax_code, 'Comparing default output text code on expense line item'
		gen_compare '0.000', _expense_output_tax_rate, 'Comparing default output text rate on expense line item'
		gen_compare '0.00', _expense_output_tax_value, 'Comparing default output text value on expense line item'
		
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
		CIF_PINV.set_pinv_expense_line_destination_company ''
		CIF_PINV.set_pinv_expense_line_dimesion_1 ''
		CIF_PINV.set_pinv_expense_line_dimesion_2 ''
		CIF_PINV.set_pinv_expense_line_line_description ''
		CIF_PINV.set_pinv_expense_line_net_value 10
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_input_tax_code $bd_tax_code_vo_r_purchase
		CIF_PINV.set_pinv_expense_line_input_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_input_tax_value '0.50', true
		CIF_PINV.click_pinv_expense_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_expense_line_output_tax_code $bd_tax_code_vo_s
		CIF_PINV.set_pinv_expense_line_output_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_output_tax_value '1.50', true
		CIF.wait_for_totals_to_calculate
		
		CIF_PINV.click_payable_invoice_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.is_pinv_line_reverse_charge_checkbox_unchecked?
		_product_output_tax_code = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_output_tax_code_column_number
		_product_output_tax_rate = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_output_tax_rate_column_number
		_product_output_tax_value = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_output_tax_value_column_number
		gen_compare '', _product_output_tax_code, 'Comparing output text code on product line item'
		gen_compare '0.000', _product_output_tax_rate, 'Comparing output text rate on product line item'
		gen_compare '', _product_output_tax_value, 'Comparing output text value on product line item'
		
		CIF_PINV.set_pinv_line_product $bd_product_auto1_com_clutch_kit_1989_dodge_raider
		CIF_PINV.set_pinv_line_destination_company ''
		CIF_PINV.set_pinv_line_quantity 2
		CIF_PINV.set_pinv_line_unit_price 100
		CIF_PINV.set_pinv_line_input_tax_code $bd_tax_code_vo_r_purchase 
		CIF_PINV.set_pinv_line_input_tax_rate '', false
		CIF_PINV.set_pinv_line_input_tax_value '10', true
		CIF_PINV.click_pinv_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_line_output_tax_code $bd_tax_code_vo_s
		CIF_PINV.set_pinv_line_output_tax_rate '', false
		CIF_PINV.set_pinv_line_output_tax_value '30.00', true
		CIF.click_toggle_button
		CIF.wait_for_totals_to_calculate
		CIF_PINV.click_pinv_save_post_button
		SF.wait_for_search_button
		CIF_PINV.compare_pinv_header_details(nil, nil, nil, '210.00', '-21.00', '189.00', 'Complete')
		gen_end_test "TST034563 - Verify that Enable Reverse Charge on PIN is enabled and output fields are available on expense and product line if Enable Place of Supply on document owner company is enabled."
	end
	
	begin
		_update_company = "#{ORG_PREFIX}CodaCompany__c comp = [select Id, #{ORG_PREFIX}EnablePlaceOfSupplyRules__c from #{ORG_PREFIX}codaCompany__c where Name = 'Merlin Auto Spain'];" 
		_update_company += "comp.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = false; "
		_update_company += "update comp;"
		updateCompany = [ _update_company]
		puts _update_company
		APEX.execute_script _update_company
	end
	
	##TST034564 - Verify that Enable Reverse Charge on PIN is disabled and output fields are not available on expense and product line if Enable Place of Supply on document owner company is disabled.
	gen_start_test "TST034564 - Verify that Enable Reverse Charge on PIN is disabled and output fields are not available on expense and product line if Enable Place of Supply on document owner company is disabled."
	begin
		_invoice_number = 'VIN#TST034564'
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		expect(CIF_PINV.is_pinv_enable_reverse_charge_checkbox_checked?).to be (false)
		CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
		CIF_PINV.set_pinv_invoice_currency $bd_currency_usd
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		CIF_PINV.click_new_row
		expect(CIF_PINV.is_pinv_expense_line_reverse_charge_checkbox_visible?).to be (false)
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
		CIF_PINV.set_pinv_expense_line_destination_company ''
		CIF_PINV.set_pinv_expense_line_dimesion_1 ''
		CIF_PINV.set_pinv_expense_line_dimesion_2 ''
		CIF_PINV.set_pinv_expense_line_line_description ''
		CIF_PINV.set_pinv_expense_line_net_value 10
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_input_tax_code $bd_tax_code_vo_r_purchase
		CIF_PINV.set_pinv_expense_line_input_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_input_tax_value '0.50', true
		CIF.wait_for_totals_to_calculate
		
		CIF_PINV.click_payable_invoice_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.set_pinv_line_product $bd_product_auto1_com_clutch_kit_1989_dodge_raider
		CIF_PINV.set_pinv_line_destination_company ''
		CIF_PINV.set_pinv_line_quantity 2
		CIF_PINV.set_pinv_line_unit_price 100
		CIF_PINV.set_pinv_line_input_tax_code $bd_tax_code_vo_r_purchase
		CIF_PINV.set_pinv_line_input_tax_rate '', false
		CIF_PINV.set_pinv_line_input_tax_value '10', true
		CIF.click_toggle_button
		CIF.wait_for_totals_to_calculate
		
		CIF_PINV.click_pinv_save_post_button
		SF.wait_for_search_button
		CIF_PINV.compare_pinv_header_details(nil, nil, nil, '210.00', '10.50', '220.50', 'Complete')
		gen_end_test "TST034564 - Verify that Enable Reverse Charge on PIN is disabled and output fields are not available on expense and product line if Enable Place of Supply on document owner company is disabled"
	end
	
	##TST034566 - Verify that user is able to edit the Enable Reverse Charge on PIN irrespective of Enable Place of Supply on document owner company.
	##TST034570	- Verify that Enable Reverse Charge on header is not amendable after posting of the document.
	gen_start_test "TST034566 - Verify that user is able to edit the Enable Reverse Charge on PIN irrespective of Enable Place of Supply on document owner company."
    begin
		_invoice_number = 'VIN#TST034566'
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
		CIF_PINV.set_pinv_invoice_currency $bd_currency_usd
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		CIF_PINV.click_payable_invoice_enable_reverse_charge_checkbox true
		
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
		CIF_PINV.set_pinv_expense_line_destination_company ''
		CIF_PINV.set_pinv_expense_line_dimesion_1 ''
		CIF_PINV.set_pinv_expense_line_dimesion_2 ''
		CIF_PINV.set_pinv_expense_line_line_description ''
		CIF_PINV.set_pinv_expense_line_net_value 10
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_input_tax_code $bd_tax_code_vo_r_purchase
		CIF_PINV.set_pinv_expense_line_input_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_input_tax_value '0.50', true
		CIF_PINV.click_pinv_expense_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_expense_line_output_tax_code $bd_tax_code_vo_s
		CIF_PINV.set_pinv_expense_line_output_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_output_tax_value '1.50', true
		CIF.wait_for_totals_to_calculate
		
		CIF_PINV.click_pinv_save_post_button
		SF.wait_for_search_button
		CIF_PINV.compare_pinv_header_details(nil, nil, nil, '10', '-1.00', '9.00', 'Complete')
		#TST034570	- checking that Enable Reverse Charge on header is not amendable after posting of the document.
		CIF.click_amend_button
		SF.wait_for_search_button
		gen_compare_has_css $cif_payable_invoice_enable_reverse_charge_disabled, true, "Enable reverse charge is disabled"
		gen_end_test "TST034566 - Verify that user is able to edit the Enable Reverse Charge on PIN irrespective of Enable Place of Supply on document owner company."
	end	
  end
  
	after :all do
		login_user
		# Delete Test Data
		_update_company = "#{ORG_PREFIX}CodaCompany__c comp = [select Id, #{ORG_PREFIX}EnablePlaceOfSupplyRules__c from #{ORG_PREFIX}codaCompany__c where Name = 'Merlin Auto Spain'];" 
		_update_company += "comp.#{ORG_PREFIX}EnablePlaceOfSupplyRules__c = false; "
		_update_company += "update comp;"
		updateCompany = [ _update_company]
		puts _update_company
		APEX.execute_script _update_company	
		FFA.delete_new_data_and_wait
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID020710 : This TID verifies the Enable Reverse Charge on Payable Invoice header in CIF layout."
	end
end