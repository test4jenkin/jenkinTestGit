 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module TEMP
extend Capybara::DSL

#############################
# standard Template Page
#############################
#selectors
$template_name = "input[id='Name']"
$template_type_equal_split = "Equal Split"
$template_calculation_type_days = "Days"
$template_type_label = "//label[text()='Template Type']"
$template_revenue_source = "//label[text()='Revenue Source']"
$template_calculation_type_label = "//label[text()='Calculation Type']"
# Buttons
$template_new_template = "New Template"
 
#############################
# template method section
#############################
	# set template Name
	def TEMP.set_name name
		SF.execute_script do
			find($template_name).set name					
		end
	end
	
	# select template type
	def TEMP.select_type type_value
		SF.execute_script do
			element_id =  find(:xpath,$template_type_label) [:for]
			select type_value, :from => element_id							
		end
	end
	
	#set revenue source value
	def TEMP.set_revenue_source rev_source
		SF.execute_script do
			element_id =  find(:xpath,$template_revenue_source) [:for]
			fill_in(element_id , :with => rev_source)
		end
	end
	
	#set calculation type value
	def TEMP.select_calculation_type type_name
		SF.execute_script do
			element_id =  find(:xpath,$template_calculation_type_label) [:for]
			select type_name, :from => element_id							
		end
	end	
end
