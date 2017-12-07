#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
module CIF_PINV
  extend Capybara::DSL

############################
#CIF Payable Invoice locators
############################
CIF_PAYABLE_INVOICE_ITEM_PRICE = 5
CIF_PAYABLE_INVOICE_NET_VALUE = 7
CIF_PAYABLE_INVOICE_WITH_LOCAL_GLA_NET_VALUE = 8
# Payable Invoice read and write element locations on header section.
  $cif_payable_invoice_account = "input[name$='Account__c']"
  $cif_payable_invoice_account_view = "div[data-ffid$='Account__c'] div:nth-child(2) div"
  $cif_payable_invoice_invoice_date = "input[name$='InvoiceDate__c']"
  $cif_payable_invoice_due_date = "input[name$='DueDate__c']"
  $cif_payable_invoice_due_date_view = "div[data-ffid$='DueDate__c'] div:nth-child(2) div"
  $cif_payable_invoice_period = "input[name$='Period__c']"
  $cif_payable_invoice_invoice_curreny = "input[name$='InvoiceCurrency__c']"
  $cif_payable_invoice_vendor_invoice_number = "input[name$='AccountInvoiceNumber__c']"
  $cif_payable_invoice_vendor_invoice_number_view = "div[data-ffid$='AccountInvoiceNumber__c'] div:nth-child(2) div"
  $cif_payable_invoice_invoice_description = "div[data-ffid$='InvoiceDescription__c'] div[data-ffid$='content'] textarea"
  $cif_payable_invoice_invoice_description_view = "div[data-ffid$='InvoiceDescription__c'] div:nth-child(2) div"
  $cif_payable_invoice_net_total = "div[data-ffid$='NetTotal__c'] div:nth-child(2) div"
  $cif_payable_invoice_tax_total = "div[data-ffid$='TaxTotal__c'] div:nth-child(2) div"
  $cif_payable_invoice_invoice_total = "div[data-ffid$='InvoiceTotal__c'] div:nth-child(2) div"
  $cif_payable_invoice_transaction = "div[data-ffid$='Transaction__c'] div:nth-child(2) div"
  $cif_payable_invoice_invoice_status = "div[data-ffid$='InvoiceStatus__c'] div:nth-child(2) div"
  $cif_payable_invoice_hold_status = "div[data-ffid$='HoldStatus__c'] div:nth-child(2) div"
  $cif_payable_invoice_payment_status = "div[data-ffid$='PaymentStatus__c'] div:nth-child(2) div"
  $cif_payable_invoice_outstanding_value = "div[data-ffid$='OutstandingValue__c'] div:nth-child(2) div"
  $cif_payable_invoice_enable_reverse_charge = "div[data-ffid$='EnableReverseCharge__c'] input[role='checkbox']"
  $cif_payable_invoice_enable_reverse_charge_disabled = "div[data-ffid$='EnableReverseCharge__c'] input[disabled]"
  $cif_payable_invoice_enable_reverse_charge_checkbox_enabled = "div[class*='f-form-cb-checked'][data-ffid$='EnableReverseCharge__c']"
  
# Payable Invoice read and write element locations in payable invoice expense line items section.
  $cif_payable_invoice_expense_line_items_tab = "div[data-ffxtype$='grid-area'] div[data-ffxtype = 'tabbar'] div:nth-child(2) div a:nth-child(1) span span span:nth-child(2)"
  $cif_payable_invoice_expense_line_click_new_row = ".cf-grid-rowdeletecolumn-image.cf-grid-rowdeletecolumn-value"
  $cif_payable_invoice_expense_line_number = "input[name$='LineNumber__c']"
  $cif_payable_invoice_expense_line_line_number_column_number = 1
  $cif_payable_invoice_expense_line_general_ledger_account = "input[name$='GeneralLedgerAccount__c']"
  $cif_payable_invoice_expense_line_general_ledger_account_column_number = 2
  $cif_payable_invoice_expense_line_local_general_ledger_account = "input[name$='LocalGLA__c']"
  $cif_payable_invoice_expense_line_add_line_item = ".cf-grid-rowdeletecolumn-image.cf-grid-rowdeletecolumn-value"
  $cif_payable_invoice_expense_line_description = "div[data-ffid$='LineDescription__c'] textarea"
  $cif_payable_invoice_expense_line_description_column_number = 6
  $cif_payable_invoice_expense_line_dimension1 = "input[name$='Dimension1__c']"
  $cif_payable_invoice_expense_line_dimension1_column_number = 4
  $cif_payable_invoice_expense_line_dimension2 = "input[name$='Dimension2__c']"
  $cif_payable_invoice_expense_line_dimension2_column_number = 5
  $cif_payable_invoice_expense_line_net_value = "input[name$='NetValue__c']"
  $cif_payable_invoice_expense_line_net_value_column_number = 7
  $cif_payable_invoice_expense_line_destination_net_value_column_number = 8
  $cif_payable_invoice_expense_line_input_tax_code = "input[name$='InputVATCode__c']"
  $cif_payable_invoice_expense_line_input_tax_code_column_number = 9
  $cif_payable_invoice_expense_line_input_tax_rate = "input[name$='TaxRate1__c']"
  $cif_payable_invoice_expense_line_input_tax_rate_column_number = 10
  $cif_payable_invoice_expense_line_input_tax_value = "input[name$='TaxValue1__c']"
  $cif_payable_invoice_expense_line_input_tax_value_column_number = 11
  $cif_payable_invoice_expense_line_reverse_charge = "div[data-ffid$='IsReverseChargeTax__c'] input[role='checkbox']"
  $cif_payable_invoice_expense_line_output_tax_code = "input[name$='OutputVATCode__c']"
  $cif_payable_invoice_expense_line_output_tax_code_column_number = 13
  $cif_payable_invoice_expense_line_output_tax_rate = "input[name$='OutputTaxRate__c']"
  $cif_payable_invoice_expense_line_output_tax_rate_column_number = 14
  $cif_payable_invoice_expense_line_output_tax_value = "input[name$='OutputTaxValue__c']"
  $cif_payable_invoice_expense_line_output_tax_value_column_number = 15
  $cif_payable_invoice_expense_line_destination_company = "input[name$='DestinationCompany__c']"
  $cif_payable_invoice_expense_line_destination_company_column_number = 3
# Payable Invoice read and write element locations in payable invoice product line items section.
  $cif_payable_invoice_line_items_tab = "div[data-ffxtype$='grid-area'] div[data-ffxtype = 'tabbar'] div:nth-child(2) div a:nth-child(2) span span span:nth-child(2)"
  $cif_payable_invoice_line_item_click_new_row = ".cfv-grid-rowdeletecolumn-image.cfv-grid-rowdeletecolumn-value"
  $cif_payable_invoice_line_item_line_number_column_number = 1
  $cif_payable_invoice_line_item_product = "input[name$='Product__c']"
  $cif_payable_invoice_line_item_product_column_number = 2
  $cif_payable_invoice_line_item_quantity = "input[name$='Quantity__c']"
  $cif_payable_invoice_line_item_quantity_column_number = 4
  $cif_payable_invoice_line_item_unit_price = "input[name$='UnitPrice__c']"
  $cif_payable_invoice_line_item_unit_price_column_number = 5
  $cif_payable_invoice_line_item_line_description = "div[data-ffid$='LineDescription__c'] textarea"
  $cif_payable_invoice_line_item_line_description_column_number = 10
  $cif_payable_invoice_line_item_destination_quantity_column_number = 6
  $cif_payable_invoice_line_item_destination_unit_price_column_number = 7
  $cif_payable_invoice_line_item_dimension1 ="input[name$='Dimension1__c']"
  $cif_payable_invoice_line_item_dimension1_column_number = 8
  $cif_payable_invoice_line_item_dimension2 = "input[name$='Dimension2__c']"
  $cif_payable_invoice_line_item_dimension2_column_number = 9
  $cif_payable_invoice_line_item_net_value = "input[name$='NetValue__c']"
  $cif_payable_invoice_line_item_net_value_column_number = 11
  $cif_payable_invoice_line_item_destination_net_value_column_number = 12
  $cif_payable_invoice_line_item_input_tax_code = "input[name$='InputVATCode__c']"
  $cif_payable_invoice_line_item_input_tax_code_column_number = 13
  $cif_payable_invoice_line_item_input_tax_rate = "input[name$='TaxRate1__c']"
  $cif_payable_invoice_line_item_input_tax_rate_column_number = 14
  $cif_payable_invoice_line_item_input_tax_value = "input[name$='TaxValue1__c']"
  $cif_payable_invoice_line_item_input_tax_value_column_number = 15
  $cif_payable_invoice_line_item_reverse_charge = "div[data-ffid$='IsReverseChargeTax__c'] input[role='checkbox']"
  $cif_payable_invoice_line_item_output_tax_code = "input[name$='OutputVATCode__c']"
  $cif_payable_invoice_line_item_output_tax_code_column_number = 17
  $cif_payable_invoice_line_item_output_tax_rate = "input[name$='OutputTaxRate__c']"
  $cif_payable_invoice_line_item_output_tax_rate_column_number = 18
  $cif_payable_invoice_line_item_output_tax_value = "input[name$='OutputTaxValue__c']" 
  $cif_payable_invoice_line_item_output_tax_value_column_number = 19
  $cif_payable_invoice_line_item_destination_company = "input[name$='DestinationCompany__c']"
  $cif_payable_invoice_line_item_destination_company_column_number = 3
  $cif_payable_invoice_line_item_unit_price_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_PAYABLE_INVOICE_ITEM_PRICE})"
  $cif_payable_invoice_line_item_quantity_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{$cif_payable_invoice_line_item_quantity_column_number})"
  $cif_payable_invoice_expense_line_net_value_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_PAYABLE_INVOICE_NET_VALUE})"
  $cif_payable_invoice_expense_line_input_tax_code_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{$cif_payable_invoice_expense_line_input_tax_code_column_number})"
  $cif_payable_invoice_prod_line_input_tax_code_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{$cif_payable_invoice_line_item_input_tax_code_column_number})"
# CIF default pinv pages  
  $cif_page_pinv_new_edit = 'Custom Form - Payable Invoice - New/Edit [cfpurchaseinvoiceedit]'
  $cif_page_pinv_view = 'Custom Form - Payable Invoice - View [cfpurchaseinvoiceview]'
  
#############################################
# Helper methods for payable invoice header section.
#############################################

##
#
# Method Summary: Find the Account input field and set the value.
#
# @param [String] account     Text account name to pass in to the account field.
#
  def CIF_PINV.set_pinv_account account   
	CIF.set_value_tab_out $cif_payable_invoice_account, account
	page.has_css?($cif_save_button ,:visible => true)
  end

##
#
# Method Summary: Find the invoice currency input field and set the value.
#
# @param [String] invoice_currency     Text invoice currency name to pass in to the invoice currency field.
#
  def CIF_PINV.set_pinv_invoice_currency invoice_currency
    CIF.set_value_tab_out $cif_payable_invoice_invoice_curreny, invoice_currency
	page.has_css?($cif_save_button ,:visible => true)
  end  
  
##
#
# Method Summary: Find the Enable reverse charge on header and check if the checkbox is checked or not.
#
  def CIF_PINV.is_pinv_enable_reverse_charge_checkbox_checked?
  return page.has_css?($cif_payable_invoice_enable_reverse_charge_checkbox_enabled)
  end
##
#
# Method Summary: Find the Enable Reverse Charge field and set the value.
#
# @param [Boolean] check_enable_reverse_charge	Check the reverse charge checkbox or not
#
  def CIF_PINV.click_payable_invoice_enable_reverse_charge_checkbox check_enable_reverse_charge
	if(check_enable_reverse_charge == true)
		if(CIF_PINV.is_pinv_enable_reverse_charge_checkbox_checked? == true)
		gen_tab_out $cif_payable_invoice_enable_reverse_charge
		else
		find($cif_payable_invoice_enable_reverse_charge).click
		gen_tab_out $cif_payable_invoice_enable_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		end
	elsif (check_enable_reverse_charge == false)
		if(CIF_PINV.is_pinv_enable_reverse_charge_checkbox_checked? == true)
		find($cif_payable_invoice_enable_reverse_charge).click
		gen_tab_out $cif_payable_invoice_enable_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
		gen_tab_out $cif_payable_invoice_enable_reverse_charge
		end
		else
			raise "Given parameter value is not a boolean, it must be true/false"
	end
  end

##
#
# Method Summary: Find the period input field and set the value.
#
# @param [String] period     Text period name to pass in to the period field.
#
  def CIF_PINV.set_pinv_period period
    CIF.set_value_tab_out $cif_payable_invoice_period, period
  end
  
##
#
# Method Summary: Find the invoice description input field and set the value.
#
# @param [String] description     Text description to pass in to the description field.
#
  def CIF_PINV.set_pinv_invoice_description description
    CIF.set_value $cif_payable_invoice_invoice_description, description
  end

##
#
# Method Summary: Find the invoice date input field and set the date.
#
# @param [String] date     Date to pass in to the date field.
#
  def CIF_PINV.set_pinv_invoice_date date
    CIF.set_value_tab_out $cif_payable_invoice_invoice_date, date
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
##
#
# Method Summary: Find the invoice due date input field and set the date.
#
# @param [String] date     Date to pass in to the date field.
#
  def CIF_PINV.set_pinv_invoice_due_date date
    CIF.set_value_tab_out $cif_payable_invoice_due_date, date
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
##
#
# Method Summary: Find the vendor invoice number input field and set the value.
#
# @param [String] invnumber     invnumber to pass in to the vendor invoice number field.
#  

  def CIF_PINV.set_pinv_vendor_invoice_number invnumber
    CIF.set_value $cif_payable_invoice_vendor_invoice_number, invnumber
	gen_tab_out $cif_payable_invoice_vendor_invoice_number
	page.has_css?($cif_save_button , :visible => true)
  end

##
#
# Method Summary : Returns the Account Name value
#
  def CIF_PINV.get_payable_invoice_account_name
	 return find($cif_payable_invoice_account_view).text
  end

##
#
# Method Summary : Returns the Vendor Invoice Number
#
  def CIF_PINV.get_payable_invoice_vendor_inv_number
	 return find($cif_payable_invoice_vendor_invoice_number_view).text
  end
  
##
#
# Method Summary : Returns the invoice status value
#
  def CIF_PINV.get_payable_invoice_status
	 return find($cif_payable_invoice_invoice_status).text
  end

##
#
# Method Summary : Returns the invoice description value
#
  def CIF_PINV.get_payable_invoice_description
	 return find($cif_payable_invoice_invoice_description_view).text
  end

##
#
# Method Summary : Returns the invoice due date value
#
  def CIF_PINV.get_payable_invoice_due_date
	 return find($cif_payable_invoice_due_date_view).text
  end
  
##
#
# Method Summary : Returns the invoice Transaction
#
  def CIF_PINV.get_payable_invoice_transaction
	 return find($cif_payable_invoice_transaction).text
  end
  
##
#
# Method Summary : Returns the invoice Hold Status
#
  def CIF_PINV.get_payable_invoice_hold_status
	 return find($cif_payable_invoice_hold_status).text
  end
  
##
#
# Method Summary : Returns the invoice Payment Status
#
  def CIF_PINV.get_payable_invoice_payment_status
	 return find($cif_payable_invoice_payment_status).text
  end  

# Method Summary : Returns the invoice vendor_invoice_number
#
  def CIF_PINV.get_payable_invoice_vendor_invoice_number
	 return find($cif_payable_invoice_vendor_invoice_number).text
  end
##
#
# Method Summary : Returns the invoice Outstanding Value
#
  def CIF_PINV.get_payable_invoice_outstanding_value
	 return find($cif_payable_invoice_outstanding_value).text
  end  
  
#########################################################################################################################
# Helper methods for payable invoice expense line item section.
# For creating a payable invoice expense line item, all the fields should
# be given values in the same order they apear on the UI as all below
# methods use tab out which will automatically take user to next field apearing
# in the row. In Case if user's current company is not VAT/GST type or user's current company is VAT/GST but does't have 
# Enable Supply Rules checkbox checked then following fields will not be visible to user:
# "Reverse Charge Checkbox", "Output Tax Field", "Output Tax Rate", "Output Tax Value".
#########################################################################################################################
##
#
# Method Summary: Find the payable invoice expense line items tab and click on it.
#
  def CIF_PINV.click_payable_invoice_expense_line_items_tab
	# In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
	if page.has_no_css?($cif_payable_invoice_expense_line_items_tab ,:wait => DEFAULT_LESS_WAIT)
		CIF.click_toggle_button
	end
    find($cif_payable_invoice_expense_line_items_tab).click
  end

##
#
# Method Summary: Find the general ledger account input field and set the value.
#
# @param [String] gla_name     Text to pass in to the general ledger account field.
#
  def CIF_PINV.set_pinv_expense_line_gla gla_name
    CIF.set_value_tab_out $cif_payable_invoice_expense_line_general_ledger_account, gla_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Find the Destination Company input field and select the Company from the list.
#
# @param [String] destinationCompany     Text to pass in to the destination company.
#
  def CIF_PINV.set_pinv_expense_line_destination_company destinationCompany
    CIF.set_value_tab_out $cif_payable_invoice_expense_line_destination_company, destinationCompany
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
##
#
# Method Summary: Find the dimension value1 input field and select the dimension form the list.
#
# @param [String] dimensionValue1     Text to pass in to the dimension1 field.
#
  def CIF_PINV.set_pinv_expense_line_dimesion_1 dimension_value1
    CIF.set_value_tab_out $cif_payable_invoice_expense_line_dimension1, dimension_value1
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the dimension value2 input field and select the dimension form the list.
#
# @param [String] dimensionValue2     Text to pass in to the dimension1 field.
#
  def CIF_PINV.set_pinv_expense_line_dimesion_2 dimension_value2
    CIF.set_value_tab_out $cif_payable_invoice_expense_line_dimension2, dimension_value2
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the line description input field and set the value into it.
#
# @param [String] lineDescription     Text to pass in to the line description field.
#
  def CIF_PINV.set_pinv_expense_line_line_description line_description
	CIF.set_value_tab_out $cif_payable_invoice_expense_line_description, line_description
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the net value input field and set the value into it.
#
# @param [String] net_value     String pass in to the net value field.
# @param [Integer] line	Integer pass to line number
#
  def CIF_PINV.set_pinv_expense_line_net_value net_value, line=1
	record_to_click = $cif_payable_invoice_expense_line_net_value_cell.gsub($sf_param_substitute, line.to_s)
	CIF.enable_picklist_input_locator $cif_payable_invoice_expense_line_net_value, record_to_click
    CIF.set_value_tab_out $cif_payable_invoice_expense_line_net_value, net_value
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end  

##
#
# Method Summary: Find the input tax code input field and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the input tax code field.
#
  def CIF_PINV.set_pinv_expense_line_input_tax_code tax_code_name, line=1
	record_to_click = $cif_payable_invoice_expense_line_input_tax_code_cell.gsub($sf_param_substitute, line.to_s)
	CIF.enable_picklist_input_locator $cif_payable_invoice_expense_line_input_tax_code ,record_to_click
    CIF.set_value_tab_out $cif_payable_invoice_expense_line_input_tax_code, tax_code_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Find the input tax rate input field on expense line item and set the rate.
#
# @param [String] tax_rate     Text to pass in to the input tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_PINV.set_pinv_expense_line_input_tax_rate tax_rate, change_tax_rate
	if(change_tax_rate == false)
		gen_tab_out $cif_payable_invoice_expense_line_input_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_invoice_expense_line_input_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
			else
				puts 'change_tax_rate variable can have only boolean values'
			end
	end	
  end  
  
##
#
# Method Summary: Find the input tax value input field and set the value.
#
# @param [Integer] tax_value     Number to pass in to the input tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PINV.set_pinv_expense_line_input_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_invoice_expense_line_input_tax_value
		else if(change_tax_value == true)
			CIF.set_value_tab_out $cif_payable_invoice_expense_line_input_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values'
		end
	end	
  end

##
#
# Method Summary: Find the reverse charge on line available to user.
#
  def CIF_PINV.is_pinv_expense_line_reverse_charge_checkbox_visible?
	 page.has_css?($cif_payable_invoice_expense_line_reverse_charge)
  end 
  
##
#
# Method Summary: Find the reverse charge input checkbox field and set the value.
# 
# @param [Boolean] check_reverse_charge_checkbox whether to check the reverse charge checkbox or not
#
  def CIF_PINV.click_pinv_expense_line_reverse_charge_checkbox check_reverse_charge_checkbox
    if(check_reverse_charge_checkbox == true)
		find($cif_payable_invoice_expense_line_reverse_charge).click
		gen_tab_out $cif_payable_invoice_expense_line_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else if(check_reverse_charge_checkbox == false)
			gen_tab_out $cif_payable_invoice_expense_line_reverse_charge
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'check_reverse_charge_checkbox can only have boolean values i.e. true/false'
		end
	end
  end

##
#
# Method Summary: Find the reverse charge input checkbox field on pinv expese line item (currently highlighted) and check if the checkbox is checked.
#
# @param [Integer] row_number          row number where checkbox needs to be checked. [DEFAULT = 1]
#
  def CIF_PINV.is_pinv_expense_line_reverse_charge_checkbox_checked? row_number=1
	page.assert_selector("table:nth-of-type(#{row_number}) img[class $='f-grid-checkcolumn-checked']")
  end
##
#
# Method Summary: Find the reverse charge input checkbox field on pinv expense line item (currently highlighted) and check if the checkbox is unchecked.
#
  def CIF_PINV.is_pinv_expense_line_reverse_charge_checkbox_unchecked?
	 page.assert_no_selector("table[class$='f-grid-item-selected'] img[class $='f-grid-checkcolumn-checked']")
  end  

##
# Method Summary: Returns the true if GLAs are present in the GLA line item else return false if the GLA's not present
#
# @param [String] gla_list to pass the list of gla's
# @param [Integer] line to pass the line number. If not specified, it will take line = 1
#
  def CIF_PINV.is_gla_values_present gla_list  ,line=1	
	count_of_gla_present = CIF.get_matched_count_picklist_value $cif_payable_invoice_expense_line_general_ledger_account , $cif_payable_invoice_expense_line_general_ledger_account ,gla_list,line=1  
	if count_of_gla_present == gla_list.count
		return true
	else
		return false
	end	
  end

##
#
# Method Summary: Find the output tax code input field on pinv expense line item and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the output tax code field.
#
  def CIF_PINV.set_pinv_expense_line_output_tax_code tax_code_name
    CIF.set_value_tab_out $cif_payable_invoice_expense_line_output_tax_code, tax_code_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the output tax rate input field and set the rate.
#
# @param [String] tax_rate     Text to pass in to the output tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_PINV.set_pinv_expense_line_output_tax_rate tax_rate, change_tax_rate
    if(change_tax_rate == false)
		gen_tab_out $cif_payable_invoice_expense_line_output_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_invoice_expense_line_output_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_rate variable can have only boolean values'
		end
	end	
  end  

##
#
# Method Summary: Find the output tax value input field and set the value.
#
# @param [Integer] tax_value     Number to pass in to the output tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PINV.set_pinv_expense_line_output_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_invoice_expense_line_output_tax_value
		else if(change_tax_value == true)
			CIF.set_value_tab_out $cif_payable_invoice_expense_line_output_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values'
		end
	end	
  end
  
#########################################################################################################################
# Helper methods for payable invoice line item section.
# For creating a payable invoice line item, all the fields should
# be given values in the same order they apear on the UI as all below
# methods use tab out which will automatically take user to next field apearing
# in the row. In Case if user's current company is not VAT/GST type or user's current company is VAT/GST but does't have 
# Enable Supply Rules checkbox checked then following fields will not be visible to user:
# "Reverse Charge Checkbox", "Output Tax Field", "Output Tax Rate", "Output Tax Value".
#########################################################################################################################
##
#
# Method Summary: Find the payable invoice line items tab and click on it.
#
  def CIF_PINV.click_payable_invoice_line_items_tab
	# In case, line Item full view page is dispyaed, User need to click on toggle incon to display the line tabs
	if page.has_no_css?($cif_payable_invoice_line_items_tab ,:wait => DEFAULT_LESS_WAIT)
		CIF.click_toggle_button
	end
	find($cif_payable_invoice_line_items_tab).click
	gen_wait_less
  end

##
#
# Method Summary: Find the product input field on pinv line item and set the value.
#
# @param [String] product_name     Text to pass in to the product field.
# 
  def CIF_PINV.set_pinv_line_product product_name
    CIF.set_value_tab_out $cif_payable_invoice_line_item_product, product_name
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the Destination Company input field and select the Company from the list.
#
# @param [String] destinationCompany     Text to pass in to the destination company.
#
  def CIF_PINV.set_pinv_line_destination_company destinationCompany
    CIF.set_value_tab_out $cif_payable_invoice_line_item_destination_company, destinationCompany
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end  
  
##
#
# Method Summary: Find the Quantity input field on pinv line item and set the value.
#
# @param [Integer] quantity     Integer to pass in to the quantity field.
# @param [Integer] line         Line Number where quantity value needs to be set[DEFAULT = 1]
#
  def CIF_PINV.set_pinv_line_quantity quantity, line=1
    record_to_click = $cif_payable_invoice_line_item_quantity_cell.gsub($sf_param_substitute, line.to_s)
    CIF.enable_picklist_input_locator $cif_payable_invoice_line_item_quantity, record_to_click
    CIF.set_value_tab_out $cif_payable_invoice_line_item_quantity, quantity
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Find the Unit Price input field on pinv line item and set the value.
#
# @param [Integer] unit_price     Integer to pass in to the Unit Price field.
#
  def CIF_PINV.set_pinv_line_unit_price unit_price, line=1
	record_to_click = $cif_payable_invoice_line_item_unit_price_cell.gsub($sf_param_substitute, line.to_s)
	CIF.enable_picklist_input_locator $cif_payable_invoice_line_item_unit_price, record_to_click
    CIF.set_value_tab_out $cif_payable_invoice_line_item_unit_price, unit_price
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end  
  
##
#
# Method Summary: Find the dimension value1 input field on pinv line item and select the dimension form the list.
#
# @param [String] dimensionValue1     Text to pass in to the dimension1 field.
#
  def CIF_PINV.set_pinv_line_dimesion_1 dimension_value1
    CIF.set_value_tab_out $cif_payable_invoice_line_item_dimension1, dimension_value1
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the dimension value2 input field on pinv line item and select the dimension form the list.
#
# @param [String] dimensionValue2     Text to pass in to the dimension1 field.
#
  def CIF_PINV.set_pinv_line_dimesion_2 dimension_value2
    CIF.set_value_tab_out $cif_payable_invoice_line_item_dimension2, dimension_value2
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
##
#
# Method Summary: Find the line description input field on pinv line item and set the value into it.
#
# @param [String] lineDescription     Text to pass in to the line description field.
#
  def CIF_PINV.set_pinv_line_line_description line_description
    CIF.set_value_tab_out $cif_payable_invoice_line_item_line_description, line_description
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Find the input tax code input field on pinv line item and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the input tax code field.
#
  def CIF_PINV.set_pinv_line_input_tax_code tax_code_name , line=1
	record_to_click = $cif_payable_invoice_prod_line_input_tax_code_cell.gsub($sf_param_substitute, line.to_s)
	CIF.enable_picklist_input_locator $cif_payable_invoice_line_item_input_tax_code, record_to_click
    CIF.set_value_tab_out $cif_payable_invoice_line_item_input_tax_code, tax_code_name
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the input tax rate input field on pinv line item and set the rate.
#
# @param [String] tax_rate     Text to pass in to the input tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_PINV.set_pinv_line_input_tax_rate tax_rate, change_tax_rate
	if(change_tax_rate == false)
		gen_tab_out $cif_payable_invoice_line_item_input_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_invoice_line_item_input_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_rate variable can have only boolean values'
		end	
	end	
  end  

##
#
# Method Summary: Find the input tax value input field on pinv line item and set the value.
#
# @param [Integer] tax_value     Number to pass in to the input tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PINV.set_pinv_line_input_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_invoice_line_item_input_tax_value
		else if(change_tax_value == true)
			CIF.set_value_tab_out $cif_payable_invoice_line_item_input_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values'
		end
	end	
  end
  
##
#
# Method Summary: Find the reverse charge input checkbox field on pinv line item and set the value.
#
# @param [Boolean] check_reverse_charge_checkbox whether to check the reverse charge checkbox or not
#
  def CIF_PINV.click_pinv_line_reverse_charge_checkbox check_reverse_charge_checkbox
	if(check_reverse_charge_checkbox == true)
		find($cif_payable_invoice_line_item_reverse_charge).click
		gen_tab_out $cif_payable_invoice_line_item_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else if(check_reverse_charge_checkbox == false)
			gen_tab_out $cif_payable_invoice_line_item_reverse_charge
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'check_reverse_charge_checkbox can only have boolean values i.e. true/false'
		end
	end	
  end
  
##
#
# Method Summary: Find the reverse charge input checkbox field on pinv line item (currently highlighted) and check if the checkbox is checked.
#
# @param [Integer] row_number          row number where checkbox needs to be checked. [DEFAULT = 1]
#
  def CIF_PINV.is_pinv_line_reverse_charge_checkbox_checked? row_number=1
	page.assert_selector("table:nth-of-type(#{row_number}) img[class $='f-grid-checkcolumn-checked']")
  end
##
#
# Method Summary: Find the reverse charge input checkbox field on pinv line item (currently highlighted) and check if the checkbox is unchecked.
#
  def CIF_PINV.is_pinv_line_reverse_charge_checkbox_unchecked?
	 page.assert_no_selector("table[class$='f-grid-item-selected'] img[class $='f-grid-checkcolumn-checked']")
  end  
  
##
#
# Method Summary: Find the output tax code input field on pinv line item and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the output tax code field.
#
  def CIF_PINV.set_pinv_line_output_tax_code tax_code_name
    CIF.set_value_tab_out $cif_payable_invoice_line_item_output_tax_code, tax_code_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the output tax rate input field on pinv line item and set the rate.
#
# @param [String] tax_rate     Text to pass in to the output tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_PINV.set_pinv_line_output_tax_rate tax_rate, change_tax_rate
    if(change_tax_rate == false)
		gen_tab_out $cif_payable_invoice_line_item_output_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_invoice_line_item_output_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_rate variable can have only boolean values i.e. true/false'
		end
	end	
  end  

##
#
# Method Summary: Find the output tax value input field on pinv line item and set the value.
#
# @param [Integer] tax_value     Number to pass in to the output tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PINV.set_pinv_line_output_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_invoice_line_item_output_tax_value
		else if(change_tax_value == true)	
			CIF.set_value_tab_out $cif_payable_invoice_line_item_output_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values i.e. true/false'
		end	
	end	
  end  

##
#
# Method Summary: Method to click in a column for specified row.
#
  def CIF_PINV.click_column_grid_data_row row_number, col_number
    find("div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type(#{row_number}) tr td:nth-of-type(#{col_number})").click
  end
  
##
#
# Method Summary: Method to get the value from a column for specified row.
#
  def CIF_PINV.get_column_value_from_grid_data_row row_number, col_number
	return find("div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type(#{row_number}) tr td:nth-of-type(#{col_number}) div").text
  end  

##
#
# Method Summary: Method to click in a column for specified row in CIF amend page.
#
  def CIF_PINV.click_column_grid_data_row_on_amend_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
	page.has_css?($cif_save_button,:visible=>true)
  end

##
#
# Method Summary: Method to get the value from a column for specified row in CIF view mode
#
  def CIF_PINV.get_column_value_from_grid_data_row_on_view_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
  end    
  
##############
# Buttons
##############

##
#
# Method Summary: Click the save button.
#
#
  def CIF_PINV.click_pinv_save_button
    CIF.click_save_button
    gen_wait_less
	CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
  end

##
#
# Method Summary: Click the save and new pinv button.
#
#
  def CIF_PINV.click_pinv_save_new_button
    CIF.click_save_new_button
  end

##
#
# Method Summary: Click the save and post pinv button.
#
#
  def CIF_PINV.click_pinv_save_post_button
    CIF.click_save_post_button
  end

##
#
# Method Summary: Click the cancel pinv button.
#
#
  def CIF_PINV.click_pinv_cancel_button
    CIF.click_cancel_button
  end

##
#
# Method Summary: Method to compare the values of journal line item.
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
  def CIF_PINV.compare_pinv_header_details(date, period, currency, net_total, tax_total, invoice_total, status)
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
      page.assert_selector('div[data-ffid$="NetTotal__c"] div div', :text => net_total, :visible => true)
    end
    if tax_total != nil
      page.assert_selector('div[data-ffid$="TaxTotal__c"] div div', :text => tax_total, :visible => true)
    end
    if invoice_total != nil
      page.assert_selector('div[data-ffid$="InvoiceTotal__c"] div div', :text => invoice_total, :visible => true)
    end
    if status != nil
	  page.assert_selector('div[data-ffid$="InvoiceStatus__c"] div div', :text => status, :visible => true)
    end
  end
##
#
# Method Summary : Click on new row
#
  def CIF_PINV.click_new_row
	SF.retry_script_block do
		CIF.click_new_row		
	end
  end
##
#
# Method Summary : Delete row by row number
#
# @param [Integer]  row_number            Row number to delete.
#
  def CIF_PINV.delete_row row_number
	SF.retry_script_block do
		CIF.delete_row row_number
	end
  end
end
