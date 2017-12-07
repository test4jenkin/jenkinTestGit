 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BA
extend Capybara::DSL
#############################
# bank account (VF pages)
#############################
#############################
# Selectors
#############################
#bank account
$ba_bankstatementdef_bank_account = "//label[text()='Bank Account']/../following-sibling::td//div//span//input"
$ba_bankstatementdef_file_delimiter = "//td//label[text()='File Delimiter']/../following-sibling::td//div//span//select"
$ba_bankstatementdef_dropdown_option_pattern_pattern = "//option[text()='"+$sf_param_substitute+"']"
$ba_bankstatementdef_date_format = "//td//label[text()='Date Format']/../following-sibling::td//div//span//select"
$ba_bankstatementdef_payment_receipt_format = "//td//label[text()='Payment/Receipt Format']/../following-sibling::td//div//span//select"
$ba_bankstatementdef_thousands_separator = "//td//label[text()='Thousands Separator']/../following-sibling::td//span//select"
$ba_bankstatementdef_decimal_separator = "//td//label[text()='Decimal Separator']/../following-sibling::td//span//select//option[text()='"+$sf_param_substitute+"']"
$ba_bankstatementdef_start_row_label = "Start Row"
$ba_bankstatementdef_maximum_number_of_decimals_label = "Maximum Number of Decimals"
$ba_bankstatementdef_date_position = "Date Position"
$ba_bankstatementdef_ref_position = "Reference Position"
$ba_bankstatementdef_description_position = "Description Position"
$ba_bankstatementdef_amount_position = "Amount Position"
$ba_bankstatementdef_save_button = "input[value=' Save ']"
$ba_bankstatementdef_name = "//h2[@class='pageDescription'] | //th[text()='Bank Statement Definition Name']/ancestor::table/tbody/tr/th//a"
$ba_file_delimiter_label = "File Delimiter"
$ba_date_format_label = "Date Format"
$ba_payment_receipt_format_label = "Payment/Receipt Format"
$ba_thousand_separator_label = "Thousands Separator"
$ba_new_bank_statement_definition_button = "input[title='New Bank Statement Definition'] , article[class*='Bank Statement Definitions'] a[title='New'] div"
$bd_bank_account_commonwealth_curr_account = "//span[contains(text(), '"+$sf_param_substitute+"')] | //a[contains(text(), '"+$sf_param_substitute+"')]"
# Labels
$bank_account_file_delimiter_label = "File Delimiter"
$bank_account_date_format_label = "Date Format"
$bank_account_payment_receipt_format_label = "Payment/Receipt Format"
$bank_account_thousand_separator_label = "Thousands Separator"
$ba_sort_code_label = "Sort Code"
$ba_swift_number_label = "SWIFT Number"
$ba_iban_label = "IBAN"
$ba_direct_debit_originator_reference_label = "Direct Debit Originator Reference"
$ba_decimal_separator_label = "Decimal Separator"

# Methods
# set bank statement definition name
	def BA.bankstatementdef_set_bankaccount bank_acc
		find(:xpath,$ba_bankstatementdef_bank_account).set bank_acc
	end 
# select file delimiter
	def BA.bankstatementdef_set_file_delimiter file_delimiter
		SF.select_value $ba_file_delimiter_label, file_delimiter
	end
# set date format for bank statement definition
	def BA.bankstatementdef_set_date_format date_format
		SF.select_value $ba_date_format_label, date_format
	end
# set payment receipt format for bank statement definition
	def BA.bankstatementdef_set_payment_receipt_format payment_receipt_format
		SF.select_value $bank_account_payment_receipt_format_label, payment_receipt_format
	end
# set thousand separator for bank statement definition
	def BA.bankstatementdef_set_thousands_separator thousands_separator
		element_id = find(:field_by_label,$bank_account_thousand_separator_label)[:for]
		select(thousands_separator , :from => element_id)
	end
# set decimal separator for bank statement definition
	def BA.bankstatementdef_set_decimal_separator decimal_separator
		SF.select_value $ba_decimal_separator_label, decimal_separator
	end 
# set start row for bank statement definition
	def BA.bankstatementdef_set_start_row start_row
		fill_in $ba_bankstatementdef_start_row_label ,:with => start_row
	end 
# set max number of decimals for bank statement definition
	def BA.bankstatementdef_set_max_num_of_decimals max_num_of_decimals
		fill_in $ba_bankstatementdef_maximum_number_of_decimals_label ,:with => max_num_of_decimals
	end 
# set date position for bank statement definition
	def BA.bankstatementdef_set_date_position date_position
		fill_in $ba_bankstatementdef_date_position ,:with => date_position
	end 	
# set ref-position for bank statement definition
	def BA.bankstatementdef_set_ref_position ref_position
		fill_in $ba_bankstatementdef_ref_position ,:with => ref_position
	end 
# set description for bank statement definition	
	def BA.bankstatementdef_set_description_position description_position
		fill_in $ba_bankstatementdef_description_position ,:with => description_position
	end 
# set amount position for bank statement definition	
	def BA.bankstatementdef_set_amount_position amount_position
		fill_in $ba_bankstatementdef_amount_position ,:with => amount_position
	end 
# click on save button for bank statement definition
	def BA.bankstatementdef_click_save_button
		SF.click_button_save
		SF.wait_for_search_button
	end
# click new button to create bank statement definition
	def BA.bankstatementdef_click_button_new
		SF.on_related_list do		
			find($ba_new_bank_statement_definition_button).click				
		end		
	end	
# select bank account name
	def BA.select_bank_account bankaccount_name
		SF.click_link bankaccount_name
		page.has_text?(bankaccount_name)
	end
#click on bank account from the list view
	def BA.click_on_bank_account_from_list_view bankaccount_name
		SF.retry_script_block do
			find(:xpath ,$bd_bank_account_commonwealth_curr_account.gsub($sf_param_substitute,bankaccount_name)).click	
		end
		page.has_text?(bankaccount_name)
	end
# set bank account sort code
	def BA.set_sort_code sort_code_value
		fill_in $ba_sort_code_label, :with => sort_code_value
	end
# set bank account swift number
	def BA.set_swift_number swift_number
		fill_in $ba_swift_number_label, :with => swift_number
	end
# Set bank account iban number
	def BA.set_iban iban_number
		fill_in $ba_iban_label, :with => iban_number
	end
# set bank account direct debit originator refernce
	def BA.set_direct_debit_originator_ref debit_originator_ref
		fill_in $ba_direct_debit_originator_reference_label, :with => debit_originator_ref
	end
# get bank statement definition name
	def BA.get_bankstatement_definition_name
		find(:xpath, $ba_bankstatementdef_name).text
	end
end	
