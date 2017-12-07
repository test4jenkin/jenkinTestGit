#--------------------------------------------------------------------#
#	TID : TID012821
# 	Pre-Requisite : Org with basedata.
# 	Setup Data:  cashentry_setup_data.rb.
#  	Product Area: Accounting - Cash entry and Matching (UI Test)
# 	Story: 26764 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Cash entry and Matching", :type => :request do
include_context "login"
include_context "logout_after_each"
	
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID012821 : UI Test - Accounting - Cash entry and Matching"
	end
	
	it "TID012821 : a custom field can be editable on completed cash entry through edit/List view" do
		gen_start_test "TID012821 : a custom field can be editable on completed cash entry through edit/List view"
		
		_line = 1
		_field_label = "Test Field"
		_test_field_locator = "//*[text()='#{_field_label}']/../following-sibling::td/input" #locator of the custom field created in additional data block as per the requirement of the test case
		_test_field_value = "TID012821"
		_column_cash_entry_number = "Cash Entry Number"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true	
		
		gen_start_test "Additional data required"
		begin
			SF.tab $tab_cash_entries
			SF.click_button_new
			CE.set_bank_account $bdu_bank_account_santander_current_account
			CE.line_set_account_name $bdu_account_algernon_partners_co
			FFA.click_new_line
			CE.line_set_cashentryvalue _line , "100.00"
			CE.line_set_account_reference _line, "CE123"
			FFA.click_save_post
			_cash_entry_number = SF.get_page_description
			SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
			SF.set_button_property_for_extended_layout			
		end
		
		gen_start_test "TST016457"
		begin
			SF.tab $tab_cash_entries
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			gen_compare_object_editable _test_field_locator, true, "Expected #{_field_label} to be editable"
			fill_in _field_label, :with => _test_field_value
			SF.click_button_save
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			_actual_test_field_value = find(:xpath, _test_field_locator)[:value]
			gen_compare _test_field_value, _actual_test_field_value, "Expected #{_field_label} value is updated"
		end
		gen_end_test "TID012821 : a custom field can be editable on completed cash entry through edit/List view"
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
		SF.choose_visualforce_page "codacashentryedit [codacashentryedit]"
		gen_end_test "TID012821 : UI Test - Accounting - Cash entry and Matching"
	end
end