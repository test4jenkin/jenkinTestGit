#--------------------------------------------------------------------------------------------#
#	TID : TID014087
# 	Pre-Requisit: Org with basedata deployed, smoketest_data_setup
#  	Product Area: Create payable invoice and credit note on extended layout
# 	Story: 25284
#--------------------------------------------------------------------------------------------#

describe "Smoke Test - Accounting - Payables Invoices & Credit Notes", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		FFA.hold_base_data_and_wait
		gen_start_test "Payables Invoices & Credit Notes Smoke Test "
	end
	
	it "TID014087 Implemented : Create payable invoice and credit note on extended layout" do
		gen_start_test "TID014087 : Payable invoice and credit note creation on extended layout"
		
		_line_2 = 2
		_date_12_3_2015 = "12/03/2015"
		_tax_value_50 = "50.00"
		_net_value_120 = "120.00"
		_expected_quantity_1 = "1.000000"
		_expected_unit_price_89 = "89.40"
		_expected_tax_value_15_64 = "15.64"
		_expected_net_value_89 = "89.40"
		_manage_expense_line_net_value_100 = "100"
		_expected_manage_expense_line_tax_value_15 = "15.00"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		puts "Additional data required for TID014087"
		begin
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.edit_extended_layout $ffa_object_payable_invoice_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_payable_invoice_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_expense_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_system_administrator, $ffa_purchase_credit_note_extended_layout
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_expense_line_item_extended_layout
		end
		
		gen_start_test "TST018827 : Create new payable invoice with product and expanse line items"
		begin
			puts "1.1 : Create new payable invoice"
			begin
				SF.tab $tab_payable_invoices
				SF.click_button_new
				PINEXT.set_account $bd_account_audi
				PINEXT.set_copy_account_values true
				PINEXT.set_derive_due_date false
				PINEXT.set_due_date _date_12_3_2015
				PINEXT.set_derive_period true
				PINEXT.set_derive_currency true
				PINEXT.set_vendor_invoice_number "VIN1234"
				PINEXT.set_invoice_date _date_12_3_2015
				SF.click_button_save
				_invoice_number = PINEXT.get_invoice_number
				gen_compare $bd_document_status_in_progress, PINEXT.get_invoice_status, "Expected New payable invoice should be created successfully"
			end
			
			puts "1.2 : Create new payable invoice line item(product) and payable invoice expense line item"
			begin
				# Create new payable invoice line item(product)
				PINEXT.click_new_payable_invoice_line_item_button
				PINEXT.set_derive_unit_price_from_product true
				PINEXT.set_set_tax_code_to_default true
				PINEXT.set_product $bd_product_auto_com_clutch_kit_1989_dodge_raider
				PINEXT.set_derive_tax_rate_from_code true
				PINEXT.set_calculate_tax_value_from_rate false
				PINEXT.set_tax_value _tax_value_50
				SF.click_button_save
				_line_invoice_number = PINEXT.product_line_item_get_payable_invoice_number $bd_product_auto_com_clutch_kit_1989_dodge_raider
				gen_compare _invoice_number, _line_invoice_number, "Expected payable invoice line item is added successfully on payable invoice"
				PINEXT.click_payable_invoice_number # clicking on payable invoice number from line item shows it is added successfully to payable invoice
				# Create new payable invoice expense line item
				PINEXT.click_new_payable_invoice_expense_line_item_button
				PINEXT.set_derive_line_number true	
				PINEXT.set_set_gla_to_default true
				PINEXT.set_set_tax_code_to_default true
				PINEXT.set_input_tax_code $bd_tax_code_vo_r_purchase
				PINEXT.set_net_value _net_value_120
				PINEXT.set_derive_tax_rate_from_code true
				PINEXT.set_calculate_tax_value_from_rate true
				SF.click_button_save
				_expense_line_invoice_number = PINEXT.expense_line_item_get_payable_invoice_number $bd_gla_postage_and_stationery
				gen_compare _invoice_number, _expense_line_invoice_number, "Expected payable invoice expense line item is added successfully on payable invoice"
				PINEXT.click_payable_invoice_number # clicking on payable invoice number from expense line item shows it is added successfully to payable invoice
			end
			
			puts "1.3 : Add product line through manage product lines UI"
			begin
				PINEXT.click_manage_product_lines_button
				SF.click_button $pinext_add_new_line_button
				PINEXT.manage_product_line_set_product _line_2, $bd_product_auto_com_clutch_kit_1989_dodge_raider
				_is_net_value_present = PINEXT.wait_until_net_value_appears _line_2, _expected_net_value_89
				gen_compare true, _is_net_value_present, "Expected Net Value to be 89.40 (autocomplete)"
				_quantity = PINEXT.manage_product_line_get_quantity _line_2
				_unit_price = PINEXT.manage_product_line_get_unit_price _line_2
				# rounding off the decimal values to 2
				_unit_price = gen_round_float_number _unit_price , 2
				_tax_code = PINEXT.manage_product_line_get_input_tax_code _line_2
				_product_line_tax_value = PINEXT.manage_line_get_tax_value _line_2
				gen_compare _expected_quantity_1, _quantity, "Expected Quantity to be 1 (autocomplete)"
				gen_compare _expected_unit_price_89, _unit_price, "Expected Unit Price to be 89.4 (autocomplete)"
				gen_compare $bd_tax_code_vo_std_purchase, _tax_code, "Expected Input Tax Code to be VO-STD Purchase (autocomplete)"
				gen_compare _expected_tax_value_15_64, _product_line_tax_value, "Expected TaxValue to be 15.64 (autocomplete)"
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PINEXT.within_product_line_section do
					within(:xpath,$pinext_product_line_item_section) do
						expect(page).to have_link($bd_product_auto_com_clutch_kit_1989_dodge_raider, :count => 2)
						gen_report_test "Expected a new product line item to be saved successfully and total count to be increased to 2"
					end
				end
			end
			
			puts "1.4 : Add expense line through manage expense line UI"
			begin
				PINEXT.click_manage_expense_lines_button
				SF.click_button $pinext_add_new_line_button
				PINEXT.manage_expense_line_set_gla _line_2, $bd_gla_postage_and_stationery
				PINEXT.manage_line_set_input_tax_code _line_2, $bd_tax_code_vo_s
				PINEXT.manage_expense_line_set_net_value _line_2, _manage_expense_line_net_value_100
				_expense_line_tax_value = PINEXT.manage_line_get_tax_value _line_2
				gen_compare _expected_manage_expense_line_tax_value_15, _expense_line_tax_value, "Expected TaxValue to be 15.00 (autocomplete)"
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PINEXT.within_expense_line_section do
					within(:xpath,$pinext_expense_line_item_section) do
						expect(page).to have_link($bd_gla_postage_and_stationery, :count => 2)
						gen_report_test "Expected a new expense line item to be saved successfully and total count to be increased to 2"
					end
				end
			end
		end
		
		gen_start_test "TST018828 Implemented : New payable credit note with product and expense line items"
		begin
			puts "1.1 : Create new payable credit note"
			begin
				SF.tab $tab_payable_credit_notes
				SF.click_button_new
				PCREXT.set_account $bd_account_audi
				PCREXT.set_copy_account_values true
				PCREXT.set_derive_due_date false
				PCREXT.set_due_date _date_12_3_2015
				PCREXT.set_derive_period true
				PCREXT.set_derive_currency true
				PCREXT.set_vendor_credit_note_number "VIN1234"
				PCREXT.set_credit_note_date _date_12_3_2015
				SF.click_button_save
				SF.wait_for_search_button
				_credit_note_number = PCREXT.get_credit_note_number
				gen_compare $bd_document_status_in_progress, PCREXT.get_credit_note_status, "Expected New payable credit note to be created successfully"
			end
			
			puts "1.2 : Create new payable credit note line item(product) and payable credit note expense line item"
			begin
				# Create new payable credit note line item(product)
				PCREXT.click_new_payable_credit_note_line_item_button
				PCREXT.set_product $bd_product_auto_com_clutch_kit_1989_dodge_raider
				PCREXT.set_derive_unit_price_from_product true
				PCREXT.set_set_tax_code_to_default true
				PCREXT.set_derive_tax_rate_from_code true
				PCREXT.set_calculate_tax_value_from_rate false
				PCREXT.set_tax_value _tax_value_50
				SF.click_button_save
				SF.wait_for_search_button
				_prod_line_credit_note_number = PCREXT.product_line_item_get_credit_note_number $bd_product_auto_com_clutch_kit_1989_dodge_raider
				gen_compare _credit_note_number, _prod_line_credit_note_number, "Expected payable credit note line item is added successfully on payable credit note"
				PCREXT.click_payable_credit_note_number # clicking on payable credit note number from line item shows it is added successfully to payable credit note
				# Create new payable invoice expense line item
				PCREXT.click_new_payable_credit_note_expense_line_item_button
				PCREXT.set_derive_line_number true
				PCREXT.set_net_value _net_value_120
				PCREXT.set_set_gla_to_default true
				PCREXT.set_set_tax_code_to_default true
				PCREXT.set_input_tax_code $bd_tax_code_vo_r_purchase
				PCREXT.set_derive_tax_rate_from_code true
				PCREXT.set_calculate_tax_value_from_rate true
				SF.click_button_save
				_expense_line_credit_note_number = PCREXT.expense_line_item_get_credit_note_number $bd_gla_postage_and_stationery
				gen_compare _credit_note_number, _expense_line_credit_note_number, "Expected payable credit note expense line item is added successfully on payable credit note"
				PCREXT.click_payable_credit_note_number # clicking on payable credit note number from expense line item shows it is added successfully to payable credit note
			end
			
			puts "1.3 : Add product line through manage product lines UI"
			begin
				PCREXT.click_manage_product_lines_button
				SF.click_button $pcrext_add_new_line_button
				PCREXT.manage_product_line_set_product _line_2, $bd_product_auto_com_clutch_kit_1989_dodge_raider
				_is_net_value_present = PCREXT.wait_until_net_value_appears _line_2, _expected_net_value_89
				gen_compare true, _is_net_value_present, "Expected Net Value to be 89.40 (autocomplete)"
				_quantity = PCREXT.manage_product_line_get_quantity _line_2
				_unit_price = PCREXT.manage_product_line_get_unit_price _line_2
				_tax_code = PCREXT.manage_product_line_get_input_tax_code _line_2
				_product_line_tax_value = PCREXT.manage_line_get_tax_value _line_2
				# rounding off the decimal values to 2
				_unit_price = gen_round_float_number _unit_price , 2
				gen_compare _expected_quantity_1, _quantity, "Expected Quantity to be 1 (autocomplete)"
				gen_compare _expected_unit_price_89, _unit_price, "Expected Unit Price to be 89.4 (autocomplete)"
				gen_compare $bd_tax_code_vo_std_purchase, _tax_code, "Expected Input Tax Code to be VO-STD Purchase (autocomplete)"
				gen_compare _expected_tax_value_15_64, _product_line_tax_value, "Expected TaxValue to be 15.64 (autocomplete)"
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PCREXT.within_product_line_section do
					within(:xpath,$pcrext_product_line_item_section) do
						expect(page).to have_link($bd_product_auto_com_clutch_kit_1989_dodge_raider, :count => 2)
						gen_report_test "Expected a new product line item to be saved successfully and total count of product lines to be increased to 2"
					end
				end
			end
			
			puts "1.4 : Add expense line through manage expense line UI"
			begin
				PCREXT.click_manage_expense_lines_button
				SF.click_button $pcrext_add_new_line_button
				PCREXT.manage_expense_line_set_gla _line_2, $bd_gla_postage_and_stationery
				PCREXT.manage_line_set_input_tax_code _line_2, $bd_tax_code_vo_s
				PCREXT.manage_expense_line_set_net_value _line_2, _manage_expense_line_net_value_100
				_expense_line_tax_value = PCREXT.manage_line_get_tax_value _line_2
				gen_compare _expected_manage_expense_line_tax_value_15, _expense_line_tax_value, "Expected TaxValue to be 15.00 (autocomplete)"
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PCREXT.within_expense_line_section do
					within(:xpath,$pcrext_expense_line_item_section) do
						expect(page).to have_link($bd_gla_postage_and_stationery, :count => 2)
						gen_report_test "Expected a new expense line item to be saved successfully and total count to be increased to 2"
					end
				end
			end
		end
		gen_end_test "TID014087 : Payable invoice and credit note creation on extended layout"
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		puts "Revert additional data setup"
		begin
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_layout
			SF.edit_extended_layout $ffa_object_payable_invoice_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_line_item_layout
			SF.edit_extended_layout $ffa_object_payable_invoice_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_expense_line_item_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_system_administrator, $ffa_purchase_credit_note_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_line_item_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_expense_line_item_layout
		
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_edit
			
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_new
	
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_view

			SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
			SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_edit
			
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
			SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_new
			
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
			SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_view
		end
		gen_end_test "Payables Invoices & Credit Notes Smoke Test "
		SF.logout 
	end
end