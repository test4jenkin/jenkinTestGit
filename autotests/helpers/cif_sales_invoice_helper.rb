#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

module CIF_SINV
  extend Capybara::DSL

############################
#CIF Sales Invoice locators
############################
SALES_INVOICE_COLUMN_PRODUCT = 2
SALES_INVOICE_COLUMN_QUANTITY = 4
SALES_INVOICE_COLUMN_UNIT_PRICE = 5
SALES_INVOICE_COLUMN_UNIT_DIMENSION_1 = 10
SALES_INVOICE_COLUMN_UNIT_DIMENSION_2 = 11
SALES_INVOICE_COLUMN_LINE_DESCRIPTION = 12
SALES_INVOICE_COLUMN_UNIT_TAX_CODE = 13

# Sales Invoice read and write element locations on header section.
  $cif_sales_invoice_account = "input[name$='Account__c']"
  $cif_sales_invoice_account_selector_drop_down = "div[data-ffid$='Account__c'] div[class*='f-form-arrow-trigger']"
  $cif_sales_invoice_invoice_date = "input[name$='InvoiceDate__c']"
  $cif_sales_invoice_due_date = "input[name$='DueDate__c']"
  $cif_sales_invoice_period = "input[name$='Period__c']"
  $cif_sales_invoice_invoice_curreny = "input[name$='InvoiceCurrency__c']"
  $cif_sales_invoice_customer_reference = "input[name$='CustomerReference__c']"
  $cif_sales_invoice_invoice_description = "div[data-ffid$='InvoiceDescription__c'] div[data-ffid$='content'] textarea"
  $cif_sales_invoice_customer_reference_view = "div[data-ffid$='CustomerReference__c'] div:nth-child(2) div"
  $cif_sales_invoice_invoice_description_view = "div[data-ffid$='InvoiceDescription__c'] div:nth-child(2) div"
  $cif_sales_invoice_net_total = "div[data-ffid$='NetTotal__c'] div:nth-child(2) div"
  $cif_sales_invoice_tax_total = "div[data-ffid$='TaxTotal__c'] div:nth-child(2) div"
  $cif_sales_invoice_invoice_total = "div[data-ffid$='InvoiceTotal__c'] div:nth-child(2) div"
  $cif_sales_invoice_transaction = "div[data-ffid$='Transaction__c'] div:nth-child(2) div"
  $cif_sales_invoice_invoice_status = "div[data-ffid$='InvoiceStatus__c'] div:nth-child(2) div"
  $cif_sales_invoice_hold_status = "div[data-ffid$='HoldStatus__c'] div:nth-child(2) div"
  $cif_sales_invoice_payment_status = "div[data-ffid$='PaymentStatus__c'] div:nth-child(2) div"
  $cif_sales_invoice_outstanding_value = "div[data-ffid$='OutstandingValue__c'] div:nth-child(2) div"
  $cif_sales_invoice_invoice_number = "div[data-ffid$='Name'] div:nth-child(2) div"
  $cif_sales_invoice_account_dropdown_trigger = "//input[contains(@name,'Account__c')]/following::div[1]"
# Sales Invoice Ids on input form manager header elements
  $cif_sales_invoice_account_ifm_field_id = "#{ORG_PREFIX}codaInvoice__c__#{ORG_PREFIX}Account__c";
  $cif_sales_invoice_invoice_date_ifm_field_id = "#{ORG_PREFIX}codaInvoice__c__#{ORG_PREFIX}InvoiceDate__c";
  $cif_sales_invoice_due_date_ifm_field_id = "#{ORG_PREFIX}codaInvoice__c__#{ORG_PREFIX}DueDate__c";
  $cif_sales_invoice_net_total_ifm_field_id = "#{ORG_PREFIX}codaInvoice__c__#{ORG_PREFIX}NetTotal__c";

# Sales Invoice read and write element locations in Sales invoice line items section.
  $cif_sales_invoice_line_items_tab = "div[data-ffxtype$='grid-area'] div[data-ffxtype = 'tabbar'] div:nth-child(2) div a:nth-child(2) span span span:nth-child(2)"
  $cif_sales_invoice_line_item_click_new_row = ".cf-grid-rowdeletecolumn-image.cf-grid-rowdeletecolumn-value"
  $cif_sales_invoice_line_item_product = "input[name$='Product__c']"
  $cif_sales_invoice_line_item_destination_company = "input[name$='DestinationCompany__c']"
  $cif_sales_invoice_line_item_quantity = "input[name$='Quantity__c']"
  $cif_sales_invoice_line_item_unit_price = "input[name$='UnitPrice__c']"
  $cif_sales_invoice_line_item_net_value = "input[name$='NetValue__c']"
  $cif_sales_invoice_line_item_destination_quantity = "input[name$='DestinationQuantity__c']"
  $cif_sales_invoice_line_item_destination_unit_price = "input[name$='DestinationUnitPrice__c']"
  $cif_sales_invoice_line_item_destination_net_value = "input[name$='DestinationNetValue__c']"
  $cif_sales_invoice_line_item_dimension1 = "input[name$='Dimension1__c']"
  $cif_sales_invoice_line_item_dimension2 = "input[name$='Dimension2__c']"
  $cif_sales_invoice_line_item_line_description = "div[data-ffid$='LineDescription__c'] textarea"
  $cif_sales_invoice_line_item_tax_code1 ="input[name$='TaxCode1__c']"
  $cif_sales_invoice_line_item_tax_rate1 = "input[name$='TaxRate1__c']"
  $cif_sales_invoice_line_item_tax_value1 = "input[name$='TaxValue1__c']"
  $cif_sales_invoice_line_item_tax_code2 = "div[data-ffid$='TaxCode2__c'] div[data-ffid='lookup'] input"
  $cif_sales_invoice_line_item_tax_rate2 = "input[name$='TaxRate2__c']"
  $cif_sales_invoice_line_item_tax_value2 = "input[name$='TaxValue1__c']"
  $cif_sales_invoice_line_item_tax_code3 = "div[data-ffid$=TaxCode3__c] div[data-ffid='lookup'] input"
  $cif_sales_invoice_line_item_tax_rate3 = "input[name$='TaxRate3__c']"
  $cif_sales_invoice_line_item_tax_value3 = "input[name$=TaxValue3__c]"
  $cif_sales_invoice_product = "div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{SALES_INVOICE_COLUMN_PRODUCT})"
  $cif_sales_invoice_quantity = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{SALES_INVOICE_COLUMN_QUANTITY})"
  $cif_sales_invoice_unit_price = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{SALES_INVOICE_COLUMN_UNIT_PRICE})"
  $cif_sales_invoice_dimention_1 = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{SALES_INVOICE_COLUMN_UNIT_DIMENSION_1})"
  $cif_sales_invoice_dimention_2 = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{SALES_INVOICE_COLUMN_UNIT_DIMENSION_2})"
  $cif_sales_invoice_tax_code = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{SALES_INVOICE_COLUMN_UNIT_TAX_CODE})"
  $cif_sales_invoice_related_list_toolbar = "div[data-ffxtype=cfv-related-toolbar]"
  $cif_sales_invoice_related_list_chatter_input = "img[class='visibilityicon  active']"
  $cif_sales_invoice_disabled_item = "[class*='f-item-disabled']"
# Sales Invoice read and write locations in Sales Invoice List View
  $cif_sales_invoice_list_view_grid = "div[class*=x-grid3-row]"

# Sales Invoice buttons
  $cif_sales_invoice_pricebook_button = "a[data-ffid='pricebookbutton']"

# Price Book Search PopUp
  $cif_sales_invoice_pricebook_search_popup_label = "div[data-ffxtype = 'priceBookSearchWindow'] div[class*='f-title-text']"
  $cif_sales_invoice_pricebook_search_popup = "div[data-ffxtype='priceBookSearchWindow']"
  $cif_sales_invoice_pricebook_search_popup_search_box = "div[data-ffid='searchBox'] input"
  $cif_sales_invoice_pricebook_search_popup_search_icon = "div[data-ffid= 'searchBox'] div[class*= 'form-search-trigger']"
  $cif_sales_invoice_pricebook_search_popup_Name = $cif_sales_invoice_pricebook_search_popup + "div[data-ffid='Name']"
  $cif_sales_invoice_pricebook_search_popup_Code = $cif_sales_invoice_pricebook_search_popup + "div[data-ffid='Code']"
  $cif_sales_invoice_pricebook_search_popup_PriceBook_name = $cif_sales_invoice_pricebook_search_popup + "div[data-ffid='PBName']"
  $cif_sales_invoice_pricebook_search_popup_Price = $cif_sales_invoice_pricebook_search_popup + "div[data-ffid='Price']"
  $cif_sales_invoice_pricebook_search_popup_selectall_checkbox = "div[class*= 'f-column-header-checkbox'] div[class*= 'f-column-header-text']"
  $cif_sales_invoice_pricebook_search_popup_cancel_button = "div[data-ffid= 'bottomToolbar'] a[data-ffid='cancelBtn']"
  $cif_sales_invoice_pricebook_search_popup_add_button = "div[data-ffid= 'bottomToolbar'] a[data-ffid='addProductLinesBtn']"
  $cif_sales_invoice_pricebook_search_popup_addAndClose_button = "div[data-ffid= 'bottomToolbar'] a[data-ffid='addAndCloseBtn']"
  $cif_sales_invoice_pricebook_search_popup_viewAllLink = "label[data-ffid='viewAllLink']"
  $cif_sales_invoice_pricebook_search_popup_recentlyAddedLink = "label[data-ffid='viewRecentLink']"
  $cif_sales_invoice_pricebook_search_popup_default_close_button = "div[data-ffxtype = 'priceBookSearchWindow'] img"
  $cif_sales_invoice_pricebook_search_popup_inlineText_label = "div[data-ffid='searchProductGrid'] div[class*='f-grid-empty']"
  
# Price book search toast
  $cif_sales_invoice_pricebook_toast_message = "div[data-ffxtype='toast'] div[data-ref='body'] div"
  
# Price book search grid
  $cif_sales_invoice_pricebook_search_grid = "div[data-ffid = 'searchProductGrid']"
  $cif_sales_invoice_pricebook_recently_added_grid = "div[data-ffid = 'recentProductsGrid']"
  
#############################################
# Helper methods for Sales invoice header section.
#############################################

##
# Method Summary: Find the Account input field and set the value.
#
# @param [String] account     Text account name to pass in to the account field.
#
  def CIF_SINV.set_sinv_account account
    SF.execute_script do
		CIF.set_value_tab_out $cif_sales_invoice_account, account	
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	end
  end

##
# Method Summary: Find the invoice currency input field and set the value.
#
# @param [String] invoice_currency     Text invoice currency name to pass in to the invoice currency field.
#
  def CIF_SINV.set_sinv_invoice_currency invoice_currency
    CIF.set_value_tab_out $cif_sales_invoice_invoice_curreny, invoice_currency
  end  

##
# Method Summary: Find the period input field and set the value.
#
# @param [String] period     Text period name to pass in to the period field.
#
  def CIF_SINV.set_sinv_period period
    CIF.set_value_tab_out $cif_sales_invoice_period, period
  end
 
##
# Method Summary: Find the invoice description input field and set the value.
#
# @param [String] description     Text description to pass in to the description field.
#
  def CIF_SINV.set_sinv_invoice_description description
    CIF.set_value $cif_sales_invoice_invoice_description, description
  end

##
# Method Summary: Find the invoice date input field and set the date.
#
# @param [String] date     Date to pass in to the date field.
#
  def CIF_SINV.set_sinv_invoice_date date
    CIF.set_value_tab_out $cif_sales_invoice_invoice_date, date
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
# Method Summary: Find the vendor invoice number input field and set the value.
#
# @param [String] invnumber     invnumber to pass in to the vendor invoice number field.
#  

  def CIF_SINV.set_sinv_vendor_invoice_number invnumber
    CIF.set_value $cif_sales_invoice_vendor_invoice_number, invnumber
  end
  
##
# Method Summary: Find the invoice customer reference input field and set the value.
#
# @param [String] customer_reference    Value to pass in to the customer reference field.
#  

  def CIF_SINV.set_sinv_customer_reference customer_reference
    CIF.set_value_tab_out $cif_sales_invoice_customer_reference, customer_reference
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
#########################################################################################################################
# Helper methods for Sales invoice line item section.
# For creating a Sales invoice line item, all the fields should be given values in the same order they apear on the UI
# as all below methods use tab out which will automatically take user to next field apearing in the row.
#########################################################################################################################
##
# Method Summary: Find the product input field on SINV line item and set the value.
#
# @param [String] product_name     Text to pass in to the product field.
# @param [String] line_num         Line Number where product needs to be set [DEFAULT = 1]
# 
  def CIF_SINV.set_sinv_line_product product_name,line_num=1
	SF.execute_script do
		object_visible = gen_is_object_visible $cif_sales_invoice_line_item_product
		if (!object_visible)
			record_to_click = $cif_sales_invoice_product.gsub($sf_param_substitute, line_num.to_s)
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_sales_invoice_line_item_product, product_name	
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
	end
  end
  
##
# Method Summary: Find the Destination Company input field and select the Company from the list.
#
# @param [String] destinationCompany     Text to pass in to the destination company.
#
  def CIF_SINV.set_sinv_line_destination_company destinationCompany
    CIF.set_value_tab_out $cif_sales_invoice_line_item_destination_company, destinationCompany
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end  
  
##
# Method Summary: Find the Quantity input field on SINV line item and set the value.
#
# @param [Integer] quantity     Integer to pass in to the quantity field.
#
  def CIF_SINV.set_sinv_line_quantity  quantity	,line=1
	SF.execute_script do
		object_visible = gen_is_object_visible $cif_sales_invoice_line_item_quantity
		if (!object_visible)
			record_to_click = $cif_sales_invoice_quantity.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_sales_invoice_line_item_quantity, quantity
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
	end
  end

##
# Method Summary: Find the Unit Price input field on SINV line item and set the value.
#
# @param [Integer] unit_price     Integer to pass in to the Unit Price field.
#
  def CIF_SINV.set_sinv_line_unit_price unit_price, line=1
	  SF.execute_script do
		object_visible = gen_is_object_visible $cif_sales_invoice_line_item_unit_price
		if (!object_visible)
			record_to_click = $cif_sales_invoice_unit_price.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_sales_invoice_line_item_unit_price, unit_price
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
	  end 
  end 

##
# Method Summary: Find the Destination Quantity input field on SINV line item and set the value.
#
# @param [Integer] destination_quantity     Integer to pass in to the Destination Quantity field.
#
  def CIF_SINV.set_destination_quantity destination_quantity
    find($cif_sales_invoice_line_item_destination_quantity).set destination_quantity
    gen_tab_out $cif_sales_invoice_line_item_destination_quantity
  end

##
# Method Summary: Find the Destination Unit Price input field on SINV line item and set the value.
#
# @param [Integer] destination_unit_price     Integer to pass in to the Destination Unit Price field.
#
  def CIF_SINV.set_destination_unit_price destination_unit_price
    find($cif_sales_invoice_line_item_destination_unit_price).set destination_unit_price
    gen_tab_out $cif_sales_invoice_line_item_destination_unit_price
  end 
  
##
# Method Summary: Find the dimension value1 input field on SINV line item and select the dimension form the list.
#
# @param [String] dimensionValue1     Text to pass in to the dimension1 field.
#
  def CIF_SINV.set_sinv_line_dimesion_1 dimension_value1, line=1
	SF.execute_script do
		object_visible = gen_is_object_visible $cif_sales_invoice_line_item_dimension1
		if (!object_visible)
			record_to_click = $cif_sales_invoice_dimention_1.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end	
		CIF.set_value_tab_out $cif_sales_invoice_line_item_dimension1, dimension_value1	
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	end
  end

##
# Method Summary: Find the dimension value2 input field on SINV line item and select the dimension form the list.
#
# @param [String] dimensionValue2     Text to pass in to the dimension1 field.
#
  def CIF_SINV.set_sinv_line_dimesion_2  dimension_value2, line=1
	SF.execute_script do
		object_visible = gen_is_object_visible $cif_sales_invoice_line_item_dimension2
		if (!object_visible)
			record_to_click = $cif_sales_invoice_dimention_2.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_sales_invoice_line_item_dimension2, dimension_value2	
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	end
  end
  
##
# Method Summary: Find the line description input field on SINV line item and set the value into it.
#
# @param [String] lineDescription     Text to pass in to the line description field.
#
  def CIF_SINV.set_sinv_line_line_description line_description
    CIF.set_value_tab_out $cif_sales_invoice_line_item_line_description, line_description
	  CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	  CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
# Method Summary: Find the input tax code input field on SINV line item and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the input tax code field.
#
  def CIF_SINV.set_sinv_line_tax_code  tax_code_name, line=1
	SF.execute_script do
		object_visible = gen_is_object_visible $cif_sales_invoice_line_item_tax_code1
		if (!object_visible)
			record_to_click = $cif_sales_invoice_tax_code.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_sales_invoice_line_item_tax_code1, tax_code_name
		  CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
	end
  end
  
##
# Method Summary: Find the tax rate field on SINV line item and set the rate.
#
# @param [String] tax_rate     Text to pass in to the input tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_SINV.set_sinv_line_tax_rate tax_rate, change_tax_rate
  	if(change_tax_rate == false)
  		gen_tab_out $cif_sales_invoice_line_item_tax_rate1
  		else if(change_tax_rate == true)
  			CIF.set_value_tab_out $cif_sales_invoice_line_item_tax_rate1, tax_rate
  			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  		else
  			puts 'change_tax_rate variable can have only boolean values'
  		end	
  	end	
  end  

##
# Method Summary: Find the input tax value input field on SINV line item and set the value.
#
# @param [Integer] tax_value     Number to pass in to the input tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_SINV.set_sinv_line_tax_value tax_value, change_tax_value
  	if(change_tax_value == false)
  		gen_tab_out $cif_sales_invoice_line_item_tax_value1
  		else if(change_tax_value == true)
  			CIF.set_value_tab_out $cif_sales_invoice_line_item_tax_value1, tax_value
  			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  		else
  			puts 'change_tax_value variable can have only boolean values'
  		end
  	end	
  end

##
# Method Summary: Select a Sales Invoice using the account name.
#
# @param [String] search_text_account_name     Account name to use in search for sales invoice ID.
#
  def CIF_SINV.select_sales_invoice_on_list_view search_text_account_name
      row = gen_get_row_in_grid $cif_sales_invoice_list_view_grid, search_text_account_name , 5
      find("div[class*=x-grid3-row]:nth-of-type(#{row}) table td:nth-of-type(4)").click
      gen_wait_less
  end

#
# Method Summary: Method to click in a column for specified row.
#
  def CIF_SINV.click_column_grid_data_row row_number, col_number
    find("div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type(#{row_number}) tr td:nth-of-type(#{col_number})").click
  end
  
##
# Method Summary: Method to get the value from a column for specified row.
#
  def CIF_SINV.get_column_value_from_grid_data_row row_number, col_number
	 return find("div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type(#{row_number}) tr td:nth-of-type(#{col_number}) div").text
  end  

##
#
# Method Summary: Method to get the value from a column for specified row in CIF view mode
#
  def CIF_SINV.get_column_value_from_grid_data_row_on_view_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
  end

##
#
# Method Summary: Method to get the value from a column for specified row in CIF amend page
#
  def CIF_SINV.click_column_grid_data_row_amend_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
  end

##############
# Buttons
##############

##
# Method Summary: Click the save button.
#
  def CIF_SINV.click_sinv_save_button
	SF.execute_script do
		CIF.click_save_button
		gen_wait_less
	end
  end

##
# Method Summary: Click the save and new SINV button.
#
  def CIF_SINV.click_sinv_save_new_button
    CIF.click_save_new_button
  end

##
# Method Summary: Click the save and post SINV button.
#
  def CIF_SINV.click_sinv_save_post_button
    SF.execute_script do
		CIF.click_save_post_button
		gen_wait_long
	end
  end

##
# Method Summary: Click the post SINV button.
#
  def CIF_SINV.click_sinv_post_button
    CIF.click_post_button
  end

##
# Method Summary: Click the cancel SINV button.
#
  def CIF_SINV.click_sinv_cancel_button
    CIF.click_cancel_button
  end

##
# Method Summary: Method to compare the values of sales invoice line item.
#
# @param [String]  date            Expected date to compare with the actual value.
# @param [String]  period          Expected period to compare with the actual value.
# @param [String]  currency        Expected currency to compare with the actual value.
# @param [Integer] reference       Expected reference to compare with the actual value.
# @param [String]  description     Expected description to compare with the actual value.
# @param [String]  type            Expected type to compare with the actual value.
# @param [String]  status          Expected status to compare with the actual value.
# @param [Integer] value           Expected value to compare with the actual value.
#
  def CIF_SINV.compare_sinv_header_details(date, period, currency, net_total, tax_total, invoice_total, status)
    if date != nil
      page.assert_selector('div[data-ffid$="InvoiceDate__c"] div div', :text =>date, :visible => true)
    end
    if period != nil
      page.assert_selector('div[data-ffid$="Period__c"] div div', :text => period, :visible => true)
    end
    if currency != nil
      page.assert_selector('div[data-ffid$="InvoiceCurrency__c"] div div', :text => currency, :visible => true)
    end
    if net_total != nil
      page.assert_selector('div[data-ffid$="NetTotal__c"] div:nth-of-type(1) div', :text => net_total, :visible => true)
    end
    if tax_total != nil
      page.assert_selector('div[data-ffid$="TaxTotal__c"] div:nth-of-type(1) div', :text => tax_total, :visible => true)
    end
    if invoice_total != nil
      page.assert_selector('div[data-ffid$="InvoiceTotal__c"] div:nth-of-type(1) div', :text => invoice_total, :visible => true)
    end
    if status != nil
      page.assert_selector('div[data-ffid$="InvoiceStatus__c"] div:nth-of-type(1) div', :text => status, :visible => true)
    end
  end

##
# Method Summary : Click on new row
#
  def CIF_SINV.click_new_row
	  SF.retry_script_block do
		  CIF.click_new_row
	  end
  end
##
# Method Summary : Create New Event in the related list toolbar
#
  def CIF_SINV.create_new_event event_name
	SF.execute_script do
		find($cif_related_list_new_event).click
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK	
		fill_in $cif_related_list_task_item_subject, with: event_name
		SF.click_button_save
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	end
  end
##
# Method Summary : Create New Task in the related list toolbar
#
  def CIF_SINV.create_new_task task_name
	SF.execute_script do
		find($cif_related_list_new_task).click
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK	
		fill_in $cif_related_list_task_item_subject, with: task_name
		SF.click_button_save
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	end
  end
##
# Method Summary : Create New Note in the related list toolbar
#
  def CIF_SINV.create_new_note note_name
	SF.execute_script do
		gen_wait_until_object $cif_related_list_new_note
		find($cif_related_list_new_note).click
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK	
		find($cif_related_list_note_title).set note_name
		SF.click_button_save
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	end
  end
##
# Method Summary : Create new chat message in the related list toolbar for chatter item
#  
  def CIF_SINV.create_new_chat_message chatter_message
	SF.execute_script do
		gen_wait_until_object $cif_related_list_chatter_frame
		within_frame(find(:xpath, $cif_related_list_chatter_frame)) do			
			page.has_css?($cif_related_list_chatter_share_button)
			find($cif_related_list_chatter_box).hover
			sleep 1# wait for the text area to get highlighted.
			find($cif_related_list_chatter_box).click
			page.has_css?($cif_sales_invoice_related_list_chatter_input)
			gen_wait_until_object $cif_related_list_chatter_editor_frame
			within_frame(find(:xpath, $cif_related_list_chatter_editor_frame)) do
				find($cif_related_list_chatter_editor_area).set chatter_message
			end
			find($cif_related_list_chatter_share_button).click		
		end
	end
  end
##
# Method Summary : Attach file in the attachment
#
  def CIF_SINV.attach_file_in_related_list_toolbar file_name
	SF.execute_script do
		find($cif_related_list_new_attachment).click
		FFA.upload_file "file",file_name
		find($ffa_attach_button).click
		find($ffa_attach_done_button).click
	end
  end
##
# Method Summary : Returns the invoice status value
#
  def CIF_SINV.get_invoice_status
    return find($cif_sales_invoice_invoice_status).text
  end

##
# Method Summary : Returns the customer reference value
#
  def CIF_SINV.get_customer_reference
    return find($cif_sales_invoice_customer_reference_view).text
  end

##
# Method Summary : Returns the invoice description value
#
  def CIF_SINV.get_invoice_description
    return find($cif_sales_invoice_invoice_description_view).text
  end


##
# Method Summary : Create 'Sales Order Custom Object' Related list Record on Sales Invoice
#
# @param [String]  String            Sales Invoice Number where custom object record needs to be created.
#
  def CIF_SINV.create_related_list_sales_order_custom_object_record sin_number
    SF.execute_script do
      gen_wait_until_object $cif_related_list_new_sales_order_custom_object
      find($cif_related_list_new_sales_order_custom_object).click
      CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK 
      find(:xpath,$cif_related_list_custom_object_input).set sin_number
      SF.click_button_save
      CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    end
  end

##
# Method summary : Method to get Sales Invoice Number
#
  def CIF_SINV.get_invoice_number
    return find($cif_sales_invoice_invoice_number).text
  end
  
##
# Method Summary: Method to get pricebook toast message
#
  def CIF_SINV.get_pricebook_toast_message
	return find($cif_sales_invoice_pricebook_toast_message).text
  end

##
# Method Summary: Method to add the product line items through price book search window
#
  def CIF_SINV.click_sinv_add_from_price_book_button
	SF.execute_script do
		gen_wait_more
		find($cif_sales_invoice_pricebook_button).click
	end
  end

##
# Method Summary: Method to check disabled button on sales invoice
#  
  def CIF_SINV.is_item_disabled? button
	  disabled_item = button+$cif_sales_invoice_disabled_item
	  return page.has_css?(disabled_item)
  end

##
# Method Summary: Method to search the products filtered on the basis of product name or code
#
  def CIF_SINV.click_sinv_search_icon
	SF.execute_script do
		find($cif_sales_invoice_pricebook_search_popup_search_icon).click
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		gen_wait_until_object $cif_sales_invoice_pricebook_search_popup_cancel_button
	end
  end

##
# Method Summary: Method to close the price book search popup window
#
  def CIF_SINV.click_sinv_price_book_search_popup_cancel_button
    find($cif_sales_invoice_pricebook_search_popup_cancel_button).click
  end
  
##
# Method Summary: Method to add multiple product lines to price book search popup window
#
  def CIF_SINV.click_sinv_price_book_search_popup_add_button
    find($cif_sales_invoice_pricebook_search_popup_add_button).click
  end
  
##
# Method Summary: Method to add multiple product lines to price book search popup window and then close price book search window
#
  def CIF_SINV.click_sinv_price_book_search_popup_add_and_close_button
    find($cif_sales_invoice_pricebook_search_popup_addAndClose_button).click
  end
  
##
# Method Summary: Method to view All products of active pricebook
#
  def CIF_SINV.click_sinv_price_book_search_popup_view_all_link
    find($cif_sales_invoice_pricebook_search_popup_viewAllLink).click
	gen_wait_until_object $cif_sales_invoice_pricebook_search_popup_cancel_button
  end
  
##
# Method Summary: Method to view recently added products of active pricebook
#
  def CIF_SINV.click_sinv_price_book_search_popup_recently_added_link
    find($cif_sales_invoice_pricebook_search_popup_recentlyAddedLink).click
  end
  
##
# Method Summary: Method to click default close button of pricebook search window
#
  def CIF_SINV.click_sinv_price_book_search_popup_default_close_button
	SF.retry_script_block do 
		page.has_css?($cif_sales_invoice_pricebook_search_popup_viewAllLink)
		find($cif_sales_invoice_pricebook_search_popup_default_close_button).hover
		sleep 1 # hover will enable the close image 
		find($cif_sales_invoice_pricebook_search_popup_default_close_button).click
		if(page.has_css?($cif_sales_invoice_pricebook_search_popup_default_close_button,:wait => 1))
			raise "Pop-Up not closed, trying again..."
		end
	end
  end
  
##
# Method Summary: Method to click in a column for specified row in Price book search grid.
#
# @param [Integer] row_number     Row number on the grid to be clicked
# @param [Integer] col_number     Column number on the grid to be clicked
#
  def CIF_SINV.click_column_pricebook_search_products_grid_data_row row_number, col_number
    grid_row_pattern = $cif_pricebook_grid_row_value.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
  end
  
##
# Method Summary: Method to get the value from a column for specified row in price book search grid.
#
# @param [Integer] row_number     Value of the row number from which the value needs to be fetched
# @param [Integer] col_number     Value of the column number from which the value needs to be fetched
#
  def CIF_SINV.get_column_value_from_pricebook_search_products_grid_data_row row_number, col_number
	grid_row_pattern = $cif_pricebook_grid_row_value.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
  end

##
# Method Summary: Method to click in a column for specified row in price book recently added grid.
#
# @param [Integer] row_number     Row number on the grid to be clicked
# @param [Integer] col_number     Column number on the grid to be clicked
#
  def CIF_SINV.click_column_pricebook_recently_added_grid_data_row row_number, col_number
    grid_row_pattern = $cif_pricebook_recently_added_items_grid_row_value.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
  end
  
##
# Method Summary: Method to get the value from a column for specified row in price book recently added grid.
#
# @param [Integer] row_number     Value of the row number from which the value needs to be fetched
# @param [Integer] col_number     Value of the column number from which the value needs to be fetched
#
  def CIF_SINV.get_column_value_from_pricebook_recently_added_grid_data_row row_number, col_number
	grid_row_pattern = $cif_pricebook_recently_added_items_grid_row_value.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
  end   

##
# Method Summary: check Price Book Search Label
#
  def CIF_SINV.get_pricebook_search_popup_label
	  pricebook_search_popup_label = nil
	  SF.retry_script_block do
		pricebook_search_popup_label = find($cif_sales_invoice_pricebook_search_popup_label).text
	  end
	  return pricebook_search_popup_label
  end	  

##
# Method Summary: check Search box Label
#
  def CIF_SINV.get_search_box_label
	  search_box_label = nil
	  SF.retry_script_block do
		search_box_label = find($cif_sales_invoice_pricebook_search_popup_search_box_label).text
	  end
	  return search_box_label
  end

##
# Method Summary: Method to check select all filtered products in price book search window
#
  def CIF_SINV.check_pricebook_search_popup_select_all_checkbox
    find($cif_sales_invoice_pricebook_search_popup_selectall_checkbox).click
  end
  
##
# Method Summary: Method to check the value from a column for specified row in search products grid
#
# @param [Integer] row_number     Value of the row number from which the value needs to be fetched
# @param [Integer] col_number     Value of the column number from which the value needs to be fetched
#
  def CIF_SINV.check_column_value_from_search_grid_data_row row_number, col_number
	grid_row_pattern = $cif_pricebook_grid_row_checkbox.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
  end
  
  
##
# Method Summary: Method to check the value from a column for specified row in recently added grid
#
# @param [Integer] row_number     Value of the row number from which the value needs to be fetched
# @param [Integer] col_number     Value of the column number from which the value needs to be fetched
#
  def CIF_SINV.check_column_value_from_recently_added_grid_data_row row_number, col_number
	grid_row_pattern = $cif_pricebook_recently_added_items_grid_row_checkbox.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
  end

##
# Method Summary: Method to get inline text of search products grid.
#
  def CIF_SINV.get_inline_text_search_products_grid
	  inline_text_label = nil
	  SF.retry_script_block do
        inline_text_label = find($cif_sales_invoice_pricebook_search_popup_inlineText_label).text
	  end
	  return inline_text_label
  end  
	
##
# Method Summary : Set Price book search box value
#
# @@param [String] search_value Price book search box text : Search by product name or code
#
  def CIF_SINV.set_price_book_search_box_value search_value
	  page.has_css?($cif_sales_invoice_pricebook_search_popup_search_box)
	  CIF.set_value $cif_sales_invoice_pricebook_search_popup_search_box, search_value
  end	  

end
