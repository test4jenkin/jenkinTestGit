#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
module CIF_PCN
  extend Capybara::DSL

PAYABLE_CREDIT_NOTE_COLUMN_UNIT_PRICE = 5
PAYABLE_CREDIT_NOTE_COLUMN_NET_VALUE = 7
PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_DIMENSION_1 = 8
PAYABLE_CREDIT_NOTE_PRODUCT_LINE_COLUMN_LINE_DESCRIPTION = 10
############################
#CIF Payable Credit Note locators
############################
  
  $cif_payable_credit_note_account ="input[name$='Account__c']"
  $cif_payable_credit_note_account_view ="div[data-ffid$='Account__c'] div:nth-child(2) div"
  $cif_payable_credit_note_status =  "div[data-ffid$='CreditNoteStatus__c'] div:nth-child(2) div"
  $cif_payable_credit_note_description = "div[data-ffid$='CreditNoteDescription__c'] div[data-ffid$='content'] textarea"
  $cif_payable_credit_note_description_view =  "div[data-ffid$='CreditNoteDescription__c'] div:nth-child(2) div"
  $cif_payable_credit_note_due_date =  "input[name$='DueDate__c']"
  $cif_payable_credit_note_due_date_view =  "div[data-ffid$='DueDate__c'] div:nth-child(2) div"
  $cif_payable_credit_note_enable_reverse_charge = "div[data-ffid$='EnableReverseCharge__c'] input[role='checkbox']"
  $cif_payable_credit_note_currency = "input[name$='CreditNoteCurrency__c']"
  $cif_payable_credit_note_vendor_credit_note_number = "input[name$='AccountCreditNoteNumber__c']"
  $cif_payable_credit_note_vendor_credit_note_number_view = "div[data-ffid$='AccountCreditNoteNumber__c'] div:nth-child(2) div"
  $cif_payable_credit_note_reason_view = "div[data-ffid$='CreditNoteReason__c'] div:nth-child(2) div"
  $cif_payable_credit_note_transaction_view = "div[data-ffid$='Transaction__c'] div:nth-child(2) div"
  $cif_payable_credit_note_payment_status_view = "div[data-ffid$='PaymentStatus__c'] div:nth-child(2) div"
  $cif_payable_credit_note_outstanding_value_view = "div[data-ffid$='OutstandingValue__c'] div:nth-child(2) div"
  $cif_payable_credit_note_enable_reverse_charge_checkbox_enabled = "div[class*='f-form-cb-checked'][data-ffid$='EnableReverseCharge__c']"
  $cif_payable_credit_note_enable_reverse_charge_disabled = "div[data-ffid$='EnableReverseCharge__c'] input[disabled]"
  
  # Payable Credit Note read and write element locations in payable credit note expense line items section.
  $cif_payable_credit_note_expense_line_items_tab = "div[data-ffxtype$='grid-area'] div[data-ffxtype = 'tabbar'] div:nth-child(2) div a:nth-child(1) span span span:nth-child(2)"
  $cif_payable_credit_note_expense_line_number = "input[name$='LineNumber__c']"
  $cif_payable_credit_note_expense_line_line_number_column_number = 1
  $cif_payable_credit_note_expense_line_general_ledger_account ="input[name$='GeneralLedgerAccount__c']"
  $cif_payable_credit_note_expense_line_general_ledger_account_column_number = 2
  $cif_payable_credit_note_expense_line_local_general_ledger_account = "input[name$='LocalGLA__c']"
  $cif_payable_credit_note_expense_line_local_general_ledger_account_column_number = 3
  $cif_payable_credit_note_expense_line_description = "div[data-ffid$='LineDescription__c'] textarea"
  $cif_payable_credit_note_expense_line_description_column_number = 6
  $cif_payable_credit_note_expense_line_dimension1 = "input[name$='Dimension1__c']"
  $cif_payable_credit_note_expense_line_dimension1_column_number = 4
  $cif_payable_credit_note_expense_line_dimension2 = "input[name$='Dimension2__c']"
  $cif_payable_credit_note_expense_line_dimension2_column_number = 5
  $cif_payable_credit_note_expense_line_net_value = "input[name='#{ORG_PREFIX}NetValue__c']"
  $cif_payable_credit_note_expense_line_net_value_column_number = 7
  $cif_payable_credit_note_expense_line_net_value_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+") div" 
  $cif_payable_credit_note_expense_line_destination_net_value_column_number = 8
  $cif_payable_credit_note_expense_line_destination_company = "input[name$='DestinationCompany__c']"
  $cif_payable_credit_note_expense_line_destination_company_column_number = 3
  $cif_payable_credit_note_expense_line_input_tax_code = "input[name$='InputVATCode__c']"
  $cif_payable_credit_note_expense_line_input_tax_code_column_number = 9
  $cif_payable_credit_note_expense_line_input_tax_rate = "input[name$='TaxRate1__c']"
  $cif_payable_credit_note_expense_line_input_tax_rate_column_number = 10
  $cif_payable_credit_note_expense_line_input_tax_value = "input[name$='TaxValue1__c']"
  $cif_payable_credit_note_expense_line_input_tax_value_column_number = 11
  $cif_payable_credit_note_expense_line_reverse_charge = "div[data-ffid$='IsReverseChargeTax__c'] input[role='checkbox']"
  $cif_payable_credit_note_expense_line_output_tax_code = "input[name$='OutputVATCode__c']"
  $cif_payable_credit_note_expense_line_output_tax_code_column_number = 13
  $cif_payable_credit_note_expense_line_output_tax_rate = "input[name$='OutputTaxRate__c']"
  $cif_payable_credit_note_expense_line_output_tax_rate_column_number = 14
  $cif_payable_credit_note_expense_line_output_tax_value = "input[name$='OutputTaxValue__c']"
  $cif_payable_credit_note_expense_line_output_tax_value_column_number = 15  
  
  #Payable Invoice read and write element locations in payable credit note product line items section.
  $cif_payable_credit_note_line_items_tab = "div[data-ffxtype$='grid-area'] div[data-ffxtype ='tabbar'] div:nth-child(2) div a:nth-child(2) span span span:nth-child(2)"
  $cif_payable_credit_note_line_item_line_number_column_number = 1
  $cif_payable_credit_note_line_item_product = "input[name$='Product__c']"
  $cif_payable_credit_note_line_item_product_column_number = 2
  $cif_payable_credit_note_line_item_quantity = "input[name$='Quantity__c']"
  $cif_payable_credit_note_line_item_destination_company = "input[name$='DestinationCompany__c']"
  $cif_payable_credit_note_line_item_destination_company_column_number = 3
  $cif_payable_credit_note_line_item_quantity_column_number = 4
  $cif_payable_credit_note_line_item_unit_price = "input[name$='UnitPrice__c']"
  $cif_payable_credit_note_line_item_unit_price_column_number = 5
  $cif_payable_credit_note_line_item_destination_quantity_column_number = 6
  $cif_payable_credit_note_line_item_destination_unit_price_column_number = 7
  $cif_payable_credit_note_line_item_dimension_1 = "input[name$='Dimension1__c']"
  $cif_payable_credit_note_line_item_dimension1_column_number = 8
  $cif_payable_credit_note_line_item_dimension2 = "input[name$='Dimension2__c']"
  $cif_payable_credit_note_line_item_dimension2_column_number = 9
  $cif_payable_credit_note_line_item_line_description = "div[data-ffid$='LineDescription__c'] textarea"
  $cif_payable_credit_note_line_item_line_description_column_number = 10
  $cif_payable_credit_note_line_item_net_value = "input[name$='NetValue__c']"
  $cif_payable_credit_note_unit_price = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{PAYABLE_CREDIT_NOTE_COLUMN_UNIT_PRICE})" 
  $cif_payable_credit_note_line_item_input_tax_code = "input[name$='InputVATCode__c']"
  $cif_payable_credit_note_line_item_net_value_column_number = 11
  $cif_payable_credit_note_line_item_destination_net_value_column_number = 12
  $cif_payable_credit_note_line_item_input_tax_code_column_number = 13
  $cif_payable_credit_note_line_item_input_tax_rate = "input[name$='TaxRate1__c']"
  $cif_payable_credit_note_line_item_input_tax_rate_column_number = 14
  $cif_payable_credit_note_line_item_input_tax_value = "input[name$='TaxValue1__c']"
  $cif_payable_credit_note_line_item_input_tax_value_column_number = 15
  $cif_payable_credit_note_line_item_reverse_charge = "div[data-ffid$='IsReverseChargeTax__c'] input[role='checkbox']"
  $cif_payable_credit_note_line_item_output_tax_code = "input[name$='OutputVATCode__c']"
  $cif_payable_credit_note_line_item_output_tax_code_column_number = 17
  $cif_payable_credit_note_line_item_output_tax_rate = "input[name$='OutputTaxRate__c']"
  $cif_payable_credit_note_line_item_output_tax_rate_column_number = 18
  $cif_payable_credit_note_line_item_output_tax_value = "input[name$='OutputTaxValue__c']" 
  $cif_payable_credit_note_line_item_output_tax_value_column_number = 19
  $cif_payable_credit_note_expense_line_input_tax_code_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{$cif_payable_credit_note_expense_line_input_tax_code_column_number})"
  
  $cif_payable_credit_note_prod_line_input_tax_code_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{$cif_payable_credit_note_line_item_input_tax_code_column_number})"
  $cif_payable_credit_note_prod_line_quantity_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{$cif_payable_credit_note_line_item_quantity_column_number})"
 
  
 
#############################################
# Helper methods for payable credit note header section.
#############################################
##
#
# Method Summary: Find the Account input field and set the value.
#
# @param [String] account     Text account name to pass in to the account field.
#
  def CIF_PCN.set_pcn_account account   
	CIF.set_value $cif_payable_credit_note_account, account
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	gen_tab_out $cif_payable_credit_note_account
	page.has_css?($cif_save_button ,:visible => true)
  end

##
#
# Method Summary: Find the credit note currency input field and set the value.
#
# @param [String] credit_note_currency     Text credit note currency name to pass in to the credit note currency field.
#
  def CIF_PCN.set_pcn_credit_note_currency credit_note_currency
    CIF.set_value_tab_out $cif_payable_credit_note_currency, credit_note_currency
  end

##
#
# Method Summary: Find the Enable Reverse Charge field and set the value.
#
# @param [Boolean] check_enable_reverse_charge	Check the reverse charge checkbox or not
#
  def CIF_PCN.click_payable_credit_note_enable_reverse_charge_checkbox check_enable_reverse_charge
	if(check_enable_reverse_charge == true)
		if(CIF_PCN.is_pcn_enable_reverse_charge_checkbox_checked? == true)
		gen_tab_out $cif_payable_credit_note_enable_reverse_charge
		else
		find($cif_payable_credit_note_enable_reverse_charge).click
		gen_tab_out $cif_payable_credit_note_enable_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		end
	elsif (check_enable_reverse_charge == false)
		if(CIF_PCN.is_pcn_enable_reverse_charge_checkbox_checked? == true)
		find($cif_payable_credit_note_enable_reverse_charge).click
		gen_tab_out $cif_payable_credit_note_enable_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
		gen_tab_out $cif_payable_credit_note_enable_reverse_charge
		end
		else
			raise "Given parameter value is not a boolean, it must be true/false"
	end
  end

##
#
# Method Summary: Find the Enable reverse charge on header and check if the checkbox is checked or not.
#
  def CIF_PCN.is_pcn_enable_reverse_charge_checkbox_checked?
  return page.has_css?($cif_payable_credit_note_enable_reverse_charge_checkbox_enabled)
	end

##
#
# Method Summary: Find the vendor credit note number input field and set the value.
#
# @param [String] pcn_number     pcn_number to pass in to the vendor credit note number field.
#  
  def CIF_PCN.set_pcn_vendor_credit_note_number pcn_number
    CIF.set_value $cif_payable_credit_note_vendor_credit_note_number, pcn_number
	gen_tab_out $cif_payable_credit_note_vendor_credit_note_number
	page.has_css?($cif_save_button , :visible => true)
  end

##
#
# Method Summary: Find the credit note description input field and set the value.
#
# @param [String] pcn_description     description to pass in the payable credit note description field.
#  
  def CIF_PCN.set_pcn_description pcn_description
    CIF.set_value_tab_out $cif_payable_credit_note_description, pcn_description
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the credit note due date input field and set the value.
#
# @param [String] pcn_due_date     string value to pass in the payable credit note due date field.
#  
  def CIF_PCN.set_pcn_due_date pcn_due_date
    CIF.set_value_tab_out $cif_payable_credit_note_due_date, pcn_due_date
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary : Returns the Payable Credit Note status value
#
  def CIF_PCN.get_payable_credit_note_status
	return find($cif_payable_credit_note_status).text
  end 
##
#
# Method Summary : Returns the Payable Credit Note description value
#
  def CIF_PCN.get_payable_credit_note_description
	return find($cif_payable_credit_note_description_view).text
  end
##
#
# Method Summary : Returns the Payable Credit Note due date value
#
  def CIF_PCN.get_payable_credit_note_due_date
	return find($cif_payable_credit_note_due_date_view).text
  end
##
#
# Method Summary : Returns the Payable Credit Note Account Value
#
  def CIF_PCN.get_payable_credit_note_account
	return find($cif_payable_credit_note_account_view).text
  end
##
#
# Method Summary : Returns the Vendor Credit Note Number
#
  def CIF_PCN.get_vendor_credit_note_number
	return find($cif_payable_credit_note_vendor_credit_note_number_view).text
  end
##
#
# Method Summary : Returns the Payable Credit Note Reason
#
  def CIF_PCN.get_payable_credit_note_reason
	return find($cif_payable_credit_note_reason_view).text
  end
##
#
# Method Summary : Returns the Payable Credit Note Transaction
#
  def CIF_PCN.get_payable_credit_note_transaction
	return find($cif_payable_credit_note_transaction_view).text
  end
##
#
# Method Summary : Returns the Payable Credit Note payment status
#
  def CIF_PCN.get_payable_credit_note_payment_status
	return find($cif_payable_credit_note_payment_status_view).text
  end
##
#
# Method Summary : Returns the Payable Credit Note Outstanding Value
#
  def CIF_PCN.get_payable_credit_note_outstanding_value
	return find($cif_payable_credit_note_outstanding_value_view).text
  end
#############################################
# Helper methods for payable credit note line section.
#############################################
##
#
# Method Summary: Find the payable credit note line items tab and click on it.
#
	def CIF_PCN.click_payable_credit_note_line_items_tab
		if page.has_no_css?($cif_payable_credit_note_line_items_tab ,:wait => DEFAULT_LESS_WAIT)
			CIF.click_toggle_button
			page.has_css?($cif_payable_credit_note_line_items_tab)
		end
		find($cif_payable_credit_note_line_items_tab).click
		#gen_wait_less
	end 

##
#
# Method Summary: Find the payable credit note expense line items tab and click on it.
#
  def CIF_PCN.click_payable_credit_note_expense_line_items_tab
    find($cif_payable_credit_note_expense_line_items_tab).click
  end

##
# Method Summary: Returns the true if GLAs are present in the GLA line item else return false if the GLA's not present
#
# @param [String] gla_list to pass the list of gla's
# @param [Integer] line to pass the line number. If not specified, it will take line = 1
#
  def CIF_PCN.is_gla_values_present gla_list  ,line=1	
	count_of_gla_present = CIF.get_matched_count_picklist_value $cif_payable_credit_note_expense_line_general_ledger_account, $cif_payable_credit_note_expense_line_general_ledger_account ,gla_list,line=1  
	if count_of_gla_present == gla_list.count
		return true
	else
		return false
	end	
  end
##
# Method Summary: Returns the true if Local GLAs are present in the Local GLA line item else return false if the Local GLA's not present
#
# @param [String] gla_list to pass the list of local gla's
# @param [Integer] line to pass the line number. If not specified, it will take line = 1
#  
  def CIF_PCN.is_local_gla_values_present gla_list  ,line=1	
	count_of_gla_present = CIF.get_matched_count_picklist_value $cif_payable_credit_note_expense_line_local_general_ledger_account, $cif_payable_credit_note_expense_line_local_general_ledger_account ,gla_list,line  
	if count_of_gla_present == gla_list.count
		return true
	else
		return false
	end	
  end  
##
#
# Method Summary: Find the general ledger account input field and set the value.
#
# @param [String] gla_name     Text to pass in to the general ledger account field.
#
  def CIF_PCN.set_pcn_expense_line_gla gla_name
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_general_ledger_account, gla_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end 

##
#
# Method Summary: Find the local general ledger account input field and set the value.
#
# @param [String] gla_name     Text to pass in to the local general ledger account field.
#
  def CIF_PCN.set_pcn_expense_line_local_gla local_gla_name
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_local_general_ledger_account, local_gla_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end 

##
#
# Method Summary: Find the Destination Company input field and select the Company from the list.
#
# @param [String] destinationCompany     Text to pass in to the destination company.
#
  def CIF_PCN.set_pcn_expense_line_destination_company destinationCompany
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_destination_company, destinationCompany
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
##
#
# Method Summary: Find the dimension value1 input field and select the dimension form the list.
#
# @param [String] dimensionValue1     Text to pass in to the dimension1 field.
#
  def CIF_PCN.set_pcn_expense_line_dimesion_1 dimension_value1
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_dimension1, dimension_value1
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the dimension value2 input field and select the dimension form the list.
#
# @param [String] dimensionValue2     Text to pass in to the dimension1 field.
#
  def CIF_PCN.set_pcn_expense_line_dimesion_2 dimension_value2
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_dimension2, dimension_value2
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the line description input field and set the value into it.
#
# @param [String] lineDescription     Text to pass in to the line description field.
#
  def CIF_PCN.set_pcn_expense_line_line_description line_description
	CIF.set_value_tab_out $cif_payable_credit_note_expense_line_description, line_description
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
  def CIF_PCN.set_pcn_expense_line_net_value net_value, line=1
	pcn_line_col_num = (PAYABLE_CREDIT_NOTE_COLUMN_NET_VALUE)
	object_visible = gen_is_object_visible $cif_payable_credit_note_expense_line_net_value
	if $cif_line_local_gla_enabled
		pcn_line_col_num = (PAYABLE_CREDIT_NOTE_COLUMN_NET_VALUE)+1
	end
	record_to_click = gen_sub_last_occurence $cif_payable_credit_note_expense_line_net_value_cell , $sf_param_substitute , pcn_line_col_num
	record_to_click = record_to_click.sub($sf_param_substitute, line.to_s)
	if (!object_visible)
		find(record_to_click).click
	end
	
	CIF.enable_picklist_input_locator $cif_payable_credit_note_expense_line_net_value, record_to_click
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_net_value, net_value
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Find the input tax code input field on expense line and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the input tax code field.
#
  def CIF_PCN.set_pcn_expense_line_input_tax_code tax_code_name, line=1
	record_to_click = $cif_payable_credit_note_expense_line_input_tax_code_cell.gsub($sf_param_substitute, line.to_s)
	CIF.enable_picklist_input_locator $cif_payable_credit_note_expense_line_input_tax_code ,record_to_click
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_input_tax_code, tax_code_name
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
  def CIF_PCN.set_pcn_expense_line_input_tax_rate tax_rate, change_tax_rate
	if(change_tax_rate == false)
		gen_tab_out $cif_payable_credit_note_expense_line_input_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_credit_note_expense_line_input_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
			else
				puts 'change_tax_rate variable can have only boolean values'
			end
	end	
  end  
  
##
#
# Method Summary: Find the input tax value input field on expense line and set the value.
#
# @param [Integer] tax_value     Number to pass in to the input tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PCN.set_pcn_expense_line_input_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_credit_note_expense_line_input_tax_value
		else if(change_tax_value == true)
			CIF.set_value_tab_out $cif_payable_credit_note_expense_line_input_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values'
		end
	end	
  end
  
##
#
# Method Summary: Find the reverse charge on line not available to user.
#
  def CIF_PCN.is_pcn_expense_line_reverse_charge_checkbox_visible?
	 page.has_css?("div[data-ffid$='IsReverseChargeTax__c']")
  end 

##
#
# Method Summary: Find the reverse charge input checkbox field on expense line and set the value.
# 
# @param [Boolean] check_reverse_charge_checkbox whether to check the reverse charge checkbox or not
#
  def CIF_PCN.click_pcn_expense_line_reverse_charge_checkbox check_reverse_charge_checkbox
    if(check_reverse_charge_checkbox == true)
		find($cif_payable_credit_note_expense_line_reverse_charge).click
		gen_tab_out $cif_payable_credit_note_expense_line_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else if(check_reverse_charge_checkbox == false)
			gen_tab_out $cif_payable_credit_note_expense_line_reverse_charge
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'check_reverse_charge_checkbox can only have boolean values i.e. true/false'
		end
	end
  end
  
##
#
# Method Summary: Find the reverse charge input checkbox field on pcrn expese line item (currently highlighted) and check if the checkbox is checked.
#
# @param [Integer] row_number          row number where checkbox needs to be checked. [DEFAULT = 1]
#
  def CIF_PCN.is_pcn_expense_line_reverse_charge_checkbox_checked? row_number=1
	page.assert_selector("table:nth-of-type(#{row_number}) img[class $='f-grid-checkcolumn-checked']")
  end
##
#
# Method Summary: Find the reverse charge input checkbox field on pcrn expense line item (currently highlighted) and check if the checkbox is unchecked.
#
  def CIF_PCN.is_pcn_expense_line_reverse_charge_checkbox_unchecked?
	 page.assert_no_selector("table[class$='f-grid-item-selected'] img[class $='f-grid-checkcolumn-checked']")
  end  

##
#
# Method Summary: Find the output tax code input field on pcn expense line item and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the output tax code field.
#
  def CIF_PCN.set_pcn_expense_line_output_tax_code tax_code_name
    CIF.set_value_tab_out $cif_payable_credit_note_expense_line_output_tax_code, tax_code_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the output tax rate input field on expense line and set the rate.
#
# @param [String] tax_rate     Text to pass in to the output tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_PCN.set_pcn_expense_line_output_tax_rate tax_rate, change_tax_rate
    if(change_tax_rate == false)
		gen_tab_out $cif_payable_credit_note_expense_line_output_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_credit_note_expense_line_output_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_rate variable can have only boolean values'
		end
	end	
  end  

##
#
# Method Summary: Find the output tax value input field on expense line and set the value.
#
# @param [Integer] tax_value     Number to pass in to the output tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PCN.set_pcn_expense_line_output_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_credit_note_expense_line_output_tax_value
		else if(change_tax_value == true)
			CIF.set_value_tab_out $cif_payable_credit_note_expense_line_output_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values'
		end
	end	
  end
  
##
#
# Method Summary: Find the product input field on pcn line item and set the value.
#
# @param [String] product_name     Text to pass in to the product field.
# 
  def CIF_PCN.set_pcn_line_product product_name
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_product, product_name
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the Destination Company input field and select the Company from the list.
#
# @param [String] destinationCompany     Text to pass in to the destination company.
#
  def CIF_PCN.set_pcn_line_destination_company destinationCompany
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_destination_company, destinationCompany
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end  
  
##
#
# Method Summary: Find the Quantity input field on pcnv line item and set the value.
#
# @param [Integer] quantity     Integer to pass in to the quantity field.
# @param [Integer] line         Line Number where quantity value needs to be set[DEFAULT = 1]
#
  def CIF_PCN.set_pcn_line_quantity quantity, line=1
    record_to_click = $cif_payable_credit_note_prod_line_quantity_cell.gsub($sf_param_substitute, line.to_s)
    CIF.enable_picklist_input_locator $cif_payable_credit_note_line_item_quantity, record_to_click
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_quantity, quantity
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Find the Unit Price input field on pcnv line item and set the value.
#
# @param [Integer] unit_price     Integer to pass in to the Unit Price field.
#
  def CIF_PCN.set_pcn_line_unit_price unit_price, line=1
	record_to_click = $cif_payable_credit_note_unit_price.gsub($sf_param_substitute, line.to_s)
	CIF.enable_picklist_input_locator $cif_payable_credit_note_line_item_unit_price, record_to_click
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_unit_price, unit_price
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end  
  
##
#
# Method Summary: Find the dimension value1 input field on pcnv line item and select the dimension form the list.
#
# @param [String] dimensionValue1     Text to pass in to the dimension1 field.
#

  def CIF_PCN.set_pcn_line_dimesion_1 dimension_value1
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_dimension1, dimension_value1
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the dimension value2 input field on pcnv line item and select the dimension form the list.
#
# @param [String] dimensionValue2     Text to pass in to the dimension1 field.
#
  def CIF_PCN.set_pcn_line_dimesion_2 dimension_value2
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_dimension2, dimension_value2
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
##
#
# Method Summary: Find the line description input field on pcnv line item and set the value into it.
#
# @param [String] lineDescription     Text to pass in to the line description field.
#
  def CIF_PCN.set_pcn_line_line_description line_description
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_line_description, line_description
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Find the input tax code input field on pcnv line item and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the input tax code field.
#
  def CIF_PCN.set_pcn_line_input_tax_code tax_code_name , line=1
	record_to_click = $cif_payable_credit_note_prod_line_input_tax_code_cell.gsub($sf_param_substitute, line.to_s)
	CIF.enable_picklist_input_locator $cif_payable_credit_note_line_item_input_tax_code, record_to_click
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_input_tax_code, tax_code_name
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the input tax rate input field on pcnv line item and set the rate.
#
# @param [String] tax_rate     Text to pass in to the input tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_PCN.set_pcn_line_input_tax_rate tax_rate, change_tax_rate
	if(change_tax_rate == false)
		gen_tab_out $cif_payable_credit_note_line_item_input_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_credit_note_line_item_input_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_rate variable can have only boolean values'
		end	
	end	
  end  

##
#
# Method Summary: Find the input tax value input field on pcnv line item and set the value.
#
# @param [Integer] tax_value     Number to pass in to the input tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PCN.set_pcn_line_input_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_credit_note_line_item_input_tax_value
		else if(change_tax_value == true)
			CIF.set_value_tab_out $cif_payable_credit_note_line_item_input_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values'
		end
	end	
  end
  
##
#
# Method Summary: Find the reverse charge input checkbox field on pcnv line item and set the value.
#
# @param [Boolean] check_reverse_charge_checkbox whether to check the reverse charge checkbox or not
#
  def CIF_PCN.click_pcn_line_reverse_charge_checkbox check_reverse_charge_checkbox
	if(check_reverse_charge_checkbox == true)
		find($cif_payable_credit_note_line_item_reverse_charge).click
		gen_tab_out $cif_payable_credit_note_line_item_reverse_charge
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else if(check_reverse_charge_checkbox == false)
			gen_tab_out $cif_payable_credit_note_line_item_reverse_charge
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'check_reverse_charge_checkbox can only have boolean values i.e. true/false'
		end
	end	
  end
  
##
#
# Method Summary: Find the reverse charge input checkbox field on pcnv line item (currently highlighted) and check if the checkbox is checked.
#
# @param [Integer] row_number          row number where checkbox needs to be checked. [DEFAULT = 1]
#
  def CIF_PCN.is_pcn_line_reverse_charge_checkbox_checked? row_number=1
	page.assert_selector("table:nth-of-type(#{row_number}) img[class $='f-grid-checkcolumn-checked']")
  end
##
#
# Method Summary: Find the reverse charge input checkbox field on pcnv line item (currently highlighted) and check if the checkbox is unchecked.
#
  def CIF_PCN.is_pcn_line_reverse_charge_checkbox_unchecked?
	 page.assert_no_selector("table[class$='f-grid-item-selected'] img[class $='f-grid-checkcolumn-checked']")
  end  
  
##
#
# Method Summary: Find the output tax code input field on pcnv line item and set the tax code.
#
# @param [String] tax_code_name     Text to pass in to the output tax code field.
#
  def CIF_PCN.set_pcn_line_output_tax_code tax_code_name
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_output_tax_code, tax_code_name
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Find the output tax rate input field on pcnv line item and set the rate.
#
# @param [String] tax_rate     Text to pass in to the output tax rate field.
# @param [Boolean] change_tax_rate     Boolean value to check whether to change the auto calculated tax rate or not.
#
  def CIF_PCN.set_pcn_line_output_tax_rate tax_rate, change_tax_rate
    if(change_tax_rate == false)
		gen_tab_out $cif_payable_credit_note_line_item_output_tax_rate
		else if(change_tax_rate == true)
			CIF.set_value_tab_out $cif_payable_credit_note_line_item_output_tax_rate, tax_rate
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_rate variable can have only boolean values i.e. true/false'
		end
	end	
  end  

##
#
# Method Summary: Find the output tax value input field on pcnv line item and set the value.
#
# @param [Integer] tax_value     Number to pass in to the output tax value field.
# @param [Boolean] change_tax_value     Boolean value to check whether to change the auto calculated tax value or not.
#
  def CIF_PCN.set_pcn_line_output_tax_value tax_value, change_tax_value
	if(change_tax_value == false)
		gen_tab_out $cif_payable_credit_note_line_item_output_tax_value
		else if(change_tax_value == true)	
			CIF.set_value_tab_out $cif_payable_credit_note_line_item_output_tax_value, tax_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
		else
			puts 'change_tax_value variable can have only boolean values i.e. true/false'
		end	
	end	
  end

##
# Method Summary: Find the Unit Price input field on PCN line item and set the value.
#
# @param [Integer] unit_price     Integer to pass in to the Unit Price field.
#
	def CIF_PCN.set_PCN_line_unit_price unit_price, line=1
		object_visible = gen_is_object_visible $cif_payable_credit_note_line_item_unit_price
		if (!object_visible)
			record_to_click = $cif_payable_credit_note_unit_price.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_payable_credit_note_line_item_unit_price, unit_price
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
	end
##
# Method Summary: Find the Net Value input field on PCN Expense line item and set the value.
#
# @param [Integer] net_value  Integer to pass in to the Net value field.
#
	def CIF_PCN.set_PCN_net_value net_value, line=1
		SF.retry_script_block do
			pcn_line_col_num = (PAYABLE_CREDIT_NOTE_COLUMN_NET_VALUE)
			object_visible = gen_is_object_visible $cif_payable_credit_note_expense_line_net_value
			if $cif_line_local_gla_enabled
				pcn_line_col_num = (PAYABLE_CREDIT_NOTE_COLUMN_NET_VALUE)+1
			end
			record_to_click = gen_sub_last_occurence $cif_payable_credit_note_expense_line_net_value_cell , $sf_param_substitute , pcn_line_col_num
			record_to_click = record_to_click.sub($sf_param_substitute, line.to_s)
			if (!object_visible)
				find(record_to_click).click
			end
			CIF.set_value_tab_out $cif_payable_credit_note_expense_line_net_value, net_value
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF.wait_for_actions_to_complete $cif_calculations_wait_message
			val = find(record_to_click).text
			SF.log_info "Retrieved Net value after set: #{val}"
			if !(val.start_with? net_value)
				raise "unable to set net value :#{net_value}"
			end
		end
	end

##
#
# Method Summary: Find the dimension value1 input field on pcn line item and select the dimension form the list.
#
# @param [String] dimensionValue1     Text to pass in to the dimension1 field.
#
  def CIF_PCN.set_pcn_line_dimesion_1 dimension_value1
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_dimension_1, dimension_value1
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the line description input field on pcn line item and set the value into it.
#
# @param [String] lineDescription     Text to pass in to the line description field.
#
  def CIF_PCN.set_pcn_line_description line_description
    CIF.set_value_tab_out $cif_payable_credit_note_line_item_line_description, line_description
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Method to click in a column for specified row on Amend page.
#
# @param [Integer] row_number     Row number on the grid to be clicked
# @param [Integer] col_number     Column number on the grid to be clicked
#
  def CIF_PCN.click_column_grid_data_row_on_amend_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
	page.has_css?($cif_save_button,:visible=>true)
  end
  
##
#
# Method Summary: Method to get the value from a column for specified row.
#
# @param [Integer] row_number     Value of the row number from which the value needs to be fetched
# @param [Integer] col_number     Value of the column number from which the value needs to be fetched
#
  def CIF_PCN.get_column_value_from_grid_data_row row_number, col_number
	grid_row_pattern = $cif_grid_row_value_on_input_page.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
  end  
  
##
#
# Method Summary: Method to get the value from a column for specified row in CIF view mode
#
# @param [Integer] row_number     Value of the row number from which the value needs to be fetched
# @param [Integer] col_number     Value of the column number from which the value needs to be fetched
#
  def CIF_PCN.get_column_value_from_grid_data_row_on_view_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
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
  def CIF_PCN.compare_pcn_header_details(date, period, currency, net_total, tax_total, credit_note_total, status)
    if date != nil
      page.assert_selector('div[data-ffid$="CreditNoteDate__c"] div div', :text =>date, :visible => true)
    end
    if period != nil
      page.assert_selector('div[data-ffid$="Period__c"] div div', :text => period, :visible => true)
    end
    if currency != nil
      page.assert_selector('div[data-ffid$="CreditNoteCurrency__c"] div div', :text => currency, :visible => true)
    end
    if net_total != nil
      page.assert_selector('div[data-ffid$="NetTotal__c"] div div', :text => net_total, :visible => true)
    end
    if tax_total != nil
      page.assert_selector('div[data-ffid$="TaxTotal__c"] div div', :text => tax_total, :visible => true)
    end
    if credit_note_total != nil
      page.assert_selector('div[data-ffid$="CreditNoteTotal__c"] div div', :text => credit_note_total, :visible => true)
    end
    if status != nil
      page.assert_selector('div[data-ffid$="CreditNoteStatus__c"] div div', :text => status, :visible => true)
    end
  end
  
########################################################
# Helper methods for buttons on payable credit note page
########################################################

##
#
# Method Summary: Method to click in a column for specified row.
#
  def CIF_PCN.click_column_grid_data_row row_number, col_number
    find("div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type(#{row_number}) tr td:nth-of-type(#{col_number})").click
  end
  	
##
# Method Summary: click on the post and match button
#	
#
	def CIF_PCN.click_post_match_button
		find($cif_post_and_match_button).click
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message		
	end
	
##
#
# Method Summary: Click the save and post pcnv button.
#
#
  def CIF_PCN.click_pcn_save_post_button
    CIF.click_save_post_button
  end

##
#
# Method Summary : Click on new row
#
  def CIF_PCN.click_new_row
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
  def CIF_PCN.delete_row row_number
	SF.retry_script_block do
		CIF.delete_row row_number
	end
  end

##
#
# Method Summary: Click the save button.
#
#
  def CIF_PCN.click_pcrn_save_button
    CIF.click_save_button
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
  end
  
##
#
# Method Summary: Click the save and new pcn button.
#
#
  def CIF_PCN.click_pcn_save_new_button
    CIF.click_save_new_button
    CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message    
  end  
end