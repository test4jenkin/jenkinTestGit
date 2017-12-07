 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BBL
extend Capybara::DSL
#############################
# Budget and Balances (VF pages)
#############################

################################
# Selectors
################################
#labels
$budget_and_balances_year_label = "Year"
$budget_and_balances_intersect_defintion_label = "Intersect Definition"
$budget_and_balances_gla_label = "General Ledger Account"
$budget_and_balances_account_label = "Account"
$budget_and_balance_dimension1 = "Dimension 1"
$budget_and_balances_budget_period_001_label = "Budget Period 001"
$budget_and_balances_budget_period_002_label = "Budget Period 002"
$budget_and_balances_budget_period_003_label = "Budget Period 003"
$budget_and_balances_budget_period_004_label = "Budget Period 004"
$budget_and_balances_budget_period_005_label = "Budget Period 005"
$budget_and_balances_budget_period_006_label = "Budget Period 006"
$budget_and_balances_budget_period_007_label = "Budget Period 007"
$budget_and_balances_budget_period_008_label = "Budget Period 008"
$budget_and_balances_budget_period_009_label = "Budget Period 009"
$budget_and_balances_budget_period_010_label = "Budget Period 010"
$budget_and_balances_budget_period_011_label = "Budget Period 011"
$budget_and_balances_budget_period_012_label = "Budget Period 012"
$budget_and_balances_brought_forward_budget_label = "Brought Forward Budget"
$budget_and_balances_brought_forward_actual = "Brought Forward Actual"
$budget_and_balances_budget_period_value_pattern  = "//td[text() = '"+$sf_param_substitute+"']/following-sibling::td[1]//div | //span[text()='"+$sf_param_substitute+"']/ancestor::div[1]/following::div[1]/div/span"
$budget_and_balances_budget_id = "//*[text()='Budget ID']/following::td/div | //span[text()='Budget ID']/ancestor::div[1]/following::div[1]/div/span"
$budget_and_balances_number_pattern = "//span[contains(text(), '"+$sf_param_substitute+"')]/ancestor::a[1] | //a[text()='"+$sf_param_substitute+"']"
$budget_and_balances_number_value = "//td[contains(text(), 'Budget ID')]/following-sibling::td//div | //span[text()='Budget ID']/ancestor::div[1]/following::div[1]/div/span"
$budget_and_balances_brought_forward_budget_value = "//td[text() = 'Brought Forward Budget']/following-sibling::td[1]//div"
$budget_and_balances_brought_forward_actual_value = "//td[text() = 'Brought Forward Actual']/following-sibling::td[1]//div"
##################################################
# Balance and Updates                            #
##################################################
$bal_update_all_intersect_definition_radio_button = "input[id$='intersectradio:0']"
$bal_update_interset_name_radio_button = "input[id$='intersectradio:1']"
$bal_update_year_lookup_icon = "a[id*='yearField']"
$bal_update_from_period_lookup_icon = "a[id*='fromperiodField']"
$bal_update_to_period_lookup_icon = "a[id*='toperiodField']"
$bal_update_master_account = "input[id$='masterAccount']"
$bal_update_select_intersect_button = "Select Intersect"
$bal_update_select_intersect_list = "select[id$='selectintersect']"
$bal_update_message_panel = "div[id$='generalMessagePanel']"
$bal_update_run_button = "input[id$='run']"
$bal_update_run_merge_account_button = "input[id$='runMergedAccount']"
$bal_update_budget_period_values_pattern = "//td[text()='"+$sf_param_substitute+"']/following::td[1]"

#methods
# # Balance Details
# set year
	def BBL.set_year year , company_name
		element_id = find(:xpath , "//*[text()='" + $budget_and_balances_year_label + "']")[:for]
		year_lookup_icon = 'a[id*="'+element_id+'"]'
		SF.retry_script_block do
			FFA.select_year_from_lookup year_lookup_icon, year , company_name
		end
	end
	
# set Interset Definition
	def BBL.set_intersect_definition intersect_definition
		SF.fill_in_lookup $budget_and_balances_intersect_defintion_label ,intersect_definition
	end
# set brought forward budget
	def BBL.set_brought_forward_budget budget_value
		fill_in $budget_and_balances_brought_forward_budget_label, :with => budget_value
	end
# set Brought Forward Actual
	def BBL.set_brought_forward_actual actual_value
		fill_in $budget_and_balances_brought_forward_actual, :with => actual_value
	end
# set diemnsion1
	def BBL.set_dimension1_value dimension_value
		SF.fill_in_lookup $budget_and_balance_dimension1, dimension_value
	end
# # Accounting Code
# set General Ledger Accounting
	def BBL.set_general_ledger_account  gla_value
		fill_in $budget_and_balances_gla_label ,:with => gla_value
	end

# set Account
	def BBL.set_account  account
		SF.fill_in_lookup $budget_and_balances_account_label , account
	end
	
# Set Budget Value
	# budget_period_label: Label of budget period which need to be set; 
	# budget_period_amount- Amount which need to be set.
	def BBL.set_budget_period_amount budget_period_label,  budget_period_amount
		fill_in budget_period_label ,:with => budget_period_amount
	end

# # get budget details
# get budget ID
	def BBL.get_budget_id
		page.has_xpath?($budget_and_balances_budget_id)
		return find(:xpath,$budget_and_balances_budget_id).text
	end
	
# get Brought Forward Budget
	def BBL.get_budget_brought_budget_forward_value
		return find(:xpath,$budget_and_balances_brought_forward_budget_value).text
	end
	
# get Brought Forward Budget
	def BBL.get_budget_brought_forward_actual_value 
		return find(:xpath,$budget_and_balances_brought_forward_actual_value).text
	end
# open budget and balances detail pages
	def BBL.open_budget_and_balance_detail_page budget_id
		find(:xpath ,$budget_and_balances_number_pattern.gsub($sf_param_substitute,budget_id)).click
		gen_wait_less
	end
#get budget balance number	
	def BBL.get_budget_number
		find(:xpath , $budget_and_balances_number_value).text
	end
	
# get budget period values: Pass budget period label for which value need to be retrieved.
	def BBL.get_budget_period_value budget_period_label 
		return find(:xpath , $budget_and_balances_budget_period_value_pattern.gsub($sf_param_substitute,budget_period_label)).text
	end
end