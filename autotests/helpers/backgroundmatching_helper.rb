
#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BGM 
extend Capybara::DSL
#############################
# Background Mathcing(VF pages)
#################################
# Background Matching selectors
#################################
$bgm_account = "input[id$=':account']"
$bgm_match_upto_date = "input[id$=':matchDateUpTo']"
$bgm_currency_mode = "//label[contains(text(),'Currency Mode')]/../following-sibling::td/span/select[1]"
$bgm_matching_currency = "//label[contains(text(),'Matching Currency')]/following-sibling::select"
$bgm_first_match_by = "//label[contains(text(),'First Match By')]/../following-sibling::td/select"
$bgm_then_match_by = "//label[contains(text(),'Then Match By')]/../following-sibling::td//span/select"

$bgm_allow_partial_payment = "//label[contains(text(),'Allow Partial Payment?')]/preceding-sibling::input"
$bgm_matching_date = "//label[contains(text(),'Matching Date')]/../following-sibling::td/span/input"
$bgm_account_value = "//label[contains(text(),'Account')]/../following-sibling::td[1]"
$bgm_matched_upto_value = "//label[contains(text(),'Matched Up To')]/../following-sibling::td"
$bgm_first_match_by_value = "//label[contains(text(),'First Match By')]/../following-sibling::td"
$bgm_where_value = "//label[contains(text(),'Where')]/../following-sibling::td"
$bgm_matching_date_value = "//label[contains(text(),'Matching Date')]/../following-sibling::td"
$bgm_partial_payments_value = "//label[contains(text(),'Partial Payments')]/../following-sibling::td[1]"
$bgm_warning_message = "div.message.warningM2 div"
# Buttons
$bgm_start_matching_button = "Start Matching"
$bgm_add_matching_condition =  "input[value = 'Add Matching Condition']"

#################################
# Background Matching methodss
#################################
# Set account name
	def BGM.set_account account_name
		SF.execute_script do
			find($bgm_account).set account_name
		end
	end
	
	def BGM.set_match_upto_date date_value
		SF.execute_script do
			find($bgm_match_upto_date).set date_value
		end
	end
	
	def BGM.select_currency_mode currency_mode
		SF.execute_script do
			find(:xpath, $bgm_currency_mode).select currency_mode
		end
	end
	
	def BGM.select_matching_currency currency_name
		SF.execute_script do
			find(:xpath, $bgm_matching_currency).select currency_name
		end
	end
	
	def BGM.select_first_match_by matching_condition
		SF.execute_script do
			find(:xpath, $bgm_first_match_by).select matching_condition
		end
	end
	
	def BGM.select_then_match_by matching_condition
		SF.execute_script do
			find(:xpath, $bgm_then_match_by).select matching_condition
		end
	end
	
	def BGM.set_allow_partial_payment bln_value
		SF.execute_script do
			find(:xpath, $bgm_allow_partial_payment).set bln_value
		end
	end
	
	def BGM.set_matching_date date
		SF.execute_script do
			find(:xpath, $bgm_matching_date).set date
			find(:xpath, $bgm_matching_date).native.send_keys(:tab)
		end
	end
	
	def BGM.get_account_value
		SF.retry_script_block do
			SF.execute_script do
				page.has_xpath?($bgm_account_value)
				return find(:xpath, $bgm_account_value).text
			end
		end
	end
	
	def BGM.get_matched_up_to_value
		SF.execute_script do
			return find(:xpath, $bgm_matched_upto_value).text
		end
	end
	
	def BGM.get_first_match_by_value
		SF.execute_script do
			return find(:xpath, $bgm_first_match_by_value).text
		end
	end
	
	def BGM.get_where_value
		SF.execute_script do
			return find(:xpath, $bgm_where_value).text
		end
	end
	
	def BGM.get_matching_date_value
		SF.execute_script do
			return find(:xpath, $bgm_matching_date_value).text
		end
	end
	
	def BGM.get_partial_payments_value
		SF.execute_script do
			return find(:xpath, $bgm_partial_payments_value).text
		end
	end
	
	def BGM.get_warning_message
		SF.execute_script do
			return find($bgm_warning_message).text
		end
	end
	
	def BGM.click_button_add_matching_condition
		SF.execute_script do
			find($bgm_add_matching_condition).click
		end
	end

end