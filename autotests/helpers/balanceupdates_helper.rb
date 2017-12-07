 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BALUPDATE
extend Capybara::DSL

##################################################
# Balance and Updates                            #
##################################################
$bal_update_all_intersect_definition_radio_button = "input[id$='intersectradio:0']"
$bal_update_interset_name_radio_button = "input[id$='intersectradio:1']"
$bal_update_year_lookup_icon = "a[id*='yearField']"
$bal_update_from_period_lookup_icon = "a[id*='fromperiodField']"
$bal_update_to_period_lookup_icon = "a[id*='toperiodField']"
$bal_update_master_account = "input[id$='master-account']"
$bal_update_select_intersect_button = "Select Intersect"
$bal_update_select_intersect_list = "select[id$='selectintersect']"
$bal_update_message_panel = "div[id$='generalMessagePanel']"
$bal_update_run_button = "input[id$='run']"
$bal_update_run_merge_account_button = "input[id$='mergeAccountsButton']"
$bal_update_budget_period_values_pattern = "//td[text()='"+$sf_param_substitute+"']/following::td[1]"
$bal_update_set_master_account_for_merged_accounts= "td[id*='update-balances-for-merged-accounts-tab_lbl']"
#############################
# Budget and Balances (VF pages)
#############################
# # Rebuild Balances
# choose All Intersects Definition radio button
	def BALUPDATE.choose_all_intersect_definition_radio_button
		find($bal_update_all_intersect_definition_radio_button).click
	end
# choose Intersect name radio button
	def BALUPDATE.choose_intersect_name_radio_button
		find($bal_update_interset_name_radio_button).click
	end
# select Intersect
	def BALUPDATE.select_intersect interset_value
		SF.click_button $bal_update_select_intersect_button
		find($bal_update_select_intersect_list).select interset_value
		SF.click_button "Apply"
	end
# select year
	def BALUPDATE.set_year year , company_name
		SF.retry_script_block do
			FFA.select_year_from_lookup $bal_update_year_lookup_icon, year ,company_name
		end
	end
# select from period
	def BALUPDATE.select_from_period period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $bal_update_from_period_lookup_icon, period_name, company_name
		end
	end
# select To period
	def BALUPDATE.select_to_period period_name , company_name
		SF.retry_script_block do
			FFA.select_period_from_lookup $bal_update_to_period_lookup_icon, period_name, company_name
		end
	end

# get budget values 
## budget_period_name- name of the budget period. ex- Budget YTD Period 001 or Budget Period 001
	def BALUPDATE.get_budget_period_values budget_period_name
		return find($bal_update_budget_period_values_pattern.sub($sf_param_substitute,budget_period_name)).text
	end
# get balance update message 
	def BALUPDATE.get_processing_message
		return find($bal_update_message_panel).text
	end
## Update Balances for Merged Accounts
# click on update balance for merged accounts
	def BALUPDATE.click_tab_balance_update_for_merged_accounts
		SF.execute_script do
			find($bal_update_set_master_account_for_merged_accounts).click
			page.has_text?("Master Account")
		end
	end
# set master account
	def BALUPDATE.set_master_account account
		SF.execute_script do
			find($bal_update_master_account).set account
		end
	end
	
# # button
# click Run button
	def BALUPDATE.click_run_button
		SF.execute_script do
			find($bal_update_run_button).click
		end
		SF.wait_for_search_button
	end
	
	def BALUPDATE.click_run_merge_account_button
		SF.execute_script do
			find($bal_update_run_merge_account_button).click
		end
		SF.wait_for_search_button
	end
end

