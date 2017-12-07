#--------------------------------------------------------------------#
#	TID :  TID020900
# 	Pre-Requisite: Org with basedata deployed. Autotest folder should have been deployed on the org,
#			org should have CB_test button on cash entry object.
#  	Product Area: CIF
# 	Story:  
#--------------------------------------------------------------------#
describe "UI Test - Cash Entry Custom Button", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	_custom_button_name = $cif_ce_custom_button_label
	_object_name = $ffa_object_cash_entry
	_page_layout_name = $ffa_cash_entry_normal_layout
	_CE_REFERENCE = "#TID020900"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait	
	end
	it "Checks custom button visibility on CIF layout", :unmanaged => true do
		begin
			_create_data = ["CODATID020900Data.selectCompany();", "CODATID020900Data.createData();"]
			APEX.execute_commands _create_data
		end
		gen_start_test "TST035258 - Check the Visibility of newly created custom button on CIF UI on cash entry"
		begin
			#Verify that no button named CB Test exist on the Cash Entry CIF view layout, as it is not added to the page layout assigned to User.
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_cash_entry_number = FFA.get_column_value_in_grid $label_cash_entry_reference, _CE_REFERENCE, $label_cashentry_number
			CE.open_cash_entry_detail_page _cash_entry_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			expect(page).not_to have_content(_custom_button_name)
			gen_report_test "Expected custom button CB_test not to be present, "
			#Add button to layout
			SF.edit_layout_add_field _object_name, _page_layout_name, $sf_layout_panel_button, [_custom_button_name], $sf_edit_page_layout_target_position_button
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			CE.open_cash_entry_detail_page _cash_entry_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			expect(page).to have_content(_custom_button_name)
			gen_report_test "Expected custom button CB_test to be present, "
			CIF_CE.click_custom_button_cb_test
			FFA.new_window do
				expect(page).to have_content($cif_ce_custom_button_cb_test_vf_page_text)
				gen_report_test "Expected clicking on custom button CB_test opens a new vf page, "
			end
		end
		gen_end_test "TST035258 - Check the Visibility of newly created custom button on CIF UI on cash entry"
	end
	after :all do
		login_user
		_destroy_data_TID020900 = ["CODATID020900Data.destroyData();"]
		APEX.execute_commands _destroy_data_TID020900
		# Remove Custom button from the page layout
		SF.edit_layout_remove_button _object_name, _page_layout_name, _custom_button_name, $sf_label_custom
		SF.logout
		gen_end_test "TID020900: Verify custom button visibility on CIF page"    
	end
end