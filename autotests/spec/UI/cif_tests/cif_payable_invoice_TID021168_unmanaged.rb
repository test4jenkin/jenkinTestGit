#--------------------------------------------------------------------#
#   TID : TID021168 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_payable_invoice_TID021168.rb -fh -o cif_payable_invoice_TID021168.html
#--------------------------------------------------------------------#

describe "TID021168 - Copy line functionality for Payable Invoice on CIF", :type => :request do
	include_context "login"	
	include_context "logout_after_each"
	_PINV_REFERENCE = "VIN#TID021168"
	_vendor_invoice_number_column_name = 'Vendor Invoice Number'
	_payable_invoice_number_column = 'Payable Invoice Number'
	_expense_line_desc = 'Expense Line Description'
	_product_line_desc = 'Product Line Description'
	_expected_net_value = '200.00'
	_expected_tax_rate = '17.500'
	_expected_tax_value = '35.00'
	_expected_quantity = '1.000000'
	_expected_unit_price = '200.000000000'
	
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait	
	end
	it "TID021168 - Checks Copy line functionality for Payable Invoice on CIF layout", :unmanaged => true do
		begin
			_create_data = ["CODATID021168Data.selectCompany();", "CODATID021168Data.createData();"]
			APEX.execute_commands _create_data
		end
		gen_start_test "TST036428 - Verify copy line functionality for Payable Invoice"
		begin		
			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_payable_invoice_number = FFA.get_column_value_in_grid _vendor_invoice_number_column_name, _PINV_REFERENCE, _payable_invoice_number_column
            PIN.open_invoice_detail_page _payable_invoice_number
			CIF.click_edit_button
			CIF.click_toggle_button
			CIF_PINV.click_payable_invoice_expense_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_expense_line_gla $bd_gla_sales_parts
			CIF_PINV.set_pinv_expense_line_net_value 400,4
			#Copying second line
			CIF.copy_row 2
			#Verify GLA on the cloned expense line
			_actual_gla_value = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_general_ledger_account_column_number
			gen_compare $bd_gla_sales_parts, _actual_gla_value, "Expected GLA is Sales - Parts"
			#Verify Dimension 1 on the cloned expense line
			_actual_dimension1 = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_dimension1_column_number
			gen_compare $bd_dim1_eur, _actual_dimension1, "Expected Dimension 1 is Dim 1 EUR"
			#Verify Dimension 2 on the cloned expense line
			_actual_dimension2 = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_dimension2_column_number
			gen_compare $bd_dim2_eur, _actual_dimension2, "Expected Dimension 2 is Dim 2 EUR"
			#Verify Line Description on the cloned expense line
			_actual_line_desc = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_description_column_number
			gen_compare _expense_line_desc, _actual_line_desc, "Expected line description is Expense Line Description"
			#Verify Net Value on the cloned expense line
			_actual_net_value = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_net_value_column_number			
			gen_compare _expected_net_value, _actual_net_value, "Expected net value 200.00"
			#Verify Tax code on the cloned expense line
			_actual_tax_code = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_input_tax_code_column_number
			gen_compare $bd_tax_code_vo_std_purchase, _actual_tax_code, "Expected tax code is VO-STD Purchase"
			#Verify Tax Rate on the cloned expense line
			_actual_tax_rate = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_input_tax_rate_column_number
			gen_compare _expected_tax_rate, _actual_tax_rate, "Expected tax rate is 17.500"
			#Verify Tax Value on the cloned expense line
			_actual_tax_value = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_expense_line_input_tax_value_column_number
			gen_compare _expected_tax_value, _actual_tax_value, "Expected tax value is 35.00"
			
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_line_product $bd_product_a4_paper
			CIF_PINV.set_pinv_line_unit_price 400,4
			CIF.copy_row 2
			#Verify Product on the cloned product line
			_actual_product = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_product_column_number
			gen_compare $bd_product_a4_paper, _actual_product, "Expected product is A4 Paper"
			#Verify Quantity on the cloned product line
			_actual_quantity = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_quantity_column_number
			gen_compare _expected_quantity, _actual_quantity, "Expected quantity is 1.000000"
			#Verify unit price on the cloned product line 
			_actual_unit_price = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_unit_price_column_number
			gen_compare _expected_unit_price, _actual_unit_price, "Expected unit price 200.000000000"
			#Verify Dimension1 on the cloned product line
			_actual_product_dimension1 = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_dimension1_column_number
			gen_compare $bd_dim1_eur, _actual_product_dimension1, "Expected Dimension1 is Dim 1 EUR"
			#Verify Dimension2 on the cloned product line
			_actual_product_dimension2 = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_dimension2_column_number
			gen_compare $bd_dim2_eur, _actual_product_dimension2, "Expected Dimension1 is Dim 2 EUR"
			#Verify Line Description on the cloned product line
			_actual_product_line_desc = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_line_description_column_number
			gen_compare _product_line_desc, _actual_product_line_desc, "Expected line description is Product Line Description"
			#Verify Tax Code on the cloned product line
			_actual_product_tax_code = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_input_tax_code_column_number
			gen_compare $bd_tax_code_vo_std_purchase, _actual_product_tax_code, "Expected tax code is VO-STD Purchase"
			#Verify Tax Rate on the cloned product line
			_actual_product_tax_rate = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_input_tax_rate_column_number
			gen_compare _expected_tax_rate, _actual_product_tax_rate, "Expected tax rate is 17.500"
			#Verify Tax Value on the cloned product line
			_actual_product_tax_value = CIF_PINV.get_column_value_from_grid_data_row 3,$cif_payable_invoice_line_item_input_tax_value_column_number
			gen_compare _expected_tax_value, _actual_product_tax_value, "Expected tax value is 35.00"
			#Verify Net Total, Tax Total and Invoice total on Payable Invoice Header before Save
			CIF_PINV.compare_pinv_header_details(nil,nil,nil,'2,400.00','280.00','2,680.00',nil)
			
			CIF_PINV.click_pinv_save_post_button
			CIF.click_toggle_button
			CIF_PINV.click_payable_invoice_expense_line_items_tab
			#Verify line numbers for expense lines
			_actual_line_number_for_line1 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 1,$cif_payable_invoice_expense_line_line_number_column_number
			gen_compare '1', _actual_line_number_for_line1, "Expected line number 1"
			_actual_line_number_for_line2 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 2,$cif_payable_invoice_expense_line_line_number_column_number
			gen_compare '2', _actual_line_number_for_line2, "Expected line number 2"
			_actual_line_number_for_line3 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 3,$cif_payable_invoice_expense_line_line_number_column_number
			gen_compare '3', _actual_line_number_for_line3, "Expected line number 3"
			_actual_line_number_for_line4 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 4,$cif_payable_invoice_expense_line_line_number_column_number
			gen_compare '4', _actual_line_number_for_line4, "Expected line number 4"
			_actual_line_number_for_line5 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 5,$cif_payable_invoice_expense_line_line_number_column_number
			gen_compare '5', _actual_line_number_for_line5, "Expected line number 5"
			#Verify line numbers for product lines
			CIF_PINV.click_payable_invoice_line_items_tab
			_actual_line_number_for_line1 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 1,$cif_payable_invoice_line_item_line_number_column_number
			gen_compare '1', _actual_line_number_for_line1, "Expected line number 1"
			_actual_line_number_for_line2 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 2,$cif_payable_invoice_line_item_line_number_column_number
			gen_compare '2', _actual_line_number_for_line2, "Expected line number 2"
			_actual_line_number_for_line3 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 3,$cif_payable_invoice_line_item_line_number_column_number
			gen_compare '3', _actual_line_number_for_line3, "Expected line number 3"
			_actual_line_number_for_line4 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 4,$cif_payable_invoice_line_item_line_number_column_number
			gen_compare '4', _actual_line_number_for_line4, "Expected line number 4"
			_actual_line_number_for_line5 = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 5,$cif_payable_invoice_line_item_line_number_column_number
			gen_compare '5', _actual_line_number_for_line5, "Expected line number 5"
			#Verify Net Total, Tax Total and Invoice total on Payable Invoice Header after Save&Post
			CIF_PINV.compare_pinv_header_details(nil,nil,nil,'2,400.00','280.00','2,680.00',nil)
			CIF.click_toggle_button
			gen_end_test "TST036428 - Check copy line functionality for PIN"
		end		
	end
	after :all do
		login_user
		_destroy_data_TID021168 = ["CODATID021168Data.destroyData();"]
		APEX.execute_commands _destroy_data_TID021168
		SF.logout
		gen_end_test "TID021168: Verify Copy line functionality for Payable Invoice on CIF"    
	end
end