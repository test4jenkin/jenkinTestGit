 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module RECY
extend Capybara::DSL

#############################
# standard Recognition Years Page
#############################
#selectors
$recy_custom_field_label = "//label[text()='#{$sf_param_substitute}']"

#lable
$recy_name = "Recognition Year Name"
$recy_period_calculation_basis = "Period Calculation Basis"
$recy_number_of_months = "Number of Months"
$recy_start_date = "Start Date"
$recy_generate_periods = "Generate Periods"
$recy_calculate_periods = "Calculate Periods"
$recy_create_period = "Create Period"
$recy_period_calculation_basis_month = "Month"

#############################
# method section
#############################
	#fill field text value  by specified label
	#label_name - name of label for text box
	#text_value - text value to fill in text box 
	def RECY.set_custom_field_text_value label_name, text_value
		element_id = find(:xpath,$recy_custom_field_label.sub($sf_param_substitute,label_name ))[:for]
		fill_in(element_id , :with => text_value)
	end

	#select valued in dropwon by specified label
	#label_name - name of label for text box
	#option_value - option value to select in dropdown
	def RECY.select_dropdown_value label_name, option_value
		element_id = find(:xpath,$recy_custom_field_label.sub($sf_param_substitute,label_name ))[:for]
		select option_value, :from => element_id		
	end
end
