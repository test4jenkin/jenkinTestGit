 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
ICT_LINE_ITEM_ROW_START_NUM =2
ICT_LINE_ITEM_PRODUCT_COLUMN = 2
ICT_LINE_ITEM_UNIT_PRICE_COLUMN = 4
ICT_LINE_ITEM_VALUE_COLUMN = 5
ICT_LINE_ITEM_QUANTITY_COLUMN = 3
if (SF.org_is_lightning)
	# ICT Line Item Column Numbers
	ICT_LINE_ITEM_ROW_START_NUM = 1
	ICT_LINE_ITEM_PRODUCT_COLUMN = 3
	ICT_LINE_ITEM_UNIT_PRICE_COLUMN = 5
	ICT_LINE_ITEM_VALUE_COLUMN = 6
	ICT_LINE_ITEM_QUANTITY_COLUMN = 4
end
module ICT
extend Capybara::DSL
#############################
# InterCompany Transfer (vf pages)
#############################

###################################################
# Inter Company Transfer Selectors
###################################################
$ict_interompanytransfer_number = "div[id='Name_ileinner']"
$ict_record_type = "//td[text()='Record Type']/following-sibling::td[1]/div | //div/span[text()='Record Type']/ancestor::div[1]/following::div[1]/div[1]/div/div/div[1]/span[1]"
$ict_processing_status = ".//td[text()='Processing Status']/following-sibling::td[1]/div | //div/span[text()='Processing Status']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_processing_message = ".//td[text()='Processing Messages']/following-sibling::td[1]/div | //div/span[text()='Processing Messages']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_reason_for_rejection = ".//td[text()='Reason for Rejection']/following-sibling::td[1]/div"
$ict_source_company = ".//td[text()='Source Company']/following-sibling::td[1]/div | //div/span[text()='Source Company']/ancestor::div[1]/following::div[1]/div[1]/div/a"
$ict_source_sales_invoice_number = ".//td[text()='Source Sales Invoice Number']/following-sibling::td[1]/div | //div/span[text()='Source Sales Invoice Number']/ancestor::div[1]/following::div[1]//div/a"
$ict_source_credit_note_number = "//td[text()='Source Sales Credit Note Number']/following-sibling::td[1]/div | //div/span[text()='Source Sales Credit Note Number']/ancestor::div[1]/following::div[1]//div/a"
$ict_source_cash_entry_number = "//td[text()='Source Cash Entry Number']/following-sibling::td[1]/div | //div/span[text()='Source Cash Entry Number']/ancestor::div[1]/following::div[1]//div/a"
$ict_source_document_type = "//td[text()='Source Document Type']/following-sibling::td[1]/div | //div/span[text()='Source Document Type']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_source_journal_number = ".//td[text()='Source Journal Number']/following-sibling::td[1]/div | //div/span[text()='Source Journal Number']/ancestor::div[1]/following::div[1]//div/a"
$ict_source_document_currency = ".//td[text()='Source Document Currency']/following-sibling::td[1]/div | //div/span[text()='Source Document Currency']/ancestor::div[1]/following::div[1]/div[1]/div/a"
$ict_source_document_total = ".//td[text()='Source Document Total']/following-sibling::td[1]/div | //div/span[text()='Source Document Total']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_source_document_date = ".//td[text()='Source Document Date']/following-sibling::td[1]/div | //div/span[text()='Source Document Date']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_source_document_reference = ".//td[text()='Source Document Reference']/following-sibling::td[1]/div | //div/span[text()='Source Document Reference']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_source_document_description = ".//td[text()='Source Document Description']/..//td[2]/div | //div/span[text()='Source Document Description']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_destination_company = ".//td[text()='Destination Company']/following-sibling::td[1]/div | //div/span[text()='Destination Company']/ancestor::div[1]/following::div[1]/div[1]/div/a"
$ict_destination_payable_invoice_number = ".//td[text()='Destination Payable Invoice Number']/following-sibling::td[1]/div | //div/span[text()='Destination Payable Invoice Number']/ancestor::div[1]/following::div[1]/div[1]/div/a"
$ict_destination_payable_credit_note_number = ".//td[text()='Destination Payable Credit Note Number']/following-sibling::td[1]/div | //div/span[text()='Destination Payable Credit Note Number']/ancestor::div[1]/following::div[1]/div[1]/div/a"
$ict_destination_cash_entry_number = "//td[text()='Destination Cash Entry Number']/following-sibling::td[1]/div | //div/span[text()='Destination Cash Entry Number']/ancestor::div[1]/following::div[1]//div/a"
$ict_destination_journal_number = ".//td[text()='Destination Journal Number']/following-sibling::td[1]/div | //div/span[text()='Destination Journal Number']/ancestor::div[1]/following::div[1]//div/a"
$ict_destination_document_currency = ".//td[text()='Destination Document Currency']/following-sibling::td[1]/div"
$ict_destination_document_total = ".//td[text()='Destination Document Total']/following-sibling::td[1]/div"
$ict_destination_document_date = ".//td[text()='Destination Document Date']/following-sibling::td[1]/div"
$ict_destination_document_reference = ".//td[text()='Destination Document Reference']/following-sibling::td[1]/div"
$ict_destination_document_type = "//td[text()='Destination Document Type']/following-sibling::td[1] | //div/span[text()='Destination Document Type']/ancestor::div[1]/following::div[1]/div[1]/span"
$ict_number_link_pattern = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[text()='"+$sf_param_substitute+"']"
$ict_destination_document_description = ".//td[text()='Destination Document Description']/..//td[2]/div"
$ict_destination_bank_account_lookup = "a[title$='Destination Document Bank Account Lookup (New Window)']"
$ict_line_item_table_rows = "//h3[text()='Intercompany Transfer Line Items']/ancestor::table[1]/following::table[1]/tbody/tr | //div[@class = 'active oneContent']//div[contains(@class,'listViewContent')]//table//tbody/tr"
$ict_line_item_table_row_data = "//h3[text()='Intercompany Transfer Line Items']/ancestor::table[1]/following::table[1]/tbody/tr["+$sf_param_substitute+"]/td[#{ICT_LINE_ITEM_PRODUCT_COLUMN}] | //div[@class = 'active oneContent']//div[contains(@class,'listViewContent')]//table//tbody/tr["+$sf_param_substitute+"]/td[#{ICT_LINE_ITEM_PRODUCT_COLUMN}]" 
$ict_line_item_table_cell_data = "//h3[text()='Intercompany Transfer Line Items']/ancestor::table[1]/following::table[1]/tbody/tr["+$sf_param_substitute+"]/td[col_num] | //div[@class = 'active oneContent']//div[contains(@class,'listViewContent')]//table//tbody/tr["+$sf_param_substitute+"]/td[col_num]"
$ict_line_item_row_pattern = "//h3[text()='Intercompany Transfer Line Items']/ancestor::table[1]/following::table//a[text()='"+$sf_param_substitute+"']//ancestor::tr | //a[text()='"+$sf_param_substitute+"']//ancestor::tr[1]"
$ict_feed_tracking_object = "codaIntercompanyTransfer"
$ict_reject_reason_textarea = "div[class='requiredInput'] textarea"
$ict_accept_button_locator = "input[title='Accept']"
$ict_feed_tracking_options_label_locator = "//h3[text()='Fields in intercompany transfers']"
$ict_view_all_line_items_link = "//span[text()='View All']"
$ict_line_item_id_pattern = "//td[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/th[1]/a"
# ICT Line item detail page
$ict_line_amount_value = "//td[text()='Value']/following::td[1]/div"
$ict_line_dim2_value = "//td[text()='Dimension 2']/following::td[1]/div/a | //td[text()='Dimension 2']/following::td[1]/div"
$ict_line_dim3_value = "//td[text()='Dimension 3']/following::td[1]/div/a | //td[text()='Dimension 3']/following::td[1]/div"
$ict_line_gla_value = "//td[text()='General Ledger Account']/following::td[1]/div/a | //td[text()='General Ledger Account']/following::td[1]/div"
# buttons
$ict_reject_ict_button = "Reject"
$ict_accept_ict_button = "Accept"
$ict_accept_ict_button_locator = "input[title='Accept'] , div[title='Accept']"
$ict_process_button_locator = "input[title='Process'] , div[title='Process']"
#Labels
$label_ict_intercompany_transfer_number = "Intercompany Transfer Number"
$label_ict_source_document_description ="Source Document Description"
$label_ict_source_journal_number = "Source Journal Number"
$label_ict_destination_doc_bank_account = "Destination Document Bank Account"
$label_ict_process_button = "Process"

#Lightning specific
$ict_collaborate_chatter_section = "a[class='tabHeader'][title='Chatter']"
$ict_number_link_related_list = "//a/span[text()='Intercompany Transfers']/ancestor::li[1]/following::li[1]/a"

#############################
# InterCompany Transfer Methods
#############################
# set destination document bank account
	def ICT.set_destination_document_bank_account bank_account_name , company_name
		SF.retry_script_block do
			FFA.select_bank_account_from_lookup $ict_destination_bank_account_lookup, bank_account_name, company_name
		end
	end

# set ICT reject reason
	def ICT.set_ict_reject_reason reason
		SF.execute_script do 
			find($ict_reject_reason_textarea).set reason
		end
	end
#get InterCompany Transfer Record Type
	def ICT.get_record_type
		return find(:xpath ,$ict_record_type).text
	end 
#get ICT processing status
	def ICT.get_processing_status
		return find(:xpath , $ict_processing_status).text
	end 
#get processing message
	def ICT.get_processing_message
		return find(:xpath , $ict_processing_message).text
	end 
#get ict reason for rejection
	def ICT.get_reason_for_rejection
		return find(:xpath , $ict_reason_for_rejection).text
	end	

# Source Details
# get source company
	def ICT.get_source_company
		return find(:xpath , $ict_source_company).text
	end 
# get source sales invoice number 
	def ICT.get_source_sales_invoice_number
		return find(:xpath , $ict_source_sales_invoice_number).text
	end 
# get source sales invoice number 
	def ICT.get_source_sales_credit_note_number
		return find(:xpath , $ict_source_credit_note_number).text
	end
# get source journal number 
	def ICT.get_source_journal_number
		return find(:xpath , $ict_source_journal_number).text
	end
# get source cash entry number
	def ICT.get_source_cash_entry_number
		return find(:xpath , $ict_source_cash_entry_number).text
	end 
# get source document type 
	def ICT.get_source_document_type 
		return find(:xpath , $ict_source_document_type).text
	end
	
# get source document currency 
	def ICT.get_source_document_currency
		return find(:xpath , $ict_source_document_currency).text
	end
# get source document reference  
	def ICT.get_source_document_total
		return find(:xpath , $ict_source_document_total).text
	end
# get source document date 
	def ICT.get_source_document_date
		return find(:xpath , $ict_source_document_date).text
	end
# get source document reference 
	def ICT.get_source_document_reference
		return find(:xpath , $ict_source_document_reference).text
	end
# get document description
	def ICT.get_source_document_description
		return find(:xpath , $ict_source_document_description).text
	end

# Destination Details	
# get destination company name 
	def ICT.get_destination_company_name
		return find(:xpath , $ict_destination_company).text
	end 
# get destination payable invoice number 
	def ICT.get_destination_payable_invoice_number
		return find(:xpath , $ict_destination_payable_invoice_number).text
	end 
# get destination payable credit note number 
	def ICT.get_destination_payable_credit_note_number
		return find(:xpath , $ict_destination_payable_credit_note_number).text
	end 	
# get destination cash entry number 
	def ICT.get_destination_cash_entry_number 
		return find(:xpath , $ict_destination_cash_entry_number).text
	end		
# get destination journal number 
	def ICT.get_destination_journal_number
		return find(:xpath , $ict_destination_journal_number).text
	end
# get destination document currency 
	def ICT.get_destination_document_currency
		return find(:xpath , $ict_destination_document_currency).text
	end
# get destination document total  
	def ICT.get_destination_document_total
		return find(:xpath , $ict_destination_document_total).text
	end
# get destination document date 
	def ICT.get_destination_document_date
		return find(:xpath , $ict_destination_document_date).text
	end
# get destination document reference 
	def ICT.get_destination_document_reference
		return find(:xpath , $ict_destination_document_reference).text
	end
# get destination document description
	def ICT.get_destination_document_description
		return find(:xpath , $ict_destination_document_description).text
	end	
# get destination document type
	def ICT.get_destination_document_type
		return find(:xpath , $ict_destination_document_type).text
	end
# get processing confirmation message
	def ICT.get_confirmation_message
		return find($page_text_message).text
	end
	
# button- click process button from list view-	
	def ICT.click_button_process
		SF.retry_script_block do 
			SF.execute_script do
				find($ict_process_button_locator).click
			end
		end
		SF.wait_for_search_button
	end

	# Confirm ICT button- click process button to confirm the ICT process	
	def ICT.click_confirm_ict_process
		SF.retry_script_block do 
			SF.click_button $label_ict_process_button
		end
		SF.wait_for_search_button
	end
# button- click accept button to accept the rejected ICT.
	def ICT.click_accept_button
		SF.retry_script_block do
			SF.click_action $ict_accept_ict_button
		end
		SF.wait_for_search_button
	end
	
# assert chatter messages on intercompany transfer
	def ICT.is_chatter_content_available chatter_msg
		if (SF.org_is_lightning)
			page.has_css?($ict_collaborate_chatter_section)
			find($ict_collaborate_chatter_section).click
		end
		return page.has_text?(chatter_msg)
	end
	
#########################################
#get ICT line item details 
#product_key as product name for which details need to be retrieved , 
#column_number - column number of that column which value need to be returned.
########################################
	def ICT.get_ICT_line_item_details product_key , column_number
		line_data = nil
		ICT.on_ict_line_items do
			allrows  = all(:xpath , $ict_line_item_table_rows)
			row = ICT_LINE_ITEM_ROW_START_NUM
			# get line  values
			while  row <= allrows.count
				row_data = $ict_line_item_table_row_data.gsub($sf_param_substitute,row.to_s)
				cellvalue = find(:xpath , row_data).text
				if product_key == cellvalue
					ict_line_item_cell_data = $ict_line_item_table_cell_data.gsub($sf_param_substitute,row.to_s).gsub("col_num",column_number.to_s)
					line_data = find(:xpath , ict_line_item_cell_data).text
					break
				end
				row += 1
			end
		end
		# Navigate back to ICT detail page.
		if (SF.org_is_lightning)
			SF.retry_script_block do
			   find(:xpath,$ict_number_link_related_list).click
			   page.has_css?($sf_lightning_related_list_tab)
			end
		end
		# return line data for product.
		return line_data
	end	
# open ICT detail page
	def ICT.open_ICT_detail_page ict_number
		ict_record_to_click = $ict_number_link_pattern.gsub($sf_param_substitute, ict_number.to_s)
		find(:xpath , ict_record_to_click).click
		SF.wait_for_search_button
	end
	
###################################
# ICT LINE ITEMS
#################################

# open ICT line item detail page
# It will open the ICT line item detail page as per the passed line description of line.
# @line_description - pass the line description value of line which need to be viewed.
	def ICT.open_ict_line_item_by_line_description line_description
		ict_line_id = $ict_line_item_id_pattern.gsub($sf_param_substitute ,line_description )
		page.has_xpath?(ict_line_id)
		find(:xpath , ict_line_id).click
		page.has_text?(line_description)
	end
	
# get ICT Line amount value
	def ICT.get_ict_line_amount_value
		return find(:xpath , $ict_line_amount_value).text
	end
	
	# get line GLA
	def ICT.get_ict_line_gla_value
		return find(:xpath , $ict_line_gla_value).text
	end
	
	# get line dimension2 
	def ICT.get_ict_line_dim2_value
		return find(:xpath , $ict_line_dim2_value).text
	end
	
	# get line dimension2 
	def ICT.get_ict_line_dim3_value
		return find(:xpath , $ict_line_dim3_value).text
	end
#################################
# Related List 
#################################
# Execute code on the transaction line items related list page. 
    def ICT.on_ict_line_items (&block)
		# On Lightning org, Navigate to related list to view line items
		if (SF.org_is_lightning)
			find($sf_lightning_related_list_tab).click
		    page.has_xpath?($ict_view_all_line_items_link)
		    find(:xpath , $ict_view_all_line_items_link).click
		    SF.wait_for_search_button
		end
		# execute the code block on line item
		block.call()
    end
end 