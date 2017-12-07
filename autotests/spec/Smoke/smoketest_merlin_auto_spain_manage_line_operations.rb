#--------------------------------------------------------------------------------------------#
#	TID : TID021611
# 	Pre-Requisit: Org with basedata deployed, smoketest_data_setup
#  	Product Area: Create documents and add line using manage line operations.
# 	Story: AC-11916
#--------------------------------------------------------------------------------------------#

describe "TID021611:Smoke Test - Accounting - Manage Line operation on documents.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	#Layout change boolean values
	_is_sin_layout_changed = false
	_is_scr_layout_changed = false
	_is_pin_layout_changed = false
	_is_pcr_layout_changed = false
	_is_jnl_layout_changed = false
	# local variables 
	_manage_expense_line_net_value_100 = "100.00"
	_line_1 = "1"
	_line_2 = "2"
	_quanity_1 ="1"
	_quanity_2 = "2"
	_price_100 = "100.00"
	_price_150 = "150.00"
	_price_200 = "200.00"
	_pin_total_347_50 = "347.50"
	_scr_total_345 =  "345.00"
	_sin_total_115 = "115.00"
	_vendor_inv_number = "PIN_124"
	_vendor_credit_note_number = "PCR_124"
	_jnl_reference= "JNL_321"
	
	before :all do
		#Hold base data
		FFA.hold_base_data_and_wait
		gen_start_test "TID021611: Manage Line Operations."
		# select COmpany
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		#Update Accounts Payable Control for Algernon and Partner Account and Update Purchase Analysis Account for Champagne
		_command_to_execute_update_account= ""
		_command_to_execute_update_account +=" Account  acc = [SELECT Id, "+ORG_PREFIX+"CODAAccountsPayableControl__c FROM Account where MirrorName__c='#{$bd_account_algernon_partners_co}'];"
		_command_to_execute_update_account +=""+ORG_PREFIX+"codaGeneralLedgerAccount__c gla =[select id from "+ORG_PREFIX+"codaGeneralLedgerAccount__c where name ='Accounts Payable Control - EUR'] ;"
		_command_to_execute_update_account +=" acc."+ORG_PREFIX+"CODAAccountsPayableControl__c= gla.id;"
		_command_to_execute_update_account +=" update acc;"
		#Execute commands for Account and Product update
		APEX.execute_commands [_command_to_execute_update_account]
	end
	
	it "TST038121 Implemented : Create sales invoice and add line using manage lines. " do
		gen_start_test "TST038121 : Create payable invoice on standard layout."	
		_is_sin_layout_changed = true
		puts "Additional data required for TST038121"
		begin
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_extended_layout
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_invoice_line_item_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
		end
		gen_start_test "TST038121: Create Invoice and Add lines using Manage lines. "
		begin
			# Create Invoice and add line items.
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SF.wait_for_search_button
			SINX.set_account $bd_account_algernon_partners_co
			SF.click_button_save
			SF.wait_for_search_button
			FFA.click_manage_line
			SINX.add_line_items _line_1 , $bd_product_a4_paper , _quanity_1 , _price_100 , $bd_tax_code_vo_s
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
			page.has_button?($ffa_post_button)
			FFA.click_post
			SINX.click_post_invoice
			gen_compare SINX.get_invoice_status , $bd_document_status_complete , "Expected Invoice status : Complete."
			gen_compare SINX.get_invoice_total , _sin_total_115,"Expected Invoice Total : #{_sin_total_115}"
		end
		gen_end_test "TST038121: Create Invoice and Add lines using Manage lines. "
	end
	
	it "TST038122 Implemented : Create Sales credit note  and add line using manage lines. " do
		gen_start_test "TST038122 : Create sales credit note on standard layout."
		
		login_user
		_is_scr_layout_changed = true
		puts "Additional data required for TST038122"
		begin
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_credit_note_line_item_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout
		end
		gen_start_test "TST038122: Create Credit Note and Add lines using Manage lines. "
		begin
			# Create Invoice and add line items.
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SF.wait_for_search_button
			SCRX.set_account $bd_account_algernon_partners_co
			SF.click_button_save
			SF.wait_for_search_button
			FFA.click_manage_line
			SCRX.add_line_items _line_1 , $bd_product_a4_paper , _quanity_2 , _price_150 , $bd_tax_code_vo_s
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
			page.has_button?($ffa_post_button)
			FFA.click_post
			SF.wait_for_search_button
			FFA.click_continue
			SF.wait_for_search_button
			_credit_note_number = SCRX.get_credit_note_number
			_transaction_number = SCRX.get_credit_note_transaction_number
			
			# Expected result
			gen_include "TRN" ,  _transaction_number , "TST038122: Expected transaction number generated to have prefix TRN."
			_credit_note_status = SCRX.get_credit_note_status
			gen_compare _credit_note_status , $bd_document_status_complete , "TST038122: Expected credit note status : Complete."
			gen_compare _scr_total_345 , SCRX.get_credit_note_total , "TST038122: Expected credit note Total : #{_scr_total_345} ."
		end
		gen_end_test "TST038122: Create Credit Note and Add lines using Manage lines. "
	end
	
	it "TST038125 Implemented : Create payable invoice and add line using manage lines. " do
		gen_start_test "TST038125 : Create payable invoice on standard layout."
		login_user
		_is_pin_layout_changed = true
		puts "Additional data required for TST038125"
		begin
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.edit_extended_layout $ffa_object_payable_invoice_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_payable_invoice_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_expense_line_item_extended_layout
		end
		
		gen_start_test "TST038125 : Create new payable invoice with product and expanse line items using manage lines"
		begin
			begin
				SF.tab $tab_payable_invoices
				SF.click_button_new
				PINEXT.set_account $bd_account_algernon_partners_co
				PINEXT.set_copy_account_values true
				PINEXT.set_derive_due_date true
				PINEXT.set_derive_period true
				PINEXT.set_derive_currency true
				PINEXT.set_vendor_invoice_number _vendor_inv_number
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, PINEXT.get_invoice_status, "Expected New payable invoice should be created successfully"
			end	
			begin
				PINEXT.click_manage_product_lines_button
				PINEXT.manage_product_line_set_product _line_1, $bd_product_a4_paper
				PINEXT.manage_product_line_set_unit_price _line_1 , _price_200
				PINEXT.manage_product_line_set_tax_code _line_1 , $bd_tax_code_vo_s
				# Save the lines.
				page.has_button?($ffa_save_button)
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PINEXT.within_product_line_section do
					within(:xpath,$pinext_product_line_item_section) do
						expect(page).to have_link($bd_product_a4_paper, :count => 1)
						gen_report_test "Expected a new product line item #{$bd_product_a4_paper} to be saved successfully"
					end
				end
			end
			begin
				PINEXT.click_manage_expense_lines_button
				PINEXT.manage_expense_line_set_gla _line_1, $bd_gla_postage_and_stationery
				PINEXT.manage_expense_line_set_net_value _line_1, _manage_expense_line_net_value_100
				PINEXT.manage_line_set_input_tax_code _line_1, $bd_tax_code_vo_std_purchase
				page.has_button?($ffa_save_button)
				# Save the expense lines
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PINEXT.within_expense_line_section do
					within(:xpath,$pinext_expense_line_item_section) do
						expect(page).to have_link($bd_gla_postage_and_stationery, :count => 1)
						gen_report_test "Expected a new expense line item #{$bd_gla_postage_and_stationery} to be saved successfully."
					end
				end
				FFA.click_post
				# Confirm the post operation
				FFA.click_post
				gen_compare PINEXT.get_invoice_status , $bd_document_status_complete , "TST038122: Expected PIN status : Complete."
				gen_compare PINEXT.get_invoice_total , _pin_total_347_50 , "TST038122: Expected PIN toatl to be #{_pin_total_347_50} ."
			end
			gen_end_test "TST038125 : Create new payable invoice with product and expanse line items using manage lines"
		end
	end

	it "TST038126 Implemented : Create payable Credit note and add line using manage lines. " , :run=>true do
		gen_start_test "TST038126 Implemented : New payable credit note with product and expense line items"
		login_user
		_is_pcr_layout_changed = true
		# update layout	
		SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_system_administrator, $ffa_purchase_credit_note_extended_layout
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
		SF.set_button_property_for_extended_layout
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
		SF.set_button_property_for_extended_layout
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
		SF.set_button_property_for_extended_layout
		SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_line_item_extended_layout
		SF.edit_extended_layout $ffa_object_payable_credit_note_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_expense_line_item_extended_layout
		
		begin
			begin
				SF.tab $tab_payable_credit_notes
				SF.click_button_new
				PCREXT.set_account $bd_account_algernon_partners_co
				PCREXT.set_copy_account_values true
				PCREXT.set_derive_due_date true
				PCREXT.set_derive_period true
				PCREXT.set_derive_currency true
				PCREXT.set_vendor_credit_note_number _vendor_credit_note_number
				SF.click_button_save
				SF.wait_for_search_button
				_credit_note_number = PCREXT.get_credit_note_number
				gen_compare $bd_document_status_in_progress, PCREXT.get_credit_note_status, "Expected New payable credit note to be created successfully"
			end
			begin
				PCREXT.click_manage_product_lines_button
				PCREXT.manage_product_line_set_product _line_1, $bd_product_a4_paper
				PCREXT.manage_product_line_set_tax_code _line_1, $bd_tax_code_vo_s
				PCREXT.manage_product_line_set_unit_price _line_1,_price_200
				page.has_button?($ffa_save_button)
				# click save button
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PCREXT.within_product_line_section do
					within(:xpath,$pcrext_product_line_item_section) do
						expect(page).to have_link($bd_product_a4_paper, :count => 1)
						gen_report_test "Expected a new product line item #{$bd_product_a4_paper} to be saved successfully. "
					end
				end
			end
			begin
				PCREXT.click_manage_expense_lines_button
				PCREXT.manage_expense_line_set_gla _line_1, $bd_gla_postage_and_stationery
				PCREXT.manage_expense_line_set_net_value _line_1, _manage_expense_line_net_value_100
				PCREXT.manage_line_set_input_tax_code _line_1, $bd_tax_code_vo_std_purchase
				page.has_button?($ffa_save_button)
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				PCREXT.within_expense_line_section do
					within(:xpath,$pcrext_expense_line_item_section) do
						expect(page).to have_link($bd_gla_postage_and_stationery, :count => 1)
						gen_report_test "Expected a new expense line item to be saved successfully. "
					end
				end
			end
			FFA.click_post
			# Confirm the post operation
			FFA.click_post
			gen_compare PCREXT.get_credit_note_status , $bd_document_status_complete , " Expected PCR status : Complete."
			gen_compare  PCREXT.get_credit_note_total , "347.50" , ": Expected PCR toatl to be 347.50 ."
		end
	end
	
	it "TST038134 Implemented : Create Journal and add line using manage lines. " do
		gen_start_test "TST038134 : Create journal on standard layout."
		login_user
		_is_jnl_layout_changed = true
		puts "Additional data required for 	TST038134"
		begin
			SF.edit_extended_layout $ffa_object_journal, $ffa_profile_system_administrator, $ffa_journal_extended_layout
			SF.edit_extended_layout $ffa_object_journal_line_item, $ffa_profile_system_administrator, $ffa_journal_line_items_extended_layout
			SF.object_button_edit $ffa_object_journal, $sf_edit_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_journal, $sf_new_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_journal, $sf_view_button
			SF.set_button_property_for_extended_layout	
		end
		begin
			# Create journal and add line items.
			SF.tab $tab_journals
			SF.click_button_new
			JNLEXT.set_journal_reference _jnl_reference
			JNLEXT.click_save_button
			SF.wait_for_search_button
			# Add Lines using manage line
			JNLEXT.click_manage_line_button
			page.has_button?($ffa_save_button)
			JNLEXT.select_line_type _line_1, $bd_jnl_line_type_account_customer
			JNLEXT.set_manage_line_account_value _line_1 , $bd_account_algernon_partners_co
			JNLEXT.set_manage_line_gla_value _line_1 , $bd_gla_sales_parts
			JNLEXT.set_manage_line_value _line_1, "100.00"
			# Add new line
			JNLEXT.click_new_line_button
			JNLEXT.select_line_type _line_2 , $bd_jnl_line_type_gla
			JNLEXT.set_manage_line_gla_value _line_2 , $bd_gla_sales_parts
			JNLEXT.set_manage_line_value _line_2, "-100.00"
			JNLEXT.click_save_button
			gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
			# Post the journal
			FFA.click_post
			SF.tab $tab_journals
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.edit_list_view $bd_select_view_all, $jnlext_line_journal_status_label, 4
			# Assert Status of Journal
			_document_status = FFA.get_column_value_in_grid $jnlext_line_reference_label , _jnl_reference , $jnlext_line_journal_status_label
			gen_compare _document_status , $bd_document_status_complete , " Expected journal status : Complete."
		end
	end
	
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		puts "Revert additional data setup"
		#Update Accounts Payable Control for Algernon Partner Account and Update Purchase Analysis Account for Champagne
		_command_to_execute_update_account= ""
		_command_to_execute_update_account +=" Account  acc = [SELECT Id, "+ORG_PREFIX+"CODAAccountsPayableControl__c FROM Account where MirrorName__c='#{$bd_account_algernon_partners_co}'];"
		_command_to_execute_update_account +=""+ORG_PREFIX+"codaGeneralLedgerAccount__c gla =[select id from "+ORG_PREFIX+"codaGeneralLedgerAccount__c where name ='Accounts Payable Control - EUR'] ;"
		_command_to_execute_update_account +=" acc."+ORG_PREFIX+"CODAAccountsPayableControl__c= null;"
		_command_to_execute_update_account +=" update acc;"
		# Execute commands for Account and Product update
		APEX.execute_commands [_command_to_execute_update_account]
		# Change layouts 
		begin
			if _is_pin_layout_changed
				SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_layout
				SF.edit_extended_layout $ffa_object_payable_invoice_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_line_item_layout
				SF.edit_extended_layout $ffa_object_payable_invoice_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_invoice_expense_line_item_layout
				
				SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_edit
				
				SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_new
		
				SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_view
			end
			if _is_pcr_layout_changed
				SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_system_administrator, $ffa_purchase_credit_note_layout
				SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_line_item_layout
				SF.edit_extended_layout $ffa_object_payable_credit_note_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_expense_line_item_layout
				
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_edit
				
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_new
				
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_view
			end
			if _is_sin_layout_changed
			# Changing the layout of invoice,credit note and line items again to normal layout
				SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_normal_layout
				SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_sales_invoice_line_item_normal_layout
				
				# changing button properties to normal
				SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_new
				
				SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_edit
				
				SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_view
			end
			if _is_scr_layout_changed
				SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_normal_layout
				SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_sales_credit_note_line_items_normal_layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_new
				
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_edit
				
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_view
			end
			if _is_jnl_layout_changed
				SF.edit_extended_layout $ffa_object_journal, $ffa_profile_system_administrator, $ffa_journal_normal_layout
				SF.edit_extended_layout $ffa_object_journal_line_item, $ffa_profile_system_administrator, $ffa_journal_line_items_normal_layout
				SF.object_button_edit $ffa_object_journal, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_edit			
				SF.object_button_edit $ffa_object_journal, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_new			
				SF.object_button_edit $ffa_object_journal, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_view		
			end
		end
		gen_end_test "TID021611:Smoke Test - Accounting - Manage Line operation on documents."
		SF.logout 
	end
end
