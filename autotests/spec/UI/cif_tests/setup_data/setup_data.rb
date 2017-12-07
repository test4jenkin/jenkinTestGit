#--------------------------------------------------------------------#
#   Test Data Summary : This test data is for all CIF scripts.
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF
#--------------------------------------------------------------------#
describe "layout change required for cif tests.", :type => :request do
	include_context "login"
 
	it "Update journal layout to CIF" do
		# Setting page layout to custom journal layout(Sencha)
		SF.object_button_edit $ffa_object_journal, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_edit
		SF.object_button_edit $ffa_object_journal, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_new	
		SF.object_button_edit $ffa_object_journal, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_view	
	end
	
	it "Update cash entry layout to CIF" do
		login_user
		# Setting page layout to custom Cash Entry layout(Sencha)
		SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_edit	
		SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_new	
		SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_view
	end
	
	it "Update Sales invoice layout to CIF" do
		login_user
		SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_edit		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_new				
		SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_view	
	end
	
	it "Update sales credit note layout to CIF " do  
		login_user
		# Setting page layout to custom Sales credit note  layout(Sencha)
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_credit_note_edit				
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_credit_note_new				
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_credit_note_view	
	end
	
	it "Update payable invoice layout to CIF " do
		login_user
		# Setting page layout to custom purchase Invoice  layout(Sencha)
		SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_edit			
		SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_new				
		SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_view	
	end
	
	it "Update payable credit note layout to CIF" do
		login_user
		# Setting page layout to custom payable credit note layout(Sencha)
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_edit				
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_new				
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
		CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_view
	end
end
