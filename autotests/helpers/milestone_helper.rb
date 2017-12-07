 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module MS
extend Capybara::DSL

#Locator
$ms_name_input = "input[id='Name']"

#Labels
$ms_target_date_label = "Target Date"
$ms_actual_date_label = "Actual Date"
$ms_milestone_amount_label = "Milestone Amount"
$ms_milestone_cost_label = "Milestone Cost"
$ms_milestone_status_label = "Status"
$ms_approved_checkbox = "Approved"
$ms_include_in_financial_checkbox= "Include In Financials"
$ms_approved_for_billing_checkbox  = "Approved for Billing"
$ms_approved_for_vendor_payment_checkbox  = "Approved for Vendor Payment"
$ms_gla_code_label = "Milestone GLA Code"
$ms_vendor_account_label = "Vendor Account"
$ms_status_approved = "Approved"

#Methods

# click new button
	def MS.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end

# set milestone name
	def MS.set_name name
		find($ms_name_input).set name
	end
	
# set target date
	def MS.set_target_date date
		fill_in $ms_target_date_label ,:with => date
	end
	
# set actual date 
	def MS.set_actual_date date
		fill_in $ms_actual_date_label ,:with => date
	end
	
# set milestone amount
	def MS.set_milestone_amount amount
		fill_in $ms_milestone_amount_label ,:with => amount
	end
	
# set start date 
	def MS.set_milestone_cost cost
		fill_in $ms_milestone_cost_label ,:with => cost
	end
	
# select milestone status
	def MS.select_milestone_status status
		select(status, :from => $ms_milestone_status_label) 
	end
	
# set gla code
	def MS.set_ms_gla_code gla_name
		fill_in $ms_gla_code_label ,:with=> gla_name
	end

# set vendor code
	def MS.set_vendor_account acc_name
		fill_in $ms_vendor_account_label ,:with=> acc_name
	end
end