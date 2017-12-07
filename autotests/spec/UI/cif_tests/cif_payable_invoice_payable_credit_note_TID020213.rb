#--------------------------------------------------------------------#
#   TID : TID020213 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_payable_invoice_payable_credit_note_TID020213.rb -fh -o cif_default_gla.html
#--------------------------------------------------------------------#

describe "TID020213-This TID verifies that GLA field is populated automatically on adding new line on CIF for PIN and PCN", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		
		begin
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
		end
	end	
	
	it "TID020213 - GLA field populated automatically on adding new line on CIF for PIN" do
		gen_start_test "TST033091: Verify GLA field is populated on adding new line on CIF for PIN"
		_pinv_vendor_invoice_number = "PIN020213"
		_row_number = 1
		begin
			#"execute script as anonymous user" 
			create_additional_data = ["#{ORG_PREFIX}codaGeneralLedgerAccount__c gla = [Select id from #{ORG_PREFIX}codaGeneralLedgerAccount__c where Name = '#{$bd_gla_sales_parts}' limit 1];Account acc = [select #{ORG_PREFIX}CODADefaultExpenseAccount__c from Account where MirrorName__c = '#{$bd_account_apex_eur_account}' limit 1];acc.#{ORG_PREFIX}CODADefaultExpenseAccount__c = gla.Id;update acc;"]
			APEX.execute_commands create_additional_data
			SF.tab $tab_payable_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.click_button_new
			CIF_PINV.set_pinv_account $bd_account_apex_eur_account
			CIF_PINV.set_pinv_vendor_invoice_number _pinv_vendor_invoice_number
			CIF_PINV.click_payable_invoice_expense_line_items_tab
			CIF.click_toggle_button
			CIF_PINV.click_new_row
			gen_tab_out $cif_payable_invoice_expense_line_general_ledger_account
			_actual_gla = CIF_PINV.get_column_value_from_grid_data_row _row_number,$cif_payable_invoice_expense_line_general_ledger_account_column_number
			gen_compare $bd_gla_sales_parts, _actual_gla, "Expected GLA value is #{$bd_gla_sales_parts}"
			CIF.click_toggle_button
		end
		gen_end_test "TST033091: Verify GLA field is populated on adding new line on CIF for PIN"
	end
	
	it 	"TID020213 - GLA field populated automatically on adding new line on CIF for PCN" do
		gen_start_test "TST033125: Verify GLA field is populated on adding new line on CIF for PCN"
		login_user
		_pcn_vendor_credit_note_number = "PCN020213"
		_row_number = 1
		begin
			SF.tab $tab_payable_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.click_button_new
			CIF_PCN.set_pcn_account $bd_account_apex_eur_account
			CIF_PCN.set_pcn_vendor_credit_note_number _pcn_vendor_credit_note_number
			CIF_PCN.click_payable_credit_note_expense_line_items_tab
			CIF.click_toggle_button
			CIF_PCN.click_new_row
			gen_tab_out $cif_payable_credit_note_expense_line_general_ledger_account
			_actual_gla = CIF_PCN.get_column_value_from_grid_data_row _row_number,$cif_payable_credit_note_expense_line_general_ledger_account_column_number
			gen_compare $bd_gla_sales_parts, _actual_gla, "Expected GLA value is #{$bd_gla_sales_parts}"
			CIF.click_toggle_button
		end
		gen_end_test "TST033125: Verify GLA field is populated on adding new line on CIF for PCN"
	end
	
	after :all do
        login_user
		destroy_additional_data = ["Account acc = [select #{ORG_PREFIX}CODADefaultExpenseAccount__c from Account where MirrorName__c = '#{$bd_account_apex_eur_account}' limit 1];acc.#{ORG_PREFIX}CODADefaultExpenseAccount__c = null;update acc;"]
		APEX.execute_commands destroy_additional_data
		SF.logout		
		gen_end_test "TID020213: Verify GLA field is populated on adding new line on CIF for Payable Documents" 	
	end
	
end
		
	

