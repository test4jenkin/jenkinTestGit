#--------------------------------------------------------------------#
#	TID : TID021246
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Allocations(UI Test)
#--------------------------------------------------------------------#

describe "TID021246 : TID covers the versioning for statistical bases.", :type => :request do
include_context "login"
include_context "logout_after_each"	
	before :all do
		#Hold Base Data
		gen_start_test "Verify the versioning of statistical basis records."
		FFA.hold_base_data_and_wait
	end
	
	it "TID021246 : verifies the versioning of statistical basis records." do
		_gmt_offset = gen_get_current_user_gmt_offset
		_locale = gen_get_current_user_locale
		_today = gen_get_current_date _gmt_offset
		_today_date = gen_locale_format_date _today, _locale
		_5daysfromtoday = gen_locale_format_date (Time.now + 60*60*24*5).gmtime.getlocal(_gmt_offset).to_date, _locale
		_10daysfromtoday = gen_locale_format_date (Time.now + 60*60*24*10).gmtime.getlocal(_gmt_offset).to_date, _locale
		_statistical_basis_name = "Test statistical basis"
		_statistical_basis_date = _today_date
		_statistical_basis_period = FFA.get_period_by_date Date.today
		_statistical_basis_description = "TID021246-Statistical Value"
		_uom_area = "Area"
		_uom_rooms = "Rooms"
		_version1_line1 = [$bd_gla_account_receivable_control_eur, $bd_dim1_eur, $bd_dim2_eur, $bd_dim3_eur, $bd_dim4_eur, '250']
		_version1_line2 = [$bd_gla_account_receivable_control_usd,'',$bd_dim2_usd,'','','200']
		_version2_line1 = [$bd_gla_account_receivable_control_usd, $bd_dim1_usd, $bd_dim2_usd, $bd_dim3_usd, $bd_dim4_usd, '70']
		_version2_line2 = [$bd_gla_account_receivable_control_usd,'',$bd_dim2_usd,'','','200']
		_version2_line3 = ['',$bd_dim1_eur,'','',$bd_dim4_usd,'100']
		_version4_line2 = [$bd_gla_account_payable_control_usd, $bd_dim1_eur, $bd_dim2_eur, $bd_dim3_eur, $bd_dim4_eur, '150']
		_version4_line3 = [$bd_gla_account_payable_control_eur, $bd_dim1_eur, $bd_dim2_eur, $bd_dim3_eur, $bd_dim4_eur, '100']
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		begin
			gen_start_test "TST036808: Verify that version section is visible only on View UI."
			SF.tab $tab_statistical_value
			SF.click_button_new
			# Verification point - Version section is not available on new UI.
			expect(SB.is_version_table_present?).to be false
			gen_report_test "Version table is not present"
			#Insert the Statistical Basis header
			SB.set_statistical_basis_name _statistical_basis_name
			SB.set_date _statistical_basis_date
			SB.set_company $company_merlin_auto_gb
			SB.set_period _statistical_basis_period
			SB.set_description _statistical_basis_description
			SB.set_unit_of_measure $sb_uom_picklist_people_label
			#Insert a statistical value lines in the grid.
			SB.set_statistical_basis_line_gla 1,$bd_gla_account_receivable_control_eur
			SB.set_statistical_basis_line_dimension1 1,$bd_dim1_eur
			SB.set_statistical_basis_line_dimension2 1,$bd_dim2_eur
			SB.set_statistical_basis_line_dimension3 1,$bd_dim3_eur
			SB.set_statistical_basis_line_dimension4 1,$bd_dim4_eur
			SB.set_statistical_basis_line_value 1, 250.00
			SB.set_line_without_company true, 2, [$bd_gla_account_receivable_control_usd,'',$bd_dim2_usd,'','',200.00]
			#Save the basis and assert the expected value###
			SB.click_button $sb_save_button
			expect(SB.is_version_table_present?).to be true
			gen_report_test "Version table is present"
			expect(SB.assert_total_versions 1).to be true
			gen_report_test "Total 1 version is present in version grid"
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be false
			gen_report_test "Current Version button is not visibe"
			expect(SB.is_button_visible?$sb_delete_button).to be true
			gen_report_test "Delete button is visible"
			expect(SB.is_button_visible?$sb_edit_button).to be true
			gen_report_test "Edit button is visible"
			expect(SB.is_button_visible?$sb_back_to_list_button).to be true
			gen_report_test "Back to List button is visible"
			expect(SB.version_title_present?).to be false
			gen_report_test "Version Title is not visible"
			gen_end_test "TST036808: Verify that version section is visible only on View UI."
		end
		
		begin
			gen_start_test "TST036821: Verify that a new version is created when user updates the existing version by making changes in existing lines and adding new lines."
			SB.click_button $sb_edit_button
			expect(SB.is_version_table_present?).to be false
			gen_report_test "Version table is not present"
			SB.set_line_without_company true, 3, ['',$bd_dim1_eur,'','',$bd_dim4_usd,100.00]
			SB.set_statistical_basis_line_gla 1,$bd_gla_account_receivable_control_usd
			SB.set_statistical_basis_line_dimension1 1,$bd_dim1_usd
			SB.set_statistical_basis_line_dimension2 1,$bd_dim2_usd
			SB.set_statistical_basis_line_dimension3 1,$bd_dim3_usd
			SB.set_statistical_basis_line_dimension4 1,$bd_dim4_usd
			SB.set_statistical_basis_line_value 1, 70.00
			SB.click_button $sb_save_button
			expect(SB.is_version_table_present?).to be true
			gen_report_test "Version table is present"
			expect(SB.assert_total_versions 2).to be true
			gen_report_test "Total 2 versions are present in version grid"
			expect(SB.does_version_column_present?).to be true
			gen_report_test "version column is present in version grid"
			expect(SB.does_name_column_present?).to be true
			gen_report_test "Name column is present in version grid"
			expect(SB.does_description_column_present?).to be true
			gen_report_test "Description column is present in version grid"
			expect(SB.does_author_column_present?).to be true
			gen_report_test "Author column is present in version grid"
			expect(SB.does_date_column_present?).to be true
			gen_report_test "Date column is present in version grid"
			gen_compare "2", (SB.get_version_column_value 1), "Expected version 2 in row 1 of version grid"
			gen_compare "1", (SB.get_version_column_value 2), "Expected version 1 in row 2 of version grid"
			gen_end_test "TST036821: Verify that a new version is created when user updates the existing version by making changes in existing lines and adding new lines."
		end	
		begin
			gen_start_test "TST036822: Verify that a new version is created when user updates an existing version of statistical basis by updating header information."
			SB.click_button $sb_edit_button
			expect(SB.is_version_table_present?).to be false
			gen_report_test "Version table is not present"
			SB.set_description _statistical_basis_description+" 1"
			SB.set_date _5daysfromtoday
			SB.set_company $company_merlin_auto_spain
			SB.set_unit_of_measure _uom_area
			SB.click_button $sb_save_button
			expect(SB.is_version_table_present?).to be true
			gen_report_test "Version table is present"
			expect(SB.assert_total_versions 3).to be true
			gen_report_test "Total 3 versions are present in version grid"
			gen_compare "3", (SB.get_version_column_value 1), "Expected version 3 in row 1 of version grid"
			gen_compare "2", (SB.get_version_column_value 2), "Expected version 2 in row 2 of version grid"
			gen_compare "1", (SB.get_version_column_value 3), "Expected version 1 in row 3 of version grid"
			# go to version 1 and verify values
			SB.click_on_version 1
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be true
			gen_report_test "Current Version button is visibe"
			expect(SB.assert_version_title 1).to be true
			gen_report_test "Version title is Version(1)"
			# compare version grid in version 1
			gen_compare "3", (SB.get_version_column_value 1), "Expected version 3 in row 1 of version grid"
			gen_compare "2", (SB.get_version_column_value 2), "Expected version 2 in row 2 of version grid"
			gen_compare "1", (SB.get_version_column_value 3), "Expected version 1 in row 3 of version grid"
			gen_compare _statistical_basis_name, SB.get_statistical_basis_name, "Expected basis Name to be matched in version 1"
			gen_compare _statistical_basis_date, SB.get_date, "Expected Date to be matched on version 1"
			gen_compare $company_merlin_auto_gb, SB.get_company, "Expected Company to be matched in version 1"
			gen_compare _statistical_basis_period, SB.get_period, "Expected Period to be matched in version 1"
			gen_compare _statistical_basis_description, SB.get_description, "Expected Description to be matched in version 1"
			gen_compare $sb_uom_picklist_people_label, SB.get_unit_of_measure, "Expected Unit of measure to be matched in version 1"
			expect(SB.assert_line_with_gla false,1,_version1_line1).to be true
			gen_report_test "Version 1 Line 1 is Matched"
			expect(SB.assert_line_with_gla false,2,_version1_line2).to be true
			gen_report_test "Version 1 Line 2 is Matched"
			# go to version 2 and verify values
			SB.click_on_version 2
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be true
			gen_report_test "Current Version button is visibe"
			expect(SB.assert_version_title 2).to be true
			gen_report_test "Version title is Version(2)"
			# Compare version grid in version 2
			gen_compare "3", (SB.get_version_column_value 1), "Expected version 3 in row 1 of version grid"
			gen_compare "2", (SB.get_version_column_value 2), "Expected version 2 in row 2 of version grid"
			gen_compare "1", (SB.get_version_column_value 3), "Expected version 1 in row 3 of version grid"
			gen_compare _statistical_basis_name, SB.get_statistical_basis_name, "Expected basis Name to be matched  in version 2"
			gen_compare _statistical_basis_date, SB.get_date, "Expected Date to be matched in version 2"
			gen_compare $company_merlin_auto_gb, SB.get_company, "Expected Company to be matched in version 2"
			gen_compare _statistical_basis_period, SB.get_period, "Expected Period to be matched in version 2"
			gen_compare _statistical_basis_description, SB.get_description, "Expected Decription to be matched in version 2"
			gen_compare $sb_uom_picklist_people_label, SB.get_unit_of_measure, "Expected Unit of Measure to be matched in version 2"
			expect(SB.assert_line_with_gla false,1,_version2_line1).to be true
			gen_report_test "Version 2 Line 1 is Matched"
			expect(SB.assert_line_with_gla false,2,_version2_line2).to be true
			gen_report_test "Version 2 Line 2 is Matched"
			expect(SB.assert_line_with_gla false,3,_version2_line3).to be true
			gen_report_test "Version 2 Line 3 is Matched"
			# Go to latest version and verify content
			SB.click_button $sb_back_to_current_version_button
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be false
			gen_report_test "Current Version button is not visibe now"
			expect(SB.version_title_present?).to be false
			gen_report_test "Version title is not present now"
			# Compare version grid in version 3
			gen_compare "3", (SB.get_version_column_value 1), "Expected version 3 in row 1 of version grid"
			gen_compare "2", (SB.get_version_column_value 2), "Expected version 2 in row 2 of version grid"
			gen_compare "1", (SB.get_version_column_value 3), "Expected version 1 in row 3 of version grid"
			gen_compare _statistical_basis_name, SB.get_statistical_basis_name, "Expected basis Name to be matched in latest version"
			gen_compare _5daysfromtoday, SB.get_date, "Expected Date to be matched in latest version"
			gen_compare $company_merlin_auto_spain, SB.get_company, "Expected Company to be matched in latest version"
			gen_compare _statistical_basis_description+" 1", SB.get_description, "Expected Description to be matched in latest version"
			gen_compare _uom_area, SB.get_unit_of_measure, "Expected Unit of Measure to be matched in latest version"
			expect(SB.assert_line_with_gla false,1,_version2_line1).to be true
			gen_report_test "Version 3 Line 1 is Matched"
			expect(SB.assert_line_with_gla false,2,_version2_line2).to be true
			gen_report_test "Version 3 Line 2 is Matched"
			expect(SB.assert_line_with_gla false,3,_version2_line3).to be true
			gen_report_test "Version 3 Line 3 is Matched"
			gen_end_test "TST036822: Verify that a new version is created when user updates an existing version of statistical basis by updating header information."
		end
		begin
			gen_start_test "TST036836: Verify that a new version is created when user updates an existing version of statistical basis by updating header as well as lines information."
			SB.click_button $sb_edit_button
			expect(SB.is_version_table_present?).to be false
			gen_report_test "Version table is not present"
			SB.set_description _statistical_basis_description+" 2"
			SB.set_date _10daysfromtoday
			SB.set_company $company_merlin_auto_usa
			SB.set_unit_of_measure _uom_rooms
			SB.set_statistical_basis_line_gla 2,$bd_gla_account_payable_control_usd
			SB.set_statistical_basis_line_dimension1 2,$bd_dim1_eur
			SB.set_statistical_basis_line_dimension2 2,$bd_dim2_eur
			SB.set_statistical_basis_line_dimension3 2,$bd_dim3_eur
			SB.set_statistical_basis_line_dimension4 2,$bd_dim4_eur
			SB.set_statistical_basis_line_value 2, 150.00
			SB.set_statistical_basis_line_gla 4,$bd_gla_account_payable_control_eur
			SB.set_statistical_basis_line_dimension1 4,$bd_dim1_eur
			SB.set_statistical_basis_line_dimension2 4,$bd_dim2_eur
			SB.set_statistical_basis_line_dimension3 4,$bd_dim3_eur
			SB.set_statistical_basis_line_dimension4 4,$bd_dim4_eur
			SB.set_statistical_basis_line_value 4, 100.00
			SB.delete_line 3
			SB.click_button $sb_save_button
			expect(SB.is_version_table_present?).to be true
			gen_report_test "Version table is present"
			expect(SB.assert_total_versions 4).to be true
			gen_report_test "Total 4 versions are present in version grid"
			gen_compare "4", (SB.get_version_column_value 1), "Expected version 4 in row 1 of version grid"
			gen_compare "3", (SB.get_version_column_value 2), "Expected version 3 in row 2 of version grid"
			gen_compare "2", (SB.get_version_column_value 3), "Expected version 2 in row 3 of version grid"
			gen_compare "1", (SB.get_version_column_value 4), "Expected version 1 in row 3 of version grid"
			# go to version 1 and verify values
			SB.click_on_version 1
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be true
			gen_report_test "Current Version button is visibe"
			expect(SB.is_button_visible? $sb_edit_button).to be false
			gen_report_test "Edit button is not visibe"
			expect(SB.is_button_visible? $sb_delete_button).to be false
			gen_report_test "Delete button is not visibe"
			expect(SB.assert_version_title 1).to be true
			gen_report_test "Version title is Version(1)"
			# Compare versions in version grid in version 1
			gen_compare "4", (SB.get_version_column_value 1), "Expected version 4 in row 1 of version grid"
			gen_compare "3", (SB.get_version_column_value 2), "Expected version 3 in row 2 of version grid"
			gen_compare "2", (SB.get_version_column_value 3), "Expected version 2 in row 3 of version grid"
			gen_compare "1", (SB.get_version_column_value 4), "Expected version 1 in row 3 of version grid"
			gen_compare _statistical_basis_name, SB.get_statistical_basis_name, "Expected basis Name to be matched  in version 1"
			gen_compare _statistical_basis_date, SB.get_date, "Expected Date to be matched  in version 1"
			gen_compare $company_merlin_auto_gb, SB.get_company, "Expected Company to be matched in version 1"
			gen_compare _statistical_basis_period, SB.get_period, "Expected Period to be matched in version 1"
			gen_compare _statistical_basis_description, SB.get_description, "Expected Description to be matched in version 1"
			gen_compare $sb_uom_picklist_people_label, SB.get_unit_of_measure, "Expected Unit Of Measure to be matched in version 1"
			expect(SB.assert_line_with_gla false,1,_version1_line1).to be true
			gen_report_test "Version 1 Line 1 is Matched"
			expect(SB.assert_line_with_gla false,2,_version1_line2).to be true
			gen_report_test "Version 1 Line 2 is Matched"
			# go to version 2 and verify values
			SB.click_on_version 2
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be true
			gen_report_test "Current Version button is visibe"
			expect(SB.is_button_visible? $sb_edit_button).to be false
			gen_report_test "Edit button is not visibe"
			expect(SB.is_button_visible? $sb_delete_button).to be false
			gen_report_test "Delete button is not visibe"
			expect(SB.assert_version_title 2).to be true
			gen_report_test "Version title is Version(2)"
			# Compare versions in version grid in version 2
			gen_compare "4", (SB.get_version_column_value 1), "Expected version 4 in row 1 of version grid"
			gen_compare "3", (SB.get_version_column_value 2), "Expected version 3 in row 2 of version grid"
			gen_compare "2", (SB.get_version_column_value 3), "Expected version 2 in row 3 of version grid"
			gen_compare "1", (SB.get_version_column_value 4), "Expected version 1 in row 3 of version grid"
			gen_compare _statistical_basis_name, SB.get_statistical_basis_name, "Expected basis Name to be matched in version 2"
			gen_compare _statistical_basis_date, SB.get_date, "Expected Date to be matched in version 2"
			gen_compare $company_merlin_auto_gb, SB.get_company, "Expected Company to be matched in version 2"
			gen_compare _statistical_basis_period, SB.get_period, "Expected Period to be matched in version 2"
			gen_compare _statistical_basis_description, SB.get_description, "Expected Description to be matched in version 2"
			gen_compare $sb_uom_picklist_people_label, SB.get_unit_of_measure, "Expected Unit of Measure to be matched in version 2"
			expect(SB.assert_line_with_gla false,1,_version2_line1).to be true
			gen_report_test "Version 2 Line 1 is Matched"
			expect(SB.assert_line_with_gla false,2,_version2_line2).to be true
			gen_report_test "Version 2 Line 2 is Matched"
			expect(SB.assert_line_with_gla false,3,_version2_line3).to be true
			gen_report_test "Version 2 Line 3 is Matched"
			# Go to version 3 and verify content
			SB.click_on_version 3
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be true
			gen_report_test "Current Version button is visibe"
			expect(SB.is_button_visible? $sb_edit_button).to be false
			gen_report_test "Edit button is not visibe"
			expect(SB.is_button_visible? $sb_delete_button).to be false
			gen_report_test "Delete button is not visibe"
			expect(SB.assert_version_title 3).to be true
			gen_report_test "Version title is Version(3)"
			# Compare versions in version grid in version 3
			gen_compare "4", (SB.get_version_column_value 1), "Expected version 4 in row 1 of version grid"
			gen_compare "3", (SB.get_version_column_value 2), "Expected version 3 in row 2 of version grid"
			gen_compare "2", (SB.get_version_column_value 3), "Expected version 2 in row 3 of version grid"
			gen_compare "1", (SB.get_version_column_value 4), "Expected version 1 in row 3 of version grid"
			gen_compare _statistical_basis_name, SB.get_statistical_basis_name, "Expected basis Name to be matched in version 3"
			gen_compare _5daysfromtoday, SB.get_date, "Expected Date to be matched in version 3"
			gen_compare $company_merlin_auto_spain, SB.get_company, "Expected Company to be matched in version 3"
			gen_compare _statistical_basis_description+" 1", SB.get_description, "Expected Description to be matched in version 3"
			gen_compare _uom_area, SB.get_unit_of_measure, "Expected Unit of Measure to be matched in version 3"
			expect(SB.assert_line_with_gla false,1,_version2_line1).to be true
			gen_report_test "Version 3 Line 1 is Matched"
			expect(SB.assert_line_with_gla false,2,_version2_line2).to be true
			gen_report_test "Version 3 Line 2 is Matched"
			expect(SB.assert_line_with_gla false,3,_version2_line3).to be true
			gen_report_test "Version 3 Line 3 is Matched"
			# Go to latest version and verify content
			SB.click_button $sb_back_to_current_version_button
			expect(SB.is_button_visible? $sb_back_to_current_version_button).to be false
			gen_report_test "Current Version button is not visibe now"
			expect(SB.is_button_visible? $sb_edit_button).to be true
			gen_report_test "Edit button is visibe"
			expect(SB.is_button_visible? $sb_delete_button).to be true
			gen_report_test "Delete button is visibe"
			expect(SB.version_title_present?).to be false
			gen_report_test "Version title is not present now"
			# Compare versions in version grid in version 4
			gen_compare "4", (SB.get_version_column_value 1), "Expected version 4 in row 1 of version grid"
			gen_compare "3", (SB.get_version_column_value 2), "Expected version 3 in row 2 of version grid"
			gen_compare "2", (SB.get_version_column_value 3), "Expected version 2 in row 3 of version grid"
			gen_compare "1", (SB.get_version_column_value 4), "Expected version 1 in row 3 of version grid"
			gen_compare _statistical_basis_name, SB.get_statistical_basis_name, "Expected basis Name to be matched in latest version"
			gen_compare _10daysfromtoday, SB.get_date, "Expected Date to be matched in latest version"
			gen_compare $company_merlin_auto_usa, SB.get_company, "Expected Company to be matched in latest version"
			gen_compare _statistical_basis_description+" 2", SB.get_description, "Expected Description to be matched in latest version"
			gen_compare _uom_rooms, SB.get_unit_of_measure, "Expected Unit of Measure to be matched in latest version"
			expect(SB.assert_line_with_gla false,1,_version2_line1).to be true
			gen_report_test "Version 4 Line 1 is Matched"
			expect(SB.assert_line_with_gla false,2,_version4_line2).to be true
			gen_report_test "Version 4 Line 2 is Matched"
			expect(SB.assert_line_with_gla false,3,_version4_line3).to be true
			gen_report_test "Version 4 Line 3 is Matched"
			gen_end_test "TST036836: Verify that a new version is created when user updates an existing version of statistical basis by updating header as well as lines information."
		end
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
	end
end