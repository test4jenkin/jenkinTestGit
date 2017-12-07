 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
 
 module PSA
 extend Capybara::DSL
 #############################
# PSA Config Helper
#############################
 #Labels
 $label_psa_import_configuration = "Import Configuration"
 
 #methods
 
	# click import configuration button
	def PSA.click_import_configuration_button
		SF.retry_script_block do
			SF.click_button $label_psa_import_configuration
		end
		SF.wait_for_search_button
	end
 end
 