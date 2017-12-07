#--------------------------------------------------------------------#
#   Test Data Summary : N/A.
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF - Sales Invoices
#   Story: AC-1383 CIF - View Related Lists - TID017513
#--------------------------------------------------------------------#
describe "TID017513-Related View for CIF Sales Invoice tests.", :type => :request do

    _document_type_sinv = "Sales Invoice"
    _input_form_name = "SINV Input Form"
    _view_form_name = "SINV View Form"
    _company_name = "Merlin Auto GB"

  
  include_context "login"
  include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID017513"
    end
    it "Related View for CIF Sales Invoice tests." do

        # login to merlin auto gb
        SF.app $accounting
        SF.tab $tab_select_company
        FFA.select_company [$company_merlin_auto_gb],true

        # Create Sales Invoice Input Form Template
        SF.tab $tab_input_form_manager
        CIF_IFM.create_new_form_type _document_type_sinv, $cif_ifm_form_type_input
        CIF_IFM.set_form_name _input_form_name
        CIF_IFM.click_save_button
        CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

        # Create Sales Invoice View Form Template
        CIF_IFM.create_new_form_type _document_type_sinv, $cif_ifm_form_type_view
        CIF_IFM.set_form_name _view_form_name
        
        # Select sales invoice related lists
        CIF_IFM.click_add_or_edit_related_list_button
		CIF_IFM.select_related_list [$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_history_sales_invoice,$cif_related_list_toolbar_label_notes,$cif_related_list_toolbar_label_tasks]
		CIF_IFM.click_ok_button_on_related_list

        CIF_IFM.click_save_button
        CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		SF.tab $tab_input_form_manager

        # Activate form layout
        CIF_IFM.select_and_activate_form _input_form_name, _company_name
        CIF_IFM.select_input_form_manager_from_list _input_form_name

        CIF_IFM.select_and_activate_form _view_form_name, _company_name
        CIF_IFM.select_input_form_manager_from_list _view_form_name

		gen_start_test "Create Sales invoice and verify that all related list are displayed"
		begin
			# Create Sales invoice
			SF.tab $tab_sales_invoices
			SF.click_button_new
			CIF.wait_for_buttons_to_load

			CIF_SINV.set_sinv_account $bd_account_algernon_partners_co
			CIF_SINV.set_sinv_invoice_currency $bd_currency_eur
			
			CIF_SINV.click_new_row 
			CIF_SINV.set_sinv_line_product $bd_product_a4_paper
			CIF_SINV.set_sinv_line_destination_company nil
			CIF_SINV.set_sinv_line_quantity 10
			CIF_SINV.set_sinv_line_unit_price 100.00

			CIF_SINV.set_sinv_line_dimesion_1 $bd_dim1_eur
			CIF_SINV.set_sinv_line_dimesion_2 $bd_dim2_eur
			CIF_SINV.set_sinv_line_line_description "Testing"

			CIF_SINV.set_sinv_line_tax_code $bd_tax_code_vo_std_sales
			CIF_SINV.set_sinv_line_tax_rate 10, true
			CIF_SINV.set_sinv_line_tax_value 100.00, true
			CIF.click_toggle_button
			CIF_SINV.click_sinv_save_post_button
			gen_wait_until_object $cif_amend_button
			CIF_SINV.compare_sinv_header_details(nil, nil, nil, '1,000.00', '100.00', '1,100.00', 'Complete')

			page.assert_selector($cif_sales_invoice_related_list_toolbar, :text =>'Attachments', :visible => true)
			gen_report_test "Related List item Attachments is displayed"
			page.assert_selector($cif_sales_invoice_related_list_toolbar, :text =>'Events', :visible => true)
			gen_report_test "Related List item Events is displayed"
			page.assert_selector($cif_sales_invoice_related_list_toolbar, :text =>'History: Sales Invoice', :visible => true)
			gen_report_test "Related List item History: Sales Invoice is displayed"
			page.assert_selector($cif_sales_invoice_related_list_toolbar, :text =>'Notes', :visible => true)
			gen_report_test "Related List item Notes is displayed"
			page.assert_selector($cif_sales_invoice_related_list_toolbar, :text =>'Task', :visible => true)
			gen_report_test "Related List item Tasks is displayed"

			gen_end_test "Sales invoice created and all related list options are displayed"
		end

		gen_start_test "Edit the input form manager"
		begin
			SF.tab $tab_input_form_manager
			CIF_IFM.select_input_form_manager_from_list _view_form_name
			CIF_IFM.click_deactivate_button        
			CIF_IFM.click_edit_button

			# Unselect sales invoice related list
	        CIF_IFM.click_add_or_edit_related_list_button
	        CIF_IFM.deselect_related_list_if_selected $cif_related_list_toolbar_label_attachments
	        CIF_IFM.deselect_related_list_if_selected $cif_related_list_toolbar_label_events
	        CIF_IFM.deselect_related_list_if_selected $cif_related_list_toolbar_label_history_sales_invoice
	        CIF_IFM.deselect_related_list_if_selected $cif_related_list_toolbar_label_notes
	        CIF_IFM.deselect_related_list_if_selected $cif_related_list_toolbar_label_tasks
			CIF_IFM.click_ok_button_on_related_list
			CIF_IFM.click_save_button
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

			CIF_IFM.click_activate_button
		
		gen_end_test "Input form manager edited successfully"
		end
		
		gen_start_test "Verify that related lists are no longer displayed on Sales Invoice" 
		begin 
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			
			CIF_SINV.select_sales_invoice_on_list_view "Algernon Partners & Co"
			gen_wait_until_object $cif_amend_button
			expect(page).not_to have_css($cif_sales_invoice_related_list_toolbar , :text =>'Attachments')
			gen_report_test "Related List item Attachments is NOT displayed"
			expect(page).not_to have_css($cif_sales_invoice_related_list_toolbar , :text =>'Events')
			gen_report_test "Related List item Events is NOT displayed"
			expect(page).not_to have_css($cif_sales_invoice_related_list_toolbar , :text =>'History: Sales Invoice')
			gen_report_test "Related List item History: Sales Invoice is NOT displayed"
			expect(page).not_to have_css($cif_sales_invoice_related_list_toolbar , :text =>'Notes')
			gen_report_test "Related List item Notes is NOT displayed"
			expect(page).not_to have_css($cif_sales_invoice_related_list_toolbar , :text =>'Tasks')
			gen_report_test "Related List item Tasks is NOT displayed"
			gen_end_test "Related lists are no longer displayed"
		end    
	end
	
	after :all do
		#Delete Test Data
		login_user
		FFA.delete_new_data_and_wait
		gen_end_test "TID017513"
		SF.logout
	end
end