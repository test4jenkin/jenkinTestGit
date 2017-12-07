#--------------------------------------------------------------------#
#   TID : TID019917
#   Pre-Requisite: Org with basedata deployed.
#   Product Area: Payable Invoice and Payable Credit Note CIF
#   driver=firefox rspec -fd -c spec/UI/cif_tests/cif_payable_invoice_payable_credit_note_TID019917.rb -fh -o payable_ext.html
#--------------------------------------------------------------------#

describe "TID019917-TID verifies the GLA and local GLA field access on payable invoice and payable credit note CIF UI.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID019917: TID verifies the GLA and local GLA field access on payable invoice and payable credit note CIF UI."
		FFA.hold_base_data_and_wait
	end
  
  it "TID019917-Create,Save,Post payable invoice in Custom Input Form mode", :unmanaged => true  do
	
    # login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_spain],true
	#Execute the apex methods
	_create_data = ["CODATID019917Data.selectCompany();", "CODATID019917Data.createData();", "CODATID019917Data.createDataExt1();"]
	APEX.execute_commands _create_data

    # #TST032390  - Verify the GLA and local GLA field access on payable invoice CIF UI.
    gen_start_test "TST032390 - Verify the GLA and local GLA field access on payable invoice CIF UI."
    begin
		_invoice_number = 'VIN#TST032390'
		SF.tab $tab_payable_invoices
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
		CIF_PINV.set_pinv_invoice_currency $bd_currency_eur
		CIF_PINV.set_pinv_vendor_invoice_number _invoice_number
		
		CIF_PINV.click_payable_invoice_expense_line_items_tab
		
		#Verify Line Number column is visible on Product Line Item tab (New page)
		
		#add expense line item 1 
		CIF_PINV.click_new_row
		gen_assert_enabled $cif_payable_invoice_expense_line_general_ledger_account
		CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_expense_line_general_ledger_account_column_number + 1
		page.has_no_css?($cif_payable_invoice_expense_line_local_general_ledger_account)
		CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_expense_line_general_ledger_account_column_number
		CIF_PINV.set_pinv_expense_line_gla $bd_gla_postage_and_stationery
		CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_expense_line_net_value_column_number + 1
		CIF.wait_for_totals_to_calculate
		CIF_PINV.set_pinv_expense_line_net_value 50
		
		CIF_PINV.click_pinv_save_post_button
		gen_wait_until_object_disappear $cif_save_post_button
		CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
		gen_compare $bd_document_status_complete, CIF_PINV.get_payable_invoice_status, 'Invoice status matched to complete'
	end
	gen_end_test "TST032390 - Verify the GLA and local GLA field access on payable invoice CIF UI."

	# #TST032391  - Verify the GLA and local GLA field access on payable credit note CIF UI.
    gen_start_test "TST032391 - Verify the GLA and local GLA field access on payable credit note CIF UI."
	
    begin
		begin
		_update_user_company = "CodaUserCompany__c usercomp = [select Id, UseLocalAccount__c from codaUserCompany__c where Company__r.Name = 'Merlin Auto Spain' and User__c = :UserInfo.getUserId()]; usercomp.UseLocalAccount__c = true; update usercomp;"
		updateUserCompany = [_update_user_company]
		APEX.execute_commands updateUserCompany
		end
		
		#Create Payable credit notes
		pcn_number = 'VCRN#TST032391'
		SF.tab $tab_payable_credit_notes
		SF.click_button_new
		CIF.wait_for_buttons_to_load
		CIF_PCN.set_pcn_account $bd_account_bmw_automobiles
		CIF_PCN.set_pcn_credit_note_currency $bd_currency_eur
		CIF_PCN.set_pcn_vendor_credit_note_number pcn_number
		
		CIF_PCN.click_payable_credit_note_expense_line_items_tab
		CIF_PCN.click_new_row
		CIF_PCN.click_column_grid_data_row 1, $cif_payable_credit_note_expense_line_local_general_ledger_account_column_number
		page.has_no_css?($cif_payable_credit_note_expense_line_general_ledger_account)
		CIF_PCN.click_column_grid_data_row 1, $cif_payable_credit_note_expense_line_local_general_ledger_account_column_number
		gen_assert_enabled $cif_payable_credit_note_expense_line_local_general_ledger_account
		CIF_PCN.set_pcn_expense_line_local_gla 60002
	end
	gen_end_test "TST032391 - Verify the GLA and local GLA field access on payable credit note CIF UI."
	end
	
	after :all do
		login_user
		# Delete Test Data
		begin
		_update_user_company = "CodaUserCompany__c usercomp = [select Id, UseLocalAccount__c from codaUserCompany__c where Company__r.Name = 'Merlin Auto Spain' and User__c = :UserInfo.getUserId()]; usercomp.UseLocalAccount__c = false; update usercomp;"
		updateUserCompany = [_update_user_company]
		APEX.execute_commands updateUserCompany
		end
		
		_delete_data = ["CODATID019917Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		
		SF.wait_for_apex_job
		SF.logout
  gen_end_test "TID019917: TID verifies the GLA and local GLA field access on payable invoice and payable credit note CIF UI."
 end
 end
 