#----------------------------------------------------------------------------------------------#
#   Test Data Summary : N/A.
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF - Sales Invoices
#   Story: AC-4257 CIF - Copy/Paste in Custom Input Forms not working consistently - TID018998
#----------------------------------------------------------------------------------------------#
describe "TID018998-CIF Sales Invoice tests.", :type => :request do

    _document_type = "Sales Invoice"
    _input_form_name = "SINV Input Form"
    _view_form_name = "SINV View Form"
    _company_name = "Merlin Auto GB"
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID018998"
    end
	
    it "TID018998:Custom Input Form for Sales Invoice tests." do

        # login to merlin auto gb
        SF.app $accounting
        SF.tab $tab_select_company
        FFA.select_company [$company_merlin_auto_gb],true

        # Create Sales Invoice Input Form Template
        SF.tab $tab_input_form_manager
        CIF_IFM.create_new_form_type _document_type, $cif_ifm_form_type_input
        CIF_IFM.set_form_name _input_form_name

		# Set account filters
		config_button_exists_for_header_element $cif_sales_invoice_account_ifm_field_id, true
		config_button_exists_for_header_element $cif_sales_invoice_invoice_date_ifm_field_id, false
		config_button_exists_for_header_element $cif_sales_invoice_due_date_ifm_field_id, false
		config_button_exists_for_header_element $cif_sales_invoice_net_total_ifm_field_id, false
		CIF_IFM.open_config_for_header_element $cif_sales_invoice_account_ifm_field_id
		CIF_IFM.choose_include_all_account_button
		#check customer direct out of listed options
		CIF_IFM.select_account_filter_option $cif_ifm_account_type_customer_direct
		CIF_IFM.apply_account_settings

        CIF_IFM.click_save_button
        CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

        # Create Sales Invoice View Form Template
        CIF_IFM.create_new_form_type _document_type, $cif_ifm_form_type_view
        CIF_IFM.set_form_name _view_form_name

		config_button_exists_for_header_element $cif_sales_invoice_account_ifm_field_id, false
		config_button_exists_for_header_element $cif_sales_invoice_invoice_date_ifm_field_id, false
		config_button_exists_for_header_element $cif_sales_invoice_due_date_ifm_field_id, false
		config_button_exists_for_header_element $cif_sales_invoice_net_total_ifm_field_id, false

        # Select sales invoice related lists
        CIF_IFM.click_add_or_edit_related_list_button
		CIF_IFM.select_related_list [$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_history_sales_invoice,$cif_related_list_toolbar_label_notes,$cif_related_list_toolbar_label_tasks]
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
			SF.tab $tab_sales_invoices
			SF.click_button_new
			# wait for button to load.
			gen_wait_until_object $cif_save_post_button
			_expected_Accounts = [
				"Algernon1 Partners & Co", 
				"Algernon Partners & Co", 
				"C.Woermann1 GmbH & Co. KG", 
				"C.Woermann GmbH & Co. KG", 
				"Cambridge1 Auto", 
				"Cambridge Auto", 
				"Hogan1 Repairs", 
				"Hogan Repairs", 
				"LG Auto Parts", 
				"Slick1 Fit Auto", 
				"Slick Fit Auto", 
				"UNIT4", 
				"Walden1 Auto Body", 
				"Walden Auto Body"
			]
			
			_actual_accounts = get_sinv_accounts_options
			gen_compare _expected_Accounts.length, _actual_accounts.length, 'Should be ' + _expected_Accounts.length.to_s + ' Accounts'
			_actual_accounts.each do |acc|
				gen_compare true, (_expected_Accounts.include? acc.text), 'Account ' + acc.text + ' should be there'
			end
			CIF_SINV.set_sinv_account $bd_account_algernon_partners_co
			CIF_SINV.set_sinv_invoice_currency $bd_currency_eur
			
			CIF_SINV.click_new_row 
			CIF_SINV.set_sinv_line_product $bd_product_a4_paper
			CIF_SINV.set_sinv_line_destination_company nil
			CIF_SINV.set_sinv_line_quantity 10
			CIF_SINV.set_sinv_line_unit_price 100.00

			CIF_SINV.set_destination_quantity nil
			CIF_SINV.set_destination_unit_price nil
			CIF_SINV.set_sinv_line_dimesion_1 $bd_dim1_eur
			CIF_SINV.set_sinv_line_dimesion_2 $bd_dim2_eur
			CIF_SINV.set_sinv_line_line_description "Testing"

			CIF_SINV.set_sinv_line_tax_code $bd_tax_code_vo_std_sales
			CIF_SINV.set_sinv_line_tax_rate 10, true
			CIF_SINV.set_sinv_line_tax_value 100.00, true

			CIF_SINV.click_sinv_save_post_button
			gen_wait_until_object $cif_amend_button
			page.has_css?($cif_sales_invoice_line_items_tab)
			CIF_SINV.compare_sinv_header_details(nil, nil, nil, '1,000.00', '100.00', '1,100.00', 'Complete')

			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_events, true, "Related List item Events is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_sales_invoice, true, "Related List item History: Sales Invoice is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_tasks, true, "Related List item Tasks is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
			gen_end_test "Sales invoice created and all related list options are displayed"
		end 
	end
	
	after :all do
		#Delete Test Data
		login_user
		FFA.delete_new_data_and_wait
		SF.logout
	end

	def config_button_exists_for_header_element header_element_id, expected
		_element_path = $cif_ifm_field_config_button.sub($cif_ifm_param_substitute, header_element_id)
		_expected_text = expected ? "config button should exist" : "config button shouldn't exist"
		gen_compare_object_visible _element_path, expected, _expected_text
	end

	def get_sinv_accounts_options
		# Click the account filed and trigger to display the options below
		find($cif_sales_invoice_account_selector_drop_down).click
		find(:xpath,$cif_sales_invoice_account_dropdown_trigger).click
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		# return all items from list
		return find($gen_f_list_plain).all('li')
	end
end