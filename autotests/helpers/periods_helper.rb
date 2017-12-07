#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

PERIOD_COLUMN_FINAL_CLOSE =9

module PERIOD
extend Capybara::DSL
###################################################
# Selectors 
###################################################
$period_owner_company_value = "//td[text()='Owner Company']/following-sibling::td[1]/div"
$period_final_close_button_checkbox = "(//div[@class = 'pbBody']/table//tr)["+$sf_param_substitute+"]//td[#{PERIOD_COLUMN_FINAL_CLOSE}]/img[@title = 'Checked']"
$period_all_period_list = "//h3[text()='Periods']/ancestor::div[1]/following::div[1]/table/tbody/tr"

# Methods
# get owner company
	def PERIOD.get_owner_company
		return find(:xpath, $period_owner_company_value).text
	end	

# Check that all period as closed		
	def PERIOD.expect_all_period_status_as_closed
		Array period_list = all(:xpath, $period_all_period_list)
		SF.wait_for_search_button
		all_period_close= true
		for i in 2..period_list.size do
			# check if any of the period is not closed
			if page.has_no_xpath?($period_final_close_button_checkbox.sub($sf_param_substitute , i.to_s))
				all_period_close=false
				return all_period_close
			end
		end
		return all_period_close
	end
end
