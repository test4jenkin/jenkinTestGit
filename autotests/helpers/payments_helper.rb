 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

PAYMENT_COLUMN_ACCOUNT = 1
PAYMENT_COLUMN_OUTSTANDING_VALUE = 2 
PAYMENT_COLUMN_GROSS_VALUE = 3 
PAYMENT_COLUMN_DISCOUNT = 4
PAYMENT_COLUMN_PAYMENT_VALUE = 5

module PAY
extend Capybara::DSL
#############################
# Payments (VF pages)
#############################
##################################################
# Payments Selectors  #
##################################################
$pay_bank_account = "input[id$=':bankAccount']"
$pay_payment_type = "input[value='"+$sf_param_substitute+"']"
$pay_payment_media = "input[value='"+$sf_param_substitute+"']"
$pay_payment_method = "select[id$=':paymentMethod']"
$pay_settlement_discount = "span[class$='lookupInput'] input[id*=':settlementDiscount']"
$pay_settlement_discount_local_gla_value = "span[id$=':settlementDiscountLocalGla'] a"
$pay_currency_write_off = "span[class$='lookupInput'] input[id*=':currencyWriteOf']"
$pay_write_off_local_gla_value = "span[id*=':currencyWriteOfLocalGla'] a"
$pay_payment_date = "input[id$=':paymentDate']"
$pay_due_date = "input[id$=':dueDate']"
$pay_payment_number_link = "//span[text()='"+$sf_param_substitute+"']/ancestor::a[1] | //a[text()='"+$sf_param_substitute+"']"
$pay_acc_to_pay_section_columns = "th[id*=':dtAccountLineItemsNew:']"
$pay_acc_to_pay_section_column_pattern = $pay_acc_to_pay_section_columns+":nth-of-type("+$sf_param_substitute+")"
$pay_acc_to_pay_section_rows = "tbody[id*=':dtAccountLineItemsNew:'] tr"
$pay_acc_to_pay_section_row_pattern = $pay_acc_to_pay_section_rows+":nth-of-type("+$sf_param_substitute+") span a"
$pay_acc_to_pay_section_outstanding_value_pattern = $pay_acc_to_pay_section_rows+":nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{PAYMENT_COLUMN_OUTSTANDING_VALUE})"
$pay_acc_to_pay_section_gross_value_pattern = $pay_acc_to_pay_section_rows+":nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{PAYMENT_COLUMN_GROSS_VALUE})"
$pay_acc_to_pay_section_discount_value_pattern = $pay_acc_to_pay_section_rows+":nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{PAYMENT_COLUMN_DISCOUNT})"
$pay_acc_to_pay_section_payment_value_pattern = $pay_acc_to_pay_section_rows+":nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{PAYMENT_COLUMN_PAYMENT_VALUE})"
$pay_show_transactions_icon = $pay_acc_to_pay_section_rows+":nth-of-type("+$sf_param_substitute+")"+" "+"a.showTransactions"
$pay_show_transaction_pop_up = "div#dialogBoxMiddle iframe"
$pay_transactions_input_payment_value = "//span[text()='"+$sf_param_substitute+"']/../following-sibling::td/span/input"
$pay_transaction_processing_icon = "div.loadingIconWrapper"
$pay_payment_line_checkbox = "span[id$=':"+$sf_param_substitute+":checkBoxPanelVoid'] input"
$pay_dialog_box_locator = "div[id$='dialogBox'] , div[id='dialogBoxMiddle']"
$pay_dialog_box_ok_button= "a[id$='myButton']"
$pay_payment_number = "h2.pageDescription"
$pay_payment_grid = "tbody[id$='dtAccountLineItemsNew:tb']"
$pay_payment_account_select_checkbox= "//a[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td[1]/span[1]/input[1]"
$pay_bank_account_lookup_icon = "a[title = 'Bank Account Lookup (New Window)']"
$pay_general_ledger_account = "input[id$=':generalLedgerAccount']"
$pay_payment_account_checkbox = "span[id$=':"+$sf_param_substitute+":checkBoxPanel'] input"
$pay_payment_grid_rows = "tbody[id$='dtAccountLineItemsNew:tb'] tr"

# Labels
$label_payment_selection_due_date = "Due Date"
$label_payment_outstanding_value = "Outstanding Value"
$label_payment_gross_value = "Gross Value"
$label_payment_discount = "Discount"
$label_payment_payment_value = "Payment Value"
$label_payment_status = "Status"
$label_payment_number = "Payment Number"
$label_payment_cancel_reason = "Cancel Reason"
$label_payment_media_check = "Check"
$label_payment_discard_reason = "Discard Reason"
$label_payment_type_collections = "Collections"
$label_payment_media_electronic = "Electronic"
$label_payment_type_payments = "Payments"
# Buttons
$pay_transactions_ok_button = "input[id$=':ok']"
$pay_generate_bank_file_button = "Generate Bank File"
$pay_transactions_next_icon = "Img[class='next']"
$pay_transactions_payment_amount_input = "table[id$='datatableContents'] tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(7) input"
$pay_transaction_items_per_page = "option[value='"+$sf_param_substitute+"']"
$pay_transactions_no_of_pages = "//div[@class = 'paginator']/span[1]/span[2]"
$pay_transaction_page_frame = "div[id = 'dialogBoxMiddle']  div  iframe:nth-of-type(1)"

$pay_payment_save_button = "input[value='Save']"
$pay_payment_pay_button = "Pay"
$pay_payment_confirm_pay_button = "Confirm & Pay"
$pay_payment_cancel_selected_button = "Cancel Selected"
$pay_cancel_payment_button = "Cancel Payment"
$pay_cancel_continue_button = "Continue"
$pay_retrieve_accounts_button = "Retrieve Accounts"
$pay_transaction_lineItem_checkbox ="input[id$='datatableContents:"+$sf_param_substitute+":tselected']"
$pay_error_panel = "div[id*='errorPanel']"
$pay_transaction_rows = "table[id$='datatableContents'] tr";
$pay_payment_grid_rows = "tbody[id$='dtAccountLineItemsNew:tb'] tr"

# Methods
# set bank account
	def PAY.set_bank_account bank_account_name
		SF.retry_script_block do
			SF.execute_script do
				page.has_css?($pay_bank_account)
				find($pay_bank_account).set bank_account_name
				gen_tab_out $pay_bank_account
				FFA.wait_page_message $ffa_msg_retrieving_payment_currency
			end
		end
	end
#set payment type
	def PAY.set_payment_type payment_type
		SF.execute_script do
			find($pay_payment_type.sub($sf_param_substitute, payment_type)).click
		end
	end
# set payment media
	def PAY.set_payment_media payment_media
		SF.execute_script do
			find($pay_payment_media.sub($sf_param_substitute, payment_media)).click
		end
	end

# set payment media
	def PAY.set_payment_method payment_metod
		SF.execute_script do
			element_id = find($pay_payment_method)[:id]
			select(payment_metod , :from => element_id)
		end
	end
# Set settlement discount
	def PAY.set_settlement_discount gla_name
		SF.execute_script do
			find($pay_settlement_discount).set gla_name
		end
	end
# Set Currency Write-off
	def PAY.set_currency_write_off gla_name
		SF.execute_script do
			find($pay_currency_write_off).set gla_name
		end
	end
# Set payment date
	def PAY.set_payment_date payment_date
		SF.execute_script do
			find($pay_payment_date).set payment_date
			gen_tab_out $pay_payment_date
			FFA.wait_page_message $ffa_msg_updating_payment_date
		end
	end
# Set due date
	def PAY.set_due_date due_date
		SF.execute_script do
			find($pay_due_date).set due_date
		end
	end
# Set gla_name
	def PAY.set_gla gla_name
		SF.execute_script do
			find($pay_general_ledger_account).set gla_name
		end
	end

# Click Retrieve Accounts button 
	def PAY.click_retrieve_accounts_button
		SF.execute_script do
			SF.click_button $pay_retrieve_accounts_button
			FFA.wait_page_message $ffa_msg_retrieving_accounts
		end
	end
# get payment number from payment detail page
	def PAY.get_payment_number
		SF.execute_script do
			return find($pay_payment_number).text
		end
	end
# open PAY detail page
	def PAY.open_payment_detail_page payment_number
		SF.execute_script do
			record_to_click = $pay_payment_number_link.gsub($sf_param_substitute, payment_number.to_s)
			find(:xpath , record_to_click).click
			page.has_text?(payment_number)
		end
	end

# get outstanding value from payment detail page	
	def PAY.get_outstanding_value acc_name_to_search
		SF.execute_script do
			row_num = PAY.get_row_num_from_acc_to_pay_section acc_name_to_search
			payment_outstanding_value = $pay_acc_to_pay_section_outstanding_value_pattern.sub($sf_param_substitute, row_num.to_s)
			return find(payment_outstanding_value).text
		end
	end
# get gross value from payment detail page	
	def PAY.get_gross_value acc_name_to_search
		SF.execute_script do
			row_num = PAY.get_row_num_from_acc_to_pay_section acc_name_to_search
			payment_gross_value = $pay_acc_to_pay_section_gross_value_pattern.sub($sf_param_substitute, row_num.to_s)
			return find(payment_gross_value).text
		end
	end
# get discount value from payment detail page	
	def PAY.get_discount acc_name_to_search
		SF.execute_script do
			row_num = PAY.get_row_num_from_acc_to_pay_section acc_name_to_search
			payment_discount = $pay_acc_to_pay_section_discount_value_pattern.sub($sf_param_substitute, row_num.to_s)
			return find(payment_discount).text
		end
	end
# get payment value from payment detail page	
	def PAY.get_payment_value acc_name_to_search
		SF.execute_script do
			row_num = PAY.get_row_num_from_acc_to_pay_section acc_name_to_search
			payment_payment_value = $pay_acc_to_pay_section_payment_value_pattern.sub($sf_param_substitute, row_num.to_s)
			return find(payment_payment_value).text	
		end
	end
	
# click on show transaction icon
	def PAY.click_show_transactions acc_name_to_search
		SF.execute_script do
			row_num = PAY.get_row_num_from_acc_to_pay_section acc_name_to_search
			find($pay_show_transactions_icon.sub($sf_param_substitute, row_num.to_s)).click
		end
	end
# set payment value on Transaction for account pop up window
	def PAY.set_transactions_payment_value doc_number, payment_value
		SF.execute_script do
			within_frame(find($pay_show_transaction_pop_up)) do
				find(:xpath, $pay_transactions_input_payment_value.gsub($sf_param_substitute, doc_number)).set payment_value
				find($pay_transactions_ok_button).click
			end
			gen_wait_until_object_disappear $pay_transaction_processing_icon
			gen_wait_until_object_disappear $ffa_processing_button_locator
		end
	end
# Select payment line based on account name on payment detail page	
	def PAY.select_payment_line acc_name_to_search
		SF.execute_script do
			find(:xpath,$pay_payment_account_select_checkbox.sub($sf_param_substitute,acc_name_to_search)).click
		end
	end
# Set payment cancel reason	
	def PAY.set_payment_cancel_reason cancel_reason
		SF.execute_script do
			page.has_text?($label_payment_cancel_reason)
			SF.retry_script_block do		
				fill_in $label_payment_cancel_reason, :with => cancel_reason
			end	
		end
	end
# Click payment cancel continue button	
	def PAY.click_payment_cancel_continue_button
		SF.execute_script do
			SF.click_button $pay_cancel_continue_button
			page.has_button?($pay_cancel_payment_button)
		end
	end
# Set payment discard reason
	def PAY.set_payment_discard_reason discard_reason
		SF.execute_script do
			fill_in $label_payment_discard_reason, :with => discard_reason
		end
	end
# click on OK button on dialog box to return back to payment page
	def PAY.click_dialog_box_ok_button
		SF.execute_script do
			if page.has_css?($pay_dialog_box_locator)
				puts 'Clicking on OK button of Popup'
				within(find($pay_dialog_box_locator)) do
					find($pay_dialog_box_ok_button).click
				end
			end
		end
		SF.wait_for_search_button
	end
	
	#uncheck account transaction line Item's checkBox
	#payment_no - Payment Number to Open in detail view
	#account_name - Account Name on which transactions exists 
	#lineItemNumber - array of integer index , which is to be uncheckd , starting with 0 base indexing
	def PAY.uncheck_account_line_Items payment_no, account_name, lineItemNumber
		#click_link payment_no
		PAY.open_payment_detail_page payment_no
		PAY.click_show_transactions account_name
		gen_wait_until_object_disappear $pay_transaction_processing_icon
		
		within_frame (find($pay_transaction_page_frame))do						
			
			if lineItemNumber.length > 0 then
				lineItemNumber.each do |item|
					find($pay_transaction_lineItem_checkbox.sub($sf_param_substitute, item.to_s)).set false
					end
			end
		end
		PAY.account_transaction_click_ok_button
	end
	
	#get error message on payment page
	def PAY.get_error_message
		return find($pay_error_panel).text		
	end
	
	# Click Save Button
	def PAY.click_save_button
		find($pay_payment_save_button).click
		SF.wait_for_search_button
	end

	# Click Pay Button
	def PAY.click_pay_button
		SF.click_button $pay_payment_pay_button
		SF.wait_for_search_button
	end	
	
	# Click Pay Button
	def PAY.click_pay_button
		SF.click_button $pay_payment_pay_button
		SF.wait_for_search_button
	end		
	
	# click generate bank file button
	def PAY.click_generate_bank_file_button
		SF.click_button $pay_generate_bank_file_button
		SF.wait_for_search_button
	end
	
	# click generate bank file button
	def PAY.click_generate_bank_file_confirm_button
		SF.click_button $pay_generate_bank_file_button
		SF.wait_for_search_button
	end
	
	#click account transaction OK button
	def PAY.account_transaction_click_ok_button
		begin
			within_frame (find($pay_transaction_page_frame))do						
				find($pay_transactions_ok_button).click
				gen_wait_until_object_disappear $pay_transaction_processing_icon
			end
		rescue Exception => e
			if e.message.include?("a is null") then
			   SF.log_info ("a is null is known issue with capybara,error skipped")
			else
			   raise e
			end
		end
	end
	
	#click on Confirm and Pay button 
	def PAY.click_confirm_pay_button
		SF.click_button $pay_payment_confirm_pay_button
		SF.wait_for_search_button
	end	

	#edit All account transaction line item with new_payment_value for specified payment payment_no 
	def PAY.edit_all_Account_line_Items account_number, payment_no, new_payment_value, items_per_page
		#click_link payment_no
		PAY.open_payment_detail_page payment_no
		gen_wait_until_object_disappear $pay_transaction_processing_icon
		PAY.click_show_transactions account_number	
		gen_wait_until_object_disappear $pay_transaction_processing_icon

		within_frame (find($pay_transaction_page_frame))do
			find($pay_transaction_items_per_page.gsub($sf_param_substitute,items_per_page.to_s)).click
			gen_wait_until_object_disappear $pay_transaction_processing_icon
			_number_of_pages = find(:xpath ,$pay_transactions_no_of_pages).text;
			#iterate all pages
			for i in 1.._number_of_pages.to_i
				gen_wait_until_object_disappear $pay_transaction_processing_icon
				no_of_transactions_on_page = all($pay_transaction_rows)
				#iterate all items of the page				
				for j in 1..no_of_transactions_on_page.count
					find($pay_transactions_payment_amount_input.gsub($sf_param_substitute, j.to_s)).set new_payment_value					
				end			
				#click on next page
				if(i < _number_of_pages.to_i)
					#wait for update the discount values 
					sleep 1
					find($pay_transactions_next_icon).click				
				end
			end			
			find($pay_transactions_ok_button).click
			gen_wait_until_object_disappear $pay_transaction_processing_icon
		end			
	end
	
# get account checkbox status of specified account name
	def PAY.get_account_checkbox_status acc_name_to_search
		row_num = PAY.get_row_num_from_acc_to_pay_section acc_name_to_search
		row_num = row_num - 1
		account_checkBox = $pay_payment_account_checkbox.sub($sf_param_substitute, row_num.to_s)
		element_id = find(account_checkBox)[:id]
		return page.has_checked_field?(element_id)		
	end
	
	# return total rows in retrieved payment grid where all accounts are listed.
	def PAY.get_total_row_count_from_acc_to_pay_section
		page.has_css?($pay_payment_grid_rows)
		allrows  = all($pay_payment_grid_rows)
		return allrows.count
	end
	
	# return the row number in which account_name is present on retrieved payment grid where all accounts are listed.
	def PAY.get_row_num_from_acc_to_pay_section account_name
		page.has_css?($pay_payment_grid_rows)
		allrows  = all($pay_payment_grid_rows)
		row = 1 
		while  row <= allrows.count
			cellvalue = find($pay_payment_grid_rows + ":nth-of-type(#{row}) div span a").text
			if account_name == cellvalue
				break
			end
			row += 1
		end 
		return row 
	end
end