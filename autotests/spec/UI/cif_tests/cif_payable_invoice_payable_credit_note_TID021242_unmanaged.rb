#--------------------------------------------------------------------#
#   TID : TID021242 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_payable_invoice_payable_credit_note_TID021242.rb -fh -o cif_clone.html
#--------------------------------------------------------------------#

describe "TID021242: Verify cloning functionality from CIF view page for PIN/PCN", :type => :request do
	_SUFFIX = '#TID021242'
	_invoice_number = 'VIN#' + _SUFFIX
	_creditnote_number = 'VCN#' + _SUFFIX
	_cloned_number = 'Cloned' + _SUFFIX
	_note_message = 'Document to be cloned' + _SUFFIX
	_todays_date = Date.today
	_due_date = _todays_date + 1
	_period = _todays_date.strftime("%Y") + "/0" + _todays_date.strftime("%m")
	_not_applicable_label = 'Not Applicable'
	_expenseline_description = 'Expense Line Description'
	_productline_description = 'Product Line Description'
	_invoice_description = 'Invoice Description#TID021242'
	_creditnote_description = 'Credit Note Descritpion#TID021242'
	
	include_context "login"
	include_context "logout_after_each"
    before :all do
        gen_start_test "TID021242: Verify cloning functionality from CIF view page for PIN/PCN"
        begin
			SF.app $accounting
			#Create Data
            _create_data = ["CODATID021242Data.selectCompany();", "CODATID021242Data.createData();","CODATID021242Data.createDataExt1();","CODATID021242Data.createDataExt2();","CODATID021242Data.createDataExt3();","CODATID021242Data.createDataExt4();","CODATID021242Data.switchCompany(CODABaseData.NAMECOMPANY_MERLINAUTOSPAIN);"]
            APEX.execute_commands _create_data
        end
    end
    
    it "TID021242 : Verify cloning functionality from CIF view page for PIN", :unmanaged => true  do
        begin
			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_invoice_number = FFA.get_column_value_in_grid $label_vendor_invoice_number,_invoice_number,$label_payable_invoice_number
            PIN.open_invoice_detail_page _payable_invoice_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			gen_compare_object_visible $cif_clone_button, true, "Expected Clone button present on UI"
            gen_report_test "TST036783_A: Verify that Clone button is added by default on CIF view page for PIN"
			
			#Note creation
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			CIF.create_new_note_in_related_list _note_message,nil
			CIF.click_post_button
			gen_compare $bd_document_status_complete, CIF_PINV.get_payable_invoice_status, "Expected Payable Invoice Status should be completed"
			
			CIF.click_clone_button
			gen_compare $cif_msg_clone_document, CIF.get_header_toast_message, 'Toast message is matched.'
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			gen_report_test "TST036786_A: Verify that toast message is displayed on the newly created cloned PIN"
			CIF_PINV.set_pinv_vendor_invoice_number _cloned_number
			CIF_PINV.click_pinv_save_button
			
			#Verifying Related List to be Blank
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected Notes record is not cloned"
			CIF.click_to_collapse_related_list_toolbar_view
			gen_report_test "TST036787_A: Verify that related lists are not cloned."
			
			gen_compare _cloned_number, CIF_PINV.get_payable_invoice_vendor_inv_number, "Expected Vendor Invoice Number is updated"
			gen_report_test "TST036795_A: Verify that user can update the cloned fields."
			
			gen_compare '0.00', CIF_PINV.get_payable_invoice_outstanding_value, "Expected Outstanding Value to be 0.00"
			gen_report_test "TST036796_A: Verify that Outstanding Value is 0 on cloning a PIN"
			
			#Verifying Header Details
			gen_compare $bd_account_apex_eur_account, CIF_PINV.get_payable_invoice_account_name , "Expected Account Name is cloned"
			gen_compare _due_date.strftime("%d/%m/%Y"), CIF_PINV.get_payable_invoice_due_date , "Expected Due Date is cloned"
			gen_compare true, CIF_PINV.is_pinv_enable_reverse_charge_checkbox_checked? , "Expected Reverse Charge checkbox is cloned"
			gen_compare _invoice_description, CIF_PINV.get_payable_invoice_description, "Expected Payable Invoice Description is cloned"
			gen_compare "", CIF_PINV.get_payable_invoice_transaction, "Expected Transaction is blank when cloned"
			gen_compare "", CIF_PINV.get_payable_invoice_hold_status, "Expected Invoice Hold Status is Blank"
			gen_compare _not_applicable_label, CIF_PINV.get_payable_invoice_payment_status, "Expected Payment Status is Not Applicable"

			#Verifying Expense Line Item Details
			gen_compare $bd_gla_sales_parts, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_general_ledger_account_column_number), "Expected GLA Value is Cloned"
			gen_compare $bd_comapny_merlin_auto_usa, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_destination_company_column_number), "Expected Destination Company is Cloned"
			gen_compare $bd_dim1_eur, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_dimension1_column_number), "Expected Dimension 1 is Cloned"
			gen_compare $bd_dim2_eur, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_dimension2_column_number), "Expected Dimension 2 is Cloned"
			gen_compare _expenseline_description, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_description_column_number), "Expected Line Description is Cloned"
			gen_compare '200.00', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_net_value_column_number), "Expected Net Value is Cloned"
			gen_compare '200.00', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_destination_net_value_column_number), "Expected Destination Net Value is Cloned"
			gen_compare $bd_tax_code_vo_ec_sales, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_input_tax_code_column_number), "Expected Input Tax Code is Cloned"
			gen_compare '7.000', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_input_tax_rate_column_number), "Expected Input Tax Rate is Cloned"
			gen_compare '14.00', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_input_tax_value_column_number), "Expected Input Tax Value is Cloned"
			gen_compare true, CIF_PINV.is_pinv_expense_line_reverse_charge_checkbox_checked?, "Expected Reverse Charge Checkbox checked is Cloned"
			gen_compare $bd_tax_code_vo_std_sales, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_output_tax_code_column_number), "Expected Output Tax Code is Cloned"
			gen_compare '17.500', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_output_tax_rate_column_number), "Expected Output Tax Rate is Cloned"
			gen_compare '35.00', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_expense_line_output_tax_value_column_number), "Expected Output Tax Value is Cloned"
			
			#Verifying Product Line Item Details
			CIF_PINV.click_payable_invoice_line_items_tab
			gen_compare $bd_product_a4_paper, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_product_column_number), "Expected Product is Cloned"
			gen_compare $bd_comapny_merlin_auto_usa, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_destination_company_column_number), "Expected Destination Company is Cloned"
			gen_compare '1.000000', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_quantity_column_number), "Expected Quantity is Cloned"
			gen_compare '300.000000000', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_unit_price_column_number), "Expected Unit Price is Cloned"
			gen_compare '1.000000', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_destination_quantity_column_number), "Expected Destination Quantity is Cloned"
			gen_compare '300.000000000', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_destination_unit_price_column_number), "Expected Destination Unit Price is Cloned"
			gen_compare $bd_dim1_eur, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_dimension1_column_number), "Expected Dimension 1 is Cloned"
			gen_compare $bd_dim2_eur, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_dimension2_column_number), "Expected Dimension 2 is Cloned"
			gen_compare _productline_description, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_line_description_column_number), "Expected Line Description is Cloned"
			gen_compare '300.00', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_net_value_column_number), "Expected Net Value is Cloned"
			gen_compare '300.00', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_destination_net_value_column_number), "Expected Destination Net Value is Cloned"
			
			gen_compare $bd_tax_code_vo_ec_sales, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_input_tax_code_column_number), "Expected Input Tax Code is Cloned"
			gen_compare '7.000', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_input_tax_rate_column_number), "Expected Input Tax Rate is Cloned"
			gen_compare '21.00', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_input_tax_value_column_number), "Expected Input Tax Value is Cloned"
			gen_compare true, CIF_PINV.is_pinv_line_reverse_charge_checkbox_checked?, "Expected Reverse Charge Checkbox checked is Cloned"
			gen_compare $bd_tax_code_vo_std_sales, CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_output_tax_code_column_number), "Expected Output Tax Code is Cloned"
			gen_compare '17.500', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_output_tax_rate_column_number), "Expected Output Tax Rate is Cloned"
			gen_compare '52.50', CIF_PINV.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_output_tax_value_column_number), "Expected Output Tax Value is Cloned"
			
			CIF_PINV.compare_pinv_header_details(_todays_date.strftime("%d/%m/%Y"), _period, $bd_currency_eur, '500.00', '-52.50', '447.50', $bd_document_status_in_progress)
			gen_report_test "TST036785_A: Verify that all fields on header and expense and product lines are cloned on clicking on Clone button for PIN"
        end
    end

	it "TID021242 : Verify cloning functionality from CIF view page for PCN", :unmanaged => true do
        login_user
		begin
            #Assign CIF page
            SF.tab $tab_payable_credit_notes
            SF.select_view $bd_select_view_all
            SF.click_button_go
            _payable_credit_note_number = FFA.get_column_value_in_grid $label_vendor_credit_note_number, _creditnote_number, $label_credit_note_number
            PCR.open_credit_note_detail_page _payable_credit_note_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			gen_compare_object_visible $cif_clone_button, true, "Expected Clone button present on UI"
            gen_report_test "TST036783_B: Verify that Clone button is added by default on CIF view page for PCN"
		    
			#Note creation
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			CIF.create_new_note_in_related_list _note_message,nil
			CIF.click_post_button
			gen_compare $bd_document_status_complete, CIF_PCN.get_payable_credit_note_status, "Expected Payable Credit Note Status should be completed"
			
			CIF.click_clone_button
			gen_compare $cif_msg_clone_document, CIF.get_header_toast_message, 'Toast message is matched.'
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			gen_report_test "TST036786_B: Verify that a toast message is displayed on the newly created cloned PCN"
			CIF_PCN.set_pcn_vendor_credit_note_number _cloned_number
			CIF_PCN.click_pcrn_save_button
			
			#Verifying Related List to be Blank
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected Notes record is not cloned"
			CIF.click_to_collapse_related_list_toolbar_view
			gen_report_test "TST036787_B: Verify that related lists are not cloned."
			
			gen_compare _cloned_number, CIF_PCN.get_vendor_credit_note_number, "Expected Vendor Credit Note Number is updated"
			gen_report_test "TST036795_B: Verify that user can update the cloned fields."
			gen_compare '0.00', CIF_PCN.get_payable_credit_note_outstanding_value, "Expected Outstanding Value to be 0.00"
			gen_report_test "TST036796_B: Verify that Outstanding Value is 0 on cloning a PCN"
			
			
			#Verifying Header Details
			gen_compare $bd_account_apex_eur_account, CIF_PCN.get_payable_credit_note_account , "Expected Account Name is cloned"
			gen_compare _due_date.strftime("%d/%m/%Y"), CIF_PCN.get_payable_credit_note_due_date , "Expected Due Date is cloned"
			gen_compare true, CIF_PCN.is_pcn_enable_reverse_charge_checkbox_checked? , "Expected Reverse Charge checkbox is cloned"
			gen_compare _creditnote_description, CIF_PCN.get_payable_credit_note_description, "Expected Payable Credit Note Description is cloned"
			gen_compare "", CIF_PCN.get_payable_credit_note_reason, "Expected Credit Note Reason is blank when cloned"
			gen_compare "", CIF_PCN.get_payable_credit_note_transaction, "Expected Transaction is blank when cloned"
			gen_compare _not_applicable_label, CIF_PCN.get_payable_credit_note_payment_status, "Expected Payment Status is Not Applicable"
			
			#Verifying Expense Line Item Details
			gen_compare $bd_gla_sales_parts, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_general_ledger_account_column_number), "Expected GLA Value is Cloned"
			gen_compare $bd_comapny_merlin_auto_usa, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_destination_company_column_number), "Expected Destination Company is Cloned"
			gen_compare $bd_dim1_eur, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_dimension1_column_number), "Expected Dimension 1 is Cloned"
			gen_compare $bd_dim2_eur, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_dimension2_column_number), "Expected Dimension 2 is Cloned"
			gen_compare _expenseline_description, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_description_column_number), "Expected Line Description is Cloned"
			gen_compare '200.00', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_net_value_column_number), "Expected Net Value is Cloned"
			gen_compare '200.00', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_destination_net_value_column_number), "Expected Destination Net Value is Cloned"
			gen_compare $bd_tax_code_vo_ec_sales, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_input_tax_code_column_number), "Expected Input Tax Code is Cloned"
			gen_compare '7.000', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_input_tax_rate_column_number), "Expected Input Tax Rate is Cloned"
			gen_compare '14.00', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_input_tax_value_column_number), "Expected Input Tax Value is Cloned"
			gen_compare true, CIF_PCN.is_pcn_expense_line_reverse_charge_checkbox_checked?, "Expected Reverse Charge Checkbox checked is Cloned"
			gen_compare $bd_tax_code_vo_std_sales, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_output_tax_code_column_number), "Expected Output Tax Code is Cloned"
			gen_compare '17.500', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_output_tax_rate_column_number), "Expected Output Tax Rate is Cloned"
			gen_compare '35.00', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_expense_line_output_tax_value_column_number), "Expected Output Tax Value is Cloned"
			
			#Verifying Product Line Item Details
			CIF_PCN.click_payable_credit_note_line_items_tab
			gen_compare $bd_product_a4_paper, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_product_column_number), "Expected Product is Cloned"
			gen_compare $bd_comapny_merlin_auto_usa, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_destination_company_column_number), "Expected Destination Company is Cloned"
			gen_compare '1.000000', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_quantity_column_number), "Expected Quantity is Cloned"
			gen_compare '300.000000000', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_unit_price_column_number), "Expected Unit Price is Cloned"
			gen_compare '1.000000', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_destination_quantity_column_number), "Expected Destination Quantity is Cloned"
			gen_compare '300.000000000', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_destination_unit_price_column_number), "Expected Destination Unit Price is Cloned"
			gen_compare $bd_dim1_eur, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_dimension1_column_number), "Expected Dimension 1 is Cloned"
			gen_compare $bd_dim2_eur, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_dimension2_column_number), "Expected Dimension 2 is Cloned"
			gen_compare _productline_description, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_invoice_line_item_line_description_column_number), "Expected Line Description is Cloned"
			gen_compare '300.00', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_net_value_column_number), "Expected Net Value is Cloned"
			gen_compare '300.00', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_destination_net_value_column_number), "Expected Destination Net Value is Cloned"
			
			gen_compare $bd_tax_code_vo_ec_sales, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_input_tax_code_column_number), "Expected Input Tax Code is Cloned"
			gen_compare '7.000', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_input_tax_rate_column_number), "Expected Input Tax Rate is Cloned"
			gen_compare '21.00', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_input_tax_value_column_number), "Expected Input Tax Value is Cloned"
			gen_compare true, CIF_PCN.is_pcn_line_reverse_charge_checkbox_checked?, "Expected Reverse Charge Checkbox checked is Cloned"
			gen_compare $bd_tax_code_vo_std_sales, CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_output_tax_code_column_number), "Expected Output Tax Code is Cloned"
			gen_compare '17.500', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_output_tax_rate_column_number), "Expected Output Tax Rate is Cloned"
			gen_compare '52.50', CIF_PCN.get_column_value_from_grid_data_row_on_view_page(1,$cif_payable_credit_note_line_item_output_tax_value_column_number), "Expected Output Tax Value is Cloned"
			
			CIF_PCN.compare_pcn_header_details(_todays_date.strftime("%d/%m/%Y"), _period, $bd_currency_eur, '500.00', '-52.50', '447.50', $bd_document_status_in_progress)

            gen_report_test "TST036785_B: Verify that all fields on header and expense and product lines are cloned on clicking on Clone button for PCN"
        end
    end
	
    after :all do
        login_user
        _destroy_data_TID021242 = ["CODATID021242Data.destroyData();"]
        APEX.execute_commands _destroy_data_TID021242
        SF.logout
        gen_end_test "TID021242: Verify cloning functionality from CIF view page for PIN/PCN"    
    end
end