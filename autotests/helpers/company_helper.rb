 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Company  
extend Capybara::DSL

#############################
# Selectors
#############################
$company_name = 'h2.pageDescription'
$company_name_input = "input[id='Name']"
$company_record_type_picklist_label = "Record Type of new record"
$company_intercompany_account_label = "Intercompany Account"
$company_address_street_label= "Street"
$company_address_city_label = "City"
$company_address_state_province_label = "State/Province"
$company_address_zip_postal_code_label = "Zip/Postal Code"
$company_address_country_label = "Country"
$company_address_fax_label = "Fax"
$company_address_website_label = "Website"
$company_address_contact_email_label = "Contact Email"
$company_address_phone_label = "Phone"
$company_country_tax_code_picklist_label = "Tax Country Code"
$company_tax_registeration_number = "Tax Registration Number"
$company_credit_terms_description1_label = "Description 1"
$company_credit_terms_days_offset1_label = "Days Offset 1"
$company_credit_terms_discount1_label = "Discount 1"
$company_credit_terms_basedata1_label = "Base Date 1"
$company_go_back_button_locator = "input[value='Go Back']"
$company_continue_button_label = "Continue , Next"
$company_activate_button_label = "Activate"
$company_activate_company_button_label = "Activate Company"
$company_user_lookup = "a[title='User Lookup (New Window)']"
$company_label = "Company"
$company_name_value = "//td[text()='Name']/ancestor::tr[1]/td[2]/div | //span[text()='Name']/ancestor::div[1]/following::div[1]/div"
$company_queue_name = "input[id$=':theQueueName']"
$company_suspense_gla_value = "//td[text()='Suspense GLA']/following-sibling::td/div/a"
$company_retained_earnings_gla_value = "//td[text()='Retained Earnings GLA']/following-sibling::td/div/a"
$company_year_end_mode_value = "//td[text()='Year End Mode']/following-sibling::td/div"
$company_year_end_mode_label = "Year End Mode"
$company_suspense_gla = "//label[text()='Suspense GLA']"
$company_retained_earnings_gla = "//label[text()='Retained Earnings GLA']"
$company_year_end_mode = "//label[text()='Year End Mode']"
$company_external_tax_calculation = "External Tax Calculation"
$company_record_type = "//label/span[text()='"+$sf_param_substitute+"']"
$company_continue_button = "input[title='Continue']"
#############################
# Companies methods
#############################
	# Default Information
	def Company.set_bank_account bank_account 
		fill_in "Bank Account" , :with => bank_account 
	end 

	def Company.set_suspense_gla suspense_gla 
		fill_in "Suspense GLA" , :with => suspense_gla 
	end 

	def Company.set_retained_earnings_gla retained_earnings_gla 
		fill_in "Retained Earnings GLA" , :with => retained_earnings_gla 
	end 

	# Accounts Receivable Analysis - Settlement Discount
	def Company.set_settlement_discount settlement_discount 
		fill_in "Settlement Discount" , :with => settlement_discount 
	end 

	# Accounts Receivable Analysis - Write-off
	def Company.set_write_off write_off 
		fill_in "Write-off" , :with => write_off 
	end 

	# Accounts Receivable Analysis - Currency Write-off
	def Company.set_currency_write_off currency_write_off  
		fill_in "Currency Write-off" , :with => currency_write_off  
	end 
	
	# select company record type
	def Company.select_record_type record_type
		# In lighting org, record type are displayed as rado button.
		if (SF.org_is_lightning)
			find(:xpath,$company_record_type.sub($sf_param_substitute ,record_type )).click
		else 
			#On Non-Lightnig, options are displayed in dropdown.
			select(record_type, :from => $company_record_type_picklist_label)
		end
	end
	
	# select year end mode
	def Company.select_year_end_mode year_end_mode
		select year_end_mode, :from => $company_year_end_mode_label
	end

## Set Company Information Details	
	# set company name
	def Company.set_company_name name
		fill_in  "Name", :with => name
	end
	
	# set intercompany account
	def Company.set_intercompany_account account_value
		fill_in  $company_intercompany_account_label , :with => account_value
	end
	
## Set company Address details
	# set street address
	def Company.set_company_street_address street_name
		fill_in $company_address_street_label , :with => street_name
	end
	
	# set company city  value
	def Company.set_company_city city_name
		fill_in $company_address_city_label , :with => city_name
	end
	
	# set company state/province value
	def Company.set_company_state_province value
		fill_in $company_address_state_province_label , :with => value
	end
	
	# set company Zip postal value
	def Company.set_company_zip_postal_code value
		fill_in $company_address_zip_postal_code_label , :with => value
	end
	
	# set company country
	def Company.set_company_country country_name
		fill_in $company_address_country_label , :with => country_name
	end
	
	# set company fax
	def Company.set_company_fax fax_value
		fill_in $company_address_fax_label , :with => fax_value
	end
	
	# set company website
	def Company.set_company_website website_name
		fill_in $company_address_website_label , :with => website_name
	end
	
	# set company contact email
	def Company.set_company_contact_email email_address
		fill_in $company_address_contact_email_label , :with => email_address
	end 
	
	# set company contact email
	def Company.set_company_phone phone_number
		fill_in $company_address_phone_label , :with => phone_number
	end
	# set company phone
	def Company.set_company_phone phone_number
		fill_in $company_address_phone_label , :with => phone_number
	end 
	
## GST Information details
	# select tax country code
	def Company.select_tax_country_code code
		SF.select_value $company_country_tax_code_picklist_label , code
	end
	
	# set tax registration number
	def Company.set_company_tax_registeration_number registeration_number 
		fill_in $company_tax_registeration_number , :with => registeration_number
	end
	#set external tax calculation for company
	def Company.set_company_external_calculation_setting tax_setting
		SF.select_value $company_external_tax_calculation , tax_setting
	end
## Credit Terms
	# set description 1 value
	def Company.set_credit_term_description1 value
		fill_in $company_credit_terms_description1_label , :with => value
	end
	
	# set days offset 1 value
	def Company.set_credit_term_days_offset1 value
		fill_in $company_credit_terms_days_offset1_label , :with => value
	end
	
	# set discount 1 value
	def Company.set_credit_term_discount1 value
		fill_in $company_credit_terms_discount1_label , :with => value
	end
	
	# set Base Date 1 value
	def Company.select_credit_term_base_date1 value
		SF.select_value $company_credit_terms_basedata1_label , value
	end
## set Company QUeue Name
	def Company.set_company_queue_name queue_name
		SF.execute_script do
			find($company_queue_name).set queue_name
		end
	end
# Get company details
# get company name
	def Company.get_company_name
		return find(:xpath , $company_name_value).text
	end
# get company suspense gla
	def Company.get_suspense_gla
		return find(:xpath, $company_suspense_gla_value).text
	end 
# get company retained earnings gla
	def Company.get_retained_earnings_gla
		return find(:xpath, $company_retained_earnings_gla_value).text
	end 
# get company year end mode
	def Company.get_year_end_mode
		return find(:xpath, $company_year_end_mode_value).text
	end
## Buttons	
# click Save button
	def Company.click_save_button
		SF.click_button_save
		SF.wait_for_search_button
	end
# click continue button
	def Company.click_continue_button
		find($company_continue_button).click
		SF.wait_for_search_button
	end
# click Activate button	
	def Company.click_activate_button
		SF.click_action $company_activate_button_label
		SF.wait_for_search_button
	end
# click Activate Company button	
	def Company.click_activate_company_button
		SF.click_button $company_activate_company_button_label
		gen_wait_until_object $company_go_back_button_locator
	end
# get company name
	def Company.get_name 
		return find($company_name).text
	end
end
