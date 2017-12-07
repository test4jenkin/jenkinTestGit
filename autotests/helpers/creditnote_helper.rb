 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SCR
extend Capybara::DSL
#############################
# sales credit note (VF pages)
#############################
###################################################
# Selectors 
###################################################
# Credit Note Headers- New/Edit Mode
$scn_account = "input[id$='account']"
$scn_creditnote_date = "input[id$='creditNoteDate']"
$scn_invoice_date = "input[id$='invoiceDate']"
$scn_creditnote_due_date = "input[id$='dueDate']"
$scn_currency = "select[id$='selectCur']"
$scn_account_dimension1 = "//td[@class = 'data2Col first']//span[@class = 'lookupInput']//input"
$scn_account_dimension_pattern = "//label[contains(text(),'"+$sf_param_substitute+"')]/../following-sibling::td/span/span/input"
$scn_sales_credit_note_payment_status =  "//label[contains(text() , 'Payment Status')]/../following-sibling::td[1]"
# Credit Note Line Item- New/Edit Mode
$scn_line_product_name = ":product"
$scn_line_quantity = ":quantity"
$scn_line_unit_price = ":unitPrice"
$scn_line_tax_code = ":taxCode"
$scn_line_tax_value = ":taxValue"
$scn_currency_dual_rate =  "Dual Rate"
$scn_line_income_schedule = ":incomeSchedule"
# Credit Note Headers- View Mode
$scn_transaction_value = "//th[text()='Transaction']/following-sibling::td[1]/span"
$scn_transaction_link = $scn_transaction_value + "/a"
$scn_credit_note_customer_reference = "input[id$='customerReference']"
$scn_toggle_exchange_rate =  "span[id$='currencyRates'] img"
$scn_credit_note_description = "//th[text()='Credit Note Description']/following-sibling::td[1]/span"
$scn_credit_note_date_value = "//th[text()='Credit Note Date']/following-sibling::td[1]/span"
$scn_credit_note_status = "//th[text()='Credit Note Status']/following-sibling::td[1]/span"
$scn_account_name = "//label[normalize-space() = 'Account']/../following-sibling::td/span/span/a"
$scn_post_and_match = "input[value = 'Post & Match']"
$scn_successfully_match_msg = "successfully matched to Credit Note"
$scn_credit_note_number = "//th[text()='Credit Note Number']/following-sibling::td[1]/span"
$scn_listview_credit_note_number_link = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$scn_back_to_list_sales_credit_notes ="Back to List: Sales Credit Notes"
$scn_credit_note_total_value = "span[id$=':cnTotal']"
$scn_period_lookup_icon = "a[id*='creditNoteBlock:creditNoteDetail:period']"
$scn_customer_reference_value = "//label[contains(text(),'Customer Reference')]/../following-sibling::td/span"
$scn_credit_note_date_value = "//th[text()='Credit Note Date']/following-sibling::td[1]/span"
$scn_due_date_value = "//th[text()='Due Date']/following-sibling::td[1]/span"
$scn_period_value = "span[id$=':period'] a"
$scn_credit_note_reason_value = "//th[text()='Credit Note Reason']/following-sibling::td/span"
$scn_credit_note_description_value = "//th[contains(text(),'Credit Note Description')]/following-sibling::td/span"
$scn_line_quantity_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(4)"
$scn_line_unit_price_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(5) span"
$scn_line_tax_code_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(6) span a"
$scn_line_tax_value_pattern = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(7) span"
$scn_account_dimension_pattern_value = "(//*[@class='pbSubsection'])[3]/table//tr["+$sf_param_substitute+"]/td/span"
$scn_post_button_locator = "input[title='Post'] , a[title='Post']"
$scn_net_total_value = "span[id*=':netTotal']"
# Credit Note Line Item- View Mode
$scn_line_items_prod_name = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(2) span a"
$scn_line_items_net_value_on_edit = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(7) span"
$scn_line_items_net_value_after_save = "tr:nth-child("+$sf_param_substitute+") td[id*='dtLineItems']:nth-of-type(8) span"
#labels
$scn_currency_dual_rate_label = "Dual Rate"
$scn_dimension_1_label = "Dimension 1"
$scn_dimension_2_label = "Dimension 2"
$scn_dimension_3_label = "Dimension 3"
$scn_dimension_4_label = "Dimension 4"
$label_credit_note_number = "Credit Note Number"
$label_credit_note_status = "Credit Note Status"
#buttons
$scn_post_credit_notes_button = "Post Credit Notes"
$scn_post_match_button = "Post & Match"
$scn_amend_document_button = "Amend Document"

# Methods 
# sales crdit note  Header
# set credit note account
	def SCR.set_account scn_accountName
		SF.execute_script do
			find($scn_account).set scn_accountName
			gen_tab_out $scn_account
			FFA.wait_page_message $ffa_msg_retrieving_account_information
		end
	end 
# set credit note date
	def SCR.set_creditnote_date credit_note_date
		SF.execute_script do
			find($scn_creditnote_date).set credit_note_date
			gen_tab_out $scn_creditnote_date
			FFA.wait_page_message $ffa_msg_updating_taxrate_duedate_period
		end
	end 
# set credot note invoice date
	def SCR.set_invoice_date credit_note_invoice_date
		SF.execute_script do
			find($scn_invoice_date).set credit_note_invoice_date
			gen_tab_out $scn_invoice_date
			FFA.wait_page_message $ffa_msg_updating_taxrate
		end
	end 
# setting credit note account dimension 1	
	def SCR.set_credit_note_account_dimension1 dimension_value
		SF.execute_script do
			FFA.click_account_toggle_icon
			find(:xpath ,$scn_account_dimension1).set dimension_value
			FFA.click_account_toggle_icon
		end
	end 
# set credit note due date 
	def SCR.set_due_date credit_note_due_date
		SF.execute_script do
			find($scn_creditnote_due_date).set credit_note_due_date
			gen_tab_out $scn_creditnote_due_date
		end
	end 
# set credit note customer reference 
	def SCR.set_customer_reference scn_customer_reference
		SF.execute_script do
			fill_in "Customer Reference", :with=> scn_customer_reference		
		end
	end 
# Amend(edit) credit note customer reference
	def SCR.edit_customer_reference scn_customer_reference
		SF.execute_script do
			find($scn_credit_note_customer_reference).set(scn_customer_reference)
		end
	end
# set credit Note reason 
	def SCR.select_reason creditnote_reason
		SF.execute_script do
			select(creditnote_reason, :from => "Credit Note Reason")
		end
	end
# set credit note currency (set the surrency after setting the credit note account)
	def SCR.set_currency creditnote_currency
		SF.execute_script do
			click_button "Change Currency"
			select(creditnote_currency, :from => 'Credit Note Currency') 
			click_button "Apply"
			FFA.wait_page_message $ffa_msg_changing_currency
		end
	end 
# set credit note description 
	def SCR.set_description credit_note_description
		SF.execute_script do
			fill_in "Credit Note Description" , :with => credit_note_description
		end
	end 
# set credit note account dimension
	def SCR.set_account_dimension dimension_field, dimension_name_to_set
		SF.execute_script do
			scn_account_dimension = $scn_account_dimension_pattern.gsub($sf_param_substitute, dimension_field)
			find(:xpath, scn_account_dimension).set dimension_name_to_set
		end
	end

# set product name 
	def SCR.line_set_product_name  line , line_product_name
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $scn_line_product_name
			find(field).set line_product_name
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end
# setting currency Dual Rate
	def SCR.set_currency_dual_rate dual_rate
		SF.execute_script do
			SCR.click_exchange_rate_toggle_icon
			fill_in $scn_currency_dual_rate_label , :with => dual_rate
			SCR.click_exchange_rate_toggle_icon
		end
	end 
# set quantity 
	def SCR.line_set_quantity line , line_quantity
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $scn_line_quantity
			find(field).set line_quantity
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end 
# set unit price 
	def SCR.line_set_unit_price  line , line_unit_price
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $scn_line_unit_price
			find(field).set line_unit_price
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_line
		end
	end 
# set tax code 
	def SCR.line_set_tax_code  line , line_tax_code
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $scn_line_tax_code
			find(field).set line_tax_code
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end 
# set tax value 
	def SCR.line_set_tax_value  line , line_tax_value
		SF.execute_script do
			line = line - 1 ;
			field  = FFA.append_company_type line , $scn_line_tax_value
			find(field).set line_tax_value
			gen_tab_out field
			FFA.wait_page_message $ffa_msg_calculating_tax
		end
	end 
	
# get invoice Payment Status
	def	SCR.get_document_payment_status
		SF.execute_script do
			return find(:xpath , $scn_sales_credit_note_payment_status).text
		end
	end
# Full line in one go (default fields)
	def SCR.add_line line_no , product_name , line_quantity , unit_price , tax_code ,tax_value
		FFA.click_new_line
		if product_name != nil 
			SCR.line_set_product_name line_no, product_name 
		end 
		if line_quantity != nil 
			SCR.line_set_quantity line_no,line_quantity 
		end 
		if unit_price != nil 
			SCR.line_set_unit_price line_no, unit_price 
		end 
		if tax_code != nil 
			SCR.line_set_tax_code line_no,tax_code 
		end 
		if tax_value != nil 
			SCR.line_set_tax_value line_no,tax_value 
		end 
	end
# get credit note  number
	def SCR.get_credit_note_number
		SF.execute_script do
			return find(:xpath , $scn_credit_note_number).text
		end
	end
# get credit note total
	def SCR.get_credit_note_total
		SF.execute_script do
			return find($scn_credit_note_total_value).text
		end
	end
	
# get net total value 
	def SCR.get_scn_net_total
		find($scn_net_total_value).text
	end
# Click on Transaction link on Sales credit note Page
	def SCR.click_transaction_number
		SF.execute_script do
			find(:xpath , $scn_transaction_link).click		
		end
		SF.wait_for_search_button
	end 
#get credit note account dimensions
	def SCR.get_credit_note_account_dimension dimension_number
		SF.execute_script do
			dim_value = $scn_account_dimension_pattern_value.gsub($sf_param_substitute , dimension_number.to_s)
			return find(:xpath , dim_value).text
		end
	end
	
# Open credit note detail page
	def SCR.open_credit_note_detail_page credit_note_number
		SF.execute_script do
			find(:xpath , $scn_listview_credit_note_number_link.gsub($sf_param_substitute, credit_note_number.to_s)).click
		end
	end
	
# get account name
	def SCR.get_account_name
		SF.execute_script do
			return find(:xpath, $scn_account_name).text
		end
	end

# get line item product name
	def SCR.line_get_product_name line_no
		SF.execute_script do
			_line_prod_name = $scn_line_items_prod_name.gsub($sf_param_substitute, line_no.to_s)
			return find(_line_prod_name).text
		end
	end
# get line item quantity
	def SCR.line_get_quantity line
		SF.execute_script do
			_line_quantity = $scn_line_quantity_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_quantity).text
		end
	end
# get line item unit price
	def SCR.line_get_unit_price line
		SF.execute_script do
			_line_unit_price = $scn_line_unit_price_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_unit_price).text
		end
	end
# get line item tax code
	def SCR.line_get_tax_code line
		SF.execute_script do
			_line_tax_code = $scn_line_tax_code_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_tax_code).text
		end
	end
# get line item tax value
	def SCR.line_get_tax_value line
		SF.execute_script do
			_line_tax_value = $scn_line_tax_value_pattern.gsub($sf_param_substitute, line.to_s)
			return find(_line_tax_value).text
		end
	end	
# get credit note net value
	def SCR.line_get_net_value line_no
		SF.execute_script do
			if (page.has_button?($sf_save_button))
				_line_net_value = $scn_line_items_net_value_on_edit.gsub($sf_param_substitute, line_no.to_s)
			else
				_line_net_value = $scn_line_items_net_value_after_save.gsub($sf_param_substitute, line_no.to_s)
			end
			return find(_line_net_value).text
		end
	end
# get customer reference value
	def SCR.get_customer_reference
		SF.execute_script do
			return find(:xpath, $scn_customer_reference_value).text
		end
	end
# get credit note date value
	def SCR.get_credit_note_date
		SF.execute_script do
			return find(:xpath, $scn_credit_note_date_value).text
		end
	end
# get due date value
	def SCR.get_due_date
		SF.execute_script do
			return find(:xpath, $scn_due_date_value).text
		end
	end	
# get credit note period value
	def SCR.get_credit_note_period
		SF.execute_script do
			return find($scn_period_value).text
		end
	end
# get credit note reason
	def SCR.get_credit_note_reason
		SF.execute_script do
			return find(:xpath, $scn_credit_note_reason_value).text
		end
	end
# get credit note description value
	def SCR.get_credit_note_description
		SF.execute_script do
			return find(:xpath, $scn_credit_note_description_value).text
		end
	end
# Click on transaction link at detail page of credit note
	def SCR.click_transaction
		SF.execute_script do
			find(:xpath, $scn_transaction_link).click
		end
		SF.wait_for_search_button
	end

# # Buttons
# click on post button
	def SCR.click_post_button
		SF.execute_script do
			find($scn_post_button_locator).click
		end
		SF.wait_for_search_button
	end
# bulk post credit note
	def SCR.click_post_credit_note
		SF.execute_script do
			first(:button, $scn_post_credit_notes_button).click
		end
		SF.wait_for_search_button
	end
# get credit note status
	def SCR.get_credit_note_status
		SF.execute_script do
			page.has_xpath?($scn_credit_note_status)
			return find(:xpath , $scn_credit_note_status).text
		end
	end
# click on post and match button
	def SCR.click_post_match_credit_note
		SF.execute_script do
			find($scn_post_and_match).click
		end
		SF.wait_for_search_button
	end
# click on exchange rate toggle icon to set dual currency rate	
	def SCR.click_exchange_rate_toggle_icon
		SF.execute_script do
			find($scn_toggle_exchange_rate).click
		end
	end
# check for a successfull matching message.	
	def SCR.expect_successful_matching_msg
		SF.execute_script do
			if(page.has_text?($scn_successfully_match_msg))
				return true
			else
				return false
			end
		end
	end

#get credit note transaction number
	def SCR.get_transaction_number
		SF.execute_script do
			return find(:xpath, $scn_transaction_value).text
		end
	end
	
# click on calculate sales tax button
	def SCR.click_calculate_tax_button
		SF.click_action $ffa_calculate_tax_button
	end
end 