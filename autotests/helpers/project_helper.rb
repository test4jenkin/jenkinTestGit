 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module PROJECT
extend Capybara::DSL

#Locator
$project_name_input = "input[id='Name']"
$project_new_milestone_button = "input[value='New Milestone']"
$project_new_misc_adjustment_button = "input[value='New Miscellaneous Adjustment']"
$project_new_budget_button= "input[value='New Budget']"
$project_name_value = "div[id*='Name_']"
#Labels
$project_region_label = "Region"
$project_services_product_label = "Services Product"
$project_start_date_label = "Start Date"
$project_end_date_label = "End Date"
$project_account_label = "Account"
$project_active_label = "Active"
$project_billable_label = "Billable"
$project_include_in_forecasting_label = "Include In Forecasting"

#Methods

# click new button
	def PROJECT.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end

# set project name
	def PROJECT.set_name name
		find($project_name_input).set name
	end
	
# set project region
	def PROJECT.set_region_value region
		fill_in $project_region_label ,:with => region
	end
	
# set services product
	def PROJECT.set_services_product value
		fill_in $project_services_product_label ,:with => value
	end
	
# set start date 
	def PROJECT.set_start_date start_date
		fill_in $project_start_date_label ,:with => start_date
	end
	
# set start date 
	def PROJECT.set_end_date end_date
		fill_in $project_end_date_label ,:with => end_date
	end
	
# set account
	def PROJECT.set_account_value account_name
		fill_in $project_account_label ,:with => account_name
	end

	# get project name
	def PROJECT.get_name
		find($project_name_value).text
	end
	# click on milestone button
	def PROJECT.click_new_milestone_button
		 SF.retry_script_block do 
			find($project_new_milestone_button).click
		end
		SF.wait_for_search_button
	end
	  
	  # click on misc adjustment button
	def PROJECT.click_new_misc_adjustment_button
		SF.retry_script_block do 
			find($project_new_misc_adjustment_button).click
		end
		SF.wait_for_search_button
	  end
	  
	  # click on budget header button
	def PROJECT.click_new_budget_header_button 
		SF.retry_script_block do
			find($project_new_budget_button).click
		end
		SF.wait_for_search_button
	end
end