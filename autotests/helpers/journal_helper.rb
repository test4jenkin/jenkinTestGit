 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module JNL
extend Capybara::DSL
#############################
# Journal (VF pages)
#############################

###################################################
# journal Selectors
###################################################
$jnl_journal_type="span[id$='type']"
$jnl_journal_date = "input[id$='journalDate']"
$jnl_journal_period = "span[id$='period']"
$jnl_journal_reference = "[id$='reference']"
$jnl_journal_description = "input[id$='description']"
$jnl_journal_description_value = "span[id$='description']"
$jnl_journal_change_currency_button = "input[id$='currencyChange']"
$jnl_journal_change_currency_apply_button = "input[value$='Apply']"
$jnl_journal_line_value = "input[class='newline_lookup']"
$jnl_journal_new_line = "a[id$='newLine']"
$jnl_journal_status = ".//th[text() = 'Journal Status']/..//td[1]/span[1]"
$jnl_journal_line_amount = ":value"
$jnl_journal_line_gla = ":gla"
$jnl_journal_line_local_gla = ":glaAC"
$jnl_journal_line_description = ":lineDescription"
$jnl_journal_line_dimension1 = ":lineDim1"
$jnl_journal_line_dimension2 = ":lineDim2"
$jnl_journal_line_dimension3 = ":lineDim3"
$jnl_journal_line_dimension4 = ":lineDim4"
$jnl_journal_number = "span[id$='journalNo']"
$jnl_journal_total_value = "span[id$='total']"
$jnl_journal_line_destination_account = "input[id$=':destinationPicker_account']"
$jnl_journal_line_destination_bank_account = "input[id$=':destinationPicker_bankAccount']"
$jnl_journal_line_destination_gla = "input[id$=':destinationPicker_gla']"
$jnl_journal_line_destination_product = "input[id$=':destinationPicker_product']" 
$jnl_journal_line_destination_taxcode= "input[id$=':destinationPicker_taxCode']"
$jnl_journal_line_item_rows = "tbody[id$='dtLineItems:tb'] tr"
$jnl_journal_line_gla_value_pattern = "span[id$='dtLineItems:"+$sf_param_substitute+":gla']"
$jnl_journal_line_amount_value_pattern = "span[id$='dtLineItems:"+$sf_param_substitute+":value']"
$jnl_journal_line_description_pattern = "//span[contains(@id,'dtLineItems:"+$sf_param_substitute+":lineDescription_cancel')]/../.."
$jnl_journal_transaction_number = "span[id$='transactionNo'] a"
$jnl_journal_line_analysis_details = "a[id$=':"+$sf_param_substitute+":analysislink']"
$jnl_journal_analysis_detail_tax_value = "input[id$='inputTaxValue1']"
$jnl_journal_analysis_detail_taxable_value = "input[id$='inputTaxableValue']"
$jnl_journal_analysis_detail_account_analysis ="input[id$='inputAccountAnalysis']"
$jnl_journal_analysis_detail_close = "a.closeAnalysis"
$jnl_journal_header_override_currency_icon = "a#hrefPos"
$jnl_journal_line_override_currency_icon = "a[id$=':"+$sf_param_substitute+":currencyvalueslink']"
$jnl_journal_override_currency_acc_lookup = "a[title='Accounting Currency Lookup (New Window)']"
$jnl_journal_override_debit_value = "input[id$='overrideCurrencyValue"+$sf_param_substitute+"']"
$jnl_journal_override_curr_values_dual = "input[id$='currValuesDual']"
$jnl_journal_custom_popup = "div[id$=':currencyvaluesheaderpage']  div[class='customPopup ui-widget-content']"
$jnl_journal_line_custom_popup = "div[id*='currencyvaluespage'] div[class='customPopup ui-widget-content']"
$jnl_journal_debits = "span[id$='debits']"
$jnl_journal_credits = "span[id$='credits']"
$jnl_journal_tax_total = "span[id$='taxTotal']"
$jnl_journal_taxable_value_total = "span[id$='taxableValueTotal']"
$jnl_journal_number_pattern = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[text()='"+$sf_param_substitute+"']"
$jnl_journal_dimension1_value = "div[id$='dtLineItems:"+$sf_param_substitute+ ":Dim1Div']"
$jnl_journal_dimension2_value = "div[id$='dtLineItems:"+$sf_param_substitute+ ":Dim2Div']"
$jnl_journal_dimension3_value = "div[id$='dtLineItems:"+$sf_param_substitute+ ":Dim3Div']"
$jnl_journal_dimension4_value = "div[id$='dtLineItems:"+$sf_param_substitute+ ":Dim4Div']"
$jnl_loading_image = "img[src='/img/loading.gif']"
$jnl_line_override_currency_enter_value_text = "Enter Values"
$jnl_reference_value_pattern = "div.x-grid3-body div:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
$jnl_value_to_find_in_grid_pattern = "div.x-grid3-body div:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
$jnl_journal_number_by_position_pattern = "//div["+$sf_param_substitute+"]/table/tbody/tr/td[4]/div/a/span[starts-with(text(),'JNL')] | //div[@class='active oneContent']//div[@class='listViewContainer']//table/tbody/tr["+$sf_param_substitute+"]/th/span/a"
$jnl_back_to_journal_list =  "Back to List: Journals"
$jnl_reverse_period_input = "a[title='Period Lookup (New Window)']"
$jnl_line_item_analysis_icon = "a[Id*='dtLineItems:"+$sf_param_substitute+ ":analysislink'] img"
$jnl_line_local_gla_in_analysis_popup = "//span[text()='Local GLA']["+$sf_param_substitute+"]"
$jnl_type_text = "[type='text']"
$jnl_gla_in_analysis_popup= "[Id*='inputGLA'][type='text']"
$jnl_line_local_gla_in_popup = "(//span[text()='Local GLA']/following-sibling::span)["+$sf_param_substitute+"]/span/a"
#buttons
$jnl_cancel_journal = "Cancel Journal"
$jnl_destination_line_type_label = "Destination Line Type"
$jnl_line_type_label = "Line Type"
$jnl_journal_currency_label = "Journal Currency"
$jnl_validate_button_locator = "input[value='Validate']"
$jnl_amend_document_button = "Amend Document"
#labels
$label_jnl_destination_line_type_account_customer = "Account - Customer"
$label_jnl_destination_line_type_account_vendor = "Account - Vendor"
$label_jnl_destination_line_type_bank_account = "Bank Account"
$label_jnl_destination_line_type_gla = "General Ledger Account"
$label_jnl_destination_line_type_product_sales = "Product - Sales"
$label_jnl_destination_line_type_product_purchases = "Product - Purchases"
$label_jnl_destination_line_type_tax_code = "Tax Code"
$label_journal_number = "Journal Number"
$label_journal_type = "Type"
$label_jnl_reference = "Reference"

#############################
# Journal Methods
#############################
# set Journal Header details
# set journal date
	def JNL.set_journal_date journal_date
		SF.execute_script do
			find($jnl_journal_date).set journal_date
			gen_tab_out $jnl_journal_date
			FFA.wait_page_message $ffa_msg_updating_taxrate_duedate_period
		end
	end 

# set journal reference 
	def JNL.set_journal_reference journal_reference
		SF.execute_script do
			find($jnl_journal_reference).set journal_reference
		end
	end 
# set journal description
	def JNL.set_journal_description journal_description
		SF.execute_script do
			find($jnl_journal_description).set journal_description
		end
	end 
# set currency
	def JNL.set_journal_currency journal_currency
		SF.execute_script do
			click_button "Change Currency"
			select(journal_currency, :from => $jnl_journal_currency_label)
			click_button "Apply"
			FFA.wait_page_message $ffa_msg_changing_currency
		end
	end
# set line type
	def JNL.select_journal_line_type journal_line_type
		SF.execute_script do
			select(journal_line_type, :from => $jnl_line_type_label) 
		end
	end
# set line value
	def JNL.select_journal_line_value journal_line_value
		SF.execute_script do
			find($jnl_journal_line_value).set journal_line_value
			gen_tab_out $jnl_journal_line_value
		end
	end
# set destination line type 
	def JNL.select_destination_line_type line_type
		SF.execute_script do
			select(line_type, :from => $jnl_destination_line_type_label) 
			gen_wait_less
		end
	end
# set destination line value as per the destination line type
	def JNL.set_destination_line_type_value destination_line_type , line_type_value
		SF.execute_script do
			if (destination_line_type == $label_jnl_destination_line_type_account_customer || destination_line_type == $label_jnl_destination_line_type_account_vendor)
				find($jnl_journal_line_destination_account).set line_type_value
				gen_tab_out $jnl_journal_line_destination_account
				elsif (destination_line_type == $label_jnl_destination_line_type_product_sales || destination_line_type == $label_jnl_destination_line_type_product_purchases)
					find($jnl_journal_line_destination_product).set line_type_value
					gen_tab_out $jnl_journal_line_destination_product
				elsif destination_line_type == $label_jnl_destination_line_type_bank_account
					find($jnl_journal_line_destination_bank_account).set line_type_value
					gen_tab_out $jnl_journal_line_destination_bank_account
				elsif destination_line_type == $label_jnl_destination_line_type_gla
					find($jnl_journal_line_destination_gla).set line_type_value
					gen_tab_out $jnl_journal_line_destination_gla
				elsif destination_line_type == $label_jnl_destination_line_type_tax_code
					find($jnl_journal_line_destination_taxcode).set line_type_value
					gen_tab_out $jnl_journal_line_destination_taxcode
				else
					raise "please provide a valid destination line type and destination line value."
			end
		end
	end
# set journal line amount
	def JNL.line_set_journal_amount  line , line_amount
		SF.execute_script do
			line = line - 1 ;
			field = $doc_line_input+":#{line}"+$jnl_journal_line_amount+$doc_line_input_end
			find(field).set line_amount
			gen_tab_out field
			page.has_button?("Save")
		end
	end 

# set journal line gla
	def JNL.line_set_journal_gla  line , line_gla
		SF.execute_script do
			line = line - 1 ;
			field = $doc_line_input+":#{line}"+$jnl_journal_line_gla+$doc_line_input_end
			# To set the Local GLA in General Ledger Account field in line item.
			localgla_field = $doc_line_input+":#{line}"+$jnl_journal_line_local_gla+$doc_line_input_end
			gla_field = field + "," + localgla_field
			gen_wait_until_object gla_field
			find(gla_field).set line_gla
			gen_tab_out gla_field
			gen_wait_until_object_disappear $ffa_processing_button_locator
		end
	end 

# click analysis details link
	def JNL.line_click_journal_analysis_details line
		SF.execute_script do
			line= line - 1
			line_analysis_link = $jnl_journal_line_analysis_details.gsub($sf_param_substitute, line.to_s)
			find(line_analysis_link).click
		end
	end

# set tax value on analysis details pop up	
	def JNL.line_set_analysis_details_tax_value tax_value
		SF.execute_script do
			find($jnl_journal_analysis_detail_tax_value).set tax_value
		end
	end
	
# set taxable value on analysis details pop up
	def JNL.line_set_analysis_details_taxable_value taxable_value
		SF.execute_script do
			find($jnl_journal_analysis_detail_taxable_value).set taxable_value
		end
	end
	
# set account analysis on analysis details pop up
	def JNL.line_set_analysis_details_account_analysis acc_analysis
		SF.execute_script do
			find($jnl_journal_analysis_detail_account_analysis).set acc_analysis
		end
	end
	
# close analysis details popup	
	def JNL.line_close_analysis_detail_popup
		SF.execute_script do
			find($jnl_journal_analysis_detail_close).click
			gen_wait_until_object_disappear $jnl_loading_image
		end
	end

# add analysis details on journal line items
	def JNL.add_line_analysis_details line_no ,line_tax_value,line_taxable_value,line_account_analysis_value 
		JNL.line_click_journal_analysis_details line_no
		if line_tax_value!=nil
			JNL.line_set_analysis_details_tax_value line_tax_value
		end
		if line_taxable_value!=nil
			JNL.line_set_analysis_details_taxable_value line_taxable_value
		end
		if line_account_analysis_value!=nil
			JNL.line_set_analysis_details_account_analysis line_account_analysis_value
		end
		JNL.line_close_analysis_detail_popup
	end
# click override currency value icon at header
	def JNL.header_click_override_currency_values
		SF.retry_script_block do
			SF.execute_script do
				find($jnl_journal_header_override_currency_icon).click
			end
		end
	end
	
# click override currency value icon at line items
	def JNL.line_click_override_currency_values line
		SF.execute_script do
			line= line - 1
			line_override_curr_value = $jnl_journal_line_override_currency_icon.gsub($sf_param_substitute, line.to_s)
			find(line_override_curr_value).click
			page.has_text?($jnl_line_override_currency_enter_value_text)
		end
	end
	
# set debit value at override currency values pop up
	def JNL.set_total_override_debit_value row_no, debit_value
		SF.execute_script do
			jnl_override_debit_value = $jnl_journal_override_debit_value.gsub($sf_param_substitute, row_no.to_s)
			find(jnl_override_debit_value).set debit_value
		end
	end
	
# set dual value at override currency values pop up
	def JNL.set_override_curr_values_dual_usd dual_value
		SF.execute_script do
			find($jnl_journal_override_curr_values_dual).set dual_value
		end
	end
	
# save override currency values at header
	def JNL.save_override_curr_values
		SF.execute_script do
			within($jnl_journal_custom_popup) do
				first(:button, $ffa_save_button).click
				gen_wait_until_object_disappear $jnl_loading_image
			end
		end
	end
# save override currency values on line 
	def JNL.save_line_override_curr_values
		within($jnl_journal_line_custom_popup) do
			first(:button, $ffa_save_button).click
			gen_wait_until_object_disappear $jnl_loading_image
		end
	end
	
# set journal line description
	def JNL.line_set_journal_description  line , line_description
		SF.execute_script do
			line = line - 1 ;
			field = $doc_line_input+":#{line}"+$jnl_journal_line_description+$doc_line_input_end
			find(field).set line_description
			gen_tab_out field
		end
	end 

# set journal line dimension 1
	def JNL.line_set_journal_dimension1  line , line_dimension1
		SF.execute_script do
			line = line - 1 ;
			field = $doc_line_input+":#{line}"+$jnl_journal_line_dimension1+$doc_line_input_end
			find(field).set line_dimension1
			gen_tab_out field
		end
	end 

# set journal line dimension 2
	def JNL.line_set_journal_dimension2  line , line_dimension2
		SF.execute_script do
			line = line - 1 ;
			field = $doc_line_input+":#{line}"+$jnl_journal_line_dimension2+$doc_line_input_end
			field = field.sub("$","*") + $jnl_type_text
			find(field).set line_dimension2
			gen_tab_out field
		end
	end
# set journal line dimension 3
	def JNL.line_set_journal_dimension3  line , line_dimension3
		SF.execute_script do
			line = line - 1 ;
			field = $doc_line_input+":#{line}"+$jnl_journal_line_dimension3+$doc_line_input_end
			find(field).set line_dimension3
			gen_tab_out field
		end
	end
# set journal line dimension 4
	def JNL.line_set_journal_dimension4  line , line_dimension4
		SF.execute_script do
			line = line - 1 ;
			field = $doc_line_input+":#{line}"+$jnl_journal_line_dimension4+$doc_line_input_end
			find(field).set line_dimension4
			gen_tab_out field
		end
	end
# Full line in one go (default fields)
	def JNL.add_line line_no , gla_value  , line_amount , line_description , line_dim1 ,line_dim2, line_dim3,line_dim4
		JNL.click_journal_new_line
		if gla_value != nil 
			JNL.line_set_journal_gla  line_no , gla_value
		end 
		if line_amount != nil 
			JNL.line_set_journal_amount  line_no , line_amount
		end 
		if line_description != nil 
			JNL.line_set_journal_description  line_no , line_description
		end 
		if line_dim1 != nil 
			JNL.line_set_journal_dimension1  line_no , line_dim1
		end 
		if line_dim2 != nil 
			JNL.line_set_journal_dimension2  line_no , line_dim2
		end 
		if line_dim3 != nil 
			JNL.line_set_journal_dimension3  line_no , line_dim3 
		end
		if line_dim4 != nil 
			JNL.line_set_journal_dimension4  line_no , line_dim4
		end
	end 
	
# get journal type 
	def JNL.get_journal_type 
		SF.execute_script do
			return find($jnl_journal_type).text
		end
	end

# get journal reference 
	def JNL.get_journal_reference 
		SF.execute_script do
			return find($jnl_journal_reference).text
		end
	end 
# get journal description
	def JNL.get_journal_description 
		SF.execute_script do
			find($jnl_journal_description_value).text
		end
	end 

# get journal line gla
	def JNL.line_get_journal_gla  line 
		SF.execute_script do
			line = line - 1 ;
			field = $jnl_journal_line_gla_value_pattern.sub($sf_param_substitute,line.to_s) + " a"
			return find(field).text
		end
	end 
# get journal line value
	def JNL.line_get_journal_line_value  line 
		SF.execute_script do
			line = line - 1 ;
			return find($jnl_journal_line_amount_value_pattern.sub($sf_param_substitute,line.to_s)).text
		end
	end 

# get journal line dimension 1
	def JNL.line_get_journal_dimension1  line 
		SF.execute_script do
			line = line - 1 ;
			journal_dimension1_value = $jnl_journal_dimension1_value.gsub(""+ $sf_param_substitute +"", line.to_s)
			return find(journal_dimension1_value).text
		end
	end 

# get journal line dimension 2
	def JNL.line_get_journal_dimension2  line 
		SF.execute_script do
			line = line - 1 ;
			journal_dimension2_value = $jnl_journal_dimension2_value.gsub(""+ $sf_param_substitute +"", line.to_s)
			return find(journal_dimension2_value).text
		end
	end
# set journal line dimension 3
	def JNL.line_get_journal_dimension3  line 
		SF.execute_script do
			line = line - 1 ;
			journal_dimension3_value = $jnl_journal_dimension3_value.gsub(""+ $sf_param_substitute +"", line.to_s)
			return find(journal_dimension3_value).text
		end
	end
# set journal line dimension 4
	def JNL.line_get_journal_dimension4  line
		SF.execute_script do
			line = line - 1 ;
			journal_dimension4_value = $jnl_journal_dimension4_value.gsub(""+ $sf_param_substitute +"", line.to_s)
			return find(journal_dimension4_value).text
		end
	end
	
	# get journal line local gla from popup
	def JNL.line_get_local_gla line
	    local_gla=""
		SF.execute_script do
			journal_local_gla_value = $jnl_line_local_gla_in_popup.gsub($sf_param_substitute, line.to_s)
			local_gla = find(:xpath,journal_local_gla_value).text
		end
		return local_gla
	end
	
	#click on analysis Icon of line 
	def JNL.click_line_analysis_popup_icon line
		line = line -1
		journal_line_item_analyss_icon = $jnl_line_item_analysis_icon.gsub($sf_param_substitute , line.to_s)
		page.has_css?(journal_line_item_analyss_icon)	
		find(journal_line_item_analyss_icon).click
	end
	
	# set journal line gla in analysis popup
	def JNL.set_general_ledger_account_in_analysis_popup line, gla_value
		SF.execute_script do
			line = line -1		    
			field = $doc_line_input+":#{line}"+$doc_line_input_end+ $jnl_gla_in_analysis_popup
			field = field.sub("$","*")
			page.has_css?(field)
			find(field).set gla_value			
		end
	end
	
# get journal number
	def JNL.get_journal_number
		SF.execute_script do
			return find($jnl_journal_number).text
		end
	end

# get journal total
	def JNL.get_journal_total
		SF.execute_script do
			return find($jnl_journal_total_value).text
		end
	end
# get journal transaction number
	def JNL.get_journal_transaction_number
		SF.execute_script do
			return find($jnl_journal_transaction_number).text
		end
	end
# get journal status
	def JNL.get_journal_status
		SF.execute_script do
			return find(:xpath , $jnl_journal_status).text
		end
	end

# get journal period
	def JNL.get_journal_period
		SF.execute_script do
			return find($jnl_journal_period).text
		end
	end

#get journal debits
	def JNL.get_journal_debits
		SF.execute_script do
			return find($jnl_journal_debits).text
		end
	end
#get journal credits
	def JNL.get_journal_credits
		SF.execute_script do
			return find($jnl_journal_credits).text
		end
	end
#get journal tax total
	def JNL.get_journal_tax_total
		SF.execute_script do
			return find($jnl_journal_tax_total).text
		end
	end
#get journal taxable value total
	def JNL.get_journal_taxable_value_total
		SF.execute_script do
			return find($jnl_journal_taxable_value_total).text
		end
	end	

# get journal line number by searching GLA and line_amount/value as a combination
	def JNL.line_get_journal_line_item_number general_ledger_account_value , line_amount
		SF.execute_script do
			number_of_product_line_items =  all($jnl_journal_line_item_rows)
			row = 0
			while row <= number_of_product_line_items.count-1
				gla_value = find($jnl_journal_line_gla_value_pattern.sub($sf_param_substitute,row.to_s)).text
				amount_value = find($jnl_journal_line_amount_value_pattern.sub($sf_param_substitute,row.to_s)).text
				if general_ledger_account_value == gla_value  
					if line_amount == amount_value
						break
					end
				end
			row+=1
			end
			return row+=1
		end
	end

# open Journal detail page
	def JNL.open_journal_detail_page journal_number
		journal_number_to_click = $jnl_journal_number_pattern.gsub( $sf_param_substitute , journal_number.to_s)
		find(:xpath , journal_number_to_click).click
		page.has_text?(journal_number)	
	end
	
	def JNL.click_back_to_journal_list
		SF.execute_script do
			click_link($jnl_back_to_journal_list)
		end
		SF.wait_for_search_button
	end
# open journal page as per its position on page list
	def JNL.open_journal_detail_page_by_position journal_count
		SF.execute_script do
			journal_number= $jnl_journal_number_by_position_pattern.gsub(""+$sf_param_substitute+"", journal_count.to_s)
			find(:xpath, journal_number).click	
		end
	end
# click on back to list to retrun to journal list view
	def JNL.click_back_to_journal_list
		SF.execute_script do
			click_link($jnl_back_to_journal_list)
		end
		SF.wait_for_search_button
	end	
# button
# New  Line Items for Journal
	def JNL.click_journal_new_line
		SF.execute_script do
			find($jnl_journal_new_line).click 
			FFA.wait_page_message $ffa_msg_adding_line
		end
	end 
	
# get journals count for any particular field value from grid view on the basis of Reference field
	def JNL.get_journals_count_having_same_value reference_value, col_name_to_return_count, value_to_count
		total_rows = all($page_vf_table_rows).size
		jnl_count = 0
		reference_column_num = gen_get_column_number_in_grid "Reference"
		debits_column_num = gen_get_column_number_in_grid "Debits"
		SF.log_info "Journal Column value is Reference-#{reference_column_num} and Debits #{debits_column_num}"
		for i in 1..total_rows
			ref_value = find($jnl_reference_value_pattern.sub($sf_param_substitute, i.to_s).sub($sf_param_substitute, reference_column_num.to_s)).text
			value_to_find = find($jnl_value_to_find_in_grid_pattern.sub($sf_param_substitute, i.to_s).sub($sf_param_substitute, debits_column_num.to_s)).text
			if(ref_value == reference_value && value_to_find == value_to_count)
				jnl_count= jnl_count+1
			end
		end
		return jnl_count
	end
	
# Set reverse period before confirming the journal reverse period
	def JNL.set_reverse_period period,company
		FFA.select_period_from_lookup $jnl_reverse_period_input,period,company
	end

	# get journal line number by searching GLA and line_amount/value as a combination
	def JNL.line_get_journal_line_item_number_by_description general_ledger_account_value , jnl_journal_line_description
		SF.execute_script do
			number_of_product_line_items =  all($jnl_journal_line_item_rows)
			row = 0
			matched_row = -1
			while row <= number_of_product_line_items.count-1
				gla_value = find($jnl_journal_line_gla_value_pattern.sub($sf_param_substitute,row.to_s)).text
				line_description = find(:xpath,$jnl_journal_line_description_pattern.sub($sf_param_substitute,row.to_s)).text
				if general_ledger_account_value == gla_value  
					if jnl_journal_line_description == line_description
						matched_row = row+1
						break
					end
				end
			row+=1
			end
			return matched_row
		end
	end
end 

