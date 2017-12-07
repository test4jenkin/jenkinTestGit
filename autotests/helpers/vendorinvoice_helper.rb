 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved. 
module VIN
extend Capybara::DSL

#Locator
$vin_elligible_for_payable_invoice_value = "//td[text()='Eligible for Payable Invoice']/following::td[1]/div"
$vin_elligible_for_payable_credit_note_value = "//td[text()='Eligible for Payable Credit Note']/following::td[1]/div"
$vin_create_pin_pcn_button = "input[value='Create Payable Invoice/Credit']"
$vin_new_invoice_item_button = "input[value='New Invoice Items']"
$vin_date_value = "//td[text()='Date']/ancestor::tr[1]/td[4]/div"
$vin_name_value = "div[id*='Name_']"
#label
$vin_account_label = "Account"
$vin_date_label = "Date"
$vin_inv_number_label = "Invoice Number"
$vin_po_wo_number_label = "PO/WO Number"
$vin_name_label = "Name"
$vin_submitted_checkbox_label = "Submitted"
$vin_approved_for_payment_checkbox_label = "Approved for Payment"
$vin_eligible_for_pin_label = "Eligible for Payable Invoice"
$vin_eligible_for_pcr_label = "Eligible for Payable Credit Note"

# Invoice Line Items
$vin_line_row_data_content = "//h3[text()='Vendor Invoice Items']//ancestor::div[2]/div[2]/table[1]/tbody[1]/tr["+$sf_param_substitute+"]"
$vin_line_start_date = "//label[contains(text(),'Start Date')]/ancestor::th/following::td[1]/span/input"
$vin_line_end_date = "//label[contains(text(),'End Date')]/ancestor::th/following::td[1]/span/input"
$vin_line_show_misc_adjustment_checkbox = "//label[contains(text(),'Show Miscellaneous Adjustments')]/ancestor::tr[1]/td[1]/input"
$vin_line_show_milestone_checkbox = "//label[contains(text(),'Show Milestones')]/ancestor::tr[1]/td[1]/input"
$vin_line_search_button = "td[class='pbButton '] input[value='Search']"
$vin_line_disabled_add_button = "input[value='Add'][disabled='disabled']"
$vin_line_invoice_item_checkbox_pattern = "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td[1]/input"
$vin_line_add_button = "input[value='Add']"
$vin_line_done_button = "input[value='Done']"
#Methods

# click new button
	def VIN.click_new_button
		SF.retry_script_block do
			SF.click_button_new
		end
		SF.wait_for_search_button
	end

# click Edit button
	def VIN.click_edit_button
		SF.retry_script_block do
			SF.click_button_edit
		end
		SF.wait_for_search_button
	end
# set account name
	def VIN.set_account acc_name 
		fill_in $vin_account_label ,:with => acc_name
	end
	
# set date
	def VIN.set_date date 
		fill_in $vin_date_label ,:with => date
	end	

# set invoice number
	def VIN.set_invoice_number inv_num 
		fill_in $vin_inv_number_label ,:with => inv_num
	end	
	
# set PO/WO number
	def VIN.set_po_wo_number value
		fill_in $vin_po_wo_number_label ,:with => value
	end

# click save button
	def VIN.click_save_button
		SF.retry_script_block do
			SF.click_button_save
		end
		page.has_css?($vin_new_invoice_item_button)
	end
# check a checkbox by its label
	def VIN.check_checkbox checkbox_label
		page.check checkbox_label
	end
	
# Un-check a checkbox by its label
	def VIN.uncheck_checkbox checkbox_label
		page.uncheck checkbox_label
	end
# get value for elligible for PIN in integer format
	def VIN.get_elligible_pin_value 
		value = find(:xpath , $vin_elligible_for_payable_invoice_value).text
		return value.to_i
	end
	
# get value for elligible for PCR in integer format
	def VIN.get_elligible_pcr_value 
		value = find(:xpath , $vin_elligible_for_payable_credit_note_value).text
		return value.to_i
	end
	
# click create pin/pcn button
	def VIN.click_create_pin_pcn_button
		find($vin_create_pin_pcn_button).click
		SF.wait_for_search_button
	end
# get invoice date
	def VIN.get_invoice_date 
		find(:xpath, $vin_date_value).text
	end

# get vendor invoice name
	def VIN.get_name
		return find($vin_name_value).text
	end
	
##################
#Vendor Invoice Line Items
#################
# click on VIN new Item button
	def VIN.click_new_item_button
		SF.retry_script_block do
			find($vin_new_invoice_item_button).click
		end
		SF.wait_for_search_button
	end

# set start date
	def VIN.set_start_date date
		find(:xpath,$vin_line_start_date).set date
	end

# set end date
	def VIN.set_end_date date
		find(:xpath,$vin_line_end_date).set date
	end	

# check show misc adjustment checkbox
	def VIN.check_show_misc_adjustment_checkbox
		find(:xpath,$vin_line_show_misc_adjustment_checkbox).set true
	end
# check milestone checkbox	
	def VIN.check_show_milestone_checkbox
		find(:xpath,$vin_line_show_milestone_checkbox).set true
	end

# click search button
	def VIN.click_search_button
		find($vin_line_search_button).click
		page.has_no_css?($vin_line_disabled_add_button)
	end

# select invoice items from list result
# pass the name of item to select by clicking on checkbox
	def VIN.select_invoice_item item_name
		find(:xpath,$vin_line_invoice_item_checkbox_pattern.sub($sf_param_substitute , item_name)).set true
	end

# click on add buton to add items
	def VIN.click_line_add_button
		SF.retry_script_block do 
			find($vin_line_add_button).click
			page.has_css?($vin_line_done_button)
		end
		SF.wait_for_search_button
	end

# click on done button
	def VIN.click_done_button
		SF.retry_script_block do 
			find($vin_line_done_button).click
		end
		page.has_css?($vin_create_pin_pcn_button)
	end
	
# get vendor invoice row content
# row_num = Row number(Integer) which content need to be returned
	def VIN.get_vin_line_row_data row_num
		row_num = row_num + 1
		row_num = row_num.to_s
		return find(:xpath , $vin_line_row_data_content.sub($sf_param_substitute , row_num)).text
	end
end