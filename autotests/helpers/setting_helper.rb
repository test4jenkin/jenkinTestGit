 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SETTING
extend Capybara::DSL

#############################
# standard Setting Page
#############################
#selectors
$setting_name = "input[id='Name']"
$setting_level_list = "//label[text()='Settings Level']//ancestor::td[1]/following-sibling::td[1]/span/select"
$setting_object_textbox = "//label[text()='Object']//ancestor::td[1]/following-sibling::td[1]/div/input"
$setting_actual_transaction_line_relationship_textbox = "//label[text()='Revenue Recognition Txn Line Lookup']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_account_textbox = "//label[text()='Account']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_description_textbox ="//label[text()='Description']//ancestor::td[1]/following-sibling::td[1]/div/input"
$setting_startdate_textbox = "//label[text()='Start Date']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_enddate_textbox = "//label[text()='End Date/Deliverable Date']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_total_revenue_textbox = "//label[text()='Total Revenue']//ancestor::td[1]/following-sibling::td[1]/div/input"
$setting_active_field_textbox = "//label[text()='Active Field']//ancestor::td[1]/following-sibling::td[1]/div/input"
$setting_active_value_textbox = "//label[text()='Active Value']//ancestor::td[1]/following-sibling::td[1]/div/input"
$setting_include_active_value_option = "//label[text()='Include Active Value']//ancestor::td[1]/following-sibling::td[1]/span/select"
$setting_currency_textbox = "//label[text()='Currency']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_completed_field_textbox = "//label[text()='Completed Field']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_completed_value_textbox = "//label[text()='Completed Value']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_include_completed_value_option = "//label[text()='Include Completed Value']//ancestor::td[1]/following-sibling::td[1]/span/select"
$setting_income_statement_account_textbox = "//label[text()='Income Statement Account']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_balance_sheet_account_textbox = "//label[text()='Balance Sheet Account']//ancestor::td[1]/following-sibling::td[1]/input"
$setting_type_option = "//option[text()='#{$sf_param_substitute}']"
$setting_add_arrow_icon = "img[alt='Add']"
# Labels
$setting_level_primary = "Primary"
$setting_fixed_bs_account_code_label = "Fixed Balance Sheet"
$setting_type_actual = "Actual"
$setting_type_forcast = "Forecast"

# Buttons

 
#############################
# Settings method section
#############################
# set setting Name
	def SETTING.set_name name
		SF.execute_script do
			find($setting_name).set name					
		end
	end
	
	# set setting Level
	def SETTING.set_level level_name
		SF.execute_script do
			field_id = find(:xpath,$setting_level_list)[:id]
			select level_name, :from => field_id				
		end
	end
	
	# set setting object Name
	def SETTING.set_object object_name
		SF.execute_script do
			find(:xpath, $setting_object_textbox).set object_name					
		end
	end
	
	# set actual transaction line relationship 
	def SETTING.set_actual_transaction_line_relationship line_relationship
		SF.execute_script do
			find(:xpath, $setting_actual_transaction_line_relationship_textbox).set line_relationship				
		end
	end
	
	# set account name
	def SETTING.set_account_name name
		SF.execute_script do
			find(:xpath, $setting_account_textbox).set name				
		end
	end
	
	# set description
	def SETTING.set_description description
		SF.execute_script do
			find(:xpath, $setting_description_textbox).set description				
		end
	end
	
	# set start date
	def SETTING.set_startdate startdate
		SF.execute_script do
			find(:xpath, $setting_startdate_textbox).set startdate				
		end
	end
	
	# set end date
	def SETTING.set_enddate enddate
		SF.execute_script do
			find(:xpath, $setting_enddate_textbox).set enddate				
		end
	end
	
	# set total revenue
	def SETTING.set_total_revenue total_revenue
		SF.execute_script do
			find(:xpath, $setting_total_revenue_textbox).set total_revenue				
		end
	end
			
	# set active field
	def SETTING.set_active_field active_field
		SF.execute_script do
			find(:xpath, $setting_active_field_textbox).set active_field				
		end
	end
	
	# set active value
	def SETTING.set_active_value active_value
		SF.execute_script do
			find(:xpath, $setting_active_value_textbox).set active_value				
		end
	end	
	
	# set active value
	def SETTING.select_include_active_value active_value
		SF.execute_script do
			field_id = find(:xpath,$setting_include_active_value_option)[:id]
			select active_value, :from => field_id							
		end
	end
	
	# set currency
	def SETTING.set_currency currency
		SF.execute_script do
			find(:xpath, $setting_currency_textbox).set currency				
		end
	end
	
	# set completed field
	def SETTING.set_completed_field completed_field
		SF.execute_script do
			find(:xpath, $setting_completed_field_textbox).set completed_field				
		end
	end	
	
	# set completed value
	def SETTING.set_completed_value completed_value
		SF.execute_script do
			find(:xpath, $setting_completed_value_textbox).set completed_value				
		end
	end	
	
	# set include_completed_value
	def SETTING.set_include_completed_value completed_value
		SF.execute_script do
			field_id = find(:xpath,$setting_include_completed_value_option)[:id]
			select completed_value, :from => field_id								
		end
	end
	
	# set income statement account
	def SETTING.set_income_statement_account income_statement_account
		SF.execute_script do
			find(:xpath, $setting_income_statement_account_textbox).set income_statement_account				
		end
	end	
	
	# set balance sheet account
	def SETTING.set_balance_sheet_account balance_sheet_account
		SF.execute_script do
			find(:xpath, $setting_balance_sheet_account_textbox).set balance_sheet_account				
		end
	end
	
	# check fixed_bs_account_code
	def SETTING.check_fixed_bs_account_code
		SF.execute_script do
			SF.check_checkbox $setting_fixed_bs_account_code_label
		end
	end
	
	# uncheck fixed_bs_account_code
	def SETTING.uncheck_fixed_bs_account_code
		SF.execute_script do
			SF.uncheck_checkbox $setting_fixed_bs_account_code_label
		end
	end	
	
	#select a setting type
	def SETTING.select_setting_type type_name
		SF.execute_script do
			find(:xpath, $setting_type_option.sub($sf_param_substitute,type_name)).click		
			find($setting_add_arrow_icon).click
		end	
	end
end
