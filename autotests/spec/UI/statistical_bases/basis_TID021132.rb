#--------------------------------------------------------------------#
#	TID : TID021132
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Allocations(UI Test)
#--------------------------------------------------------------------#

describe "TID021132 : Create,edit and delete the statistical value", :type => :request do
include_context "login"
include_context "logout_after_each"	
	before :all do
		#Hold Base Data
		gen_start_test "Verify that user is able to create,edit and delete a statistical value"
		FFA.hold_base_data_and_wait
	end
	
	it "TID021132 : Verify that user is able to create,edit and delete a statistical value" do
		_statistical_basis_name = "Test statistical basis"
		_statistical_basis_date = Date.today
		_statistical_basis_period = FFA.get_period_by_date _statistical_basis_date
		_statistical_basis_description = "TID021132-Statistical Value"
		_unit_of_measure = "People"
		_statistical_basis_title = "Statistical Bases"
		_TST036220_sencha_popup_confirmation_message = "To confirm that you want to delete this statistical basis, click Delete."
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		begin
			gen_start_test "TST036220: Verify that user is able to create,edit and delete a statistical value"
			###Step1###
			SF.tab $tab_statistical_value
			SF.click_button_new
			###Step2 - Assert the page tiltle####
			SB.assert_title _statistical_basis_title
			###Step3 - Insert the Statistical Basis header###
			SB.set_statistical_basis_name _statistical_basis_name
			SB.set_date _statistical_basis_date
			SB.set_company $company_merlin_auto_gb
			SB.set_period _statistical_basis_period
			SB.set_description _statistical_basis_description
			SB.set_unit_of_measure _unit_of_measure
			####Step4 - Insert a statistical value line in the grid.###
			SB.set_statistical_basis_line_gla 1,$bd_gla_account_receivable_control_eur
			SB.set_statistical_basis_line_dimension1 1,$bd_dim1_eur
			SB.set_statistical_basis_line_dimension2 1,$bd_dim2_eur
			SB.set_statistical_basis_line_dimension3 1,$bd_dim3_eur
			SB.set_statistical_basis_line_dimension4 1,$bd_dim4_eur
			SB.set_statistical_basis_line_value 1, 250.00
			####Step4 - Insert another line in the grid###
			SB.set_line_without_company true, 2, [$bd_gla_account_receivable_control_usd,'',$bd_dim2_usd,'','',200.00]
			###Step5 - Save the basis and assert the expected value###
			SB.click_button $sb_save_button
			SB.assert_total_value 450.00
			expect(SB.is_button_visible?$sb_edit_button).to be true
			gen_report_test "Edit button is visible"
			expect(SB.is_button_visible?$sb_delete_button).to be true
			gen_report_test "Delete button is visible"
			####Step6 - edit the statistical value by adding a new line and edit the existing values###
			SB.click_button $sb_edit_button
			SB.set_line_without_company true, 3, ['',$bd_dim1_eur,'','',$bd_dim4_usd,100.00]
			SB.set_date _statistical_basis_date + 10
			###Step7 - edit the dimension 4 and value in line 1
			SB.set_statistical_basis_line_value 1, 70.00
			SB.set_statistical_basis_line_dimension4 2, $bd_dim4_usd
			###Step8 - Save the record and assert the total value
			SB.click_button $sb_save_button
			SB.assert_total_value 370.00
			###Step9,10 - Delet the basis record
			SB.click_button $sb_delete_button
			gen_compare _TST036220_sencha_popup_confirmation_message, FFA.get_sencha_popup_error_message, "confirmation message - "
			FFA.sencha_popup_click_continue
			SB.wait_for_list_view
			expect(page.has_text?(_statistical_basis_name)).to be false
			gen_report_test "Basis doesn't exist on List view."
			gen_end_test "TST036220: Verify that user is able to create,edit and delete a statistical value"
		end
			
		begin
			gen_start_test "TST036382: Verify that user gets various valiadtion. "
			SF.tab $tab_statistical_value
			SF.click_button_new
			#Validate that user is not able to save a statistical value without statistical value name
			SB.set_statistical_basis_name ''
			SB.set_line_with_company true, 1, ['', $bd_gla_account_receivable_control_eur,$bd_dim1_eur,'','','',40.00]
			expect(SB.is_button_enabled?$sb_save_button).to be false
			gen_report_test "Save button is disabled"
			
			#Validate that statistical value name should be unique
			SB.set_statistical_basis_name _statistical_basis_name
			expect(SB.is_button_enabled?$sb_save_button).to be false
			gen_report_test "Save button is disabled"
			
			#Validate that user is not able to save a statistical basis line without dimension or general ledger account and value.
			SB.add_new_line 1
			SB.set_line_with_company true, 2, ['','','','','','','']
			expect(SB.is_button_enabled?$sb_save_button).to be false
			gen_report_test "Save button is disabled"
			
			#Validate that user is not able to save a statistical basis line with general ledger account and no value.
			SB.set_line_with_company true, 2, ['',$bd_gla_account_receivable_control_eur,'','','','','']
			expect(SB.is_button_enabled?$sb_save_button).to be false
			gen_report_test "Save button is disabled"
			
			#Validate that user is not able to save a statistical basis line with dimension and no value.
			SB.set_line_with_company true, 2, ['','',$bd_dim1_eur,'','','','']
			expect(SB.is_button_enabled?$sb_save_button).to be false
			gen_report_test "Save button is disabled"
			
			#Validate that user is not able to save a statistical basis line with value but without dimension or general ledger account.
			SB.set_line_with_company true, 2, ['','','','','','',100.00]
			expect(SB.is_button_enabled?$sb_save_button).to be false
			gen_report_test "Save button is disabled"
			
			gen_end_test "TST036382: Verify that user gets various valiadtion. "
		end
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
	end
end
	