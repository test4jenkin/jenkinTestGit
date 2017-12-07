#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Avalara_Settings
extend Capybara::DSL
################################
# Selectors
################################
	$avalara_settings_account_no_textbox = "//td[text()='Account #:']/following-sibling::td[1]/input"
	$avalara_settings_license_key = "//td[text()='License Key:']/following-sibling::td[1]/input"
	$avalara_settings_service_url = "//td[text()='Service URL:']/following-sibling::td[1]/input"
	$avalara_settings_company_code = "//td[text()='Company Code:']/following-sibling::td[1]/input"
	$avalara_settings_avatax_timeout = "//td[text()='AvaTax Timeout(ms):']/following-sibling::td[1]//input"
	$avalara_settings_disable_address_validation = "//td[text()='Disable Address Validation:']/following-sibling::td[1]//input"
	$avalara_settings_disable_tax_calculation = "//td[text()='Disable Tax Calculation:']/following-sibling::td[1]//input"
	$avalara_settings_enable_automatic_tax_calculation_quote = "//td[text()='Enable Automatic Tax Calculation - Quote:']/following-sibling::td[1]//input"
	$avalara_settings_enable_automatic_tax_calculation_sales_order = "//td[text()='Enable Automatic Tax Calculation - Sales Order:']/following-sibling::td[1]//input"
	$avalara_settings_enable_automatic_tax_calculation_invoice = "//td[text()='Enable Automatic Tax Calculation - Invoice:']/following-sibling::td[1]//input"
	$avalara_settings_enable_automatic_tax_calculation_voucher = "//td[text()='Enable Automatic Tax Calculation - Voucher:']/following-sibling::td[1]//input"
	$avalara_settings_tax_code_freight = "//td[text()='Tax Code - Freight:']/following-sibling::td[1]//input"
	$avalara_settings_tax_code_misc = "//td[text()='Tax Code - Miscellaneous:']/following-sibling::td[1]//input"
	$avalara_settings_return_validated_address_in_upper_case = "//td[text()='Return validated address in Upper case:']/following-sibling::td[1]//input"
	$avalara_settings_vat_id_field = "//td[text()='VAT ID Field:']/following-sibling::td[1]//input"
	$avalara_settings_enable_logging = "//td[text()='Enable Logging:']/following-sibling::td[1]//input"
	$avalara_settings_edit_button = "input[name$=':editButton']"

	$avalara_settings_org_address_edit_button = "input[name$=':editAddressButton']"
	$avalara_settings_org_address_name_input = "//td[text()='Name:']/following-sibling::td[1]//input"
	$avalara_settings_org_address_street_input = "//td[text()='Street:']/following-sibling::td[1]//textarea"
	$avalara_settings_org_address_city_input = "//td[text()='City:']/following-sibling::td[1]//input"
	$avalara_settings_org_address_state_input = "//td[text()='State:']/following-sibling::td[1]//input"
	$avalara_settings_org_address_postal_zip_input = "//td[text()='Postal/Zip Code:']/following-sibling::td[1]//input"
	$avalara_settings_org_address_country_input = "//td[text()='Country:']/following-sibling::td[1]//input"


	#Set account Number 
	def Avalara_Settings.set_account_number account_number
		SF.retry_script_block do
			find(:xpath, $avalara_settings_account_no_textbox).set account_number
		end
	end

	#Set license_key
	def Avalara_Settings.set_license_key _license_key
		SF.retry_script_block do
			find(:xpath, $avalara_settings_license_key).set _license_key
		end
	end

	#Set service url
	def Avalara_Settings.set_service_url service_url
		SF.retry_script_block do
			find(:xpath, $avalara_settings_service_url).set service_url
		end
	end

	#Set company code
	def Avalara_Settings.set_company_code company_code
		SF.retry_script_block do
			find(:xpath, $avalara_settings_company_code).set company_code
		end
	end

	#Set avatax timeout
	def Avalara_Settings.set_avatax_timeout avatax_timeout
		SF.retry_script_block do
			find(:xpath, $avalara_settings_avatax_timeout).set avatax_timeout
		end
	end

	#check disable address validation check box
	def Avalara_Settings.check_disable_address_validation
		SF.retry_script_block do
			find(:xpath, $avalara_settings_disable_address_validation).set(true)
		end
	end

	#check disable tax calculation check box
	def Avalara_Settings.check_disable_tax_calculation
		SF.retry_script_block do
			find(:xpath, $avalara_settings_disable_tax_calculation).set(true)
		end
	end

	#check enable automatic tax calculation quote check box
	def Avalara_Settings.check_enable_automatic_tax_calculation_quote
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_quote).set(true)
		end
	end

	#check enable automatic tax calculation sales order check box
	def Avalara_Settings.check_enable_automatic_tax_calculation_sales_order
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_sales_order).set(true)
		end
	end

	#check enable automatic tax calculation invoice check box
	def Avalara_Settings.check_enable_automatic_tax_calculation_invoice
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_invoice).set(true)
		end
	end

	#check enable automatic tax calculation voucher check box
	def Avalara_Settings.check_enable_automatic_tax_calculation_voucher
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_voucher).set(true)
		end
	end

	#check disable address validation check box
	def Avalara_Settings.uncheck_disable_address_validation
		SF.retry_script_block do
			find(:xpath, $avalara_settings_disable_address_validation).set(false)
		end
	end

	#uncheck disable tax calculation check box
	def Avalara_Settings.uncheck_disable_tax_calculation
		SF.retry_script_block do
			find(:xpath, $avalara_settings_disable_tax_calculation).set(false)
		end
	end

	#uncheck enable automatic tax calculation quote check box
	def Avalara_Settings.uncheck_enable_automatic_tax_calculation_quote
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_quote).set(false)
		end
	end

	#uncheck enable automatic tax calculation sales order check box
	def Avalara_Settings.uncheck_enable_automatic_tax_calculation_sales_order
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_sales_order).set(false)
		end
	end

	#uncheck enable automatic tax calculation invoice check box
	def Avalara_Settings.uncheck_enable_automatic_tax_calculation_invoice
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_invoice).set(false)
		end
	end

	#uncheck enable automatic tax calculation voucher check box
	def Avalara_Settings.uncheck_enable_automatic_tax_calculation_voucher
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_automatic_tax_calculation_voucher).set(false)
		end
	end

	#Set tax code freight
	def Avalara_Settings.set_tax_code_freight tax_code_freight
		SF.retry_script_block do
			find(:xpath, $avalara_settings_tax_code_freight).set tax_code_freight
		end
	end

	#Set tax code Miscellaneous
	def Avalara_Settings.set_tax_code_miscellaneous tax_code_miscellaneous
		SF.retry_script_block do
			find(:xpath, $avalara_settings_tax_code_misc).set tax_code_miscellaneous
		end
	end

	#uncheck return validated address in upper case check box
	def Avalara_Settings.uncheck_return_validated_address_in_upper_case
		SF.retry_script_block do
			find(:xpath, $avalara_settings_return_validated_address_in_upper_case).set(false)
		end
	end

	#Set vat id ield
	def Avalara_Settings.set_vat_id_field vat_id_field_value
		SF.retry_script_block do
			find(:xpath, $avalara_settings_vat_id_field).set vat_id_field_value
		end
	end

	#check enable logging checkbox
	def Avalara_Settings.check_enable_logging
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_logging).set(true)
		end
	end
	
	#uncheck enable logging checkbox
	def Avalara_Settings.uncheck_enable_logging
		SF.retry_script_block do
			find(:xpath, $avalara_settings_enable_logging).set(false)
		end
	end

	#click Organisation address edit button
	def Avalara_Settings.click_edit_button
		SF.retry_script_block do
			find($avalara_settings_edit_button).click
			SF.wait_for_search_button
		end
	end

	########################
	# Organization Address #
	########################
	#click Organisation address edit button
	def Avalara_Settings.click_orgnization_address_edit_button
		SF.retry_script_block do
			find($avalara_settings_org_address_edit_button).click
			SF.wait_for_search_button
		end
	end

	#Set Organization Address Name
	def Avalara_Settings.set_orgnization_address_name  name
		SF.retry_script_block do
			find(:xpath, $avalara_settings_org_address_name_input).set name
		end
	end

	#Set Organization Address street
	def Avalara_Settings.set_orgnization_address_street  street
		SF.retry_script_block do
			find(:xpath, $avalara_settings_org_address_street_input).set street
		end
	end

	#Set Organization Address city
	def Avalara_Settings.set_orgnization_address_city city
		SF.retry_script_block do
			find(:xpath, $avalara_settings_org_address_city_input).set city
		end
	end

	#Set Organization Address state
	def Avalara_Settings.set_orgnization_address_state state
		SF.retry_script_block do
			find(:xpath, $avalara_settings_org_address_state_input ).set state
		end
	end

	#Set Organization Address postal_zip
	def Avalara_Settings.set_orgnization_address_postal_zip postal_zip
		SF.retry_script_block do
			find(:xpath, $avalara_settings_org_address_postal_zip_input  ).set postal_zip
		end
	end

	#Set Organization Address country
	def Avalara_Settings.set_orgnization_address_country country
		SF.retry_script_block do
			find(:xpath, $avalara_settings_org_address_country_input  ).set country
		end
	end
end