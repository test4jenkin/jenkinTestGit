#---------------------------------------------------------------------------------------------#
#   Test Data Summary : N/A.
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF - Sales Credit Note
#   Story: AC-4257 CIF - Copy/Paste in Custom Input Forms not working consistently - TID018999
#---------------------------------------------------------------------------------------------#
describe "TID018999-Custom Input Form Sales Credit Note tests.", :type => :request do

    _document_type = "Sales Credit Note"
    _input_form_name = "SCRN Input Form"
    _view_form_name = "SCRN View Form"
    _company_name = "Merlin Auto GB"

  include_context "login"
  include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID018999"
    end
	
    it "TID018999:Custom Input Form for Sales Credit Note tests." do

        # login to merlin auto gb
        SF.app $accounting
        SF.tab $tab_select_company
        FFA.select_company [$company_merlin_auto_gb],true

        # Create Sales Invoice Input Form Template
        SF.tab $tab_input_form_manager
        CIF_IFM.create_new_form_type _document_type, $cif_ifm_form_type_input
        CIF_IFM.set_form_name _input_form_name
        CIF_IFM.click_save_button
        CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

        # Create Sales Invoice View Form Template
        CIF_IFM.create_new_form_type _document_type, $cif_ifm_form_type_view
        CIF_IFM.set_form_name _view_form_name

        # Select sales invoice related lists
        CIF_IFM.click_add_or_edit_related_list_button
		CIF_IFM.select_related_list [$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_history_sales_credit_note,$cif_related_list_toolbar_label_notes,$cif_related_list_toolbar_label_tasks]
		CIF_IFM.click_ok_button_on_related_list

        CIF_IFM.click_save_button
        CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

        # Activate form layout
        CIF_IFM.select_and_activate_form _input_form_name, _company_name
        CIF_IFM.select_input_form_manager_from_list _input_form_name

        CIF_IFM.select_and_activate_form _view_form_name, _company_name
        CIF_IFM.select_input_form_manager_from_list _view_form_name
		
		gen_start_test "Create Sales invoice and verify that all related list are displayed"
		begin
			# Create Sales invoice
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			# wait for button to load
			gen_wait_until_object $cif_save_post_button
			CIF_SCN.set_account $bd_account_algernon_partners_co
			CIF_SCN.set_credit_note_currency $bd_currency_eur
			
			CIF_SCN.click_new_row 
			CIF_SCN.set_scn_line_item_product $bd_product_a4_paper
			CIF_SCN.set_scn_line_item_destination_company nil
			CIF_SCN.set_line_item_quantity 10
			CIF.wait_for_totals_to_calculate
			CIF_SCN.set_scn_line_item_unit_price 100.00
			CIF.wait_for_totals_to_calculate
			
			CIF_SCN.set_scn_destination_quantity nil
			CIF_SCN.set_scn_destination_unit_price nil
			CIF_SCN.set_scn_line_item_dimesion_1 $bd_dim1_eur
			CIF_SCN.set_scn_line_item_dimesion_2 $bd_dim2_eur
			CIF_SCN.set_scn_line_item_line_description "Testing"

			CIF_SCN.set_scn_line_item_tax_code $bd_tax_code_vo_std_sales
			CIF_SCN.set_scn_line_item_tax_rate 10, true
			CIF.wait_for_totals_to_calculate
			CIF_SCN.set_scn_line_item_tax_value 100.00, true
			CIF.wait_for_totals_to_calculate
			CIF.click_save_post_button    
			gen_wait_until_object_disappear $cif_save_post_button
			gen_wait_until_object $cif_amend_button
			CIF_SCN.compare_scn_header_details(nil, nil, nil, '1,000.00', '100.00', '1,100.00', 'Complete')
			
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_events, true, "Related List item Events is displayed"
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_history_sales_credit_note, true, "Related List item History: Sales Invoice is displayed"
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_tasks, true, "Related List item Tasks is displayed"
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
			gen_end_test "Sales Credit Note created and all related list options are displayed"
			gen_end_test "TID018999"
		end 
	end
	
	after :all do
		#Delete Test Data
		login_user
		FFA.delete_new_data_and_wait
		SF.logout
	end
	
end