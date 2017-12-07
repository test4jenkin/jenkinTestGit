 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module MADJUST
extend Capybara::DSL

#Locator
$madjust_name_input = "input[id='Name']"

#Labels
$madjust_effective_date_label = "Effective Date"
$madjust_actual_date_label = "Actual Date"
$madjust_amount_label = "Amount"
$madjust_status_label = "Status"
$madjust_approved_checkbox = "Approved"
$madjust_include_in_financial_checkbox= "Include In Financials"
$madjust_approved_for_billing_checkbox  = "Approved for Billing"
$madjust_approved_for_vendor_payment_checkbox  = "Approved for Vendor Payment"
$madjust_gla_code_label = "Miscellaneous Adjustment GLA Code"
$madjust_vendor_account_label = "Vendor Account"
$madjust_trx_category_ready_to_bill_revenue = "Ready-to-Bill Revenue"
$madjust_status_approved = "Approved"
$madjust_transaction_category = "Transaction Category"

#Methods

# click new button
	def MADJUST.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end

# set milestone name
	def MADJUST.set_name name
		find($madjust_name_input).set name
	end
	
# set target date
	def MADJUST.set_effective_date date
		fill_in $madjust_effective_date_label ,:with => date
	end
	
# set milestone amount
	def MADJUST.set_amount amount
		fill_in $madjust_amount_label ,:with => amount
	end
	
# select milestone status
	def MADJUST.select_misc_adjust_status status
		select(status, :from => $madjust_status_label) 
	end

# select transaction category
	def MADJUST.select_tranx_category category
		select(category, :from => $madjust_transaction_category) 
	end
	
# set gla code
	def MADJUST.set_madjust_gla_code gla_name
		fill_in $madjust_gla_code_label ,:with=> gla_name
	end

# set vendor code
	def MADJUST.set_vendor_account acc_name
		fill_in $madjust_vendor_account_label ,:with=> acc_name
	end
end