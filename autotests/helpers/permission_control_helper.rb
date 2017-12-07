 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module PC
extend Capybara::DSL

#Locators
$pc_resource_lookup = "img[title='Resource Lookup (New Window)']"
$pc_name_value = "div[id*='Name_']"
#Labels
$pc_user_label = "User"
$pc_resource_label = "Resource"
$pc_region_label = "Region"
$pc_resource_request_entry_checkbox = "Resource Request Entry"
$pc_staffing_checkbox = "Staffing"
$pc_skills_certifications_entry_checkbox = "Skills And Certifications Entry"
$pc_skills_certifications_view_checkbox = "Skills And Certifications View"
$pc_billing_checkbox = "Billing"
$pc_forecast_edit_checkbox = "Forecast Edit"
$pc_forecast_view_checkbox = "Forecast View"
$pc_task_manager_view_checkbox = "Task Manager View"
$pc_timecard_entry_checkbox = "Timecard Entry"
$pc_timecard_ops_edit_checkbox = "Timecard Ops Edit"
$pc_expense_entry_checkbox = "Expense Entry"
$pc_expense_ops_edit_checkbox = "Expense Ops Edit"
$pc_invoicing_checkbox = "Invoicing"

#Methods

# cleck new button
	def PC.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end
	
# set user
	def PC.set_user user_name
		fill_in $pc_user_label ,:with => user_name
		
	end
	
	# set resource name
	def PC.set_resource resource_name
		fill_in $pc_resource_label ,:with => resource_name[0,3]
		find($pc_resource_lookup).click
		within_window(windows.last) do
			page.has_text?($lookup_search_frame_lookup_text, :wait => DEFAULT_LESS_WAIT)
			page.driver.browser.switch_to.frame $lookup_result_frame
			SF.click_link resource_name
		end
	end
	
	# set region name
	def PC.set_region region_name
		fill_in $pc_region_label ,:with => region_name
	end
	
	# check checkbox on page as per its lable
	def PC.check_checkbox checkbox_name 
		page.check checkbox_name
	end
	
	# save the permission control
	def PC.click_save_button
		SF.retry_script_block do
			SF.click_button_save
		end
		SF.wait_for_search_button
	end
	
	# get PC name
	def PC.get_name
		return find($pc_name_value).text
	end
end