#--------------------------------------------------------------------#
#   TID : TID018189
#   Pre-Requisite: Org with basedata deployed;Deployed CODATID018189Data.cls on org.
#   Product Area: Accounting - Chart of Accounts
#   driver=firefox rspec -fd -c spec/UI/chart_of_accounts_mappings_TID018189.rb -fh -o pin_ext.html
#--------------------------------------------------------------------#

describe "Verify the chart of account mappings functionality through Sencha UI.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID018189: Verify the chart of account mappings functionality through Sencha UI."
		FFA.hold_base_data_and_wait
	end
  
  it "Creates Chart Of Account Mappings through Sencha UI", :unmanaged => true  do

    #login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_spain],true
	_suffix = '#TID018189'
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
	begin
		_create_data = ["CODATID018189Data.selectCompany();", "CODATID018189Data.createData();", "CODATID018189Data.createDataExt1();"]
		APEX.execute_commands _create_data
	end
	
    # #TST028095  - Verify the display on access of "Chart of account mappings" tab.
    gen_start_test "TST028095 - Verify the display on access of Chart of account mappings tab."
    begin
		SF.tab $tab_chart_of_accounts_mappings
		# Comparing data in map corporate gla grid
		
		# row 1
		_row1_gla_name = COAM.get_grid_column_value $coam_corporate_glas_grid, '1', $coam_map_corporate_glas_name_column
		_row1_type = COAM.get_grid_column_value $coam_corporate_glas_grid, '1', $coam_map_corporate_glas_type_column
		gen_compare _corporate_gla_4001, _row1_gla_name, 'Comparing Name in row 1 in Corporate grid'
		gen_compare _type_balance_sheet, _row1_type, 'Comparing Type in row 1 in Corporate grid'
		
		# row 2
		_row2_gla_name = COAM.get_grid_column_value $coam_corporate_glas_grid, '2', $coam_map_corporate_glas_name_column
		_row2_type = COAM.get_grid_column_value $coam_corporate_glas_grid, '2', $coam_map_corporate_glas_type_column
		gen_compare _corporate_gla_NAMEGLA_ACCOUNTSPAYABLECONTROLEUR, _row2_gla_name, 'Comparing Name in row 2 in Corporate grid'
		gen_compare _type_balance_sheet, _row2_type, 'Comparing Type in row 2 in Corporate grid'
		
		# row 3
		_row3_gla_name = COAM.get_grid_column_value $coam_corporate_glas_grid, '3', $coam_map_corporate_glas_name_column
		_row3_type = COAM.get_grid_column_value $coam_corporate_glas_grid, '3', $coam_map_corporate_glas_type_column
		gen_compare _corporate_gla_NAMEGLA_POSTAGEANDSTATIONERY, _row3_gla_name, 'Comparing Name in row 3 in Corporate grid'
		gen_compare _type_profit_loss, _row3_type, 'Comparing Type in row 3 in Corporate grid'
		
		# row 4
		_row4_gla_name = COAM.get_grid_column_value $coam_corporate_glas_grid, '4', $coam_map_corporate_glas_name_column
		_row4_type = COAM.get_grid_column_value $coam_corporate_glas_grid, '4', $coam_map_corporate_glas_type_column
		gen_compare _corporate_gla_NAMEGLA_VATINPUT, _row4_gla_name, 'Comparing Name in row 4 in Corporate grid'
		gen_compare _type_balance_sheet, _row4_type, 'Comparing Type in row 4 in Corporate grid'
		
		# Comparing data in To Local Glas grid
		# row 1
		_row1_gla_name = COAM.get_grid_column_value $coam_local_glas_grid, '1', $coam_to_local_glas_name_column
		_row1_type = COAM.get_grid_column_value $coam_local_glas_grid, '1', $coam_to_local_glas_type_column
		_row1_coa = COAM.get_grid_column_value $coam_local_glas_grid, '1', $coam_to_local_glas_chart_of_accounts_structure_column
		gen_compare _local_gla_60001, _row1_gla_name, 'Comparing Name Column in row 1 in Local gla grid'
		gen_compare _type_balance_sheet, _row1_type, 'Comparing Type in row 1 in Local gla grid'
		gen_compare _coa_french, _row1_coa, 'Comparing COA Name in row 1 in Local gla grid'
		
		# row 2
		_row2_gla_name = COAM.get_grid_column_value $coam_local_glas_grid, '2', $coam_to_local_glas_name_column
		_row2_type = COAM.get_grid_column_value $coam_local_glas_grid, '2', $coam_to_local_glas_type_column
		_row2_coa = COAM.get_grid_column_value $coam_local_glas_grid, '2', $coam_to_local_glas_chart_of_accounts_structure_column
		gen_compare _local_gla_60002, _row2_gla_name, 'Comparing Name in row 2 in Local gla grid'
		gen_compare _type_balance_sheet, _row2_type, 'Comparing Type in row 2 in Local gla grid'
		gen_compare _coa_french, _row2_coa, 'Comparing COA in row 2 in Local gla grid'
		
		# row 3
		_row3_gla_name = COAM.get_grid_column_value $coam_local_glas_grid, '3', $coam_to_local_glas_name_column
		_row3_type = COAM.get_grid_column_value $coam_local_glas_grid, '3', $coam_to_local_glas_type_column
		_row3_coa = COAM.get_grid_column_value $coam_local_glas_grid, '3', $coam_to_local_glas_chart_of_accounts_structure_column
		gen_compare _local_gla_60003, _row3_gla_name, 'Comparing Name in row 3 in Local gla grid'
		gen_compare _type_balance_sheet, _row3_type, 'Comparing Type in row 3 in Local gla grid'
		gen_compare _coa_french, _row3_coa, 'Comparing COA in row 3 in Local gla grid'
		
		# row 4
		_row4_gla_name = COAM.get_grid_column_value $coam_local_glas_grid, '4', $coam_to_local_glas_name_column
		_row4_type = COAM.get_grid_column_value $coam_local_glas_grid, '4', $coam_to_local_glas_type_column
		_row4_coa = COAM.get_grid_column_value $coam_local_glas_grid, '4', $coam_to_local_glas_chart_of_accounts_structure_column
		gen_compare _local_gla_60004, _row4_gla_name, 'Comparing Name in row 4 in Local gla grid'
		gen_compare _type_balance_sheet, _row4_type, 'Comparing Type in row 4 in Local gla grid'
		gen_compare _coa_french, _row4_coa, 'Comparing COA in row 4 in Local gla grid'
		
		# Assert no record found in mappings table
		expect(COAM.get_no_mapping_found?).to be(true)
		
		# Assert no gla detail section is blank
		expect(COAM.get_no_mapping_selected?).to be(true)
		gen_end_test "TST028095 - Verify the display on access of Chart of account mappings tab."
	end	
	
	gen_start_test "TST028479 - Verify the creation of chart of account mappings through new UI."
    begin
		SF.tab $tab_chart_of_accounts_mappings
		
		# Create Mapping
		COAM.select_corporate_gla _corporate_gla_4001
		COAM.select_local_gla _local_gla_60001
		
		# Compare result in mappings table
		_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
		_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
		gen_compare _corporate_gla_4001, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
		gen_compare _local_gla_60001, _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
		
		COAM.click_on_save_button
		gen_end_test "TST028479 - Verify the creation of chart of account mappings through new UI."
	end
	
	gen_start_test "TST028514 - Verify the deletion of chart of account mappings through new UI."
    begin
		SF.tab $tab_chart_of_accounts_mappings
		# Compare mapping exist in mappings table
		expect(COAM.get_mapped_corporate_gla_by_local_gla _local_gla_60001).to eq(_corporate_gla_4001)
		# delete mapping
		COAM.delete_mapping_by_gla_name _local_gla_60001
		COAM.enter_reason_delete_mapping_popup "test reason"
		COAM.click_delete_button_delete_mapping_popup
		
		# Assert local gla appeared in To Local GLA Table
		expect(COAM.is_local_gla_exist_in_local_gla_grid? _local_gla_60001).to be(true)
		COAM.click_on_save_button
		gen_end_test "TST028514 - Verify the deletion of chart of account mappings through new UI."
	end
  end
  
	after :all do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID018189Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID018189 : Verify the chart of account mappings functionality through Sencha UI."
	end
end