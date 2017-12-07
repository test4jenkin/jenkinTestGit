 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module SA
extend Capybara::DSL

# DFP Selectors
$sa_create_sales_invoice_button = "Create Sales Invoice"
$sa_sales_invoice_end_date_texbox = "input[Id*='EndDateField']"
$sa_sales_invoice_invoice_date_texbox = "input[Id*='Dates:InvoiceDate:InvoiceDateField']"
$sa_create_sales_invoice_confirm_button = "Confirm"
$sa_back_to_sales_agreement_button = "Back to Sales Agreement"

#billing line Items
$sa_line_item_new_billing_line_item = "input[value*='New Billing Line Item']"
$sa_billing_period_startdate = "//label[contains(text(),'Billing Period Start Date')]/../following-sibling::td/div/span/input"
$sa_billing_period_enddate = "//label[contains(text(),'Billing Period End Date')]/../following-sibling::td/div/span/input"
$sa_billing_ad_startdate = "//label[contains(text(),'Ad Start Date')]/../following-sibling::td/span/input"
$sa_billing_ad_enddate = "//label[contains(text(),'Ad End Date')]/../following-sibling::td/div/span/input"
$sa_billing_quantity_contracted_this_period = "//label[contains(text(),'Quantity Contracted This Period')]/../following-sibling::td/input"
$sa_billing_quantity_delivered_this_period = "//label[contains(text(),'Quantity Delivered This Period')]/../following-sibling::td/div/input"
$sa_billing_quantity = "//label[text()='Quantity']/../following-sibling::td/div/input"
$sa_billing_type = "//label[text()='Billing Type']/../following-sibling::td/div/span/select"
$sa_billing_total_cost = "//label[text()='Total Cost']/../following-sibling::td/div/input"
$sa_line_item_related_list_block = "//h3[text()='Sales Agreement Line Items']/ancestor::div[2]"
$sa_detail_account_name_column = "//td[text()='Account']/following-sibling::td[1]"
$sa_detail_agency_commission_column = "//td[text()='Agency Commission']/following-sibling::td[1]"
$sa_detail_campaign_start_date = "//td[text()='Campaign Start Date']/following-sibling::td[1]"
$sa_detail_campaign_end_date = "//td[text()='Campaign End Date']/following-sibling::td[1]"
$sa_detail_contract_value = "//td[text()='Contract Value']/following-sibling::td[1]"
$sa_line_item_ad_start_date = "//td[text()='Ad Start Date']/following-sibling::td[1]/div"
$sa_line_item_ad_end_date = "//td[text()='Ad End Date']/following-sibling::td[1]/div"
$sa_line_item_line_value = "//td[text()='Line Value']/following-sibling::td[1]/div"
#message
$sa_create_sales_invoice_in_progress = "Creating Sales Invoice. You will be notified by email when the process is complete."
#soql Query
$sa_sales_agreement_of_opportunity = "Select Id, Name from ffcm__SalesAgreement__c where ffcm__Opportunity__c IN (Select Id from Opportunity where Name='"+$sf_param_substitute+"')"
$sa_sales_agreement_line_item = "SELECT ID, Name from ffcm__SalesAgreementLineItem__c  WHERE ffcm__SalesAgreement__c='"+$sf_param_substitute+"'"
$sa_sales_invoice_from_opportunity = "SELECT Id, Name from #{ORG_PREFIX}codaInvoice__c where ffcm__SalesAgreement__c='"+$sf_param_substitute+"'"
$sa_inprogress_sales_invoice_from_opportunity = $sa_sales_invoice_from_opportunity + "AND #{ORG_PREFIX}InvoiceStatus__c='#{$bd_document_status_in_progress}'"
$sa_sales_credit_note_from_sales_invoice = "SELECT Id, Name, #{ORG_PREFIX}CreditNoteStatus__c, #{ORG_PREFIX}NetTotal__c from #{ORG_PREFIX}codaCreditNote__c where ffcm__SalesAgreement__c='"+$sf_param_substitute+"' AND #{ORG_PREFIX}Invoice__c= '"+$sf_param_substitute+"'"
                                           
$sa_id = "Id"
$sa_name = "Name"
$sa_sales_credit_note_status = "#{ORG_PREFIX}CreditNoteStatus__c"
$sa_sales_credit_note_total =  "#{ORG_PREFIX}CreditNoteTotal__c"
$sa_sales_credit_note_net_total = "#{ORG_PREFIX}NetTotal__c"

$sa_billing_line_item_product_column = "//td[text()='Product']/../td[2]//div"
$sa_billing_line_item_billing_period_start_date_column = "//td[text()='Billing Period Start Date']/../td[2]//div"
$sa_billing_line_item_billing_period_end_date_column = "//td[text()='Billing Period End Date']/../td[2]//div"
$sa_billing_line_item_ad_start_date_column = "//td[text()='Ad Start Date']/../td[4]//div"
$sa_billing_line_item_ad_end_date_column ="//td[text()='Ad End Date']/../td[4]//div"
$sa_billing_line_item_quantity_contracted_this_period_column ="//td[text()='Quantity Contracted This Period']/../td[2]//div"
$sa_billing_line_item_quantity_delivered_this_period_column ="//td[text()='Quantity Delivered This Period']/../td[4]//div"
$sa_billing_line_item_quantity_contracted_to_date_column ="//td[text()='Quantity Contracted To Date']/../td[2]//div"
$sa_billing_line_item_quantity_delivered_to_date_column ="//td[text()='Quantity Delivered To Date']/../td[4]//div"
$sa_billing_line_item_quantity_contracted_ad_lifetime_column ="//td[text()='Quantity Contracted Ad Lifetime']/../td[2]//div"
$sa_billing_line_item_quantity_delivered_ad_lifetime_column ="//td[text()='Quantity Delivered Ad Lifetime']/../td[4]//div"
$sa_billing_line_item_billable_quantity_this_period_column ="//td[text()='Billable Quantity This Period']/../td[2]//div"
$sa_billing_line_item_billable_quantity_to_date_column ="//td[text()='Billable Quantity To Date']/../td[4]//div"
$sa_billing_line_item_rate_method_column ="//td[text()='Rate Method']/../td[2]//div"
$sa_billing_line_item_billing_type_column ="//td[text()='Billing Type']/../td[2]//div"
$sa_billing_line_item_billing_cap_column ="//td[text()='Billing Cap']/../td[2]//div"
$sa_billing_line_item_total_cost_column ="//td[text()='Total Cost']/../td[4]//div"
$sa_billing_line_item_ad_rate_column ="//td[text()='Ad Rate']/../td[2]//div"

	# Methods 
	#Click on Create Sales Invoice button
	def SA.click_button_create_sales_invoice
		SF.click_button $sa_create_sales_invoice_button
		SF.wait_for_search_button
	end 
	
	#Click on Confirm button after Click on Create Sales Invoice button
	def SA.click_button_create_sales_invoice_confirm
		SF.click_button $sa_create_sales_invoice_confirm_button
		SF.wait_for_search_button
	end 
	
	#Click on Back button 
	def SA.click_button_back_to_sales_agreement
		SF.click_button $sa_back_to_sales_agreement_button
		SF.wait_for_search_button
	end
	
	#set sales invoice end date
	def SA.set_sales_invoice_end_date _end_date
		 find($sa_sales_invoice_end_date_texbox).set _end_date
	end 
	
	#set sales invoice invoice date
	def SA.set_sales_invoice_date _invoice_date
		 find($sa_sales_invoice_invoice_date_texbox).set _invoice_date
		 gen_tab_out $sa_sales_invoice_invoice_date_texbox
	end
	
	#click on Button "New Billing Line Item"
	def SA.click_new_billing_line_item
		 find($sa_line_item_new_billing_line_item).click
		 SF.wait_for_search_button
	end
	
	#Set Billing Line Item's billing period start date
	def SA.set_billing_line_item_billing_period_start_date start_date
		 find(:xpath,$sa_billing_period_startdate).set start_date
	end
	
	#Set Billing Line Item's billing period end date
	def SA.set_billing_line_item_billing_period_end_date end_date
		 find(:xpath,$sa_billing_period_enddate).set end_date
	end
	
	#Set Billing Line Item's ad period start date
	def SA.set_billing_line_item_ad_start_date start_date
		 find(:xpath,$sa_billing_ad_startdate).set start_date
	end
	
	#Set Billing Line Item's ad period end date
	def SA.set_billing_line_item_ad_end_date end_date
		 find(:xpath,$sa_billing_ad_enddate).set end_date
	end
	
	#Set Billing Line Item's quantity contracted this period
	def SA.set_billing_line_item_quantity_contracted_this_period _quantity_contracted_this_period
		 find(:xpath,$sa_billing_quantity_contracted_this_period).set _quantity_contracted_this_period
	end
	
	#Set Billing Line Item's quantity contracted this period
	def SA.set_billing_line_item_quantity_delivered_this_period _quantity_delivered_this_period
		 find(:xpath,$sa_billing_quantity_delivered_this_period).set _quantity_delivered_this_period
	end
	
	#set billing Line Item's quanity
	def SA.set_billing_line_item_quantity _billing_quantity
		 find(:xpath,$sa_billing_quantity).set _billing_quantity
	end
	
	#set billing Line Item's billing quantity
	def SA.set_billing_line_item_billing_type _billing_type
		 find(:xpath,$sa_billing_type).select _billing_type
	end
	
	##set billing Line Item's total cost
	def SA.set_billing_line_item_total_cost _cost
		 find(:xpath,$sa_billing_total_cost).set _cost
	end
	
	#click on sales agreement line Item name
	def SA.view_sales_agreement_line_item _sales_agreement_line_item_name
		within(:xpath, $sa_line_item_related_list_block)do
			SF.click_link _sales_agreement_line_item_name
		end
	end
	
	#get sales agreement top 1 name and Id from opportunity
	#opportunity_name - Name of opportunity
	def SA.get_sales_agreement_name_and_id_from_opportunity opportunity_name
		APEX.execute_soql $sa_sales_agreement_of_opportunity.gsub($sf_param_substitute, opportunity_name )
		_sales_agreement_id = APEX.get_field_value_from_soql_result $sa_id
		_sales_agreement_name = APEX.get_field_value_from_soql_result $sa_name
		return _sales_agreement_id, _sales_agreement_name
	end
	
	#get sales agreement line Item from sales agreement Id
	def SA.get_sales_agreement_line_item sales_agreement_id
		APEX.execute_soql $sa_sales_agreement_line_item.gsub($sf_param_substitute, sales_agreement_id )
		_sales_agreement_line_item_id = APEX.get_field_value_from_soql_result $sa_id
		_sales_agreement_line_item_name = APEX.get_field_value_from_soql_result $sa_name
		return _sales_agreement_line_item_id, _sales_agreement_line_item_name
	end
	
	#get Sales invoice Id,Name for sales Agreement
	def SA.get_sales_invoice_details_from_sales_agreement sales_agreement_id
		APEX.execute_soql $sa_sales_invoice_from_opportunity.gsub($sf_param_substitute, sales_agreement_id )
		_sales_invoice_id = APEX.get_field_value_from_soql_result $sa_id
		_sales_invoice_name = APEX.get_field_value_from_soql_result $sa_name
		return _sales_invoice_id, _sales_invoice_name
	end
	
	#get inprogress sales invoice id, name for sales Agreement 
	def SA.get_inprogress_sales_invoice_details sales_agreement_id
		APEX.execute_soql $sa_inprogress_sales_invoice_from_opportunity.gsub($sf_param_substitute, sales_agreement_id )
		_sales_invoice_id = APEX.get_field_value_from_soql_result $sa_id
		_sales_invoice_name = APEX.get_field_value_from_soql_result $sa_name
		return _sales_invoice_id, _sales_invoice_name
	end
	
	#get sales credit note details from sales invoice and sales agreement Id
	def SA.get_credit_note_details_from_sales_agreement sales_agreement_id, sales_invoice_id
		APEX.execute_soql $sa_sales_credit_note_from_sales_invoice.sub($sf_param_substitute, sales_agreement_id).sub($sf_param_substitute, sales_invoice_id )
		#APEX.execute_soql $sa_sales_credit_note_from_sales_invoice.gsub($sf_param_substitute, sales_invoice_id )
		_sales_credit_note_id = APEX.get_field_value_from_soql_result $sa_id
		_sales_credit_note_name = APEX.get_field_value_from_soql_result $sa_name
		_sales_credit_note_status = APEX.get_field_value_from_soql_result $sa_sales_credit_note_status 
		_sales_credit_note_net_total = APEX.get_field_value_from_soql_result $sa_sales_credit_note_net_total
		return  _sales_credit_note_id, _sales_credit_note_name, _sales_credit_note_status, _sales_credit_note_net_total
	end
	
	#get Account Name
	def SA.get_account_name
		return find(:xpath, $sa_detail_account_name_column).text
	end
	
	#get agency commision
	def SA.get_agency_commision
		return find(:xpath, $sa_detail_agency_commission_column).text
	end
	
	#get campaign start date
	def SA.get_campaign_start_date
		return find(:xpath, $sa_detail_campaign_start_date).text
	end
	
	#get campaign end date
	def SA.get_campaign_end_date
		return find(:xpath, $sa_detail_campaign_end_date).text
	end
	
	#get contract value
	def SA.get_contract_value
		return find(:xpath, $sa_detail_contract_value).text
	end
	
	#get Line Item ad start date 
	def SA.get_line_item_ad_start_date
		return find(:xpath, $sa_line_item_ad_start_date).text
	end
	
	#get Line Item ad end date 
	def SA.get_line_item_ad_end_date
		return find(:xpath, $sa_line_item_ad_end_date).text
	end
	
	#get line item line value 
	def SA.get_line_item_line_value
		return find(:xpath, $sa_line_item_line_value).text
	end
	
	#get billing line item product value 
	def SA.get_billing_line_item_product_value
		return find(:xpath, $sa_billing_line_item_product_column).text
	end
	
	#get billing line item billing_period_start_date value 
	def SA.get_billing_line_item_billing_period_start_date_value
		return find(:xpath, $sa_billing_line_item_billing_period_start_date_column).text
	end
	
	#get billing line item billing_period_end_date value 
	def SA.get_billing_line_item_billing_period_end_date_value
		return find(:xpath, $sa_billing_line_item_billing_period_end_date_column).text
	end
	
	#get billing line item ad_start_date value 
	def SA.get_billing_line_item_ad_start_date_value
		return find(:xpath, $sa_billing_line_item_ad_start_date_column).text
	end
	
	#get billing line item ad_end_date value 
	def SA.get_billing_line_item_ad_end_date_value
		return find(:xpath, $sa_billing_line_item_ad_end_date_column).text
	end
	#get billing line item quantity_contracted_this_period value 
	def SA.get_billing_line_item_quantity_contracted_this_period_value
		return find(:xpath, $sa_billing_line_item_quantity_contracted_this_period_column).text
	end
	
	#get billing line item quantity_delivered_this_period value 
	def SA.get_billing_line_item_quantity_delivered_this_period_value
		return find(:xpath, $sa_billing_line_item_quantity_delivered_this_period_column).text
	end
	
	#get billing line item quantity_contracted_to_date value 
	def SA.get_billing_line_item_quantity_contracted_to_date_value
		return find(:xpath, $sa_billing_line_item_quantity_contracted_to_date_column).text
	end
	
	#get billing line item quantity_delivered_to_date value 
	def SA.get_billing_line_item_quantity_delivered_to_date_value
		return find(:xpath, $sa_billing_line_item_quantity_delivered_to_date_column).text
	end
	
	#get billing line item quantity_delivered_ad_lifetime value 
	def SA.get_billing_line_item_quantity_delivered_ad_lifetime_value
		return find(:xpath, $sa_billing_line_item_quantity_delivered_ad_lifetime_column).text
	end
	
	#get billing line item billable_quantity_this_period value 
	def SA.get_billing_line_item_billable_quantity_this_period_value
		return find(:xpath, $sa_billing_line_item_billable_quantity_this_period_column).text
	end
	
	#get billing line item billable_quantity_to_date value 
	def SA.get_billing_line_item_billable_quantity_to_date_value
		return find(:xpath, $sa_billing_line_item_billable_quantity_to_date_column).text
	end
	
	#get billing line item rate_method value 
	def SA.get_billing_line_item_rate_method_value
		return find(:xpath, $sa_billing_line_item_rate_method_column).text
	end
	
	#get billing line item billing_type value 
	def SA.get_billing_line_item_billing_type_value
		return find(:xpath, $sa_billing_line_item_billing_type_column).text
	end
	
	#get billing line item billing_cap value 
	def SA.get_billing_line_item_billing_cap_value
		return find(:xpath, $sa_billing_line_item_billing_cap_column).text
	end
	
	#get billing line item total_cost value 
	def SA.get_billing_line_item_total_cost_value
		return find(:xpath, $sa_billing_line_item_total_cost_column).text
	end
	
	#get billing line item ad_rate value 
	def SA.get_billing_line_item_ad_rate_value
		return find(:xpath, $sa_billing_line_item_ad_rate_column).text
	end	
end