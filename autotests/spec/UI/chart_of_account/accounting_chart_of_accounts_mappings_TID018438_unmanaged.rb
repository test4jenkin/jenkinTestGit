#--------------------------------------------------------------------#
#   TID : TID018438
#   Pre-Requisite: Org with basedata deployed; Deploy CODATID018438Data.cls on org
#   Product Area: Accounting - Chart of Accounts
#--------------------------------------------------------------------#

describe "Creates Chart Of Account Mappings through Sencha UI", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	_suffix = '#TID018438'
	_corporate_gla_4001 = '4001'+_suffix
	_corporate_gla_NAMEGLA_ACCOUNTSPAYABLECONTROLEUR = $bd_gla_account_payable_control_eur
	_corporate_gla_NAMEGLA_POSTAGEANDSTATIONERY = $bd_gla_postage_and_stationery
	_corporate_gla_NAMEGLA_VATINPUT = $bd_gla_vat_input
	_local_gla_60001 = '60001'+_suffix
	_local_gla_60002 = '60002'+_suffix
	_local_gla_60003 = '60003'+_suffix
	_local_gla_60004 = '60004'+_suffix
	_type_balance_sheet = 'Balance Sheet'
	_type_profit_loss = 'Profit and Loss'
	_coa_french = 'French'+_suffix
	_pin_layout_changed_to_cif_page=false
	_pcn_layout_changed_to_cif_page=false
	_cash_entry_layout_changed_to_cif_page=false
	_journal_layout_changed_to_cif_page=false
	
	before :all do
		#Hold Base Data
		gen_start_test "TID018189: Verify that GLA with COA = null or COA = Corporate should be displayed in Sencha page GLA fields."
		FFA.hold_base_data_and_wait
		
		begin
			#login and select merlin auto spain company.
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain],true
			#Execute the apex methods
			_create_data = ["CODATID018438Data.selectCompany();", "CODATID018438Data.createData();", "CODATID018438Data.createDataExt1();"]
			APEX.execute_commands _create_data
			# Update user company
			_update_user_company = "CodaUserCompany__c usercomp = [select Id, UseLocalAccount__c from codaUserCompany__c where Company__r.Name = 'Merlin Auto Spain' and User__c = :UserInfo.getUserId()]; usercomp.UseLocalAccount__c = false; update usercomp;"
			updateUserCompany = [_update_user_company]
			APEX.execute_commands updateUserCompany
			$cif_line_local_gla_enabled = true
		end
	end
  
	it "TST028813 - Verify the GLA displayed in GLA picklist on CIF payable invoice form ", :unmanaged => true  do
  
		gen_start_test "TST028813 - Verify the GLA displayed in GLA picklist on CIF payable invoice form "
		begin
			_pin_layout_changed_to_cif_page = true
			_vendor_invoice_number = "VIN0089"		
			_net_value_50 = '50'
			
			# Setting page layout to custom purchase Invoice  layout(Sencha)
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_edit
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_new
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_view
		
			SF.tab $tab_payable_invoices
			SF.click_button_new
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			CIF_PINV.set_pinv_account $bd_account_bmw_automobiles
			CIF_PINV.set_pinv_vendor_invoice_number _vendor_invoice_number
			CIF_PINV.click_payable_invoice_expense_line_items_tab
			CIF_PINV.click_new_row
			#Assert GLA values
			_pin_gla_not_present = CIF_PINV.is_gla_values_present [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ] ,1
			gen_compare false, _pin_gla_not_present, "GLAs should not be present #{_local_gla_60001}, #{_local_gla_60002}, #{_local_gla_60003} and #{_local_gla_60004}"
			_pin_gla_present = CIF_PINV.is_gla_values_present  [_corporate_gla_4001, $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us] ,1
			gen_compare true, _pin_gla_present, "GLAs should be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur} and #{$bd_gla_settlement_discounts_allowed_us}"
			
			CIF_PINV.set_pinv_expense_line_gla _corporate_gla_4001
			net_value_cell_num = CIF.get_line_column_number $cif_net_value_label
			CIF_PINV.click_column_grid_data_row 1, net_value_cell_num
			CIF_PINV.set_pinv_expense_line_net_value _net_value_50
			CIF.click_toggle_button
			CIF_PINV.click_pinv_save_button
			
			gen_compare $bd_document_status_in_progress,  CIF_PINV.get_payable_invoice_status, "Expected Payable Invoice status should be with In-Progress status"	
		end
		gen_end_test "TST028813 - Verify the GLA displayed in GLA picklist on CIF payable invoice form " 
	end
 
	it "TST028814 - Verify the GLA displayed in GLA picklist on CIF payable credit note form.", :unmanaged => true  do
		gen_start_test "TST028814 - Verify the GLA displayed in GLA picklist on CIF payable credit note form."
		login_user
		begin
			_pcn_layout_changed_to_cif_page = true
			_pcn_vendor_invoice_number = 'VCRN0089'
			
			# Setting page layout to custom payable credit note layout(Sencha)
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_edit				
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_new				
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_view
			
			SF.tab $tab_payable_credit_notes
			SF.click_button_new
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			CIF_PCN.set_pcn_account $bd_account_bmw_automobiles		
			CIF_PCN.set_pcn_vendor_credit_note_number _pcn_vendor_invoice_number
			CIF_PCN.click_payable_credit_note_expense_line_items_tab
			CIF_PCN.click_new_row
			#Assert GLA values
			_pcn_gla_not_present = CIF_PCN.is_gla_values_present [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ] ,1
			gen_compare false, _pcn_gla_not_present, "GLAs should not be present #{_local_gla_60001}, #{_local_gla_60002}, #{_local_gla_60003} and #{_local_gla_60004}"
			_pcn_gla_present = CIF_PCN.is_gla_values_present  [_corporate_gla_4001, $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us] ,1
			gen_compare true, _pcn_gla_present, "GLAs should be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur} and #{$bd_gla_settlement_discounts_allowed_us}"
			
			CIF_PCN.set_pcn_expense_line_gla _corporate_gla_4001
			CIF.wait_for_totals_to_calculate
			CIF_PCN.set_PCN_net_value "50"
			CIF.wait_for_totals_to_calculate
			CIF.click_toggle_button
			CIF_PCN.click_pcrn_save_button
			# check for Status 
			gen_compare $bd_document_status_in_progress,  CIF_PCN.get_payable_credit_note_status, "Expected Payable Credit Note status should be with In-Progress status"	
		end	
		gen_end_test "TST028814 - Verify the GLA displayed in GLA picklist on CIF payable credit note form."
	end
	
	it "TST028815 - Verify the GLA displayed in GLA picklist on CIF journal form.", :unmanaged => true  do
		gen_start_test "TST028815 - Verify the GLA displayed in GLA picklist on CIF journal form."
		login_user
		begin
		_journal_layout_changed_to_cif_page = true
			# Setting page layout to custom journal layout(Sencha)
			SF.object_button_edit $ffa_object_journal, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_edit
			SF.object_button_edit $ffa_object_journal, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_new
			SF.object_button_edit $ffa_object_journal, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_view
		
			#Creating journal Document with following line items
			SF.tab $tab_journals
			SF.click_button_new
			
			# Line 1
			CIF.click_new_row
			CIF_JNL.set_line_type $bd_jnl_line_type_account_customer
			CIF_JNL.click_toggle_button
			#Assert GLA values
			_pcn_gla_not_present = CIF_JNL.is_gla_values_present [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ] ,1
			gen_compare false, _pcn_gla_not_present, "GLAs should not be present #{_local_gla_60001}, #{_local_gla_60002}, #{_local_gla_60003} and #{_local_gla_60004}"
			_pcn_gla_present = CIF_JNL.is_gla_values_present  [_corporate_gla_4001, $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us] ,1
			gen_compare true, _pcn_gla_present, "GLAs should be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur} and #{$bd_gla_settlement_discounts_allowed_us}"
			
			CIF_JNL.set_gla _corporate_gla_4001
			CIF_JNL.set_account $bd_account_cambridge_auto
			CIF_JNL.set_value "10",1
			
			#Line 2
			CIF_JNL.set_line_type $bd_jnl_line_type_account_vendor
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_account_receivable_is ,2
			CIF_JNL.set_account $bd_account_bmw_automobiles,2
			CIF_JNL.set_value "10",2
			
			#Line 3
			CIF_JNL.set_line_type $bd_jnl_line_type_bank_account,3
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_bank_account_checking_us,3
			CIF_JNL.set_bank_account $bd_bank_account_santander_current_account,3
			CIF_JNL.set_value "10",3
			
			#Line 4
			CIF_JNL.set_line_type $bd_jnl_line_type_gla,4
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_accounts_payable_control_eur,4
			CIF_JNL.set_value "-60.00",4
			
			#Line 5
			CIF_JNL.set_line_type $bd_jnl_line_type_product_sales,5
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_settlement_discounts_allowed_us,5
			CIF_JNL.set_product $bd_product_auto_com_clutch_kit_1989_dodge_raider, 5
			CIF_JNL.set_value "10.00",5
			
			#Line 6
			CIF_JNL.set_line_type $bd_jnl_line_type_product_purchases,6
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_postage_and_stationery,6
			CIF_JNL.set_product $bd_product_bbk_fuel_pump_power_plus_series_universal, 6
			CIF_JNL.set_value "10.00",6
			
			#Line 7
			CIF_JNL.set_line_type $bd_jnl_line_type_tax_code,7
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_tax_is,7
			CIF_JNL.set_tax_code $bd_tax_code_bs,7
			CIF_JNL.set_value "10.00",7
			
			#Line 8
			CIF_JNL.set_line_type $bd_jnl_line_type_intercompany,8
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_bank_account_checking_us, 8
			CIF_JNL.set_line_field_destination_company $bd_comapny_merlin_auto_usa, 8
			CIF_JNL.set_value "0.00",8
			
			#Line 9
			CIF_JNL.set_line_type $bd_jnl_line_type_bank_account,9
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_bank_account_checking_us, 9
			CIF_JNL.set_bank_account $bd_bank_account_santander_current_account,9
			CIF_JNL.click_toggle_button
			
			#Save the document
			CIF_JNL.click_journal_save_button
			
			gen_compare $bd_document_status_in_progress,  CIF_JNL.get_journal_document_status, "Expected Journal status should be with In-Progress status"
		end
		gen_end_test "TST028815 - Verify the GLA displayed in GLA picklist on CIF journal form."
	end
	
	it "TST028816 - Verify the GLA displayed in GLA picklist on CIF cash entry form.", :unmanaged => true  do
		gen_start_test "TST028816 - Verify the GLA displayed in GLA picklist on CIF cash entry form."
		login_user
		begin
			_cash_entry_layout_changed_to_cif_page = true
			# Setting page layout to custom Cash Entry layout(Sencha)
			SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_edit	
			SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_new	
			SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_view
			
			SF.tab $tab_cash_entries
			SF.click_button_new
			CIF_CE.set_ce_type $bd_cash_entry_receipt_type
			CIF_CE.set_ce_bank_account $bd_bank_account_santander_current_account	
			CIF_CE.set_ce_payment_method $bd_cash_entry_payment_method_cash			
			#Assert GLA values
			_ce_charges_gla_not_present = CIF_CE.is_charges_gla_values_present [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ] ,1
			gen_compare false, _ce_charges_gla_not_present, "GLAs should not be present #{_local_gla_60001}, #{_local_gla_60002}, #{_local_gla_60003} and #{_local_gla_60004}"
			_ce_charges_gla_present = CIF_CE.is_charges_gla_values_present  [_corporate_gla_4001, $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us] ,1
			gen_compare true, _ce_charges_gla_present, "GLAs should be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur} and #{$bd_gla_settlement_discounts_allowed_us}"
			
			CIF_CE.set_ce_charges_gla _corporate_gla_4001
			CIF_CE.click_new_row
			CIF_CE.set_ce_account $bd_account_cambridge_auto
			CIF_CE.set_ce_cash_entry_value "67.00"
			CIF_CE.click_ce_save_button
			SF.wait_for_search_button
			
			gen_compare $bd_document_status_in_progress,  CIF_CE.get_ce_document_status, "Expected Cash Entry status should be with In-Progress status"
		end
		gen_end_test "TST028816 - Verify the GLA displayed in GLA picklist on CIF cash entry form."
	end
	
	it "TST028817 - Verify the GLA displayed in GLA picklist on Allocation sencha UI.", :unmanaged => true  do
		gen_start_test "TST028817 - Verify the GLA displayed in GLA picklist on Allocation sencha UI."
		login_user
		begin
			SF.tab $tab_allocations		
			SF.click_button_new
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			#Assert GLA values
			_alloc_gla_not_present = Allocations.get_matched_count_gla [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ]
			gen_compare 0, _alloc_gla_not_present, "GLAs should not be present #{_local_gla_60001}, #{_local_gla_60002}, #{_local_gla_60003} and #{_local_gla_60004}"
			_alloc_gla_present = Allocations.get_matched_count_gla  [_corporate_gla_4001, $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us]
			gen_compare 3, _alloc_gla_present, "GLAs should be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur} and #{$bd_gla_settlement_discounts_allowed_us}"		
		end
		gen_end_test "TST028817 - Verify the GLA displayed in GLA picklist on Allocation sencha UI."
	end
	
	it "TST028818 - Verify the GLA displayed in GLA picklist on payment selection sencha UI.", :unmanaged => true  do
		gen_start_test "TST028818 - Verify the GLA displayed in GLA picklist on payment selection sencha UI."
		login_user
		begin
			SF.tab $tab_payment_selection
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK		
			PAYSEL.set_gla_filter true
			PAYSEL.set_gla_value [_local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ]
			_paysel_gla_not_present = PAYSEL.get_matched_count_gla [_local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ]
			gen_compare 0, _paysel_gla_not_present, "GLAs should not be present #{_local_gla_60001}, #{_local_gla_60002}, #{_local_gla_60003} and #{_local_gla_60004}"
			PAYSEL.set_gla_value [ _corporate_gla_4001,  $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us ]
			_paysel_gla_present = PAYSEL.get_matched_count_gla [_corporate_gla_4001,  $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us ]
			gen_compare 3, _paysel_gla_present, "GLAs should be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur} and #{$bd_gla_settlement_discounts_allowed_us}"		
		end
		gen_end_test "TST028818 - Verify the GLA displayed in GLA picklist on payment selection sencha UI."
	end
	
	it "TST028819 - Verify the GLA displayed in GLA picklist on transaction reconcillation sencha UI.", :unmanaged => true   do
		gen_start_test "TST028819 - Verify the GLA displayed in GLA picklist on transaction reconcillation sencha UI."
		login_user
		begin
			SF.tab $tab_transaction_reconciliations
			SF.click_button_new
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK	
			TRANRECON.click_button $tranrecon_left_add_transaction_button
			_tran_rec_gla_not_present = TRANRECON.reconciliation_get_matched_count_gla $tranrecon_left_filter, [ _local_gla_60001,_local_gla_60002,_local_gla_60003,_local_gla_60004 ]
			gen_compare 0, _tran_rec_gla_not_present, "GLAs should not be present #{_local_gla_60001}, #{_local_gla_60002}, #{_local_gla_60003} and #{_local_gla_60004}"
			_tran_rec_gla_present = TRANRECON.reconciliation_get_matched_count_gla $tranrecon_left_filter, [_corporate_gla_4001, $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us]
			gen_compare 3, _tran_rec_gla_present, "GLAs should be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur} and #{$bd_gla_settlement_discounts_allowed_us}"
			TRANRECON.click_button $filter_popup_close_button			
		end
		gen_end_test "TST028819 - Verify the GLA displayed in GLA picklist on transaction reconcillation sencha UI."
	end
    
	after :all do
		login_user
		# Delete Test Data
		$cif_line_local_gla_enabled = false
		_delete_data = ["CODATID018438Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait		
		begin
			# Setting page layout to VF purchase Invoice  layout
			if(_pin_layout_changed_to_cif_page)
				# Setting page layout to VF purchase Invoice  layout
				SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_edit			
				SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_new			
				SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_view
			end
			
			if(_pcn_layout_changed_to_cif_page)
				# Setting page layout to VF payable credit note  layout
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_edit			
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_new			
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_view
			end

			if(_cash_entry_layout_changed_to_cif_page)
				# Setting page layout to VF cash entry  layout
				SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_edit			
				SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_new			
				SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_view
			end
			
			if(_journal_layout_changed_to_cif_page)
				# Setting page layout to VF journal  layout
				SF.object_button_edit $ffa_object_journal, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_edit			
				SF.object_button_edit $ffa_object_journal, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_new			
				SF.object_button_edit $ffa_object_journal, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_view			
			end			
		end		
		SF.logout
		gen_end_test "TID018438 : Verify the chart of account mappings functionality through Sencha UI."
	end
end