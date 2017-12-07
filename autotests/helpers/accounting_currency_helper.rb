 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module AccountingCurrency  
extend Capybara::DSL
##################################################
# Accounting Currency field label and locators
##################################################
$acc_curr_iso_code_label = "ISO Code"
$acc_curr_currency_picklist_label = "Currency"
$acc_curr_decimal_places_label = "Decimal Places"
$acc_curr_home_checkbox_label = "Home"
$acc_curr_dual_checkbox_label = "Dual"
$acc_curr_new_exch_rate_button_label = "New Exchange Rate"
$acc_curr_currency_name_value = "//td[text()='ISO Code']/following::td[1]/div | //span[text()='ISO Code']/ancestor::div[1]/following::div[1]/div/span"
$accountingcurrency_owner_value = "//td[text()='Owner']/following-sibling::td[1]/div"
$acc_curr_set_effective_date = "input[id$='exchRateEffDate']"
$acc_curr_exch_rate_loading_image= "div.maskContent"
$acc_curr_config_group_currencies_link = "//span[text()='Currencies']/ancestor::a[1]"
$acc_curr_edit_config_group = "//h3[text()='Values']/ancestor::div[2]/div[2]//tr[2]/td[1]/a[text()='Edit']"
$acc_curr_config_group_value = "textarea[type='text']"
$acc_curr_config_group_true = "//td[text()='true']"
#Exchange rate
$acc_curr_exch_rate_start_date_label ="Start Date"
$acc_curr_exch_rate_label = "Rate"
$acc_curr_exch_rate_currency_label = "Exchange Rate Currency"
$acc_curr_currency_label = "Currency"
$acc_curr_currency_manage_rate_label = "Manage Rates"
$acc_curr_exch_rate_effective_date = "input[id="+$sf_param_substitute+"]"
$acc_curr_currency_manage_rate_button = "input[value='Manage Rates'] , article[aria-describedby='title#{ORG_PREFIX}ExchangeRates__r'] div a[title='Manage Rates']"

#############################
# Accounting Currency 
#############################

# Methods
# Create a new Accounting currency
	def	AccountingCurrency.create iso_code ,currency_value, decimal_places, home , dual 
		if iso_code != nil
			fill_in $acc_curr_iso_code_label , :with => iso_code
		end 
		if decimal_places != nil
			fill_in $acc_curr_decimal_places_label , :with => decimal_places
		end 
		if currency_value != nil
			SF.select_value $acc_curr_currency_picklist_label , currency_value
		end
		if home == true 
			check $acc_curr_home_checkbox_label
		elsif home == false 
			uncheck $acc_curr_home_checkbox_label
		end
		if dual == true 
			check $acc_curr_dual_checkbox_label
		elsif dual == false
			uncheck $acc_curr_dual_checkbox_label
		end 
	end 

# Get owner value	
	def AccountingCurrency.get_owner_value
		return find(:xpath, $accountingcurrency_owner_value).text
	end
	
# Create a new Exchange rate
	def AccountingCurrency.create_exchange_rate start_date, exchange_rate , exchange_rate_currency
		if start_date != nil
			fill_in $acc_curr_exch_rate_start_date_label , :with => start_date
		end
		if exchange_rate != nil
			fill_in $acc_curr_exch_rate_label , :with => exchange_rate
		end
		if exchange_rate_currency != nil
			fill_in $acc_curr_exch_rate_currency_label , :with => exchange_rate_currency
		end
	end
# Get Methods
# get currency name
	def AccountingCurrency.get_currency_name
		return find(:xpath ,$acc_curr_currency_name_value).text
	end
## Buttons
# click on new exchange rate button
	def AccountingCurrency.click_new_exchange_rate_button
		SF.click_button $acc_curr_new_exch_rate_button_label
		SF.wait_for_search_button
	end


# click on manage Rates button	
	def AccountingCurrency.click_manage_rates_button
		SF.on_related_list do
			find($acc_curr_currency_manage_rate_button).click
			page.has_css?($acc_curr_set_effective_date)
		end
		gen_wait_until_object_disappear $acc_curr_exch_rate_loading_image
	end	
## Actions on Manage Rate page
# set effective date
	def AccountingCurrency.set_exchange_rate_effective_date set_effective_date
		SF.execute_script do
			find($acc_curr_set_effective_date).set set_effective_date
			gen_tab_out $acc_curr_set_effective_date
			gen_wait_until_object_disappear $acc_curr_exch_rate_loading_image
		end
	end
# set exchange rate
	def AccountingCurrency.set_exchange_rate exch_rate ,home_currency , exchange_rate_currency
		SF.retry_script_block do 
			SF.execute_script do
				exch_rate_currency_locator = "rateGrid-"+home_currency+"-"+exchange_rate_currency
				gen_wait_until_object $acc_curr_exch_rate_effective_date.sub($sf_param_substitute,exch_rate_currency_locator)
				find($acc_curr_exch_rate_effective_date.sub($sf_param_substitute,exch_rate_currency_locator)).set exch_rate
			end
		end
	end	
end 


