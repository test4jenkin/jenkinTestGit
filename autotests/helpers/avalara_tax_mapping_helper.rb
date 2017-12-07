#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module AVA_TAX_MAP
extend Capybara::DSL

	##Selectors
	$ava_tax_map_product_group = "//label[text()='Product Group']"
	$ava_tax_map_avalara_tax_code = "//label[text()='Avalara Tax Code']"

	##Labels
	$ava_tax_map_product_group_label = "Product Group"
	$ava_tax_map_item_type_label = "Item Type"
	$ava_tax_map_avalara_tax_code_label = "Avalara Tax Code"

	#Set Avalara tax mapping product group
	def AVA_TAX_MAP.set_product_group product_group
		SF.retry_script_block do
			element_id = find(:xpath , $ava_tax_map_product_group)[:for]
			fill_in(element_id , :with => product_group)
		end
	end

	#Set Avalara tax mapping item type
	def AVA_TAX_MAP.set_item_type item_type
		SF.retry_script_block do
			SF.select_value $ava_tax_map_item_type_label , item_type
		end
	end

	#Set Avalara tax mapping avalara tax code
	def AVA_TAX_MAP.set_avalara_tax_code avalara_tax_code
		SF.retry_script_block do
			element_id = find(:xpath , $ava_tax_map_avalara_tax_code)[:for]
			fill_in(element_id , :with => avalara_tax_code)	
		end
	end
end