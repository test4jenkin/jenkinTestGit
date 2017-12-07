 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Account  
extend Capybara::DSL

#############################
# Accounts Selectors
#############################
##Selector
$account_acc_name = "//label[text()='Account Name']/ancestor::td[1]/following::td[1]/div/input | //div[contains(@class,'slds-p-around--medium')]//span[text()='Account Name']/ancestor::label[1]/following::input[1]"
$acc_account_merge_id_value ="//td[text()='Merge Id']/following::td[1]/div | //span[text()='Merge Id']/ancestor::div[1]/following::div[1]/div/span"
#Merge Account
$acc_find_account_value = "input[id='srch']"
$acc_find_account_button = "input[value='Find Accounts']"
$acc_merge_accounts_link_label = "Merge Accounts"
$acc_select_merge_account_next_button= "input[title='Next']"
$acc_billing_street_input = "//label[text()='Billing Street']/ancestor::td[1]/following::td[1]/textarea | //span[text()='Billing Address']/ancestor::div[1]/div[1]/div/textarea"
$acc_billing_city_input = "//label[text()='Billing City']/ancestor::td[1]/following::td[1]/input | //span[text()='Billing Address']/ancestor::div[1]//span[text()='City']/ancestor::label[1]/following::input[1]"
$acc_billing_state_province_input = "//label[text()='Billing State/Province']/ancestor::td[1]/following::td[1]/input | //span[text()='Billing Address']/ancestor::div[1]//span[text()='State']/ancestor::label[1]/following::input[1]"
$acc_billing_country_input = "//label[text()='Billing Country']/ancestor::td[1]/following::td[1]/input | //span[text()='Billing Address']/ancestor::div[1]//span[text()='Country']/ancestor::label[1]/following::input[1]"
$acc_billing_zip_postal_code_input = "//label[text()='Billing Zip/Postal Code']/ancestor::td[1]/following::td[1]/input | //span[text()='Billing Address']/ancestor::div[1]//span[text()='Zip/Postal Code']/ancestor::label[1]/following::input[1]"
# Labels
$account_accounts_payable_control_label = "Accounts Payable Control"
$account_accounts_receivable_control_label = "Accounts Receivable Control"
$account_bank_account_name_label = "Bank Account Name"
$account_bank_name_label = "Bank Name"
$account_bank_sort_code_label = "Bank Sort Code"
$account_bank_account_number_label = "Bank Account Number"
$account_bank_account_reference_label = "Bank Account Reference"
$account_bank_swift_number_label = "Bank SWIFT Number"
$account_bank_iban_number_label = "Bank IBAN Number"
$account_name_label = "Account Name"
$account_type_picklist = "Type"
$account_copy_billing_add_to_shipping_add_link = "Copy Billing Address to Shipping Address"
$account_reporting_code_label = "Reporting Code"
$account_currency_label = "Account Currency"
$account_tax_country_code_label = "Tax Country Code"
$account_name_value = "//td[text()='Account Name']/following::td[1]/div[1] | //span[text()='Account Name']/ancestor::div[1]/following::div[1]/div/span"
$account_trading_currency_label= "Account Trading Currency"
$account_tax_status_label= "Tax Status"
$account_tax_calculation_method_label = "Tax Calculation Method"
$account_receivable_control_label = "Accounts Receivable Control"
$account_base_date_1_label = "Base Date 1"
$account_discount_1_label = "Discount 1"
$account_days_offset_1_label = "Days Offset 1"
$account_description_1_label = "Description 1"
$account_account_payable_control_value = "//td[text()='Accounts Payable Control']/following::td[1]/div[1] | //div[contains(@class,'slds-p-around--medium')]//span[text()='Accounts Payable Control']/ancestor::label[1]/following::input[1]"
$account_account_receivable_control_link = "//td[text()='Accounts Receivable Control']/following::td[1]/div[1]/a"
$account_merge_id_label = "Merge Id"
$account_financial_correspondence_invoice_email_label = "Invoice Email"
$account_financial_correspondence_finance_contact_label = "Finance Contact"
$account_detail_list_link = "a[title='Details']"
$account_dsm_account_id_label = "//label[text()='DSM Account ID']/ancestor::td[1]/following::td[1]/input"


# Methods
# Accounting Information section 
	# set account name
	def Account.set_account_name  name
		find(:xpath,$account_acc_name).set name
	end
	# set account type
	def Account.select_account_type type
		SF.select_value $account_type_picklist, type
	end
	# set reporting code
	def Account.set_account_reporting_code rep_code
		fill_in $account_reporting_code_label ,:with => rep_code
	end
	# set account currency
	def Account.select_account_currency currency
		SF.retry_script_block do
			SF.select_value $account_currency_label , currency
		end
	end
# set account receivable control gla	
	def Account.set_accounts_receivable_control accounts_receivable_control 		
		SF.fill_in_lookup $account_accounts_receivable_control_label , accounts_receivable_control
	end 
# set account payab;e control gla 
	def Account.set_accounts_payable_control accounts_payable_control		
		SF.fill_in_lookup $account_accounts_payable_control_label , accounts_payable_control
	end
# set account trading currency
	def Account.set_account_trading_currency account_trading_currency
		fill_in "Account Trading Currency" ,:with => account_trading_currency
	end
# set default expense account
	def Account.set_default_expense_account default_expense_account
		fill_in "Default Expense Account" ,:with => default_expense_account
	end
# set account phone 
	def Account.set_account_phone phone_number
		fill_in "Phone" ,:with => phone_number
	end
# Address information 
# set billing street
	def Account.set_billing_street billing_street 
		find(:xpath , $acc_billing_street_input).set billing_street
	end 
# set billing city
	def Account.set_billing_city billing_city
		find(:xpath , $acc_billing_city_input ).set billing_city
	end 
# set billing state province
	def Account.set_billing_state_province billing_state_province
		find(:xpath , $acc_billing_state_province_input ).set billing_state_province
	end 
# set billing zip code
	def Account.set_billing_zip_postal_code billing_zip_postal_code
		find(:xpath , $acc_billing_zip_postal_code_input ).set billing_zip_postal_code
	end 
# set billing country
	def Account.set_billing_country  billing_country 
		find(:xpath , $acc_billing_country_input ).set billing_country
	end 

# click on copy billing add to shipping address
	def Account.copy_billing_address_to_shipping_address
		click_link $account_copy_billing_add_to_shipping_add_link
	end
# VAT/GST information 
# select tax status
	def Account.select_tax_status tax_status
		SF.select_value 'Tax Status' ,tax_status 
	end
# select tax calculation method
	def Account.select_tax_calculation_method tax_calculation_method
		SF.select_value 'Tax Calculation Method' ,tax_calculation_method
	end
# select tax country code
	def Account.select_tax_county_code code
		SF.select_value $account_tax_country_code_label ,code
	end
# Finance Correspondence
# select billing method
	def Account.select_billing_method billing_method
		select(billing_method, :from => 'Billing Method') 
	end 
# select payment method	
	def Account.select_payment_method payment_method
		select(payment_method, :from => 'Payment Method') 
	end 
# Credit terms 
# set description 1
	def Account.set_description_1 description_1
		fill_in "Description 1" , :with => description_1
	end 
# select base date 1
	def Account.select_base_date_1 base_date_1 
		SF.select_value 'Base Date 1',base_date_1
	end 
# set days offset 1
	def Account.set_days_offset_1 days_offset_1 
		fill_in "Days Offset 1" , :with => days_offset_1 
	end 
# set discount 1
	def Account.set_discount_1 discount_1
		fill_in "Discount 1" , :with => discount_1
	end 
# set description 2
	def Account.set_description_2 description_2
		fill_in "Description 2" , :with => description_2
	end 
# select base date 2
	def Account.select_base_date_2 base_date_2
		select(base_date_2 , :from => 'Base Date 2') 
	end 
# set days offset 2
	def Account.set_days_offset_2 days_offset_2
		fill_in "Days Offset 2" , :with => days_offset_2
	end 
# set discount	2
	def Account.set_discount_2 discount_2
		fill_in "Discount 2" , :with => discount_2
	end
# View Account details	
	def Account.view_account account_name
		SF.click_link account_name
		SF.wait_for_search_button
	end 

# Get methods
# get account name
	def Account.get_account_name
		Account.on_account_detail_page do
			return find(:xpath,$account_name_value).text
		end
	end
	
	# get account Payable control name
	def Account.get_account_payable_control_name
		return find(:xpath, $account_account_payable_control_value).text		 
	end
	# get account name
	def Account.get_account_receivable_control_name
		return find(:xpath, $account_account_receivable_control_link).text		 
	end
# open account detail page	
	def Account.open_account_detail_page account_name
		click_link account_name[0]
		click_link account_name
	end
# get Merge Id
	def Account.get_merge_id
		return find(:xpath , $acc_account_merge_id_value).text
	end
# click on merge account
	def Account.click_merge_account
		click_link $acc_merge_accounts_link_label
		SF.wait_for_search_button
	end
# set find account value
	def Account.set_find_account account_value
		find( $acc_find_account_value).set account_value
	end
# click find account
	def Account.click_find_account
		find($acc_find_account_button).click
		SF.wait_for_search_button
	end
# select merge account value
	def Account.select_merge_account account_value
		record_to_select = find(:xpath , $acc_select_merge_account.gsub($sf_param_substitute, account_value))[:id]
		page.check(record_to_select)
	end
# click on next button
	def Account.click_next
		find($acc_select_merge_account_next_button).click
		SF.wait_for_search_button
	end
# click on merge button.
	def Account.click_button_merge
		SF.click_button "Merge"
		gen_wait_less # Wait for the alert to appear on screen
	end
# check if account name is deleted from app	
	def Account.check_is_account_deleted account_name
		SF.listview_filter_result_by_alphabet account_name[0]
		if(page.has_text?(account_name))
			return false
		else
			return true
		end
	end
# set Bank related information
# set bank account name
	def Account.set_bank_account_name bank_acc_name
		fill_in $account_bank_account_name_label, :with => bank_acc_name
	end

# set bank name	
	def Account.set_bank_name bank_name
		fill_in $account_bank_name_label, :with => bank_name
	end
# set bank sort code	
	def Account.set_bank_sort_code code_value
		fill_in $account_bank_sort_code_label, :with => code_value
	end
# set bank account number
	def Account.set_bank_account_number bank_acc_number
		fill_in $account_bank_account_number_label, :with => bank_acc_number
	end

# set bank account reference	
	def Account.set_bank_account_reference bank_acc_ref
		fill_in $account_bank_account_reference_label, :with => bank_acc_ref
	end
# set bank swift number	
	def Account.set_bank_swift_number bank_swift_num
		fill_in $account_bank_swift_number_label, :with => bank_swift_num
	end
# set bank iban number
	def Account.set_bank_iban_number bank_iban_num
		fill_in $account_bank_iban_number_label, :with => bank_iban_num
	end
	
# set finance correspondence details
	# set finance correspondence email	
	def Account.set_finance_correspondence_email  email_address 
		fill_in $account_financial_correspondence_invoice_email_label ,:with => email_address
	end
	
	# set finance correspondence contact name	
	def Account.set_finance_correspondence_contact contact_name 
		SF.fill_in_lookup $account_financial_correspondence_finance_contact_label ,  contact_name
	end
	
	def Account.on_account_detail_page (&block)
		if (SF.org_is_lightning)
			find($account_detail_list_link).click
		end
		# execute the code block on line item
		block.call()
	end
	
	def Account.verify_detail_content text_to_validate
		Account.on_account_detail_page do
		    SF.scroll_page_down 3
			isTextExists = page.has_text?(text_to_validate)	
			SF.scroll_page_up 3
			return isTextExists			
		end
	end
	
	# set account dsm Id , 
	# dsm_id - company id in DFP
	def Account.set_dsm_account_id dsm_id
		find(:xpath,$account_dsm_account_id_label).set dsm_id
	end
end 
