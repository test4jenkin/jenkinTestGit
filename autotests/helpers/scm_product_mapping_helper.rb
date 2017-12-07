#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SCM_Product_Mapping
extend Capybara::DSL

##Selectors
$scm_product_mapping_scm_line_type = "//label[text()='SCM Line Type']"
$scm_product_mapping_product = "//label[text()='Product']"

##Labels
$scm_product_mapping_scm_line_type_lable = "SCM Line Type"
$scm_product_mapping_product_lable = "Product"
	
	#Set SCM Product Mapping scm line type
	def SCM_Product_Mapping.set_scm_line_type scm_line_type
		SF.retry_script_block do
			SF.select_value $scm_product_mapping_scm_line_type_lable , scm_line_type		
		end
	end

	#Set SCM Product Mapping product
	def SCM_Product_Mapping.set_product product
		SF.retry_script_block do
			element_id = find(:xpath,$scm_product_mapping_product)[:for]
			fill_in(element_id , :with => product)			
		end
	end
end