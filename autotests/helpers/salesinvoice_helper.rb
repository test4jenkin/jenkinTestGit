 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SIN
extend Capybara::DSL
#############################
# sales invoice (VF pages)
#############################
###################################################
# Selectors 
###################################################
$sin_account = "input[id$='account']"
$sin_invoice_date = "input[id$='invoiceDate']"
$sin_invoice_due_date = "input[id$='dueDate']"
$sin_invoice_period = "input[id$=':periodValue']"
$sin_line_product_name = ":product"
$sin_line_quantity = ":quantity"
$sin_account_dimension1 = "//td[@class = 'data2Col first']//span[@class = 'lookupInput']//input"
$sin_currency_dual_rate =  "Dual Rate"
$sin_line_unit_price = ":unitPrice"
$sin_line_tax_code = ":taxCode"
$sin_line_tax_value = ":taxValue"
$sin_line_income_schedule = ":incomeSchedule"
$sin_toggle_exchange_rate =  "span[id$='currencyRates'] img"
$sin_convert_to_credit_note = "input[value = 'Convert to Credit Note']"
$sin_transaction_value = "//th[text()='Transaction']/following-sibling::td[1]/span"
$sin_transaction_link = $sin_transaction_value + "/a"
$sin_invoice_date_value = "//th[text()='Invoice Date']/following-sibling::td[1]/span"
$sin_invoice_description_value = "//th[text()='Invoice Description']/following-sibling::td[1]/span"
$sin_invoice_number_pattern= "//div["+$sf_param_substitute+"]/table/tbody/tr/td[4]/div/a/span[starts-with(text(),'SIN')] | //div[@class='active oneContent']//div[@class='listViewContainer']//table/tbody/tr["+$sf_param_substitute+"]/th/span/a"
$sin_back_to_list_sales_invoices = "Back to List: Sales Invoices"
$sin_convert_link = "Convert"
$sin_invoice_rate = "span[id$='documentRateRo']"
$sin_invoice_number = ".//th[text()='Invoice Number']/following-sibling::td[1]/span"
$sin_status = "//th[text() = 'Invoice Status']/following-sibling::td[1]"
$sin_sales_invoice_link_pattern = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$sin_sales_invoice_link = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1]"
$sin_sales_invoice_payment_status =  "//label[contains(text() , 'Payment Status')]/../following-sibling::td[1]"
$sin_payment_outstanding_value = "//label[contains(text() , 'Outstanding Value')]/../following-sibling::td[1]/span"
$sin_account_dimension_pattern = "//label[contains(text(),'"+$sf_param_substitute+"')]/../following-sibling::td/span/span/input"
$sin_account_dimension_pattern_value = "(//*[@class='pbSubsection'])[3]/table//tr["+$sf_param_substitute+"]/td/span"
$sin_dimension1 = "//label[contains (text() , 'Dimension 1')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$sin_dimension2 = "//label[contains (text() , 'Dimension 2')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$sin_dimension3 = "//label[contains (text() , 'Dimension 3')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$sin_dimension4= "//label[contains (text() , 'Dimension 4')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$sin_destination_company = "//label[contains (text() , 'Destination Company')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$sin_destination_unit_price = "//label[contains (text() , 'Destination Unit Price')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$sin_destination_quantity = "//label[contains (text() , 'Destination Quantity')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$sin_invoice_total_amount_value= "span[id$=':invTotal']"
$sin_product_dimension_input_pattern = "//label[contains(text(),'"+$sf_param_substitute+"')]/../following-sibling::td/span[contains(@id,'dtLineItems"
$sin_product_dimension_input_end = "')]/span/input"
$sin_product_line_description_input = "textarea[id*='dtLineItems"
$sin_period_lookup_icon = "a[id*='invoiceBlock:invoiceDetail:periodValue']"
$sin_customer_reference_value = "//label[contains(text(),'Customer Reference')]/../following-sibling::td/span"
$sin_invoice_date_value = "//th[contains(text(),'Invoice Date')]/following-sibling::td[1]/span"
$sin_due_date_value = "//label[contains(text(),'Due Date')]/../following-sibling::td/span/span"
$sin_shipping_method_value = "//th[contains(text(),'Shipping Method')]/following-sibling::td/span"
$sin_invoice_description_value = "//th[contains(text(),'Invoice Description')]/following-sibling::td/span"
$sin_generate_adjustment_journal_value = "span[id$=':generateAdjustmentJournal'] img"
$sin_income_schedule_value = "span[id$=':incomeSchedule'] a"
$sin_product_dimension_value_pattern = "//label[contains(text(),'"+$sf_param_substitute+"')]/../following-sibling::td/span[contains(@id,'dtLineItems:"+$sf_param_substitute+":popupLine')]"
$sin_product_line_description_value_pattern = "//label[contains(text(),'Line Description')]/../following-sibling::td/span[contains(@id,':dtLineItems:"+$sf_param_substitute+":popupLine')]"
$sin_line_prod_name_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(2) span a"
$sin_line_quantity_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(4)"
$sin_line_unit_price_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(5) span"
$sin_line_tax_code_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(6) span a"
$sin_line_tax_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(7) span"
$sin_invoice_period_value = "//th[text()='Period']/following-sibling::td/span/a"
$sin_payment_schedule_value = "select[id$='paymentSchedule']"
$sin_number_of_payments = "input[id$='numberOfPayments']"
$sin_payment_schedule_interval = "select[id$=':interval']"
$sin_payment_schedule_first_due_date ="input[id$=':firstDueDate']"
$sin_payment_schedule = "span[id$='paymentSchedule']"
$sin_generate_adjustment_journal_checkbox = "input[id$='generateAdjustmentJournal']"
$sin_post_button_locator = "input[title='Post'] , a[title='Post']"
$sin_net_total_value = "span[id$=':netTotal']"
# Labels
$sin_currency_dual_rate_label = "Dual Rate"
$sin_dimension_1_label = "Dimension 1"
$sin_dimension_2_label = "Dimension 2"
$sin_dimension_3_label = "Dimension 3"
$sin_dimension_4_label = "Dimension 4"
$label_invoice_number = "Invoice Number"
$label_invoice_status = "Invoice Status"
$sin_payment_schedule_label = "Payment Schedule"
$sin_generate_adjustment_journal_label = "Generate Adjustment Journal"
#buttons
$sin_post_invoices_button = "Post Invoices"
$sin_convert_to_credit_note_button = "Convert to Credit Note"
$sin_calculate_button = "select[id*=':interval']+input[value='Calculate']"
$sin_amend_document_button = "Amend Document"
# Recurring invoice screen (coming from Opportunity)
$sin_recurring_invoices_table = "table[id$=dtRecurringRules]"  # invoices to be generated table 
$sin_product_line_toggle_icon = "span[title='Toggle Notes and Analysis area']"
$sin_account_name_link = "//td[text()='Account']/../td[2]/a"

#methods
# Invoice Header 
# set account on invoice header
	def SIN.set_account accountName
		SF.execute_script do
			find($sin_account).set accountName
			gen_tab_out $sin_account
			FFA.wait_page_message $ffa_msg_retrieving_account_information
		end
	end 
	
	def SIN.set_invoice_account_dimension1 dimension_value
		SF.execute_script do
			 FFA.click_account_toggle_icon
			 find(:xpath ,$sin_dimension1).set dimension_value
			 FFA.click_account_toggle_icon
		end
	end 
	
	def SIN.set_invoice_account_dimension2 dimension_value
		SF.execute_script do
			 FFA.click_account_toggle_icon
			 find(:xpath ,$sin_dimension2).set dimension_value
			 FFA.click_account_toggle_icon
		end
	end 
# set invoice date 
	def SIN.set_invoice_date invoice_date
		SF.execute_script do
			find($sin_invoice_date).set invoice_date
			gen_tab_out $sin_invoice_date
			FFA.wait_page_message $ffa_msg_updating_taxrate_duedate_period
		end
	end 

	# Dual Rate
	def SIN.set_currency_dual_rate dual_rate
		SF.execute_script do
			SIN.click_exchange_rate_toggle_icon
			fill_in $sin_currency_dual_rate_label , :with => dual_rate
			SIN.click_exchange_rate_toggle_icon
		end
	end 
	
# set invoice due date 
	def SIN.set_due_date due_date
		SF.execute_script do
			find($sin_invoice_due_date).set due_date
			gen_tab_out $sin_invoice_due_date
		end
	end 
# set customer reference on invoice header  
	def SIN.set_customer_reference customer_reference
		SF.execute_script do
			fill_in "Customer Reference", :with=> customer_reference	
		end
	end 
# set sales invoice currency 
	def SIN.set_currency invoice_currency
		SF.execute_script do
			click_button "Change Currency"
			select(invoice_currency, :from => 'Invoice Currency') 
			click_button "Apply"
			FFA.wait_page_message $ffa_msg_changing_currency
		end
	end 

# check-uncheck the currency adjustment journal checkbox
	def SIN.check_generate_adjustment_journal check_value
		SF.execute_script do
			find($sin_generate_adjustment_journal_checkbox).set(check_value)
		end
	end
	
	#  Rate Icon
	def SIN.click_rate_icon
		SF.execute_script do
			find($sin_invoice_rate_icon ).click
		end
	end 
	
# set Dual Rate	
	def SIN.set_dual_rate dual_rate
		SF.execute_script do
			find($sin_invoice_dual_rate).set dual_rate
			gen_tab_out $sin_invoice_dual_rate
		end
	end 

# set shipping method 
	def SIN.select_shipping_method shipping_method
		SF.execute_script do
			select(shipping_method, :from => "Shipping Method") 
		end
	end 
# set invoice description 
	def SIN.set_description invoice_description
		SF.execute_script do
			fill_in "Invoice Description" , :with => invoice_description
		end
	end 
# set sales invoice account dimension
	def SIN.set_account_dimension dimension_field, dimension_name_to_set
		SF.execute_script do
			sin_account_dimension = $sin_account_dimension_pattern.gsub($sf_param_substitute, dimension_field)
			find(:xpath, sin_account_dimension).set dimension_name_to_set
		end
	end

# set product name 
	def SIN.line_set_product_name  line , line_product_name
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $sin_line_product_name
			find(field).set line_product_name
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end 
	#Dimension values
	def SIN.set_product_diemension1 dimension_value
		SF.execute_script do
			SIN.click_product_line_toggle_icon
			find(:xpath ,$sin_dimension1).set dimension_value
			SIN.click_product_line_toggle_icon
		end
	end
	
	def SIN.set_product_diemension2 dimension_value
		SF.execute_script do
			SIN.click_product_line_toggle_icon
			find(:xpath ,$sin_dimension2).set dimension_value
			SIN.click_product_line_toggle_icon
		end
	end
	
	def SIN.set_product_diemension3 dimension_value
		SF.execute_script do
			SIN.click_product_line_toggle_icon
			find(:xpath ,$sin_dimension3).set dimension_value
			SIN.click_product_line_toggle_icon
		end
	end
	
	def SIN.set_product_diemension4 dimension_value
		SF.execute_script do
			SIN.click_product_line_toggle_icon
			find(:xpath ,$sin_dimension4).set dimension_value
			SIN.click_product_line_toggle_icon
		end
	end
	
	def SIN.set_line_destination_company destination_company
		SF.execute_script do
			SIN.click_product_line_toggle_icon
			find(:xpath ,$sin_destination_company).set destination_company
			SIN.click_product_line_toggle_icon
		end
	end
	
	def SIN.set_line_destination_quantity destination_quantity
		SF.execute_script do
			SIN.click_product_line_toggle_icon
			find(:xpath ,$sin_destination_quantity).set destination_quantity
			SIN.click_product_line_toggle_icon
		end
	end
	
	def SIN.set_line_destination_unit_price destination_unit_price
		SF.execute_script do
			SIN.click_product_line_toggle_icon
			find(:xpath ,$sin_destination_unit_price).set destination_unit_price
			SIN.click_product_line_toggle_icon
		end
	end
# set quantity 
	def SIN.line_set_quantity line , line_quantity
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $sin_line_quantity
			find(field).set line_quantity
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end 
# set unit price 
	def SIN.line_set_unit_price  line , line_unit_price
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $sin_line_unit_price
			find(field).set line_unit_price
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end 
# set tax code 
	def SIN.line_set_tax_code  line , line_tax_code
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $sin_line_tax_code
			find(field).set line_tax_code
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end 
# set tax value 
	def SIN.line_set_tax_value  line , line_tax_value
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $sin_line_tax_value
			find(field).set line_tax_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end 
# set income schedule 
	def SIN.line_set_income_schedule  line , line_income_schedule 
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $sin_line_income_schedule
			SF.retry_script_block do
				find(field).set line_income_schedule
				gen_tab_out field
			end
			FFA.wait_page_message $ffa_msg_updating_income_schedule
		end
	end 
# set product dimensions (notes and analysis)
	def SIN.line_set_product_dimensions line, dimension_field, dimension_name_to_set
		SF.execute_script do
			line= line-1
			_product_dimension_input_pattern = $sin_product_dimension_input_pattern.sub($sf_param_substitute, dimension_field)
			_product_dimension_input = _product_dimension_input_pattern+"VAT:#{line}"+$sin_product_dimension_input_end
			find(:xpath, _product_dimension_input).set dimension_name_to_set
		end
	end
# set product line description
	def SIN.line_set_product_line_description line, description
		SF.execute_script do
			line= line-1
			_product_line_description = $sin_product_line_description_input+"VAT:#{line}"+$doc_line_input_end
			find(_product_line_description).set description
		end
	end
# set Generate Adjustment Journal
	def SIN.set_generate_adjustment_journal_checkbox checkbox_value_to_set
		SF.execute_script do
			if(checkbox_value_to_set)
				check($sin_generate_adjustment_journal_label)
			else
				uncheck($sin_generate_adjustment_journal_label)
			end
		end
	end
#get invoice account dimensions
	def SIN.get_invoice_account_dimension dimension_number
		SF.execute_script do
			dim_value = $sin_account_dimension_pattern_value.sub($sf_param_substitute , dimension_number.to_s)
			return find(:xpath , dim_value).text
		end
	end
# Click on Transaction link on Sales Invoice Page
	def	SIN.click_transaction_number
		SF.execute_script do
			page.has_xpath?($sin_transaction_link)
			find(:xpath , $sin_transaction_link).click	
		end
		SF.wait_for_search_button
	end
	
# get invoice status
	def SIN.get_status
		SF.execute_script do
			find(:xpath , $sin_status).text
		end
	end

# get invoice number
	def	SIN.get_invoice_number
		SF.execute_script do
			return find(:xpath , $sin_invoice_number).text
		end
	end

# get transaction number
	def	SIN.get_transaction_number
		SF.execute_script do
			return find(:xpath , $sin_transaction_value).text
		end
	end
#get invoice date
	def SIN.get_invoice_date
		SF.execute_script do
			return find(:xpath, $sin_invoice_date_value).text
		end
	end
# get invoice description
	def SIN.get_invoice_description
		SF.execute_script do
			return find(:xpath, $sin_invoice_description_value).text
		end
	end

# get invoice Payment Status
	def	SIN.get_invoice_payment_status
		SF.execute_script do
			return find(:xpath , $sin_sales_invoice_payment_status).text
		end
	end
# get Document Outstanding value
	def	SIN.get_invoice_payment_outstanding_value
		SF.execute_script do
			return find(:xpath , $sin_payment_outstanding_value).text
		end
	end

# get sales invoice total amount
	def SIN.get_invoice_total
		SF.execute_script do
			return find($sin_invoice_total_amount_value).text
		end
	end

# get Invoice net total
	def SIN.get_invoice_net_total
		find($sin_net_total_value).text
	end

# Full line in one go (default fields)
	def SIN.add_line line_no , product_name , line_quantity , unit_price , tax_code ,tax_value, income_schedule
		FFA.click_new_line
		if product_name != nil 
			SIN.line_set_product_name line_no, product_name 
		end 
		if line_quantity != nil 
			SIN.line_set_quantity line_no,line_quantity 
		end 
		if unit_price != nil 
			SIN.line_set_unit_price line_no, unit_price 
		end 
		if tax_code != nil 
			SIN.line_set_tax_code line_no,tax_code 
		end 
		if tax_value != nil 
			SIN.line_set_tax_value line_no,tax_value 
		end 
		if income_schedule != nil 
			SIN.line_set_income_schedule line_no, income_schedule 
		end
	end 

# open and view invoice from list view if invoice number is not known
#invoice_count is row no of grid view whose related invoice to be clicked 
	def SIN.view_invoice_detail invoice_count
		SF.execute_script do
			invoice_count = invoice_count + 1
			sales_invoice_number= $sin_invoice_number_pattern.gsub(""+$sf_param_substitute+"", invoice_count.to_s)
			page.has_xpath?(sales_invoice_number)
			find(:xpath, sales_invoice_number).click
		end
		SF.wait_for_search_button
	end

# get exchange rates - invoice rate
	def SIN.get_invoice_rate
		SF.execute_script do
			return find($sin_invoice_rate).text
		end
	end

# # Buttons
	def SIN.click_post_button
		SF.execute_script do
			find($sin_post_button_locator).click
		end
		SF.wait_for_search_button
	end
	def SIN.click_post_invoices
		SF.retry_script_block do 
			SF.execute_script do
				first(:button, $sin_post_invoices_button).click
			end
		end
		SF.wait_for_search_button
	end

# open SIN detail page
	def SIN.open_invoice_detail_page invoice_number
		record_to_click = $sin_sales_invoice_link_pattern.gsub($sf_param_substitute, invoice_number.to_s)
		find(:xpath , record_to_click).click
		page.has_text?(invoice_number)
	end

# click on exchange rate toggle icon	
	def SIN.click_exchange_rate_toggle_icon
		SF.retry_script_block do
			SF.execute_script do
				find($sin_toggle_exchange_rate).click
			end
		end
	end
# click on convert to credit note button
	def SIN.click_connvert_to_credit_note_button
		SF.execute_script do
			find($sin_convert_to_credit_note).click
		end
		SF.wait_for_search_button
	end

#################################
# payment schedule 
#################################
# set payment schedule
 	def SIN.set_payment_schedule payment_schedule
		SF.execute_script do
			select payment_schedule, :from => $sin_payment_schedule_label
			FFA.wait_page_message $ffa_msg_updating_payment_schedule_fields
		end
 	end
 
# set payment schedule intervals
 	def SIN.set_payment_schedule_number_of_payments num_of_payments
		SF.execute_script do
			find($sin_number_of_payments).set num_of_payments
		end
 	end

# set payment schedule first due date
 	def SIN.set_payment_schedule_first_due_date first_due_date
		SF.execute_script do
			find($sin_payment_schedule_first_due_date).set first_due_date
		end
 	end

# set payment schedule interval type
 	def SIN.set_payment_schedule_interval_type interval_type
		SF.execute_script do
			find($sin_payment_schedule_interval).select interval_type
		end
 	end 
# click calculate button to claculate payment schedule
	def SIN.click_calculate_payment_schedule_button
		SF.execute_script do
			find($sin_calculate_button).click
			FFA.wait_page_message $ffa_msg_calculating_payment_schedule
		end
	end
	
# click on product line toggle icon
	def SIN.click_product_line_toggle_icon
		SF.execute_script do
			find($sin_product_line_toggle_icon).click
		end
	end

# get period while creating sales invoice
	def SIN.get_invoice_period_before_save 
		SF.execute_script do
			return find($sin_invoice_period)[:value]
		end
	end

# get period after save of invoice
	def SIN.get_invoice_period_after_save
		SF.execute_script do
			return find(:xpath, $sin_invoice_period_value).text
		end
	end
# get customer reference value
	def SIN.get_customer_reference
		SF.execute_script do
			return find(:xpath, $sin_customer_reference_value).text
		end
	end

# get due date value
	def SIN.get_due_date
		SF.execute_script do
			return find(:xpath, $sin_due_date_value).text
		end
	end	
# get shipping method value
	def SIN.get_shipping_method
		SF.execute_script do
			return find(:xpath, $sin_shipping_method_value).text
		end
	end 

# get generate adjustment journal value
	def SIN.get_generate_adjustment_journal
		SF.execute_script do
			return find($sin_generate_adjustment_journal_value)[:title]
		end
	end 
# get income schedule value
	def SIN.get_income_schedule
		SF.execute_script do
			return find($sin_income_schedule_value).text
		end
	end
# get product dimension value
	def SIN.get_product_dimension line, dimension_field
		SF.execute_script do
			line = line-1
			_product_dimension_value_pattern = $sin_product_dimension_value_pattern.sub($sf_param_substitute, dimension_field)
			_product_dimension_value = _product_dimension_value_pattern.sub($sf_param_substitute, line.to_s)
			return find(:xpath, _product_dimension_value).text
		end
	end
# get product line description value
	def SIN.get_product_line_description line
		SF.execute_script do
			line= line-1
			return find(:xpath, $sin_product_line_description_value_pattern.sub($sf_param_substitute, line.to_s)).text
		end
	end
# get line item product name
	def SIN.line_get_product_name line
		SF.execute_script do
			_line_prod_name = $sin_line_prod_name_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_prod_name).text
		end
	end
# get line item quantity
	def SIN.line_get_quantity line
		SF.execute_script do
			_line_quantity = $sin_line_quantity_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_quantity).text
		end
	end
# get line item unit price
	def SIN.line_get_unit_price line
		SF.execute_script do
			_line_unit_price = $sin_line_unit_price_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_unit_price).text
		end
	end
# get line item tax code
	def SIN.line_get_tax_code line
		SF.execute_script do
			_line_tax_code = $sin_line_tax_code_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_tax_code).text
		end
	end
# get line item tax value
	def SIN.line_get_tax_value line
		SF.execute_script do
			_line_tax_value = $sin_line_tax_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_tax_value).text
		end
	end
# get payment schedule
	def SIN.get_payment_schedule
		SF.execute_script do
			return find($sin_payment_schedule).text
		end
	end
	
	# click on calculate sales tax button
	def SIN.click_calculate_tax_button
		SF.click_action $ffa_calculate_tax_button
	end
	
	# get Account Name
	def SIN.get_account_name
		return find(:xpath, $sin_account_name_link).text
	end
end
