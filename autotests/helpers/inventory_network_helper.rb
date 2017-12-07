 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
 
module Inventory_Network
extend Capybara::DSL
$inventory_network_radio_label_pattern = "//label[contains(text(),'"+$sf_param_substitute+"')]/../input[@type='radio']"
$inventory_network_radio_option_icp_west = "ICP West"
$inventory_network_edit_icp_button = "Edit ICP"
$inventory_network_company_label = "//label[text()='Company']"

	#select radio option
	def Inventory_Network.select_radio_option option_name
		SF.retry_script_block do
			find(:xpath,$inventory_network_radio_label_pattern.gsub($sf_param_substitute,option_name)).click
		end
	end

	#set company
	def Inventory_Network.set_company company_name
		SF.retry_script_block do
			element_id = find(:xpath,$inventory_network_company_label)[:for]
			fill_in(element_id , :with => company_name)
		end
	end
end
