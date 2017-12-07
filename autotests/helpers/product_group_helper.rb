#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Product_Group
extend Capybara::DSL

##Selectors
$product_group_name = "//label[text()='Product Group Name']"
$product_group_description = "//label[text()='Description']"
$product_group_intangible_product = "//label[text()='Intangible Product']"
$product_group_product = "//label[text()='Product']"
$product_group_item_in_grid_pattern = "//span[text()='"+$sf_param_substitute+"']"

#product group Name
$product_group_finished_goods = "Finished Goods"

#Item master 
$product_group_item_master_item_type_name = "//span[text()='Item Type']/../following-sibling::td[1]/div"
$product_group_item_master_product_group_name = "//span[text()='Product Group']/../following-sibling::td[1]/div" 

#Item Master name
$product_group_item_master_widget_1 = "Widget-1"
	
	#Set product group name
	def Product_Group.set_name name
		SF.retry_script_block do
			element_id = find(:xpath , $product_group_name)[:for]
			fill_in(element_id , :with => name)	
		end
	end
	
	#Set product group description
	def Product_Group.set_description description
		SF.retry_script_block do
			element_id = find(:xpath , $product_group_description)[:for]
			fill_in(element_id , :with => description)	
		end
	end
	
	#Set product group intangible product
	def Product_Group.set_intangible_product intangible_product
		SF.retry_script_block do
			element_id = find(:xpath , $product_group_intangible_product)[:for]
			fill_in(element_id , :with => intangible_product)	
		end
	end
	
	#Set product group product
	def Product_Group.set_product product
		SF.retry_script_block do
			element_id = find(:xpath , $product_group_product)[:for]
			fill_in(element_id , :with => product)	
		end
	end
	
	#item Master
	#get Item master Item type
	def Product_Group.get_item_master_item_type
		return find(:xpath , $product_group_item_master_item_type_name).text
	end
	
	#get Item master product group
	def Product_Group.get_item_master_product_group
		return find(:xpath , $product_group_item_master_product_group_name).text
	end	
	
	#select Product group name from grid
	def Product_Group.click_product_group_name_in_grid name
		return find(:xpath , $product_group_item_in_grid_pattern.sub($sf_param_substitute,name)).click
	end
end