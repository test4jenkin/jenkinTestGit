#--------------------------------------------------------------------#
#	TID : TID011524
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Sales Invoice and Credit Notes (UI Test)
# 	Story: 25691 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Matching & Reconciliation for Sales Credit Note extended layout", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "Matching & Reconciliation UI Test for Sales Credit Note extended layout"
	end
	
	_expected_error_message = "Line number cannot be blank. Enter a valid value."
	_quantity_2 = 2
	
	it "TID011524 : Sales credit note line item is not created/updated if Line Number is blank and Derive Line Number=false" do
		gen_start_test "TID011524 : Sales credit note line item is not created/updated if Line Number is blank and Derive Line Number=false"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true		
		puts "Additional data required for TID011524"
		begin
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_credit_note_line_item_extended_layout
		end
		
		gen_start_test "TST014448 : Sales Credit Note Line Item is not created , having Line Number fields Blank and Derive Line Number Unchecked"
		begin
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCRX.set_account $bdu_account_algernon_partners_co
			SF.click_button_save
			_credit_note_number = SCRX.get_credit_note_number
			SCRX.click_new_sales_credit_note_line_items_button
			SCRX.set_product $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SCRX.set_line_number nil
			SCRX.set_derive_line_number false
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected System to show validation message #{_expected_error_message}"
		end
		
		gen_start_test "TST014452 : Sales Credit Note Line Item is not updated, having Line Number fields Blank and Derive Line Number Unchecked"
		begin
			SF.tab $tab_sales_credit_notes
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SCRX.open_credit_note_detail_page _credit_note_number
			SCRX.click_new_sales_credit_note_line_items_button
			SCRX.set_product $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			SF.click_button_save
			SF.wait_for_search_button
			SF.click_button_edit
			SCRX.set_quantity _quantity_2
			SCRX.set_line_number nil
			SCRX.set_derive_line_number false
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected System to show validation message #{_expected_error_message}"
		end
		gen_end_test "TID011524 : Sales credit note line item is not created/updated if Line Number is blank and Derive Line Number=false"
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		puts "Revert additional data created for TID011524"
		begin
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_normal_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_edit
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_new
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_view
			SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_sales_credit_note_line_items_normal_layout
			SF.logout
		end
		gen_end_test "Matching & Reconciliation UI Test for Sales Credit Note extended layout"
	end
end