 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
 
SINX_LINE_COLUMN_PRODUCT = 2
SINX_LINE_COLUMN_QUANTITY = 5
SINX_LINE_COLUMN_TAXCODE = 10

module SINX
extend Capybara::DSL
#############################
# sales invoice Extended Layout (VF pages)
#############################
# selectors
# Sales Invoice Header New/Edit Mode
$sinx_invoice_customer_reference = "input[id$='customerReference']"
$sinx_period_lookup_icon = "a[title='Period Lookup (New Window)']"
$sinx_account = "Account"
$sinx_invoice_date = "Invoice Date"
$sinx_dual_rate = "Dual Rate"
# Sales Invoice Line Item New/Edit Mode
$sinx_add_new_line = "input[class= 'newlinebutton']"
$sin_manage_line_button = "input[title = 'Manage Lines']"
$sinx_line_unit_price_label = "Unit Price"
$sinx_line_combined_tax_code_label = "Combined Tax Code"
$sinx_derive_unit_from_product_checkbox= "input[id*='"+$sf_param_substitute+"']"
# Sales Invoice Header view Mode
$sinx_invoice_status = ".//td[text()='Invoice Status']/following-sibling::td[1]/div | //div/span[text()='Invoice Status']/ancestor::div[1]/following::div[1]/div/span"
$sinx_invoice_number = ".//td[text()='Invoice Number']/following-sibling::td[1]/div | //div/span[text()='Invoice Number']/ancestor::div[1]/following::div[1]/div/span"
$sinx_customer_reference_number = "//td[text()='Customer Reference']/following-sibling::td/div | //div/span[text()='Customer Reference']/ancestor::div[1]/following::div[1]/div/span"
$sinx_sales_invoice_line_item_edit_link = "//a[text()='"+$sf_param_substitute+"']/../preceding-sibling::td/a[text()='Edit']"
$sinx_invoice_date_value = "//td[text()='Invoice Date']/following-sibling::td[1]/div"
$sinx_due_date_value = "//td[text()='Due Date']/following-sibling::td[1]/div"
$sinx_period_value = "//td[text()='Period']/following-sibling::td/div/a"
$sinx_shipping_method_value = "//td[text()='Shipping Method']/following-sibling::td/div"
$sinx_generate_adjustment_journal_value = "//td[text()='Generate Adjustment Journal']/following-sibling::td/div/img"
$sinx_invoice_description_value = "//td[text()='Invoice Description']/following-sibling::td/div"
$sinx_account_dimension_value = "//td[text()='"+$sf_param_substitute+"']/following-sibling::td/div/a"
$sinx_line_invoice_line_item_id_value = "//td[text()='Sales Invoice Line Item ID']/following::td[1]/div"
$sinx_number_of_invoice_line_item_rows = "//h3[text()='Sales Invoice Line Items']//ancestor::div[1]/following::div[1]/table/tbody/tr"
$sinx_invoice_line_items_table_header_values = $sinx_number_of_invoice_line_item_rows+"[1]/th"
$sinx_invoice_line_items_value_pattern = $sinx_number_of_invoice_line_item_rows+"["+$sf_param_substitute+"]"
$sinx_transaction_number = "//td[text()='Transaction']/following-sibling::td[1]/div/a | //div/span[text()='Transaction']/ancestor::div[1]/following::div[1]/div/div/a"
$sinx_total_amount_value = "//td[text()='Invoice Total']/following-sibling::td/div | //div/span[text()='Invoice Total']/ancestor::div[1]/following::div[1]/div/span"
$sinx_invoice_line_item_id_link = "//a[text()='"+$sf_param_substitute+"']/../preceding-sibling::th/a"
$sinx_income_schedule_value = "//td[text()='Income Schedule']/following-sibling::td[1]/div"
$sinx_number_of_payments_value = "//td[text()='Number of Payments']/following-sibling::td/div"
$sinx_customer_reference_input = "input[id$='customerReference'] , input[id$='customerReference']"
$sinx_invoice_account_input = "//label[text()='Account']/ancestor::td[1]/following::td[1]/span/input"
$sinx_account_dimension_pattern = "//label[text()='"+$sf_param_substitute+"']/ancestor::td[1]/following::td[1]/span/input"
$sinx_invoice_date_input = "//label[text()='Invoice Date']/ancestor::td[1]/following::td[1]/div/span/input |  //span[text()='Invoice Date']/ancestor::label[1]/following::div[1]/input"
$sinx_invoice_dual_rate_input = "//label[text()='Dual Rate']/ancestor::td[1]/following::td[1]/input | //span[text()='Dual Rate']//ancestor::div[1]/input"
$sinx_invoice_line_item_id_link_pattern = "//a[text()='"+$sf_param_substitute+"']/../preceding-sibling::th/a | //a[text()='"+$sf_param_substitute+"']//ancestor::tr[1]/th[1]/a"
# Sales Invoice Line Item view Mode
$sinx_invoice_line_combined_tax_code_value = "//td[text()='Combined Tax Code']/following::td[1]/div/a | //div/span[text()='Combined Tax Code']/ancestor::div[1]/following::div[1]/div/div/a"
$sinx_invoice_line_tax_rate_value = "//td[text()='Tax Rate']/following::td[1]/div | //div/span[text()='Tax Rate']/ancestor::div[1]/following::div[1]/div/span"
$sinx_invoice_line_tax_rate2_value = "//td[text()='Tax Rate 2']/following::td[1]/div | //div/span[text()='Tax Rate 2']/ancestor::div[1]/following::div[1]/div/span"
$sinx_invoice_line_tax_rate3_value = "//td[text()='Tax Rate 3']/following::td[1]/div | //div/span[text()='Tax Rate 3']/ancestor::div[1]/following::div[1]/div/span"
$sinx_invoice_line_taxvalue_value = "//td[text()='Tax Value']/following::td[1]/div | //div/span[text()='Tax Value']/ancestor::div[1]/following::div[1]/div/span"
$sinx_invoice_line_taxvalue2_value = "//td[text()='Tax Value 2']/following::td[1]/div | //div/span[text()='Tax Value 2']/ancestor::div[1]/following::div[1]/div/span"
$sinx_invoice_line_taxvalue3_value = "//td[text()='Tax Value 3']/following::td[1]/div"
$sinx_invoice_line_tax_code_value = "//td[text()='Tax Code']/following::td[1]/div | //div/span[text()='Tax Code']/ancestor::div[1]/following::div[1]/div/div/a"
$sinx_invoice_line_tax_code2_value = "//td[text()='Tax Code 2']/following::td[1]/div | //div/span[text()='Tax Code 2']/ancestor::div[1]/following::div[1]/div/div/a"
$sinx_invoice_line_tax_code3_value = "//td[text()='Tax Code 3']/following::td[1]/div"
$sinx_sales_invoice_link = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$sin_manage_line_button = "input[title = 'Manage Lines']"
$sinx_line_product = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{SINX_LINE_COLUMN_PRODUCT}) span input"
$sinx_line_quantity = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") input[data-role='Quantity__c_STRING']"
$sinx_line_unit_price = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") input[data-role='UnitPrice__c_STRING']"
$sinx_line_tax_code = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{SINX_LINE_COLUMN_TAXCODE}) span input"
$sinx_manage_line_tax_code_lookup_icon_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") a[title='Tax Code Lookup (New Window)']"
$sinx_line_product_name_value = "//td[text()='Product Name']/following-sibling::td/div/a"
$sinx_line_combined_tax_code_value = "//td[text()='Combined Tax Code']/following-sibling::td/div/a"
$sinx_product_name_value = "//td[text()='Product Name']/following-sibling::td[1]/div/a"
$sinx_quantity_value = "//td[text()='Quantity']/following-sibling::td[1]/div"
$sinx_product_quantity = "//label[text()='Quantity']/ancestor::td[1]/following::td[1]/div/input | //span[text()='Quantity']/ancestor::label[1]/following::input[1]"
$sinx_unit_price_value = "//td[text()='Unit Price']/following-sibling::td[1]/div"
$sinx_tax_code_value = "//td[text()='Tax Code']/following-sibling::td[1]/div/a"
$sinx_tax_value = "//td[text()='Tax Value']/following-sibling::td[1]/div"
$sinx_product_dimension_value = "//td[text()='"+$sf_param_substitute+"']/following-sibling::td[1]/div"
$sinx_line_description_value = "//td[text()='Line Description']/following-sibling::td[1]/div"
$sinx_ajax_process_image_locator = "input[class*='ajax']"
$sinx_line_derive_price_from_product_checkbox_label = "Derive Unit Price from Product"
$sinx_derive_unit_price_from_product_label = "Derive Unit Price from Product"
$sinx_line_income_schedule_line_items = "//th[text()='Income Schedule Line Item ID']/../following-sibling::tr"
$sinx_line_income_schedule_line_item_id = "//th[text()='Income Schedule Line Item ID']/../following-sibling::tr["+$sf_param_substitute+"]/th/a"
$sinx_show_all_income_schedule_line_items = "//a[contains(text(),'Income Schedule Line Item')]/../../following-sibling::tr"
$sinx_show_all_income_schedule_line_item_id = "//a[contains(text(),'Income Schedule Line Item')]/../../following-sibling::tr["+$sf_param_substitute+"]/th/a"
$sinx_income_schedule_line_items_go_to_list = "//h3[text()='Income Schedule Line Items']/ancestor::div[1]/following::div[1]/div/a[contains(text(),'Go to list')]"
$sinx_income_schedule_line_amount = "//td[text()='Amount']/following::td[1]/div"
$sinx_sales_invoice_line_item_link = "//a[contains(text(),'Sales Invoice Line Item')]"
$sinx_account_name_link = "//td[text()='Account']/following-sibling::td[1]/div/a"
$sinx_invoice_date_value = "//td[text()='Invoice Date']/following-sibling::td[1]/div"
$sinx_invoice_net_total_value = "//td[text()='Net Total']/following::td"
#buttons
$sinx_convert_to_credit_note = "Convert To Credit Note"
$sinx_convert_to_credit_note_confirm = "Convert to Credit Note" 
$sinx_post_invoices_button = "Post Invoices"
$sinx_new_sales_invoice_line_item_button = "input[value='New Sales Invoice Line Item'] , article[aria-describedby='title#{ORG_PREFIX}InvoiceLineItems__r'] div a[title='New']"
# labels
$sinx_product_name_label = "Product Name"
$sinx_customer_reference_label = "Customer Reference"
$sinx_derive_line_number_label = "Derive Line Number"
$sinx_line_number_label = "Line Number"
$sinx_quantity_label = "Quantity"
$sinx_shipping_method_label = "Shipping Method"
$sinx_invoice_description_label = "Invoice Description"
$sinx_generate_adjustment_journal_label = "Generate Adjustment Journal"
$sinx_dimension1_label = "Dimension 1"
$sinx_dimension2_label = "Dimension 2"
$sinx_dimension3_label = "Dimension 3"
$sinx_dimension4_label = "Dimension 4"
$sinx_line_description_label = "Line Description"
$sinx_unit_price_label = "Unit Price"
$sinx_tax_value_label = "Tax Value"
$sinx_income_schedule_label = "Income Schedule"
$sinx_due_date_label = "Due Date"
$sinx_number_of_payments_label = "Number of Payments"
$sinx_interval_label = "Interval"
$sinx_new_sales_invoice_line_item_button_label = "New Sales Invoice Line Item"
$sinx_company_label = "Company"
$sinx_tax_code_label = "Tax Code"
#Lighting specific
$sinx_view_all_invoice_line_item_link = "a[data-relatedlistid='#{ORG_PREFIX}InvoiceLineItems__r'] span[class='view-all-label']"
$sinx_custom_field_label = "//label[text()='#{$sf_param_substitute}']"
# Methods
#Extended Layout invoice 
	# set invoice account name
	def SINX.set_account accountName
		page.has_xpath?($sinx_invoice_account_input)
		SF.fill_in_lookup $sinx_account ,accountName
	end 
	# set account dimension value
	def SINX.set_account_dimension dimension_field, dimension_name_to_set
		SF.fill_in_lookup dimension_field , dimension_name_to_set
	end 
	# set invoice date
	def SINX.set_invoice_date invoice_date
		find(:xpath ,$sinx_invoice_date_input).set invoice_date
	end 
	# set invoice dual rate
	def SINX.set_dual_rate dual_rate
		find(:xpath,$sinx_invoice_dual_rate_input).set dual_rate
	end 
	# set invoice customer reference
	def SINX.set_customer_reference ref_value
		element_id = find(:field_by_label,$sinx_customer_reference_label)[:for]
		fill_in(element_id , :with => ref_value)
	end 
	
	def SINX.set_company company_name
		fill_in $sinx_company_label, :with => company_name
	end
	
	# click on add new lne
	def SINX.add_new_line
		SF.execute_script do
			find($sinx_add_new_line).click
		end
	end 

	# select shipping method
	def SINX.set_shipping_method shipping_method
		select shipping_method, :from => $sinx_shipping_method_label
	end
	
	# set invoice description
	def SINX.set_invoice_description invoice_description
		fill_in $sinx_invoice_description_label, :with => invoice_description
	end
	
	# set invoice reference while amending document
	def SINX.set_customer_reference_on_amend_document reference
		SF.execute_script do
			find($sinx_customer_reference_input).set reference
		end
	end
	# Set Generate Adjustment Journal checkbox
	def SINX.set_generate_adjustment_journal_checkbox checkbox_value_to_set
		if(checkbox_value_to_set)
			check($sinx_generate_adjustment_journal_label)
		else
			uncheck($sinx_generate_adjustment_journal_label)
		end
	end
	# Set due date
	def SINX.set_due_date due_date
		fill_in $sinx_due_date_label, :with => due_date
	end
	# set income schedule
	def SINX.set_income_schedule income_schedule
		fill_in $sinx_income_schedule_label, :with => income_schedule
	end
	# set payment number
	def SINX.set_number_of_payments number_of_payments
		fill_in $sinx_number_of_payments_label, :with => number_of_payments
	end
	# payment interval
	def SINX.set_payment_interval interval_type
		select interval_type, :from => $sinx_interval_label
	end
	# click sales invoice line item edit link from sales invoice (extended layout) detail page
	def SINX.click_sales_invoice_line_item_edit_link product_name
		find(:xpath, $sinx_sales_invoice_line_item_edit_link.sub($sf_param_substitute, product_name)).click
		SF.wait_for_search_button
	end
#########################################################################
# Create Sales Invoice Line Item through Manage Line button
#########################################################################	
	# Set line product name
	def SINX.line_set_product_name  line , line_product_name
		SF.execute_script do 
			product_field= $sinx_line_product.sub($sf_param_substitute,line)
			find(product_field).set line_product_name
			gen_tab_out product_field
			# waiting for process to complete.
			gen_wait_until_object_disappear $sinx_ajax_process_image_locator
		end
	end 
	# set line quantity
	def SINX.line_set_quantity  line , quantity
		SF.execute_script do 
			quantity_field= $sinx_line_quantity.sub($sf_param_substitute,line)
			find(quantity_field).set quantity
			gen_tab_out quantity_field
			sleep 1 # sleep of 1 second to update total value
		end
	end 
	# set line unit price
	def SINX.line_set_unit_price  line , unit_price
		SF.execute_script do 
			price_field= $sinx_line_unit_price.sub($sf_param_substitute,line)
			find(price_field).set unit_price
			gen_tab_out price_field
			sleep 1# sleep of 1 second to update to the total value
		end
	end 
	# set line tax code
	def SINX.line_set_tax_code  line , tax_code
		SF.execute_script do 
			tax_field= $sinx_line_tax_code.sub($sf_param_substitute,line)
			# Select tax code from lookup to avoid the error of duplicate value which starts with same name(ex- VO-S , VO-STD purchase)
			FFA.select_tax_code_from_lookup $sinx_manage_line_tax_code_lookup_icon_pattern.sub($sf_param_substitute,line),tax_code
			gen_tab_out tax_field
			# waiting for process to complete.
			gen_wait_until_object_disappear $sinx_ajax_process_image_locator
		end
	end 

# add complete line item.	
	def SINX.add_line_items line_no , product_name , line_quantity , unit_price , tax_code
		if product_name != nil 
			SINX.line_set_product_name  line_no , product_name
		end 
		if line_quantity != nil 
			SINX.line_set_quantity  line_no , line_quantity
		end 
		if unit_price != nil 
			SINX.line_set_unit_price  line_no , unit_price
		end 
		if tax_code != nil 
			SINX.line_set_tax_code  line_no , tax_code
		end 
		SF.wait_for_search_button
	end

# Click on Transaction link on Sales Invoice Page
	 def SINX.click_transaction_number
		gen_scroll_to $sinx_transaction_number
		SF.scroll_line_up 10
		find(:xpath , $sinx_transaction_number).click 
		SF.wait_for_search_button
	end
	 
# get Invoice details
	# get invoice number
	def SINX.get_invoice_number
		return find(:xpath ,$sinx_invoice_number).text
	end 
	# get invoice status
	def SINX.get_invoice_status
		return find(:xpath ,$sinx_invoice_status).text
	end 
	# get invoice line item id name 
	def SINX.get_line_invoice_line_item_id
		return find(:xpath , $sinx_line_invoice_line_item_id_value).text
	end
	# get invoice total
	def SINX.get_invoice_total
		return find(:xpath,$sinx_total_amount_value).text
	end
# get invoice line item details
# get line item combined tax code value
	def SINX.get_line_combined_tax_code_value
		return find(:xpath , $sinx_invoice_line_combined_tax_code_value).text
	end
# get line item tax code value
	def SINX.get_line_tax_code_value
		return find(:xpath , $sinx_invoice_line_tax_code_value).text
	end
# get line item tax code2 value
	def SINX.get_line_tax_code2_value
		return find(:xpath , $sinx_invoice_line_tax_code2_value).text
	end
# get line item tax code3 value
	def SINX.get_line_tax_code3_value
		return find(:xpath , $sinx_invoice_line_tax_code3_value).text
	end
# get line tax rate value
	def SINX.get_line_tax_rate_value
		return find(:xpath , $sinx_invoice_line_tax_rate_value).text
	end
# get line tax rate2 value
	def SINX.get_line_tax_rate2_value
		return find(:xpath , $sinx_invoice_line_tax_rate2_value).text
	end
# get line tax rate3 value
	def SINX.get_line_tax_rate3_value
		return find(:xpath , $sinx_invoice_line_tax_rate3_value).text
	end
# get line tax value value
	def SINX.get_line_taxvalue_value
		return find(:xpath , $sinx_invoice_line_taxvalue_value).text
	end
# get line tax value 2 value
	def SINX.get_line_taxvalue2_value
		return find(:xpath , $sinx_invoice_line_taxvalue2_value).text
	end
# get line tax value 3 value
	def SINX.get_line_taxvalue3_value
		return find(:xpath , $sinx_invoice_line_taxvalue3_value).text
	end

# click convert to credit note button
	def SINX.convert_to_credit_note
		if (SF.org_is_lightning)
			SF.click_action $sinx_convert_to_credit_note
			page.has_css?($sf_lightening_iframe_locator)
		else
			click_button($sinx_convert_to_credit_note)
			SF.wait_for_search_button
		end
	end
	# get invoice customer reference value 
	def SINX.get_customer_reference_number
		return find(:xpath ,$sinx_customer_reference_number).text
	end 
	# get invoice transaction value
	def SINX.get_invoice_transaction_number
		return find(:xpath ,$sinx_transaction_number).text
	end

	# get invoice date
	def SINX.get_invoice_date
		return find(:xpath, $sinx_invoice_date_value).text
	end
	# get due date
	def SINX.get_due_date
		return find(:xpath, $sinx_due_date_value).text
	end
	# get sales invoice period
	def SINX.get_sales_invoice_period
		return find(:xpath, $sinx_period_value).text
	end
	# get shipping method
	def SINX.get_shipping_method
		return find(:xpath, $sinx_shipping_method_value).text
	end 
	# get generate adjustment journal checkbox value
	def SINX.get_generate_adjustment_journal
		return find(:xpath, $sinx_generate_adjustment_journal_value)[:title]
	end 
	# get invoice description
	def SINX.get_invoice_description
		return find(:xpath, $sinx_invoice_description_value).text
	end 
	# get invoice description
	def SINX.get_account_dimension dimension_field
		return find(:xpath, $sinx_account_dimension_value.sub($sf_param_substitute, dimension_field)).text
	end
	# get income schedule
	def SINX.get_income_schedule
		return find(:xpath, $sinx_income_schedule_value).text
	end 
	# get number of payments
	def SINX.get_number_of_payments
		return find(:xpath, $sinx_number_of_payments_value).text
	end
	
	#To confirm sales invoice to credit note conversion
	def SINX.convert_to_credit_note_confirm
		SF.execute_script do
			click_button($sinx_convert_to_credit_note_confirm)
		end
		SF.wait_for_search_button
	end

# # Buttons
	# click on post invoice button
	def SINX.click_post_invoice
		SF.execute_script do
			page.has_button?($ffa_post_invoices_button)
			first(:button, $ffa_post_invoices_button).click	
			SF.wait_for_search_button
		end
	end
	# click on Post button
	def SINX.click_post_button
		FFA.click_post
		SF.wait_for_search_button
	end
	# click on print PDF button
	def SINX.click_print_pdf_button
		FFA.click_print_pdf
		SF.wait_for_search_button
	end
# click on new sales invoice line items button
	def SINX.click_new_sales_invoice_line_items_button
		SF.on_related_list do
			page.has_css?($sinx_new_sales_invoice_line_item_button)
			find($sinx_new_sales_invoice_line_item_button).click
			SF.wait_for_search_button
		end
	end
# open SIN detail page
	def SINX.open_invoice_detail_page invoice_number
		record_to_click = $sinx_sales_invoice_link.gsub($sf_param_substitute, invoice_number.to_s)
		find(:xpath , record_to_click).click
		page.has_text?(invoice_number)
	end

# click sales invoice line item id on sales invoice detail page
	def SINX.click_sales_invoice_line_item_id prod_name
		find(:xpath, $sinx_invoice_line_item_id_link.sub($sf_param_substitute, prod_name)).click
	end

# view invoice line items detail page
# product_name= product name for which line item need to be viewed
	def SINX.view_invoice_line_item_detail_page product_name
		SF.retry_script_block do
			SINX.on_invoice_line_item do
				find(:xpath , $sinx_invoice_line_item_id_link_pattern.gsub($sf_param_substitute ,product_name)).click
				page.has_text?(product_name)
			end
		end
	end
	
#get number of income schedule line items on a sales invoice line
	def SINX.get_number_of_income_schedule_line_items
		if(page.has_xpath?($sinx_income_schedule_line_items_go_to_list))
			find(:xpath, $sinx_income_schedule_line_items_go_to_list).click
			SF.wait_for_search_button
			_income_schedule_lines = all(:xpath, $sinx_show_all_income_schedule_line_items).count
			find(:xpath, $sinx_sales_invoice_line_item_link).click			
		else
			_income_schedule_lines = all(:xpath, $sinx_line_income_schedule_line_items).count
		end
		return _income_schedule_lines
	end

# open all income schedule line items one by one and return income schedule amount
	def SINX.get_all_income_schedule_line_items_amount _invoice_line_item_id
		_inc_schedule_amount_array = Array[]
		_total_schedule_line_items = SINX.get_number_of_income_schedule_line_items
			for row in 1.._total_schedule_line_items
				if(page.has_xpath?($sinx_income_schedule_line_items_go_to_list))
					find(:xpath, $sinx_income_schedule_line_items_go_to_list).click
					find(:xpath, $sinx_show_all_income_schedule_line_item_id.sub($sf_param_substitute,row.to_s)).click
				else
					find(:xpath, $sinx_line_income_schedule_line_item_id.sub($sf_param_substitute, row.to_s)).click
				end
				_inc_schedule_amount_array[row-1] = find(:xpath, $sinx_income_schedule_line_amount).text
				SF.click_link _invoice_line_item_id
			end
		return _inc_schedule_amount_array
	end

#get number of income schedule line items on a sales invoice line
	def SINX.get_number_of_income_schedule_line_items
		if(page.has_xpath?($sinx_income_schedule_line_items_go_to_list))
			find(:xpath, $sinx_income_schedule_line_items_go_to_list).click
			SF.wait_for_search_button
			_income_schedule_lines = all(:xpath, $sinx_show_all_income_schedule_line_items).count
			return _income_schedule_lines
		else
			_income_schedule_lines = all(:xpath, $sinx_line_income_schedule_line_items).count
			return _income_schedule_lines
		end
	end

# open income schedule line item
	def SINX.get_all_income_schedule_line_items_amount _invoice_line_item_id, _total_schedule_line_items
		_inc_schedule_amount_array = Array[]
		if(_total_schedule_line_items>5)
			for row in 1.._total_schedule_line_items
				find(:xpath, $sinx_show_all_income_schedule_line_item_id.sub($sf_param_substitute,row.to_s)).click
				_inc_schedule_amount_array[row-1] = find(:xpath, $sinx_income_schedule_line_amount).text
				SF.click_link _invoice_line_item_id
				find(:xpath, $sinx_income_schedule_line_items_go_to_list).click
			end
		else
			for row in 1.._total_schedule_line_items
				find(:xpath, $sinx_line_income_schedule_line_item_id.sub($sf_param_substitute, row.to_s)).click
				_inc_schedule_amount_array[row-1] = find(:xpath, $sinx_income_schedule_line_amount).text
				SF.click_link _invoice_line_item_id
			end
		end
		return _inc_schedule_amount_array
	end

#########################################################################
# Create Sales Invoice Line Item through New Sales Invoice Line Item button
#########################################################################
	# set product
	def SINX.set_product_name prod_name
		SF.fill_in_lookup $sinx_product_name_label,  prod_name
	end
	# set derive line number checkbox
	def SINX.set_product_derive_line_number checkbox_value_to_set 
		if (checkbox_value_to_set)
			check($sinx_derive_line_number_label)
		else
			uncheck($sinx_derive_line_number_label)
		end
	end
	# set line number
	def SINX.set_product_line_number line_no
		fill_in $sinx_line_number_label, :with => line_no
	end
	# set quantity
	def SINX.set_product_quantity quantity_value
		find(:xpath,$sinx_product_quantity).set quantity_value
	end
	# set dimension_value
	def SINX.set_product_dimension dimension_field, dimension_name_to_set
		fill_in dimension_field, :with => dimension_name_to_set
	end
	# set line description
	def SINX.set_product_line_description line_desc
		fill_in $sinx_line_description_label, :with => line_desc
	end
	# set unit price_field
	def SINX.set_product_unit_price unit_price
		fill_in $sinx_unit_price_label, :with => unit_price
	end
	# set tax value
	def SINX.set_product_tax_value tax_value
		fill_in $sinx_tax_value_label, :with => tax_value
	end
	# get product name
	def SINX.get_product_name
		return find(:xpath, $sinx_product_name_value).text
	end
	# get quantity
	def SINX.get_quantity
		return find(:xpath, $sinx_quantity_value).text
	end
	# get unit price
	def SINX.get_unit_price
		return find(:xpath, $sinx_unit_price_value).text
	end
	# get tax code
	def SINX.get_tax_code
		return find(:xpath, $sinx_tax_code_value).text
	end
	# get tax value
	def SINX.get_tax_value
		return find(:xpath, $sinx_tax_value).text
	end
	# get product dimension
	def SINX.get_product_dimension dimension_field
		return find(:xpath, $sinx_product_dimension_value.sub($sf_param_substitute, dimension_field)).text
	end 
	# get product line description
	def SINX.get_product_line_description
		return find(:xpath, $sinx_line_description_value).text
	end

	# set tax code
	def SINX.set_tax_code tax_code
		SF.fill_in_lookup $sinx_tax_code_label,  tax_code
	end

	# set unit price for line
	def SINX.set_unit_price_for_line unit_price
		fill_in $sinx_line_unit_price_label , :with=> unit_price
	end
# set combined tax code for line
	def SINX.set_combined_tax_code_for_line taxcode_value
		SF.fill_in_lookup $sinx_line_combined_tax_code_label ,  taxcode_value
	end
# check/uncheck Derive Unit Price from Product on line items [select_deselect=true to check and false to uncheck]
	def SINX.check_derive_unti_price_from_product_checkbox select_deselect
		# select the checkbox,if select_deselect = true
		if(select_deselect)
			page.check($sinx_line_derive_price_from_product_checkbox_label)
		else
			page.uncheck($sinx_line_derive_price_from_product_checkbox_label)
		end
	end
#####################################
# Related List action Items
# Use below methods to perform operation on related list items
#####################################	

# Execute the block code on invoice  line item page
	# If org is lightning, user will be redirected to line items page before executing the block of code.
	def SINX.on_invoice_line_item (&block)
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find($sf_lightning_related_list_tab).click
				page.has_css?($sinx_view_all_invoice_line_item_link)
				find($sinx_view_all_invoice_line_item_link).click
				page.has_css?($page_grid_columns)
			end
		end
		block.call()
	end

	#get Account Name in media layout
	def SINX.get_account_name_in_media_layout
		return find(:xpath, $sinx_account_name_link).text
	end
	
	#get invoice date in media layout
	def SINX.get_invoice_date_in_media_layout
		return find(:xpath, $sinx_invoice_date_value).text
	end
	
	#get invoice net total in media layout
	def SINX.get_invoice_net_total_in_media_layout
		return find(:xpath,$sinx_invoice_net_total_value).text
	end
	
	#fill custom field text value by label
	#label_name - name of label for text box
	#text_value - text value to fill in text box 
	def SINX.set_custom_field_text_value label_name, text_value
		element_id = find(:xpath,$sinx_custom_field_label.sub($sf_param_substitute,label_name ))[:for]
		fill_in(element_id , :with => text_value)
	end
end 
