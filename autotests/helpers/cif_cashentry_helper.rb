#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
module CIF_CE
  extend Capybara::DSL

CASH_ENTRY_ACCOUNT_VALUE = 2
CASH_ENTRY_ACCOUNT_REFERENCE_VALUE = 3
CASH_ENTRY_VALUE = 5
############################
#CIF Cash Entry locators
############################
#Header locators
$cif_ce_type = "input[name$='Type__c']"
$cif_ce_bank_account_value = "input[name$='BankAccount__c']"
$cif_ce_date = "input[name$='Date__c']"
$cif_ce_period = "div[data-ffid$='Period__c'] div[data-ffid$='lookup'] input"
$cif_ce_payment_method = "input[name$='PaymentMethod__c']"
$cif_ce_currency = "div[data-ffid$='CashEntryCurrency__c'] div[data-ffid$='lookup'] input"
$cif_ce_reference = "input[name$='Reference__c']"
$cif_ce_description = "div[data-ffid$='Description__c'] div[data-ffid$='content'] textarea"
$cif_ce_reference_view = "div[data-ffid$='Reference__c'] div:nth-child(2) div"
$cif_ce_description_view = "div[data-ffid$='Description__c'] div:nth-child(2) div"
$cif_ce_custom_button_label = "CB_test"
$cif_ce_custom_button_cb_test = "//a[@data-qtip='CB_test']"
$cif_ce_custom_button_cb_test_vf_page_text = "Custom button text"
$cif_ce_sharing_button_label = "Sharing"
$cif_ce_submit_for_approval_button_label = "Submit for Approval"
#Cash Entry Line Items Locators
$cif_ce_namespace_account_value = "div[data-ffid='#{ORG_PREFIX}Account__c'] div[data-ffid$='lookup'] input[id]"
$cif_ce_charges_gla = "input[name$='ChargesGLA__c']"
$cif_ce_account_value = "input[name='#{ORG_PREFIX}Account__c']"
$cif_ce_account_reference = "input[name$='AccountReference__c']"
$cif_ce_cash_entry = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CASH_ENTRY_VALUE})"
$cif_ce_account = "div[data-ffxtype='tableview'] table:nth-of-type("+$sf_param_substitute+") tr td:nth-of-type(#{CASH_ENTRY_ACCOUNT_VALUE})"
$cif_ce_cash_entry_value = "input[name$='CashEntryValue__c']"
$cif_cash_entry_status = "div[data-ffid$='Status__c'] div:nth-child(2) div"

#############################################
# Helper methods for Cash Entry header section.
#############################################
##
# Method Summary: Set Type  input field and select the Type from the list.
#
# @param [String] type Text to pass in to the Type
#
	def CIF_CE.set_ce_type type
		CIF.set_value_tab_out $cif_ce_type, type
	end
##
# Method Summary: Set payment method for cash entry
#
# @param payment_method[String] payment methof of cash entry
#
	def CIF_CE.set_ce_payment_method payment_method
		CIF.set_value_tab_out $cif_ce_payment_method, payment_method
	end
	
##
# Method Summary: Set the bank account value in the bank account field
# @param [String] Bank Account to pass in to the bank_account field.
#
	def CIF_CE.set_ce_bank_account bank_account
		CIF.set_value_tab_out $cif_ce_bank_account_value, bank_account
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK	
	end

##
# Method Summary: Set the Cash Entry Date value in the bank account field
# @param [Date] date     Date DD/MM/YYYY to pass in to the Date field.
#
	def CIF_CE.set_ce_date date
		find($cif_ce_date).set date
		gen_tab_out $cif_ce_date
	end

##
# Method Summary: Find the period input field and set the value.
#
# @param [String] period     Text period to pass in to the period field.
#
	def CIF_CE.set_ce_period period
	  	find($cif_ce_period).set period
		gen_tab_out $cif_ce_period
	end

##
# Method Summary: Find the Cash Entry currency input field and set the value.
#
# @param [String] currency     Text currency name to pass in to the cash entry currency field.
#
	def CIF_CE.set_ce_currency currency
	  	find($cif_ce_currency).set currency
	  	gen_tab_out $cif_ce_currency
	end

##
# Method Summary: Find the Reference input field and Enter the value.
#
# @param [String] reference     Text customer reference name to pass in to the customer reference field.
#
  	def CIF_CE.set_ce_reference reference
		find($cif_ce_reference).set reference
		gen_tab_out $cif_ce_reference
  	end

##
# Method Summary: Find the Cash Entry description input field and set the value.
#
# @param [String] description     Text description to pass in to the description field.
  	def CIF_CE.set_description description
  		find($cif_ce_description).set description
  		gen_tab_out $cif_ce_description
  	end

##
# Method Summary: get status of Cash Entry
#
	def CIF_CE.get_ce_document_status
		return find($cif_cash_entry_status).text
	end

##
# Method Summary: get reference field value of Cash Entry
#
	def CIF_CE.get_ce_reference
		return find($cif_ce_reference_view).text
	end

##
# Method Summary: get description field value of Cash Entry
#
	def CIF_CE.get_ce_description
		return find($cif_ce_description_view).text
	end

#########################################################################################################################
# Helper methods for Cash Entry line item section.
# For creating a Cash Entry line item, all the fields should be given values in the same order they apear on the UI
# as all below methods use tab out which will automatically take user to next field apearing in the row.
#########################################################################################################################

##
# Method Summary: Find the Account  input field and select the account from the list.
#
# @param [String] Account Text to pass in to the Account
# @param [integer] line to pass the line number, if argument not passed it will take 1 as default value
#
	def CIF_CE.set_ce_account account, line=1
		object_visible = gen_is_object_visible $cif_ce_account_value
		if (!object_visible)
			record_to_click = $cif_ce_account.gsub($sf_param_substitute, line.to_s)  #to be filled
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_ce_account_value, account
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
	end

##
# Method Summary: Find the Account Reference input field on Cash Entry line item and set the value into it.
#
# @param [String] account_ref    Text to pass in to the account reference field.
#
  def CIF_CE.set_ce_line_item_account_ref account_ref
    find($cif_ce_account_reference).set account_ref
    gen_tab_out $cif_ce_account_reference
  end

##
# Method Summary: Find the Cash Entry value  input field and input the value
#
# @param [String] cash_entry_value  Text to pass in to the cash_entry_value .
# @param [integer] line to pass the line number, if argument not passed it will take 1 as default value
#
	def CIF_CE.set_ce_cash_entry_value cash_entry_value, line=1
		object_visible = gen_is_object_visible $cif_ce_cash_entry_value
		if (!object_visible)
			record_to_click = $cif_ce_cash_entry.gsub($sf_param_substitute, line.to_s)
			find(record_to_click).click
		end
		CIF.set_value_tab_out $cif_ce_cash_entry_value, cash_entry_value
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
		CIF.wait_for_actions_to_complete $cif_calculations_wait_message
	end
	
##
# Method Summary : Click on new row
#
	def CIF_CE.click_new_row
		SF.retry_script_block do
			CIF.click_new_row
		end
		sleep 1# wait for new line to become visible/enable.
	end
	
##
# Method Summary: Click the save and post CE button.
#
	def CIF_CE.click_sinv_save_post_button
		CIF.click_save_post_button
	end
	
##
# Method Summary: Click the save button.
#
	def CIF_CE.click_ce_save_button
		CIF.click_save_button
	end
	
	##
	# Method Summary: Returns the true if GLAs are present in the GLA line item else return false if the GLA's not present
	#
	# @param [String] gla_list to pass the list of gla's
	# @param [Integer] line to pass the line number. If not specified, it will take line = 1 
	#
	def CIF_CE.is_charges_gla_values_present gla_list  ,line=1	
		count_of_gla_present = CIF.get_matched_count_picklist_value $cif_ce_charges_gla ,$cif_ce_charges_gla ,gla_list,line=1  
		if count_of_gla_present == gla_list.count
			return true
		else
			return false
		end	
	end

	##
	# Method Summary: Set the value in the ChargesGLA field
	#
	# @param [String] gla_value to pass the list of gla's
	#
	def CIF_CE.set_ce_charges_gla gla_value
		CIF.set_value_tab_out $cif_ce_charges_gla, gla_value
		CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK	
	end
##
# Method Summary: Method to compare the values of Cash Entry.
#
# @param [String]  date            		Expected date to compare with the actual value.
# @param [String]  period          		Expected period to compare with the actual value.
# @param [String]  currency        		Expected currency to compare with the actual value.
# @param [Integer] cash_entry_value     Expected Cash Entry Value to compare with the actual value.
# @param [Integer] bank_account_value   Expected Bank Account Value to compare with the actual value.
# @param [Integer] net_value            Expected Net Value to compare with the actual value.
# @param [Integer] net_banked          	Expected Net Banked to compare with the actual value.
# @param [String] status           		Expected Status to compare with the actual value.
#
    def CIF_CE.compare_ce_header_details(date, period, currency, cash_entry_value, bank_account_value, net_value, net_banked, status)
    	if date != nil
      		page.assert_selector('div[data-ffid$="Date__c"] div div', :text =>date, :visible => true)
    	end
    	if period != nil
      		page.assert_selector('div[data-ffid$="Period__c"] div div', :text => period, :visible => true)
    	end
	    if currency != nil
	       	page.assert_selector('div[data-ffid$="CashEntryCurrency__c"] div div', :text => currency, :visible => true)
	    end
	    if cash_entry_value != nil
	      	page.assert_selector('div[data-ffid$="Value__c"] div div', :text => cash_entry_value, :visible => true)
	    end
	    if bank_account_value != nil
	      	page.assert_selector('div[data-ffid$="BankAccountValue__c"] div div', :text => bank_account_value, :visible => true)
	    end
	    if net_value != nil
	      	page.assert_selector('div[data-ffid$="NetValue__c"] div div', :text => net_value, :visible => true)
	    end
	    if net_banked != nil
	      	page.assert_selector('div[data-ffid$="NetBanked__c"] div div', :text => net_banked, :visible => true)
	    end
	    if status != nil
	      	page.assert_selector('div[data-ffid$="Status__c"] div div', :text => status, :visible => true)
	    end
  end

##
#
# Method Summary: Method to get the value from a column for specified row in CIF view mode
#
# @param [Integer] row_number     Value of the row number from which the value needs to be fetched
# @param [Integer] col_number     Value of the column number from which the value needs to be fetched
#
  def CIF_CE.get_column_value_from_grid_data_row_on_view_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    return find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).text
  end

##
#
# Method Summary: Method to click in a column for specified row.
#
  def CIF_CE.click_column_grid_data_row row_number, col_number
    find("div[class = 'f-panel f-grid-locked f-tabpanel-child f-panel-default f-grid'] div[class*='f-grid-inner-normal'] table:nth-of-type(#{row_number}) tr td:nth-of-type(#{col_number})").click
  end
  
##
#
# Method Summary: Method to get the value from a column for specified row in CIF amend page
#
  def CIF_CE.click_column_grid_data_row_amend_page row_number, col_number
    grid_row_pattern = $cif_grid_row_value_on_view_page.sub($sf_param_substitute,row_number.to_s)
    find(grid_row_pattern.sub($sf_param_substitute ,col_number.to_s)).click
  end
##
#
# Method Summary: Method to click on Custom button CB_test
#
  def CIF_CE.click_custom_button_cb_test
	find(:xpath, $cif_ce_custom_button_cb_test).click
	gen_wait_less# wait for new window to open
  end	
end
