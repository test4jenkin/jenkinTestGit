 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module LOCKBOX
extend Capybara::DSL

$lockbox_namespace_prefix = "fflbx__"
$lockbox_new_import_defination_button = "New Bank Lockbox Import Definition"
$lockbox_manage_import_mappings = "Manage Import Mappings"
$lockbox_new_ar_cash_transation = "New AR Cash Transaction"
$lockbox_import = "Import"
$lockbox_yes = "Yes"
$lockbox_create_cash_entry = "Create Cash Entry"
$lockbox_defination_name = "//td[text()='Name']/following-sibling::td/div" 
$lockbox_decimal_seperator = "//td[text()='Decimal Separator']/following-sibling::td/div" 
$lockbox_thousands_separator =  "//td[text()='Thousands Separator']/following-sibling::td/div" 
$lockbox_file_delimiter =  "//td[text()='File Delimiter']/following-sibling::td/div" 
$lockbox_date_format =  "//td[text()='Date Format']/following-sibling::td/div"
$lockbox_bank_account_textbox = "//label[text()='Bank Account']/../../td[2]/div/span/input"
$lockbox_unique_number_textbox = "//label[text()='Number / Wire transfer']/../../td[2]/div/input"
$lockbox_currency_textbox = "//label[text()='Currency']/.. /following-sibling::td/div/span/input"
$lockbox_matching_mode_option = "//label[text()='Matching Mode']/../../following-sibling::td/div/span/select"
$lockbox_discount_gla_input = "//label[text()='Discount GLA']/../following-sibling::td/span/input"
$lockbox_write_off_gla_input = "//label[text()='Write-off GLA']/../following-sibling::td/span/input"
$lockbox_currency_write_off_gla_input = "//label[text()='Currency Write-off GLA']/../following-sibling::td/span/input"
$lockbox_bank_charges_gla_input = "//label[text()='Bank Charges GLA']/../following-sibling::td/span/input"
$lockbox_import_defination_decimal_seperator_list = "//label[text()='Decimal Separator']/../following-sibling::td/span/select"
$lockbox_import_defination_thousand_seperator_list = "//label[text()='Thousands Separator']/../following-sibling::td/span/select"
$lockbox_import_defination_file_delimiter_list = "//label[text()='File Delimiter']/../following-sibling::td/span/select"
$lockbox_import_defination_date_format_list = "//label[text()='Date Format']/../following-sibling::td/span/select"
$lockbox_import_defination_name_label = "//td[text()='Name']/following-sibling::td/div"
$lockbox_import_defination_decimal_seperator_label = "//td[text()='Decimal Separator']/following-sibling::td/div"
$lockbox_import_defination_thousands_sepertor_label = "//td[text()='Thousands Separator']/following-sibling::td/div"
$lockbox_import_defination_file_delimeter_label = "//td[text()='File Delimiter']/following-sibling::td/div"
$lockbox_import_defination_date_format_label = "//td[text()='Date Format']/following-sibling::td/div"
$lockbox_currency_lookup_icon = "a[title='Currency Lookup (New Window)']"
$lockbox_import_mapping_input = "//td[text()='"+$sf_param_substitute+"']/following-sibling::td[1]/input"
$lockbox_import_mapping_deposite_date = "Deposit Date"
$lockbox_import_mapping_amount = "Amount"
$lockbox_import_mapping_bank_lockbox_num = "Bank Lockbox Number"
$lockbox_import_mapping_check_number = "Check Number"
$lockbox_import_mapping_remitter = "Remitter"
$lockbox_import_mapping_type = "Type"
$lockbox_import_mapping_document_ref = "Document Reference"
$lockbox_import_mapping_table_column = "//td[text()='"+$sf_param_substitute+"']/following-sibling::td[2]"
$lockbox_show_more = "//a[text()='more']"
$lockbox_chose_file_button = "input[id$='importFile']"
$lockbox_view_name = "div[id*='Name']"
$lockbox_import_definations_related_list = "//h3[text()='Bank Lockbox Import Definitions']/ancestor::div[2]"
$lockbox_ar_cash_transaction_related_list = "//h3[text()='AR Cash Transactions']/ancestor::div[2]"
$lockbox_ar_cash_transaction_line_items_related_list = "//h3[text()='AR Cash Transaction Line Items']/ancestor::div[2]"
$lockbox_ar_cash_transation_link = "//a[contains(text(),'R-00')]"
$lockbox_ar_cash_transation__line_item_link = "//a[contains(text(),'RLI-00')]"
$lockbox_ar_cash_transation_status = "//td[text()='Status']/following-sibling::td[1]/div"
$lockbox_ar_cash_transation_type = "//td[text()='Cash Entry Type']/following-sibling::td[1]/div"
$lockbox_ar_cash_transation_no_of_cash_entries = "//td[text()='Number of Cash Entries']/following-sibling::td[1]/div"
$lockbox_ar_cash_transation_total_of_cash_entries = "//td[text()='Total of Cash Entries']/following-sibling::td[1]/div"
$lockbox_create_cash_entry_lbx_only_radio_option = "input[value='"+$sf_param_substitute+"']"
$lockbox_cash_entry_for_lbx_only = "LBX Only"

#SOQL queries
$lockbox_ar_cash_transaction_details = "SELECT ID, NAME from #{$lockbox_namespace_prefix}Receipt__c WHERE #{$lockbox_namespace_prefix}Lockbox__r.Name ='"+$sf_param_substitute+"'"
$lockbox_cash_entry_details_from_ar_cash_transaction = "select Id, Name from #{ORG_PREFIX}codaCashEntry__c where #{$lockbox_namespace_prefix}Receipt__r.Name = '"+$sf_param_substitute+"'"

#unique number variable
$lockbox_unique_number = (100..999).to_a.shuffle 


	#GET lockbox name
	def LOCKBOX.get_bank_lockbox_number
		return find($lockbox_view_name).text		
	end 
	
	#set bank account name
	def LOCKBOX.set_bank_account account_name, company_name
		FFA.select_bank_account_from_lookup $pay_bank_account_lookup_icon, account_name ,company_name		
	end 

	#set unique number
	def LOCKBOX.set_unique_number unique_number
		find(:xpath, $lockbox_unique_number_textbox).set unique_number
	end 
	
	#set currency
	def LOCKBOX.set_currency currency, company_name
		FFA.select_currency_from_lookup $lockbox_currency_lookup_icon, currency, company_name		
	end 
	
	#set matching mode
	def LOCKBOX.set_matching_mode matching_mode
		find(:xpath, $lockbox_matching_mode_option).set matching_mode
	end 
	
	#set Discount GLA
	def LOCKBOX.set_discount_gla discount_gla
		find(:xpath, $lockbox_discount_gla_input).set discount_gla
	end 
	
	#set write off GLA
	def LOCKBOX.set_write_off_gla write_off_gla
		find(:xpath,$lockbox_write_off_gla_input).set write_off_gla
	end 
	
	#set currency write off gla
	def LOCKBOX.set_currency_write_off_gla currency_write_off_gla
		find(:xpath, $lockbox_currency_write_off_gla_input).set currency_write_off_gla
	end 
	
	#set bank charges gla
	def LOCKBOX.set_bank_charges_gla bank_charges_gla
		find(:xpath, $lockbox_bank_charges_gla_input).set bank_charges_gla
	end 
	
	# IMPORT DEFINATION  SET Methods
	#set import defination decimal seperator option
	def LOCKBOX.set_import_defination_decimal_seperator decimal_seperator
		find(:xpath, $lockbox_import_defination_decimal_seperator_list).select decimal_seperator
	end 
	
	#set import defination thousand seperator option
	def LOCKBOX.set_import_defination_thousand_seperator thousand_seperator
		find(:xpath, $lockbox_import_defination_thousand_seperator_list).select thousand_seperator
	end 
	
	#set import defination file delimiter option
	def LOCKBOX.set_import_defination_file_delimiter file_delimiter
		find(:xpath, $lockbox_import_defination_file_delimiter_list).select file_delimiter
	end 
	
	#set import defination date format option
	def LOCKBOX.set_import_defination_date_format date_format
		find(:xpath, $lockbox_import_defination_date_format_list).select date_format
	end 
	
	#get import defination name
	def LOCKBOX.set_import_defination_name
		return find(:xpath, $lockbox_import_defination_name_label).text
	end 
	
	# IMPORT DEFINATION  GET Methods
	#get import defination decimal_seperator
	def LOCKBOX.get_import_defination_decimal_seperator
		return find(:xpath, $lockbox_import_defination_decimal_seperator_label).text
	end 
	
	#get import defination thousands_sepertor
	def LOCKBOX.get_import_defination_thousands_sepertor
		return find(:xpath,$lockbox_import_defination_thousands_sepertor_label).text
	end 
	
	#get import defination file delimeter
	def LOCKBOX.get_import_defination_file_delimeter
		return find(:xpath,$lockbox_import_defination_file_delimeter_label).text
	end 
	
	#get import defination date format
	def LOCKBOX.get_import_defination_date_format
		return find(:xpath,$lockbox_import_defination_date_format_label).text
	end 
	
	#IMPORT MAPPINGS set Methods
	#set deposite date column number 
	def LOCKBOX.set_deposite_date_column_number number
		find(:xpath, $lockbox_import_mapping_input.gsub($sf_param_substitute, $lockbox_import_mapping_deposite_date)).set number
	end
	
	#set amount column number 
	def LOCKBOX.set_amount_column_number number
		find(:xpath, $lockbox_import_mapping_input.gsub($sf_param_substitute, $lockbox_import_mapping_amount)).set number
	end 
	
	#set bank_lockbox_number column number 
	def LOCKBOX.set_bank_lockbox_num_column_number number
		find(:xpath, $lockbox_import_mapping_input.gsub($sf_param_substitute, $lockbox_import_mapping_bank_lockbox_num)).set number
	end 
	
	#set check_number column number 
	def LOCKBOX.set_mapping_check_number_column_number number
		find(:xpath, $lockbox_import_mapping_input.gsub($sf_param_substitute, $lockbox_import_mapping_check_number)).set number
	end 
	
	#set remitter column number 
	def LOCKBOX.set_remitter_column_number number
		find(:xpath, $lockbox_import_mapping_input.gsub($sf_param_substitute, $lockbox_import_mapping_remitter)).set number
	end 
	
	#set type column number 
	def LOCKBOX.set_type_column_number number
		find(:xpath, $lockbox_import_mapping_input.gsub($sf_param_substitute, $lockbox_import_mapping_type)).set number
	end 
	
	#set document_reference column number 
	def LOCKBOX.set_document_ref_column_number number
		find(:xpath, $lockbox_import_mapping_input.gsub($sf_param_substitute, $lockbox_import_mapping_document_ref)).set number
	end
	
	#IMPORT MAPPINGS get Methods
	def LOCKBOX.get_deposite_date_column_number
		return find(:xpath, $lockbox_import_mapping_table_column.gsub($sf_param_substitute, $lockbox_import_mapping_deposite_date)).text
	end
	
	#set amount column number 
	def LOCKBOX.get_amount_column_number
		return find(:xpath, $lockbox_import_mapping_table_column.gsub($sf_param_substitute, $lockbox_import_mapping_amount)).text
	end 
	
	#set bank_lockbox_number column number 
	def LOCKBOX.get_bank_lockbox_num_column_number
		return find(:xpath, $lockbox_import_mapping_table_column.gsub($sf_param_substitute, $lockbox_import_mapping_bank_lockbox_num)).text
	end 
	
	#set check_number column number 
	def LOCKBOX.get_mapping_check_number_column_number
		return find(:xpath, $lockbox_import_mapping_table_column.gsub($sf_param_substitute, $lockbox_import_mapping_check_number)).text
	end 
	
	#set remitter column number 
	def LOCKBOX.get_remitter_column_number
		return find(:xpath, $lockbox_import_mapping_table_column.gsub($sf_param_substitute, $lockbox_import_mapping_remitter)).text
	end 
	
	#set type column number 
	def LOCKBOX.get_type_column_number
		return find(:xpath, $lockbox_import_mapping_table_column.gsub($sf_param_substitute, $lockbox_import_mapping_type)).text
	end 
	
	#set document_reference column number 
	def LOCKBOX.get_document_ref_column_number
		return find(:xpath, $lockbox_import_mapping_table_column.gsub($sf_param_substitute, $lockbox_import_mapping_document_ref)).text
	end
	
	#click button more in related list
	def LOCKBOX.click_more
	    if page.has_xpath?($lockbox_show_more)
			find(:xpath,$lockbox_show_more).click
		end
	end
	
	#get unique number
	def LOCKBOX.get_unique_number
		return $lockbox_unique_number.pop
	end
	
	#click on import button
	def LOCKBOX.click_button_import
		SF.execute_script do
			SF.click_button $lockbox_import
		end
		SF.wait_for_search_button
	end
	
	#upload given file 
	def LOCKBOX.import_ar_cash_transaction file_name_to_import
		SF.execute_script do
			element_id = find($lockbox_chose_file_button)[:id]
			FFA.upload_file element_id,file_name_to_import
		end
	end
	
	#click on recently created ar cash entry link
	def LOCKBOX.clicK_link_ar_cash_transaction
		within(:xpath,$lockbox_ar_cash_transaction_related_list) do
			find(:xpath,$lockbox_ar_cash_transation_link).click
		end
	end
	
	#get ar cash transaction status
	def LOCKBOX.get_ar_cash_trasaction_status
		SF.retry_script_block do 
			return find(:xpath, $lockbox_ar_cash_transation_status).text
		end
	end
	
	#get ar cash transaction type
	def LOCKBOX.get_ar_cash_trasaction_type
		SF.retry_script_block do 
			return find(:xpath, $lockbox_ar_cash_transation_type).text
		end
	end
	
	#get ar cash transaction no of cash_entries
	def LOCKBOX.get_ar_cash_trasaction_no_of_cash_entries
		SF.retry_script_block do 
			return find(:xpath, $lockbox_ar_cash_transation_no_of_cash_entries).text
		end
	end
	
	#get ar cash transaction Total of Cash Entries
	def LOCKBOX.get_ar_cash_trasaction_total_of_cash_entries
		SF.retry_script_block do 
			return find(:xpath, $lockbox_ar_cash_transation_total_of_cash_entries).text
		end
	end	
	
	#select radio option for create cash entry
	def LOCKBOX.select_cash_enrtry_radio_option option_text
		SF.retry_script_block do 
			find($lockbox_create_cash_entry_lbx_only_radio_option.gsub($sf_param_substitute,option_text)).click
		end
	end
	
	#get ar cash transaction details using soql
	#_lockbox_number - lockbox name 
	def LOCKBOX.get_ar_cash_transaction_details _lockbox_number
		SF.retry_script_block do 
			APEX.execute_soql $lockbox_ar_cash_transaction_details.gsub($sf_param_substitute, _lockbox_number )
			_ar_cash_trans_id = APEX.get_field_value_from_soql_result $sa_id
			_ar_cash_trans_name = APEX.get_field_value_from_soql_result $sa_name
			return _ar_cash_trans_id, _ar_cash_trans_name
		end
	end
	
	#get cash entry details from ar cash transaction 
	#ar_cash_transaction_name - Name of AR cash transaction associated with lockbox
	def LOCKBOX.get_cash_entry_details_from_ar_cash_transaction ar_cash_transaction_name 
		SF.retry_script_block do 
			APEX.execute_soql $lockbox_cash_entry_details_from_ar_cash_transaction.gsub($sf_param_substitute, ar_cash_transaction_name)
			_ar_cash_entry_id = APEX.get_field_value_from_soql_result $sa_id
			_ar_cash_entry_name = APEX.get_field_value_from_soql_result $sa_name
			return _ar_cash_entry_id, _ar_cash_entry_name		
		end
	end
end