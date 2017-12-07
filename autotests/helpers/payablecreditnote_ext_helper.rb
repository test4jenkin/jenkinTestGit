 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module PCREXT 
extend Capybara::DSL
###################################################
# Selectors 
###################################################
$pcrext_credit_note_number_value = "//td[text()='Credit Note Number']/following-sibling::td[1]/div | //span[text()='Credit Note Number']/ancestor::div[1]/following::div[1]/div[1]/span"
$pcrext_credit_note_status_value = "//td[text()='Credit Note Status']/following-sibling::td[1]/div | //span[text()='Credit Note Status']/ancestor::div[1]/following::div[1]/div[1]/span"
$pcrext_payable_credit_note_number_value = "//td[text()='Payable Credit Note Number']/following-sibling::td[1]/div"
$pcrext_payable_credit_note_number_link = $pcrext_payable_credit_note_number_value + "/a | //span[text()='Payable Credit Note Number']/ancestor::div[1]/following::div[1]/div[1]/div[1]/a"
$pcrext_manage_product_line_product_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"Product__c"
$pcrext_manage_product_line_quantity_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"Quantity__c"
$pcrext_manage_product_line_unit_price_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"UnitPrice__c"
$pcrext_manage_line_input_tax_code_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"InputVATCode__c"
$pcrext_manage_line_input_tax_code_lookup_icon_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") a[title='Input Tax Code Lookup (New Window)']"
$pcrext_manage_line_tax_value_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"TaxValue1__c"
$pcrext_manage_expense_line_gla_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"GeneralLedgerAccount__c"
$pcrext_manage_expense_line_net_value_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") input.input.input_"+ORG_PREFIX+"NetValue__c"
$pcrext_manage_product_line_net_value_pattern = "//tr["+$sf_param_substitute+"]//div[@class='"+ORG_PREFIX+"NetValue__c DOUBLE cellInnerText'][text()='"+$sf_param_substitute+"']"
$pcrext_credit_note_company_name = "//td[text()='Company']/following::td[1]/div[1]/a[1]"
$pcrext_company = "//label[text()='Company']"
$pcrext_vendor_credit_note_number_value = "//td[text()='Vendor Credit Note Number']/following-sibling::td[1]/div"
$pcrext_credit_note_currency_value = "//td[text()='Credit Note Currency']/following-sibling::td[1]/div/a"
$pcrext_credit_note_period_value = "//td[text()='Period']/following-sibling::td[1]/div/a"
$pcrext_error_message = "div.message.errorM3"
$pcrext_expense_line_item_section ="//h3[text()='Payable Credit Note Expense Line Items']//ancestor::div[2] | //table[@class='forceRecordLayout uiVirtualDataGrid--default uiVirtualDataGrid']/tbody" 
$pcrext_product_line_item_section = "//h3[text()='Payable Credit Note Line Items']//ancestor::div[2] | //table[@class='forceRecordLayout uiVirtualDataGrid--default uiVirtualDataGrid']/tbody"
$pcrext_net_value = "//label[text()='Net Value']/ancestor::td[1]/following::td[1]//input | //span[text()='Net Value']/ancestor::label[1]/following::input[1]"
$pcrext_quantity = "//label[text()='Quantity']"
$pcrext_net_total = "//td[text()='Net Total']/following-sibling::td[1]/div | //span[text()='Net Total']/ancestor::div[1]/following::div[1]/div[1]/span"
$pcrext_credit_note_total = "//td[text()='Credit Note Total']/following-sibling::td[1]/div | //span[text()='Credit Note Total']/ancestor::div[1]/following::div[1]/div[1]/span"
$pcrext_tax_total = "//td[text()='Tax Total']/following-sibling::td[1]/div | //span[text()='Tax Total']/ancestor::div[1]/following::div[1]/div[1]/span"
$pcrext_ajax_process_image_locator = "input[class*='ajax']"
# Labels
$pcrext_account_label = "Account"
$pcrext_copy_account_values_label = "Copy Account Values"
$pcrext_derive_due_date_label = "Derive Due Date"
$pcrext_due_date_label = "Due Date"
$pcrext_derive_period_label = "Derive Period"
$pcrext_derive_currency_label = "Derive Currency"
$pcrext_vendor_credit_note_number_label = "Vendor Credit Note Number"
$pcrext_credit_note_date_label = "Credit Note Date"
$pcrext_product_name_label = "Product Name"
$pcrext_derive_unit_price_from_product_label = "Derive Unit Price from Product"
$pcrext_quantity_label = "Quantity"
$pcrext_destination_net_value = "Destination Net Value"
$pcrext_destination_quantity ="Destination Quantity"
$pcrext_destination_unit_price = "Destination Unit Price"
$pcrext_set_tax_code_to_default_label = "Set Tax Code to Default"
$pcrext_derive_tax_rate_from_code_label = "Derive Tax Rate from Code"
$pcrext_calculate_tax_value_from_rate_label = "Calculate Tax Value from Rate"
$pcrext_tax_value_label = "Tax Value"
$pcrext_derive_line_number_label = "Derive Line Number"
$pcrext_net_value_label = "Net Value"
$pcrext_set_gla_to_default_label = "Set GLA to Default"
$pcrext_input_tax_code_label = "Input Tax Code"
$pcrext_company_label = "Company"
# Buttons
$pcrext_new_payable_credit_note_item_button = "input[value='New Payable Credit Note Line Item'] ,article[aria-describedby='title#{ORG_PREFIX}PurchaseCreditNoteLineItems__r'] div a[title='New']"
$pcrext_new_payable_credit_note_expense_item_button = "input[value='New Payable Credit Note Expense Line Item'] , article[aria-describedby='title#{ORG_PREFIX}PurchaseCreditNoteExpenseLineItems__r'] div a[title='New']"
$pcrext_manage_product_lines_button = "Manage Product Lines"
$pcrext_manage_expense_lines_button = "Manage Expense Lines"
$pcrext_add_new_line_button = "New Line"

#Lighting specific
$pcrext_line_item_pattern = "//a[@title='"+$sf_param_substitute+"']/ancestor::tr[1]/td[1]/a"
$pcrext_view_all_product_line_item_link = "article[aria-describedby='title#{ORG_PREFIX}PurchaseCreditNoteLineItems__r'] span[class='view-all-label']"
$pcrext_view_all_expense_line_item_link = "article[aria-describedby='title#{ORG_PREFIX}PurchaseCreditNoteExpenseLineItems__r'] span[class='view-all-label']"
$pcrext_related_list_credit_note_link = "//div[text()='Payable Credit Notes']/ancestor::a[1]/following::a[1]"
$pcrext_related_list_invoice_link = "//div[text()='Payable Credit Notes']/ancestor::a[1]/following::a[1]"

# Methods

# Set account
	def PCREXT.set_account account_name
		SF.fill_in_lookup $pcrext_account_label, account_name
	end
# Set company
	def PCREXT.set_company company_name
		company_id = find(:xpath,$pcrext_company)[:for]				
		fill_in(company_id , :with => company_name)	
	end
# Set copy account values checkbox
	def PCREXT.set_copy_account_values checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_copy_account_values_label)
		else
			uncheck($pcrext_copy_account_values_label)
		end
	end
# Set Derive Due Date checkbox
	def PCREXT.set_derive_due_date checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_derive_due_date_label)
		else
			uncheck($pcrext_derive_due_date_label)
		end
	end
# Set due date
	def PCREXT.set_due_date due_date_value
		fill_in $pcrext_due_date_label, :with => due_date_value
	end
# Set derive period checkbox
	def PCREXT.set_derive_period checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_derive_period_label)
		else
			uncheck($pcrext_derive_period_label)
		end
	end
# Set derive currency checkbox
	def PCREXT.set_derive_currency checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_derive_currency_label)
		else
			uncheck($pcrext_derive_currency_label)
		end
	end
# Set vendor credit note number
	def PCREXT.set_vendor_credit_note_number vendor_credit_note_number
		fill_in $pcrext_vendor_credit_note_number_label, :with => vendor_credit_note_number
	end
# Set Credit Note date
	def PCREXT.set_credit_note_date credit_note_date
		fill_in $pcrext_credit_note_date_label, :with => credit_note_date
	end
# click manage product lines button 
	def PCREXT.click_manage_product_lines_button
		SF.click_action $pcrext_manage_product_lines_button
		gen_wait_until_object_disappear $page_waiting_icon
	end
# click manage expense lines button 
	def PCREXT.click_manage_expense_lines_button
		SF.click_action $pcrext_manage_expense_lines_button
		gen_wait_until_object_disappear $page_waiting_icon
	end
# Get credit note number
	def PCREXT.get_credit_note_number
		return find(:xpath, $pcrext_credit_note_number_value).text
	end
# Get credit note status
	def PCREXT.get_credit_note_status
		return find(:xpath, $pcrext_credit_note_status_value).text
	end
# get company name
	def PCREXT.get_company_name
		return find(:xpath, $pcrext_credit_note_company_name).text
	end
# get vendor credit note number balue
	def PCREXT.get_vendor_credit_note_number
		return find(:xpath,$pcrext_vendor_credit_note_number_value).text
	end
# get credit note currency value from detail page
	def PCREXT.get_credit_note_currency
		return find(:xpath,$pcrext_credit_note_currency_value).text
	end
# get credit note period value
	def PCREXT.get_credit_note_period_value
		return find(:xpath , $pcrext_credit_note_period_value).text
	end
# click on credit note currency
	def PCREXT.click_credit_note_currency
		find(:xpath,$pcrext_credit_note_currency_value).click
		SF.wait_for_search_button
	end
# click on credit note period
	def PCREXT.click_on_credit_note_period
		find(:xpath,$pcrext_credit_note_period_value).click
		SF.wait_for_search_button
	end
# get error message on post
	def PCREXT.get_error_message_on_post
		return find($pcrext_error_message).text
	end
	
	# get tax total
	def PCREXT.get_tax_total
		return find(:xpath , $pcrext_tax_total).text		
	end
	
	# get Net total
	def PCREXT.get_net_total
		return find(:xpath , $pcrext_net_total).text		
	end
	
	# get Net total
	def PCREXT.get_credit_note_total
		return find(:xpath , $pcrext_credit_note_total).text		
	end
	
	# click on button on payable invoice extended layout on related list
	def PCREXT.click_new_payable_credit_note_line_item_button
		SF.on_related_list do
			page.has_css?($pcrext_new_payable_credit_note_item_button)
			find($pcrext_new_payable_credit_note_item_button).click
		end
	end
	
	# click on button on payable invoice extended layout on related list
	def PCREXT.click_new_payable_credit_note_expense_line_item_button
		SF.on_related_list do
			page.has_css?($pcrext_new_payable_credit_note_expense_item_button)
			find($pcrext_new_payable_credit_note_expense_item_button).click
		end
	end

############################################################################################	
# New payable credit note line item and new payable credit note expense line item from related list
#############################################################################################
	# set payable destination net value
	def PCREXT.set_exp_destination_net_value net_value
		fill_in $pcrext_destination_net_value, :with => net_value
	end
	
	# set payable destination unit price
	def PCREXT.set_prod_line_destination_unit_price unit_price
		fill_in $pcrext_destination_unit_price, :with => unit_price
	end
	
	# set payable destination quantity
	def PCREXT.set_prod_line_destination_quantity quantity
		fill_in $pcrext_destination_quantity, :with => quantity
	end
	
	# set payable credit note line item : product
	def PCREXT.set_product product_name
		SF.fill_in_lookup $pcrext_product_name_label,  product_name
	end
	# set payable credit note line item : Derive Unit Price from Product checkbox
	def PCREXT.set_derive_unit_price_from_product checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_derive_unit_price_from_product_label)
		else
			uncheck($pcrext_derive_unit_price_from_product_label)
		end
	end
	# set payable credit note line item : quantity
	def PCREXT.set_quantity quantity_value
		quantity_id = find(:xpath,$pcrext_quantity)[:for]				
		fill_in(quantity_id , :with => quantity_value)	
	end
	# set "set tax code to default" checkbox (common to payable credit note product and expense line item UI)
	def PCREXT.set_set_tax_code_to_default checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_set_tax_code_to_default_label)
		else
			uncheck($pcrext_set_tax_code_to_default_label)
		end
	end
	# set "Derive Tax Rate from Code" checkbox (common to payable credit note product and expense line item UI)
	def PCREXT.set_derive_tax_rate_from_code checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_derive_tax_rate_from_code_label)
		else
			uncheck($pcrext_derive_tax_rate_from_code_label)
		end
	end
	# set "Calculate Tax Value from Rate" checkbox (common to payable credit note product and expense line item UI)
	def PCREXT.set_calculate_tax_value_from_rate checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_calculate_tax_value_from_rate_label)
		else
			uncheck($pcrext_calculate_tax_value_from_rate_label)
		end		
	end
	# set tax value (common to payable credit note product and expense line item UI)
	def PCREXT.set_tax_value tax_value
		fill_in $pcrext_tax_value_label, :with => tax_value
	end
	# set derive line number checkbox (common to payable credit note product and expense line item UI)
	def PCREXT.set_derive_line_number checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_derive_line_number_label)
		else
			uncheck($pcrext_derive_line_number_label)
		end
	end
	# set payable credit note expense line item : Net Value
	def PCREXT.set_net_value net_value
		find(:xpath,$pcrext_net_value).set net_value
	end
	# set payable credit note expense line item : "Set GLA to Default" checkbox
	def PCREXT.set_set_gla_to_default checkbox_value_to_set
		if (checkbox_value_to_set == true)
			check($pcrext_set_gla_to_default_label)
		else
			uncheck($pcrext_set_gla_to_default_label)
		end		
	end
	# set Input Tax Code (common to payable credit note product and expense line item UI)
	def PCREXT.set_input_tax_code tax_code
		SF.fill_in_lookup $pcrext_input_tax_code_label,  tax_code
	end
	# click payable credit note number link from line item page to open payable credit note detail page
	def PCREXT.click_payable_credit_note_number
		find(:xpath, $pcrext_payable_credit_note_number_link).click
		SF.wait_for_search_button
	end
	# get payable credit note number value from line item detail page
	def PCREXT.line_item_get_payable_credit_note_number
		return find(:xpath, $pcrext_payable_credit_note_number_value).text
	end
	# set company name on line item page
	def PCREXT.line_item_set_company_name company_name
		fill_in $pcrext_company_label, :with=> company_name
	end
		
	# get payable credit note number value from product line item detail page
	# product_name= name of the product
	def PCREXT.product_line_item_get_credit_note_number product_name
		PCREXT.on_product_line_item do
			if (SF.org_is_lightning)
				page.has_text?(product_name)
				find(:xpath,$pcrext_line_item_pattern.sub($sf_param_substitute,product_name)).click
			end
			return find(:xpath, $pcrext_payable_credit_note_number_link).text
		end
	end
	
	# get payable credit note  number value from expense line item detail page
	# gla_name- name of the gla in expense lin eitem
	def PCREXT.expense_line_item_get_credit_note_number gla_name
		PCREXT.on_expense_line_item do
			if (SF.org_is_lightning)
				page.has_text?(gla_name)
				find(:xpath,$pcrext_line_item_pattern.sub($sf_param_substitute,gla_name)).click
			end
			return find(:xpath, $pcrext_payable_credit_note_number_link).text
		end
	end
	
	# Execute the passed block on of code on line item detail page.
	# on lightning org, user will be redirected to line item detail page before the block of code is executed.
	def PCREXT.within_product_line_section (&block)
		PCREXT.on_product_line_item do
			block.call()
		end
		if (SF.org_is_lightning)
			find(:xpath, $pcrext_related_list_invoice_link).click
		end
	end
	
	
	# Execute the passed block on of code on expense line item detail page.
	# on lightning org, user will be redirected to line item detail page before the block of code is executed.
	def PCREXT.within_expense_line_section (&block)
		PCREXT.on_expense_line_item do
			block.call()
		end
		if (SF.org_is_lightning)
			find(:xpath, $pcrext_related_list_invoice_link).click
		end
	end
	
#####################################
# Manage product lines page
#####################################
	# set product on payable credit line
	def PCREXT.manage_product_line_set_product line, product_name
		SF.execute_script do
			_manage_product_line_product = $pcrext_manage_product_line_product_pattern.sub($sf_param_substitute, line.to_s)
			find(_manage_product_line_product).set product_name
			gen_tab_out _manage_product_line_product
			SF.retry_script_block do
				gen_wait_until_object_disappear $pcrext_ajax_process_image_locator
			end
		end
	end
	
	# set unit price on payable credit line
	# @line = line number on which value need to be set
	# @price - unit price of product
	def PCREXT.manage_product_line_set_unit_price line, price
		SF.execute_script do
			_manage_product_line_unit_price = $pcrext_manage_product_line_unit_price_pattern.sub($sf_param_substitute, line.to_s)
			find(_manage_product_line_unit_price).set price
			gen_tab_out _manage_product_line_unit_price
			SF.retry_script_block do
				gen_wait_until_object_disappear $pcrext_ajax_process_image_locator
			end
		end
	end
	
	# set tax code on invoice line
	# @line = line number on which value need to be set
	# @tax_code - tax code value of product
	def PCREXT.manage_product_line_set_tax_code line, tax_code
		SF.execute_script do
			_manage_product_line_tax_code = $pcrext_manage_line_input_tax_code_pattern.sub($sf_param_substitute, line.to_s)
			# Select tax code from lookup to avoid the error of duplicate value which starts with same name(ex- VO-S , VO-STD purchase)
			FFA.select_tax_code_from_lookup $pcrext_manage_line_input_tax_code_lookup_icon_pattern.sub($sf_param_substitute,line),tax_code
			gen_tab_out _manage_product_line_tax_code
			SF.retry_script_block do
				gen_wait_until_object_disappear $pcrext_ajax_process_image_locator
			end
		end
	end
	
	# need to call below func in script after setting product on credit line to allow values to autopouplate in other fields
	def PCREXT.wait_until_net_value_appears line, net_value
		SF.execute_script do
			_net_value_row = $pcrext_manage_product_line_net_value_pattern.sub($sf_param_substitute, line.to_s)
			_net_value = _net_value_row.sub($sf_param_substitute, net_value.to_s)
			gen_wait_until_object _net_value
			if(page.has_xpath?(_net_value))
				return true
			else
				return false
			end
		end
	end	
	# get quantity value from payable credit line
	def PCREXT.manage_product_line_get_quantity line
		SF.execute_script do
			return find($pcrext_manage_product_line_quantity_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	# get unit price from payable credit line
	def PCREXT.manage_product_line_get_unit_price line
		SF.execute_script do
			return find($pcrext_manage_product_line_unit_price_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	# get input tax code value from payable credit line
	def PCREXT.manage_product_line_get_input_tax_code line
		SF.execute_script do
			return find($pcrext_manage_line_input_tax_code_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	# get tax value value from payable credit line (function common to manage expense line and manage product line UI)
	def PCREXT.manage_line_get_tax_value line
		SF.execute_script do
			return find($pcrext_manage_line_tax_value_pattern.sub($sf_param_substitute, line.to_s))[:value]
		end
	end
	
#####################################
# Manage expense lines page
#####################################
	# set gla on payable credit line of Manage expense lines
	def PCREXT.manage_expense_line_set_gla line, gla_name
		SF.execute_script do
			_manage_exp_line_gla = $pcrext_manage_expense_line_gla_pattern.sub($sf_param_substitute, line.to_s)
			find(_manage_exp_line_gla).set gla_name
			gen_tab_out _manage_exp_line_gla
			gen_wait_until_object_disappear $pcrext_ajax_process_image_locator
		end
	end
	# set input tax code on payable credit line (function common to manage expense line and manage product line UI)
	def PCREXT.manage_line_set_input_tax_code line, tax_code
		SF.execute_script do
			_input_tax_code = $pcrext_manage_line_input_tax_code_pattern.sub($sf_param_substitute, line.to_s)
			# Select tax code from lookup to avoid the error of duplicate value which starts with same name(ex- VO-S , VO-STD purchase)
			FFA.select_tax_code_from_lookup $pcrext_manage_line_input_tax_code_lookup_icon_pattern.sub($sf_param_substitute, line.to_s),tax_code
			gen_tab_out _input_tax_code
			gen_wait_until_object_disappear $pcrext_ajax_process_image_locator
		end
	end
	# set net value on payable credit line of Manage expense lines
	def PCREXT.manage_expense_line_set_net_value line, net_value
		SF.execute_script do
			_net_value_locator = $pcrext_manage_expense_line_net_value_pattern.sub($sf_param_substitute, line.to_s)
			find(_net_value_locator).set net_value
			gen_tab_out _net_value_locator
			gen_wait_until_object_disappear $pcrext_ajax_process_image_locator
		end
	end
	
#####################################
# Related List action Items
# Use below methods to perform operation on related list items
#####################################	

	# Execute the block code on product line item page
	# If org is lightning, user will be redirected to line item details page before executing the block of code.
	def PCREXT.on_product_line_item (&block)
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find($sf_lightning_related_list_tab).click
				page.has_css?($pcrext_view_all_product_line_item_link)
				find($pcrext_view_all_product_line_item_link).click
				page.has_css?($page_grid_columns)
			end
		end
		block.call()
	end
	
	# Execute the block code on expense line item page
	# If org is lightning, user will be redirected to line item details page before executing the block of code.
	def PCREXT.on_expense_line_item (&block)
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find($sf_lightning_related_list_tab).click
				page.has_css?($pcrext_view_all_expense_line_item_link)
				find($pcrext_view_all_expense_line_item_link).click
				page.has_css?($page_grid_columns)
			end
		end
		block.call()
	end
end