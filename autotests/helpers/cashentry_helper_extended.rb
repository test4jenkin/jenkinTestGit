 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
 
CEX_LINE_COLUMN_ACCOUNT = 2
CEX_LINE_COLUMN_VAUE = 4
CEX_LINE_COLUMN_NET_VALUE = 6
 
module CEX
extend Capybara::DSL

#############################
# Cash Entry Extended Layout selectors
#############################
$cex_bank_account_input = "//label[text()='Bank Account']/ancestor::td[1]/following::td[1]/span/input"
$cex_cash_entry_number = "//td[text()='Cash Entry Number']/following::td[1]/div"
$cex_type_value  = "//td[text()='Type']/following::td[1]/div"
$cex_period_value = "//td[text()='Period']/following::td[1]/div"
$cex_bank_account_value = "//td[text()='Bank Account Value']/following::td[1]/div"
$cex_account_value = "//td[text()='Cash Entry Value']/following::td[1]/div"
$cex_line_charges_value = "//td[text()='Line Charges']/following::td[1]/div"
$cex_net_value = "//td[text()='Net Value']/following::td[1]/div"
$cex_account_payment_method = "//td[text()='Account Payment Method']/following::td[1]/div"
$cex_net_banked_value = "//td[text()='Net Banked']/following::td[1]/div"
$cex_cash_entry_value = "//td[text()='Cash Entry Value']/following::td[1]/div"
$cex_status_value = "//td[text()='Status']/following::td[1]/div"
$cex_currency_value = "//td[text()='Cash Entry Currency']/following::td[1]/div/a"
$cex_line_account_input = "//label[text()='Account']/ancestor::td[1]/following::td[1]/div/span/input"
$cex_line_number_link_pattern = "//h3[text()='Cash Entry Line Items']/ancestor::div[1]/following::div[1]/table/tbody/tr["+$sf_param_substitute+"]/th[1]/a"
#Manage Line
$cex_manage_line_account_input = "//h2[text()='Cash Entry Lines']/ancestor::div[1]/following::div[1]/div[1]/table/tbody/tr["+$sf_param_substitute+"]/td[#{CEX_LINE_COLUMN_ACCOUNT}]/div/span/input"
$cex_manage_line_ce_value_input = "//h2[text()='Cash Entry Lines']/ancestor::div[1]/following::div[1]/div[1]/table/tbody/tr["+$sf_param_substitute+"]/td[#{CEX_LINE_COLUMN_VAUE}]/div/input"
$cex_manage_line_net_value = "//h2[text()='Cash Entry Lines']/ancestor::div[1]/following::div[1]/div[1]/table/tbody/tr["+$sf_param_substitute+"]/td[#{CEX_LINE_COLUMN_NET_VALUE}]/div"
# Buttons
$cex_add_new_line_button = "input[value='New Cash Entry Line Item']"
$cex_manage_line_button= "input[value='Manage Lines']"
$cex_manage_add_line_button = "input[id='addLine']"
# Labels
$cex_type_label = "Type"
$cex_date_label = "Date"
$cex_derive_bank_account_label = "Derive Bank Account"
$cex_bank_account_label = "Bank Account"
$cex_derive_period_label = "Derive Period"
$cex_derive_currency_label = "Derive Currency"
$cex_payment_method_label = "Payment Method"
$cex_line_item_account_label = "Account"
$cex_line_item_derive_line_number_label = "Derive Line Number"
$cex_line_item_derive_payment_method_label = "Derive Payment Method"
$cex_line_item_cash_entry_value_label = "Cash Entry Value"
#############################
# Cash Entry Ext Layout methods
#############################

###############################
# Cash Entry Header New / Edit Page
###############################
# select cash entry type
	def CEX.select_cash_entry_type cex_type
		select(cex_type, :from => $cex_type_label) 
	end
	
# check derive bank account checkbox
	def CEX.check_derive_bank_account_checkbox
		SF.check_checkbox $cex_derive_bank_account_label
	end

# Uncheck derive bank account checkbox
	def CEX.uncheck_derive_bank_account_checkbox
		SF.uncheck_checkbox $cex_derive_bank_account_label
	end

# set bank account value
	def CEX.set_bank_account_name bank_name
		fill_in $cex_bank_account_label, :with => bank_name
	end

# set date
	def CEX.set_cash_entry_date date
		fill_in $cex_date_label, :with => date
	end
	
# check derive period checkbox
	def CEX.check_derive_period_checkbox
		SF.check_checkbox $cex_derive_period_label
	end

# Uncheck derive period checkbox
	def CEX.uncheck_derive_period_checkbox
		SF.uncheck_checkbox $cex_derive_period_label
	end

# check derive currency  checkbox
	def CEX.check_derive_currency_checkbox
		SF.check_checkbox $cex_derive_currency_label
	end

# Uncheck derive currency checkbox
	def CEX.uncheck_derive_currency_checkbox
		SF.uncheck_checkbox $cex_derive_currency_label
	end

# select cash entry payment method
	def CEX.select_cash_entry_payment_method payment_method
		select(payment_method, :from => $cex_payment_method_label) 
	end

###############################
# Cash Entry Line Item 
###############################
# set account in line item
	def CEX.set_line_item_account account_name
		find(:xpath , $cex_line_account_input).set account_name
		find(:xpath , $cex_line_account_input).native.send_keys(:tab)
	end

# check derive currency  checkbox
	def CEX.check_derive_line_num_checkbox
		SF.check_checkbox $cex_line_item_derive_line_number_label
	end

# Uncheck derive currency checkbox
	def CEX.uncheck_derive_line_num_checkbox
		SF.uncheck_checkbox $cex_line_item_derive_line_number_label
	end

# check derive payment method checkbox
	def CEX.check_derive_payment_method_checkbox
		SF.check_checkbox $cex_line_item_derive_payment_method_label
	end

# Uncheck derive pwyment method checkbox
	def CEX.uncheck_derive_payment_method_checkbox
		SF.uncheck_checkbox $cex_line_item_derive_payment_method_label
	end

# set cash entry value for cash entry line
	def CEX.set_line_item_cash_entry_value value
		fill_in $cex_line_item_cash_entry_value_label, :with => value
	end
	
# get line item payment method 
	def CEX.get_line_item_payment_method
		return find(:xpath , $cex_account_payment_method).text
	end
###############################
# Cash Entry Manage Line Item
###############################
#Manage Line
# set line account on manage line page
	def CE.set_manage_line_account row_num , acc_name
		row_account_input = $cex_manage_line_account_input.sub($sf_param_substitute , row_num.to_s)
		find(:xpath , row_account_input).set acc_name
		# click on next cell to auto populate the values
		find(:xpath , $cex_manage_line_ce_value_input.sub($sf_param_substitute , row_num.to_s)).click
	end
	
# set line cash entry value on manage line page
	def CE.set_manage_line_ce_value row_num , cashentry_value
		row_value_input = $cex_manage_line_ce_value_input.sub($sf_param_substitute , row_num.to_s)
		find(:xpath , row_value_input).set cashentry_value
		# click on next cell to auto populate the values
		find(:xpath,$cex_manage_line_net_value.sub($sf_param_substitute,row_num.to_s)).click
		sleep 1 # wait for the net value to auto update
	end
# get net value from manage line
	def CEX.get_line_net_value row_num
		SF.retry_script_block do
			row_net_value = $cex_manage_line_net_value.sub($sf_param_substitute,row_num.to_s)
			return find(:xpath , row_net_value).text
		end
	end
	
	
# Buttons
# Save cash entry
	def CEX.click_save_button
		SF.click_button_save
		SF.wait_for_search_button
	end

# click on New line item button
	def CEX.click_add_new_line_button
		find($cex_add_new_line_button).click
		SF.wait_for_search_button
	end
	
# click on manage line button
	def CEX.click_manage_line_button
		find($cex_manage_line_button).click
		page.has_css?($cex_manage_add_line_button)
	end
	
# click on add line button from manage line page
	def CEX.click_add_line_button
		find($cex_manage_add_line_button).click
	end
	
# click on post button
	def CEX.click_post_button
		SF.click_button $ffa_post_button
		SF.wait_for_search_button
	end
###############################
# Header View Page (get methods)
###############################
# get cash entry number
	def CEX.get_cash_entry_number
		return find(:xpath,$cex_cash_entry_number).text
	end

# get cash entry type
	def CEX.get_cash_entry_type
		return find(:xpath , $cex_type_value).text
	end

# get cash entry currency
	def CEX.get_cash_entry_currency
		return find(:xpath, $cex_currency_value).text
	end
	
# get cash entry period value
	def CEX.get_cash_entry_period
		return find(:xpath , $cex_period_value).text
	end

# get cash entry bank account value
	def CEX.get_cash_entry_bank_account_value
		return find(:xpath , $cex_bank_account_value).text
	end

# get cash entry account value 
	def CEX.get_cash_entry_account_value
		return find(:xpath , $cex_account_value).text
	end

# get cash entry line charge value
	def CEX.get_cash_entry_line_charge_value
		return find(:xpath , $cex_line_charges_value).text
	end

# get cash entry net value 
	def CEX.get_cash_entry_net_value
		return find(:xpath , $cex_net_value).text
	end

# get cash entry net banked vale
	def CEX.get_net_banked_value 
		find(:xpath, $cex_net_banked_value).text
	end
	
# get cash entry net vale
	def CEX.get_cash_entry_value 
		find(:xpath, $cex_cash_entry_value).text
	end

# get cash entry status
	def CEX.get_status 
		find(:xpath , $cex_status_value).text
	end	
	
# open cash entry line item detail page from header view
	def CEX.open_cash_entry_line_detail_page line_num
		line_num = line_num + 1
		SF.retry_script_block do 
			find(:xpath, $cex_line_number_link_pattern.sub($sf_param_substitute,line_num.to_s)).click
		end
		page.has_xpath?($cex_line_charges_value)	
	end
end