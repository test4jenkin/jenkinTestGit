#--------------------------------------------------------------------#
#	TID : TID020354
# 	Pre-Requisite : smoketest_data_setup.rb , setup_smoketest_data_ext.rb
#  	Product Area:  Accounting - Payments Collections & Cash Entries
#--------------------------------------------------------------------#

describe "TID020354 Smoke Test:-  New Payment - APC GLA Filter via custom setting", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	#variables
	_gla_retained_profit = "Retained Profit"
	_trial_balance2_current_liabilities = "Current Liabilities"
	_trial_balance2_long_term_liabilities = "Long Term Liabilities"
	_trial_balance2_current_assets = "Current Assets"
	_trial_balance2_fixed_assets = "Fixed Assets"
	_any_filter = 'ANY FILTER'
	_no_filtering = 'NO FILTERING'
	_exclude_pl = 'EXCLUDE P&L'
	
	before :all do
		#Hold Base Data
		gen_start_test "TID020354"	
		FFA.hold_base_data_and_wait
		#Additional data section
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
			
		update_gla $bd_gla_accounts_payable_control_eur , $bd_gla_type_balance_sheet, $bd_gla_type_balance_sheet , _trial_balance2_current_liabilities
		update_gla $bd_gla_accounts_payable_control_gbp , $bd_gla_type_balance_sheet, $bd_gla_type_balance_sheet , _trial_balance2_long_term_liabilities
		update_gla $bd_gla_account_receivable_control_eur , $bd_gla_type_balance_sheet, $bd_gla_type_balance_sheet , _trial_balance2_long_term_liabilities
		update_gla $bd_gla_account_receivable_control_usd , $bd_gla_type_balance_sheet, $bd_gla_type_balance_sheet , _trial_balance2_current_assets
		update_gla $bd_gla_account_receivable_control_gbp , $bd_gla_type_balance_sheet, $bd_gla_type_balance_sheet , _trial_balance2_fixed_assets
		update_gla $bd_gla_settlement_discounts_allowed_us , $bd_gla_type_profit_and_loss, nil , nil
		update_gla $bd_gla_settlement_discount_allowed_uk , $bd_gla_type_profit_and_loss, nil , nil
		update_gla $bd_gla_exchange_gain_loss_us , $bd_gla_type_profit_and_loss, nil , nil
		update_gla $bd_gla_exchange_gain_loss_uk , $bd_gla_type_profit_and_loss, nil , nil
		update_gla _gla_retained_profit , $bd_gla_type_retained_earnings, nil , nil
	end
	
	it "TST033479- There's no custom setting => Balance Sheet filter should apply" do
		
			gen_start_test "TST033479- There's no custom setting => Balance Sheet filter should apply"
			#There's no custom setting => Balance Sheet filter should apply
			delete_acc_setting = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
			APEX.execute_commands [delete_acc_setting]
			# Go to New Payment tab and fill all the fields:
			set_payment_plus_data
			
			#A) The following GLAs should be available for selection: 
			NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur
			NEWPAY.set_APC_GLA $bd_gla_accounts_payable_control_gbp
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_eur
			gen_compare([$bd_gla_account_payable_control_eur, $bd_gla_accounts_payable_control_gbp ,$bd_gla_account_receivable_control_eur ], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,"3 Gla exists in list. ")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_payable_control_eur
			NEWPAY.remove_selected_APC_GLA $bd_gla_accounts_payable_control_gbp
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_eur
			
			#5. Accounts Receivable Control - USD  No matching entries found. 
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_usd
			gen_not_include(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_account_receivable_control_usd],"#{$bd_gla_account_receivable_control_usd} Gla does not exist in list. ")
			
			#6. Settlement Discounts Allowed US  No matching entries found. 
			NEWPAY.set_APC_GLA $bd_gla_settlement_discounts_allowed_us
			gen_not_include(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, [$bd_gla_settlement_discounts_allowed_us],"#{$bd_gla_settlement_discounts_allowed_us} Gla does not exist in list. ")	
			gen_end_test "TST033479- There's no custom setting => Balance Sheet filter should apply"
	end
	
	it "TST033480- The custom setting value is blank => Balance Sheet filter should apply" do
		login_user
		begin
			gen_start_test "TST033480- The custom setting value is blank => Balance Sheet filter should apply"
			delete_acc_setting = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
			APEX.execute_commands [delete_acc_setting]
			
			# Create custom setting
			custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}GLAFilteringInPaymentSelection__c = null);"
			custom_setting += "INSERT setting;"
			APEX.execute_commands [custom_setting]
			#Go to New Payment tab and fill all the fields:
			set_payment_plus_data
			#A) The following GLAs should be available for selection: 
			NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur
			NEWPAY.set_APC_GLA $bd_gla_accounts_payable_control_gbp
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_eur
			gen_compare([$bd_gla_account_payable_control_eur, $bd_gla_accounts_payable_control_gbp ,$bd_gla_account_receivable_control_eur ], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,"3 Gla exists in list. ")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_payable_control_eur
			NEWPAY.remove_selected_APC_GLA $bd_gla_accounts_payable_control_gbp
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_eur
			
			#5. Accounts Receivable Control - USD  No matching entries found. 
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_usd
			gen_not_include(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_account_receivable_control_usd],"#{$bd_gla_account_receivable_control_usd} Gla does not exist in list. ")
			
			#6. Settlement Discounts Allowed US  No matching entries found. 
			NEWPAY.set_APC_GLA $bd_gla_settlement_discounts_allowed_us
			gen_not_include(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, [$bd_gla_settlement_discounts_allowed_us],"#{$bd_gla_settlement_discounts_allowed_us} Gla does not exist in list. ")
			gen_end_test "TST033480- The custom setting value is blank => Balance Sheet filter should apply"
		end
	end
	
	it "TST033481- The custom setting value is wrong => Balance Sheet filter should apply" do
		login_user
		begin
			gen_start_test "TST033481- The custom setting value is wrong => Balance Sheet filter should apply"
			delete_acc_setting = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
			APEX.execute_commands [delete_acc_setting]
			
			#The custom setting value is blank => Balance Sheet filter should apply
			# Create custom setting
			custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}GLAFilteringInPaymentSelection__c = '#{_any_filter}');"
			custom_setting += "INSERT setting;"
			APEX.execute_commands [custom_setting]
			#Go to New Payment tab and fill all the fields:
			set_payment_plus_data
			#A) The following GLAs should be available for selection: 
			NEWPAY.set_APC_GLA $bd_gla_account_payable_control_eur
			NEWPAY.set_APC_GLA $bd_gla_accounts_payable_control_gbp
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_eur
			gen_compare([$bd_gla_account_payable_control_eur, $bd_gla_accounts_payable_control_gbp ,$bd_gla_account_receivable_control_eur ], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,"3 Gla exists in list. ")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_payable_control_eur
			NEWPAY.remove_selected_APC_GLA $bd_gla_accounts_payable_control_gbp
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_eur
			
			#5. Accounts Receivable Control - USD  No matching entries found. 
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_usd
			gen_not_include(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_account_receivable_control_usd],"#{$bd_gla_account_receivable_control_usd} Gla does not exist in list. ")
			
			#6. Settlement Discounts Allowed US  No matching entries found. 
			NEWPAY.set_APC_GLA $bd_gla_settlement_discounts_allowed_us
			gen_not_include(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, [$bd_gla_settlement_discounts_allowed_us],"#{$bd_gla_settlement_discounts_allowed_us} Gla does not exist in list. ")
			gen_end_test "TST033481- The custom setting value is wrong => Balance Sheet filter should apply"
		end
	end
	
	it "TST033482- The custom setting value is NO FILTERING => All GLAs should be retrieved" do
		login_user
		begin
			gen_start_test "TST033482- The custom setting value is NO FILTERING => All GLAs should be retrieved"
			delete_acc_setting = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
			APEX.execute_commands [delete_acc_setting]
			
			#The custom setting value is blank => Balance Sheet filter should apply
			# Create custom setting
			custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}GLAFilteringInPaymentSelection__c = '#{_no_filtering}');"
			custom_setting += "INSERT setting;"
			APEX.execute_commands [custom_setting]
			#2,3,4  Go to New Payment tab and fill all the fields:
			set_payment_plus_data
			#5. Type "Accounts Receivable Control - USD" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_usd
			gen_compare(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, [$bd_gla_account_receivable_control_usd], "#{$bd_gla_account_receivable_control_usd} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_usd
			
			#6. Type "Settlement Discounts Allowed US" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_settlement_discounts_allowed_us
			gen_compare(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, [$bd_gla_settlement_discounts_allowed_us],"#{$bd_gla_settlement_discounts_allowed_us} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_settlement_discounts_allowed_us
			#7. 7. Type "Exchange Gain/Loss UK" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_exchange_gain_loss_us
			gen_compare(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_exchange_gain_loss_us], "#{$bd_gla_exchange_gain_loss_us} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_exchange_gain_loss_us
			#8. Type "Retained Profit" in the GLA field. Check result B
			NEWPAY.set_APC_GLA _gla_retained_profit
			gen_compare(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[_gla_retained_profit],  "#{$_gla_retained_profit} exists in list")
			NEWPAY.remove_selected_APC_GLA _gla_retained_profit
			#9. Type "Accounts Payable Control - EUR" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_accounts_payable_control_eur
			gen_compare( NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_accounts_payable_control_eur], "#{$bd_gla_accounts_payable_control_eur} exists in list ")
						
			#10. Set custom setting to the same value, but now write it in lower case: no filtering
			custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c accountSetting = [Select Id ,#{ORG_PREFIX}GLAFilteringInPaymentSelection__c from #{ORG_PREFIX}codaAccountingSettings__c][0];"
			custom_setting += "accountSetting.#{ORG_PREFIX}GLAFilteringInPaymentSelection__c = '#{_no_filtering.downcase}';"
			custom_setting += "UPDATE accountSetting;"
			APEX.execute_commands [custom_setting]
			
			#11. Repeat steps 2, 3, 4, 5, 7 and 8
			#2,3,4  Go to New Payment tab and fill all the fields:
			set_payment_plus_data
			#5. Type "Accounts Receivable Control - USD" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_usd
			gen_compare( NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, [$bd_gla_account_receivable_control_usd], "#{$bd_gla_account_receivable_control_usd} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_usd
			#7. Type "Exchange Gain/Loss UK" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_exchange_gain_loss_us
			gen_compare( NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_exchange_gain_loss_us], "#{$bd_gla_exchange_gain_loss_us} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_exchange_gain_loss_us
			#8. Type "Retained Profit" in the GLA field. Check result B
			NEWPAY.set_APC_GLA _gla_retained_profit
			gen_compare( NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[_gla_retained_profit], "#{_gla_retained_profit} exists in list")
			gen_end_test "TST033482- The custom setting value is NO FILTERING => All GLAs should be retrieved"
		end
	end
	
	it "TST033501- The custom setting value is EXCLUDE P&L => All GLAs different than Profit and Loss should be retrieved" do
		login_user
		begin
			gen_start_test "TST033501- The custom setting value is EXCLUDE P&L => All GLAs different than Profit and Loss should be retrieved"
			delete_acc_setting = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
			APEX.execute_commands [delete_acc_setting]
			
			#The custom setting value is blank => Balance Sheet filter should apply
			# Create custom setting
			custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}GLAFilteringInPaymentSelection__c = '#{_exclude_pl}');"
			custom_setting += "INSERT setting;"
			APEX.execute_commands [custom_setting]
			#2,3,4  Go to New Payment tab and fill all the fields:
			set_payment_plus_data
			#5. Type "Accounts Receivable Control - USD" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_usd
			gen_compare(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_account_receivable_control_usd], "#{$bd_gla_account_receivable_control_usd} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_usd
			#6. Type "Accounts Receivable Control - GBP" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_gbp
			gen_compare( NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_account_receivable_control_gbp], "#{$bd_gla_account_receivable_control_gbp} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_gbp
			#7. Type "Accounts Payable Control - EUR" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_accounts_payable_control_eur
			gen_compare(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_accounts_payable_control_eur], "#{$bd_gla_accounts_payable_control_eur} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_accounts_payable_control_eur
			#8. Type "Retained Profit" in the GLA field. Check result B
			NEWPAY.set_APC_GLA _gla_retained_profit
			gen_compare(NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, [_gla_retained_profit],"#{_gla_retained_profit} exists in list")
			NEWPAY.remove_selected_APC_GLA _gla_retained_profit
			#9. Type "Settlement Discounts Allowed US" in the GLA field. Check result C
			NEWPAY.set_APC_GLA $bd_gla_settlement_discounts_allowed_us
			gen_not_include([$bd_gla_settlement_discounts_allowed_us], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, "#{$bd_gla_settlement_discounts_allowed_us} No matching entries found ")
			
			#10. Type "Exchange Gain/Loss US" in the GLA field. Check result C
			NEWPAY.set_APC_GLA $bd_gla_exchange_gain_loss_us
			gen_not_include([$bd_gla_exchange_gain_loss_us], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,"#{$bd_gla_exchange_gain_loss_us} No matching entries found ")
			
			#11. Type "Settlement Discounts Allowed UK" in the GLA field. Check result C
			NEWPAY.set_APC_GLA $bd_gla_settlement_discount_allowed_uk
			gen_not_include([$bd_gla_settlement_discount_allowed_uk], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, "#{$bd_gla_settlement_discount_allowed_uk} No matching entries found ")
			
			#12. Type "Exchange Gain/Loss UK" in the GLA field. Check result C
			NEWPAY.set_APC_GLA $bd_gla_exchange_gain_loss_uk
			gen_not_include([$bd_gla_exchange_gain_loss_uk], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, "#{$bd_gla_exchange_gain_loss_uk} No matching entries found ")
			
			#13. Set custom setting to the same value, but now write it in lower case: exclude p&l 
			custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c accountSetting = [Select Id ,#{ORG_PREFIX}GLAFilteringInPaymentSelection__c from #{ORG_PREFIX}codaAccountingSettings__c][0];"
			custom_setting += "accountSetting.#{ORG_PREFIX}GLAFilteringInPaymentSelection__c = '#{_exclude_pl.downcase}';"
			custom_setting += "UPDATE accountSetting;"
			APEX.execute_commands [custom_setting]
			
			#Repeat steps 2, 3, 4, 6, 8 and 9
			#2,3,4  Go to New Payment tab and fill all the fields:
			set_payment_plus_data
			#6. Type "Accounts Receivable Control - GBP" in the GLA field. Check result B
			NEWPAY.set_APC_GLA $bd_gla_account_receivable_control_gbp
			gen_compare( NEWPAY.get_selecttransactions_APC_GLA_all_selected_options,[$bd_gla_account_receivable_control_gbp], "#{$bd_gla_account_receivable_control_gbp} exists in list")
			NEWPAY.remove_selected_APC_GLA $bd_gla_account_receivable_control_gbp
			#8. Type "Retained Profit" in the GLA field. Check result B
			NEWPAY.set_APC_GLA _gla_retained_profit
			gen_compare([_gla_retained_profit], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, "#{_gla_retained_profit} exists in list")
			NEWPAY.remove_selected_APC_GLA _gla_retained_profit
			#9. Type "Settlement Discounts Allowed US" in the GLA field. Check result C
			NEWPAY.set_APC_GLA $bd_gla_settlement_discounts_allowed_us
			gen_not_include([$bd_gla_settlement_discounts_allowed_us], NEWPAY.get_selecttransactions_APC_GLA_all_selected_options, "#{$bd_gla_settlement_discounts_allowed_us} No matching entries found ")
			gen_end_test "TST033501- The custom setting value is EXCLUDE P&L => All GLAs different than Profit and Loss should be retrieved"
		end
	end
	
	after :all do
		login_user
		update_gla $bd_gla_accounts_payable_control_eur , $bd_gla_type_balance_sheet, nil , nil
		update_gla $bd_gla_accounts_payable_control_gbp , $bd_gla_type_balance_sheet, nil , nil
		update_gla $bd_gla_account_receivable_control_eur , $bd_gla_type_balance_sheet, nil , nil
		update_gla $bd_gla_account_receivable_control_usd , $bd_gla_type_balance_sheet, nil , nil
		update_gla $bd_gla_account_receivable_control_gbp , $bd_gla_type_balance_sheet, nil , nil
		update_gla $bd_gla_settlement_discounts_allowed_us , $bd_gla_type_profit_and_loss , nil , nil
		update_gla $bd_gla_settlement_discount_allowed_uk , $bd_gla_type_profit_and_loss, nil , nil
		update_gla $bd_gla_exchange_gain_loss_us , $bd_gla_type_profit_and_loss, nil , nil
		update_gla $bd_gla_exchange_gain_loss_uk , $bd_gla_type_profit_and_loss, nil , nil
		update_gla _gla_retained_profit , $bd_gla_type_retained_earnings, nil , nil
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID020354"
		SF.logout 
	end
end	

#Update gla type and trial balance
def update_gla gla_name , gla_type, trial_balance1, trial_balance2
		update_gla_query = "#{ORG_PREFIX}CODAGeneralLedgerAccount__c gla = [Select Id,#{ORG_PREFIX}Type__c, #{ORG_PREFIX}TrialBalance1__c,#{ORG_PREFIX}TrialBalance2__c from #{ORG_PREFIX}CODAGeneralLedgerAccount__c  Where Name='#{gla_name}'];"
		update_gla_query += "gla.#{ORG_PREFIX}Type__c = '#{gla_type}';"
		if update_gla_query != nil 
			update_gla_query += "gla.#{ORG_PREFIX}TrialBalance1__c = '#{trial_balance1}';"
		else
				update_gla_query += "gla.#{ORG_PREFIX}TrialBalance1__c = null;"
		end
		
		if update_gla_query != nil
			update_gla_query += "gla.#{ORG_PREFIX}TrialBalance2__c = '#{trial_balance2}';"
		else
			update_gla_query += "gla.#{ORG_PREFIX}TrialBalance2__c = null;"
		end
		update_gla_query += "Update gla;"
		APEX.execute_commands [update_gla_query];		
end

#set payment plus data new_payment parameter and click next button
def set_payment_plus_data
		SF.tab $tab_new_payment
		gen_wait_until_object_disappear $page_loadmask_message
		page.has_css?($newpay_detail_payment_date)
		NEWPAY.set_payment_date Date.today().strftime("%d/%m/%Y")
		NEWPAY.set_bank_account $bd_bank_account_bristol_checking_account
		NEWPAY.set_payment_media $bd_payment_method_check
		NEWPAY.set_settlement_discount $bd_gla_settlement_discounts_allowed_us
		NEWPAY.set_currency_write_off $bd_gla_write_off_us
		NEWPAY.click_next_button
		gen_wait_until_object $newpay_selecttransactions_retrieveTransButton_dataffid_access
end