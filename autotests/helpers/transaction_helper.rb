 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
 if (SF.org_is_lightning)
	# TRX Line Item Column Numbers
	TRX_LINE_ITEM_ROW_START_NUM = 1
	TRX_LINE_ITEM_HOME_VALUE_COLUMN_NUM = 3
	TRX_LINE_ITEM_GLA_COLUMN_NUM = 6
	TRX_LINE_ITEM_DESCRIPTION_NUM = 7
else
	TRX_LINE_ITEM_ROW_START_NUM = 2
	TRX_LINE_ITEM_DESCRIPTION_NUM = 8
	TRX_LINE_ITEM_HOME_VALUE_COLUMN_NUM = 4
	TRX_LINE_ITEM_GLA_COLUMN_NUM = 7
end
module TRANX
extend Capybara::DSL
#############################
# Transaction (VF pages)
#############################
# Selectors
$tranx_number_of_line_items = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr | //div[@class = 'active oneContent']//div[contains(@class,'listViewContent')]//table//tbody/tr"
$tranx_line_item_column_num = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr[1]/th | //div[@class = 'active oneContent']//div[@class = 'headerRegion']/following::div[1]//tbody/tr[1]/th"
$tranx_line_item_row_description_value_pattern = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr["+$sf_param_substitute+"]"+"/td[#{TRX_LINE_ITEM_DESCRIPTION_NUM}]"
$tranx_number_of_line_item_data = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr["+$sf_param_substitute+"] | //div[@class = 'active oneContent']//div[contains(@class,'listViewContent')]//table//tbody/tr["+$sf_param_substitute+"]"
$tranx_line_item_row_data = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr["+$sf_param_substitute+"]"+"/td[#{TRX_LINE_ITEM_GLA_COLUMN_NUM}] | //div[@class = 'active oneContent']//div[@class = 'headerRegion']/following::div[1]//tbody/tr["+$sf_param_substitute+"]"+"/td[#{TRX_LINE_ITEM_GLA_COLUMN_NUM}]"
$tranx_line_item_row_home_value_pattern = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr["+$sf_param_substitute+"]"+"/td[#{TRX_LINE_ITEM_HOME_VALUE_COLUMN_NUM}]"
$tranx_line_item_id_link = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr["+$sf_param_substitute+"]"+"/th/a | //div[@class = 'active oneContent']//div[@class = 'headerRegion']/following::div[1]//tbody/tr["+$sf_param_substitute+"]"+"/th/a"
$tranx_line_item_pattern = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//td[text()='"+$sf_param_substitute+"']/ancestor::tr"
$tranx_line_item_header_column_pattern = "//h3[text()='Transaction Line Items']/ancestor::div[1]/following::div[1]/table//tr[1]/th["+$sf_param_substitute+"]"
$tranx_account_total = "//td[text()='Account Total']/../td[2]/div | //div/span[text()='Account Total']/ancestor::div[1]/following::div[1]/div/span"
$tranx_account_outstanding_total = "//td[text()='Account Outstanding Total']/../td[2]/div | //div/span[text()='Account Outstanding Total']/ancestor::div[1]/following::div[1]/div/span"
$tranx_home_debits = "//td[text()='Home Debits']/following-sibling::td/div | //div/span[text()='Home Debits']/ancestor::div[1]/following::div[1]/div/span"
$tranx_dual_debits = "//td[text()='Dual Debits']/following-sibling::td/div | //div/span[text()='Dual Debits']/ancestor::div[1]/following::div[1]/div/span"
$tranx_dual_credits = "//td[text()='Dual Credits']/following-sibling::td/div"
$tranx_reverse_reason = "//label[text()='Reverse Reason']/../following-sibling::td/div//textarea"
$tranx_transaction_type = "//td[text()='Transaction Type']/following-sibling::td/div | //div/span[text()='Transaction Type']/ancestor::div[1]/following::div[1]/div/span"
$tranx_transaction_period = "//td[text()='Period']/following-sibling::td/div | //div/span[text()='Period']/ancestor::div[1]/following::div[1]//div/a"
$tranx_transaction_company = "//td[text()='Company']/following-sibling::td/div | //div/span[text()='Company']/ancestor::div[1]/following::div[1]//div/a"
$tranx_transaction_date = "//td[text()='Transaction Date']/following-sibling::td/div | //div/span[text()='Transaction Date']/ancestor::div[1]/following::div[1]/div/span"
$tranx_transaction_number_value = "//td[text()='Transaction Number']/following::td[1]/div | //div/span[text()='Transaction Number']/ancestor::div[1]/following::div[1]/div/span"
$tranx_transaction_number_link = "//td[text()='Transaction Number']/following::td[1]/div/a"
$tranx_original_transaction_number_value = "//td[text()='Original Transaction Number']/following::td[1]/div/a | //div/span[text()='Original Transaction Number']/ancestor::div[1]/following::div[1]//div/a"
$tranx_document_description_value = "//td[text()='Document Description']/following::td[1]/div | //div/span[text()='Document Description']/ancestor::div[1]/following::div[1]/div/span"
$tranx_document_reference_value = "//td[text()='Document Reference']/following::td[1]/div"
$tranx_document_reference2_value = "//td[text()='Document Reference 2']/following::td[1]/div"
$tranx_document_total_value = "//td[text()='Document Total']/following-sibling::td"
$tranx_document_outstanding_total_value = "//td[text()='Document Outstanding Total']/following-sibling::td"
$tranx_account_value = "//td[text()='Account']/following-sibling::td/div"
$tranx_home_credits_value = "//td[text()='Home Credits']/following-sibling::td/div"
$tranx_home_value_total = "//td[text()='Home Value Total']/following-sibling::td/div"
$tranx_account_line_item =  "//tr[@class = 'headerRow']//th[contains(text(), 'Line Type')]/../following-sibling::tr[1]//th/a | //td//span[text()='Account']/ancestor::tr[1]/th[1]//a"
$tranx_analysis_line_item =  "//tr[@class = 'headerRow']//th[contains(text(), 'Line Type')]/../following-sibling::tr[2]//th/a"
$tranx_as_of_age_band =  "//td[text()='As of Age Band']/../td[2]/div | //span[text()='As of Age Band']/../following-sibling::div[1]/div/span"
$tranx_account_line_item_account_value = "//td[text() = 'Account']/following-sibling::td//div//a | //div/span[text()='Account']/ancestor::div[1]/following::div[1]//div/a"
$tranx_line_item_transaction_number = "//td[text()='Transaction Number']/following::td[1]/div | //div/span[text()='Transaction Number']/ancestor::div[1]/following::div[1]//div/a"
$tranx_account_line_item_account_line_reference_value = "//td[text() = 'Line Reference']/following-sibling::td//div"
$tranx_analysis_line_item_dimension1_value = "//td[text() = 'Dimension 1']/following-sibling::td//div//a"
$tranx_analysis_line_item_due_date_value = "//td[text() = 'Due Date']/following-sibling::td[1]//div"
$tranx_transaction_line_gla_value = "//td[text()='General Ledger Account']/following-sibling::td/div"
$tranx_line_detail_header = "//h2[text()= 'Transaction Line Item Detail']"
#Type
$tranx_type_allocation = 'Allocation'
$tranx_button_reverse = "input[value = 'Reverse']"
#Labels
$tranx_account_label = "Account"
$tranx_home_value_label = "Home Value"
$tranx_home_tax_total_label = "Home Tax Total"
$tranx_home_taxable_value_label = "Home Taxable Value"
$tranx_general_ledger_account_label = "General Ledger Account"
$tranx_analysis_label = "Analysis"
$tranx_tax_label = "Tax"
$trans_local_gla_label = "Local GLA"
$trans_local_gla_currency_label = "Local GLA Currency"
$trans_local_gla_value_label = "Local GLA Value"


#line items
$tranx_line_item_dual_value = "//td[text()='Dual Value']/following-sibling::td/div | //div/span[text()='Dual Value']/ancestor::div[1]/following::div[1]/div/span"
$tranx_line_item_document_value = "//td[text()='Document Value']/following-sibling::td/div | //div/span[text()='Document Value']/ancestor::div[1]/following::div[1]/div/span"
$tranx_line_item_gla_name = "//td[text()='General Ledger Account']/following::td[1]/div"
$tranx_line_item_gla_currency_name = "//td[text()='General Ledger Account Currency']/following::td[1]/div"
$tranx_line_item_gla_value = "//td[text()='General Ledger Account Value']/following::td[1]/div"

$tranx_line_item_local_gla_name = "//td[text()='Local GLA']/following::td[1]/div"
$tranx_line_item_local_gla_currency_name = "//td[text()='Local GLA Currency']/following::td[1]/div"
$tranx_line_item_local_gla_value = "//td[text()='Local GLA Value']/following::td[1]/div"
$tranx_line_item_dim1_name = "//td[text()='Dimension 1']/following::td[1]/div"
$tranx_line_item_dim2_name = "//td[text()='Dimension 2']/following::td[1]/div"
$tranx_line_item_dim3_name = "//td[text()='Dimension 3']/following::td[1]/div"
$tranx_line_item_dim4_name = "//td[text()='Dimension 4']/following::td[1]/div"
$tranx_line_item_line_type_value = "//td[text()='Line Type']/following::td[1]/div"
# Lightning specific
$tranxl_button_reverse = "div[title='Reverse']"
$trax_related_list_link = "a[title='Related']"
$tranx_view_all_line_items_link = "//span[text()='View All']"
$tranx_number_link_related_list = "//a/span[text()='Transactions']/ancestor::li[1]/following::li[1]/a"
$trans_more_link = "//a[contains(text(), 'more')]"

#methods
# get account total value
	def TRANX.get_account_total
		return find(:xpath, $tranx_account_total).text
	end
# get account outstanding value
	def TRANX.get_account_outstanding_total
		return find(:xpath, $tranx_account_outstanding_total).text
	end
# get home debit balue
	def TRANX.get_home_debits
		return find(:xpath, $tranx_home_debits).text
	end
# get dual debit value
	def TRANX.get_dual_debits
		return find(:xpath, $tranx_dual_debits).text
	end	
# get dual credit value
	def TRANX.get_dual_credits
		return find(:xpath, $tranx_dual_credits).text
	end		
# Transaction LineItem
# click on account transaction line item
	def TRANX.click_on_account_line_item
		TRANX.on_tranx_line_items do
			find(:xpath, $tranx_account_line_item).click
		end
		 SF.wait_for_search_button
	end	
# get account value of account line item
	def TRANX.get_account_line_item_account_value
		 find(:xpath ,$tranx_account_line_item_account_value).text
	end
# get account line reference value of account line item
	def TRANX.get_account_line_item_account_line_reference_value
		 find(:xpath ,$tranx_account_line_item_account_line_reference_value).text
	end

# click on analysis transaction line item
	def TRANX.click_on_analysis_line_item
		TRANX.on_tranx_line_items do
			find(:xpath, $tranx_analysis_line_item).click
		end
		 SF.wait_for_search_button
	end	
# get dimension 1 value of Analyis line item
	def TRANX.get_analysis_line_item_dimension1_value
		 find(:xpath ,$tranx_analysis_line_item_dimension1_value).text
	end
	
# get due date value of Analyis line item
	def TRANX.get_analysis_line_item_due_date_value
		 find(:xpath ,$tranx_analysis_line_item_due_date_value).text
	end
	
# get as of age band value
	def TRANX.get_as_of_age_band		
		first(:xpath , $tranx_as_of_age_band).text
	end

# get transaction type
	def TRANX.get_transaction_type
		return find(:xpath, $tranx_transaction_type).text
	end
# get transaction period
	def TRANX.get_transaction_period
		return find(:xpath, $tranx_transaction_period).text
	end
# get transaction company
	def TRANX.get_transaction_company
		return find(:xpath, $tranx_transaction_company).text
	end
# get transaction date
	def TRANX.get_transaction_date
		return find(:xpath, $tranx_transaction_date).text
	end		
# get gla line no
	def TRANX.get_gla_line_no
		return find(:xpath, $tranx_transaction_type).text
	end	
# click on reverse button	
	def TRANX.click_reverse_button
		SF.execute_script do
			if page.has_css?($tranx_button_reverse , :wait => 2)
				find($tranx_button_reverse).click
			else
				find($tranxl_button_reverse).click
			end
		end
		
		 SF.wait_for_search_button
	end	
# set reverse reason
	def TRANX.set_reverse_reason reason
		SF.execute_script do
			page.has_xpath?($tranx_reverse_reason)
			find(:xpath, $tranx_reverse_reason).set reason
		end
	end	
# assert values present in transaction line item.
# return true if passed values exist on transaction line items. 	
	def TRANX.assert_transaction_line_item value_1, value_2
		status = false
		TRANX.on_tranx_line_items do	
			rownum=2
			if (SF.org_is_lightning)
			    rownum=1
			end
			page.has_xpath?($tranx_number_of_line_items)
			all_tranx_lineitems = all(:xpath, $tranx_number_of_line_items)
			for i in rownum..all_tranx_lineitems.size do
				lineitemlocator = $tranx_number_of_line_item_data.gsub($sf_param_substitute,i.to_s)
				if((find(:xpath, lineitemlocator).has_content?(value_1)) && (find(:xpath, lineitemlocator).has_content?(value_2)))
					status = true
					break
				end
			end
		end
		# Navigate back to transaction page.
		if (SF.org_is_lightning)
			SF.retry_script_block do
			   find(:xpath,$tranx_number_link_related_list).click
			   page.has_css?($trax_related_list_link)
			end
		end
		return status
   end
   
	# Execute code on the transaction line items related list page. 
    def TRANX.on_tranx_line_items (&block)
		# On Lightning org, Navigate to related list to view line items
		if (SF.org_is_lightning)
			find($trax_related_list_link).click
		    page.has_xpath?($tranx_view_all_line_items_link)
		    find(:xpath , $tranx_view_all_line_items_link).click
		    SF.wait_for_search_button
		end
		# execute the code block on line item
		block.call()
    end
# get transaction number
   def TRANX.get_transaction_number 
		return find(:xpath , $tranx_transaction_number_value).text
   end
 # get original transaction number
   def TRANX.get_original_transaction_number 
		return find(:xpath , $tranx_original_transaction_number_value).text
   end
# get transaction document description
   def TRANX.get_transaction_document_description
		return find(:xpath , $tranx_document_description_value).text
   end
# get transaction document reference
   def TRANX.get_transaction_document_reference
		return find(:xpath , $tranx_document_reference_value).text
   end
# get transaction document reference 2
   def TRANX.get_transaction_document_reference2
		return find(:xpath , $tranx_document_reference2_value).text
   end

# get Transaction line item details 
# line_type_name= name of line type, Analysis,Account etc , 
# product_value_to_search= name of column whose value need to be returned for above line type.
	def TRANX.get_line_item_data line_type_name , product_value_to_search			
		allrows  = all(:xpath , $tranx_number_of_line_items)
		numofcol = all(:xpath , $tranx_line_item_column_num)
		col=1;
		row =1 ;
		while col <= numofcol.count
			column_value = find(:xpath , $tranx_line_item_header_column_pattern.sub($sf_param_substitute,col.to_s)).text
			if product_value_to_search == column_value
				break
			end
			col+=1
		end
		col-=1;
		trx_line_item_row = $tranx_line_item_pattern.gsub($sf_param_substitute, line_type_name)
		while  row <= allrows.count-1
			cellvalue = find(:xpath , trx_line_item_row+"["+row.to_s+"]/td[3]").text 
			if line_type_name == cellvalue
				return find(:xpath , trx_line_item_row+"["+row.to_s+"]"+"/td["+col.to_s+"]").text
			end
			row += 1
		end	
	end 
	
	def TRANX.get_document_total
		return find(:xpath, $tranx_document_total_value).text
	end
	
	def TRANX.get_document_outstanding_total_value
		return find(:xpath, $tranx_document_outstanding_total_value).text
	end
	
	def TRANX.get_account_value
		return find(:xpath, $tranx_account_value).text
	end
	
	def TRANX.get_home_credits_value
		return find(:xpath, $tranx_home_credits_value).text
	end
	
	def TRANX.get_home_value_total
		return find(:xpath, $tranx_home_value_total).text
	end
	
# get dual value from dual information on transaction line item's page
	def TRANX.get_line_item_dual_value
		return find(:xpath, $tranx_line_item_dual_value).text
	end
# get document value for line item on transaction line items page
	def TRANX.get_line_item_document_value
		return find(:xpath, $tranx_line_item_document_value).text
	end
	
	# get transaction number from transaction line items detail page
	def TRANX.get_line_item_transaction_number
		return find(:xpath, $tranx_line_item_transaction_number).text
	end
#open the line item page	
	def TRANX.open_transaction_line_item_by_gla gla_value
		TRANX.on_tranx_line_items do	
			all_tranx_lineitems = all(:xpath, $tranx_number_of_line_items)
			for i in TRX_LINE_ITEM_ROW_START_NUM..all_tranx_lineitems.size do
				tranx_row_data = $tranx_line_item_row_data.gsub($sf_param_substitute,i.to_s)
				if find(:xpath, tranx_row_data).text == gla_value
					line_item_num = $tranx_line_item_id_link.gsub($sf_param_substitute,i.to_s)
					page.has_xpath?(line_item_num)
					find(:xpath, line_item_num).click
					break
				end		
			end
		end
	end
	
#open the line item page	
	def TRANX.open_transaction_line_item_by_home_value  home_value
		TRANX.click_more
		page.has_xpath?($tranx_number_of_line_items)
		TRANX.on_tranx_line_items do	
			all_tranx_lineitems = all(:xpath, $tranx_number_of_line_items)
			for i in TRX_LINE_ITEM_ROW_START_NUM..all_tranx_lineitems.size do
				tranx_row_data = $tranx_line_item_row_home_value_pattern.gsub($sf_param_substitute,i.to_s)
				if find(:xpath, tranx_row_data).text == home_value.to_s
					line_item_num = $tranx_line_item_id_link.gsub($sf_param_substitute,i.to_s)
					page.has_xpath?(line_item_num)
					find(:xpath, line_item_num).click
					page.has_text?(home_value)
					break
				end		
			end
		end
	end

	#open the line item page by home value and line description
	def TRANX.open_transaction_line_item_by_home_value_line_description  home_value, line_description
	  	TRANX.click_more
		page.has_xpath?($tranx_number_of_line_items)
		TRANX.on_tranx_line_items do	
			all_tranx_lineitems = all(:xpath, $tranx_number_of_line_items)
			for i in TRX_LINE_ITEM_ROW_START_NUM..all_tranx_lineitems.size do
				tranx_row_data = $tranx_line_item_row_home_value_pattern.gsub($sf_param_substitute,i.to_s)
				trans_row_desc = $tranx_line_item_row_description_value_pattern.gsub($sf_param_substitute,i.to_s)
				if (find(:xpath, tranx_row_data).text == home_value.to_s && find(:xpath, trans_row_desc).text == line_description)
					line_item_num = $tranx_line_item_id_link.gsub($sf_param_substitute,i.to_s)
					page.has_xpath?(line_item_num)
					find(:xpath, line_item_num).click
					gen_wait_until_object $tranx_line_detail_header
					break
				end		
			end
		end
	end		
	
############################
# TRANSACTION LINE ITEM PAGE
############################

	def TRANX.get_line_item_gla_name
		SF.retry_script_block do
			return find(:xpath , $tranx_line_item_gla_name).text
		end
	end
	
	def TRANX.get_line_item_gla_currency_value
		return find(:xpath , $tranx_line_item_gla_currency_name).text			
	end
	
	def TRANX.get_line_item_gla_value
		return find(:xpath , $tranx_line_item_gla_value).text		
	end
	
	def TRANX.get_line_item_local_gla_name
		return find(:xpath , $tranx_line_item_local_gla_name).text		
	end
	
	def TRANX.get_line_item_local_gla_currency_value
		return find(:xpath , $tranx_line_item_local_gla_currency_name).text
	end
	
	def TRANX.get_line_item_local_gla_value
		return find(:xpath , $tranx_line_item_local_gla_value).text		
	end
	
	#get trasaction line item dim 1 value 
	def TRANX.get_line_item_dimension1_value
		SF.retry_script_block do
			return find(:xpath , $tranx_line_item_dim1_name).text		
		end
	end
	
	#get trasaction line item dim 2 value 
	def TRANX.get_line_item_dimension2_value
		return find(:xpath , $tranx_line_item_dim2_name).text		
	end
	
	#get trasaction line item dim 3 value 
	def TRANX.get_line_item_dimension3_value
		SF.retry_script_block do
			return find(:xpath , $tranx_line_item_dim3_name).text		
		end
	end
	
	#get trasaction line item dim 4 value 
	def TRANX.get_line_item_dimension4_value
		SF.retry_script_block do
			return find(:xpath , $tranx_line_item_dim4_name).text		
		end
	end
	
	def TRANX.get_line_item_line_type_value
		SF.retry_script_block do
			return find(:xpath , $tranx_line_item_line_type_value).text		
		end
	end
	
	def TRANX.click_more
	    if page.has_xpath?($trans_more_link)
			find(:xpath, $trans_more_link).click
			page.has_no_xpath?($trans_more_link)
			SF.wait_for_search_button
		end
	end
end
