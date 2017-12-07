#--------------------------------------------------------------------#
# TID: TID021175
# Pre-Requisit: Org with basedata deployed; CODATID021175Data.cls deployed on org.
# Product Area: Accounting - Allocations
# Story: 38981
# To run: rspec spec/UI/allocation/allocations_rules_fixed_TID021175_unmanaged.rb
#--------------------------------------------------------------------#


describe "TID021175: Verify the functionality for fixed type allocation rule", :type => :request do
	_fixed_allocation_rule_1 = "Test Fixed Allocation Rule 1"
	_fixed_allocation_rule_description = "Test Fixed Allocation Rule Description"
	_fixed_allocation_rule_2 = "Fixed Allocation Rule 1a"
	_fixed_allocation_rule_update = "Fixed Rule 1a Updated"
	_percentage_1 = "60.2563"
	_percentage_2 = "30.6741"
	_percentage_3 = "9.0695"
	_percentage_4 = "0.0001"
	_percentage_5 = "9.0696"
	_percentage_6 = "10.0696"
	row_1 = "Sales - Parts Dim 1 USD Dim 2 USD Dim 3 USD Dim 4 USD 60.2563"
	row_2 = "Marketing Dim 1 EUR Dim 3 USD Dim 4 USD 30.6741"
	row_3 = "Rent Tasmania Dim 2 USD 9.0695"
	row_3_new = "Rent Tasmania Dim 2 USD 9.0696"
	_allocationrules_message_cannot_delete_on_template = "You cannot delete or deactivate the allocation rule: Fixed Allocation Rule 1a, because it is used on the following templates: Allocation Template 1"
	_allocationrules_warning_message_on_edit = "The following allocation templates use this allocation rule: Allocation Template 1. If you edit the rule you might affect how allocation is calculated by these templates."
	include_context "login"
	include_context "logout_after_each"
	# Test setup
	before(:all) do
		begin
			#Data Setup 1
			_create_data = ["CODATID021175Data.selectCompany();", "CODATID021175Data.createData();"]
			# Execute Commands
			APEX.execute_commands _create_data
		end 
	end

	it "TID021175 - Allocation Rules Type - Fixed ", :unmanaged => true  do
		gen_start_test "TID021175: Verify the functionality for fixed type allocation rule"
		SF.tab $tab_allocation_rules

		gen_start_test "TST036467 - Verify user cannot save allocation rule with Name = null and Name already existing"
			#Error Message 1
			SF.click_button_new		
			AllocationRules.select_rule_type $allocationrules_type_fixed_label
			AllocationRules.set_rule_name ""
			AllocationRules.click_save_button
			gen_include $allocationrules_message_name_required , AllocationRules.get_error_message , "Expected Allocation Rule Mandatory Name Validation"
			AllocationRules.click_continue_button_on_popup

			#Error Message 2
			AllocationRules.set_rule_name _fixed_allocation_rule_2
			AllocationRules.click_save_button
			gen_include $allocationrules_message_name_already_exist , AllocationRules.get_error_message , "Expected Allocation Rule Existing Name Validation"
			AllocationRules.click_continue_button_on_popup
		gen_end_test "TST036467 - Verify user cannot save allocation rule with Name = null"

		gen_start_test "TST036468 - Verify user cannot save allocation rule with line_gla = Blank"
			#Error Message 3
			AllocationRules.set_rule_name _fixed_allocation_rule_1
			AllocationRules.set_rule_description _fixed_allocation_rule_description
			AllocationRules.set_fixed_rule_line_dim1 $bd_dim1_usd
			AllocationRules.click_save_button
			gen_include $allocationrules_message_gla_manadatory , AllocationRules.get_error_message , "Expected Mandatory GLA Validation"
			AllocationRules.click_continue_button_on_popup

			#Clear the grid
			AllocationRules.click_clear_all_button
			gen_compare "0" , AllocationRules.get_total_percentage , "Expected Total Percentage Value = 0"
			gen_compare_objval_not_null AllocationRules.get_grid_row_value_by_column(1, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN), false, "Expected Dimension 1 = Blank"
			gen_compare "" , AllocationRules.get_grid_row_value_by_column(1, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected Percentage Value = null"
			
		gen_end_test "TST036468 - Verify user cannot save allocation rule with line_gla = Blank"

		gen_start_test "TST036469 - Verify user cannot save allocation rule with isActive = true and total percentage not equal to 100"
			AllocationRules.set_is_active_checkbox
			AllocationRules.set_fixed_rule_grid_row $bd_gla_sales_parts, $bd_dim1_usd, $bd_dim2_usd, $bd_dim3_usd, $bd_dim4_usd, _percentage_1
			AllocationRules.set_fixed_rule_grid_row $bd_gla_marketing, $bd_dim1_eur, nil, $bd_dim3_usd, $bd_dim4_usd, _percentage_2, 2
			AllocationRules.set_fixed_rule_grid_row $bd_gla_rent, $bd_dim1_tasmania, $bd_dim2_usd, nil, nil, _percentage_3,3
			AllocationRules.set_fixed_rule_grid_row $bd_gla_rent, $bd_dim1_usd, $bd_dim2_usd, nil, nil, _percentage_4,4
			AllocationRules.delete_fixed_rule_line 4
			
			#Error Message 4
			gen_compare "99.9999" , AllocationRules.get_total_percentage , "Expected Total Percentage Value = 99.9999"
			AllocationRules.click_save_button
			gen_include $allocationrules_message_activation_failed , AllocationRules.get_error_message , "Expected Activation Rule cannot be activated error message"
			AllocationRules.click_continue_button_on_popup

			#Error Message 5
			AllocationRules.unset_is_active_checkbox
			AllocationRules.set_fixed_rule_line_percentage _percentage_6 , 3
			AllocationRules.click_save_button
			gen_include $allocationrules_message_percentage_limit , AllocationRules.get_error_message , "Expected Activation Rule cannot be activated with more than 100% allocation error message"
			AllocationRules.click_continue_button_on_popup

			#Save Allocation Rule
			AllocationRules.set_fixed_rule_line_percentage _percentage_4, 3
			AllocationRules.click_save_button
			AllocationRules.click_edit_button
			AllocationRules.delete_fixed_rule_line 3
			AllocationRules.click_save_button

			AllocationRules.click_edit_button
			gen_compare_objval_not_null AllocationRules.get_grid_row_value_by_column(3, ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN), false, "Expected GLA = Blank"
			gen_compare "" , AllocationRules.get_grid_row_value_by_column(3, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected Percentage Value = null"
			
			AllocationRules.set_fixed_rule_grid_row $bd_gla_rent, $bd_dim1_tasmania, $bd_dim2_usd, nil, nil, _percentage_3,3
			AllocationRules.click_save_button
			gen_compare row_1,AllocationRules.get_allocation_rule_grid_row(1),"Expected First row on Fixed Allocation Rule grid"
			gen_compare row_2,AllocationRules.get_allocation_rule_grid_row(2),"Expected second row on Fixed Allocation Rule grid"
			gen_compare row_3,AllocationRules.get_allocation_rule_grid_row(3),"Expected third row on Fixed Allocation Rule grid"
		gen_end_test "TST036469 - Verify user cannot save allocation rule with isActive = true and total percentage not equal to 100"

		gen_start_test "TST036470 - Verify user can edit Allocation rule and save with Active = true when percentage total is equal to 100"
			AllocationRules.click_edit_button
			AllocationRules.set_is_active_checkbox
			AllocationRules.set_fixed_rule_line_percentage _percentage_5,3
			AllocationRules.click_save_button
			gen_compare "100" , AllocationRules.get_total_percentage , "Expected Total Percentage Value = 100"
			gen_compare row_3_new,AllocationRules.get_allocation_rule_grid_row(3),"Expected third row on Fixed Allocation Rule grid"
		gen_end_test "TST036470 - Verify user can edit Allocation rule and save with Active = true when percentage total is equal to 100"

		gen_start_test "TST036471 - Verify spread even functionality on the fixed Allocation rule lines"
			AllocationRules.click_back_to_list_button
			AllocationRules.open_allocation_rule_detail_page _fixed_allocation_rule_1
			AllocationRules.click_edit_button
			AllocationRules.click_toggle_button
			AllocationRules.click_fixed_rule_menu_option $allocationrules_percentage_label, $allocationrules_type_spread_evenly_label
			gen_compare "100" , AllocationRules.get_total_percentage , "Expected Total Percentage Value = 100"
			AllocationRules.click_save_button
			gen_compare $bd_gla_sales_parts , AllocationRules.get_grid_row_value_by_column_view_page(1, ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN) , "Expected GLA = Sales Parts"
			gen_compare "33.3333" , AllocationRules.get_grid_row_value_by_column_view_page(1, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected Total Percentage Value = 33.3333"
			gen_compare $bd_gla_marketing , AllocationRules.get_grid_row_value_by_column_view_page(2, ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN) , "Expected GLA = Marketing"
			gen_compare "33.3334" , AllocationRules.get_grid_row_value_by_column_view_page(2, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected Total Percentage Value = 33.3333"
			gen_compare $bd_gla_rent , AllocationRules.get_grid_row_value_by_column_view_page(3, ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN) , "Expected GLA = Rent"
			gen_compare "33.3333" , AllocationRules.get_grid_row_value_by_column_view_page(3, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected Total Percentage Value = 33.3334"
		gen_end_test "TST036470 - Verify user can edit Allocation rule and save with Active = true when percentage total is equal to 100"
		
		gen_start_test "TST036598 - Verify Populate All functionality on the fixed Allocation rule lines"
			AllocationRules.click_edit_button
			AllocationRules.click_fixed_rule_menu_option $allocationrules_dim1_label, $allocationrules_type_populate_all_label
			gen_compare $bd_apex_eur_001 , AllocationRules.get_grid_row_value_by_column(4, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = Apex EUR 001"
			gen_compare $bd_apex_jpy_001 , AllocationRules.get_grid_row_value_by_column(5, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = Apex JPY 001"
			gen_compare $bd_apex_usd_001 , AllocationRules.get_grid_row_value_by_column(6, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = Apex USD 001"
			gen_compare $bd_dim1_gbp , AllocationRules.get_grid_row_value_by_column(7, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = DIM 1 GBP"
			gen_compare $bd_dim1_european , AllocationRules.get_grid_row_value_by_column(8, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = European"
			gen_compare $bd_dim1_massachusetts , AllocationRules.get_grid_row_value_by_column(9, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = Massachusetts"
			gen_compare $bd_dim1_new_york , AllocationRules.get_grid_row_value_by_column(10, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = New York"
			gen_compare $bd_dim1_north , AllocationRules.get_grid_row_value_by_column(11, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = North"
			gen_compare $bd_dim1_queensland , AllocationRules.get_grid_row_value_by_column(12, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = Queensland"
			gen_compare $bd_dim1_south , AllocationRules.get_grid_row_value_by_column(13, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = South"
			AllocationRules.click_back_to_list_button
		gen_end_test "TST036598 - Verify Populate All functionality on the fixed Allocation rule lines"
		
		gen_start_test "TST036599 - Verify Delete functionality on the fixed Allocation rule lines"
			gen_compare_has_content _fixed_allocation_rule_1, true, "Expected Allocation Rule 1 is present"
			AllocationRules.open_allocation_rule_detail_page _fixed_allocation_rule_1
			AllocationRules.click_delete_button
			AllocationRules.click_continue_button_on_popup
			gen_compare_has_content _fixed_allocation_rule_1, false, "Expected Allocation Rule 1 is deleted"
		gen_end_test "TST036599 - Verify Delete functionality on the fixed Allocation rule lines"
		
		gen_start_test "TST036622 - Verify user cannot delete Allocation Rule associated with Allocation Template"
			gen_compare_has_content _fixed_allocation_rule_2, true, "Expected Fixed Allocation Rule 1a is present"
			AllocationRules.open_allocation_rule_detail_page _fixed_allocation_rule_2
			AllocationRules.click_delete_button
			AllocationRules.click_continue_button_on_popup
			gen_include _allocationrules_message_cannot_delete_on_template , AllocationRules.get_error_message , "Expected Allocation Rule associated with Allocation Template Validation"
			AllocationRules.click_continue_button_on_popup
			AllocationRules.click_back_to_list_button
			gen_compare_has_content _fixed_allocation_rule_2, true, "Expected Fixed Allocation Rule 1a is present"
		gen_end_test "TST036622 - Verify user cannot delete Allocation Rule associated with Allocation Template"
		
		gen_start_test "TST036661 - Verify the warning message when user edits the Allocation Rule associated with Allocation Template."
			AllocationRules.open_allocation_rule_detail_page _fixed_allocation_rule_2
			AllocationRules.click_edit_button
			gen_include _allocationrules_warning_message_on_edit , AllocationRules.get_error_message , "Expected Allocation Rule associated with Allocation Template warning message on edit"
			AllocationRules.click_continue_button_on_popup
			AllocationRules.set_rule_name _fixed_allocation_rule_update
			AllocationRules.set_fixed_rule_line_gla $bd_gla_sales_hardware,1
			AllocationRules.click_save_button
			gen_compare _fixed_allocation_rule_update, AllocationRules.get_rule_name, "Expected Allocation Rule Name = Fixed Rule 1a Updated"
			gen_compare $bd_gla_sales_hardware, AllocationRules.get_grid_row_value_by_column_view_page(1, ALLOCATION_FIXED_RULE_GRID_GLA_COLUMN) , "Expected GLA = Sales - Hardware"
			AllocationRules.click_back_to_list_button
		gen_end_test "TST036661 - Verify the warning message when user edits the Allocation Rule associated with Allocation Template."
	end
	
	after(:all) do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID021175Data.destroyData();"]
		APEX.execute_commands _delete_data
		gen_end_test "TID021175: Verify the functionality for fixed type allocation rule"
	end
end
