#--------------------------------------------------------------------#
#   TID : TID017332
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: Payable Invoice CIF
#   driver=firefox rspec -fd -c spec/UI/cif_tests/cif_payable_invoice_TID017332.rb -fh -o pin_ext.html
#--------------------------------------------------------------------#

describe "TID017332-TID verifies the reverse charge fields on default Custom Input Forms on VAT company's Payable Invoice.", :type => :request do
  include_context "login"
  include_context "logout_after_each"

	before :all do
		#Hold Base Data
		gen_start_test "TID017332: TID verifies the reverse charge fields on default Custom Input Forms on VAT company's Payable Invoice."
		# FFA.hold_base_data_and_wait
	end
  
  it "TID017332-Create,Save,Post payable invoice in Custom Input Form mode" do

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
	
	# #TST025839  - Verify that the reverse charge fields - Reverse charge,Output Tax Code ,Output Tax rate and Output Tax value are available to users in 	VAT companies default form.
    gen_start_test "TST025839 - Verify that the reverse charge fields - Reverse charge,Output Tax Code ,Output Tax rate and Output Tax value are available to users in 	VAT companies default form."
    begin
		_invoice_number = 'VIN#TST025839'
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
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
		
		CIF_PINV.click_payable_invoice_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.is_pinv_line_reverse_charge_checkbox_unchecked?
		_product_output_tax_code = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_output_tax_code_column_number
		_product_output_tax_rate = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_output_tax_rate_column_number
		_product_output_tax_value = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_output_tax_value_column_number
		gen_compare '', _product_output_tax_code, 'Comparing output text code on product line item'
		gen_compare '0.000', _product_output_tax_rate, 'Comparing output text rate on product line item'
		gen_compare '', _product_output_tax_value, 'Comparing output text value on product line item'
		gen_end_test "TST025839 - Verify that the reverse charge fields - Reverse charge,Output Tax Code ,Output Tax rate and Output Tax value are available to users in 	VAT companies default form."
	end	
	
	gen_start_test "TST025840 - Verify that user is able to post the PIN with reverse charges field through a default form in a VAT company."
    begin
		_invoice_number = 'VIN#TST025840'
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
		CIF_PINV.set_pinv_invoice_currency $bd_currency_usd
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
		CIF_PINV.set_pinv_expense_line_destination_company ''
		CIF_PINV.set_pinv_expense_line_dimesion_1 ''
		CIF_PINV.set_pinv_expense_line_dimesion_2 ''
		CIF_PINV.set_pinv_expense_line_line_description ''
		CIF_PINV.set_pinv_expense_line_net_value 50
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_input_tax_code $bd_tax_code_vi_s
		CIF_PINV.set_pinv_expense_line_input_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_input_tax_value '7.5', true
		CIF_PINV.click_pinv_expense_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_expense_line_output_tax_code $bd_tax_code_vo_ec_sales
		CIF_PINV.set_pinv_expense_line_output_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_output_tax_value '3.50', true
		
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_account_payable_control_eur
		CIF_PINV.set_pinv_expense_line_destination_company ''
		CIF_PINV.set_pinv_expense_line_dimesion_1 ''
		CIF_PINV.set_pinv_expense_line_dimesion_2 ''
		CIF_PINV.set_pinv_expense_line_line_description ''
		CIF_PINV.set_pinv_expense_line_net_value 40
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_input_tax_code $bd_tax_code_vi_s, 2
		CIF_PINV.set_pinv_expense_line_input_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_input_tax_value '6', true
		CIF_PINV.click_pinv_expense_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_expense_line_output_tax_code $bd_tax_code_vo_ec_sales
		CIF_PINV.set_pinv_expense_line_output_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_output_tax_value '2.80', true
		CIF.wait_for_totals_to_calculate
		
		CIF_PINV.click_payable_invoice_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.set_pinv_line_product $bd_product_bbk_fuel_pump_power_plus_series_universal
		CIF_PINV.set_pinv_line_destination_company ''
		CIF_PINV.set_pinv_line_quantity 4
		CIF_PINV.set_pinv_line_unit_price 100
		CIF_PINV.set_pinv_line_input_tax_code $bd_tax_code_tax_code_is 
		CIF_PINV.set_pinv_line_input_tax_rate '', false
		CIF_PINV.set_pinv_line_input_tax_value 100, true
		CIF_PINV.click_pinv_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_line_output_tax_code $bd_tax_code_vi_s
		CIF_PINV.set_pinv_line_output_tax_rate '', false
		CIF_PINV.set_pinv_line_output_tax_value '60', true
		CIF.wait_for_totals_to_calculate
		
		CIF_PINV.set_pinv_line_product $bd_product_auto1_com_clutch_kit_1989_dodge_raider
		CIF_PINV.set_pinv_line_destination_company ''
		CIF_PINV.set_pinv_line_quantity 5
		CIF_PINV.set_pinv_line_unit_price 100
		CIF_PINV.set_pinv_line_input_tax_code $bd_tax_code_vo_ec_sales , 2
		CIF_PINV.set_pinv_line_input_tax_rate '', false
		CIF_PINV.set_pinv_line_input_tax_value '35', true
		CIF_PINV.click_pinv_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_line_output_tax_code $bd_tax_code_tax_code_is
		CIF_PINV.set_pinv_line_output_tax_rate '', false
		CIF_PINV.set_pinv_line_output_tax_value '125.00', true
		CIF.wait_for_totals_to_calculate
		CIF_PINV.click_pinv_save_post_button
		CIF.wait_for_buttons_to_load
		CIF_PINV.compare_pinv_header_details(nil, nil, nil, '990.00', '-42.80', '947.20', 'Complete')
		gen_end_test "TST025840 - Verify that user is able to post the PIN with reverse charges field through a default form in a VAT company."
	end
    
	gen_start_test "TST025843 - Verify that user gets an error if it set reverse charge true but not provide any of the tax code or tax value for output tax code."
    begin
		_invoice_number = 'VIN#TST025843'
		_sencha_pop_up_error_message_TST025843 = 'Failed to post transaction: When applying a reverse charge, you must provide both an input and an output tax code and tax value. Expense Line: 1'
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
		CIF_PINV.set_pinv_invoice_currency $bd_currency_usd
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		CIF_PINV.click_new_row
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
		CIF_PINV.set_pinv_expense_line_destination_company ''
		CIF_PINV.set_pinv_expense_line_dimesion_1 ''
		CIF_PINV.set_pinv_expense_line_dimesion_2 ''
		CIF_PINV.set_pinv_expense_line_line_description ''
		CIF_PINV.set_pinv_expense_line_net_value 50
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_input_tax_code $bd_tax_code_vi_s
		CIF_PINV.set_pinv_expense_line_input_tax_rate '', false
		CIF_PINV.set_pinv_expense_line_input_tax_value '7.5', true
		CIF_PINV.click_pinv_expense_line_reverse_charge_checkbox true
		CIF_PINV.set_pinv_expense_line_output_tax_code ''
		CIF_PINV.set_pinv_expense_line_output_tax_rate '', true
		CIF_PINV.set_pinv_expense_line_output_tax_value '', true
		CIF.wait_for_totals_to_calculate
		CIF_PINV.click_pinv_save_post_button
		gen_compare _sencha_pop_up_error_message_TST025843, FFA.get_sencha_popup_error_message, 'Error message found'
		FFA.sencha_popup_click_continue
		CIF_PINV.click_payable_invoice_enable_reverse_charge_checkbox false
		CIF.wait_for_totals_to_calculate
		CIF_PINV.click_pinv_save_post_button
		CIF.wait_for_buttons_to_load
		CIF_PINV.compare_pinv_header_details(nil, nil, nil, '50.00', '7.50', '57.50', 'Complete')
		gen_end_test "TST025843 - Verify that user gets an error if it set reverse charge true but not provide any of the tax code or tax value for output tax code."
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
		gen_end_test "TID017332 : TID verifies the reverse charge fields on default Custom Input Forms on VAT company's Payable Invoice."
	end
end