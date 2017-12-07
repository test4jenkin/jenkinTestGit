#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
MAX_RETRY_COUNT=2
module SB
extend Capybara::DSL
####### Statistical Basis Header Selectors ###########
$sb_name = "div[data-ffid='basisName'] input"
$sb_date = "div[data-ffid='basisDate'] input"
$sb_period = "div[data-ffid='basisPeriod'] input"
$sb_descirption = "div[data-ffid='basisDesc'] input"
$sb_unit_of_measure = "div[data-ffid='basisUnitOfMeasure'] input"
$sb_company = "div[data-ffid='basisCompany'] input"
$sb_total_value = "div[data-ffid='summaryBar'] td[data-columnid='splitTableColumnValue']"
$sb_title = "div[data-ffid='basisTitle']"
$sb_close_button = "div[data-ffid='CloseButton']"
$sb_field_disabled = "div[data-ffid*='"+$sf_param_substitute+"'][class*='f-item-disabled']"
####### Statistical Basis Line Selectors ###########
$sb_line_company =  "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='splitTableColumnCompany']"
$sb_line_company_input =  "input[name = 'Company']"
$sb_line_gla =  "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='splitTableColumnGLA']"
$sb_line_gla_input =  "input[name = 'GeneralLedgerAccount']"
$sb_line_dimension1 =  "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='splitTableColumnDIM1']"
$sb_line_dimension1_input =  "input[name = 'Dimension1']"
$sb_line_dimension2 =  "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='splitTableColumnDIM2']"
$sb_line_dimension2_input =  "input[name = 'Dimension2']"
$sb_line_dimension3 =  "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='splitTableColumnDIM3']"
$sb_line_dimension3_input =  "input[name = 'Dimension3']"
$sb_line_dimension4 =  "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='splitTableColumnDIM4']"
$sb_line_dimension4_input =  "input[name = 'Dimension4']"
$sb_line_value =  "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='splitTableColumnValue']"
$sb_line_value_input =  "input[name = 'Value']"
$sb_line_delete_button = "div[data-ffid='basisTable'] table:nth-of-type("+$sf_param_substitute+") tr td[data-columnid='deleteLineButton']"
$sb_line_header_columns = "div[data-ffxtype$='column']"
####### Statistical Basis button Selectors #######
$sb_button = "a[data-ffid='"+$sf_param_substitute+"']"
$sb_button_disabled = "a[data-ffid= '"+$sf_param_substitute+"'][class*='f-btn-disabled']"
$sb_save_button = "saveButton"
$sb_delete_button = "deleteButton"
$sb_edit_button = "editButton"
$sb_back_to_list_button = "backToListButton"
$sb_cancel_button = "cancelButton"
$sb_open_attachment_button = "openAttachment"
$sb_list_view_new_button = "input[title='New Statistical Basis']"
$sb_link_pattern = "//div[contains(@class,'listBody')]//span[contains(text(),'"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$sb_import_csv_button = "//div[contains(@id,'filebutton')]/div/span/following-sibling::input"
$sb_back_to_current_version_button = "backToCurrentVersionButton"
$sb_menu_item_checked_class = "f-menu-item-checked"
$sb_menu_item_unchecked_class = "f-menu-item-unchecked"
$sb_menu_pattern_gla = "//div[@data-ffxtype='menu']//span[text()='General Ledger Account']/parent::a"

####### Statistical Basis Version Table Selectors ########
$sb_version_table = "div[data-ffid='basisVersionTable']"
$sb_version_table_version = "//td[@data-columnid = 'versionColumn']//a[text()='"+$sf_param_substitute+"']"
$sb_version_table_version_value = $sb_version_table+" table:nth-of-type("+$sf_param_substitute+") td[data-columnid='versionColumn']"
$sb_version_table_version_column = $sb_version_table+" div[data-ffid='versionColumn']"
$sb_version_table_name_column = $sb_version_table+" div[data-ffid='nameColumn']"
$sb_version_table_description_column = $sb_version_table+" div[data-ffid='descriptionColumn']"
$sb_version_table_date_column = $sb_version_table+" div[data-ffid='dateColumn']"
$sb_version_table_author_column = $sb_version_table+" div[data-ffid='authorColumn']"
$sb_version_title = "div[data-ffid='versionTitle']"
$sb_total_versions = $sb_version_table + " div[data-ffxtype='title'] div"
$sb_versions_label = "Versions ("+$sf_param_substitute+")"
$sb_version_title_label = "Version ("+$sf_param_substitute+")"
$sb_loading_icon = "//div[text()='Loading']"
$sb_dim1_menu_item_button = "div[data-ffid='splitTableColumnDIM1'] div[class= 'f-column-header-trigger']"
$sb_columns_arrow = "div[data-ffid='columnItem'] div[class*='f-menu-item-arrow']"
$sb_columns_menu_item_gla = "div[data-ffxtype='menucheckitem']:nth-child(1)"
$sb_basis_line_company_column_header = "div[data-ffid='splitTableColumnCompany']"
$sb_basis_line_gla_column_header = "div[data-ffid='splitTableColumnGLA']"
$sb_basis_line_dim1_column_header = "div[data-ffid='splitTableColumnDIM1']"
####### Statistical Basis Attachment Popup Selectors ########
$sb_attachment_count = "div[data-ffxtype='displayfield'] div div"
$sb_attachment_popup_add_attachment_button = "a[data-ffid='addAttachment']"
$sb_attachment_popup_close_button = "a[data-ffid='closeAttachmentPopUp']"
$sb_attachment_popup_grid = "div[data-ffid='attachmentgrid']"
$sb_attachment_popup_grid_filename_column = $sb_attachment_popup_grid + " div[data-ffid='fileName']"
$sb_attachment_popup_grid_added_column = $sb_attachment_popup_grid + " div[data-ffid='added']"
$sb_attachment_popup_grid_author_column = $sb_attachment_popup_grid + " div[data-ffid='authorColumn']"
$sb_attachment_popup_grid_table = $sb_attachment_popup_grid + " table"
$sb_attachment_grid_delete_attachment_icon = "//div[@data-ffid='attachmentgrid']//a[contains(text(),'"+$sf_param_substitute+"')]/../../preceding-sibling::td[@data-columnid='sbAttachmentTableColumnDEL']/div/div[contains(@class,'ffdc-icon-delete')]"
$sb_attachment_grid_file_name = "div[data-ffid='attachmentgrid'] table:nth-of-type("+$sf_param_substitute+") td[data-columnid='fileName'] a"
####### Labels #######
$sb_title_label = "Statistical Bases"
$sb_uom_picklist_people_label = "People"
################ Methods ################
#### Set Statistical Basis Header Name ####
	def SB.set_statistical_basis_name value
		find($sb_name).set value
	end
#### Get Statistical Basis Header Name ####	
	def SB.get_statistical_basis_name
		return find($sb_name).value
	end
#### Set Statistical Basis Header Date ####	
	def SB.set_date value
		find($sb_date).set value
		gen_tab_out $sb_date
	end
#### Get Statistical Basis Header Date ####		
	def SB.get_date
		return find($sb_date).value
	end
#### Set Statistical Basis Header Period ####
	def SB.set_period value
		find($sb_period).set value
	end
#### Get Statistical Basis Header Period ####	
	def SB.get_period
		gen_wait_less # on page reload period value gets populated a movement later.
		return find($sb_period).value
	end
#### Set Statistical Basis Header Description ####	
	def SB.set_description value
		find($sb_descirption).set value
	end
#### Get Statistical Basis Header Description ####		
	def SB.get_description
		return find($sb_descirption).value
	end
#### Set Statistical Basis Header Unit Of Measure ####		
	def SB.set_unit_of_measure value
		find($sb_unit_of_measure).set value
	end
#### Get Statistical Basis Header Unit Of Measure ####			
	def SB.get_unit_of_measure
		return find($sb_unit_of_measure).value
	end
#### Set Statistical Basis Header Company ####			
	def SB.set_company value
		find($sb_company).set value
		gen_tab_out $sb_date
	end
#### Get Statistical Basis Header Company ####		
	def SB.get_company
		return find($sb_company).value
	end
#### Assert Statistical Basis Header Total Value ####		
	def SB.assert_total_value expected_value
		actual_value = find($sb_total_value).text
		return expected_value == actual_value
	end
#### Assert Title ####		
	def SB.assert_title title
		return title == find($sb_title).text
	end
#### Close Statistical Basis page ####		
	def SB.click_close_icon
		find($sb_close_button).click
	end
#### Assert that field is enabled on Header ####	
	def SB.is_field_enabled? field_name
		return page.has_no_css? ($sb_field_disabled.sub($sf_param_substitute, field_name))
	end
#### Get the Attachment count from the Header ####	
	def SB.get_attachment_count
		return find($sb_attachment_count).text
	end
#### Click on Button ####
# Choose button_name from following
# $sb_save_button = "saveButton"
# $sb_delete_button = "deleteButton"
# $sb_edit_button = "editButton"
# $sb_back_to_list_button = "backToListButton"
# $sb_cancel_button = "cancelButton"
# $sb_back_to_current_version_button = "backToCurrentVersionButton"
# $sb_open_attachment_button = "openAttachment"
##########################
	def SB.click_button button_name
		find($sb_total_value).click
		button = $sb_button.sub($sf_param_substitute, button_name)
		is_enabled = SB.is_button_enabled? button_name
		if is_enabled
			find(button).click
		else
			raise "Button #{button_name} is disabled"
		end	
		gen_wait_until_object_disappear $sb_loading_icon
	end
	def SB.is_button_visible? button_name
		return page.has_css? ($sb_button.sub($sf_param_substitute, button_name))
	end
	def SB.is_button_enabled? button_name
		return page.has_no_css? ($sb_button_disabled.sub($sf_param_substitute, button_name))
	end
#### Delete a line ####	
	def SB.delete_line line_number
		delete_button = $sb_line_delete_button.sub($sf_param_substitute, line_number.to_s)
		find(delete_button).click
	end
#### Importing CSV file####
	def SB.import_csv_file file_name
		if OS_TYPE == OS_WINDOWS
			file_path = $upload_file_path + file_name
			pwd = Dir.pwd + file_path
			win_pwd=pwd.gsub("/", "\\")
		else 
			file_path = $upload_file_path + file_name
			win_pwd = Dir.pwd + file_path
		end
		puts "Importing file: " + win_pwd
		element_id= find(:xpath, $sb_import_csv_button, visible: false)[:id]
		attach_file(element_id, win_pwd, visible: false)
	end
#### Assert content of a line ####
# line_content - the whole line in an array which needs to be asserted for ex.
# Case 1 : with_company = true
# [company_name, gla name, dim1 name, dim2 name, dim3 name, dim4 name, value]
# Case 2 : with_company = false
# [gla name, dim1 name, dim2 name, dim3 name, dim4 name, value]
# if value of any column is blank then simply pass blank string for ex. 
# ['', '', dim2 name, dim3 name, '', value]
##################################
	def SB.assert_line_with_gla with_company, line_number, line_content
		company_matched = false
		gla_matched = false
		dim1_matched = false
		dim2_matched = false
		dim3_matched = false
		dim4_matched = false
		value_matched = false
		index = 0

		if(with_company == true)
			if line_content[0].eql?(SB.get_statistical_basis_line_company line_number)
				company_matched = true
			else
				puts "Company not matched, Expected - #{line_content[0]} Actual - #{SB.get_statistical_basis_line_company line_number}"
			end
			index = 1
		end

		if line_content[0 + index].eql?(SB.get_statistical_basis_line_gla line_number)
			gla_matched = true
		else
			puts "GLA not matched, Expected - #{line_content[0 + index]} Actual - #{SB.get_statistical_basis_line_gla line_number}"
		end
		if line_content[1 + index] == (SB.get_statistical_basis_line_dimension1 line_number)
			dim1_matched = true
		else
			puts "Dimension 1 not matched, Expected - #{line_content[1 + index]} Actual - #{SB.get_statistical_basis_line_dimension1 line_number}"	
		end
		if line_content[2 + index] == (SB.get_statistical_basis_line_dimension2 line_number)
			dim2_matched = true
		else
			puts "Dimension 2 not matched, Expected - #{line_content[2 + index]} Actual - #{SB.get_statistical_basis_line_dimension2 line_number}"	
		end
		if line_content[3 + index] == (SB.get_statistical_basis_line_dimension3 line_number)
			dim3_matched = true
		else
			puts "Dimension 3 not matched, Expected - #{line_content[3 + index]} Actual - #{SB.get_statistical_basis_line_dimension3 line_number}"	
		end
		if line_content[4 + index] == (SB.get_statistical_basis_line_dimension4 line_number)
			dim4_matched = true
		else
			puts "Dimension 4 not matched, Expected - #{line_content[4 + index]} Actual - #{SB.get_statistical_basis_line_dimension4 line_number}"	
		end
		if line_content[5 + index] == (SB.get_statistical_basis_line_value line_number)
			value_matched = true
		else
			puts "Value not matched, Expected - #{line_content[5 + index]} Actual - #{SB.get_statistical_basis_line_value line_number}"	
		end
		if(with_company == true)
			return (company_matched and gla_matched and dim1_matched and dim2_matched and dim3_matched and dim4_matched and value_matched)
		else
			return (gla_matched and dim1_matched and dim2_matched and dim3_matched and dim4_matched and value_matched)
		end
	end
#### Add a new Line ####
	def SB.add_new_line previous_line_number
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_value_input
			if (!object_visible)
				record_to_click = $sb_line_value.gsub($sf_param_substitute, previous_line_number.to_s)
				find(record_to_click).click
			end
			find($sb_line_value_input).click
			gen_wait_less
			gen_tab_out $sb_line_value_input
		end
	end
#### Set Line at given line Number with company ####	
# Case 1  with_gla = true
# line = [company, gla name, dim1 name, dim2 name, dim3 name, dim4 name, value]
# Case 2  with_gla = false
# line = [company, dim1 name, dim2 name, dim3 name, dim4 name, value]
#######################################
	def SB.set_line_with_company with_gla, line_number, line
		index = 0
		SB.set_statistical_basis_line_company line_number, line[0]
		if(with_gla == true && line.size == 7)
			index = 1
			SB.set_statistical_basis_line_gla line_number, line[index]
		end
		SB.set_statistical_basis_line_dimension1 line_number,  line[index + 1]
		SB.set_statistical_basis_line_dimension2 line_number,  line[index + 2]
		SB.set_statistical_basis_line_dimension3 line_number,  line[index + 3]
		SB.set_statistical_basis_line_dimension4 line_number,  line[index + 4]
		SB.set_statistical_basis_line_value line_number,  line[index + 5]
	end
#### Set Multiple lines from the given start_line_number ####	
# Case 1 with_gla = true
# lines = [
#[company1 name, gla1 name, dim1 name1, dim2 name1, dim3 name1, dim4 name1, value1],
#[company2 name, gla2 name, dim1 name2, dim2 name2, dim3 name2, dim4 name2, value2],
#[company3 name, gla3 name, dim1 name3, dim2 name3, dim3 name3, dim4 name3, value3],
#['','','North','South','','', 325.00]
#]
# Case 2 with_gla = false
# lines = [
#[company1 name, dim1 name1, dim2 name1, dim3 name1, dim4 name1, value1],
#[company2 name, dim1 name2, dim2 name2, dim3 name2, dim4 name2, value2],
#['','North','South','','', 325.00]
#]
#############################################################
	def SB.set_lines_with_company with_gla, lines, start_line_number = 1
		line_number = start_line_number
		lines.each do |line|
			SB.set_line_with_company with_gla,line_number,line
			line_number += 1
		end
	end
#### Set Line at given line Number without company ####	
# Case 1  with_gla = true
# line = [gla name, dim1 name, dim2 name, dim3 name, dim4 name, value]
# Case 2  with_gla = false
# line = [dim1 name, dim2 name, dim3 name, dim4 name, value]
#######################################
	def SB.set_line_without_company  with_gla, line_number, line
		index = 0
		if(with_gla == true && line.size == 6)
			SB.set_statistical_basis_line_gla line_number, line[index]
			index = 1
		end
		SB.set_statistical_basis_line_dimension1 line_number,  line[index]
		SB.set_statistical_basis_line_dimension2 line_number,  line[index + 1]
		SB.set_statistical_basis_line_dimension3 line_number,  line[index + 2]
		SB.set_statistical_basis_line_dimension4 line_number,  line[index + 3]
		SB.set_statistical_basis_line_value line_number,  line[index + 4]
	end
#### Set Statistical Basis Line Company at given line_number ####	
	def SB.set_statistical_basis_line_company line_number, company_value
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_company_input
			if (!object_visible)
				record_to_click = $sb_line_company.gsub($sf_param_substitute, line_number.to_s)		
				SF.retry_script_block do
					find(record_to_click).click
				end	
			end
			SF.retry_script_block do
				find($sb_line_company_input).set company_value
			end
		end
	end
#### Get Statistical Basis Line Company column from given line number ####	
	def SB.get_statistical_basis_line_company line_number
		return find($sb_line_company.gsub($sf_param_substitute, line_number.to_s)).text
	end
#### Set Statistical Basis Line GLA at given line_number ####	
	def SB.set_statistical_basis_line_gla line_number, gla_value
		SB.show_gla_column
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_gla_input
			if (!object_visible)
				record_to_click = $sb_line_gla.gsub($sf_param_substitute, line_number.to_s)		
				SF.retry_script_block do
					find(record_to_click).click
				end	
			end
			SF.retry_script_block do
				find($sb_line_gla_input).set gla_value
			end
		end
	end
#### Get Statistical Basis Line GLA column from given line number ####	
	def SB.get_statistical_basis_line_gla line_number
		return find($sb_line_gla.gsub($sf_param_substitute, line_number.to_s)).text
	end
#### Set Statistical Basis Line Dimension 1 column at given line_number ####
	def SB.set_statistical_basis_line_dimension1 line_number, dimension_value
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_dimension1_input
			if (!object_visible)
				record_to_click = $sb_line_dimension1.gsub($sf_param_substitute, line_number.to_s)
				SF.retry_script_block do
					find(record_to_click).click
				end	
			end
			find($sb_line_dimension1_input).set dimension_value
		end
	end
#### Get Statistical Basis Line Dimension 1 column from given line number ####	
	def SB.get_statistical_basis_line_dimension1 line_number
		return find($sb_line_dimension1.gsub($sf_param_substitute, line_number.to_s)).text
	end
#### Set Statistical Basis Line Dimension 2 column at given line_number ####	
	def SB.set_statistical_basis_line_dimension2 line_number, dimension_value
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_dimension2_input
			if (!object_visible)
				record_to_click = $sb_line_dimension2.gsub($sf_param_substitute, line_number.to_s)
				find(record_to_click).click
			end
			find($sb_line_dimension2_input).set dimension_value
		end
	end
#### Get Statistical Basis Line Dimension 2 column from given line number ####	
	def SB.get_statistical_basis_line_dimension2 line_number
		return find($sb_line_dimension2.gsub($sf_param_substitute, line_number.to_s)).text
	end
#### Set Statistical Basis Line Dimension 3 column at given line_number ####	
	def SB.set_statistical_basis_line_dimension3 line_number, dimension_value
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_dimension3_input
			if (!object_visible)
				record_to_click = $sb_line_dimension3.gsub($sf_param_substitute, line_number.to_s)
				find(record_to_click).click
			end
			find($sb_line_dimension3_input).set dimension_value
		end
	end
#### Get Statistical Basis Line Dimension 3 column from given line number ####	
	def SB.get_statistical_basis_line_dimension3 line_number
		return find($sb_line_dimension3.gsub($sf_param_substitute, line_number.to_s)).text
	end
#### Set Statistical Basis Line Dimension 4 column at given line_number ####	
	def SB.set_statistical_basis_line_dimension4 line_number, dimension_value
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_dimension4_input
			if (!object_visible)
				record_to_click = $sb_line_dimension4.gsub($sf_param_substitute, line_number.to_s)
				find(record_to_click).click
			end
			find($sb_line_dimension4_input).set dimension_value
		end
	end
#### Get Statistical Basis Line Dimension 4 column from given line number ####
	def SB.get_statistical_basis_line_dimension4 line_number
		return find($sb_line_dimension4.gsub($sf_param_substitute, line_number.to_s)).text
	end
#### Set Statistical Basis Line Company Column at given line_number ####
	def SB.set_statistical_basis_line_company line_number, company_name
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_company_input
			if (!object_visible)
				record_to_click = $sb_line_company.gsub($sf_param_substitute, line_number.to_s)
				find(record_to_click).click
			end
			find($sb_line_company_input).set company_name
		end
	end
#### Get Statistical Basis Line Company Column from given line_number ####
	def SB.get_statistical_basis_line_company line_number
		return find($sb_line_company.gsub($sf_param_substitute, line_number.to_s)).text
	end	
#### Set Statistical Basis Line Value column at given line_number ####	
	def SB.set_statistical_basis_line_value line_number, value
		SF.execute_script do
			object_visible = gen_is_object_visible $sb_line_value_input
			if (!object_visible)
				record_to_click = $sb_line_value.gsub($sf_param_substitute, line_number.to_s)
				find(record_to_click).click
			end
			find($sb_line_value_input).set value
		end
	end
#### Get Statistical Basis Line Value from given line number ####	
	def SB.get_statistical_basis_line_value line_number
		return find($sb_line_value.gsub($sf_param_substitute, line_number.to_s)).text
	end
#### Assert that company column is visible####
	def SB.is_company_column_present?
		return page.has_css?($sb_basis_line_company_column_header) 
	end
#### Wait for list view to appear ####
	def SB.wait_for_list_view
		gen_wait_until_object $sb_list_view_new_button
	end
############## Open Statistical Basis from List View ####################
	def SB.open_statistical_basis_detail_page basis_name
		record_to_click = $sb_link_pattern.gsub($sf_param_substitute, basis_name.to_s)
		find(:xpath , record_to_click).click
	end
#### Get if the table is present or not ####
	def SB.is_version_table_present?
		return page.has_css?($sb_version_table)
	end
#### Click on Version ####
# Latest version will always be disabled so will not be clickable
####
	def SB.click_on_version version_number
		within $sb_version_table do
			version_column = $sb_version_table_version.sub($sf_param_substitute, (version_number).to_s)
			SF.retry_script_block do
				find(:xpath, version_column).click
			end
		end
		gen_wait_until_object_disappear $sb_loading_icon
	end
#### Get Version column value ####
	def SB.get_version_column_value row_number 
		version_column = $sb_version_table_version_value.sub($sf_param_substitute, (row_number).to_s)
		return find(version_column).text
	end
#### Assert total number of versions ####
	def SB.assert_total_versions expected_versions
		actual_num_of_versions = find($sb_total_versions).text
		expected_num_of_versions = $sb_versions_label.sub($sf_param_substitute, expected_versions.to_s)
		return actual_num_of_versions == expected_num_of_versions
	end
#### Get version Title in header panel ####
	def SB.assert_version_title expected_version
		actual_title = find($sb_version_title).text
		expected_title = $sb_version_title_label.sub($sf_param_substitute, expected_version.to_s)
		return actual_title == expected_title
	end
#### is version title visible ####
	def SB.version_title_present?
		return page.has_css? ($sb_version_title)
	end
#### verify version table columns ####
	def SB.does_version_column_present?
		return page.has_css? $sb_version_table_version_column
	end
	
	def SB.does_name_column_present?
		return page.has_css? $sb_version_table_name_column
	end
	
	def SB.does_description_column_present?
		return page.has_css? $sb_version_table_description_column
	end
	
	def SB.does_author_column_present?
		return page.has_css? $sb_version_table_author_column
	end
	
	def SB.does_date_column_present?
		return page.has_css? $sb_version_table_date_column
	end

#### show general ledger account column ####
	def SB.show_gla_column
		is_present = page.has_css?($sb_basis_line_gla_column_header)
		if !is_present
			find($sb_basis_line_dim1_column_header).hover
			find($sb_dim1_menu_item_button).click
			find($sb_columns_arrow).click
			find(:xpath, $sb_menu_pattern_gla).click
		end
	end
#### hide general ledger account column ####
	def SB.hide_gla_column
		if page.has_css?($sb_basis_line_gla_column_header)
			find($sb_basis_line_dim1_column_header).hover
			find($sb_dim1_menu_item_button).click
			find($sb_columns_arrow).click
			classes = find($sb_columns_menu_item_gla)[:class]
			is_checked = classes.include? $sb_menu_item_checked_class
			if is_checked
				find($sb_columns_menu_item_gla+' a div').click
			end
		end	
	end
#### Attachment Popup #####
	def SB.attach_file_in_attachment_popup file_name
		SB.click_button $sb_open_attachment_button
		SB.click_add_attachment_button_in_attachment_popup
		window = page.driver.browser.window_handles
		if window.size > 1 
			FFA.new_window do
				FFA.upload_file "file",file_name
				find($ffa_attach_button).click
				find($ffa_attach_done_button).click
			end
			page.driver.browser.switch_to.window(window.first)
		else
			FFA.upload_file "file",file_name
			find($ffa_attach_button).click
			find($ffa_attach_done_button).click
		end
	end
	def SB.click_add_attachment_button_in_attachment_popup
		find($sb_attachment_popup_add_attachment_button).click
	end
	def SB.click_close_button_in_attachment_popup
		find($sb_attachment_popup_close_button).click
	end
	def SB.delete_attachment_in_attachment_popup attachment_name
		SF.retry_script_block do
			line_to_delete = $sb_attachment_grid_delete_attachment_icon.sub($sf_param_substitute, attachment_name)
			attachment_rows = page.all($sb_attachment_popup_grid_table)
		 
			find(:xpath, line_to_delete).hover
			sleep 1
			find(:xpath, line_to_delete).click
			gen_wait_less # Wait for table to refresh and update the number of rows after delete operation.
			count_rows = page.all($sb_attachment_popup_grid_table)
			SF.log_info "After delete file #{attachment_name} , count is  #{count_rows.size}"
			if(count_rows.size == ((attachment_rows.size)-1))
				SF.log_info "Attachment  Name - #{attachment_name} is deleted."
				break
			else
				raise "Object not deleted : #{line_to_delete}"
			end
		end
	end

	def SB.does_file_name_column_present_in_attachment_popup?
		return page.has_css? $sb_attachment_popup_grid_filename_column
	end
	def SB.does_added_column_present_in_attachment_popup?
		return page.has_css? $sb_attachment_popup_grid_added_column
	end
	def SB.does_author_column_present_in_attachment_popup?
		return page.has_css? $sb_attachment_popup_grid_author_column
	end
	def SB.get_attachent_popup_file_name_column_value row_number 
		filename_column = $sb_attachment_grid_file_name.sub($sf_param_substitute, (row_number).to_s)
		return find(filename_column).text
	end
end
