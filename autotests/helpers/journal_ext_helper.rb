 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
 JNLEXT_MANAGE_LINE_TYPE_COLUMN = 2
 JNLEXT_MANAGE_LINE_ACCOUNT_COLUMN = 3
 JNLEXT_MANAGE_LINE_GLA_COLUMN = 4
 JNLEXT_MANAGE_LINE_VALUE_COLUMN = 8
 module JNLEXT
 extend Capybara::DSL
 #############################
# Journal Extended  Helper
#############################
$jnlext_journal_status = "//td[text()='Journal Status']/following::td[1]/div[1]"
$jnlext_manage_line_button = "input[value='Manage Lines']"
$jnlext_manage_line_new_line_button = "input[value='New Line']"
$jnlext_journal_name= "h2.pageDescription"
#Manage Lines
$jnlext_select_line_type = "table#uberGrid tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{JNLEXT_MANAGE_LINE_TYPE_COLUMN}) select[class$='LineType__c']"
$jnlext_manage_line_set_account_pattern= "table#uberGrid tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{JNLEXT_MANAGE_LINE_ACCOUNT_COLUMN}) input[class$='Account__c']"
$jnlext_manage_line_set_value_pattern = "table#uberGrid tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{JNLEXT_MANAGE_LINE_VALUE_COLUMN}) input[class*='Value__c']"
$jnlext_manage_line_set_gla_value_pattern = "table#uberGrid tbody tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(#{JNLEXT_MANAGE_LINE_GLA_COLUMN}) input[class*='GeneralLedgerAccount__c']"	
 #Labels
$jnlext_line_type_label = "Line Type"
$jnlext_line_value_label = "Value"
$jnlext_line_account_label = "Account"
$jnlext_line_general_ledger_account_label = "General Ledger Account"
$jnlext_line_reference_label = "Reference"
$jnlext_line_journal_status_label = "Journal Status"
 #methods
	# click on new button
	def JNLEXT.click_save_button
		SF.retry_script_block do
			SF.click_button_save
		end
		page.has_button?($ffa_post_button)
	end
	
# set reference at journal header
	def JNLEXT.set_journal_reference ref_value
		fill_in $jnlext_line_reference_label , :with => ref_value
	end
# get journal status
	def JNLEXT.get_journal_status
		SF.retry_script_block do 
			jnl_status = find(:xpath , $jnlext_journal_status).text
			if jnl_status == nil
				raise "Status not updated, trying again..."
			else
				puts "value not updated"
			end
		end
	end
# get journal_name from journal page
	def JNLEXT.get_journal_number 
		find($jnlext_journal_name).text
	end
# click on new journal line button to add a new line
	def JNLEXT.click_manage_line_button
		find($jnlext_manage_line_button).click
	end
# Journal Manage Line Item
	# click on new line button on manage line button
	def JNLEXT.click_new_line_button
		find($jnlext_manage_line_new_line_button).click
	end
	
	# select line type from manage line page
	def JNLEXT.select_line_type line_num, line_type
		SF.retry_script_block do 
			line_type_cell = $jnlext_select_line_type.sub($sf_param_substitute ,line_num.to_s )
			select_dropdown = find(line_type_cell)[:id]
			select(line_type, :from => select_dropdown) 
			find(line_type_cell).native.send_keys(:tab)
		end
	end
	
	# set account value on manage line
	def JNLEXT.set_manage_line_account_value line_num,acc_value
		SF.retry_script_block do 
			acc_cell = $jnlext_manage_line_set_account_pattern.sub($sf_param_substitute ,line_num.to_s)
			find(acc_cell).set acc_value
		end
	end
	
	# set account value on manage line
	def JNLEXT.set_manage_line_gla_value line_num,gla_value
		SF.retry_script_block do 
			find($jnlext_manage_line_set_gla_value_pattern.sub($sf_param_substitute ,line_num.to_s)).set gla_value
		end
	end
	
	# set  value on manage line
	def JNLEXT.set_manage_line_value line_num,value
		SF.retry_script_block do 
			find($jnlext_manage_line_set_value_pattern.sub($sf_param_substitute ,line_num.to_s)).set value
		end
	end
	
	# click post button
	def JNLEXT.click_post_button
		SF.retry_script_block do
			FFA.click_post
		end
	end
 end
 