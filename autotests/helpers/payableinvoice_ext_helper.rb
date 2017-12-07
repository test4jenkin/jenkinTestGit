 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module PINEXT 
extend Capybara::DSL
###################################################
# Selectors 
###################################################
$pinext_invoice_status_value = "//td[text()='Invoice Status']/following-sibling::td[1]/div | //span[text()='Invoice Status']/ancestor::div[1]/following::div[1]/div[1]/span"
$pinext_payable_invoice_number_value = "//td[text()='Payable Invoice Number']/following-sibling::td[1]/div | //span[text()='Payable Invoice Number']/ancestor::div[1]/following::div[1]/div[1]/span"
$pinext_payable_invoice_number_link = "//td[text()='Payable Invoice Number']/following-sibling::td[1]/div/a | //span[text()='Payable Invoice Number']/ancestor::div[1]/following::div[1]/div/div/a"
$pinext_payable_invoice_line_item_id = "//td[text()='Payable Invoice Line Item ID']/following-sibling::td[1]"
$pinext_manage_product_line_product_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"Product__c"
$pinext_manage_product_line_quantity_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"Quantity__c"
$pinext_manage_product_line_unit_price_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"UnitPrice__c"
$pinext_manage_line_input_tax_code_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"InputVATCode__c"
$pinext_manage_line_input_tax_code_lookup_icon_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") a[title='Input Tax Code Lookup (New Window)']"
$pinext_manage_line_combined_tax_code_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"TaxCodeCombined__c"
$pinext_manage_line_tax_value_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"TaxValue1__c"
$pinext_manage_expense_line_gla_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"GeneralLedgerAccount__c"
$pinext_manage_expense_line_net_value_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"NetValue__c"
$pinext_manage_product_line_net_value_pattern = "//tr["+$sf_param_substitute+"]//div[@class='"+ORG_PREFIX+"NetValue__c DOUBLE cellInnerText'][text()='"+$sf_param_substitute+"']"
$pinext_period_link = "//td[text()='Period']/following-sibling::td[1]/div/a"
$pinext_invoice_currency_link = "//td[text()='Invoice Currency']/following-sibling::td[1]/div/a"
$pinext_company_value = "//td[text()='Company']/following-sibling::td[1]/div"
$pinext_company = "//label[text()='Company']"
$pinext_error_message = "div.message.errorM3"
$pinext_expense_line_item_section = "//h3[text()='Payable Invoice Expense Line Items']//ancestor::div[2] | //table[@class='forceRecordLayout uiVirtualDataGrid--default uiVirtualDataGrid']/tbody"
$pinext_product_line_item_section = "//h3[text()='Payable Invoice Line Items']//ancestor::div[2] | //table[@class='forceRecordLayout uiVirtualDataGrid--default uiVirtualDataGrid']/tbody"
$pinext_net_value = "//label[text() = 'Net Value']/ancestor::td[1]/following::td[1]/div/input | //span[text()='Net Value']/ancestor::label[1]/following::input[1]"
$pinext_net_total = "//td[text() = 'Net Total']/following-sibling::td[1]/div | //span[text()='Net Total']/ancestor::div[1]/following::div[1]/div[1]/span"
$pinext_tax_total = "//td[text() = 'Tax Total']/following-sibling::td[1]/div | //span[text()='Tax Total']/ancestor::div[1]/following::div[1]/div[1]/span"
$pinext_invoice_total = "//td[text() = 'Invoice Total']/following-sibling::td[1]/div | //span[text()='Invoice Total']/ancestor::div[1]/following::div[1]/div[1]/span"
$pinext_ajax_process_image_locator = "input[class*='ajax']"
# Labels
$pinext_account_label = "Account"
$pinext_copy_account_values_label = "Copy Account Values"
$pinext_derive_due_date_label = "Derive Due Date"
$pinext_due_date_label = "Due Date"
$pinext_derive_period_label = "Derive Period"
$pinext_derive_currency_label = "Derive Currency"
$pinext_vendor_invoice_number_label = "Vendor Invoice Number"
$pinext_invoice_date_label = "Invoice Date"
$pinext_product_label = "Product"
$pinext_derive_unit_price_from_product_label = "Derive Unit Price from Product"
$pinext_quantity_label = "Quantity"
$pinext_set_tax_code_to_default_label = "Set Tax Code to Default"
$pinext_derive_tax_rate_from_code_label = "Derive Tax Rate from Code"
$pinext_calculate_tax_value_from_rate_label = "Calculate Tax Value from Rate"
$pinext_tax_value_label = "Tax Value"
$pinext_derive_line_number_label = "Derive Line Number"
$pinext_net_value_label = "Net Value"
$pinext_set_gla_to_default_label = "Set GLA to Default"
$pinext_input_tax_code_label = "Input Tax Code"
$pinext_combined_tax_code_label = "Combined Tax Code"
$pinext_company_label = "Company"
$pinext_general_ledger_account_label = "General Ledger Account"
$pinext_unit_price_label = "Unit Price"
$pinext_manage_line_new_line_locator = "input[class='newlinebutton addLine']"
# Buttons
$pinext_new_payable_invoice_line_item_button = "input[value='New Payable Invoice Line Item'] , article[aria-describedby='title#{ORG_PREFIX}PurchaseInvoiceLineItems__r'] div a[title='New']"
$pinext_new_payable_invoice_expense_line_item_button = "input[value='New Payable Invoice Expense Line Item'] , article[aria-describedby='title#{ORG_PREFIX}PurchaseInvoiceExpenseLineItems__r'] div a[title='New']"
$pinext_manage_product_lines_button = "Manage Product Lines"
$pinext_add_new_line_button = "New Line"
$pinext_manage_expense_lines_button = "Manage Expense Lines"
$pinext_convert_to_credit_note = "Convert to Credit Note"
$pinext_convert_to_credit_note_confirm = "Convert to Credit Note" 
#Lightning specific
$pinext_view_invoice_line_items_link = "//article[@aria-describedby='title#{ORG_PREFIX}PurchaseInvoiceLineItems__r']//span[text()='View All']"
$pinext_view_invoice_expense_line_items_link = "//article[@aria-describedby='title#{ORG_PREFIX}PurchaseInvoiceExpenseLineItems__r']//span[text()='View All']"
$pinext_view_all_product_line_item_link = "article[aria-describedby='title#{ORG_PREFIX}PurchaseInvoiceLineItems__r'] span[class='view-all-label']"
$pinext_view_all_expense_line_item_link = "article[aria-describedby='title#{ORG_PREFIX}PurchaseInvoiceExpenseLineItems__r'] span[class='view-all-label']"
$pinext_line_item_pattern = "//a[@title='"+$sf_param_substitute+"']/ancestor::tr[1]/th[1]/a"
$pinext_related_list_invoice_link = "//div[text()='Payable Invoices']/ancestor::a[1]/following::a[1]"	

# Methods

# Set Account
	def PINEXT.set_account account_name
		SF.fill_in_lookup $pinext_account_label, account_name
	end
# Set copy account values checkbox
	def PINEXT.set_copy_account_values checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_copy_account_values_label)
		else
			uncheck($pinext_copy_account_values_label)
		end
	end
# Set Derive Due Date checkbox
	def PINEXT.set_derive_due_date checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_derive_due_date_label)
		else
			uncheck($pinext_derive_due_date_label)
		end
	end
# Set due date
	def PINEXT.set_due_date due_date_value
		fill_in $pinext_due_date_label, :with => due_date_value
	end
# Set derive period checkbox
	def PINEXT.set_derive_period checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_derive_period_label)
		else
			uncheck($pinext_derive_period_label)
		end
	end
# Set derive currency checkbox
	def PINEXT.set_derive_currency checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_derive_currency_label)
		else
			uncheck($pinext_derive_currency_label)
		end
	end
# Set vendor invoice number
	def PINEXT.set_vendor_invoice_number vendor_invoice_number
		fill_in $pinext_vendor_invoice_number_label, :with => vendor_invoice_number
	end
# Set invoice date
	def PINEXT.set_invoice_date invoice_date
		fill_in $pinext_invoice_date_label, :with => invoice_date
	end
# Set company
	def PINEXT.set_company company_name
		company_id = find(:xpath,$pinext_company)[:for]				
		fill_in(company_id , :with => company_name)	
	end
	
# click manage product lines button 
	def PINEXT.click_manage_product_lines_button
		SF.click_action $pinext_manage_product_lines_button
		gen_wait_until_object $pinext_manage_line_new_line_locator
	end
# click manage expense lines button 
	def PINEXT.click_manage_expense_lines_button
		SF.click_action $pinext_manage_expense_lines_button
		gen_wait_until_object $pinext_manage_line_new_line_locator
	end
	
	def PINEXT.click_post_invoice
		first(:button, $ffa_post_invoices_button).click
		SF.wait_for_search_button
	end
	
	#click on convert to credit note
	 def PINEXT.convert_to_credit_note
		SF.click_action $pinext_convert_to_credit_note
		SF.wait_for_search_button
	 end
	
	#To confirm purchase invoice to credit note conversion
	def PINEXT.convert_to_credit_note_confirm
		SF.execute_script do
			click_button($pinext_convert_to_credit_note_confirm)
		end
		SF.wait_for_search_button
	end

# Get invoice number
	def PINEXT.get_invoice_number
		return find(:xpath, $pinext_payable_invoice_number_value).text
	end
# Get invoice status
	def PINEXT.get_invoice_status
		return find(:xpath, $pinext_invoice_status_value).text
	end
# Get company
	def PINEXT.get_company
		return find(:xpath, $pinext_company_value).text
	end	
	
	# get Net Total 
	def PINEXT.get_net_total
	    return find(:xpath , $pinext_net_total).text
	end
	
	# get Tax Total 
	def PINEXT.get_tax_total
	    return find(:xpath , $pinext_tax_total).text
	end
	
	# get Invoice Total 
	def PINEXT.get_invoice_total
	    return find(:xpath , $pinext_invoice_total).text
	end
	
# Click invoice period link
	def PINEXT.click_period_link
		find(:xpath, $pinext_period_link).click
	end
# Click invoice currency link
	def PINEXT.click_invoice_currency
		find(:xpath, $pinext_invoice_currency_link).click
	end
# get error message on post
	def PINEXT.get_error_message_on_post
		return find($pinext_error_message).text
	end
	
# click on button on payable invoice extended layout on related list
	def PINEXT.click_new_payable_invoice_line_item_button
		SF.on_related_list do
			page.has_css?($pinext_new_payable_invoice_line_item_button)
			find($pinext_new_payable_invoice_line_item_button).click
		end
	end
	
	# click on button on payable invoice extended layout on related list
	def PINEXT.click_new_payable_invoice_expense_line_item_button
		SF.on_related_list do
			page.has_css?($pinext_new_payable_invoice_expense_line_item_button)
			find($pinext_new_payable_invoice_expense_line_item_button).click
		end
	end
	
	# get payable invoice number value from product line item detail page
	# pass the product name as parameter
	def PINEXT.product_line_item_get_payable_invoice_number product_name
		PINEXT.on_product_line_item do
			if (SF.org_is_lightning)
				find(:xpath,$pinext_line_item_pattern.sub($sf_param_substitute,product_name)).click
			end
			return find(:xpath, $pinext_payable_invoice_number_link).text
		end
	end
	
	# get payable invoice number value from expense line item detail page
	# pass the tax code name as parameter
	def PINEXT.expense_line_item_get_payable_invoice_number gla_name
		PINEXT.on_expense_line_item do
			if (SF.org_is_lightning)
				find(:xpath,$pinext_line_item_pattern.sub($sf_param_substitute,gla_name)).click
			end
			return find(:xpath, $pinext_payable_invoice_number_link).text
		end
	end
	
	# Execute the passed block on of code on line item detail page.
	# on lightning org, user will be redirected to line item detail page before the block of code is executed.
	def PINEXT.within_product_line_section (&block)
		PINEXT.on_product_line_item do
			block.call()
		end
		# Navigate user to detal page of payable invoice
		if (SF.org_is_lightning)
			find(:xpath, $pinext_related_list_invoice_link).click
		end
	end
	
	
	# Execute the passed block on of code on line item detail page.
	# on lightning org, user will be redirected to line item detail page before the block of code is executed.
	def PINEXT.within_expense_line_section (&block)
		PINEXT.on_expense_line_item do
			block.call()
		end
		# Navigate user to detal page of payable invoice
		if (SF.org_is_lightning)
			find(:xpath, $pinext_related_list_invoice_link).click
			
		end
	end
############################################################################################	
# New payable invoice line item and new payable invoice expense line item from related list
#############################################################################################
	# set payable invoice line item : product
	def PINEXT.set_product product_name
		SF.fill_in_lookup $pinext_product_label,  product_name
	end
	# set payable invoice line item : Derive Unit Price from Product checkbox
	def PINEXT.set_derive_unit_price_from_product checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_derive_unit_price_from_product_label)
		else
			uncheck($pinext_derive_unit_price_from_product_label)
		end
	end
	# set payable invoice line item : quantity
	def PINEXT.set_quantity quantity_value
		fill_in $pinext_quantity_label, :with => quantity_value
	end
	# set payable invoice line item : unit price
	def PINEXT.set_unit_price unit_price
		fill_in $pinext_unit_price_label, :with => unit_price
	end
	# set "set tax code to default" checkbox (common to product and expense line item UI)
	def PINEXT.set_set_tax_code_to_default checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_set_tax_code_to_default_label)
		else
			uncheck($pinext_set_tax_code_to_default_label)
		end
	end
	# set "Derive Tax Rate from Code" checkbox (common to product and expense line item UI)
	def PINEXT.set_derive_tax_rate_from_code checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_derive_tax_rate_from_code_label)
		else
			uncheck($pinext_derive_tax_rate_from_code_label)
		end
	end
	# set "Calculate Tax Value from Rate" checkbox (common to product and expense line item UI)
	def PINEXT.set_calculate_tax_value_from_rate checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_calculate_tax_value_from_rate_label)
		else
			uncheck($pinext_calculate_tax_value_from_rate_label)
		end		
	end
	# set tax value (common to product and expense line item UI)
	def PINEXT.set_tax_value tax_value
		fill_in $pinext_tax_value_label, :with => tax_value
	end
	# set derive line number checkbox (common to product and expense line item UI)
	def PINEXT.set_derive_line_number checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_derive_line_number_label)
		else
			uncheck($pinext_derive_line_number_label)
		end
	end
	# set payable invoice expense line item : Net Value
	def PINEXT.set_net_value net_value
		find(:xpath, $pinext_net_value).set net_value
	end
	# set payable invoice expense line item : "Set GLA to Default" checkbox
	def PINEXT.set_set_gla_to_default checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pinext_set_gla_to_default_label)
		else
			uncheck($pinext_set_gla_to_default_label)
		end		
	end
	# set Input Tax Code (common to product and expense line item UI)
	def PINEXT.set_input_tax_code tax_code
		SF.fill_in_lookup $pinext_input_tax_code_label,  tax_code
	end
	
	# click payable invoice number link from line item page to open payable invoice detail page
	def PINEXT.click_payable_invoice_number
		find(:xpath, $pinext_payable_invoice_number_link).click
	end
	# set payable invoice expense line item : GLA
	def PINEXT.set_gla gla_name
		fill_in $pinext_general_ledger_account_label, :with => gla_name
	end
	# set Company common to product and expense line item UI)
	def PINEXT.set_line_company company_name
		fill_in $pinext_company_label, :with => company_name
	end

	# Click on payable invoice number link
	def PINEXT.click_payable_inv_number_link pin_number
		if (page.has_link?(pin_number))
			SF.click_link pin_number
		end
	end
#####################################
# Manage product lines page
#####################################
	# set product on invoice line
	def PINEXT.manage_product_line_set_product line, product_name
		SF.execute_script do
			_manage_product_line_product = $pinext_manage_product_line_product_pattern.sub($sf_param_substitute, line.to_s)
			find(_manage_product_line_product).set product_name
			gen_tab_out _manage_product_line_product
			SF.retry_script_block do 
				gen_wait_until_object_disappear $pinext_ajax_process_image_locator
			end
		end
	end
	
	# set unit price on invoice line
	# @line = line number on which value need to be set
	# @price - unit price of product
	def PINEXT.manage_product_line_set_unit_price line, price
		SF.execute_script do
			_manage_product_line_unit_price = $pinext_manage_product_line_unit_price_pattern.sub($sf_param_substitute, line.to_s)
			find(_manage_product_line_unit_price).set price
			gen_tab_out _manage_product_line_unit_price
			SF.retry_script_block do
				gen_wait_until_object_disappear $pinext_ajax_process_image_locator
			end
		end
	end
	
	# set tax code on invoice line
	# @line = line number on which value need to be set
	# @tax_code - tax code value of product
	def PINEXT.manage_product_line_set_tax_code line, tax_code
		SF.execute_script do
			_manage_product_line_tax_code = $pinext_manage_line_input_tax_code_pattern.sub($sf_param_substitute, line.to_s)
			# Select tax code from lookup to avoid the error of duplicate value which starts with same name(ex- VO-S , VO-STD purchase)
			FFA.select_tax_code_from_lookup $pinext_manage_line_input_tax_code_lookup_icon_pattern.sub($sf_param_substitute, line.to_s),tax_code
			gen_tab_out _manage_product_line_tax_code
			SF.retry_script_block do
				gen_wait_until_object_disappear $pinext_ajax_process_image_locator
			end
		end
	end
	
	# need to call below func in script after setting product on invoice line to allow values to autopouplate in other fields
	def PINEXT.wait_until_net_value_appears line, net_value
		SF.execute_script do
			_net_value_row = $pinext_manage_product_line_net_value_pattern.sub($sf_param_substitute, line.to_s)
			_net_value = _net_value_row.sub($sf_param_substitute, net_value.to_s)
			gen_wait_until_object _net_value
			if(page.has_xpath?(_net_value))
				return true
			else
				return false
			end
		end
	end
	# get quantity value from invoice line
	def PINEXT.manage_product_line_get_quantity line
		SF.execute_script do
			return find($pinext_manage_product_line_quantity_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	# get unit price from invoice line
	def PINEXT.manage_product_line_get_unit_price line
		SF.execute_script do
			return find($pinext_manage_product_line_unit_price_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	# get input tax code value from invoice line
	def PINEXT.manage_product_line_get_input_tax_code line
		SF.execute_script do
			return find($pinext_manage_line_input_tax_code_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	# get tax value value from invoice line (function common to manage expense line and manage product line UI)
	def PINEXT.manage_line_get_tax_value line
		SF.execute_script do
			return find($pinext_manage_line_tax_value_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	
#####################################
# Manage expense lines page
#####################################
	# set gla on invoice line of Manage expense lines
	def PINEXT.manage_expense_line_set_gla line, gla_name
		SF.execute_script do
			line_gla = $pinext_manage_expense_line_gla_pattern.sub($sf_param_substitute, line.to_s)
			find(line_gla).set gla_name
			gen_tab_out line_gla
			gen_wait_until_object_disappear $pinext_ajax_process_image_locator
		end
	end
	# set input tax code on invoice line (function common to manage expense line and manage product line UI)
	def PINEXT.manage_line_set_input_tax_code line, tax_code
		SF.execute_script do
			_input_tax_code = $pinext_manage_line_input_tax_code_pattern.sub($sf_param_substitute, line.to_s)
			# Select tax code from lookup to avoid the error of duplicate value which starts with same name(ex- VO-S , VO-STD purchase)
			FFA.select_tax_code_from_lookup $pinext_manage_line_input_tax_code_lookup_icon_pattern.sub($sf_param_substitute, line.to_s),tax_code
			gen_tab_out _input_tax_code
			gen_wait_until_object_disappear $page_waiting_icon
			gen_wait_until_object_disappear $pinext_ajax_process_image_locator
		end
	end
	
	# set combined tax code on invoice line (function common to manage expense line and manage product line UI)
	def PINEXT.manage_line_set_combined_tax_code line, tax_code
		SF.execute_script do
			_combined_tax_code = $pinext_manage_line_combined_tax_code_pattern.sub($sf_param_substitute, line.to_s)
			find(_combined_tax_code).set tax_code
			gen_tab_out _combined_tax_code
			gen_wait_until_object_disappear $pinext_ajax_process_image_locator
		end
	end
	
	# set net value on invoice line of Manage expense lines
	def PINEXT.manage_expense_line_set_net_value line, net_value
		SF.execute_script do
			_net_value_locator = $pinext_manage_expense_line_net_value_pattern.sub($sf_param_substitute, line.to_s)
			find(_net_value_locator).set net_value
			gen_tab_out _net_value_locator
		end
	end

#####################################
# Related List action Items
# Use below methods to perform operation on related list items
#####################################	

	# Execute the block code on product line item page
	# If org is lightning, user will be redirected to line item details page before executing the block of code.
	def PINEXT.on_product_line_item (&block)
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find($sf_lightning_related_list_tab).click
				page.has_css?($pinext_view_all_product_line_item_link)
				find($pinext_view_all_product_line_item_link).click
				page.has_css?($page_grid_columns)
			end
		end
		block.call()
	end
	
	# Execute the block code on expense line item page
	# If org is lightning, user will be redirected to line item details page before executing the block of code.
	def PINEXT.on_expense_line_item (&block)
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find($sf_lightning_related_list_tab).click
				page.has_css?($pinext_view_all_expense_line_item_link)
				find($pinext_view_all_expense_line_item_link).click
				page.has_css?($page_grid_columns)
			end
		end
		block.call()
	end
end
