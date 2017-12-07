#--------------------------------------------------------------------#
#   TID : TID020706
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: Sales invoice CIF
#   driver=firefox rspec spec/UI/cif_tests/cif_sales_invoice_TID020706.rb -fh -o sales_ext_TID020706.html
#--------------------------------------------------------------------#

describe "TID020706-verifies that price book search functionality on Sales invoice document on CIF UI.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
  _price_book_search_label = 'Price Book Search'
  _search_box_label = 'Enter part of product name or code to search:'
  _product_name_label = 'Apex Product 001'
  _product1_code_label = 'ACR3E75013'
  _product2_code_label = 'ACR3E75013H1'
  _product3_code_label = 'APEXPROD001'
  _priceBookName_label = 'Standard Price Book'
  _product1_price_label = '£74.50'
  _product2_price_label = '£15.00'
  _addProductLine_toast_message = 'Auto Com Clutch Kit 1989 Dodge Raider was added to your document.'
  _addMultiple_ProductLines_toast_message = '1 items were added to your document.'
  _currency_not_populated_error = "Select the document currency on the header then click Add from Price Book."
  _invalid_search_error = "Enter part of product name or code to search."
  _inline_search_grid_text = "Enter part of product name or code to search."
  _sales_invoice_Quantity_1 = '1.000000'
  _sales_invoice_Quantity_2 = '2.000000'
  
  
	before :all do
		#Hold Base Data
		gen_start_test "TID020706: TID verifies that price book search functionality on Sales invoice document on CIF UI."
		FFA.hold_base_data_and_wait
		# Activate the pricebook , On unmanage- It is activated through base data.
		if (ORG_TYPE == MANAGED)
			SF.tab $tab_price_book
			SF.click_button_go
			SF.wait_for_search_button
			FFA.activate_pricebook $bd_pricebook_standard_price_book , true
		end
	end
  
    it "Create a sales invoice and add new lines using add price-book functionality and post it using CIF UI" do
	
    # login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_spain],true

    # #TST034565  - Verify that Add from price book will get enabled, once user populate invoice currency on page by populating account.
    gen_start_test "TST034565 - Verify that Add from price book will get enabled, once user populate invoice currency on page by populating account."
    begin
		# Create Sales invoice
		SF.tab $tab_sales_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		CIF_SINV.click_sinv_add_from_price_book_button
		gen_compare _currency_not_populated_error, FFA.get_sencha_popup_error_message, 'Blank document currency on SINV Header'
		FFA.sencha_popup_click_continue
		
		CIF_SINV.set_sinv_account $bd_account_cambridge_auto
		CIF_SINV.click_sinv_add_from_price_book_button
		
		#Verify price book search window displayed to user	
		gen_compare _price_book_search_label,CIF_SINV.get_pricebook_search_popup_label,"Label is #{_price_book_search_label}"
		gen_compare _inline_search_grid_text,CIF_SINV.get_inline_text_search_products_grid,"Inline text is #{_inline_search_grid_text}"
		CIF_SINV.click_sinv_search_icon
		gen_compare _invalid_search_error, FFA.get_sencha_popup_error_message,"Blank search text on PriceBook Search Window "
		FFA.sencha_popup_click_continue
		CIF_SINV.click_sinv_price_book_search_popup_default_close_button
		gen_end_test "TST034565 - Verify that Add from price book will get enabled, once user populate invoice currency on page by populating account."
	end

	# #TST034569  - Verify addition of product line items to sales invoice line items through price book search window.
    gen_start_test "TST034569 - Verify addition of product line items to sales invoice line items through price book search window."
	
    begin
		# Create Sales invoice
		SF.tab $tab_sales_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		
		CIF_SINV.set_sinv_account $bd_account_cambridge_auto
		CIF_SINV.click_sinv_add_from_price_book_button
		
		gen_compare _price_book_search_label,CIF_SINV.get_pricebook_search_popup_label,"Label is #{_price_book_search_label}"
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_cancel_button
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_add_button).to be true
		gen_report_test "sales invoice pricebook seach popup add button not present - passed"
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_addAndClose_button).to be true
		gen_report_test "sales invoice pricebook seach popup add and close button not present - passed"
		CIF_SINV.set_price_book_search_box_value "au"
		CIF_SINV.click_sinv_search_icon
		
		#Verify the product values filtered and displayed in Price Book grid.
		gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 1,2) , 'Comparing Product Name in row 1 in PriceBook grid'
		gen_compare $bd_product_auto1_com_clutch_kit_1989_dodge_raider,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 2,2), 'Comparing Product Name in row 2 in PriceBook grid'
		gen_compare _product1_code_label,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 1,3), 'Comparing Product Code in row 1 in PriceBook grid'
		gen_compare _product2_code_label,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 2,3), 'Comparing Product Code in row 2 in PriceBook grid'
		gen_compare _priceBookName_label,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 1,4), 'Comparing Price Book Name in row 1 in PriceBook grid'
		gen_compare _priceBookName_label,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 2,4), 'Comparing Price Book Name in row 2 in PriceBook grid'
		gen_compare _product1_price_label,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 1,5), 'Comparing Price in row 1 in PriceBook grid'
		gen_compare _product1_price_label,(CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row 2,5), 'Comparing Price in row 2 in PriceBook grid'
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_cancel_button
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_add_button).to be true
		gen_report_test "sales invoice pricebook seach popup add button not present - passed"
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_addAndClose_button).to be true
		gen_report_test "sales invoice pricebook seach popup add and close button not present - passed"
		
		#Verify the addition of multiple product line items through price book search window on add button action
		CIF_SINV.check_column_value_from_search_grid_data_row 1,1
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_cancel_button
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_add_button
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_addAndClose_button
		CIF_SINV.click_sinv_price_book_search_popup_add_button
		gen_compare _addMultiple_ProductLines_toast_message, CIF_SINV.get_pricebook_toast_message, 'Toast message is matched.'
		CIF_SINV.click_sinv_price_book_search_popup_default_close_button
		
		#Verify the toast message displayed on adding multiple products through price book search window
		
		CIF.wait_for_totals_to_calculate
		CIF_SINV.compare_sinv_header_details(nil, nil, nil, '74.50', '13.04', '87.54', nil)
		gen_compare _sales_invoice_Quantity_1,(CIF_SINV.get_column_value_from_grid_data_row 1,4), 'comparing qunatity field of sales invoice line item'
		
		#Verify the addition of multiple product line items through price book search window on add and close button
		CIF_SINV.click_sinv_add_from_price_book_button
		CIF_SINV.set_price_book_search_box_value "au"
		CIF_SINV.click_sinv_search_icon
		CIF_SINV.check_column_value_from_search_grid_data_row 1,1
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_cancel_button
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_add_button
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_addAndClose_button
		CIF_SINV.click_sinv_price_book_search_popup_add_and_close_button
		
		#Verify the toast message displayed on adding multiple products through price book search window
		expect(page.has_no_css?($cif_sales_invoice_pricebook_search_grid)).to be true
		gen_report_test "sales invoice pricebook seach popup has been closed"
		gen_compare _addMultiple_ProductLines_toast_message, CIF_SINV.get_pricebook_toast_message, 'Toast message is matched.'
		CIF.wait_for_totals_to_calculate
		CIF_SINV.compare_sinv_header_details(nil, nil, nil, '149.00', '13.04', '162.04', nil)
		gen_compare _sales_invoice_Quantity_2,(CIF_SINV.get_column_value_from_grid_data_row 1,4), 'comparing qunatity field of sales invoice line item'
		
		#verify the view All link functionality of price book search grid
		CIF_SINV.click_sinv_add_from_price_book_button
		gen_compare _inline_search_grid_text,CIF_SINV.get_inline_text_search_products_grid,"Inline text is #{_inline_search_grid_text}"
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_cancel_button
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_add_button).to be true
		gen_report_test "sales invoice pricebook seach popup add button not present - passed"
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_addAndClose_button).to be true
		gen_report_test "sales invoice pricebook seach popup add and close button not present - passed"
		CIF_SINV.click_sinv_price_book_search_popup_view_all_link
		
		#verify that products loaded in price book search grid on view All action
		expect(page.has_no_css?($cif_sales_invoice_pricebook_search_popup_inlineText_label)).to be true
		gen_report_test "sales invoice pricebook seach popup is not empty"
		CIF_SINV.check_column_value_from_search_grid_data_row 1,1
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_cancel_button
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_add_button
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_addAndClose_button
		CIF_SINV.click_sinv_price_book_search_popup_add_and_close_button
		
		#verify the sales invoice line items in grid
		expect(page.has_no_css?($cif_sales_invoice_pricebook_search_grid)).to be true
		gen_report_test "sales invoice pricebook seach popup has been closed"
		gen_compare _addMultiple_ProductLines_toast_message, CIF_SINV.get_pricebook_toast_message, 'Toast message is matched.'
		CIF.wait_for_totals_to_calculate
		gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider,(CIF_SINV.get_column_value_from_grid_data_row 1,2) , 'Comparing Product Name in row 1 in PriceBook grid'
		gen_compare _product_name_label,(CIF_SINV.get_column_value_from_grid_data_row 2,2) , 'Comparing Product Name in row 2 in PriceBook grid'
		gen_compare _sales_invoice_Quantity_2,(CIF_SINV.get_column_value_from_grid_data_row 1,4), 'comparing qunatity field in row 1 of sales invoice line item'
		gen_compare _sales_invoice_Quantity_1,(CIF_SINV.get_column_value_from_grid_data_row 2,4), 'comparing qunatity field of in row 2 of sales invoice line item'
		CIF_SINV.compare_sinv_header_details(nil, nil, nil, '164.00', '13.04', '177.04', nil)
		
		#verify the recently added link functionality of price book search grid
		CIF_SINV.click_sinv_add_from_price_book_button
		gen_compare _inline_search_grid_text,CIF_SINV.get_inline_text_search_products_grid,"Inline text is #{_inline_search_grid_text}"
		gen_assert_enabled $cif_sales_invoice_pricebook_search_popup_cancel_button
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_add_button).to be true
		gen_report_test "sales invoice pricebook seach popup add button not present - passed"
		expect(CIF_SINV.is_item_disabled? $cif_sales_invoice_pricebook_search_popup_addAndClose_button).to be true
		gen_report_test "sales invoice pricebook seach popup add and close button not present - passed"
		CIF_SINV.click_sinv_price_book_search_popup_recently_added_link
		
		#verrify the items displaying in recently added grid
		gen_compare _product_name_label,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 1,2), 'Comparing product name in row 1 of recently added grid'
		gen_compare $bd_product_auto_com_clutch_kit_1989_dodge_raider,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 2,2), 'Comparing product name in row 2 of recently added grid'
		gen_compare _product3_code_label,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 1,3), 'Comparing product code in row 1 of recently added grid'
		gen_compare _product1_code_label,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 2,3), 'Comparing product code in row 2 of recently added grid'
		gen_compare _priceBookName_label,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 1,4), 'Comparing Price Book Name in row 1 of recently added grid'
		gen_compare _priceBookName_label,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 2,4), 'Comparing Price Book Name in row 2 of recently added grid'
		gen_compare _product2_price_label,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 1,5), 'Comparing Price in row 1 of recently added grid'
		gen_compare _product1_price_label,(CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row 2,5), 'Comparing Price in row 2 of recently added grid'
		
		CIF_SINV.check_column_value_from_recently_added_grid_data_row 2,1
		CIF_SINV.click_sinv_price_book_search_popup_add_and_close_button
		CIF.wait_for_totals_to_calculate
		CIF_SINV.compare_sinv_header_details(nil, nil, nil, '238.50', '13.04', '251.54', nil)
		
		#verify the cancel button functionality
		CIF_SINV.click_sinv_add_from_price_book_button
		CIF_SINV.click_sinv_price_book_search_popup_view_all_link
		CIF_SINV.click_sinv_price_book_search_popup_cancel_button
		gen_compare false,gen_is_object_visible($cif_sales_invoice_pricebook_search_popup),"Sales Invoice pricebook seach popup closed after clicking Cancel Button"
		
		#Post the sales invoice and verify the net total,tax total,invoice total and invoice status fields
		CIF_SINV.click_sinv_save_post_button
		gen_wait_until_object $cif_amend_button
		CIF_SINV.compare_sinv_header_details(nil, nil, nil, '238.50', '13.04', '251.54', 'Complete')
		
		gen_end_test "TST034569 - Verify addition of multiple product line items to sales invoice line items through price book search window."
	end
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
	end 
end 
