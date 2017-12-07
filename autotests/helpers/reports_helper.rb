 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module REPORTS  
extend Capybara::DSL

$reports_new_report = "New Report..."
$reports_create = "Create"
$reports_remove_all_columns = "Remove All Columns"
$reports_quick_find_input = "input[name='quickFindInput']"
$reports_report_type_item = "//span[text() = '"+$sf_param_substitute+"']"
$reports_report_type_show_more = "//span[contains(text(),'Show more')]"
$reports_report_show_option = "input[name='scope']"
$reports_column_to_drag_pattern =  "//span[text()='"+$sf_param_substitute+": Info']/ancestor::li[1]//span[text()='"+$sf_param_substitute+"']"
$reports_target_column_panel = "div[id='gridViewScrollpreviewPanelGrid']"
$reports_target_column_verification_pattern = "//div[@id='gridViewHeaderpreviewPanelGrid']//table[2]//tr"
$reports_summarize_sum_checkbox = "input[id='sum0']"
$reports_add_filter_button = "//button[text()='Add']"
$reports_save_and_run_button= "//button[text()='Save and Run Report']"
$reports_filter_column_select = "form[class*='x-panel-body filterBody edit'] :nth-of-type(2) input[class*='x-form-text x-form-field pc']"
$reports_filter_condition_select = "form[class*='x-panel-body filterBody edit']  :nth-of-type(3) input[type='text']"
$reports_filter_condition_value = "form[class*='x-panel-body filterBody edit'] :nth-of-type(4) input"
$reports_name_input = "input[id='saveReportDlg_reportNameField']"
$reports_no_thanks_button_demo_popup = "//button[text()='No Thanks']"
$reports_report_type_transaction_line_items = "Transactions with Transaction Line Items"
$reports_show_option_all_transaction = "All transactions"
$reports_show_options_div = "//div[text()='"+$sf_param_substitute+"']"
$reports_column_header_pattern = "//div[contains(text(),'"+$sf_param_substitute+"')]"
$reports_column_header_arrow_image_pattern = $reports_column_header_pattern + "//a"
$reports_column_header_image_icon = $reports_column_header_pattern  + "/img"
$reports_column_header_options_pattern = "//span[contains(text(),'"+ $sf_param_substitute +"')]"
$reports_column_option_summarize_this_field = "Summarize this Field"
$reports_column_option_group_by_this_field = "Group by this Field"
$reports_filter_button_ok = "OK"
$reports_filter_button_save_and_run_report = "Save and Run Report"
$reports_company_checkbox_pattern = "//span[text()='"+ $sf_param_substitute +"']/../input[@type='checkbox']"
$report_generation_status_complete_label = "//h2[text()='Report Generation Status:']/../div[text()='Complete']"
$report_profitability_report_total_in_classic_view = "//strong[contains(text(), 'Grand Totals')]/ancestor::tr/following-sibling::tr/td[3]"
$report_report_table = "table[class='reportTable tabularReportTable']"
$report_filter_dropdown_value_pattern = "//div[text()='"+ $sf_param_substitute +"' and contains(@class,'selected')]"
#methods
	#click new report button
	def REPORTS.click_new_report_button
		SF.retry_script_block do 
			# Remove the popup which is to give information+walk through on reports tab.
			if(page.has_xpath?($reports_no_thanks_button_demo_popup,:wait => DEFAULT_LESS_WAIT))
				find(:xpath , $reports_no_thanks_button_demo_popup).click
			end
			SF.click_button $reports_new_report
		end
	end
	
	# Click on Create button to create the report
	def REPORTS.click_create_report_button
		SF.click_button $reports_create
		SF.wait_for_search_button
		# Remove the popup which is to give information+walk through on reports tab.
		if(page.has_xpath?($reports_no_thanks_button_demo_popup,:wait => DEFAULT_LESS_WAIT))
			find(:xpath , $reports_no_thanks_button_demo_popup).click
		end
	end
	
	#select report type
	def REPORTS.select_report_type report_type
		SF.retry_script_block do 
			gen_wait_until_object $reports_quick_find_input
			find($reports_quick_find_input).set report_type
			find(:xpath,$reports_report_type_show_more).click
			item_to_select = $reports_report_type_item.sub($sf_param_substitute,report_type)
			gen_wait_until_object item_to_select
			find(:xpath,item_to_select).click
		end
	end

	#select show option
	def REPORTS.select_show_option show_option
		SF.retry_script_block do 
			find($reports_report_show_option).click
			find(:xpath,$reports_show_options_div.sub($sf_param_substitute,show_option)).click
		end
	end

	#Add multiple columns to report
	def REPORTS.add_column_to_report object_name , column_list
		SF.retry_script_block do 
			column_list.each do |column|
				find($reports_quick_find_input).set column
				source = find(:xpath, $reports_column_to_drag_pattern.sub($sf_param_substitute, object_name).gsub($sf_param_substitute, column))
				target = find($reports_target_column_panel)
				source.drag_to(target)
				SF.wait_less				
			end	
		end
	end

	#click on column image Icon and select column option
	def REPORTS.select_column_options column, option_name
		SF.retry_script_block do 
		 	#click down arrow of column
			page.has_xpath?($reports_column_header_pattern.gsub($sf_param_substitute, column))
			find(:xpath,$reports_column_header_pattern.gsub($sf_param_substitute, column)).hover
			gen_wait_until_object $reports_column_header_arrow_image_pattern.gsub($sf_param_substitute, column)
			find(:xpath, $reports_column_header_arrow_image_pattern.gsub($sf_param_substitute, column)).click	
			gen_wait_until_object $reports_column_header_options_pattern.gsub($sf_param_substitute, option_name)
			find(:xpath, $reports_column_header_options_pattern.gsub($sf_param_substitute, option_name)).click		
		end	
	end

	#check summarize column sum checkbox
	def REPORTS.check_summarize_column_sum_checkbox 
		SF.retry_script_block do 
			find($reports_summarize_sum_checkbox).set true		
		end	
	end

	#Add filter on column
	def REPORTS.add_filter
		SF.retry_script_block do 
			find(:xpath,$reports_add_filter_button).click
			if (page.has_no_css?($reports_filter_column_select))
				raise "Row to add filter not displayed, Re-click on Add button..."
			end
		end	
	end

	#Set/select filter column value
	def REPORTS.select_filter_column column_to_select
		SF.retry_script_block do 
			page.has_css?($reports_filter_column_select)
			find($reports_filter_column_select).set ""
			find($reports_filter_column_select).set column_to_select
			filter_dropdown_value = $report_filter_dropdown_value_pattern.sub($sf_param_substitute ,column_to_select )
			puts page.has_xpath?(filter_dropdown_value)
			if(page.has_xpath?(filter_dropdown_value))
				find(:xpath, filter_dropdown_value).click
			end
			gen_tab_out $reports_filter_column_select
		end
	end

	#Set/select filter condition option
	def REPORTS.select_filter_condition_in_dropdown condition
		SF.retry_script_block do 
			find($reports_filter_condition_select).set condition
		end
	end

	#Set filter condition value
	def REPORTS.set_filter_condition_value column_value
		SF.retry_script_block do 
			find($reports_filter_condition_value).set column_value
		end
	end

	#set report Name
	def REPORTS.set_report_name name
		SF.retry_script_block do
			gen_wait_until_object $reports_name_input
			find($reports_name_input).set name
			gen_tab_out $reports_name_input
		end
	end	

	def REPORTS.get_report_id_from_url
		report_id = nil 
		SF.retry_script_block do
			current_page_url = page.current_url
			str_split = current_page_url.split('/')
			report_id = str_split[3]		
		end
		return report_id
	end

	#get company selected or not in current company
	def REPORTS.is_company_selected company_name
		SF.retry_script_block do
			return find(:xpath,$reports_company_checkbox_pattern.gsub($sf_param_substitute, company_name)).value
		end
	end
	
	#get profitability Report total
	def REPORTS.get_profitability_report_total
		SF.retry_script_block do
			return find(:xpath,$report_profitability_report_total_in_classic_view).text
		end
	end
	
	#get report contenet
	def REPORTS.get_report_content
		report_content = nil
		SF.retry_script_block do
			report_content =  find($report_report_table).text			
		end
		SF.log_info report_content
		return report_content
	end
end
