 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module BUDGET
extend Capybara::DSL

#Locator
$budget_name_input = "input[id='Name']"
$budget_name_value = "div[id*='Name_']"

#label
$budget_amount_label = "Amount"
$budget_account_label = "Account"
$budget_effective_date_label = "Effective Date"
$budget_type_label = "Type"
$budget_type_vendor_purchase_order = "Vendor Purchase Order"
#Methods

# click new button
	def BUDGET.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end

# set budget header name
	def BUDGET.set_name name
		find($budget_name_input).set name
	end

# set amount
	def BUDGET.set_amount amount
		fill_in $budget_amount_label ,:with => amount
	end
# set account 
	def BUDGET.set_account acc_name
		fill_in $budget_account_label ,:with => acc_name
	end
# select type 	
	def BUDGET.select_budget_type budget_type
		select(budget_type, :from => $budget_type_label) 
	end
	
# set effective date
	def BUDGET.set_effective_date date
		fill_in $budget_effective_date_label ,:with => date
	end

# get budget name
	def BUDGET.get_name 
		return find($budget_name_value).text
	end
end