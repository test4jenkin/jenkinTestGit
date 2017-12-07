 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module BE
extend Capybara::DSL

#Locator
$be_release_button = "input[value='Release']"
$be_create_sin_scn_button = "input[value='Create Invoices/Credits']"
#label
$be_summary_amount_label = "Summary Amount"
$be_name_label = "Name"

#Methods

# click on release button
	def BE.click_release_button
		find($be_release_button).click
		page.has_css?($be_create_sin_scn_button)
	end
	
# click on create sales invoice and credit note button
	def BE.click_create_sin_scn_button
		SF.retry_script_block do 
			find($be_create_sin_scn_button).click
		end
		SF.wait_for_search_button
	end

end