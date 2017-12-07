#--------------------------------------------------------------------#
# TID: TID021317
# Pre-Requisit: Org with basedata deployed
# Product Area: Accounting - Allocations
# Story: AC-9731
# To run: rspec spec/UI/allocation/allocations_rules_variable_TID021317.rb
#--------------------------------------------------------------------#

describe "TID021317: Verify the functionality for Variable type allocation rule", :type => :request do
	_variable_allocation_rule_1 = "Test Variable Allocation Rule 1"
	_variable_allocation_rule_description = "Test Variable Allocation Rule Description"
	grid_row_1 = "Accounts Receivable Control - EUR Dim 1 USD Dim 2 USD Dim 3 USD Dim 4 USD 40 100"
	grid_row_2 = "Dim 1 USD Dim 2 USD 40 56.338"
	grid_row_3 = "European Ford US 22 30.9859"
	grid_row_4 = "Dim 1 EUR Dim 2 EUR 9 12.6761"
	grid_row_5 = "Dim 1 USD Dim 2 USD 40 64.5161"
	grid_row_6 = "European Ford US 22 35.4839"
	grid_row_7 = "Dim 1 USD Dim 2 USD 40 100"
	grid_row_8 = "Dim 2 USD 40 81.6327"
	grid_row_9 = "Dim 2 EUR 9 18.3673"
	
	_statistical_basis_name = "Test statistical basis"
	_statistical_basis_date = Date.today
	_statistical_basis_period = FFA.get_period_by_date _statistical_basis_date
	_statistical_basis_description = "TID021317-Statistical Value"
	_unit_of_measure = "People"
	
	statistical_values_cant_delete_on_rule = "You cannot delete the statistical bases Test statistical basis because they are used on the following allocation rules: Test Variable Allocation Rule 1"
	
	include_context "login"
	include_context "logout_after_each"
	# Test setup
	before(:all) do
		gen_start_test "TID021317: Verify the functionality of Variable Allocation Rule"
		begin
			FFA.hold_base_data_and_wait
			#Data Setup 1
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain],true
		end 
	end

	it "TID021317 - Allocation Rules Type - Variable " do

		SF.tab $tab_allocation_rules
		gen_start_test "TST037093 - Verify that user cannot save Variable Allocation Rule without selecting any Statistical Basis"
			#Error Message 1
			SF.click_button_new		
			AllocationRules.select_rule_type $allocationrules_type_variable_label
			AllocationRules.set_rule_name _variable_allocation_rule_1
			AllocationRules.set_rule_description _variable_allocation_rule_description
			AllocationRules.click_save_button
			#Error Message 1
			gen_include $allocationrules_message_basis_distribution_field_mandatory , AllocationRules.get_error_message , "Expected Allocation Rule Mandatory Statistical Basis Validation"
			AllocationRules.click_continue_button_on_popup
		gen_end_test "TST037093 - Verify that user cannot save Variable Allocation Rule without selecting any Statistical Basis"
		gen_start_test "TST037095 - Verify that user can create Statistical Basis from the Header"
			#Error Message
			AllocationRules.click_edit_statistical_bases_button
			gen_include $allocationrules_message_statistical_value_unselected , AllocationRules.get_error_message , "Expected Statistical Basis Not Selected Validation"
			AllocationRules.click_continue_button_on_popup
			AllocationRules.click_add_statistical_bases_button
			SB.set_statistical_basis_name _statistical_basis_name
			SB.set_date _statistical_basis_date
			SB.set_description _statistical_basis_description
			SB.set_unit_of_measure _unit_of_measure
			SB.set_company $company_merlin_auto_spain
			SB.set_period _statistical_basis_period
			
			SB.set_line_without_company true,1,[$bd_gla_account_receivable_control_eur,$bd_dim1_usd,$bd_dim2_usd,$bd_dim3_usd,$bd_dim4_usd,40]
			SB.set_statistical_basis_line_dimension1 2,$bd_dim1_european
			SB.set_statistical_basis_line_value 2, 20
			SB.set_statistical_basis_line_dimension1 3,$bd_dim1_north
			SB.set_statistical_basis_line_value 3, 30
			SB.set_statistical_basis_line_dimension1 4,$bd_dim1_european
			SB.set_statistical_basis_line_dimension2 4,$bd_dim2_ford_us
			SB.set_statistical_basis_line_value 4, 22
			SB.set_statistical_basis_line_dimension3 5,$bd_apex_eur_003
			SB.set_statistical_basis_line_value 5, 13
			SB.set_statistical_basis_line_dimension4 6,$bd_apex_eur_004
			SB.set_statistical_basis_line_value 6, 25
			SB.set_line_without_company true,7,['',$bd_dim1_eur,$bd_dim2_eur,'',$bd_dim4_usd,9]
			SB.delete_line 8
			gen_compare '159', AllocationRules.get_total_value ,"Expected total value in Statistical Basis popup is Correct"
			AllocationRules.click_save_and_select_on_basis_popup
		gen_end_test "TST037095 - Verify that user can create Statistical Basis from the Header"
		
		gen_start_test "TST037094 - Verify that user cannot save Variable Allocation Rule without selecting any Distribution Field"	
			AllocationRules.click_save_button
			gen_include $allocationrules_message_distribution_field_mandatory , AllocationRules.get_error_message , "Expected Allocation Rule Distribution Field needs to be selected Validation"
			AllocationRules.click_continue_button_on_popup
		gen_end_test "TST037094 - Verify that user cannot save Variable Allocation Rule without selecting any Distribution Fields"
		
		gen_start_test "TST037097 - Verify that Preview button displays the statistical basis grid"		
			AllocationRules.select_distribution_fields [$allocationrules_gla_label,$allocationrules_dim1_label,$allocationrules_dim2_label,$allocationrules_dim3_label,$allocationrules_dim4_label]
			AllocationRules.click_preview_button
			gen_compare 1,AllocationRules.get_count_of_grid_rows,"Expected Grid Row Size to be 1"
			gen_compare grid_row_1,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row is displayed"
			gen_compare '100',AllocationRules.get_total_percentage,"Expected Total Percentage is displayed"
			gen_compare '40',AllocationRules.get_total_value,"Expected Total Value is displayed"
			AllocationRules.click_save_button

			AllocationRules.click_edit_button
			gen_assert_disabled $allocationrules_alloc_type
			AllocationRules.remove_distribution_field $allocationrules_gla_label
			AllocationRules.remove_distribution_field $allocationrules_dim3_label
			AllocationRules.remove_distribution_field $allocationrules_dim4_label
			AllocationRules.click_preview_button
			gen_compare 3,AllocationRules.get_count_of_grid_rows,"Expected Grid Row Size to be 3"
			gen_compare grid_row_2,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row 1 is displayed"
			gen_compare grid_row_3,AllocationRules.get_allocation_rule_grid_row(2),"Expected Grid Row 2 is displayed"
			gen_compare grid_row_4,AllocationRules.get_allocation_rule_grid_row(3),"Expected Grid Row 3 is displayed"
			gen_compare '100',AllocationRules.get_total_percentage,"Expected Total Percentage is displayed"
			gen_compare '71',AllocationRules.get_total_value,"Expected Total Value is displayed"
			
			AllocationRules.click_show_filter_button
			AllocationRules.click_add_filter_button
			AllocationRules.set_filter_values $allocationrules_dim1_label,$allocationrules_filter_operator_contains_label,'USD'
			AllocationRules.click_add_filter_button
			AllocationRules.set_filter_values $allocationrules_dim1_label,$allocationrules_filter_operator_equals_label,$bd_dim1_european,2
			AllocationRules.click_preview_button
			gen_compare 2,AllocationRules.get_count_of_grid_rows,"Expected Grid Row Size to be 2"
			gen_compare grid_row_5,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row 1 is displayed"
			gen_compare grid_row_6,AllocationRules.get_allocation_rule_grid_row(2),"Expected Grid Row 2 is displayed"
			gen_compare '100',AllocationRules.get_total_percentage,"Expected Total Percentage is displayed"
			gen_compare '62',AllocationRules.get_total_value,"Expected Total Value is displayed"
			
			AllocationRules.click_show_filter_button
			AllocationRules.click_add_filter_button
			AllocationRules.set_filter_values $allocationrules_dim2_label,$allocationrules_filter_operator_not_equals_label,$bd_dim2_ford_us,3
			AllocationRules.click_preview_button
			gen_compare 1,AllocationRules.get_count_of_grid_rows,"Expected Grid Row Size to be 1"
			gen_compare grid_row_7,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row 1 is displayed"
			gen_compare '100',AllocationRules.get_total_percentage,"Expected Total Percentage is displayed"
			gen_compare '40',AllocationRules.get_total_value,"Expected Total Value is displayed"

			AllocationRules.remove_distribution_field $allocationrules_dim1_label
			gen_compare $allocationrules_message_filter_undo_confirmation,AllocationRules.get_toast_message,"Expected Toast message is displayed"
			AllocationRules.click_undo_button_on_toast_message_box
			gen_compare '3',AllocationRules.get_displayed_filter_count,"Expected Number of filter count displayed to be 3"
			AllocationRules.click_show_filter_button
			gen_compare 3,AllocationRules.get_filter_count,"Expected Number of filters to be 3"
			
			AllocationRules.remove_distribution_field $allocationrules_dim1_label
			AllocationRules.click_close_button_on_toast_message_box
			gen_compare 1,AllocationRules.get_filter_count,"Expected Number of filters to be 1"
			gen_compare '1',AllocationRules.get_displayed_filter_count,"Expected Number of filter count displayed to be 1"
			AllocationRules.click_preview_button
			gen_compare 2,AllocationRules.get_count_of_grid_rows,"Expected Grid Row Size to be 2"
			gen_compare grid_row_8,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row 1 is displayed"
			gen_compare grid_row_9,AllocationRules.get_allocation_rule_grid_row(2),"Expected Grid Row 2 is displayed"
			gen_compare '100',AllocationRules.get_total_percentage,"Expected Total Percentage is displayed"
			gen_compare '49',AllocationRules.get_total_value,"Expected Total Percentage is displayed"
			
			AllocationRules.set_is_active_checkbox
			AllocationRules.click_save_button
			gen_compare grid_row_8,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row 1 is displayed"
			gen_compare grid_row_9,AllocationRules.get_allocation_rule_grid_row(2),"Expected Grid Row 2 is displayed"
			
			AllocationRules.click_back_to_list_button
		gen_end_test "TST037097 - Verify that Preview button displays the statistical basis grid"
		
		gen_start_test "TST037098 - Verify Delete functionality on the Variable Allocation rule lines"
			gen_compare_has_content _variable_allocation_rule_1, true, "Expected Variable Allocation Rule 1 is present"
			SF.tab $tab_statistical_value
			gen_compare_has_content _statistical_basis_name, true, "Expected Statistical Basis associated with Allocation Rule is not deleted"
			SB.open_statistical_basis_detail_page _statistical_basis_name
			SB.click_button $sb_delete_button
			FFA.sencha_popup_click_continue
			gen_include statistical_values_cant_delete_on_rule, FFA.get_sencha_popup_error_message, "Error message for statistical value is displayed"
			FFA.sencha_popup_click_continue
			SB.click_button $sb_back_to_list_button 
			SF.tab $tab_allocation_rules
			AllocationRules.open_allocation_rule_detail_page _variable_allocation_rule_1
			AllocationRules.click_delete_button
			AllocationRules.click_continue_button_on_popup
			gen_compare_has_content _variable_allocation_rule_1, false, "Expected Variable Allocation Rule 1 is deleted"
		gen_end_test "TST037098 - Verify Delete functionality on the Variable Allocation rule lines"
	end
	
	after(:all) do
		login_user
		FFA.delete_new_data_and_wait
		# Delete Test Data
		gen_end_test "TID021317: Verify the functionality of Variable Allocation Rule"
	end
end
