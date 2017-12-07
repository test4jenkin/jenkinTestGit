#----------------------------------------------------------------------------------------------#
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: CIF - Sales Invoices
#   Story: AC-10031 CIF - Add warning message to CIF
#   How to run : rspec spec/UI/cif_tests/cif_sales_invoice_TID021385.rb
#----------------------------------------------------------------------------------------------#
describe "TID021385- Verify that user gets a toast message on CIF UI when document's status changed to Ready to Post", :type => :request do
    _warning_message = 'This document will be posted in the background.'
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
    end
	
    it "TID021385: Verify that user gets a toast message on CIF UI when document's status changed to Ready to Post." do
        # login to Merlin Auto GB
        SF.app $accounting
        SF.tab $tab_select_company
        FFA.select_company [$company_merlin_auto_gb],true

		gen_start_test "TST037381 - User is now informed on CIF page also, when status of document is changed to Ready to post."
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
			CIF_SINV.set_sinv_line_quantity 1
			CIF_SINV.set_sinv_line_unit_price 100.00

			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_auto_com_clutch_kit_1989_dodge_raider,2
			CIF_SINV.set_sinv_line_quantity 1,2
			CIF_SINV.set_sinv_line_unit_price 200.00,2
			CIF_SINV.click_sinv_save_button
			SF.wait_for_search_button	
			
			#Creating Custom Setting
			SF.new_custom_setting $ffa_custom_setting_accounting_settings
			SF.set_custom_setting_property $ffa_accounting_settings_sales_invoice_lines_threshold, 1
			SF.click_button_save
			
			#Posting SIN
			SF.tab $tab_sales_invoices
			SF.click_button_go
			_sales_invoice_number = FFA.get_column_value_in_grid $budget_account_label , $bd_account_algernon_partners_co, $label_invoice_number
			SIN.open_invoice_detail_page _sales_invoice_number
			
			CIF_SINV.click_sinv_post_button
			gen_compare _warning_message,CIF.get_header_toast_message,'Toast is displayed'
			CIF_SINV.compare_sinv_header_details(nil, nil, nil, '300.00', '35.00', '335.00', $bd_document_status_ready_to_post)
			
			#Coming back to SIN
			SF.tab $tab_sales_invoices
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			#SF.wait_for_search_button
			gen_compare _warning_message,CIF.get_header_toast_message,'Toast is displayed'
		end 
		gen_end_test "TST037381 - User is now informed on CIF page also, when status of document is changed to Ready to post."
	end
	
	after :all do
		#Delete Test Data
		login_user
		FFA.delete_new_data_and_wait
		_accounting_settings_delete = ["delete[SELECT Id from #{ORG_PREFIX}codaAccountingSettings__c];"]
		APEX.execute_commands _accounting_settings_delete
		SF.logout
	end
end