 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module CE
extend Capybara::DSL
#############################
# cash enry (VF pages)
#############################

#############################
# Cash Entry selectors
#############################
$cashentry_bank_account = "input[id$='bankAccount']"
$cashentry_currency = "input[id$='cashentrycurrency']"
$cashentry_payment_method = "[id$='paymentMethod']"
$cashentry_date = "[id$='cashEntryDate']"
$cashentry_type = "select[id$=':cashEntryType']"
$cashentry_account = "[id$='accountName']"
$cashentry_decsription = "textarea[id*='cashEntryDetail']"
$cashentry_header_cashentry_value = "span[id$=':cashValue']"
$cashentry_header_bankaccount_value = "span[id$=':BankAccountValue']"
$cashentry_header_netvalue = "span[id$=':TotalNetValue']"
$cashentry_currency_dual_rate = "div[class$='pbSubsection'] input[id$=':dualRate']"
$cashentry_line_cashentry_value = ":CashEntryValue"
$cashentry_currency_lookup = "a[title='Cash Entry Currency Lookup (New Window)']"
$currency_lookup_element = "//td[text()='"+$sf_param_substitute+"']/../th/a"
$cashentry_line_bankaccount_value = ":LineBankAccountValue"
$cashentry_number = "//h1[text()='Cash Entry']/..//h2"
$cashentry_status = "//th[text() = 'Status']/following-sibling::td[1]"
$cashentry_type_value = "//th[text() = 'Type']/following-sibling::td[1]"
$cashentry_transaction_link = "//th[text()='Transaction']/following-sibling::td[1]//a"
$cash_entry_number_link = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[text()='"+$sf_param_substitute+"']"
$cashentry_line_account_reference = "input[id$='dtLineItems:"+$sf_param_substitute+":accountReference']"
$cashentry_period = "input[id$=':period']"
$cashentry_period_lookup_icon = "a[title='Period Lookup (New Window)']"
$cashentry_bank_account_lookup_icon = "a[title='Bank Account Lookup (New Window)']"
$cashentry_bank_charges_gla = "input[id$=':chargesGLA']"
$cashentry_bank_charge = "input[id$=':ChargesAmount']"
$cashentry_line_charges = ":Charges"
$cashentry_description_amend_page = "textarea[class='largeTextArea']"
$cashentry_description_value = "//*[contains(text(),'Description')]/../following-sibling::td[1]/span"
$cashentry_transaction_value = "//th[text()='Transaction']/following-sibling::td[1]"
$cashentry_name_by_reference = "//div[contains(text(), '" + $sf_param_substitute + "')]/../..//span[contains(text(), 'CSH')] | //td[contains(text(), '" + $sf_param_substitute + "')]/..//a[contains(text(), 'CSH')]"

# cash entry line data
$cashentry_line_account_value_pattern = "span[id$='dtLineItems:"+$sf_param_substitute+":account']"
$cashentry_line_payment_method_value_pattern = "span[id$='dtLineItems:"+$sf_param_substitute+":accountPaymentMethod']" 
$cashentry_line_select_payment_method_value = "select[id$='dtLineItems:"+$sf_param_substitute+":accountPaymentMethod']"
$cashentry_line_cashentry_value_pattern = "span[id$='dtLineItems:"+$sf_param_substitute+":CashEntryValue']"
#button
$cashentry_update_button = "input[id$=':calculate']"
$cashentry_amend_document_button = "Amend Document"
# Labels
$cashentry_date_label = "Date"
$cashentry_payment_method_label = "Payment Method"
$cashentry_charges_gla_label = "Charges GLA"
$cashentry_description_label = "Description"
$cashentry_bank_charge_label = "Bank Charge"
$cashentry_dimension_1_label = "Dimension 1"
$cashentry_dimension_2_label = "Dimension 2"
$cashentry_dimension_3_label = "Dimension 3"
$cashentry_dimension_4_label = "Dimension 4"
$cashentry_bank_account_dimension_1_label = "Bank Account Dimension 1"
$cashentry_bank_account_dimension_2_label = "Bank Account Dimension 2"
$cashentry_bank_account_dimension_3_label = "Bank Account Dimension 3"
$cashentry_bank_account_dimension_4_label = "Bank Account Dimension 4"
$cashentry_account_dimension_1_label = "Account Dimension 1"
$cashentry_account_dimension_2_label = "Account Dimension 2"
$cashentry_account_dimension_3_label = "Account Dimension 3"
$cashentry_account_dimension_4_label = "Account Dimension 4"
$cashentry_cash_entry_rate_label  = "Cash Entry Rate"
$cashentry_dual_rate_label = "Dual Rate"
$cashentry_reference_label = "Reference"
$cashentry_type_label = "Type"

#############################
# Cash Entry methods
#############################

# cash entry Header

# select cash entry type
	def CE.select_cash_entry_type ce_type
		ce_type_id = find($cashentry_type)[:id]
		select(ce_type, :from => ce_type_id) 
	end
# set cash entry bank account
	def CE.set_bank_account ce_bankaccountName
		SF.execute_script do
			find($cashentry_bank_account).set ce_bankaccountName
			gen_tab_out $cashentry_bank_account
			FFA.wait_page_message $ffa_msg_retrieving_bank_account_information
		end
	end 
# select cash entry bank account from lookup
	def CE.select_bank_account_from_lookup lookup_icon_name, search_value, company_name
		SF.execute_script do
			FFA.select_bank_account_from_lookup lookup_icon_name, search_value, company_name
			gen_tab_out $cashentry_bank_account
			FFA.wait_page_message $ffa_msg_retrieving_bank_account_information
		end
	end
 
	def CE.set_currency currency,company_name		
		SF.retry_script_block do
			FFA.select_currency_from_lookup $cashentry_currency_lookup, currency, company_name
		end
		SF.execute_script do
			gen_tab_out  $cashentry_currency
			FFA.wait_page_message $ffa_msg_updating_cashentry_currency		
		end
	end 

# set dual rate for currency
	def CE.set_currency_dual_rate dual_rate
		SF.execute_script do
			SF.retry_script_block do
				FFA.click_currency_rate_toggle_icon
				find($cashentry_currency_dual_rate).set dual_rate
				FFA.click_currency_rate_toggle_icon
			end
		end
	end
	
	def CE.set_cash_entry_description description 
		SF.execute_script do
			SF.retry_script_block do
				find($cashentry_decsription).set description
			end
		end
	end
	
	def CE.set_cash_entry_description_amend_page description 
		SF.execute_script do
			SF.retry_script_block do
				find($cashentry_description_amend_page).set description
			end
		end
	end
	
	
	def CE.set_payment_method payment_method
		SF.execute_script do
			find($cashentry_payment_method).select payment_method
		end
	end 	
	
	def CE.set_date date
		SF.execute_script do
			find($cashentry_date).set date
			gen_tab_out $cashentry_date
			FFA.wait_page_message $ffa_msg_retrieving_period
		end
	end 
	
	def CE.set_reference reference_text
		SF.execute_script do
			fill_in $cashentry_reference_label, :with => reference_text
		end
	end
	
	def CE.set_bank_charges_gla gla_name
		SF.execute_script do
			find($cashentry_bank_charges_gla).set gla_name
			gen_tab_out $cashentry_bank_charges_gla
			FFA.wait_page_message $ffa_msg_retrieving_bank_charges_gla_information
		end
	end
	
	def CE.set_bank_charge bank_charge
		SF.execute_script do
			find($cashentry_bank_charge).set bank_charge
		end
	end
	
	def CE.line_set_account_name  account_name
		SF.execute_script do
			find($cashentry_account).set account_name
			gen_tab_out $cashentry_account
		end
	end	
	
	def CE.line_set_cashentryvalue line , cash_entry_value
		SF.execute_script do
			line = line - 1 ;
			field  = $doc_line_input+":#{line}"+$cashentry_line_cashentry_value+$doc_line_input_end 
			find(field).set cash_entry_value
			gen_tab_out field
		end
	end 

	def CE.line_get_line_bankaccount_value line
		SF.execute_script do
			line = line - 1 ;
			field  = $doc_line_input+":#{line}"+$cashentry_line_bankaccount_value+$doc_line_input_end
			field_value = find(field).text
			return field_value
		end
	end 

	def CE.line_set_payment_method_value line_number , payment_method
		SF.execute_script do
			line_number=line_number-1
			find($cashentry_line_select_payment_method_value.sub($sf_param_substitute , line_number.to_s)).select payment_method
		end
	end

# Set account reference	
	def CE.line_set_account_reference line, account_ref
		SF.execute_script do
			line = line - 1 ;
			find($cashentry_line_account_reference.gsub($sf_param_substitute, line.to_s)).set account_ref	
		end
	end
# Set line charges	
	def CE.line_set_line_charges line, line_charges
		SF.execute_script do
			line = line-1
			field = $doc_line_input+":#{line}"+$cashentry_line_charges+$doc_line_input_end
			find(field).set line_charges
			gen_tab_out field
		end
	end
	
# get cash Entry header details
	def CE.get_cash_entry_number
		SF.execute_script do
			return find(:xpath,$cashentry_number).text
		end
	end
	
	def CE.get_bank_account_name
		SF.execute_script do
			return find($cashentry_bank_account).value
		end
	end 
	
	def CE.get_cashentry_type_value 
		SF.execute_script do
			return find(:xpath , $cashentry_type_value).text
		end
	end
	
	def CE.get_cashentry_bankaccount_value
		SF.execute_script do
			return find($cashentry_header_bankaccount_value).text
		end
	end
	
	def CE.get_cashentry_value 
		SF.execute_script do
			return find($cashentry_header_cashentry_value).text
		end
	end
	
	def CE.get_cashentry_total_netvalue 
		SF.execute_script do
			return find($cashentry_header_netvalue).text
		end
	end

## get cash entry line data
# get line account value
	def CE.get_line_cashentry_account line_number
		SF.execute_script do
			line_number = line_number-1
			return find($cashentry_line_account_value_pattern.sub($sf_param_substitute , line_number.to_s)).text
		end
	end
# get line payment method value
	def CE.get_line_cashentry_payment_method line_number
		SF.execute_script do
			line_number = line_number-1
			return find($cashentry_line_payment_method_value_pattern.sub($sf_param_substitute , line_number.to_s)).text
		end
	end
# get line payment method value
	def CE.get_line_cashentry_value line_number
		SF.execute_script do
			line_number = line_number-1
			return find($cashentry_line_cashentry_value_pattern.sub($sf_param_substitute , line_number.to_s)).text
		end
	end

# open cash entry  detail page
	def CE.open_cash_entry_detail_page cashentry_number		
		find(:xpath , $cash_entry_number_link.gsub($sf_param_substitute, cashentry_number.to_s)).click
		page.has_text?(cashentry_number)		
	end

# get cash entry name Reference
	def CE.get_cash_entry_name_by_reference reference
		cashentry_to_click = $cashentry_name_by_reference.gsub($sf_param_substitute, reference)
		return find(:xpath , cashentry_to_click).text
	end

# click on Transaction lin on cash entry detail page
	def CE.click_transaction_link
		SF.execute_script do
			find(:xpath , $cashentry_transaction_link).click
		end
	end

# get Cash Entry Status status
	def CE.get_cash_entry_status
		SF.execute_script do
			return find(:xpath , $cashentry_status).text
		end
	end
# Buttons
# cash entry 
	def CE.click_update
		SF.execute_script do
			find($cashentry_update_button).click
			FFA.wait_page_message  $ffa_msg_calculating_value
		end
	end

# get cash entry period value
	def CE.get_cashentry_period
		SF.execute_script do
			return find($cashentry_period)[:value]
		end
	end
#####################################################	
# For Standard UI
#####################################################
	def CE.set_date_for_standard date
		fill_in $cashentry_date_label, :with => date
	end
	
	def CE.set_reference_for_standard reference_text
		fill_in $cashentry_reference_label, :with => reference_text
	end
	
	def CE.set_payment_method_for_standard payment_method
		select payment_method, :from => $cashentry_payment_method_label
	end
	
	def CE.set_charges_gla_for_standard gla_name
		fill_in $cashentry_charges_gla_label, :with => gla_name
	end
	
	def CE.set_description_for_standard description_text
		fill_in $cashentry_description_label, :with => description_text
	end
	
	def CE.set_bank_charge_for_standard bank_charge
		fill_in $cashentry_bank_charge_label, :with => bank_charge
	end
	
	def CE.set_dimension_for_standard dimension_field, dimension_value
		fill_in dimension_field, :with => dimension_value
	end
	
	def CE.set_bank_account_dimension_for_standard bank_account_dimension_field, bank_acc_dimension_value
		fill_in bank_account_dimension_field, :with => bank_acc_dimension_value
	end
	
	def CE.set_account_dimension_for_standard account_dimension_field, account_dimension_value
		fill_in account_dimension_field, :with => account_dimension_value
	end
	
	def CE.set_cash_entry_rate_for_standard cash_entry_rate
		fill_in $cashentry_cash_entry_rate_label, :with => cash_entry_rate
	end
	
	def CE.set_dual_rate_for_standard dual_rate
		fill_in $cashentry_dual_rate_label, :with => dual_rate
	end

# get cash entry date
	def CE.get_cash_entry_date
		SF.execute_script do
			return find($cashentry_date).text
		end
	end
# get cash entry description
	def CE.get_description
		SF.execute_script do
			return find(:xpath, $cashentry_description_value).text
		end
	end
# get transaction number
	def CE.get_transaction_number
		SF.execute_script do
			return find(:xpath, $cashentry_transaction_value).text
		end
	end
end	
