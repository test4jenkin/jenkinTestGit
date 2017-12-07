#--------------------------------------------------------------------#
#   TID : TID021069 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_cash_entry_TID021069.rb -fh -o cif_cash_entry_TID021069.html
#--------------------------------------------------------------------#

describe "TID021069 - Optional availability of Sharing and Submit for Approval buttons on Cash Entry CIF view page", :type => :request do
	include_context "login"	
	include_context "logout_after_each"	
	_CE_REFERENCE = "#TID021069"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait	
	end
	it "TID021069 - Checks standard button visibility on CIF layout", :unmanaged => true  do
		begin
			_create_data = ["CODATID021069Data.selectCompany();", "CODATID021069Data.createData();"]
			APEX.execute_commands _create_data
		end
		gen_start_test "TST035924 - Check the Visibility of sharing and submit for Approval buttons on CIF UI for Cash Entry"
		begin
			#Verify that Sharing button exists on the Cash Entry CIF view layout
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_cash_entry_number = FFA.get_column_value_in_grid $label_cash_entry_reference, _CE_REFERENCE, $label_cashentry_number
			CE.open_cash_entry_detail_page _cash_entry_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			gen_compare_object_visible $cif_sharing_button, true, "Expected Sharing button present on UI"
			
			#Add Submit for Approval button to layout
			SF.edit_layout_add_field $ffa_object_cash_entry, $ffa_cash_entry_normal_layout, $sf_layout_panel_button, [$cif_ce_submit_for_approval_button_label], $sf_edit_page_layout_target_position_standard_button
			
			#Verify that Submit for Approval button exists on the Cash Entry CIF view layout
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			CE.open_cash_entry_detail_page _cash_entry_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			gen_compare_object_visible $cif_sharing_button, true, "Expected Sharing button to be displayed on UI"
			gen_compare_object_visible $cif_submit_for_approval_button, true, "Expected Submit for Approval button to be displayed on UI"
		end
		gen_end_test "TST035924 - Check the Visibility of Sharing and Submit for Approval buttons on CIF UI on cash entry"
	end
	after :all do
		login_user
		_destroy_data_TID021069 = ["CODATID021069Data.destroyData();"]
		APEX.execute_commands _destroy_data_TID021069
		
		#Remove Submit for Approval button from the page layout
		SF.edit_layout_remove_button $ffa_object_cash_entry, $ffa_cash_entry_normal_layout, $cif_ce_submit_for_approval_button_label, $sf_label_standard
		SF.logout
		gen_end_test "TID021069: Verify standard button visibility on CIF page"    
	end
end
