#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

DOCUMENT_TYPE_INVOICE = 'Invoice'
DOCUMENT_TYPE_CREDIT_NOTE = 'Credit Note'
BILLING_DOCUMENT_STATUS_DRAFT = 'Draft'
BILLING_DOCUMENT_STATUS_COMPLETE = 'Complete'
module ERPBD
	extend Capybara::DSL

	#############################################
	#ERP Billing document header buttons
	#############################################

	$erpbd_complete_button = "Complete"
	$erpbd_new_billing_document_line_item = "New Billing Document Line Item"

	#############################################
	#ERP Blling Document Header Fields
	#############################################

	$erpbd_field_type = "//label[text()='Document Type']/ancestor::td[1]/following-sibling::td[1]//select"
	$erpbd_field_account =  "a[title='Account Lookup (New Window)']"
	$erpbd_field_document_date ="//label[text()='Document Date']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_due_date = "//label[text()='Document Due Date']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_company = "//label[text()='Company']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_status = "//label[text()='Document Status']/ancestor::td[1]/following-sibling::td[1]//select"
	$erpbd_field_customer_reference = "//label[text()='Customer Reference']/ancestor::td[1]/following-sibling::td[1]//textarea"
	$erpbd_field_description ="//label[text()='Description']/ancestor::td[1]/following-sibling::td[1]//textarea"
	$erpbd_field_shipping_street = "//label[text()='Shipping Street']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_shipping_city = "//label[text()='Shipping City']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_shipping_state_or_province = "//label[text()='Shipping State/Province']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_shipping_zip_or_postalcode ="//label[text()='Shipping Zip/Postal Code']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_shipping_country ="//label[text()='Shipping Country']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_document_number_view = "//td[text()='Document Number']/following-sibling::td[1]//div"
	$erpbd_field_document_status_view = "//span[text()='Document Status']/ancestor::td[1]/following-sibling::td[1]//div"
	$erpbd_field_posting_status_view = "//span[text()='Posting Status']/ancestor::td[1]/following-sibling::td[1]//div"

	##############################################
	#Billing document line fields for view/edit mode
	##############################################
	$erpbd_field_line_product_or_service = "//label[text()='Product or Service']/ancestor::td[1]/following-sibling::td[1]//span[@class='lookupInput']/input"
	$erpbd_field_line_quantity = "//label[text()='Quantity']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_line_unit_price = "//label[text()='Unit Price']/ancestor::td[1]/following-sibling::td[1]//input"
	$erpbd_field_line_description = "//label[text()='Description']/ancestor::td[1]/following-sibling::td[1]//textarea"

	$erpbd_link_pattern = "//div[contains(@class,'listBody')]//span[contains(text(),'"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"


	#############################################
	#ERP Blling Document Header Fields Community Layout
	#############################################

	$erpbd_community_field_account_view = "//span[text()='Account']/../following-sibling::td/a"
	$erpbd_community_field_document_number_view = "//td[text()='Document Number']/following-sibling::td"
	$erpbd_community_field_document_type_view = "//span[text()='Document Type']/../following-sibling::td"
	$erpbd_community_field_payment_status_view = "//span[text()='Payment Status']/../following-sibling::td"
	$erpbd_community_field_outstanding_value_view = "//span[text()='Outstanding Value']/../following-sibling::td"

	#############################################
	#ERP Blling Document Line Fields Community Layout
	#############################################

	$erpbd_community_row_pattern = "tr.dataRow:nth-of-type("+$sf_param_substitute+")"

	###############################################
	#Methods to fill document header fields
	###############################################
	
	###
	# Method Summary: Set Document Type Picklist
	#
	# @param [String] docType     Select "Invoice" or "Credit Note" as Document Type
	#
	def ERPBD.set_document_type docType
		find(:xpath,$erpbd_field_type).select(docType)
	end

	### 
	# Method Summary: Set Document Account
	#
	# @param [String] account     Value to fill in to the input field.
	#
	def ERPBD.set_document_account account
        ERPBD.select_account_from_lookup $erpbd_field_account, account
	end

	### 
	# Method Summary: Set Document Date
	#
	# @param [String] documentDate     Value to fill in to the input field.
	#
	def ERPBD.set_document_date documentDate
		find(:xpath,$erpbd_field_document_date).set(documentDate)
	end

	### 
	# Method Summary: Set Document Due Date
	#
	# @param [String] dueDate     Value to fill in to the input field.
	#
	def ERPBD.set_document_due_date dueDate
		find(:xpath,$erpbd_field_due_date).set(dueDate)
	end

	### 
	# Method Summary: Set Document Company
	#
	# @param [String] company     Value to fill in to the input field.
	#
	def ERPBD.set_document_company company
		find(:xpath,$erpbd_field_company).set(company)
	end

	### 
	# Method Summary: Set Document Customer Reference
	#
	# @param [String] customerReference     Value to fill in to the input field.
	#
	def ERPBD.set_document_customer_reference customerReference
		find(:xpath,$erpbd_field_customer_reference).set(customerReference)
	end

	### 
	# Method Summary: Set Document Description
	#
	# @param [String] description     Value to fill in to the input field.
	#
	def ERPBD.set_document_description description
		find(:xpath,$erpbd_field_description).set(description)
	end
	
	### 
	# Method Summary: Set Shipping Street
	#
	# @param [String] shippingStreet     Value to fill in to the input field.
	#
	def ERPBD.set_shipping_street shippingStreet
		find(:xpath,$erpbd_field_shipping_street).set(shippingStreet)
	end

	### 
	# Method Summary: Set Shipping City
	#
	# @param [String] cityName     Value to fill in to the input field.
	#	
	def ERPBD.set_shipping_city cityName
		find(:xpath,$erpbd_field_shipping_city).set(cityName)
	end
	
	### 
	# Method Summary: Set Shipping State or Province
	#
	# @param [String] stateName     Value to fill in to the input field.
	#	
	def ERPBD.set_shipping_state_or_province stateName
		find(:xpath,$erpbd_field_shipping_state_or_province).set(stateName)
	end
	
	### 
	# Method Summary: Set Shipping Zipcode
	#
	# @param [String] zipCode     Value to fill in to the input field.
	#	
	def ERPBD.set_shipping_zip_or_postalcode zipCode
		find(:xpath,$erpbd_field_shipping_zip_or_postalcode).set(zipCode)
	end
	
	### 
	# Method Summary: Set Shipping Country
	#
	# @param [String] country     Value to fill in to the input field.
	#	
	def ERPBD.set_shipping_country country
		find(:xpath,$erpbd_field_shipping_country).set(country)
	end
	
	### 
	# Method Summary: Get Document Status from the Billing Document
	#
	def ERPBD.get_document_status
		return find(:xpath,$erpbd_field_document_status_view).text
	end
	
	### 
	# Method Summary: Get Posting Status from the Billing Document
	#	
	def ERPBD.get_posting_status
		return find(:xpath,$erpbd_field_posting_status_view).text
	end

	### 
	# Method Summary: Get Document Number from the Billing Document
	#	
	def ERPBD.get_document_number
		return find(:xpath,$erpbd_field_document_number_view).text
	end

	### 
	# Method Summary: Get Account from the Billing Document on Community Layout
	#
	def ERPBD.get_account_community_layout
		return find(:xpath,$erpbd_community_field_account_view).text
	end

	### 
	# Method Summary: Get Document Number from the Billing Document on Community Layout
	#	
	def ERPBD.get_document_number_community_layout
		return find(:xpath,$erpbd_community_field_document_number_view).text
	end

	### 
	# Method Summary: Get Document Type from the Billing Document on Community Layout
	#	
	def ERPBD.get_document_type_community_layout
		return find(:xpath,$erpbd_community_field_document_type_view).text
	end

	### 
	# Method Summary: Get Payment Status from the Billing Document on Community Layout
	#	
	def ERPBD.get_payment_status_community_layout
		return find(:xpath,$erpbd_community_field_payment_status_view).text
	end

	### 
	# Method Summary: Get Outstanding Value from the Billing Document on Community Layout
	#	
	def ERPBD.get_outstanding_value_community_layout
		return find(:xpath,$erpbd_community_field_outstanding_value_view).text
	end

	#####################################
	#Methods to edit document lines
	#####################################

	### 
	# Method Summary: Set Product on line
	#
	# @param [String] productName     Value to fill in to the input field.
	#
	def ERPBD.set_product_on_line productName
		find(:xpath,$erpbd_field_line_product_or_service).set(productName)
	end

	### 
	# Method Summary: Set Unit Price on line
	#
	# @param [String] unitPrice     Value to fill in to the input field.
	#
	def ERPBD.set_unit_price_on_line unitPrice
		find(:xpath,$erpbd_field_line_unit_price).set(unitPrice)
	end

	### 
	# Method Summary: Set Quantity on line
	#
	# @param [String] quantity     Value to fill in to the input field.
	#
	def ERPBD.set_quantity_on_line quantity
		find(:xpath,$erpbd_field_line_quantity).set(quantity)
	end

	### 
	# Method Summary: Set Description on line
	#
	# @param [String] description     Value to fill in to the input field.
	#
	def ERPBD.set_description_on_line description
		find(:xpath,$erpbd_field_line_description).set(description)
	end

	##
	# Method Summary:  Method to open Billing Document Detail Page
	#
	# @param [String] document_number    Billing Document Number to open
	#
	def ERPBD.open_detail_page document_number
		record_to_click = $erpbd_link_pattern.gsub($sf_param_substitute, rule_name.to_s)
		find(:xpath , record_to_click).click
	end

	##
	# Method Summary:  Method to return Billing Document Line Number on Community Layout
	#
	# @param [String] line_number    Billing Line Number to Retrieve
	#
	def ERPBD.get_billing_document_line_on_community_layout line_number
		record = $erpbd_community_row_pattern.sub($sf_param_substitute, (line_number+1).to_s)
		return find(record).text
	end

    #############################
    # To select Account from look up icon as per account name passed
    # lookup_icon_name- name/locator of lookup icon, its values changes on every page.
    # search_account - Account which user want to select
    #############################
    def ERPBD.select_account_from_lookup lookup_icon_name, search_account
        SF.execute_script do
            find(lookup_icon_name).click
        end
        sleep 1# wait for the look up to appear
        within_window(windows.last) do
            page.has_text?($lookup_search_frame_lookup_text)
            account = search_account
            page.driver.browser.switch_to.frame $lookup_search_frame
            fill_in $lookup_search_text, with: account 
            SF.click_button_go
            SF.wait_for_search_button
            page.driver.browser.switch_to.default_content
            page.driver.browser.switch_to.frame $lookup_result_frame 
            rownum=2 #Searched account will be on row 1
            find($lookup_period_column_pattern.sub($sf_param_substitute , rownum.to_s)).click
            SF.wait_for_search_button
        end
    end

end