#----------------------------------------------------------------------------------------------#
#   Test Data Summary : N/A.
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF - Sales Invoices
#   Story: AC-4257 CIF - Copy/Paste in Custom Input Forms not working consistently - TID019002
#----------------------------------------------------------------------------------------------#
describe "TID019002-CIF Cash Entry tests.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
    _document_type = "Cash Entry"
    _input_form_name = "CE Input Form"
    _view_form_name = "CE View Form"
    _company_name = "Merlin Auto Spain"
    _cash_entry_type = "Payment"
    _bank_account = "Santander Current Account"
    _description = "Capybara Test"
	
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait	
	end  
	
	it "TID019002-Custom Input Form for Cash Entry tests." do

		# login to merlin auto gb
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true

		# Create Sales Invoice Input Form Template
		SF.tab $tab_input_form_manager
		CIF_IFM.create_new_form_type _document_type, 'Input'
		
		CIF_IFM.set_form_name _input_form_name
		CIF_IFM.click_save_button

		# Create Sales Invoice View Form Template
		CIF_IFM.create_new_form_type _document_type, 'View'
		CIF_IFM.set_form_name _view_form_name

		# Select sales invoice related lists
		CIF_IFM.click_add_or_edit_related_list_button
		CIF_IFM.select_related_list [$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_history_cash_entry,$cif_related_list_toolbar_label_notes]
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
			SF.tab $tab_cash_entries
			SF.click_button_new
			CIF.wait_for_buttons_to_load

			#Header
			CIF_CE.set_ce_type _cash_entry_type
			CIF_CE.set_ce_bank_account _bank_account
			CIF_CE.set_description _description

			#Line item
			CIF_CE.click_new_row
			CIF_CE.set_ce_account $bd_account_apex_eur_account
			CIF_CE.set_ce_cash_entry_value 1000.00
			CIF.click_save_post_button        
			gen_wait_until_object $cif_amend_button
			#assert related list
			page.assert_selector($cif_related_list_toolbar, :text =>'Attachments', :visible => true)
			gen_report_test "Related List item Attachments is displayed"
			page.assert_selector($cif_related_list_toolbar, :text =>'Files', :visible => true)
			gen_report_test "Related List item Events is displayed"
			page.assert_selector($cif_related_list_toolbar, :text =>'Groups', :visible => true)
			gen_report_test "Related List item Events is displayed"
			page.assert_selector($cif_related_list_toolbar, :text =>'History: Cash Entry', :visible => true)
			gen_report_test "Related List item History: Cash Entry is displayed"
			page.assert_selector($cif_related_list_toolbar, :text =>'Notes', :visible => true)
			gen_report_test "Related List item Notes is displayed"
		end
	end
  
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "Cash Entry created and all related list options are displayed"
		SF.logout 
	end
end