#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module MA
extend Capybara::DSL

#############################
# Locators
#############################
$ma_master_account = "input[id$=':masterField']"
$ma_merge1_account = "input[id$=':merge1Field']"
$ma_run_button = "input[value= 'Run']"
$ma_confirm_button = "input[value='Confirm']"
$ma_merge_account_message = "The Merge Accounts process is in progress.  You are notified by email of the success or failure of this operation."
#############################
# Merge Account Methods
#############################
# set master account
	def MA.set_master_account master_account
		SF.execute_script do
			find($ma_master_account).set master_account
		end
	end
# set merge1 account	
	def MA.set_merge1_account merge_account
		SF.execute_script do
			find($ma_merge1_account).set merge_account
		end
	end
	
# Buttons
# click on run button	
	def MA.click_run_button
		SF.execute_script do
			find($ma_run_button).click
		end
		SF.wait_for_search_button
	end
# click on confirm button	
	def MA.confirm_button
		SF.execute_script do
			if page.has_css?($ma_confirm_button)
				find($ma_confirm_button).click			
			end
		end
		SF.wait_for_search_button
	end
end