#--------------------------------------------------------------------#
#   TID : TID021266
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF
#   driver=firefox rspec spec/UI/cif_tests/cif_payable_invoice_payable_credit_note_TID021266.rb -fh -o TID021266.html
#--------------------------------------------------------------------#

describe "TID021266 : Error message or a warning message on PIN/PCN created with CIF, when a duplicate vendor invoice/credit note number is entered.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
 	_purchase_invoice_edit_page = 'cfpurchaseinvoiceedit'
 	_purchase_credit_note_edit_page = 'cfpurchasecreditnoteedit'
	_duplicate_pin_vendor_error = 'Payable Invoice: Object validation has failed. Vendor Invoice Number Field: Payable Invoice cannot be saved because this Vendor Invoice Number already exists for '+$bd_account_apex_eur_account+'.'
	_duplicate_pin_vendor_warning = '1. This Vendor Invoice Number already exists for '+$bd_account_apex_eur_account+'.' 
  	_duplicate_pcn_vendor_error = 'Payable Credit Note: Object validation has failed. Vendor Credit Note Number Field: Payable Credit Note cannot be saved because this Vendor Credit Note Number already exists for '+$bd_account_apex_eur_account+'.'	
  	_duplicate_pcn_vendor_warning = '1. This Vendor Credit Note Number already exists for '+$bd_account_apex_eur_account+'.'
 	_accounting_settings_delete = ["delete[SELECT Id from #{ORG_PREFIX}codaAccountingSettings__c];"]
 
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		
		#Login and select merlin auto spain company.
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		gen_start_test "TID021266: Verify that user faces an error message or a warning message on PIN/PCN created with CIF, when a duplicate vendor invoice/credit note number is entered."		
	end
   
    it "TST036901: Verify that duplicate vendor invoice/credit note number shows error." do
    	_vendor_number = 'TST036901_7'
		#Change custom setting to enable document number check and allow duplicate vendor invoice/credit note number
		SF.new_custom_setting $ffa_custom_setting_accounting_settings
		SF.set_custom_setting_property $ffa_accounting_settings_disable_vendor_number_check, false
		SF.set_custom_setting_property $ffa_accounting_settings_duplicate_vendor_number_allowed, false
		SF.click_button_save
	
    	gen_start_test "TST036901 A. - User gets an error message on CIF, when duplicate vendor invoice number is entered."		
			#Create first invoice
			SF.tab $tab_payable_invoices
			SF.click_button_new
			CIF.wait_for_buttons_to_load
			CIF_PINV.set_pinv_account $bd_account_apex_eur_account
			CIF_PINV.set_pinv_vendor_invoice_number _vendor_number

			#add 1 line item
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_line_product $bd_product_a4_paper
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_quantity_column_number
			CIF_PINV.set_pinv_line_quantity 1
			CIF_PINV.set_pinv_line_unit_price "20"

			#Save and New Payable Invoice
			CIF_PINV.click_pinv_save_new_button		
			CIF.wait_for_buttons_to_load

			#Create invoice with same vendor invoice number
			CIF_PINV.set_pinv_account $bd_account_apex_eur_account
			CIF_PINV.set_pinv_vendor_invoice_number _vendor_number

			#add 1 line item
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_line_product $bd_product_a4_paper
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_quantity_column_number
			CIF_PINV.set_pinv_line_quantity 1
			CIF_PINV.set_pinv_line_unit_price "20"

			current_page_url = page.current_url

			#Save Payable Invoice
			CIF_PINV.click_pinv_save_button
			CIF.wait_for_buttons_to_load
			gen_compare _duplicate_pin_vendor_error, FFA.get_sencha_popup_error_message, 'Error message found'
			FFA.sencha_popup_click_continue
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message

			gen_include _purchase_invoice_edit_page , current_page_url , 'Expected to remain on same page i.e. purchaseinvoiceedit page'
		gen_end_test "TST036901 A. - User gets an error message on CIF, when duplicate vendor invoice number is entered."
	
    	gen_start_test "TST036901 B. - User gets an error message on CIF, when duplicate vendor credit note number is entered."		
			#Create first credit note
			SF.tab $tab_payable_credit_notes
			SF.click_button_new
			CIF.wait_for_buttons_to_load
			CIF_PCN.set_pcn_account $bd_account_apex_eur_account
			CIF_PCN.set_pcn_vendor_credit_note_number _vendor_number
			
			#add 1 line item
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.click_new_row
			CIF_PCN.set_pcn_line_product $bd_product_a4_paper
			CIF_PCN.click_column_grid_data_row 1, $cif_payable_credit_note_line_item_quantity_column_number
			CIF_PCN.set_pcn_line_quantity 1
			CIF_PCN.set_pcn_line_unit_price "20"
			
			#Save and New Payable Credit Note
			CIF_PCN.click_pcn_save_new_button
			CIF.wait_for_buttons_to_load

			#Create credit note with same vendor credit note number
			CIF_PCN.set_pcn_account $bd_account_apex_eur_account
			CIF_PCN.set_pcn_vendor_credit_note_number _vendor_number

			#add 1 line item
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.click_new_row
			CIF_PCN.set_pcn_line_product $bd_product_a4_paper
			CIF_PCN.click_column_grid_data_row 1, $cif_payable_credit_note_line_item_quantity_column_number
			CIF_PCN.set_pcn_line_quantity 1
			CIF_PCN.set_pcn_line_unit_price "20"
			
			current_page_url = page.current_url

			#Save Payable Credit Note
			CIF_PCN.click_pcrn_save_button
			CIF.wait_for_buttons_to_load
			gen_compare _duplicate_pcn_vendor_error, FFA.get_sencha_popup_error_message, 'Error message found'
			FFA.sencha_popup_click_continue
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			
			gen_include _purchase_credit_note_edit_page , current_page_url , 'Expected to remain on same page i.e. purchaseinvoiceedit page'
		
		gen_end_test "TST036901 B. - User gets an error message on CIF, when duplicate vendor credit note number is entered."
    end	

    it "TST036902: Verify that duplicate vendor invoice/credit note number shows warning." do
		login_user
		_vendor_number = 'TST036902_7'
		#Change custom setting to enable document number check and allow duplicate vendor invoice/credit note number
		SF.new_custom_setting $ffa_custom_setting_accounting_settings		
		SF.set_custom_setting_property $ffa_accounting_settings_disable_vendor_number_check, false
		SF.set_custom_setting_property $ffa_accounting_settings_duplicate_vendor_number_allowed, true
		SF.click_button_save	
	
    	gen_start_test "TST036902 A - User gets a warning message on CIF, when duplicate vendor invoice number is entered."
			#Create first invoice
			SF.tab $tab_payable_invoices
			SF.click_button_new
			CIF.wait_for_buttons_to_load
			CIF_PINV.set_pinv_account $bd_account_apex_eur_account
			CIF_PINV.set_pinv_vendor_invoice_number _vendor_number
			
			#add 1 line item
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_line_product $bd_product_a4_paper
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_quantity_column_number
			CIF_PINV.set_pinv_line_quantity 1
			CIF_PINV.set_pinv_line_unit_price "20"
			
			#Save and New Payable Invoice
			CIF_PINV.click_pinv_save_new_button		
			CIF.wait_for_buttons_to_load

			#Create second invoice
			CIF_PINV.set_pinv_account $bd_account_apex_eur_account
			CIF_PINV.set_pinv_vendor_invoice_number _vendor_number

			#add 1 line item
			CIF_PINV.click_payable_invoice_line_items_tab
			CIF_PINV.click_new_row
			CIF_PINV.set_pinv_line_product $bd_product_a4_paper
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_quantity_column_number
			CIF_PINV.set_pinv_line_quantity 1
			CIF_PINV.set_pinv_line_unit_price "20"

			#Save and New Payable Invoice
			CIF_PINV.click_pinv_save_button
			CIF.wait_for_buttons_to_load

			gen_compare _duplicate_pin_vendor_warning, FFA.get_sencha_popup_error_message, 'Warning message found'
			FFA.sencha_popup_click_continue
			gen_wait_until_object $cif_edit_record_button
			
			gen_compare $bd_document_status_in_progress, CIF_PINV.get_payable_invoice_status, "Expected Payable Invoice should be with In Progress status"
		gen_end_test "TST036902 A. - User gets a warning message on CIF, when duplicate vendor invoice number is entered."		
	
		gen_start_test "TST036902 B - User gets a warning message on CIF, when duplicate vendor credit note number is entered."
			#Create first credit note
			SF.tab $tab_payable_credit_notes
			SF.click_button_new
			CIF.wait_for_buttons_to_load
			CIF_PCN.set_pcn_account $bd_account_apex_eur_account
			CIF_PCN.set_pcn_vendor_credit_note_number _vendor_number
			
			#add 1 line item
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.click_new_row
			CIF_PCN.set_pcn_line_product $bd_product_a4_paper
			CIF_PCN.click_column_grid_data_row 1, $cif_payable_credit_note_line_item_quantity_column_number
			CIF_PCN.set_pcn_line_quantity 1
			CIF_PCN.set_pcn_line_unit_price "20"
			
			#Save and New Payable Credit Note
			CIF_PCN.click_pcn_save_new_button		
			CIF.wait_for_buttons_to_load

			#Create second credit note
			CIF_PCN.set_pcn_account $bd_account_apex_eur_account
			CIF_PCN.set_pcn_vendor_credit_note_number _vendor_number

			#add 1 line item
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.click_new_row
			CIF_PCN.set_pcn_line_product $bd_product_a4_paper
			CIF_PCN.click_column_grid_data_row 1, $cif_payable_credit_note_line_item_quantity_column_number
			CIF_PCN.set_pcn_line_quantity 1
			CIF_PCN.set_pcn_line_unit_price "20"

			#Save and New Payable Credit Note
			CIF_PCN.click_pcrn_save_button
			CIF.wait_for_buttons_to_load

			gen_compare _duplicate_pcn_vendor_warning, FFA.get_sencha_popup_error_message, 'Warning message found'
			FFA.sencha_popup_click_continue
			gen_wait_until_object $cif_edit_record_button
			
			gen_compare $bd_document_status_in_progress, CIF_PCN.get_payable_credit_note_status, "Expected Payable Credit Note should be with In Progress status"
		gen_end_test "TST036902 B. - User gets a warning message on CIF, when duplicate vendor credit note number is entered."	
	end
	
	after :all do
		#Delete new data
		login_user
		FFA.delete_new_data_and_wait
		APEX.execute_commands _accounting_settings_delete
		SF.logout
		gen_end_test "TID021266: TID verifies that user faces an error message or a warning message on PIN/PCN created with CIF, when a duplicate vendor invoice/credit note number is entered."
	end
end