 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module USERCOMPANY  
extend Capybara::DSL
#selectors
$usercompany_user_lookup = "a[title='User Lookup (New Window)']"
$usercompany_company_label = "Company"
$usercompany_user_label = "User"
$usercompany_company_input = "//label[text()='Company']/ancestor::td[1]/following::td[1]/span/input" 
$usercompany_user_input =  "//label[text()='User']/ancestor::td[1]/following::td[1]/span/input"
$usercompany_use_local_account_label = "Use Local Account"

#Methods
#############################
# User Companies
#############################
# Set user details
	def USERCOMPANY.set_user_name name 
		SF.retry_script_block do
			FFA.select_user_from_lookup  $usercompany_user_lookup , name
		end
	end 
# Set Company Details
	def USERCOMPANY.set_company_name comp_name
		SF.fill_in_lookup $usercompany_company_label , comp_name
	end
end 
