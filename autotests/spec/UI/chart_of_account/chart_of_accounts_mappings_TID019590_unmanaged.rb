#--------------------------------------------------------------------#
#   TID : TID019590
#   Pre-Requisite: Org with basedata deployed;Deploy CODATID019590Data.cls on org.
#   Product Area: Accounting - Chart of Accounts
#   driver=firefox rspec -fd -c spec/UI/chart_of_accounts_mappings_TID019590.rb -fh -o pin_ext.html
#--------------------------------------------------------------------#

describe "Verify the various operations on Chart Of Account mappings through sencha UI.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID019590: Verify the various operations on Chart Of Account mappings through sencha UI."
		#SF.create_tab_from_visualforce_page 'BaseDataJob','BaseDataJob'
		FFA.hold_base_data_and_wait
	end
  
  it "Creates Chart Of Account Mappings through Sencha UI", :unmanaged => true  do

    #login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_spain],true
	_suffix = '#TID019590'
	_corporate_gla_4001 = '4001'+_suffix
	_corporate_gla_NAMEGLA_ACCOUNTSPAYABLECONTROLEUR = $bd_gla_account_payable_control_eur
	_corporate_gla_NAMEGLA_POSTAGEANDSTATIONERY = $bd_gla_postage_and_stationery
	_corporate_gla_NAMEGLA_VATINPUT = $bd_gla_vat_input
	_local_gla_60001 = '60001'+_suffix
	_local_gla_60002 = '60002'+_suffix
	_local_gla_60003 = '60003'+_suffix
	_local_gla_60004 = '60004'+_suffix
	_type_balance_sheet = 'Balance Sheet'
	_type_profit_loss = 'Profit and Loss'
	_coa_french = 'French'+_suffix
	_dim_type_dim1 = 'Dimension 1'
	_dim_type_dim2 = 'Dimension 2'
	_dim_type_dim3 = 'Dimension 3'
	_dim_type_dim4 = 'Dimension 4'
	_dim1_value_dim1_EUR = 'Dim 1 EUR'
	_dim1_value_dim1_GBP = 'Dim 1 GBP'
	_dim1_value_dim1_USD = 'Dim 1 USD'
	_dim2_value_dim2_EUR = 'Dim 2 EUR'
	_dim2_value_dim2_GBP = 'Dim 2 GBP'
	_dim2_value_dim2_USD = 'Dim 2 USD'
	_dim3_value_dim3_EUR = 'Dim 3 EUR'
	_dim3_value_dim3_GBP = 'Dim 3 GBP'
	_dim3_value_dim3_USD = 'Dim 3 USD'
	_dim4_value_dim4_EUR = 'Dim 4 EUR'
	_dim4_value_dim4_GBP = 'Dim 4 GBP'
	_dim4_value_dim4_USD = 'Dim 4 USD'
	begin
		_create_data = ["CODATID019590Data.selectCompany();", "CODATID019590Data.createData();", "CODATID019590Data.createDataExt1();"]
		APEX.execute_commands _create_data
	end
	
    gen_start_test "TST030832 - Verify that user is able to save Chart of account mappings successfully."
    begin
		_duplicate_mapping_error_message = 'Chart of account mapping already exists for this combination: Corporate GLA: 4001#TID019590, Dimension1: Dim 1 EUR, Local GLA: 60001#TID019590'
		_duplicate_mapping_in_same_coa_error = 'Chart of account mapping already exists for this combination: Corporate GLA: VAT Input, Dimension1: Dim 1 EUR, Chart Of Accounts Structure: French#TID019590.'
		_duplicate_local_gla_dim_combination_error = 'Chart of account mapping already exists for this combination: Local GLA: 60001#TID019590, Dimension1: Dim 1 EUR'
		SF.tab $tab_chart_of_accounts_mappings
		COAM.select_corporate_gla _corporate_gla_NAMEGLA_VATINPUT
		COAM.select_dimension_type _dim_type_dim2
		COAM.select_dimension_value _dim2_value_dim2_EUR
		COAM.select_local_gla _local_gla_60003
		
		# Compare result in mappings table before save
		_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
		_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
		_row1_dim_value = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_dimension_column
		gen_compare _corporate_gla_NAMEGLA_VATINPUT, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
		gen_compare _local_gla_60003, _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
		gen_compare 'Dimension 2 : '+_dim2_value_dim2_EUR, _row1_dim_value, 'Comparing Dimension value in row 1 in Mappings grid'
		
		COAM.click_on_save_button
		
		# Reload chart of accounts mapping UI after save action
		SF.tab $tab_chart_of_accounts_mappings
		
		# Compare result in mappings table after save and reloading the page
		_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
		_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
		_row1_dim_value = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_dimension_column
		gen_compare _corporate_gla_NAMEGLA_VATINPUT, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
		gen_compare _local_gla_60003, _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
		gen_compare 'Dimension 2 : '+_dim2_value_dim2_EUR, _row1_dim_value, 'Comparing Dimension value in row 1 in Mappings grid'
		
		# Create a Mapping before editing the existing one
		COAM.select_corporate_gla _corporate_gla_NAMEGLA_VATINPUT
		COAM.select_dimension_type _dim_type_dim1
		COAM.select_dimension_value _dim1_value_dim1_EUR
		COAM.select_local_gla _local_gla_60004
		
		# Assert Reason field does not exist for newly added mapping in edit mapping popup
		COAM.click_edit_mapping_button '1'
		expect(COAM.does_reason_exist_edit_mapping_popup?).to eq(false)
		
		# Click on Cancel button in edit mapping popup and assert that the edit mapping popup is closed now.
		COAM.click_cacel_button_edit_mapping_popup
		expect(COAM.does_edit_mapping_popup_exist?).to eq(false)
		
		# Edit exiting Mapping
		COAM.click_edit_mapping_button '2'
		COAM.select_dimension_type_edit_mapping_popup _dim_type_dim1
		COAM.select_dimension_value_edit_mapping_popup _dim1_value_dim1_EUR
		COAM.enter_reason_edit_mapping_popup 'Test'
		COAM.click_save_button_edit_mapping_popup
		
		# Assert dulicate mapping in same coa error appreas
		gen_compare _duplicate_mapping_in_same_coa_error, FFA.get_sencha_popup_error_message, 'Duplicate mapping in same COA Error message found'
		FFA.sencha_popup_click_continue
		
		COAM.select_dimension_type_edit_mapping_popup _dim_type_dim3
		COAM.select_dimension_value_edit_mapping_popup _dim3_value_dim3_EUR
		COAM.click_save_button_edit_mapping_popup
		
		# Assert all columns are dirty for line one and only dimension column is dirty for line 2
		_is_dimension_dirty_row2 = COAM.is_column_dirty_in_mappings_grid '2','8'
		_are_all_columns_dirty_row1 = COAM.all_dirty? '1'
		expect(_is_dimension_dirty_row2).to eq(true)
		expect(_are_all_columns_dirty_row1).to eq(true)
		
		# Assert no delete mapping popup is shown when an all dirty row is deleted
		COAM.click_delete_mapping_button '1'
		expect(COAM.does_delete_mapping_popup_exist?).to eq(false)
		
		COAM.select_row_mappings_grid '1'
		
		COAM.click_on_save_button
		
		# Reload chart of accounts mapping UI after save action
		SF.tab $tab_chart_of_accounts_mappings
		
		# Assert Edited values in history after save
		
		# Assert in mappings grid
		COAM.select_row_mappings_grid '1'
		_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
		_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
		_row1_dim_value = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_dimension_column
		gen_compare _corporate_gla_NAMEGLA_VATINPUT, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
		gen_compare _local_gla_60003, _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
		gen_compare 'Dimension 3 : '+_dim3_value_dim3_EUR, _row1_dim_value, 'Comparing Dimension value in row 1 in Mappings grid'
		
		# Assert in history grid
		COAM.click_on_history_tab
		_row1_action = COAM.get_grid_column_value $coam_history_grid, '1', $coam_history_tab_action_column
		_row1_field_name = COAM.get_grid_column_value $coam_history_grid, '1', $coam_history_tab_field_column
		_row1_old_value = COAM.get_grid_column_value $coam_history_grid, '1', $coam_history_tab_old_value_column
		_row1_new_value = COAM.get_grid_column_value $coam_history_grid, '1', $coam_history_tab_new_value_column
		_row1_reason = COAM.get_grid_column_value $coam_history_grid, '1', $coam_history_tab_reason_column
		_row2_action = COAM.get_grid_column_value $coam_history_grid, '2', $coam_history_tab_action_column
		_row2_field_name = COAM.get_grid_column_value $coam_history_grid, '2', $coam_history_tab_field_column
		_row2_old_value = COAM.get_grid_column_value $coam_history_grid, '2', $coam_history_tab_old_value_column
		_row2_new_value = COAM.get_grid_column_value $coam_history_grid, '2', $coam_history_tab_new_value_column
		_row2_reason = COAM.get_grid_column_value $coam_history_grid, '2', $coam_history_tab_reason_column
		# Assert Action Value
		gen_compare 'Changed',  _row1_action, 'Field value is matched in history Row 1'
		gen_compare 'Changed',  _row2_action, 'Field value is matched in history Row 2'
		# Assert Field Value
		gen_compare 'Dimension Type',  _row1_field_name, 'Field value is matched in history Row 1'
		gen_compare 'Dimension Value',  _row2_field_name, 'Field value is matched in history Row 2'
		# Assert old Value
		gen_compare 'Dimension 2', _row1_old_value, 'Old value is matched in histroy row 1'
		gen_compare _dim2_value_dim2_EUR, _row2_old_value, 'Old value is matched in histroy row 2' 
		# Assert new value
		gen_compare 'Dimension 3', _row1_new_value, 'New value is matched in histroy row 1'
		gen_compare _dim3_value_dim3_EUR, _row2_new_value, 'New value is matched in histroy row 2'
		# Assert reason
		gen_compare 'Test', _row1_reason, 'Reason is matched in histroy row 1'
		gen_compare 'Test', _row2_reason, 'Reason is matched in histroy row 2'
		
		gen_end_test "TST030832 - Verify that user is able to save Chart of account mappings successfully."
	end
  end
	after :all do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID019590Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID019590 : Verify the various operations on Chart Of Account mappings through sencha UI."
	end
end