#--------------------------------------------------------------------#
#	TID : TID014284
# 	Pre-Requisite : Org with basedata deployed, 
#	Setup Data: pin_pcn_data.rb
#  	Product Area: Accounting - Payables Invoices & Credit Notes (UI Test)
# 	Story: 26950
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Payables Invoices & Credit Notes", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID014284 : Accounting - Payables Invoices & Credit Notes UI Test"
	end
	
	it "TID014284 : System should allow an admin user to create/update payable invoice in a company that's not selected as current company." do
		gen_start_test "TID014284 : System should allow an admin user to create/update payable invoice in a company that's not selected as current company."

		_field_name_owner_company = "Owner Company"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true	
		
		puts "Additional data required for TID014284"
		begin
			# Set extended layout for payable invoice
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_extended_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout			
		end
		
		gen_start_test "TST019228 : System should allow an admin user to create payable invoice in a company that's not selected as current company."
		begin
			# Create payable invoice
			SF.tab $tab_payable_invoices
			SF.click_button_new
			PINEXT.set_account $bdu_account_bmw_automobiles
			PINEXT.set_company $company_merlin_auto_gb
			PINEXT.set_vendor_invoice_number "VIN123"
			SF.click_button_save
			_pay_inv_number = PINEXT.get_invoice_number
			
			# Verify payable invoice status and company
			gen_compare $bdu_document_status_in_progress, PINEXT.get_invoice_status, "Expected payable invoice to be of status #{$bdu_document_status_in_progress}"
			gen_compare $company_merlin_auto_gb, PINEXT.get_company, "Expected payable invoice to be created in company #{$company_merlin_auto_gb}"
			
			# Verify payable invoice period to be of company "Merlin Auto GB"
			PINEXT.click_period_link
			gen_compare $company_merlin_auto_gb, PERIOD.get_owner_company, "Expected owner company to be #{$company_merlin_auto_gb}"
			SF.tab $tab_payable_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SF.click_link _pay_inv_number
			
			# Verify payable invoice currency to be of company "Merlin Auto GB"
			PINEXT.click_invoice_currency
			gen_include $company_merlin_auto_gb, AccountingCurrency.get_owner_value, "Expected owner value to include #{$company_merlin_auto_gb}"
			
			# Create new payable invoice expense line item
			SF.tab $tab_payable_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SF.click_link _pay_inv_number
			PINEXT.click_new_payable_invoice_expense_line_item_button
			PINEXT.set_net_value "100"
			PINEXT.set_gla $bdu_gla_account_payable_control_eur
			PINEXT.set_line_company $company_merlin_auto_gb
			SF.click_button_save
			
			# Verify company on payable invoice expense line item
			gen_compare $company_merlin_auto_gb, PINEXT.get_company, "Expected company to be #{$company_merlin_auto_gb}"
			PINEXT.click_payable_invoice_number
			
			# Create new payable invoice line item
			PINEXT.click_new_payable_invoice_line_item_button
			PINEXT.set_product $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			PINEXT.set_unit_price "10.00"
			PINEXT.set_line_company $company_merlin_auto_gb
			SF.click_button_save
			
			# Verify company on payable invoice line item
			gen_compare $company_merlin_auto_gb, PINEXT.get_company, "Expected company to be #{$company_merlin_auto_gb}"
		end
		
		gen_start_test "TST019232 : System should allow an admin user to update payable invoice in a company that's not selected as current company."
		begin
			PINEXT.click_payable_invoice_number
			SF.click_button_edit
			PINEXT.set_vendor_invoice_number "VIN14284"
			SF.click_button_save
			
			# Verify payable invoice status and company
			gen_compare $bdu_document_status_in_progress, PINEXT.get_invoice_status, "Expected payable invoice to be of status #{$bdu_document_status_in_progress}"
			gen_compare $company_merlin_auto_gb, PINEXT.get_company, "Expected payable invoice to be created in company #{$company_merlin_auto_gb}"
			
			# Verify payable invoice period to be of company "Merlin Auto GB"
			PINEXT.click_period_link
			gen_compare $company_merlin_auto_gb, PERIOD.get_owner_company, "Expected owner company to be #{$company_merlin_auto_gb}"
			SF.tab $tab_payable_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SF.click_link _pay_inv_number
			
			# Verify payable invoice currency to be of company "Merlin Auto GB"
			PINEXT.click_invoice_currency
			gen_include $company_merlin_auto_gb, AccountingCurrency.get_owner_value, "Expected owner value to include #{$company_merlin_auto_gb}"
		end
		gen_end_test "TID014284 : System should allow an admin user to create/update payable invoice in a company that's not selected as current company."
	end
	
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		puts "Revert additional data"
		begin
			SF.edit_extended_layout $ffa_object_payable_invoice, $ffa_profile_system_administrator, $ffa_purchase_invoice_layout
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_purchase_invoice_new
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_purchase_invoice_edit
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_purchase_invoice_view
		end
		gen_end_test "TID014284 : Accounting - Payables Invoices & Credit Notes UI Test"
	end
end