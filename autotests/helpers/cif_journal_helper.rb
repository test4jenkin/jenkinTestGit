#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
module CIF_JNL
  extend Capybara::DSL
  
  CIF_JOURNAL_COLUMN_LINE_TYPE =2
  CIF_JOURNAL_COLUMN_GLA = 3
  CIF_JOURNAL_COLUMN_ACCOUNT = 4
  CIF_JOURNAL_COLUMN_BANKACCOUNT = 5
  CIF_JOURNAL_COLUMN_PRODUCT = 6
  CIF_JOURNAL_COLUMN_TAX_CODE = 7
  CIF_JOURNAL_COLUMN_TAXABLE_VALUE = 8
  CIF_JOURNAL_COLUMN_TAX_VALUE = 9
  CIF_JOURNAL_COLUMN_ACCOUNT_ANALYSIS = 11
  CIF_JOURNAL_COLUMN_PRODUCT_ANALYSIS = 12
  CIF_JOURNAL_COLUMN_DESTINATION_COMPANY = 13
  CIF_JOURNAL_COLUMN_DESTINATION_TYPE = 14
  CIF_JOURNAL_COLUMN_LINE_DESCRIPTION = 15
  CIF_JOURNAL_COLUMN_DIMENSION_1 = 16
  CIF_JOURNAL_COLUMN_DIMENSION_2 = 17
  CIF_JOURNAL_COLUMN_VALUE = 18
############################
#CIF Journal locators
############################

# Journal read and write element locations on header section.
  $cif_journal_date = "input[name$='JournalDate__c']"
  $cif_journal_period = "input[name$='Period__c']"
  $cif_journal_currency = "input[name$='JournalCurrency__c']"
  $cif_journal_reference = "input[name$='Reference__c']"
  $cif_journal_description = "div[data-ffid$='JournalDescription__c'] textarea"
  $cif_journal_status = "div[data-ffid$='JournalStatus__c'] div:nth-child(2) div"
  $cif_journal_reference_view = "div[data-ffid$='Reference__c'] div:nth-child(2) div"
  $cif_journal_description_view = "div[data-ffid$='JournalDescription__c'] div:nth-child(2) div"
  $cif_journal_field_error_messsage = "div[data-ffid$='JournalCurrency__c'] div[role='alert'] ul li"
  $cif_journal_debits = "div[data-ffid$='Debits__c'] div:nth-child(2) div"
  $cif_journal_credits = "div[data-ffid$='Credits__c'] div:nth-child(2) div"
  $cif_journal_total = "div[data-ffid$='Total__c'] div:nth-child(2) div"
  $cif_journal_home = "td[class='pbTitle'] h3"

# Journal read and write element locations on details section.
  $cif_journal_line_type = "input[name$='LineType__c']"
  $cif_journal_general_ledger_account = "input[name$='GeneralLedgerAccount__c']"
  $cif_journal_add_line_item = ".cf-grid-rowdeletecolumn-image.cf-grid-rowdeletecolumn-value"
  $cif_journal_account = "input[name='#{ORG_PREFIX}Account__c']"
  $cif_journal_tax_value = "input[name$='TaxValue1__c']"
  $cif_journal_line_description = "input[name$='LineDescription__c']"
  $cif_journal_dimension1 = "input[name$='Dimension1__c']"
  $cif_journal_dimension2 = "input[name$='Dimension2__c']"
  $cif_journal_dimension3 = "input[name$='Dimension3__c']"
  $cif_journal_dimension4 = "input[name$='Dimension4__c']"
  $cif_journal_value = "input[name='#{ORG_PREFIX}Value__c']"
  $cif_journal_tax_code = "input[name$='TaxCode__c']"
  $cif_journal_taxable_value = "input[name$='TaxableValue__c']"
  $cif_journal_account_analysis = "input[name$='AccountAnalysis__c']"
  $cif_journal_bank_account = "input[name$='BankAccount__c']"
  $cif_journal_tax_analysis = "div[data-ffid$='TaxAnalysis1__c'] div[data-ffid='lookup'] input[id]"
  $cif_journal_product_analysis = "input[name$='ProductAnalysis__c']"
  $cif_journal_product = "input[name$='Product__c']"
  $cif_destination_company = "input[name$='DestinationCompany__c']"
  $cif_destination_line_type = "input[name$='DestinationLineType__c']"
  $cif_journal_line_type_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_LINE_TYPE})"
  $cif_journal_gla_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_GLA})"
  $cif_journal_account_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
  $cif_journal_bankaccount_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
  $cif_journal_product_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
  $cif_journal_tax_code_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
  $cif_journal_value_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
  $cif_journal_account_analysis_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_ACCOUNT_ANALYSIS})"  
  $cif_journal_product_analysis_cell = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_PRODUCT_ANALYSIS})"  
  $cif_journal_tax_value_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_TAX_VALUE})"
  $cif_journal_taxable_value_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_TAXABLE_VALUE})"
  $cif_journal_destination_company_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
  $cif_journal_destination_line_type_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type("+$sf_param_substitute+")"
  $cif_journal_line_description_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_LINE_DESCRIPTION})"
  $cif_journal_dimension_1_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_DIMENSION_1})"
  $cif_journal_dimension_2_cell =  "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CIF_JOURNAL_COLUMN_DIMENSION_2})"
 
  #buttons
  $cif_journal_toggle_button = "a[data-ffxtype='fillbutton']"

#############################################
# Helper methods for Journal header section.
#############################################

##
#
# Method Summary: Find the reference input field and set the value.
#
# @param [String] reference     Text description to pass in to the reference field.
#
  def CIF_JNL.set_journal_reference reference
	page.has_css?($cif_journal_reference)
    CIF.set_value $cif_journal_reference, reference
  end


##
#
# Method Summary: Find the description input field and set the value.
#
# @param [String] description     Text description to pass in to the description field.
#
  def CIF_JNL.set_journal_description description
    CIF.set_value $cif_journal_description, description
  end

##
#
# Method Summary: Find the date input field and set the date.
#
# @param [String] date     Date to pass to pass in to the date field.
#
  def CIF_JNL.set_journal_date date
    CIF.set_value_tab_out $cif_journal_date, date
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Returns the Journal Document Status value
#
#  
  def CIF_JNL.get_journal_document_status
	return find($cif_journal_status).text
  end

##
#
# Method Summary: Returns the Journal Reference value
#
#  
  def CIF_JNL.get_journal_reference
    return find($cif_journal_reference_view).text
  end

##
#
# Method Summary: Returns the Journal Document Description value
#
#  
  def CIF_JNL.get_journal_document_description
    return find($cif_journal_description_view).text
  end

########################################################
# Helper methods for Journal line item details section.
########################################################
##
#
# Method Summary: Find the line type input field and set the type of line.
#
# @param [String] lineType     Text to pass in to the lineType field.
#
  def CIF_JNL.set_line_type line_type, line=1
	CIF.activate_line_field_item $cif_journal_line_type, $cif_journal_line_type_cell, line_type, line	
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the gla type input field and set the type of gla.
#
# @param [String] glaType     Text to pass in to the glaType field.
#
  def CIF_JNL.set_gla gla_type, line=1
    CIF.activate_line_field_item $cif_journal_general_ledger_account, $cif_journal_gla_cell, gla_type, line	
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the account_analysis type input field and set the type of account_analysis.
#
# @param [String] account_analysis     Text to pass in to the account_analysis field.
#
  def CIF_JNL.set_account_analysis_value account_analysis, line=1
    CIF.activate_line_field_item $cif_journal_account_analysis, $cif_journal_account_analysis_cell, account_analysis, line	
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the product_analysis type input field and set the type of product_analysis.
#
# @param [String] product_analysis     Text to pass in to the product_analysis field.
#
def CIF_JNL.set_product_analysis_value product_analysis, line=1
  CIF.activate_line_field_item $cif_journal_product_analysis, $cif_journal_product_analysis_cell, product_analysis, line	
  CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
end
  
##
#
# Method Summary: Find the product type input field and set the type of product.
#
# @param [String] product     Text to pass in to the product field.
#
  def CIF_JNL.set_product product, line=1
	jnl_line_col_num = (CIF_JOURNAL_COLUMN_PRODUCT) 
	# Update the cell value as per Local GLA setting.
	if $cif_line_local_gla_enabled
		jnl_line_col_num += 1 
	end
	jnl_line_column = gen_sub_last_occurence $cif_journal_product_cell , $sf_param_substitute , jnl_line_col_num
	CIF.activate_line_field_item $cif_journal_product, jnl_line_column, product, line    
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_totals_to_calculate
  end

##
#
# Method Summary: Find the product type input field and set the type of product.
#
# @param [String] product     Text to pass in to the product field.
#
  def CIF_JNL.set_line_field_destination_company destination_company, line=1
	jnl_line_col_num = (CIF_JOURNAL_COLUMN_DESTINATION_COMPANY) 
	# Update the cell value as per Local GLA setting.
	if $cif_line_local_gla_enabled
		jnl_line_col_num += 1 
	end
	jnl_line_column = gen_sub_last_occurence $cif_journal_destination_company_cell , $sf_param_substitute , jnl_line_col_num

	CIF.activate_line_field_item $cif_destination_company, jnl_line_column, destination_company, line    
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the destination type input field and set it.
#
# @param [String] destination_type     Text to pass in to the destination type field.
#
  def CIF_JNL.set_line_field_destination_type destination_type, line=1
  jnl_line_col_num = (CIF_JOURNAL_COLUMN_DESTINATION_TYPE) 
  # Update the cell value as per Local GLA setting.
  if $cif_line_local_gla_enabled
    jnl_line_col_num += 1 
  end
  jnl_line_column = gen_sub_last_occurence $cif_journal_destination_line_type_cell, $sf_param_substitute, jnl_line_col_num
	CIF.activate_line_field_item $cif_destination_line_type, jnl_line_column, destination_type, line    
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end
  
##
#
# Method Summary: Find the bank_account type input field and set the type of bank_account.
#
# @param [String] product     Text to pass in to the bank_account field.
#
  def CIF_JNL.set_bank_account bank_account, line=1
	jnl_line_col_num = (CIF_JOURNAL_COLUMN_BANKACCOUNT)
	# Update the cell value as per Local GLA setting.
	if $cif_line_local_gla_enabled
		jnl_line_col_num +=1 
	end
	jnl_line_column = gen_sub_last_occurence $cif_journal_bankaccount_cell , $sf_param_substitute , jnl_line_col_num
	CIF.activate_line_field_item $cif_journal_bank_account, jnl_line_column, bank_account, line    
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_totals_to_calculate
  end
  
##
#
# Method Summary: Find the account name input field and set the type of account.
#
# @param [String] accountName     Text to pass in to the accountName field.
#
  def CIF_JNL.set_account account_name, line=1
	jnl_line_col_num = (CIF_JOURNAL_COLUMN_ACCOUNT)
	# Update the cell value as per Local GLA setting.
	if $cif_line_local_gla_enabled
		jnl_line_col_num += 1 
	end
	jnl_line_column = gen_sub_last_occurence $cif_journal_account_cell , $sf_param_substitute , jnl_line_col_num
	CIF.activate_line_field_item $cif_journal_account, jnl_line_column, account_name, line    
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_totals_to_calculate
  end

##
#
# Method Summary: Find the tax code input field and set the value into it.
#
# @param [String] tax code     Text to pass in to the line Tax code field.
#
  def CIF_JNL.set_tax_code tax_code, line=1
	jnl_line_col_num = (CIF_JOURNAL_COLUMN_TAX_CODE) 
	# Update the cell value as per Local GLA setting.
	if $cif_line_local_gla_enabled
		jnl_line_col_num += 1 
	end	
	jnl_line_column = gen_sub_last_occurence $cif_journal_tax_code_cell , $sf_param_substitute , jnl_line_col_num
	CIF.activate_line_field_item $cif_journal_tax_code, jnl_line_column, tax_code, line 
	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
	CIF.wait_for_totals_to_calculate
  end

##
#
# Method Summary: Find the tax code input field and set the value into it.
#
# @param [String] tax code     Text to pass in to the line Tax code field.
#
  def CIF_JNL.set_taxable_value taxable_value, line=1
	CIF.activate_line_field_item $cif_journal_taxable_value, $cif_journal_taxable_value_cell, taxable_value, line    
  end

  
  
##  
#
# Method Summary: Find the tax value input field and set the value.
#
# @param [Integer] taxValue     Number to pass in to the taxValue field.
#
  def CIF_JNL.set_tax_value tax_value, line=1
    CIF.activate_line_field_item $cif_journal_tax_value, $cif_journal_tax_value_cell, tax_value, line    
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the description input field and set the value into it.
#
# @param [String] lineDescription     Text to pass in to the line description field.
#
  def CIF_JNL.set_line_description line_description, line=1
	record_to_click = $cif_journal_line_description_cell.gsub($sf_param_substitute, line.to_s)  
	CIF.enable_picklist_input_locator $cif_journal_line_description,record_to_click  
    CIF.set_value_tab_out $cif_journal_line_description, line_description
  end

##
#
# Method Summary: Find the dimension value1 input field and select the dimension form the list.
#
# @param [String] dimensionValue1     Text to pass in to the dimension1 field.
#
  def CIF_JNL.set_dimesion_1 dimension_value1, line=1
	record_to_click = $cif_journal_dimension_1_cell.gsub($sf_param_substitute, line.to_s)  
	CIF.enable_picklist_input_locator $cif_journal_dimension1,record_to_click  
    CIF.set_value_tab_out $cif_journal_dimension1, dimension_value1
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the dimension value2 input field and select the dimension form the list.
#
# @param [String] dimensionValue2     Text to pass in to the dimension1 field.
#
  def CIF_JNL.set_dimesion_2 dimension_value2, line=1
    record_to_click = $cif_journal_dimension_2_cell.gsub($sf_param_substitute, line.to_s)  
	CIF.enable_picklist_input_locator $cif_journal_dimension2,record_to_click  
    CIF.set_value_tab_out $cif_journal_dimension2, dimension_value2
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
  end

##
#
# Method Summary: Find the value input field and set the value into it.
#
# @param [String] value     Number pass in to the value field.
#
  def CIF_JNL.set_value amount_value,  value=1
	jnl_line_col_num = (CIF_JOURNAL_COLUMN_VALUE)
	# Update the cell value as per Local GLA setting.
	if $cif_line_local_gla_enabled
		jnl_line_col_num += 1 
	end
	jnl_line_column = gen_sub_last_occurence $cif_journal_value_cell , $sf_param_substitute , jnl_line_col_num
	CIF.activate_line_field_item $cif_journal_value, jnl_line_column, amount_value, value		
    CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
    CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end
  
##
#
# Method Summary: Method to get the value from a column for specified row in CIF view mode
#
  def CIF_JNL.get_column_value_from_grid_data_row_on_view_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
  end  
##
#
# Method Summary: Method to create a journal line item in one step.
#
# @param [String]  line_type            Text to pass in to the lineType field.
# @param [String]  gla_type             Text to pass in to the glaType field.
# @param [String]  account_name         Text to pass in to the accountName field.
# @param [Integer] tax_value            Text to pass in to the taxValue field.
# @param [String]  line_description     Text to pass in to the lineDescription field.
# @param [String]  dimension_value1     Text to pass in to the dimensionValue1 field.
# @param [String]  dimension_value2     Text to pass in to the dimensionValue2 field.
# @param [Integer] value               Text to pass in to the value field.
#
  def CIF_JNL.set_journa_line_item  line_type, gla_type, account_name, tax_value, line_description, dimension_value1, dimension_value2, value
    if lineType != nil
      CIF_JNL.set_line_type line_type
    end
    if glaType != nil
      CIF_JNL.set_gla gla_type
    end
    if accountName != nil
      CIF_JNL.set_account account_name
    end
    if taxValue  != nil
      CIF_JNL.set_tax_value tax_value
    end
    if lineDescription  != nil
      CIF_JNL.set_line_description line_description
    end
    if dimensionValue1  != nil
      CIF_JNL.set_dimesion_1 dimension_value1
    end
    if dimensionValue2  != nil
      CIF_JNL.set_dimesion_2 dimension_value2
    end
    if value  != nil
      CIF_JNL.set_value value
    end
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
  def CIF_JNL.compare_journal_header_details(date, period, currency, reference, description, type, status, debit_value, credit_value, total_value)
    if date != nil
      page.assert_selector('div[data-ffid$="JournalDate__c"] div[role="textbox"]', :text =>date, :visible => true)
    end
    if period != nil
      page.assert_selector('div[data-ffid$="Period__c"] div[role="textbox"]', :text => period, :visible => true)
    end
    if currency != nil
      page.assert_selector('div[data-ffid$="JournalCurrency__c"] div[role="textbox"]', :text => currency, :visible => true)
    end
    if reference != nil
      page.assert_selector('div[data-ffid$="Reference__c"] div[role="textbox"]', :text => reference, :visible => true)
    end
    if description != nil
      page.assert_selector('div[data-ffid$="JournalDescription__c"] div[role="textbox"]', :text => description, :visible => true)
    end
    if type != nil
      page.assert_selector('div[data-ffid$="Type__c"] div[role="textbox"]', :text => type, :visible => true)
    end
    if status != nil
      page.assert_selector('div[data-ffid$="JournalStatus__c"] div[role="textbox"]', :text => status, :visible => true)
    end
    if debit_value != nil
      page.assert_selector($cif_journal_debits, :text => debit_value, :visible => true)
    end
    if total_value != nil
      page.assert_selector($cif_journal_credits, :text => credit_value, :visible => true)
    end
    if status != nil
      page.assert_selector($cif_journal_total, :text => total_value, :visible => true)
    end
  end

##
#
# Method Summary: Method toreturn data for specified row.
#
  def CIF_JNL.get_grid_data_row row_number
    return find("div[data-ffxtype='tableview'] table:nth-of-type(#{row_number}) tbody tr").text
  end

##############
# Buttons
##############

##
#
# Method Summary: Click the save journal button.
#
#
  def CIF_JNL.click_journal_save_button
    CIF.click_save_button
    CIF.wait_for_actions_to_complete $cif_calculations_wait_message
  end

##
#
# Method Summary: Click the save and new journal button.
#
#
  def CIF_JNL.click_journal_save_new_button
    CIF.click_save_new_button
  end

##
#
# Method Summary: Click the save and post journal button.
#
#
  def CIF_JNL.click_journal_save_post_button
    CIF.click_save_post_button
  end

##
#
# Method Summary: Click the cancel journal button.
#
#
  def CIF_JNL.click_journal_cancel_button
    CIF.click_cancel_button
  end
##
#
# Method Summary: Toggle button to maximise and minimise the line items table.
#
#
  def CIF_JNL.click_toggle_button
    find($cif_journal_toggle_button).click
  end
##
# Method Summary: Returns the true if GLAs are present in the GLA line item else return false if the GLA's not present
#
# @param [String] gla_list to pass the list of gla's
# @param [Integer] line to pass the line number. If not specified, it will take line = 1
#
  def CIF_JNL.is_gla_values_present gla_list, line=1	
    count_of_gla_present = CIF.get_matched_count_picklist_value $cif_journal_gla_cell ,$cif_journal_general_ledger_account, gla_list,line=1  
    if count_of_gla_present == gla_list.count
      return true
    else
      return false
    end	
  end

##
# Method Summary: Returns true if the listed bank accounts are present else return false
#
# @param [String] ba_list to pass the list of bank accounts
# @param [Integer] line to pass the line number. If not specified, it will take line = 1
#
  def CIF_JNL.is_bankaccount_values_present ba_list, line=1	
    jnl_line_col_num = (CIF_JOURNAL_COLUMN_BANKACCOUNT)
    # Update the cell value as per Local GLA setting.
    if $cif_line_local_gla_enabled
      jnl_line_col_num +=1 
    end
    jnl_line_column = gen_sub_last_occurence $cif_journal_bankaccount_cell , $sf_param_substitute , jnl_line_col_num
    
    count_of_ba_present = CIF.get_matched_count_picklist_value jnl_line_column ,$cif_journal_bank_account, ba_list,line=1  
    if count_of_ba_present == ba_list.count
      return true
    else
      return false
    end	
  end  
end
