#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module COAS
 extend Capybara::DSL	
#############################
#Chart of Account Structure
#############################
###################################################
#Selectors 
###################################################

#Labels
$coas_name_label = "Name"
$coas_default_corporate_gla_label = "Default Corporate GLA"
$coas_default_local_gla_label = "Default Local GLA"
$coas_is_corporate_checkbox_label = "Is Corporate"
$coas_active_checkbox_label = "Active"
$coas_currency_select_list = "CurrencyIsoCode"
$coas_is_corporate_checkbox = "//label[text()='Is Corporate']/../following-sibling::td[1]/input"
$coas_is_active_checkbox = "//label[text()='Active']/../following-sibling::td[1]/input"
###################################################
#Methods
###################################################

	# set Name
	def COAS.set_name name
		fill_in $coas_name_label , :with => name
	end

	# set default corporate gla
	def COAS.set_default_corporate_gla gla
		fill_in $coas_default_corporate_gla_label , :with => gla
	end
	
	# set default Local gla
	def COAS.set_default_local_gla gla
		fill_in $coas_default_local_gla_label , :with => gla
	end
	
	# set currency
	def COAS.set_currency currency
		#find($coas_currecy_select_list).set currency		
		select(currency, :from => $coas_currency_select_list)
	end
	
	# set is corporate checkbox value
	def COAS.set_default_corporate is_corporate
		find(:xpath,$coas_is_corporate_checkbox).set  is_corporate
	end
	
	# set is active checkbox value
	def COAS.set_active is_active
		find(:xpath,$coas_is_active_checkbox).set  is_active
	end	
end