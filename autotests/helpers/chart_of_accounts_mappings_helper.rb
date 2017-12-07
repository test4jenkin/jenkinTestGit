#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
module COAM
  extend Capybara::DSL
  
###################################################
# Parameter Substitution Symbol
###################################################
$coam_param_substitute='?'

###############################################################
# Chart of Account Mappings read and write element locations.
###############################################################  
# GLA Details section  
  $coam_gla_details_corporate_gla_name = "table[Id*='GLADetails'] tr:nth-of-type(3) td:nth-of-type(1) div div div div"
  $coam_gla_details_corporate_gla_reporting_code = "table[Id*='GLADetails'] tr:nth-of-type(3) td:nth-of-type(2) div div div div"
  $coam_gla_details_corporate_gla_type = "table[Id*='GLADetails'] tr:nth-of-type(3) td:nth-of-type(3) div div div div"
  $coam_gla_details_local_gla_name = "table[Id*='GLADetails'] tr:nth-of-type(6) td:nth-of-type(1) div div div div"
  $coam_gla_details_local_gla_reporting_code = "table[Id*='GLADetails'] tr:nth-of-type(6) td:nth-of-type(2) div div div div"
  $coam_gla_details_local_gla_type = "table[Id*='GLADetails'] tr:nth-of-type(6) td:nth-of-type(3) div div div div"
  $coam_chart_of_accounts_mappings_page_title = "span[class='ffdc-logo-text']"
# Map Corporate Glas grid
  $coam_map_corporate_glas_name_column = "Name"
  $coam_map_corporate_glas_name_column_number = "2"  
  $coam_map_corporate_glas_type_column = "Type"
  $coam_map_corporate_glas_type_column_number = "3"
  $coam_map_corporate_glas_reporting_balance_column = "Reporting Balance"
  $coam_map_corporate_glas_reporting_balance_column_number = "4"
  
  $coam_map_corporate_glas_label = "//label[text()='Map Corporate GLAs']"
  $coam_map_corporate_glas_search_box = "div[data-ffid='corporateGLAs'] input[placeholder = 'Search']"
  $coam_map_corporate_glas_table_radio_button = "//div[@data-ffid='corporateGLAs']// div[text()='"+$coam_param_substitute+"']/ancestor::td/preceding-sibling::td[1]/div/div"
  $coam_map_corporate_glas_table_name_column_by_gla_name = "//div[@data-ffid='corporateGLAs']// div[text()='"+$coam_param_substitute+"']"

# To Local Glas grids  
  $coam_to_local_glas_name_column = "Name"
  $coam_to_local_glas_name_column_number = "2"
  $coam_to_local_glas_chart_of_accounts_structure_column = "Chart of Accounts Structure"
  $coam_to_local_glas_chart_of_accounts_structure_column_number = "3"
  $coam_to_local_glas_type_column = "Type"
  $coam_to_local_glas_type_column_number = "4"
  $coam_to_local_glas_reporting_code_column = "Reporting Code"
  $coam_to_local_glas_reporting_code_column_number = "5"
  
  $coam_to_local_glas_label = "//label[text()='To Local GLAs']"
  $coam_to_local_glas_search_box = "div[data-ffid='localGLAs'] input[placeholder = 'Search']"
  $coam_to_local_glas_table_radio_button = "//div[@data-ffid='localGLAs']// div[text()='"+$coam_param_substitute+"']/ancestor::td/preceding-sibling::td[1]/div/div"
  $coam_to_local_glas_table_name_column_by_gla_name = "//div[@data-ffid='localGLAs']// div[text()='"+$coam_param_substitute+"']"
  $coam_to_local_glas_table_chart_of_accounts_structure_column_by_gla_name = "//div[@data-ffid='localGLAs']// div[text()='"+$coam_param_substitute+"']/ancestor::td/following-sibling::td[1]/div"

# Mappings grid
  $coam_mappings_grid_corporate_gla_column = "Corporate GLA"
  $coam_mappings_grid_corporate_gla_column_number = "4"
  $coam_mappings_grid_local_gla_column = "Local GLA"
  $coam_mappings_grid_local_gla_column_number = "7"
  $coam_mappings_grid_chart_of_accounts_structure_column = "Chart of Accounts Structure"
  $coam_mappings_grid_chart_of_accounts_structure_column_number = "5"
  $coam_mappings_grid_created_on_column = "Created On"
  $coam_mappings_grid_created_on_column_number = "9"
  $coam_mappings_grid_dimension_column = "Dimension"
  $coam_mappings_grid_dimension_column_number = "8"
  $coam_mappings_search_box = "div[data-ffid='mappings'] input[placeholder = 'Search']"
  $coam_mappings_table_delete_button_locate_by_gla_name = "//div[@data-ffid='mappings']// div[text()='"+$coam_param_substitute+"']/ancestor::td/preceding-sibling::td/div/div"
  $coam_mappings_table_corporate_gla_locate_by_local_gla_name = "//div[@data-ffid='mappings']//td[7]/div[text()='"+$coam_param_substitute+"']/ancestor::td/preceding-sibling::td[3]/div"
  $coam_mappings_table_corporate_gla_column_by_corporate_gla_name = "//div[@data-ffid='mappings']// td[4]/div[text()='"+$coam_param_substitute+"']"
  $coam_mappings_table_local_gla_column_by_local_gla_name = "//div[@data-ffid='mappings']// td[3]/div[text()='"+$coam_param_substitute+"']"
  $coam_corporate_gla_conflict_button_row_wise = "div[data-ffid='mappings'] div table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(3) div[class*='ffdc-icon-warning']"
  $coam_local_gla_conflict_button_row_wise = "div[data-ffid='mappings'] div table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(6) div[class*='f-action-col-icon']"
  $coam_edit_mapping_button_row_wise = "div[data-ffid='mappings'] div table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(2) div[class*='ffdc-icon-edit']"
  $coam_delete_mapping_button_row_wise = "div[data-ffid='mappings'] div table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(1) div[class*='ffdc-icon-delete']"
  $coam_mappings_table_dirty_column_row_wise = "div[data-ffid='mappings'] div table:nth-of-type("+$coam_param_substitute+") td[class*='f-grid-dirty-cell']:nth-of-type("+$coam_param_substitute+")"
# Chart of Account Mappings buttons
  $coam_chart_of_account_mappings_save_button = "//span[text()='Save']"
  $coam_chart_of_account_mappings_export_mappings_button = "//span[text()='Export Mappings']"
  $coam_chart_of_account_mappings_back_button = "//span[text()='Back']"
  $coam_export_mappings_adobe_pdf_button = "div[data-ffxtype='menu'] div div div div:nth-of-type(1) a span"
  $coam_export_mappings_microsoft_excel_button = "div[data-ffxtype='menu'] div div div div:nth-of-type(2) a span"
  $coam_export_mappings_csv_file_button = "div[data-ffxtype='menu'] div div div div:nth-of-type(3) a span"
  $coam_save_message_pop_up_close_button = "div[data-ffxtype='toast'] div[class*= 'f-tool-close']"
# Chart of Account Mappings labels
  $coam_mappings_grid_no_record_found_message = "div[class='f-grid-empty']"
  $coam_gla_details_section_no_mapping_selected = "//div[text()='No Mapping Selected']"
  $coam_saved_successfully_message = "//div[text()='Chart of accounts mappings saved successfully.']"
# grids
  $coam_corporate_glas_grid = "corporateGLAs"
  $coam_local_glas_grid = "localGLAs"
  $coam_mappings_grid = "mappings"
  $coam_history_grid = "mappingHistory"
  $coam_chart_of_accounts_mappigs_grid_column = "div[data-ffid='"+$coam_param_substitute+"'] table:nth-of-type("+$coam_param_substitute+") td:nth-of-type("+$coam_param_substitute+") div"
# Filter section
  $coam_when_dimension_label = "//div[text()='When Dimension']"
  $coam_filter_slider_button = "div[data-ffid='dimensions'] img"
  $coam_filter_dimension_type_value = "div[data-ffid='dimensionType'] input"
  $coam_filter_dimension_value = "div[data-ffid='dimensionValues'] input"
# Conflicts section
  $coam_corp_conflicts_tab = "//span[text()='Corporate Conflicts']"
  $coam_corp_conflicts_local_gla_value_row_wise = "div[data-ffid='corporateConflicts'] table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(1) div"
  $coam_corp_conflicts_dimension_value_row_wise = "div[data-ffid='corporateConflicts'] table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(2) div"
  $coam_local_conflicts_tab = "//span[text()='Local Conflicts']"
  $coam_local_conflicts_corp_gla_value_row_wise = "div[data-ffid='localConflicts'] table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(1) div"
  $coam_local_conflicts_dimension_value_row_wise = "div[data-ffid='localConflicts'] table:nth-of-type("+$coam_param_substitute+") td:nth-of-type(2) div"
# Delete mapping Popup
  $coam_delete_mapping_popup = "div[data-ffxtype='delete-mapping']"
  $coam_delete_mapping_popup_alert_icon = $coam_delete_mapping_popup + " img[class*='COAM-icon-alert']"
  $coam_delete_mapping_popup_alert_msg = $coam_delete_mapping_popup + " td[class*='COAM-msg-td'] div[class*='f-autocontainer-innerCt']"
  $coam_delete_mapping_popup_reason_text_area = $coam_delete_mapping_popup + " textarea"
  $coam_delete_mapping_popup_cancel_button = $coam_delete_mapping_popup + " a:nth-of-type(1) span:nth-child(2)"
  $coam_delete_mapping_popup_delete_button = $coam_delete_mapping_popup + " a:nth-of-type(2) span:nth-child(2)"
  $coam_delete_mapping_popup_close_button =  $coam_delete_mapping_popup + " img[class*='f-tool-close']"
# Edit mapping popup
  $coam_edit_mapping_popup = "div[data-ffxtype='edit-mapping']"
  $coam_edit_mapping_popup_corp_gla = $coam_edit_mapping_popup + " div[data-ffid='corporateGLA'] input"
  $coam_edit_mapping_popup_local_gla = $coam_edit_mapping_popup + " div[data-ffid='localGLA'] input"
  $coam_edit_mapping_popup_dimension = $coam_edit_mapping_popup + " div[data-ffid='dimensions'] div[data-ffid='dimensionType'] input"
  $coam_edit_mapping_popup_dimension_value = $coam_edit_mapping_popup + " div[data-ffid='dimensions'] div[data-ffid='dimensionValues'] input[type='text']"
  $coam_edit_mapping_popup_reason_text_area = $coam_edit_mapping_popup + " div[data-ffid='reason'] textarea"
  $coam_edit_mapping_popup_cancel_button = $coam_edit_mapping_popup + " a:nth-of-type(1) span:nth-child(2)"
  $coam_edit_mapping_popup_save_button = $coam_edit_mapping_popup + " a:nth-of-type(2) span:nth-child(2)"
  $coam_edit_mapping_popup_close_button =  $coam_edit_mapping_popup + " img[class*='f-tool-close']"
# History section
  $coam_history_tab = "div[data-ffid = 'glaDetails'] a:nth-of-type(2) span:nth-child(2)"
  $coam_history_tab_date_column = "Date"
  $coam_history_tab_date_column_number = "1"
  $coam_history_tab_action_column = "Action"
  $coam_history_tab_action_column_number = "2"
  $coam_history_tab_field_column = "Field"
  $coam_history_tab_field_column_number = "3"
  $coam_history_tab_old_value_column = "Old Value"
  $coam_history_tab_old_value_column_number = "4"
  $coam_history_tab_new_value_column = "New Value"
  $coam_history_tab_new_value_column_number = "5"
  $coam_history_tab_reason_column = "Reason"
  $coam_history_tab_reason_column_number = "6"
  $coam_history_tab_grid_column = "div[data-ffid = 'mappingHistory'] div:nth-of-type(2) table:nth-of-type("+$coam_param_substitute+") td:nth-of-type("+$coam_param_substitute+") div[class*='f-grid-cell-inner']"
  $coam_histroy_tab_action_section_row_wise = "div[data-ffid = 'mappingHistory'] div:nth-of-type(2) table:nth-of-type("+$coam_param_substitute+") div[data-qtip]"
# Delete mapping confirmation toast
  $coam_delete_mapping_toast = "div[data-ffid='undoToast']"
  $coam_delete_mapping_confirmation_toast_msg = $coam_delete_mapping_toast+" label"
  $coam_delete_mapping_confirmation_toast_undo_button = $coam_delete_mapping_toast+" div:nth-of-type(3) span:nth-child(2)"
####################################################
# Helper methods for chart of account mappings page
###################################################
# get delete mapping confirmation toast message
	def COAM.get_delete_mapping_confirmation_toast_msg
		find($coam_delete_mapping_confirmation_toast_msg).text
	end
# click undo button in delete mapping confirmation toast
	def COAM.click_delete_mapping_confirmation_toast_undo_button
		find($coam_delete_mapping_confirmation_toast_undo_button).click
	end
# check if delete mapping toast exist
	def COAM.does_delete_mapping_toast_exist?
		return page.has_css?($coam_delete_mapping_toast)
	end	
# check if delete mapping popup exist
	def COAM.does_delete_mapping_popup_exist?
		return page.has_css?($coam_delete_mapping_popup)
	end
# check if edit mapping popup exist
	def COAM.does_edit_mapping_popup_exist?
		return page.has_css?($coam_edit_mapping_popup)
	end	
# check if reason field exist in edit mapping popup
	def COAM.does_reason_exist_edit_mapping_popup?
		return page.has_css?($coam_edit_mapping_popup_reason_text_area)
	end 	
# check if a column is dirty in mappings grid
	def COAM.is_column_dirty_in_mappings_grid row_number, column_number
		_row = $coam_mappings_table_dirty_column_row_wise.sub($coam_param_substitute, row_number)
		_column = _row.sub($coam_param_substitute, column_number)
		return page.has_css?(_column)
	end
# check if all columns in mapping grid for a row, are dirty
	def COAM.all_dirty? row_number
		_dirty_corp_gla = COAM.is_column_dirty_in_mappings_grid row_number, $coam_mappings_grid_corporate_gla_column_number
		_dirty_local_gla = COAM.is_column_dirty_in_mappings_grid row_number, $coam_mappings_grid_local_gla_column_number
		_dirty_coa = COAM.is_column_dirty_in_mappings_grid row_number, $coam_mappings_grid_chart_of_accounts_structure_column_number
		_dirty_dimension = COAM.is_column_dirty_in_mappings_grid row_number, $coam_mappings_grid_dimension_column_number
		_dirty_create_on = COAM.is_column_dirty_in_mappings_grid row_number, $coam_mappings_grid_created_on_column_number
		if (_dirty_corp_gla) and (_dirty_local_gla) and (_dirty_coa) and (_dirty_dimension) and (_dirty_create_on)
			return true
		else 
			return false
		end	
	end	
# Select a row in mappings table
	def COAM.select_row_mappings_grid row_number
		_column = $coam_chart_of_accounts_mappigs_grid_column.sub($coam_param_substitute, $coam_mappings_grid)
		_row = _column.sub($coam_param_substitute, row_number)
		_row = _row.sub($coam_param_substitute,$coam_mappings_grid_corporate_gla_column_number)
		SF.retry_script_block do
			find(_row).click
		end
	end
# click on history tab
	def COAM.click_on_history_tab
		find($coam_history_tab).click
		SF.wait_less
	end	
# select Dimension type in edit mapping popup
	def COAM.select_dimension_type_edit_mapping_popup option
		find($coam_edit_mapping_popup_dimension).set(option)
		gen_tab_out $coam_edit_mapping_popup_dimension
	end
# select Dimension value in edit mapping popup
	def COAM.select_dimension_value_edit_mapping_popup value
		find($coam_edit_mapping_popup_dimension_value).set(value)
		gen_tab_out $coam_edit_mapping_popup_dimension_value
	end	
# get corp gla value in edit mapping popup
	def COAM.get_corp_gla_value_edit_mapping_popup
		find($coam_edit_mapping_popup_corp_gla).text
	end
# get local gla value in edit mapping popup
	def COAM.get_local_gla_value_edit_mapping_popup
		find($coam_edit_mapping_popup_local_gla).text
	end	
# Close edit mapping popup by clicking on close button X
	def COAM.close_edit_mapping_popup
		find($coam_edit_mapping_popup_close_button).click
	end
# Give reason in edit mapping popup
	def COAM.enter_reason_edit_mapping_popup reason
		find($coam_edit_mapping_popup_reason_text_area).set reason
		gen_tab_out $coam_edit_mapping_popup_reason_text_area
	end
# click cancel button in edit mapping popup
	def COAM.click_cacel_button_edit_mapping_popup
		find($coam_edit_mapping_popup_cancel_button).click
	end
# click Save button in edit mapping popup
	def COAM.click_save_button_edit_mapping_popup
		find($coam_edit_mapping_popup_save_button).click
	end
# Close delete mapping popup by clicking on close button X
	def COAM.close_delete_mapping_popup
		find($coam_delete_mapping_popup_close_button).click
	end
# Give reason in Delete mapping popup
	def COAM.enter_reason_delete_mapping_popup reason
		find($coam_delete_mapping_popup_reason_text_area).set reason
	end
# click cancel button in delete mapping popup
	def COAM.click_cacel_button_delete_mapping_popup
		find($coam_delete_mapping_popup_cancel_button).click
	end
# click delete button in delete mapping popup
	def COAM.click_delete_button_delete_mapping_popup
		page.has_css?($coam_delete_mapping_popup_delete_button)
		find($coam_delete_mapping_popup_delete_button).click
	end
# check that if Corporate Conflict tab is disabled, if disabled the method returns true
	def COAM.does_corp_conflict_tab_disabled?
		return page.has_xpath?("//span[text()='Corporate Conflicts'] / ancestor::a[contains(@class,'f-tab-disabled')]")
	end
# check that if Local Conflict tab is disabled, if disabled the method returns true
	def COAM.does_local_conflict_tab_disabled?
		return page.has_xpath?("//span[text()='Local Conflicts'] / ancestor::a[contains(@class,'f-tab-disabled')]")
	end	
# check that conflict button for corp gla exists for a given row
	def COAM.does_corp_gla_conflict_button_exist? row_number
		conflict_button = $coam_corporate_gla_conflict_button_row_wise.sub($coam_param_substitute, row_number)
		return page.assert_selector(conflict_button)
	end
# check that conflict button for local gla exists for a given row
	def COAM.does_local_gla_conflict_button_exist? row_number
		conflict_button = $coam_local_gla_conflict_button_row_wise.sub($coam_param_substitute, row_number)
		return page.assert_selector(conflict_button)
	end	
# get local gla value in corporate conflicts tab
	def COAM.get_local_gla_value_in_coporate_conflicts_tab row_number
		local_gla = $coam_corp_conflicts_local_gla_value_row_wise.sub($coam_param_substitute, row_number)
		return find(local_gla).text
	end
# get dimension value in corporate conflicts tab
	def COAM.get_dimension_value_in_coporate_conflicts_tab row_number
		dim_value = $coam_corp_conflicts_dimension_value_row_wise.sub($coam_param_substitute, row_number)
		return find(dim_value).text
	end
# get corp gla value in local conflicts tab
	def COAM.get_corp_gla_value_in_local_conflicts_tab row_number
		corp_gla = $coam_local_conflicts_corp_gla_value_row_wise.sub($coam_param_substitute, row_number)
		return find(corp_gla).text
	end
# get dimension value in local conflicts tab
	def COAM.get_dimension_value_in_local_conflicts_tab row_number
		dim_value = $coam_local_conflicts_dimension_value_row_wise.sub($coam_param_substitute, row_number)
		return find(dim_value).text
	end	
# click corporate gla conflict button
	def COAM.click_corp_gla_conflict_button row_number
		conflict_button = $coam_corporate_gla_conflict_button_row_wise.sub($coam_param_substitute, row_number)
		find(conflict_button).click
	end
# click local gla conflict button
	def COAM.click_local_gla_conflict_button row_number
		conflict_button = $coam_local_gla_conflict_button_row_wise.sub($coam_param_substitute, row_number)
		find(conflict_button).click
	end
# click edit mapping button
	def COAM.click_edit_mapping_button row_number
		edit_button = $coam_edit_mapping_button_row_wise.sub($coam_param_substitute, row_number)
		find(edit_button).click
	end
# click delete mapping button
	def COAM.click_delete_mapping_button row_number
		delete_button = $coam_delete_mapping_button_row_wise.sub($coam_param_substitute, row_number)
		find(delete_button).click
	end	
# select Dimension type in dimension filter
	def COAM.select_dimension_type option
		find($coam_filter_dimension_type_value).set(option)
		gen_tab_out $coam_filter_dimension_type_value
	end
# select Dimension value in dimension filter
	def COAM.select_dimension_value value
		find($coam_filter_dimension_value).set(value)
		gen_tab_out $coam_filter_dimension_value
	end
# assert local gla exist in To Local GLA grid
	def COAM.is_local_gla_exist_in_local_gla_grid? local_gla_name
		gen_wait_until_object $coam_map_corporate_glas_label
		local_gla_column = $coam_to_local_glas_table_name_column_by_gla_name.sub($coam_param_substitute, local_gla_name)
		return page.has_xpath?(local_gla_column)
	end
# mappings table no record found
	def COAM.get_no_mapping_found?
		gen_wait_until_object $coam_map_corporate_glas_label
		return page.has_css?($coam_mappings_grid_no_record_found_message)
	end
# gla detail no mapping selected
	def COAM.get_no_mapping_selected?
		gen_wait_until_object $coam_map_corporate_glas_label
		return page.has_xpath?($coam_gla_details_section_no_mapping_selected)
	end
# get grid column value
# Param : grid_type (Type : String)  (Description : Value of the grid from which you want to get the column value)
# Param : row_number (Type : String) (Description : which row you want to fatch data from)
# Param : column_name (Type : String) (Description : Column Name) 
	def COAM.get_grid_column_value (grid_type, row_number, column_name)
		gen_wait_until_object $coam_map_corporate_glas_label
		_column_value = $coam_chart_of_accounts_mappigs_grid_column
		if(grid_type == $coam_corporate_glas_grid)
			_column_value = _column_value.sub($coam_param_substitute, $coam_corporate_glas_grid)
			_column_value = _column_value.sub($coam_param_substitute, row_number)
			if(column_name == $coam_map_corporate_glas_name_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_map_corporate_glas_name_column_number)
			elsif(column_name == $coam_map_corporate_glas_type_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_map_corporate_glas_type_column_number)
			elsif(column_name == $coam_map_corporate_glas_reporting_balance_column )
				_column_value = _column_value.sub($coam_param_substitute, $coam_map_corporate_glas_reporting_balance_column_number)
			else
				raise "No Column found"
			end
		elsif(grid_type == $coam_local_glas_grid)
			_column_value = _column_value.sub($coam_param_substitute, $coam_local_glas_grid)
			_column_value = _column_value.sub($coam_param_substitute, row_number)
			if(column_name == $coam_to_local_glas_name_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_to_local_glas_name_column_number)
			elsif(column_name == $coam_to_local_glas_chart_of_accounts_structure_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_to_local_glas_chart_of_accounts_structure_column_number)
			elsif(column_name == $coam_to_local_glas_type_column )
				_column_value = _column_value.sub($coam_param_substitute, $coam_to_local_glas_type_column_number)
			elsif(column_name == $coam_to_local_glas_reporting_code_column )
				_column_value = _column_value.sub($coam_param_substitute, $coam_to_local_glas_reporting_code_column_number)	
			else
				raise "No Column found"
			end
		elsif(grid_type == $coam_mappings_grid)
			_column_value = _column_value.sub($coam_param_substitute, $coam_mappings_grid)
			_column_value = _column_value.sub($coam_param_substitute, row_number)
			if(column_name == $coam_mappings_grid_corporate_gla_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_mappings_grid_corporate_gla_column_number)
			elsif(column_name == $coam_mappings_grid_local_gla_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_mappings_grid_local_gla_column_number)
			elsif(column_name == $coam_mappings_grid_chart_of_accounts_structure_column )
				_column_value = _column_value.sub($coam_param_substitute, $coam_mappings_grid_chart_of_accounts_structure_column_number)
			elsif(column_name == $coam_mappings_grid_created_on_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_mappings_grid_created_on_column_number)
			elsif(column_name == $coam_mappings_grid_dimension_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_mappings_grid_dimension_column_number)
			else
				raise $coam_mappings_grid_no_record_found_message
			end
		elsif(grid_type == $coam_history_grid)
			_column_value = $coam_history_tab_grid_column
			_column_value = _column_value.sub($coam_param_substitute, row_number)
			if(column_name == $coam_history_tab_field_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_history_tab_field_column_number)
			elsif(column_name == $coam_history_tab_old_value_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_history_tab_old_value_column_number)
			elsif(column_name == $coam_history_tab_new_value_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_history_tab_new_value_column_number)
			elsif(column_name == $coam_history_tab_reason_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_history_tab_reason_column_number)
			elsif(column_name == $coam_history_tab_action_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_history_tab_action_column_number)
			elsif(column_name == $coam_history_tab_date_column)
				_column_value = _column_value.sub($coam_param_substitute, $coam_history_tab_date_column_number)	
			else
				raise "No Column found"
			end
		end
		return find(_column_value).text
	end
# delete mapping for a gla
	def COAM.delete_mapping_by_gla_name gla_name
		gen_wait_until_object $coam_map_corporate_glas_label
		delete_button = $coam_mappings_table_delete_button_locate_by_gla_name.sub($coam_param_substitute, gla_name)
		find(:xpath, delete_button).click
	end
##
#
# Method Summary: Find the radio button for corporate gla with given name and select.
#
# @param [String] gla_name     Text corporate gla to pass.
#
	def COAM.select_corporate_gla gla_name
		gen_wait_until_object $coam_map_corporate_glas_label
		radio_button = $coam_map_corporate_glas_table_radio_button.gsub($coam_param_substitute, gla_name)
		find(:xpath, radio_button).click
	end
  
##
#
# Method Summary: Find the radio button for local gla with given name and select.
#
# @param [String] local_gla_name     Text local gla to pass.
#
	def COAM.select_local_gla local_gla_name
		gen_wait_until_object $coam_to_local_glas_label
		radio_button = $coam_to_local_glas_table_radio_button.gsub($coam_param_substitute, local_gla_name)
		find(:xpath, radio_button).click
	end
  
##
#
# Method Summary: Find the Save button and save created mappings by clicking on the button.
#
#
	def COAM.click_on_save_button
		gen_wait_until_object $coam_chart_of_account_mappings_save_button
		find(:xpath, $coam_chart_of_account_mappings_save_button).click
		FFA.wait_for_popup_msg_sync $coam_ffa_msg_loading_metadata
		gen_wait_until_object $coam_saved_successfully_message
		find($coam_save_message_pop_up_close_button).click
		gen_wait_until_object $coam_mappings_search_box
	end


##
#
# Method Summary: Assert Mapping exist for given GLAs
# @param [string] corporate_gla_name Name of the corporate GLA for which mapping needs to be checked.
# @param [string] local_gla_name Name of the local GLA for which mapping needs to be checked.
#
#
	def COAM.get_mapped_corporate_gla_by_local_gla local_gla_name
		gen_wait_until_object $coam_mappings_search_box
		return find(:xpath, $coam_mappings_table_corporate_gla_locate_by_local_gla_name.gsub($coam_param_substitute, local_gla_name)).text
	end

##
#
# Method Summary: get GLA Details -- Corporate GLA Name
# @param [string] corporate_gla_name Name of the corporate GLA for which gla details needs to be checked.
#
#  
	def COAM.get_gla_details_corporate_gla_name corporate_gla_name
		gen_wait_until_object $coam_mappings_search_box
		find(:xpath, $coam_mappings_table_corporate_gla_column_by_corporate_gla_name.gsub($coam_param_substitute, corporate_gla_name)).click
		return find($coam_gla_details_corporate_gla_name).text
	end
  
##
#
# Method Summary: get GLA Details -- local GLA Name
# @param [string] local_gla_name Name of the local GLA for which gla details needs to be checked.
#
#  
	def COAM.get_gla_details_local_gla_name local_gla_name
		gen_wait_until_object $coam_mappings_search_box
		find(:xpath, $coam_mappings_table_local_gla_column_by_local_gla_name.gsub($coam_param_substitute, local_gla_name)).click
		return find($coam_gla_details_local_gla_name).text
	end  
 
##
#
# Method Summary: Click on Back Button if not disabled
#
#

	def COAM.click_on_back_button
		if (!page.has_css?("a[class*='f-btn-disabled'][data-ffid='backButton']"))
			find(:xpath, $coam_chart_of_account_mappings_back_button).click
			else
				raise "Export Mapping button is disabled"
		end
	end  
  
# Method Summary: Click on Export Mappings Button.
	def COAM.click_on_export_mappings_button
		if (!page.has_css?("a[class*='f-btn-disabled'][data-ffid='exportButton']"))
			find(:xpath, $coam_chart_of_account_mappings_export_mappings_button).click
			else
				raise "Export Mapping button is disabled"
		end	
	end  
  
# click CSV File (.csv) option on Export Mappings button
	def COAM.click_csv_file_export_mappings_button
		find($coam_export_mappings_csv_file_button).click
		SF.wait_less
		gen_wait_for_download_to_complete
	end	
# click Microsoft Excel (.xls) option on Export Mappings button
	def COAM.click_microsoft_excel_export_mappings_button
		find($coam_export_mappings_microsoft_excel_button).click
		SF.wait_less
		gen_wait_for_download_to_complete
	end
# click Adobe PDF (.pdf) option on Export Mappings button
	def COAM.click_adobe_pdf_export_mappings_button
		find($coam_export_mappings_adobe_pdf_button).click	
	end
end	