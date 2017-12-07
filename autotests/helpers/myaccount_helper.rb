 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module MYACCOUNT  
extend Capybara::DSL
#############################
# MyAccount Helper for Community
#############################
#selector
$myaccount_account_balance_summary_link = "Account Balance Summary"
$myaccount_account_balance_details_link = "Account Balance Details"
$myaccount_pie_chart_locator = "div[class='vf-surface vf-surface-default']"	
$myaccount_account_balance_section = "span[class='myAccount-balancegrid'] table[class='list myAccount-grid']"
$myaccount_summary_section_document_outstanding_amount_pattern = "//td[text()='"+$sf_param_substitute+"']/ancestor::tr[1]/td[2]/span"
$myaccount_doc_type_picklist_selected_value = "select[id$='documentTypes'] option[selected='selected']"
$myaccount_payment_status_picklist_selected_value= "select[id$='payment_status'] option[selected='selected']"
$myaccount_document_result_row_pattern = "//td/span[text()='"+$sf_param_substitute+"']/ancestor::tr[1]"
$myaccount_payment_result_row_pattern = "table[class='list myAccount-grid'] tbody tr:nth-of-type(#{$sf_param_substitute})"
$myaccount_document_type_picklist_value_pattern = "//option[text()='"+$sf_param_substitute+"']"
$myaccount_document_view_detail_locator ="a[title$='View Details']"
$myaccount_document_print_locator = "a[title$='Print']"
$myaccount_document_view_detail_locator_pattern = "//td/span[text()='"+$sf_param_substitute+"']/ancestor::tr[1]//a[contains(@title,'View Details')]"
$myaccount_document_print_pdf_locator_pattern = "//td/span[text()='"+$sf_param_substitute+"']/ancestor::tr[1]//a[contains(@title,'Print')]"
$myAccount_grid = ".myAccount-grid tr[class*='dataRow']"
$myAccount_grid_rows = ".myAccount-grid tr[class*='dataRow']"
$myAccount_expand_side_bar= "a[title*='Click to Open Sidebar']"
#myaccount filters 
$myaccount_document_type_fillter = "select[id$='filterForm:documentTypes']"
$myaccount_billing_document_type_filter = "select[id$=':secondaryFilter:billing_type']"
$myaccount_payment_status_fillter = "select[id$=':secondaryFilter:payment_status']"
$myaccount_document_number_from_date_fillter = "input[id$='_from']"
$myaccount_document_number_to_date_fillter = "input[id$='_to']"
$myaccount_date_range_from_fillter = "input[id$=':start_date']"
$myaccount_date_range_to_fillter = "input[id$=':end_date']"
$myaccount_payment_type_fillter = "select[id$=':payment_type']"
#Button
$myaccount_apply_filter_button = "input[id$=':applyButton']"
#Label
$myaccount_document_type_label = "Document Type"
$myaccount_payment_status_label = "Payment Status"
$myaccount_payment_type_label = "Payment Type"
$myaccount_applying_filter_msg = "Applying filters"
# Methods
	# check for the text present under account balance section in myaccount tab
	def  MYACCOUNT.is_value_present_account_balance_section value
		value_present = false
		within($myaccount_account_balance_section) do
			value_present = page.has_text?(value)
		end
		return value_present
	end
	
	# get the outstanding amount of documents under summary section
	def  MYACCOUNT.get_document_outstanding_amount doc_type
		outstanding_amount = find(:xpath, $myaccount_summary_section_document_outstanding_amount_pattern.sub($sf_param_substitute,doc_type)).text
		return outstanding_amount
	end
	
	# select a value from document type filter picklist
	def MYACCOUNT.select_document_type doc_type
        find($myaccount_document_type_fillter).select(doc_type)
		FFA.wait_page_message $myaccount_applying_filter_msg
	end
	
	# select a value from payment status  fiter picklist
	def MYACCOUNT.select_payment_status status
		select status, :from => $myaccount_payment_status_label
	end
	
	# select a value from payment type  fiter picklist
	def MYACCOUNT.select_payment_type type
		select type, :from => $myaccount_payment_type_label
	end
	
	# get the selected value of document type picklist
	def  MYACCOUNT.get_document_type_picklist_selected_value 
		return find($myaccount_doc_type_picklist_selected_value).text
	end
	# get the selected value of payment status picklist
	def  MYACCOUNT.get_payment_status_picklist_selected_value
		return find($myaccount_payment_status_picklist_selected_value).text
	end
	
	# Get Row Data of a document from Account balance detail result section
	# Pass the document number and this method will return the complete row content of that document
	def MYACCOUNT.get_document_row_content doc_number
		document_row_data = find(:xpath,$myaccount_document_result_row_pattern.sub($sf_param_substitute,doc_number)).text
		SF.log_info "Document Row Data- #{document_row_data}"
		return document_row_data
	end
	
	# Get Row Data of a pament from Account balance detail result section
	# Pass the row number and this method will return the complete row content of that document
	def MYACCOUNT.get_payment_row_content row_number
		payment_row_data = find($myaccount_payment_result_row_pattern.sub($sf_param_substitute,row_number)).text
		SF.log_info "payment row data - #{payment_row_data}"
		return payment_row_data
	end
	
	# click on view detail icon of a document
	# doc_number = document number for which view detail icon need to be clicked
	def MYACCOUNT.click_view_detail doc_number
		find(:xpath,$myaccount_document_view_detail_locator_pattern.sub($sf_param_substitute,doc_number)).click
		gen_wait_less # wait for sometime to display view detail in separate window.
	end
	
	# click on print pdf icon of a document
	# doc_number = document number for which print pdf icon need to be clicked
	def MYACCOUNT.click_print_pdf doc_number
		find(:xpath,$myaccount_document_print_pdf_locator_pattern.sub($sf_param_substitute,doc_number)).click
		gen_wait_less # wait for sometime to display pdf in separate window.
	end
	
	#click on apply filter button
	def MYACCOUNT.click_apply_filter
		find($myaccount_apply_filter_button).click
		FFA.wait_page_message $myaccount_applying_filter_msg
	end

	# select a value from billing document type fiter picklist
    def MYACCOUNT.select_billing_document_type doc_type
        find($myaccount_billing_document_type_filter).select(doc_type)
    end

    # Set Document Number From in the Filter
    def MYACCOUNT.set_document_number_from doc_num
        find($myaccount_document_number_from_date_fillter).set(doc_num)
    end

    # Set Document Number To in the Filtera
    def MYACCOUNT.set_document_number_to doc_num
        find($myaccount_document_number_to_date_fillter).set(doc_num)
    end

    # Set Date Range From in the Filter
    def MYACCOUNT.set_date_range_from date_from
        find($myaccount_date_range_from_fillter).set(date_from)
    end

    # Set Date Range To in the Filter
    def MYACCOUNT.set_date_range_to date_to
        find($myaccount_date_range_to_fillter).set(date_to)
    end
	
	# expand side bar of my account tab on community page, if it is in collapsed state
	def MYACCOUNT.expand_side_bar
		SF.retry_script_block do 
			# expand side bar if it is in collapsed.
			if(page.has_css?($myAccount_expand_side_bar))
				find($myAccount_expand_side_bar).hover
				sleep 1 # wait for the sidebar to get highlight
				find($myAccount_expand_side_bar).click
			end
		end
		page.has_text?($myaccount_account_balance_summary_link)
	end
end 
