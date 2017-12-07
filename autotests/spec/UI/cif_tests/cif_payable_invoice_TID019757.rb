#--------------------------------------------------------------------#
#   TID : TID019757
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF
#   driver=firefox rspec spec/UI/cif_tests/cif_payable_invoice_TID019757.rb -fh -o pin_ext.html
#--------------------------------------------------------------------#

describe "TID019757 : Line number field is available now on CIF pages of payable invoice records.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID019757: TID verifies that line number field is available now on CIF pages of payable invoice records."
	end
  
	it "TST032020: Verify that Line number field is available now on CIF pages of payable invoice records." do

	_line_number_column_header = 'Line Number'
	
    # Login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_gb],true

    gen_start_test "TST032020 A. - Line number field is available on Product Line Item tab"
	begin
		_invoice_number = 'VIN#TST032020A'
		
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF_PINV.set_pinv_account $bd_account_apex_eur_account
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
		CIF_PINV.click_payable_invoice_line_items_tab
		
		#Verify Line Number column is visible on Product Line Item tab (New page)
		page.has_text?($_line_number_column_header)
		CIF.click_toggle_button
		#add line item 1 
		CIF_PINV.click_new_row
		CIF_PINV.set_pinv_line_product $bd_product_champagne
		CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_quantity_column_number
		CIF_PINV.set_pinv_line_quantity 1
		CIF_PINV.set_pinv_line_unit_price "50"
		
		#add line item 2
		CIF_PINV.click_new_row
		CIF_PINV.click_column_grid_data_row 2, $cif_payable_invoice_line_item_product_column_number		
		CIF_PINV.set_pinv_line_product $bd_product_a4_paper
		CIF_PINV.click_column_grid_data_row 2, $cif_payable_invoice_line_item_quantity_column_number
		CIF_PINV.set_pinv_line_quantity 1
		CIF_PINV.set_pinv_line_unit_price "200"
		
		#add line item 3
		CIF_PINV.click_new_row
		CIF_PINV.click_column_grid_data_row 3, $cif_payable_invoice_line_item_product_column_number	
		CIF_PINV.set_pinv_line_product $bd_product_auto_com_clutch_kit_1989_dodge_raider
		CIF_PINV.click_column_grid_data_row 3, $cif_payable_invoice_line_item_quantity_column_number
		CIF_PINV.set_pinv_line_quantity 1
		CIF_PINV.set_pinv_line_unit_price "300"
		
		#add line item 4
		CIF_PINV.click_new_row		
		CIF_PINV.click_column_grid_data_row 4, $cif_payable_invoice_line_item_product_column_number
		CIF_PINV.set_pinv_line_product $bd_product_dell_pc
		CIF_PINV.click_column_grid_data_row 4, $cif_payable_invoice_line_item_quantity_column_number
		CIF_PINV.set_pinv_line_quantity 1
		CIF_PINV.set_pinv_line_unit_price "400"
				
		_line_number_row_1 = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_1 = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_product_column_number
		_line_number_row_2 = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_2 = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_line_item_product_column_number
		_line_number_row_3 = CIF_PINV.get_column_value_from_grid_data_row 3, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_3 = CIF_PINV.get_column_value_from_grid_data_row 3, $cif_payable_invoice_line_item_product_column_number
		_line_number_row_4 = CIF_PINV.get_column_value_from_grid_data_row 4, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_4 = CIF_PINV.get_column_value_from_grid_data_row 4, $cif_payable_invoice_line_item_product_column_number
		
		#Comparing values
		gen_compare '1', _line_number_row_1, 'Comparing Row Number 1'
		gen_compare $bd_product_champagne, _product_row_1, 'Comparing Product of Row Number 1'
		gen_compare '2', _line_number_row_2, 'Comparing Row Number 2'
		gen_compare $bd_product_a4_paper, _product_row_2, 'Comparing Product of Row Number 2'
		gen_compare '3', _line_number_row_3, 'Comparing Row Number 3'
		gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, _product_row_3, 'Comparing Product of Row Number 3'
		gen_compare '4', _line_number_row_4, 'Comparing Row Number 4'
		gen_compare $bd_product_dell_pc, _product_row_4, 'Comparing Product of Row Number 4'
		
		#Deleting rows
		CIF_PINV.delete_row 1
		CIF_PINV.delete_row 3
		
		_line_number_row_1_after_delete = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_1_after_delete = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_line_item_product_column_number
		_line_number_row_2_after_delete = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_2_after_delete = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_line_item_product_column_number
		
		#Comparing Values after delete
		gen_compare '1', _line_number_row_1_after_delete, 'Row Number 1 auto arrange after delete'
		gen_compare $bd_product_a4_paper, _product_row_1_after_delete, 'Comparing Product of Row Number 1 after delete'
		gen_compare '2', _line_number_row_2_after_delete, 'Row Number 2 auto arrange after delete'
		gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, _product_row_2_after_delete, 'Comparing Product of Row Number 2 after delete'
		
		#Save and Post Payable Invoice
		CIF_PINV.click_pinv_save_post_button
		SF.wait_for_search_button
		page.has_text?($bd_product_a4_paper)
		#Verify Line Number column is visible on Product Line Item tab (View page)
		CIF_PINV.click_payable_invoice_line_items_tab
		page.has_text?($_line_number_column_header)
		
		_line_number_row_1_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 1, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_1_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 1, $cif_payable_invoice_line_item_product_column_number
		_line_number_row_2_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 2, $cif_payable_invoice_line_item_line_number_column_number
		_product_row_2_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 2, $cif_payable_invoice_line_item_product_column_number
		
		#Comparing Values
		gen_compare '1', _line_number_row_1_view, 'Row Number 1 on view page'
		gen_compare $bd_product_a4_paper, _product_row_1_view, 'Comparing Product of Row Number 1 on View page'
		gen_compare '2', _line_number_row_2_view, 'Row Number 2 on view page'
		gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider, _product_row_2_view, 'Comparing Product of Row Number 2 on View page'
				
		gen_end_test "TST032020 A. - Line number field is available on Product Line Item tab"
	end
	
	gen_start_test "TST032020 B. - Line number field is available on Expense Line Item tab"
	begin
		_invoice_number = 'VIN#TST032020B'
		
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF_PINV.set_pinv_account $bd_account_apex_eur_account
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		
		#Verify Line Number column is visible on Product Line Item tab (New page)
		page.has_text?($_line_number_column_header)
		CIF.click_toggle_button
		#add line item 1 
		CIF_PINV.click_new_row
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
		CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_expense_line_net_value_column_number
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_net_value 50
		
		#add line item 2 
		CIF_PINV.click_new_row
		CIF_PINV.click_column_grid_data_row 2, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_sales_parts
		CIF_PINV.click_column_grid_data_row 2, $cif_payable_invoice_expense_line_net_value_column_number
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_net_value 100
		
		#add line item 3 
		CIF_PINV.click_new_row
		CIF_PINV.click_column_grid_data_row 3, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_stock_parts
		CIF_PINV.click_column_grid_data_row 3, $cif_payable_invoice_expense_line_net_value_column_number
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_net_value 150
		
		#add line item 4 
		CIF_PINV.click_new_row
		CIF_PINV.click_column_grid_data_row 4, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_marketing
		CIF_PINV.click_column_grid_data_row 4, $cif_payable_invoice_expense_line_net_value_column_number
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_net_value 200
		CIF.click_toggle_button
		_line_number_row_1 = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_1 = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		_line_number_row_2 = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_2 = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		_line_number_row_3 = CIF_PINV.get_column_value_from_grid_data_row 3, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_3 = CIF_PINV.get_column_value_from_grid_data_row 3, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		_line_number_row_4 = CIF_PINV.get_column_value_from_grid_data_row 4, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_4 = CIF_PINV.get_column_value_from_grid_data_row 4, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		
		#Comparing values
		gen_compare '1', _line_number_row_1, 'Comparing Row Number 1'
		gen_compare $bd_gla_postage_and_stationery, _GLA_row_1, 'GLA Product of Row Number 1'
		gen_compare '2', _line_number_row_2, 'Comparing Row Number 2'
		gen_compare $bd_gla_sales_parts, _GLA_row_2, 'Comparing GLA of Row Number 2'
		gen_compare '3', _line_number_row_3, 'Comparing Row Number 3'
		gen_compare $bd_gla_stock_parts, _GLA_row_3, 'Comparing GLA of Row Number 3'
		gen_compare '4', _line_number_row_4, 'Comparing Row Number 4'
		gen_compare $bd_gla_marketing, _GLA_row_4, 'Comparing GLA of Row Number 4'
		
		CIF_PINV.delete_row 1
		CIF_PINV.delete_row 3
		
		_line_number_row_1_after_delete = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_1_after_delete = CIF_PINV.get_column_value_from_grid_data_row 1, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		_line_number_row_2_after_delete = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_2_after_delete = CIF_PINV.get_column_value_from_grid_data_row 2, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		
		#Comparing Values
		gen_compare '1', _line_number_row_1_after_delete, 'Row Number 1 auto arrange after delete'
		gen_compare $bd_gla_sales_parts, _GLA_row_1_after_delete, 'Comparing GLA of Row Number 1 after delete'
		gen_compare '2', _line_number_row_2_after_delete, 'Row Number 2 auto arrange after delete'
		gen_compare $bd_gla_stock_parts, _GLA_row_2_after_delete, 'Comparing GLA of Row Number 2 after delete'
		
		#Save and Post Payable Invoice
		CIF_PINV.click_pinv_save_post_button
		
		#Verify Line Number column is visible on Expense line tab (View page)
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		page.has_text?($_line_number_column_header)
		
		_line_number_row_1_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 1, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_1_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 1, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		_line_number_row_2_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 2, $cif_payable_invoice_expense_line_line_number_column_number
		_GLA_row_2_view = CIF_PINV.get_column_value_from_grid_data_row_on_view_page 2, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		
		#Comparing Values
		gen_compare '1', _line_number_row_1_view, 'Row Number 1 on view page'
		gen_compare $bd_gla_sales_parts, _GLA_row_1_view, 'Comparing GLA of Row Number 1 on View page'
		gen_compare '2', _line_number_row_2_view, 'Row Number 2 on view page'
		gen_compare $bd_gla_stock_parts, _GLA_row_2_view, 'Comparing GLA of Row Number 2 on View page'
				
		gen_end_test "TST032020 B. - Line number field is available on Expense Line Item tab"
	end
	end	
	
	after :all do
		#Delete new data
		login_user
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID019757: TID verifies that line number field is available now on CIF pages of payable invoice records."
	end
end