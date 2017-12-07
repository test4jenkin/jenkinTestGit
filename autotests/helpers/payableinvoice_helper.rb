 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module PIN
extend Capybara::DSL
#############################
# Payable Invoice (VF pages)
#############################

###################################################
# Selectors
###################################################
$pin_invoice_account = "input[id$=':account']"
$pin_vendor_invoice_number = "input[id$='accountInvoiceNumber']"
$pin_expense_line_gla = "span[id*='glaName'] span.lookupInput input"
$pin_expense_new_line = "span[id*=':newExpenseLine'] input"
$pin_invoice_date = "input[id$=':invoiceDate']"
$pin_expense_line_input_net_value = ":netValue"
$pin_expense_line_tax_code = ":taxCode"
$pin_expense_line_reverse_charge = ":isReverseCharge"
$pin_invoice_product_name = "span.lookupInput input[id*=':productName']"
$pin_product_new_line = "span[id*=':newLine'] input"
$pin_product_line_quantity = ":quantity"
$pin_product_line_unit_price = ":unitPrice"
$pin_product_line_tax_code = ":taxCode"
$pin_product_line_reverse_charge = ":isReverseCharge"
$pin_invoice_number = "//th[text() = 'Payable Invoice Number']/following-sibling::td[1]/span"
$pin_invoice_account_value = "//span[@title='Toggle Analysis area']/ancestor::span[2]/span[1]"
$pin_invoice_status = "//th[text() = 'Invoice Status']/following-sibling::td[1]/span"
$pin_invoice_description = "//th[text() = 'Invoice Description']/following-sibling::td[1]/span"
$pin_invoice_reference1 = "//th[text() = 'Reference 1']/following-sibling::td[1]/span"
$pin_transaction_number = "//th[text() = 'Transaction']/following-sibling::td[1]/span"
$pin_vendor_invoice_number_value = "//th/label[contains(text(),'Vendor Invoice Number')]/..//following-sibling::td[1]/span/span"
$pin_invoice_total = "span[id$='invTotal']"
$pin_invoice_currency = "span[id$='selectCur']"
$pin_transaction_value = "//th[text()='Transaction']/following-sibling::td[1]/span"
$pin_payable_invoice_link_pattern = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$pin_currency_dual_rate = "div[class$='pbSubsection'] input[id$=':dualRate']"
$pin_invoice_date_value = ".//th[text()='Invoice Date']/following-sibling::td[1]/span"
$pin_transaction_value = "//th[text()='Transaction']/following-sibling::td[1]/span"
$pin_transaction_link = $pin_transaction_value + "/a"
$pin_account_dimension_pattern = "(//*[@class='pbSubsection'])[3]/table//tr["+$sf_param_substitute+"]/td/span"
$pin_account_toggle_icon = "a[title='Toggle Analysis area']"
$pin_expense_line_net_value = "td[id*=':dtExpenseLineItems'] span[id*=':"+$sf_param_substitute+":netValue']"
$pin_dimension1 = "//label[contains (text() , 'Dimension 1')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$pin_dimension2 = "//label[contains (text() , 'Dimension 2')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$pin_dimension3 = "//label[contains (text() , 'Dimension 3')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$pin_dimension4 = "//label[contains (text() , 'Dimension 4')]/../following-sibling::td//span[@class = 'lookupInput']//input"
$pin_expense_line_gla_toggle_icon = "span[title='Toggle Notes and Analysis area']"
$pin_product_line_item_header = "//h3[text()='Product Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/thead/tr/th"
$pin_expense_line_row_pattern= "//h3[text()='Expense Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/tbody/tr["+$sf_param_substitute+"]"
$pin_expense_line_net_value = "td[id*=':dtExpenseLineItems'] span[id*=':"+$sf_param_substitute+":netValue']"
$pin_product_line_item_row_pattern = "//h3[text()='Product Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/tbody/tr"
$pin_product_line_item_pattern = "//h3[text()='Product Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/tbody/tr["+$sf_param_substitute+"]/td["+$sf_param_substitute+"]"
$pin_expense_line_net_value_pattern = "td[id*=':dtExpenseLineItems'] span[id*=':"+$sf_param_substitute+":netValue']"
$pin_account_input_dimension_pattern = "(//*[@class='pbSubsection'])[3]/table//tr["+$sf_param_substitute+"]/td[1]/span/span[1]/input"
$pin_due_date = "input[id$=':dueDate']"
$pin_place_on_hold_button = "//input[@value='Place on Hold' and @class='btn']"
$pin_payable_invoice_by_vendor_invoice_number = "//div[contains(text(), '" + $sf_param_substitute + "')]/../..//span[contains(text(), 'PIN')] | //td[contains(text(), '" + $sf_param_substitute + "')]/..//a[contains(text(), 'PIN')]"
$pin_due_date_value= "//th[text()='Due Date']/following::td[1]/span"
###################################################
# payable invoice labels
###################################################
# Labels
$pin_invoice_currency_label = "Invoice Currency"
$pin_vendor_invoice_total_label = "Vendor Invoice Total"
$pin_discard_reason_label = "Discard Reason"
$pin_reference1_label = "Reference 1"
$pin_invoice_description_label = "Invoice Description"
$label_payable_invoice_manage_exp_lines = "Payable Invoice Expense Line Item"
$label_payable_invoice_manage_prod_lines = "Payable Invoice Line Item"
$pin_invoice_currency_label = "Invoice Currency"
$pin_vendor_invoice_total_label = "Vendor Invoice Total"
$pin_discard_reason_label = "Discard Reason"
$pin_reference1_label = "Reference 1"
$pin_vendor_invoice_number_label = "Vendor Invoice Number"
$pin_payable_invoice_number_label = "Payable Invoice Number"
# Buttons
$pin_release_for_payment = "Release for Payment"
$pin_amend_document_button = "Amend Document"
 
# Methods
	def PIN.set_invoice_account_dimension1 dimension_value
		SF.execute_script do
			 FFA.click_account_toggle_icon
			 find(:xpath ,$pin_dimension1).set dimension_value
			 FFA.click_account_toggle_icon
		end
	end 
	
	def PIN.set_invoice_account_dimension2 dimension_value
		SF.execute_script do
			 FFA.click_account_toggle_icon
			 find(:xpath ,$pin_dimension2).set dimension_value
			 FFA.click_account_toggle_icon
		end
	end 

# Dimension values for Gla 	
	def PIN.set_expense_line_gla_diemension1 dimension_value
		SF.execute_script do
			PIN.click_expense_line_gla_toggle_icon
			find(:xpath ,$pin_dimension1).set dimension_value
			PIN.click_expense_line_gla_toggle_icon
		end
	end
	
	def PIN.set_expense_line_gla_diemension2 dimension_value
		SF.execute_script do
			PIN.click_expense_line_gla_toggle_icon
			find(:xpath ,$pin_dimension2).set dimension_value
			PIN.click_expense_line_gla_toggle_icon
		end
	end
	
	def PIN.set_expense_line_gla_diemension3 dimension_value
		SF.execute_script do
			PIN.click_expense_line_gla_toggle_icon
			find(:xpath ,$pin_dimension3).set dimension_value
			PIN.click_expense_line_gla_toggle_icon
		end
	end
	
	def PIN.set_expense_line_gla_diemension4 dimension_value
		SF.execute_script do
			PIN.click_expense_line_gla_toggle_icon
			find(:xpath ,$pin_dimension4).set dimension_value
			PIN.click_expense_line_gla_toggle_icon
		end
	end

# set invoice description
	def PIN.set_invoice_description invoice_description
		SF.execute_script do
			fill_in $pin_invoice_description_label, :with => invoice_description
		end
	end

# set PIN Account
	def PIN.set_account account_name
		SF.execute_script do
			find($pin_invoice_account).set account_name
			gen_tab_out $pin_invoice_account
			FFA.wait_page_message $ffa_msg_retrieving_account_information
		end
	end
# set payable invoice date
	def PIN.set_invoice_date date
		SF.execute_script do
			find($pin_invoice_date).set date
			gen_tab_out $pin_invoice_date
			FFA.wait_page_message $ffa_msg_calculating_due_date_and_period
		end
	end
# change invoice currency
	def PIN.change_invoice_currency currency_name
		SF.execute_script do
			SF.click_button $ffa_change_currency_button
			select currency_name, :from => $pin_invoice_currency_label
			SF.click_button $ffa_apply_button
			FFA.wait_page_message $ffa_msg_changing_currency
		end
	end
# set dual rate for currency
	def PIN.set_currency_dual_rate dual_rate
		SF.execute_script do
			SF.retry_script_block do
				FFA.click_currency_rate_toggle_icon
				find($pin_currency_dual_rate).set dual_rate
				FFA.click_currency_rate_toggle_icon
			end
		end
	end
# set vendor invoice number
	def PIN.set_vendor_invoice_number invoice_number
		SF.execute_script do
			find($pin_vendor_invoice_number).set invoice_number
			gen_tab_out $pin_vendor_invoice_number
			FFA.wait_page_message $ffa_msg_working
		end
	end
# set vendor invoice total
	def PIN.set_vendor_invoice_total invoice_total
		SF.execute_script do
			fill_in $pin_vendor_invoice_total_label, :with => invoice_total
		end
	end
# set gla under expense line
	def PIN.set_expense_line_gla gla_name
		SF.execute_script do
			page.has_css?($pin_expense_line_gla)
			find($pin_expense_line_gla).set gla_name
		end
	end
# click new expense line
	def PIN.click_new_expense_line
		SF.execute_script do
			find($pin_expense_new_line).click
			FFA.wait_page_message $ffa_msg_adding_line
		end
	end
# set net value under expense line
	def PIN.set_expense_line_net_value line, net_value
		SF.execute_script do
			line = line-1		
			field  = FFA.append_expense_line_company_type line , $pin_expense_line_input_net_value				
			find(field).set net_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax_value
		end
	end
# set expense line tax code
	def PIN.set_expense_line_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_expense_line_company_type line , $pin_expense_line_tax_code
			find(field).set tax_code_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax_value
		end
	end
	
# set expense line output tax code(enable only when reverse charge is true for line item)
	def PIN.set_expense_line_output_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_expense_line_company_type line , $pin_expense_line_tax_code
			# SUbstituting the values to differentiate the locator of input tax code and output tax code
			output_tax_code_field = field.sub("VAT']" ,"VATExpenseOutput']").sub("SUT']" ,"SUTExpenseOutput']")
			find(output_tax_code_field).set tax_code_value
			gen_tab_out output_tax_code_field
			FFA.wait_page_message $ffa_msg_calculating_tax_value
		end
	end
	
# check reverse charge checkbox for expense line item
	def PIN.check_expense_line_reverse_charge line
		SF.execute_script do
			line = line-1
			field  = FFA.append_expense_line_company_type line , $pin_expense_line_reverse_charge
			find(field).set true
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_processing_reverse_charge
		end
	end
# set PIN product name
	def PIN.set_product_name product_name
		SF.execute_script do
			find($pin_invoice_product_name).set product_name
		end
	end
# click product new line
	def PIN.click_product_new_line
		SF.execute_script do
			find($pin_product_new_line).click
			FFA.wait_page_message $ffa_msg_adding_line
		end
	end
# set product line quantity
	def PIN.set_product_line_quantity line, quantity_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pin_product_line_quantity
			gen_wait_until_object field
			find(field).set quantity_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end
# set product line unit price
	def PIN.set_product_line_unit_price line, unit_price_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pin_product_line_unit_price
			find(field).set unit_price_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end	
# set product line tax code
	def PIN.set_product_line_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pin_product_line_tax_code
			find(field).set tax_code_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end
	
# set product line tax code
	def PIN.set_product_line_output_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pin_product_line_tax_code
			# SUbstituting the values to differentiate the locator of input tax code and output tax code
			output_tax_code_field = field.sub("VAT']" ,"VATOutput']").sub("SUT']" ,"SUTOutput']")
			find(output_tax_code_field).set tax_code_value
			gen_tab_out output_tax_code_field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end
	
# check reverse charge checkbox for expense line item
	def PIN.check_prod_line_reverse_charge line
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pin_product_line_reverse_charge
			prod_reverse_field = field.sub("VAT']" , "VATProductLine']").sub("SUT']" , "SUTProductLine']")
			find(prod_reverse_field).set true
			gen_tab_out prod_reverse_field
			FFA.wait_page_message $ffa_msg_processing_reverse_charge
		end
	end
# set discard reason on Payable Invoice Discard vf page
	def PIN.set_invoice_discard_reason discard_reason_text
		SF.execute_script do
			fill_in $pin_discard_reason_label, :with => discard_reason_text
		end
	end
# set PIN reference1
	def PIN.set_reference1 reference_text
		SF.execute_script do
			fill_in $pin_reference1_label, :with => reference_text
		end
	end

# set dimensions for account
	def PIN.set_account_dimension dimension_number , dimension_value
		SF.execute_script do
			find(:xpath, $pin_account_input_dimension_pattern.sub($sf_param_substitute, dimension_number.to_s)).set dimension_value
		end
	end
# set due date
	def PIN.set_due_date date
		SF.execute_script do
			find($pin_due_date).set date
		end
	end

# get PIN number
	def PIN.get_invoice_number
		SF.execute_script do
			return find(:xpath , $pin_invoice_number).text
		end
	end
# get PIN account
	def PIN.get_account
		SF.execute_script do
			return find(:xpath , $pin_invoice_account_value).text
		end
	end
# get PIN description
	def PIN.get_description
		SF.execute_script do
			return find(:xpath, $pin_invoice_description).text
		end
	end
# get PIN reference
	def PIN.get_reference1
		SF.execute_script do
			return find(:xpath, $pin_invoice_reference1).text
		end
	end
# getPIN vendor invoice number
	def PIN.get_vendor_invoice_number
		SF.execute_script do
			return find(:xpath , $pin_vendor_invoice_number_value).text
		end
	end
# get PIN total
	def PIN.get_invoice_total
		SF.execute_script do
			return find($pin_invoice_total).text
		end
	end
# get PIN currency
	def PIN.get_invoice_currency
		SF.execute_script do
			return find( $pin_invoice_currency).text
		end
	end
# get PIN Date
	def PIN.get_invoice_date
		SF.execute_script do
			return find(:xpath ,  $pin_invoice_date_value).text
		end
	end
# get PIN status
	def PIN.get_invoice_status
		SF.execute_script do
			return find(:xpath ,  $pin_invoice_status).text
		end
	end
	
# get due date value
	# return the due date of PIN document in string format
	def PIN.get_pin_due_date
		due_date = find(:xpath , $pin_due_date_value).text
		return due_date.to_s
	end
# click transaction link
	def PIN.click_transaction_link_and_wait
		SF.execute_script do
			find(:xpath ,$pin_transaction_link ).click 
		end
		SF.wait_for_search_button
	end
#get invoice account dimensions
	def PIN.get_invoice_account_dimension dimension_number
		SF.execute_script do
			dim_value = $pin_account_dimension_pattern.gsub($sf_param_substitute , dimension_number.to_s)
			return find(:xpath , dim_value).text
		end
	end
#get invoice transaction number
	def PIN.get_invoice_transaction_number
		SF.execute_script do
			if(page.has_xpath?($pin_transaction_link))
				return find(:xpath, $pin_transaction_value).text
			else
				return find(:xpath, $pin_transaction_number).text
			end
		end
	end

######################
# get payable invoice product line item details
# product_name- name of product for which value need to be retrieved 
# col_value_to_return- name of that column which value need to be returned
######################
	def PIN.get_product_line_data product_name , col_value_to_return
		SF.execute_script do
			allrows=all(:xpath , $pin_product_line_item_row_pattern)
			allcols = all(:xpath,$pin_product_line_item_header)
			row=1
			col=1
			while col <=allcols.count
				colvalue = find(:xpath,$pin_product_line_item_header+"["+col.to_s+"]").text
				if col_value_to_return == colvalue
					break
				end
			col+=1
			end
			while  row <= allrows.count
				linedata = $pin_product_line_item_pattern.sub($sf_param_substitute,row.to_s)
				cellvalue = find( :xpath , linedata.sub($sf_param_substitute,"2")).text 
				if product_name == cellvalue
					return find(:xpath , linedata.sub($sf_param_substitute,col.to_s)).text
				end
				row += 1
			end	
			return nil
		end
	end

######################
# get payable invoice product expense line item row content
# row_num- row_num(int) which row data need to be returned
######################
	def PIN.get_expense_line_row_data row_num
		SF.execute_script do
			return find(:xpath,$pin_expense_line_row_pattern.sub($sf_param_substitute , row_num.to_s)).text
		end
	end
# open payable invoice detail page
	def PIN.open_invoice_detail_page pin_number
		pin_number_to_click = $pin_payable_invoice_link_pattern.gsub($sf_param_substitute, pin_number.to_s)
		find(:xpath , pin_number_to_click).click
		page.has_text?(pin_number)
	end

# open payable invoice detail page via Vendor Invoice  Number
	def PIN.get_invoice_number_by_vendor_invoice_number vendor_invoice_number
		pin_number_to_click = $pin_payable_invoice_by_vendor_invoice_number.gsub($sf_param_substitute, vendor_invoice_number)
		return find(:xpath , pin_number_to_click).text
	end
	
	def	PIN.click_transaction_number 
		SF.execute_script do
			find(:xpath , $pin_transaction_link).click
		end
		SF.wait_for_search_button
	end

	# GLA Toggle Icon
	def PIN.click_expense_line_gla_toggle_icon
		SF.execute_script do
			find($pin_expense_line_gla_toggle_icon).click
		end
	end

	# Place on Hold
	def PIN.click_on_hold
		gen_wait_until_object $pin_place_on_hold_button
		SF.execute_script do
			find(:xpath, $pin_place_on_hold_button).click
		end
	end
end
