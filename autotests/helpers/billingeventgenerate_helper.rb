 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module BEG
extend Capybara::DSL

#Locator
$beg_include_prior_period_checkbox = "input[id$=':includePriorPeriods']"
$beg_generate_button = "input[value='Generate']"
$beg_generate_event_account_value = "span[id$=':events'] table tbody tr:nth-of-type(2) td:nth-of-type(3) span"
$beg_batch_plus_image = "//span[contains(text(),'BEB-')]/ancestor::tr[1]/td[1]/a/img"
$beg_event_plus_image = "//span[contains(text(),'BE-')]/ancestor::tr[1]/td[1]/a/img"
$beg_release_button = "input[value='Release']"
$beg_event_row_pattern = "//a/span[text()='"+$sf_param_substitute+"']/ancestor::td[1]/following::td[3][(text()='"+$sf_param_substitute+"')]/ancestor::tr[1]/td[1]/input"
$beg_remove_button = "input[value='Remove']"
#label

#Methods

# check include prior period checkbox
	def BEG.check_include_prior_period_checkbox
		find($beg_include_prior_period_checkbox).set true
	end
	
# click generate button
	def BEG.click_generate_button
		find($beg_generate_button).click
		page.has_css?($beg_release_button)
	end
	
# get account name for billing event
	def BEG.get_billing_event_account_name 
		return find($beg_generate_event_account_value).text
	end
	
# expand the billing event batch name
	def BEG.expand_billing_event_batch_list
		SF.retry_script_block do 
			find(:xpath,$beg_batch_plus_image).click
			sleep 1# wait for the page to get  refresh
		end
		gen_wait_until_object $beg_release_button
	end
	
# expand the billing event name
	def BEG.expand_billing_event_list
		SF.retry_script_block do 
			find(:xpath,$beg_event_plus_image).click
			sleep 1# wait for the page to get refresh
		end
		gen_wait_until_object $beg_release_button
	end

	# click on remove button
	def BEG.remove_and_accept_alert
		find($beg_remove_button).click
		sleep 1# wait for the alert to appear
		SF.alert_ok
		gen_wait_until_object $beg_generate_button
	end
	
# select billing event items from list
# category_name(string) - Exact name of the category of billing event which need to be selected
# amount(string) - Exact amount of the billing event including currency - ex "USD -100.00"
	def BEG.select_billing_event category_name , amount
		SF.retry_script_block do 
			event_list = $beg_event_row_pattern.sub($sf_param_substitute ,category_name).sub($sf_param_substitute,amount)
			find(:xpath,event_list).click
		end
	end
	
end