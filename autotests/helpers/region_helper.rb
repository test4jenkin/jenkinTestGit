 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module REGION
extend Capybara::DSL

#Locator
$region_name_input = "input[id='Name']"
$region_name_value = "div[id*='Name_']"
#Labels
$region_company_label = "Company"
$region_default_work_calendar_label = "Default Work Calendar"
$region_include_in_forecasting_checkbox_label= "Include In Forecasting"
#Methods
	
	# click new button
	def REGION.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end

	# set region name
	def REGION.set_region_name name
		find($region_name_input).set name
	end
		
	# set Region Company
	def REGION.set_region_company company_name
		fill_in $region_company_label ,:with => company_name
	end
	
	# set default work calendar
	def REGION.set_default_work_calendar calendar_name
		fill_in $region_default_work_calendar_label ,:with => calendar_name
	end
	
	# check Include In Forecasting checkbox
	def REGION.check_include_in_forecasting_checkbox
		page.check $region_include_in_forecasting_checkbox_label
	end
	
	# save the region
	def REGION.click_save_button
		SF.retry_script_block do
			SF.click_button_save
		end
		SF.wait_for_search_button
	end
	
	# get region name
	def REGION.get_name
		find($region_name_value).text
	end
end