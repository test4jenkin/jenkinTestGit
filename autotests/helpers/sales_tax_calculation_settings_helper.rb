 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SalesTaxCalc
extend Capybara::DSL
#####################################
# Sales Tax Calculation Settings
#####################################

###################################################
# Selectors
###################################################

$stc_enable_external_sales_tax_calc = "//label[text()='Enable External Tax Calculation']/../following-sibling::td/input"
$stc_account_number = "//label[text()='Account Number']/../following-sibling::td[1]/input"
$stc_connection_url = "//label[text()='Connection URL']/../following-sibling::td/input"
$stc_license_key = "//*[@type='password']"
$stc_summary_tax_code = "//label[text()='Summary Tax Code']/../following-sibling::td/input"
$stc_record_full_sales_tax_details = "//label[text()='Record Full Tax Details']/../following-sibling::td/input"
$stc_address_validation_contry_code_filter = "//label[text()='Address Validation Country Code Filter']/../following-sibling::td/textarea"

#methods
#Sales Tax Calculation Settings feilds setup
	def SalesTaxCalc.set_enable_external_sales_tax_calculation is_checked
		SF.execute_script do
			if is_checked == "true"
				find(:xpath,$stc_enable_external_sales_tax_calc).set(true)
			else 
				find(:xpath,$stc_enable_external_sales_tax_calc).set(false)
			end
		end
	end
	
	def SalesTaxCalc.set_account_number acc_number
		SF.execute_script do
			find(:xpath,$stc_account_number).set(acc_number)
		end
	end
	
	def SalesTaxCalc.set_connection_url url
		SF.execute_script do
			find(:xpath,$stc_connection_url).set(url)
		end
	end
	
	def SalesTaxCalc.set_license_key license_key
		SF.execute_script do
			find(:xpath,$stc_license_key).set(license_key)
		end
	end	
	
	def SalesTaxCalc.set_summary_tax_code summary_tax_code
		SF.execute_script do
			find(:xpath,$stc_summary_tax_code ).set(summary_tax_code)
		end
	end		
	
	def SalesTaxCalc.set_record_full_sales_tax_details is_checked
		SF.execute_script do
			if is_checked == "true"
				find(:xpath,$stc_record_full_sales_tax_details).set(true)
			else 
				find(:xpath,$stc_record_full_sales_tax_details).set(false)
			end
		end
	end
	
	def SalesTaxCalc.set_address_validation_filter code_filter
		SF.execute_script do
			find(:xpath,$stc_address_validation_contry_code_filter).set(code_filter)
		end
	end
end	