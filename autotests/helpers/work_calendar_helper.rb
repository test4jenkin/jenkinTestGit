 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module WC
extend Capybara::DSL

#Locator
$wc_name_input = "input[id='Name']"
$wc_name_value = "div[id*='Name_']"
#Methods
	
	# click new button
	def WC.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end
	
	# set work calendar name
	def WC.set_work_calendar_name name
		find($wc_name_input).set name
	end
	
	# save the work calendar
	def WC.click_save_button
		SF.retry_script_block do
			SF.click_button_save
		end
		SF.wait_for_search_button
	end
	
	# get name of work calendar
	def WC.get_wc_name 
		return find($wc_name_value).text
	end
end