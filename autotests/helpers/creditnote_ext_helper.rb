
 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
 
SCRX_LINE_COLUMN_PRODUCT = 2
SCRX_LINE_COLUMN_QUANTITY = 8
SCRX_LINE_COLUMN_UNITPRICE = 9
 
module SCRX	
extend Capybara::DSL
#############################
# sales credit note (VF pages)
#############################
# Selectors

# Sales Credit Note Header New/Edit Mode
$scrx_add_new_line = "input[class= 'newlinebutton']"
$scrx_period_lookup_icon = "a[title='Period Lookup (New Window)']"
$scrx_account = "Account"
$scrx_credit_note_date = "Credit Note Date"
$scrx_dual_rate = "Dual Rate"
$scrx_credit_note_payment_status_paid = "Paid"
$scrx_account_input = "//label[text()='Account']/ancestor::td[1]/following::td[1]/span/input"
$scrx_account_dimension_pattern = "//label[text()='"+$sf_param_substitute+"']/ancestor::td[1]/following::td[1]/span/input"
$scrx_credit_note_date_field = "//label[text()='Credit Note Date']/ancestor::td[1]/following::td[1]//span/input | //div[contains(@class,'slds-modal__container')]//span[text()='Credit Note Date']/ancestor::label[1]/following::div[1]/input"
# Sales Credit Note Header view Mode
$scrx_credit_note_link = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$scrx_credit_note_description = "//td[text()='Credit Note Description']/following-sibling::td[1]/div | //div/span[text()='Credit Note Description']/ancestor::div[1]/following::div[1]/div/span"
$scrx_credit_note_status = ".//td[text()='Credit Note Status']/following-sibling::td[1]/div | //div/span[text()='Credit Note Status']/ancestor::div[1]/following::div[1]/div/span"
$scrx_credit_note_invoice_date = "//td[text()='Invoice Date']/following-sibling::td[1]/div | //div/span[text()='Invoice Date']/ancestor::div[1]/following::div[1]/div/span"
$scrx_credit_note_total = "//td[text()='Credit Note Total']/following-sibling::td[1]/div | //div/span[text()='Credit Note Total']/ancestor::div[1]/following::div[1]/div/span"
$scrx_credit_note_payment_status = "//td[text()='Payment Status']/following-sibling::td[1]/div"
$scrx_customer_reference_number = "//td[contains(text(), 'Customer Reference')]/following::td[1]/div | //div/span[text()='Customer Reference']/ancestor::div[1]/following::div[1]/div/span"
$scrx_credit_note_customer_reference = "input[id$='customerReference']"
$scrx_credit_note_transaction_number = "//td[text()='Transaction']/following-sibling::td[1]/div/a | //div/span[text()='Transaction']/ancestor::div[1]/following::div[1]/div/div/a"
$scrx_credit_note_number = ".//td[text()='Credit Note Number']/following-sibling::td[1]/div | //div/span[text()='Credit Note Number']/ancestor::div[1]/following::div[1]/div/span"
$scrx_line_quantity = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{SCRX_LINE_COLUMN_QUANTITY}) input"
$scrx_line_product = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{SCRX_LINE_COLUMN_PRODUCT}) span input"
$scrx_line_unit_price = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{SCRX_LINE_COLUMN_UNITPRICE}) input"
$scrx_line_tax_code = "table[id$='uberGrid'] tbody tr:nth-of-type("+$sf_param_substitute+") input[class*='input_TaxCode1__c']"
$scrx_manage_line_tax_code_lookup_icon_pattern = "table#uberGrid tr:nth-of-type("+$sf_param_substitute+") a[title='Tax Code Lookup (New Window)']"
$scrx_line_quantity_value = "//td[text()='Quantity']/following-sibling::td/div"
$scrx_line_net_value = "//td[text()='Net Value']/following-sibling::td/div"
$scrx_matched_payment_section = "iframe[title= 'creditnotematchingpayments']"
$scrx_invoice_number_value = "//td[text()='Invoice']/following-sibling::td/div/a | //div/span[text()='Invoice']/ancestor::div[1]/following::div[1]/div/div/a"
$scrx_credit_note_account_value = "//td[text()='Account']/following-sibling::td/div/a | //div/span[text()='Account']/ancestor::div[1]/following::div[1]/div/div/a"
$scrx_credit_note_currency_value = "//td[text()='Credit Note Currency']/following-sibling::td/div/a | //div/span[text()='Credit Note Currency']/ancestor::div[1]/following::div[1]/div/div/a"
$scrx_credit_note_line_item_number_pattern = "//h3[text()='Sales Credit Note Line Items']//ancestor::div[1]/following::div[1]/table/tbody/tr["+$sf_param_substitute+"]/th[1]/a"
$scrx_transaction_number = "//td[text()='Transaction']/following-sibling::td[1]/div/a | //div/span[text()='Transaction']/ancestor::div[1]/following::div[1]/div/div/a"
$scrx_credit_note_line_item_edit_link = "//a[text()='"+$sf_param_substitute+"']/../preceding-sibling::td/a[text()='Edit']"
$scrx_credit_note_date_value = "//td[text()='Credit Note Date']/following-sibling::td[1]/div"
$scrx_due_date_value = "//td[text()='Due Date']/following-sibling::td[1]/div"
$scrx_period_value = "//td[text()='Period']/following-sibling::td/div/a"
$scrx_credit_note_reason_value = "//td[text()='Credit Note Reason']/following-sibling::td/div"
$scrx_account_dimension_value_pattern = "//td[text()='"+$sf_param_substitute+"']/following-sibling::td/div/a"
$scrx_credit_note_line_item_id_link = "//a[text()='"+$sf_param_substitute+"']/../preceding-sibling::th/a | //a[text()='"+$sf_param_substitute+"']//ancestor::tr[1]/th[1]/a"
$scrx_dual_rate_input = "//label[text()='Dual Rate']/ancestor::td[1]/following::td[1]/input | //div[contains(@class,'slds-modal__container')]//span[text()='Dual Rate']//ancestor::div[1]/input"
# Sales Credit Note Line Item view Mode
$scrx_line_quantity_value = "//td[text()='Quantity']/following-sibling::td/div | //div/span[text()='Quantity']/ancestor::div[1]/following::div[1]/div/span"
$scrx_line_net_value = "//td[text()='Net Value']/following-sibling::td/div | //div/span[text()='Net Value']/ancestor::div[1]/following::div[1]/div/span"
$scrx_product_name_value = "//td[text()='Product Name']/following-sibling::td[1]/div/a"
$scrx_quantity_value = "//td[text()='Quantity']/following-sibling::td[1]/div"
$scrx_quantity="//label[text()='Quantity']"
$scrx_unit_price_value = "//td[text()='Unit Price']/following-sibling::td[1]/div"
$scrx_tax_code_value = "//td[text()='Tax Code']/following-sibling::td[1]/div/a"
$scrx_tax_value = "//td[text()='Tax Value']/following-sibling::td[1]/div"
$scrx_matched_payment_section_iframe_title="//h3[text()='Matched Payments']/ancestor::div[1]/following::div[1]//iframe | //section[@class='full oneCol forcePageBlockSection forcePageBlockSectionView']//iframe"
$scrx_payment_status_in_matched_payment =  "//a[text()='"+$sf_param_substitute+"']/ancestor::td[1]/following::td[8]"
$scrx_ajax_process_image_locator = "input[class*='ajax']"
$scrx_line_product_name_value = "//td[text()='Product Name']/following-sibling::td/div/a | //div/span[text()='Product Name']/ancestor::div[1]/following::div[1]/div/div/a"
# Buttons
$scrx_new_sales_credit_note_line_item_button = "input[value='New Sales Credit Note Line Item']"
# Labels
$scrx_product_name_label = "Product Name"
$scrx_line_number_label = "Line Number"
$scrx_derive_line_number_label = "Derive Line Number"
$scrx_quantity_label = "Quantity"
$scrx_due_date_label = "Due Date"
$scrx_credit_note_reason_label = "Credit Note Reason"
$scrx_credit_note_description_label = "Credit Note Description"
$scrx_dimension_1_label = "Dimension 1"
$scrx_dimension_2_label = "Dimension 2"
$scrx_dimension_3_label = "Dimension 3"
$scrx_dimension_4_label = "Dimension 4"
$scrx_tax_value_label = "Tax Value"
$scrx_customer_reference_label = "Customer Reference"
$scrx_unit_price_label = "Unit Price"
$scrx_tax_code_label = "Tax Code"
$scrx_view_all_credit_note_line_item_link = "a[data-relatedlistid='#{ORG_PREFIX}CreditNoteLineItems__r'] span[class='view-all-label']"
	

# Sales Invoice Extended Methods
	# get credit note transaction value
	def SCRX.get_credit_note_transaction_number
		return find(:xpath ,$scrx_credit_note_transaction_number).text
	end
	# get credit note number value
	def SCRX.get_credit_note_number
		return find(:xpath ,$scrx_credit_note_number).text
	end 
	#Extended Layout credit Note
	def SCRX.open_credit_note_detail_page credit_note_number
		 record_to_click = $scrx_credit_note_link.gsub($sf_param_substitute, credit_note_number.to_s)
		 find(:xpath , record_to_click).click
		 page.has_text?(credit_note_number)
	end
	# get credit note account value
	def SCRX.get_account_name
		return find(:xpath,$scrx_credit_note_account_value).text
	end
	# get credit note currency value
	def SCRX.get_credit_note_currency
		return find(:xpath,$scrx_credit_note_currency_value).text
	end
	# set credit note date
	def SCRX.set_creditnote_date credit_note_date
		find(:xpath,$scrx_credit_note_date_field).set credit_note_date
	end 
	# set credit note description
	def SCRX.get_credit_note_description 
		return find(:xpath ,$scrx_credit_note_description).text
	end 
	def SCRX.get_invoice_number
		return find(:xpath , $scrx_invoice_number_value).text
	end
	# get Credit Note status value
	def SCRX.get_credit_note_status
		return find(:xpath ,$scrx_credit_note_status).text
	end 
	# get credit note invoice date value 
	def SCRX.get_credit_note_invoice_date
		return find(:xpath ,$scrx_credit_note_invoice_date).text
	end 
	# get credit note total value
	def SCRX.get_credit_note_total
		return find(:xpath ,$scrx_credit_note_total).text
	end 
	# get customer reference value
	def SCRX.get_customer_reference_number
		return find(:xpath ,$scrx_customer_reference_number).text
	end 
	# get credit note payment status value 
	def SCRX.get_credit_note_payment_status
		return find(:xpath ,$scrx_credit_note_payment_status).text
	end 

# get credit note date
	def SCRX.get_credit_note_date
		return find(:xpath, $scrx_credit_note_date_value).text
	end
# get due date
	def SCRX.get_due_date
		return find(:xpath, $scrx_due_date_value).text
	end
# get credit note period value
	def SCRX.get_credit_note_period
		return find(:xpath, $scrx_period_value).text
	end
# get credit note reason value
	def SCRX.get_credit_note_reason
		return find(:xpath, $scrx_credit_note_reason_value).text
	end
# get account dimension value
	def SCRX.get_account_dimension dimension_field
		return find(:xpath, $scrx_account_dimension_value_pattern.sub($sf_param_substitute, dimension_field)).text
	end
	# set credit note account name
	def SCRX.set_account accountName
		SF.fill_in_lookup $scrx_account ,accountName
	end 
	# set dimension of credit note account
	def SCRX.set_account_dimension dimension_field, dimension_value
		SF.fill_in_lookup dimension_field , dimension_value
	end 
	# set dual rate 
	def SCRX.set_dual_rate dual_rate
		find(:xpath, $scrx_dual_rate_input).set dual_rate
	end 
	# click on add new line 
	def SCRX.add_new_line
		find($scrx_add_new_line).click
	end 
	# set credit note customer reference value
	def SCRX.set_customer_reference ref_value
		fill_in $scrx_customer_reference_label, :with => ref_value
	end 
	# set due date
	def SCRX.set_due_date due_date
		fill_in $scrx_due_date_label, :with => due_date
	end
	# set credit note reason
	def SCRX.set_credit_note_reason credit_note_reason
		select credit_note_reason, :from => $scrx_credit_note_reason_label
	end
	# set credit note description
	def SCRX.set_credit_note_description credit_note_description
		fill_in $scrx_credit_note_description_label, :with => credit_note_description
	end
	
	def SCRX.edit_customer_reference scn_customer_reference	
		find($scrx_credit_note_customer_reference).set(scn_customer_reference)
	end
# click on new sales credit note line items button
	def SCRX.click_new_sales_credit_note_line_items_button
		SF.on_related_list do
			page.has_css?($scrx_new_sales_credit_note_line_item_button)
			find($scrx_new_sales_credit_note_line_item_button).click
			SF.wait_for_search_button
		end
	end	
	# click sales credit note line item edit link from sales credit note (extended layout) detail page
	def SCRX.click_credit_note_line_item_edit_link product_name
		find(:xpath, $scrx_credit_note_line_item_edit_link.sub($sf_param_substitute, product_name)).click
		SF.wait_for_search_button
	end
# Adding line items through manage Line button
	# set  product name
	def SCRX.line_set_product_name  line , line_product_name
		SF.execute_script do
			product_field = $scrx_line_product.sub($sf_param_substitute,line)
			find(product_field).set line_product_name
			gen_tab_out product_field
			# waiting for process to complete
			gen_wait_until_object_disappear $scrx_ajax_process_image_locator
		end
	end 
	# set quantity value
	def SCRX.line_set_quantity  line , line_quanitiy
		SF.execute_script do
			quantity_field = $scrx_line_quantity.sub($sf_param_substitute,line)
			find(quantity_field).set line_quanitiy
			gen_tab_out quantity_field
			sleep 1 # for updating totale value
		end
	end
	# set unit price value
	def SCRX.line_set_unit_price  line , unit_price
		SF.execute_script do
			price_field= $scrx_line_unit_price.sub($sf_param_substitute,line)
			find(price_field).set unit_price
			gen_tab_out price_field
			sleep 1
		end
	end 
	# set tax code
	def SCRX.line_set_tax_code  line , tax_code
		SF.execute_script do
			tax_field= $scrx_line_tax_code.sub($sf_param_substitute,line)
			# Select tax code from lookup to avoid the error of duplicate value which starts with same name(ex- VO-S , VO-STD purchase)
			FFA.select_tax_code_from_lookup $scrx_manage_line_tax_code_lookup_icon_pattern.sub($sf_param_substitute,line),tax_code
			gen_tab_out tax_field		
			# waiting for process to complete.
			gen_wait_until_object_disappear $scrx_ajax_process_image_locator
		end
	end 
# Click on Transaction link on Sales Invoice Page
	def SCRX.click_transaction_number
		find(:xpath , $scrx_transaction_number).click 
	end
# get line item details 	
	def SCRX.line_get_product_name
		return find(:xpath,$scrx_line_product_name_value).text
	end
# get line item quantity	
	def SCRX.line_get_quantity
		return find(:xpath , $scrx_line_quantity_value).text
	end
# get line item net value
	def SCRX.line_get_net_value
		return find(:xpath, $scrx_line_net_value).text
	end
	 
# add a complete line item
	def SCRX.add_line_items line_no , product_name , line_quantity , unit_price , tax_code
		if product_name != nil 
			SCRX.line_set_product_name  line_no , product_name
		end 
		if line_quantity != nil 
			SCRX.line_set_quantity  line_no , line_quantity
		end 
		if unit_price != nil 
			SCRX.line_set_unit_price  line_no , unit_price
		end 
		if tax_code != nil 
			SCRX.line_set_tax_code  line_no , tax_code
		end 
		SF.wait_for_search_button
	end	
	#Credit Note View Page Methods
	#Match Payment Get methods
	def SCRX.is_document_number_in_matched_payment doc_id
		within_frame(find($scrx_matched_payment_section)) do 
			if (page.has_link?(doc_id))
				return true
			else
				return false
			end
		end
	 end

# view credit note  line items detail page
# line_number- line number of credit note line item
	def SCRX.view_invoice_line_item_detail_page line_number
		line_number+=1
		find(:xpath,$scrx_credit_note_line_item_number_pattern.sub($sf_param_substitute,line_number.to_s)).click
		SF.wait_for_search_button
	end
	
# get payment status from matched payment section 
# Pass the Document number for which payment status need to be retrieved
	def SCRX.get_payment_status_from_matched_payment_section doc_num
		within_frame(find(:xpath ,$scrx_matched_payment_section_iframe_title)) do
			value = find(:xpath ,$scrx_payment_status_in_matched_payment.sub($sf_param_substitute,doc_num.to_s) ).text
			return value
		end	
	end

#########################################################################
# Create Sales Credit Note Line Item through New Sales Credit Note Line Item button
#########################################################################
	# set product
	def SCRX.set_product product_name
		fill_in $scrx_product_name_label, :with => product_name
	end
	# set line number
	def SCRX.set_line_number line_no
		fill_in $scrx_line_number_label, :with => line_no
	end
	# set derive line number checkbox
	def SCRX.set_derive_line_number checkbox_value_to_set 
		if (checkbox_value_to_set)
			check($scrx_derive_line_number_label)
		else
			uncheck($scrx_derive_line_number_label)
		end
	end
	# set quantity
	def SCRX.set_quantity quantity_value
		qty_id = find(:xpath,$scrx_quantity)[:for]				
		fill_in(qty_id , :with => quantity_value)	
	end

	# set unit price_field
	def SCRX.set_unit_price unit_price
		fill_in $scrx_unit_price_label, :with => unit_price
	end
	# set tax code
	def SCRX.set_tax_code tax_code
		fill_in $scrx_tax_code_label, :with => tax_code
	end
	# set tax value
	def SCRX.set_tax_value tax_value
		fill_in $scrx_tax_value_label, :with => tax_value
	end
	# get product name
	def SCRX.get_product_name
		return find(:xpath, $scrx_product_name_value).text
	end
	# get quantity
	def SCRX.get_quantity
		return find(:xpath, $scrx_quantity_value).text
	end
	# get unit price
	def SCRX.get_unit_price
		return find(:xpath, $scrx_unit_price_value).text
	end
	# get tax code
	def SCRX.get_tax_code
		return find(:xpath, $scrx_tax_code_value).text
	end
	# get tax value
	def SCRX.get_tax_value
		return find(:xpath, $scrx_tax_value).text
	end
	# click sales credit note line item id on credit note detail page
	def SCRX.click_credit_note_line_item_id prod_name
		SCRX.on_credit_note_line_item do
			find(:xpath, $scrx_credit_note_line_item_id_link.gsub($sf_param_substitute, prod_name)).click
		end
	end
	
#####################################
# Related List action Items
# Use below methods to perform operation on related list items
#####################################	

# Execute the block code on invoice  line item page
	# If org is lightning, user will be redirected to line items page before executing the block of code.
	def SCRX.on_credit_note_line_item (&block)
		if (SF.org_is_lightning)
			SF.retry_script_block do
				find($sf_lightning_related_list_tab).click
				page.has_css?($scrx_view_all_credit_note_line_item_link)
				find($scrx_view_all_credit_note_line_item_link).click
				page.has_css?($page_grid_columns)
			end
		end
		block.call()
	end	
end