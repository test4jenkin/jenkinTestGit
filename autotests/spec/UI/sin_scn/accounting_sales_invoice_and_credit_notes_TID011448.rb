#--------------------------------------------------------------------#
#	TID : TID011448
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Sales Invoice and Credit Notes (UI Test)
# 	Story: 25691 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Matching & Reconciliation for Sales Invoice extended layout", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "Matching & Reconciliation UI Test for Sales Invoice extended layout"
	end
	
	_expected_error_message = "Line number cannot be blank. Enter a valid value."
	_quantity_2 = 2
	
	it "TID011448 : Sales Invoice Line Item is not created/updated if Line Number is blank and Derive Line Number=false" do
		gen_start_test "TID011448 : Sales Invoice Line Item is not created/updated if Line Number is blank and Derive Line Number=false"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true		
		puts "Additional data required for TID011448"
		begin
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_invoice_line_item_extended_layout
		end
		gen_start_test "TST014316 : Sales Invoice Line Items is not created having line number fields Blank and Derive Line Number Unchecked"
		begin
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SINX.set_account $bdu_account_algernon_partners_co
			SF.click_button_save
			_invoice_number = SINX.get_invoice_number
			SINX.click_new_sales_invoice_line_items_button
			SINX.set_product_name $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SINX.set_product_derive_line_number false
			SINX.set_product_line_number nil
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected System to show validation message #{_expected_error_message}"
		end
		gen_start_test "TST014451 : Sales Invoice Line Items is not updated having line number fields Blank and Derive Line Number Unchecked"
		begin
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SINX.open_invoice_detail_page _invoice_number
			SINX.click_new_sales_invoice_line_items_button
			SINX.set_product_name $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SF.click_button_save
			SF.wait_for_search_button
			SF.click_button_edit
			SINX.set_product_quantity _quantity_2
			SINX.set_product_derive_line_number false
			SINX.set_product_line_number nil
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected System to show validation message #{_expected_error_message}"
		end
		gen_end_test "TID011448 : Sales Invoice Line Item is not created/updated if Line Number is blank and Derive Line Number=false"
	end

	after :all do
		login_user
		FFA.delete_new_data_and_wait
		puts "Revert additional data created for TID011448"
		begin
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_normal_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_edit
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_new
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_view
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_sales_invoice_line_item_normal_layout
		end
		gen_end_test "Matching & Reconciliation UI Test for Sales Invoice extended layout"
	end
end