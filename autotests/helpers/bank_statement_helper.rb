 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BS
extend Capybara::DSL
#############################
# bank statement (VF pages)
#############################
#selectors
$bankstatement_bank_acc_label = "Bank Account"
$bankstatement_statement_date = "Statement Date"
$bankstatement_reference = "Reference"
$bankstatement_opening_balance = "Opening Balance"
$bankstatement_closing_balance = "Closing Balance"
$bankstatement_status = "//td[text()='Status']/following-sibling::td//div | //span[text()='Status']/ancestor::div[1]/following::div[1]/div/span"
$bankstatement_reconcile_table = ".bankRecWrapper"
$bankstatement_import_button = "input[id$=':import']"
$bankstatement_reconcile_bankstatement_lines ="//span[text()='"+$sf_param_substitute+"']/../preceding-sibling::td[2]"
$bankstatement_reconcile_complete_reconciliation = "input[value='Complete Reconciliation']"
$bankstatement_reconciliation_status = "//td[text()='Reconciliation Status']/following-sibling::td//div"
$bankstatement_number = "//h2[@class='pageDescription'] | //p[text()='Bank Statement']/following::h1/span"
$bankstatement_link = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[contains(text(), '"+$sf_param_substitute+"')]"
$bankstatement_reconcile_commit_lines = "input[value='Commit Selected Lines']"
$bankstatement_bank_account_lookup_icon = "a[title='Bank Account Lookup (New Window)']"
$bankstatement_reconcile_button_label = "Reconcile"
$bankstatement_import_file_locator = "//label[contains(text(), 'Statement File')]"
$bankstatement_statement_date_locator=  "input[id$=':statementDateField']"
$bankstatement_processing_message = "Processing..."
$bankstatement_auto_reconcile_confirm = "Yes"

# Locators for lightning org
$bankstatement_reconcile_button = "//div[@title='Reconcile']/ancestor::a"
$bankstatement_auto_reconcile_confirm_button = "//div[@id='Yes']"

#methods
# set bank account
	def BS.set_bank_account bank_account,company_name		
		SF.retry_script_block do
			FFA.select_bank_account_from_lookup $bankstatement_bank_account_lookup_icon,bank_account,company_name
		end
	end
# set bank statement date
	def BS.set_statement_date statement_date
		SF.execute_script do
			fill_in $bankstatement_statement_date ,:with => statement_date
			gen_tab_out $bankstatement_statement_date_locator
			FFA.wait_page_message $bankstatement_processing_message
		end
	end
# set reference value
	def BS.set_reference reference
		SF.execute_script do
			fill_in $bankstatement_reference ,:with => reference
		end
	end
# set opening balance
	def BS.set_opening_balance opening_balance
		SF.execute_script do
			fill_in $bankstatement_opening_balance ,:with => opening_balance
		end
	end
# set closing balance date
	def BS.set_closing_balance closing_balance
		SF.execute_script do
			fill_in $bankstatement_closing_balance ,:with => closing_balance
		end
	end
# get bank statement status
	def BS.get_bank_statement_status
		return find(:xpath,$bankstatement_status).text
	end
# click reconcile button
    def BS.click_button_reconcile
        SF.retry_script_block do
            if(SF.org_is_lightning)
                page.has_css?($sfl_show_more_action_link)
                find($sfl_show_more_action_link).click
                find(:xpath, $bankstatement_reconcile_button).click
            else
                SF.click_button $bankstatement_reconcile_button_label
            end
            SF.wait_for_search_button
        end
    end
# click yes button on reconcile confirmation page
    def BS.click_button_reconcile_confirm
        SF.retry_script_block do
            if(SF.org_is_lightning)
                page.has_css?($sfl_show_more_action_link)
                find($sfl_show_more_action_link).click
                find(:xpath, $bankstatement_auto_reconcile_confirm_button).click
            else
                SF.click_button $bankstatement_auto_reconcile_confirm
            end
            gen_wait_until_object $bankstatement_reconcile_table
        end
    end
# click reconcile button but skipping confirmation page
	def BS.click_button_reconcile_skips_confirmation
	    SF.retry_script_block do
            BS.click_button_reconcile
            gen_wait_until_object $bankstatement_reconcile_table
        end
	end 
# click import button	
	def BS.click_button_import
		SF.execute_script do
			find($bankstatement_import_button).click
		end
		SF.wait_for_search_button
	end
# select bank statement lines as per reference to select
	def BS.select_bank_statement_lines reference_to_select
		SF.execute_script do
			line_to_select = $bankstatement_reconcile_bankstatement_lines.sub($sf_param_substitute, reference_to_select)
			find(:xpath,line_to_select).click
		end
	end
# click commit button 
	def BS.click_button_commit_selected_lines
		SF.execute_script do
			SF.retry_script_block do
				find($bankstatement_reconcile_commit_lines).click
			end
			#waiting for complete reconciliation button to appear within the reconciliation table.
			gen_wait_until_object $bankstatement_reconcile_complete_reconciliation
			# wait for processing message on UI to be cleared so that Complete Reconciliation button on background UI is displayed as enabled to be clicked.
			gen_wait_less
		end
	end 	
# get bank statement number
	def BS.get_bank_statement_number		
		return find(:xpath,$bankstatement_number).text		
	end	
# open bank statement detail page
	def BS.open_bank_statement_detail_page bank_statement_number
		record_to_click = $bankstatement_link.gsub($sf_param_substitute, bank_statement_number)
		find(:xpath , record_to_click).click
		page.has_text?(bank_statement_number)
	end	
# click on complete button to reconcile 
	def BS.click_complete_reconciliation_button 
		SF.retry_script_block do
			SF.execute_script do
				find($bankstatement_reconcile_complete_reconciliation).click
			end
		end
		SF.wait_for_search_button
	end
# import bank statement file
	def BS.import_statement_file file_name_to_import
		SF.execute_script do
			element_id = find(:xpath , $bankstatement_import_file_locator)[:for]
			FFA.upload_file element_id,file_name_to_import
		end
	end
end