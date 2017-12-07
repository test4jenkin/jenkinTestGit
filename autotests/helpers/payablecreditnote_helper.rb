 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module PCR
extend Capybara::DSL

#############################
# payable credit note (VF pages)
#############################
# payable credit note selectors
$pcr_credit_note_account = "input[id$=':account']"
$pcr_vendor_credit_note_number = "[id$=':accountCreditNoteNumber']"
$pcr_expense_line_gla = "span[id*='glaName'] span.lookupInput input"
$pcr_credit_note_date = "[id$=':creditNoteDate']"
$pcr_credit_note_due_date_value= "//th[text()='Due Date']/following::td[1]/span"
$pcr_expense_new_line = "span[id*=':newExpenseLine'] input"
$pcr_expense_line_input_net_value = ":netValue"
$pcr_expense_line_tax_code = ":taxCode"
$pcr_expense_line_output_tax_code = "ExpenseOutput"
$pcr_product_line_output_tax_code = "Output"
$pcr_product_name = "span.lookupInput input[id*=':productName']"
$pcr_product_new_line = "span[id*=':newLine'] input"
$pcr_product_line_quantity = ":quantity"
$pcr_product_line_unit_price = ":unitPrice"
$pcr_product_line_tax_code = ":taxCode"
$pcr_credit_note_number = "//th[text() = 'Credit Note Number']/following-sibling::td[1]/span"
$pcr_vendor_credit_note_number_convertto_creditnote = "//label[contains(text(),'Vendor Credit Note Number')]/../following-sibling::td[1]/span/input"
$pcr_credit_note_account_value = "//*[@title='Toggle Analysis area']/ancestor::span[2]/span[1]/a"
$pcr_credit_note_description="span[id$='creditNoteDescription']"
$pcr_credit_note_reference1="span[id$='reference1']"
$pcr_credit_note_currency = "span[id$='currencyvalue']"
$pcr_transaction_value = "//th[text()='Transaction']/following-sibling::td[1]/span"
$pcr_transaction_link = $pcr_transaction_value + "/a"
$pcr_currency_dual_rate = "div[class$='pbSubsection'] input[id$=':dualRate']"
$pcr_number_link_pattern = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$pcr_credit_note_status = "//th[text() = 'Credit Note Status']/following-sibling::td[1]/span"
$pcr_credit_note_total = "span[id$='invTotal']"
$pcr_account_dimension_pattern = "(//*[@class='pbSubsection'])[3]/table//tr["+$sf_param_substitute+"]/td"
$pcr_expense_line_net_value_pattern = "td[id*=':dtExpenseLineItems'] span[id*=':"+$sf_param_substitute+":netValue']"
$pcr_expense_line_net_value = "td[id*=':dtExpenseLineItems'] span[id*=':"+$sf_param_substitute+":netValue']"
$pcr_product_line_item_row_pattern = "//h3[text()='Product Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/tbody/tr"
$pcr_product_line_item_pattern = "//h3[text()='Product Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/tbody/tr["+$sf_param_substitute+"]/td["+$sf_param_substitute+"]"
$pcr_product_line_item_header = "//h3[text()='Product Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/thead/tr/th"
$pcr_account_input_dimension_pattern = "(//*[@class='pbSubsection'])[3]/table//tr["+$sf_param_substitute+"]/td[1]/span/span[1]/input"
$pcr_expense_line_row_pattern= "//h3[text()='Expense Lines']/ancestor::div[1]/following::div[1]/table/tbody/tr/td/table/tbody/tr["+$sf_param_substitute+"]"
# Labels
$pcr_credit_note_reason_label = "Credit Note Reason"
$pcr_credit_note_currency_label = "Credit Note Currency"
$pcr_vendor_credit_note_total_label = "Vendor Credit Note Total"
$pcr_reference1_label = "Reference 1"
$pcr_discard_reason_label = "Discard Reason"
$pcr_credit_note_description_label = "Credit Note Description"
$label_payable_credit_note_manage_exp_lines = "Payable Credit Note Expense Line Item"
$label_payable_credit_note_manage_prod_lines = "Payable Credit Note Line Item"
$label_payable_credit_note_number = "Credit Note Number"
$label_vendor_credit_note_number  = "Vendor Credit Note Number"
# Buttons
$pcr_amend_document_button = "Amend Document" 
$pcr_expense_line_reverse_charge = ":isReverseCharge"
$pcr_product_line_reverse_charge = ":isReverseCharge"

$pcr_text_vat = "VAT']"
$pcr_text_vat_productline =  "VATProductLine']"
$pcr_text_sut = "SUT']"
$pcr_text_sut_productline = "SUTProductLine']"
 
#############################
# payable credit note methods
#############################
# set PCR account
	def PCR.set_account account_name
		SF.execute_script do
			find($pcr_credit_note_account).set account_name		
			gen_tab_out $pcr_credit_note_account
			FFA.wait_page_message $ffa_msg_retrieving_account_information
		end
	end

# set payable credit note  date
	def PCR.set_payable_credit_note_date date
		SF.execute_script do
			find($pcr_credit_note_date).set date
			gen_tab_out $pcr_credit_note_date
			FFA.wait_page_message $ffa_msg_calculating_due_date_and_period
		end
	end

# select payable credit note reason
	def PCR.select_credit_note_reason option_name
		SF.execute_script do
			select option_name, :from => $pcr_credit_note_reason_label
		end
	end

# change payable credit note currency
	def PCR.change_credit_note_currency currency_name
		SF.execute_script do
			SF.click_button $ffa_change_currency_button
			select currency_name, :from => $pcr_credit_note_currency_label
			SF.click_button $ffa_apply_button
			FFA.wait_page_message $ffa_msg_changing_currency
		end
	end

# set dual rate for currency
	def PCR.set_currency_dual_rate dual_rate
		SF.execute_script do
			SF.retry_script_block do
				FFA.click_currency_rate_toggle_icon
				find($pcr_currency_dual_rate).set dual_rate
				FFA.click_currency_rate_toggle_icon
			end
		end
	end
	
# set vendor credit note number
	def PCR.set_vendor_credit_note_number credit_note_number
		SF.execute_script do
			find($pcr_vendor_credit_note_number).set credit_note_number
			gen_tab_out $pcr_vendor_credit_note_number
			FFA.wait_page_message $ffa_msg_working
		end
	end
# set vendor credit note number on purchase invoice convert to creditnote VF page
	def PCR.set_vendor_credit_note_number_convert credit_note_number
		SF.execute_script do
			find(:xpath, $pcr_vendor_credit_note_number_convertto_creditnote).set credit_note_number
		end
	end
# set vendor credit note total
	def PCR.set_vendor_credit_note_total credit_note_total
		SF.execute_script do
			fill_in $pcr_vendor_credit_note_total_label, :with => credit_note_total
		end
	end
# set gla under expense line
	def PCR.set_expense_line_gla gla_name
		SF.execute_script do
			gen_wait_until_object $pcr_expense_line_gla
			find($pcr_expense_line_gla).set gla_name
		end
	end
# click new expense line on PCR
	def PCR.click_new_expense_line
		SF.execute_script do
			find($pcr_expense_new_line).click
			FFA.wait_page_message $ffa_msg_adding_line
		end
	end
# set net value under expense line
	def PCR.set_expense_line_net_value line, net_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_expense_line_company_type line , $pcr_expense_line_input_net_value
			find(field).set net_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax_value
		end
	end
# set PCR expense line tax code
	def PCR.set_expense_line_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_expense_line_company_type line , $pcr_expense_line_tax_code
			find(field).set tax_code_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax_value
		end
	end
# set PCR product name
	def PCR.set_product_name product_name
		SF.execute_script do
			find($pcr_product_name).set product_name
		end
	end
# click PCR product new line
	def PCR.click_product_new_line
		SF.execute_script do
			find($pcr_product_new_line).click
			FFA.wait_page_message $ffa_msg_adding_line
		end
	end
# set PCR product line quantity
	def PCR.set_product_line_quantity line, quantity_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pcr_product_line_quantity
			page.has_css?(field)
			find(field).set quantity_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end
# set PCR product line unit price
	def PCR.set_product_line_unit_price line, unit_price_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pcr_product_line_unit_price
			find(field).set unit_price_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end	
# set PCR product line tax code
	def PCR.set_product_line_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pcr_product_line_tax_code
			find(field).set tax_code_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end
# set PCR reference
	def PCR.set_reference1 reference_text
		SF.execute_script do
			fill_in $pcr_reference1_label, :with => reference_text
		end
	end
# set PCR discard reason on Payable Credit Note Discard vf page
	def PCR.set_credit_note_discard_reason discard_reason_text
		SF.execute_script do
			fill_in $pcr_discard_reason_label, :with => discard_reason_text
		end
	end

# set credit note description
	def PCR.set_credit_note_description credit_note_description
		SF.execute_script do
			fill_in $pcr_credit_note_description_label, :with => credit_note_description
		end
	end

# set dimensions for account
	def PCR.set_account_dimension dimension_number , dimension_value
		SF.execute_script do
			find(:xpath, $pcr_account_input_dimension_pattern.sub($sf_param_substitute, dimension_number.to_s)).set dimension_value
		end
	end
	
# get credit note number
	def PCR.get_credit_note_number
		SF.execute_script do
			return find(:xpath , $pcr_credit_note_number).text
		end
	end
# get PCR account
	def PCR.get_account
		SF.execute_script do
			return find(:xpath , $pcr_credit_note_account_value).text
		end
	end
# get PCR description
	def PCR.get_description
		SF.execute_script do
			return find($pcr_credit_note_description).text
		end
	end
# get PCR reference
	def PCR.get_reference1
		SF.execute_script do
			return find($pcr_credit_note_reference1).text
		end
	end

# get PCR vendor credit note number
	def PCR.get_vendor_credit_note_number
		SF.execute_script do
			return find($pcr_vendor_credit_note_number).text
		end
	end
# get PCR total
	def PCR.get_credit_note_total
		SF.execute_script do
			return find($pcr_credit_note_total).text
		end
	end
# get PCR currency
	def PCR.get_credit_note_currency
		SF.execute_script do
			return find($pcr_credit_note_currency).text
		end
	end
# get PCR Date
	def PCR.get_credit_note_date
		SF.execute_script do
			return find($pcr_credit_note_date).text
		end
	end
# get PCR status
	def PCR.get_credit_note_status
		SF.execute_script do
			return find(:xpath ,  $pcr_credit_note_status).text
		end
	end
# get due date value
	# return the due date of PCR document in string format
	def PCR.get_pcr_due_date
		due_date = find(:xpath , $pcr_credit_note_due_date_value).text
		return due_date.to_s
	end

# Click on Transaction link on credit note Page
	def PCR.click_transaction_number
		SF.execute_script do
			find(:xpath , $pcr_transaction_link).click			
		end
		SF.wait_for_search_button
	end
#get credit note transaction number
	def PCR.get_credit_note_transaction_number
		SF.execute_script do
			if(page.has_xpath?($pcr_transaction_link))
				return find(:xpath, $pcr_transaction_link).text
			else
				return find(:xpath, $pcr_transaction_value).text
			end	
		end
	end

######################
# get payable credit note  product line item details
# product_name- name of product for which value need to be retrieved 
# col_value_to_return- name of that column which value need to be returned
######################
	def PCR.get_product_line_data product_name , col_value_to_return
		SF.execute_script do
			allrows=all(:xpath , $pcr_product_line_item_row_pattern)
			allcols = all(:xpath,$pcr_product_line_item_header)
			row=1
			col=1
			while col <=allcols.count
				colvalue = find(:xpath,$pcr_product_line_item_header+"["+col.to_s+"]").text
				if col_value_to_return == colvalue
					break
				end
			col+=1
			end
			while  row <= allrows.count
				linedata = $pcr_product_line_item_pattern.sub($sf_param_substitute,row.to_s)
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
# get payable credit note   expense line item row content
# row_num- row_num(int) which row data need to be returned
######################
	def PCR.get_expense_line_row_data row_num
		SF.execute_script do
			return find(:xpath,$pcr_expense_line_row_pattern.sub($sf_param_substitute , row_num.to_s)).text
		end
	end
#get credit note account dimensions
	def PCR.get_creditnote_account_dimension dimension_number
		SF.execute_script do
			dim_value = $pcr_account_dimension_pattern.gsub($sf_param_substitute , dimension_number.to_s)
			return find(:xpath , dim_value).text
		end
	end
	
# open PCR detail page
	def PCR.open_credit_note_detail_page credit_note_number
		SF.execute_script do
			record_to_click = $pcr_number_link_pattern.gsub($sf_param_substitute, credit_note_number.to_s)
			find(:xpath , record_to_click).click
		end
		page.has_text?(credit_note_number)
	end
	
	# check reverse charge checkbox for expense line item
	def PCR.check_expense_line_reverse_charge line
		SF.execute_script do
			line = line-1
			field  = FFA.append_expense_line_company_type line , $pcr_expense_line_reverse_charge
			page.has_css?(field)
			find(field).set true
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_processing_reverse_charge
		end
	end
	
	# check reverse charge checkbox for product line item
	def PCR.check_prod_line_reverse_charge line
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pcr_product_line_reverse_charge
			prod_reverse_field = field.sub($pcr_text_vat , $pcr_text_vat_productline).sub($pcr_text_sut , $pcr_text_sut_productline)
			page.has_css?(prod_reverse_field)
			find(prod_reverse_field).set true
			gen_tab_out prod_reverse_field
			FFA.wait_page_message $ffa_msg_processing_reverse_charge
		end
	end
	
	# set PCR expense line output tax code
	def PCR.set_expense_line_output_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_expense_line_company_type line , $pcr_expense_line_tax_code 
			field = field.gsub($doc_line_input_end,$pcr_expense_line_output_tax_code + $doc_line_input_end )
			find(field).set tax_code_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax_value
		end
	end
	
	# set PCR product line output tax code
	def PCR.set_product_line_output_tax_code line, tax_code_value
		SF.execute_script do
			line = line-1
			field  = FFA.append_company_type line , $pcr_product_line_tax_code
			field = field.gsub($doc_line_input_end,$pcr_product_line_output_tax_code + $doc_line_input_end )
			find(field).set tax_code_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end
end
