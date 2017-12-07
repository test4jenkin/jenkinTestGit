#--------------------------------------------------------------------#
#   TID : TID019247
#   Pre-Requisite: Org with basedata deployed; Deploy CODATID019247Data.cls on org
#   Product Area: Accounting - Chart of Accounts
#   driver=firefox rspec -fd -c spec/UI/chart_of_accounts_mappings_TID019247.rb -fh -o pin_ext.html
#--------------------------------------------------------------------#

describe "Verify the chart of account mappings functionality through Sencha UI.", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID019247: Verify the chart of account mappings functionality through Sencha UI."
		FFA.hold_base_data_and_wait
	end
  
  it "Creates Chart Of Account Mappings through Sencha UI", :unmanaged => true  do

    #login and select merlin auto spain company.
    SF.app $accounting
    SF.tab $tab_select_company
    FFA.select_company [$company_merlin_auto_spain],true
	_suffix = '#TID019247'
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
		_create_data = ["CODATID019247Data.selectCompany();", "CODATID019247Data.createData();", "CODATID019247Data.createDataExt1();"]
		APEX.execute_commands _create_data
	end
	
    gen_start_test "TST030832 - Verify that user is able to save Chart of account mappings successfully."
    begin
		SF.tab $tab_chart_of_accounts_mappings
		_no_value_error_message = 'Select a dimension value.'
		_duplicate_mapping_error_message = 'Chart of account mapping already exists for this combination: Corporate GLA: 4001#TID019247, Dimension1: Dim 1 EUR, Local GLA: 60001#TID019247'
		_duplicate_mapping_in_same_coa_error = 'Chart of account mapping already exists for this combination: Corporate GLA: 4001#TID019247, Dimension1: Dim 1 EUR, Chart Of Accounts Structure: French#TID019247.'
		_duplicate_local_gla_dim_combination_error = 'Chart of account mapping already exists for this combination: Local GLA: 60001#TID019247, Dimension1: Dim 1 EUR'
		# Create Mapping with no dimension selected
		COAM.select_corporate_gla _corporate_gla_4001
		COAM.select_local_gla _local_gla_60001
		
		# Create Mapping with dimension type Dimension 1 and value null assert the error message
		COAM.select_corporate_gla _corporate_gla_4001
		COAM.select_dimension_type _dim_type_dim1
		COAM.select_local_gla _local_gla_60001
		gen_compare _no_value_error_message, FFA.get_sencha_popup_error_message, 'no value Error message found'
		FFA.sencha_popup_click_continue
		# create mapping with dimension type Dimension 1 and value Dim 1 EUR
		COAM.select_corporate_gla _corporate_gla_4001
		COAM.select_dimension_type _dim_type_dim1
		COAM.select_dimension_value _dim1_value_dim1_EUR
		COAM.select_local_gla _local_gla_60001
		# Compare result in mappings table
		_row1_corporate_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_corporate_gla_column
		_row1_local_gla_name = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_local_gla_column
		_row1_dim_value = COAM.get_grid_column_value $coam_mappings_grid, '1', $coam_mappings_grid_dimension_column
		gen_compare _corporate_gla_4001, _row1_corporate_gla_name, 'Comparing Corporate GLA Name in row 1 in Mappings grid'
		gen_compare _local_gla_60001, _row1_local_gla_name, 'Comparing Local GLA Name in row 1 in Mappings grid'
		gen_compare 'Dimension 1 : '+_dim1_value_dim1_EUR, _row1_dim_value, 'Comparing Dimension value in row 1 in Mappings grid'
		
		# Assert that no duplicate mapping can be created
		COAM.select_corporate_gla _corporate_gla_4001
		COAM.select_dimension_type _dim_type_dim1
		COAM.select_dimension_value _dim1_value_dim1_EUR
		COAM.select_local_gla _local_gla_60001
		gen_compare _duplicate_mapping_error_message, FFA.get_sencha_popup_error_message, 'Duplicate mapping error message found'
		FFA.sencha_popup_click_continue
		
		# Assert that no duplicate mapping, for same Corp GLA - Dim combination, for same COA.
		COAM.select_corporate_gla _corporate_gla_4001
		COAM.select_dimension_type _dim_type_dim1
		COAM.select_dimension_value _dim1_value_dim1_EUR
		COAM.select_local_gla _local_gla_60002
		gen_compare _duplicate_mapping_in_same_coa_error, FFA.get_sencha_popup_error_message, 'Duplicate mapping in same COA Error message found'
		FFA.sencha_popup_click_continue
		
		# Assert that no dulicate mapping, for same Local GLA - Dim combination, can be created.
		COAM.select_corporate_gla _corporate_gla_NAMEGLA_ACCOUNTSPAYABLECONTROLEUR
		COAM.select_dimension_type _dim_type_dim1
		COAM.select_dimension_value _dim1_value_dim1_EUR
		COAM.select_local_gla _local_gla_60001
		gen_compare _duplicate_local_gla_dim_combination_error, FFA.get_sencha_popup_error_message, 'Duplicate mapping in same Local GLA - Dim Combination Error message found'
		FFA.sencha_popup_click_continue
		
		# Assert that conflict button get shown for corp GLA when mappings exist for same Corp GLA with different Dim type combination
		COAM.select_corporate_gla _corporate_gla_4001
		COAM.select_dimension_type _dim_type_dim2
		COAM.select_dimension_value _dim2_value_dim2_EUR
		COAM.select_local_gla _local_gla_60002
		
		# Corporate gla Conflict button avaiable in row one
		expect(COAM.does_corp_gla_conflict_button_exist? '1').to eq(true)
		COAM.click_corp_gla_conflict_button '1'
		# Local conflicts tab disabled
		expect(COAM.does_local_conflict_tab_disabled?).to eq(true)
		# Coporate conflict tab enabled
		expect(COAM.does_corp_conflict_tab_disabled?).to eq(false)
		
		COAM.click_corp_gla_conflict_button '1'
		# Coporat conflict tab values
		_row1_local_gla = COAM.get_local_gla_value_in_coporate_conflicts_tab '1'
		_row1_dim_value = COAM.get_dimension_value_in_coporate_conflicts_tab '1'
		gen_compare _local_gla_60002, _row1_local_gla, 'Local GLA value in row one matched'
		gen_compare 'Dimension 2 : '+_dim2_value_dim2_EUR, _row1_dim_value, 'Dimension value in row one matched'
		
		_row2_local_gla = COAM.get_local_gla_value_in_coporate_conflicts_tab '2'
		_row2_dim_value = COAM.get_dimension_value_in_coporate_conflicts_tab '2'
		gen_compare _local_gla_60001, _row2_local_gla, 'Local GLA value in row two matched'
		gen_compare 'Dimension 1 : '+_dim1_value_dim1_EUR, _row2_dim_value, 'Dimension value in row two matched'
		
		# Assert that conflict button get shown for Local GLA when mapping is created for same Local GLA with different Dim type combination
		COAM.select_corporate_gla _corporate_gla_NAMEGLA_ACCOUNTSPAYABLECONTROLEUR
		COAM.select_dimension_type _dim_type_dim3
		COAM.select_dimension_value _dim3_value_dim3_EUR
		COAM.select_local_gla _local_gla_60002
		
		# Local gla Conflict button avaiable in row one
		expect(COAM.does_local_gla_conflict_button_exist? '1').to eq(true)
		COAM.click_local_gla_conflict_button '1'
		# Local conflicts tab enabled
		expect(COAM.does_local_conflict_tab_disabled?).to eq(false)
		# Coporate conflict tab disabled
		expect(COAM.does_corp_conflict_tab_disabled?).to eq(true)
		COAM.click_local_gla_conflict_button '1'	
		# Local conflict tab values
		_row1_corp_gla = COAM.get_corp_gla_value_in_local_conflicts_tab '1'
		_row1_dim_value_local = COAM.get_dimension_value_in_local_conflicts_tab '1'
		gen_compare _corporate_gla_NAMEGLA_ACCOUNTSPAYABLECONTROLEUR, _row1_corp_gla, 'corp GLA value in row one matched'
		gen_compare 'Dimension 3 : '+_dim3_value_dim3_EUR, _row1_dim_value_local, 'Dimension value in row one matched'
		
		_row2_corp_gla = COAM.get_corp_gla_value_in_local_conflicts_tab '2'
		_row2_dim_value_local = COAM.get_dimension_value_in_local_conflicts_tab '2'
		gen_compare _corporate_gla_4001, _row2_corp_gla, 'Corp GLA value in row two matched'
		gen_compare 'Dimension 2 : '+_dim2_value_dim2_EUR, _row2_dim_value_local, 'Dimension value in row two matched'
		
		COAM.click_on_save_button
		gen_end_test "TST030832 - Verify that user is able to save Chart of account mappings successfully."
	end
  end
	after :all do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID019247Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID019247 : Verify the chart of account mappings functionality through Sencha UI."
	end
end