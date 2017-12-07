#--------------------------------------------------------------------#
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF
#   Story: AC-7364 CIF - Matched Payments Related List - TID020499
#--------------------------------------------------------------------#
describe "TID020499-Related View for CIF Sales Invoice tests.", :type => :request do
    _document_type_sinv = "Sales Invoice"
    _input_form_name = "SINV Input Form"
    _view_form_name = "SINV View Form"
    _company_name = "Merlin Auto GB"
    __fieldsAddArray = ["Invoice Rate","Invoice Number"] # Fields to be added to the layout
	_last_year = ((Time.now).year - 1).to_s
	_invoice_total = "3,671.88"
	
	include_context "login"
	include_context "logout_after_each"
	_last_year = ((Time.now).year-1).to_s
	
	before :all do
		gen_start_test "TID020499"    
		#Assign the CIF Sales Invoice pages to the native buttons.
		SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_edit			
		SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_new			

		# Setting page layout to VF cash entry  layout
		SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_edit			
		SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_new			

    end
    it "Related View for CIF Sales Invoice tests." do

        # login to merlin auto gb
        SF.app $accounting
        SF.tab $tab_select_company
        FFA.select_company [$company_merlin_auto_gb],true

        # Create Sales Invoice Input Form Template
        SF.tab $tab_input_form_manager
        CIF_IFM.create_new_form_type _document_type_sinv, $cif_ifm_form_type_view
        CIF_IFM.set_form_name _view_form_name
        CIF_IFM.selectFields("Sales Invoice Header Items")
        CIF_IFM.drag_fields_on_layout(__fieldsAddArray, $cif_ifm_field_add, $cif_ifm_new_row_next, nil)

        # Select matched payments related list and activate the form
		CIF_IFM.click_add_or_edit_related_list_button
		CIF_IFM.select_related_list [$cif_related_list_toolbar_label_matched_payments]
		CIF_IFM.click_ok_button_on_related_list
        CIF_IFM.click_save_button
        CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

        CIF_IFM.select_and_activate_form _view_form_name, _company_name
        CIF_IFM.select_input_form_manager_from_list _view_form_name

         # Create Sales invoice for Algernon Partners & Co 
		SF.tab $tab_sales_invoices
		SF.click_button_new
		SIN.set_account "CODA Harrogate"

		# Use last year instead of hard coded year
		SIN.set_invoice_date "25/06/"+_last_year
		SIN.set_due_date "10/07/"+_last_year
		SIN.set_customer_reference "REF2"
		SIN.select_shipping_method "FedEx"
		SIN.set_description "SIN2 DESCRIPTION2"
		SIN.add_line 1, "Bendix Front Brake Pad Set 1975-1983 Chrysler Cordoba" , 15 , 75 , "VO-STD Sales" , nil , nil
		SIN.add_line 2, "Bosch Oil Filter Ford Mustang 1994-2003" , 20 , 100 , "VO-STD Sales" , nil , nil
		FFA.click_save_post
		SF.tab $tab_sales_invoices
		SF.select_view $bd_select_view_all
        SF.click_button_go
		SF.edit_list_view $bd_select_view_all, $label_invoice_total, 5
		_posted_sales_invoice_number = FFA.get_column_value_in_grid $label_invoice_total, _invoice_total, $label_invoice_number
		gen_report_test "Invoice created and posted"

		# Create a cash enty (For matched component)
		SF.tab $tab_cash_entries
		SF.click_button_new
		CE.select_bank_account_from_lookup $cashentry_bank_account_lookup_icon, $bdu_bank_account_barclays_current_account, $company_merlin_auto_gb
		CE.set_reference 1
		CE.set_date "1/6/"+_last_year
		CE.set_currency $bd_currency_gbp,$company_merlin_auto_gb	
		CE.set_payment_method $bd_payment_method_cash
		CE.set_cash_entry_description "CE1"
		CE.line_set_account_name "CODA Harrogate"
		FFA.click_new_line
		CE.line_set_payment_method_value 1 ,"Cash"
		CE.line_set_cashentryvalue 1,"3671.88"
		CE.click_update
		FFA.click_save_post
		gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "Cash entry Created and posted"
		# Matching (Match Sales Invoice and Cash Entry)
		SF.tab $tab_cash_matching
		CM.retrieve_cashmatching "CODA Harrogate", $bd_currency_mode_document, $bd_currency_gbp
		CM.select_cashentry_doc_for_matching "CSH", 1
		CM.select_trans_doc_for_matching "SIN", 1
		CM.click_commit_data
		gen_include $ffa_msg_cashmatching_completed_message,CM.get_cash_matching_commit_operation_message , "Expected Commit operation to be successfull"
		gen_include $ffa_msg_cashmatching_reference_message,CM.get_cash_matching_commit_operation_message , "Expected Commit operation to be successfull with a reference number: "+CM.get_cash_matching_commit_operation_message
  		
		SF.tab $tab_sales_invoices
		SF.click_button_go
		SIN.open_invoice_detail_page _posted_sales_invoice_number
		page.assert_selector($cif_sales_invoice_related_list_toolbar, :text =>'Matched Payments', :visible => true)
		gen_report_test "Related List item Matched Payments is displayed"

		CIF.click_related_list_toolbar_item "Matched Payments"
		actual =  CIF.get_grid_rows
		gen_compare 1 , actual , "Matched Payments displayed"
		griddata = Array.new 
			.push(CIF.get_grid_data_row 1)
		rc = griddata[0]
		grid_data = FFA.substitute_document_number rc # strip out the documnets numbers
		gen_compare "Cash XX 1 XX £ 3,671.88 £ -3,671.88 £ -3,671.88 € -4,406.26 £ 0.00 Paid",grid_data,"Row 1"
	end
	
	after :all do
		#Delete Test Data
		login_user
		FFA.delete_new_data_and_wait
		begin				
			# Setting page layout to custom Sales Invoice  layout(Sencha)
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_edit		
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_new				
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_view	
			
			# Setting page layout to custom Cash Entry layout(Sencha)
			SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_edit	
			SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_new	
			SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_view
			gen_end_test "TID020499"
		end
		SF.logout
	end
end