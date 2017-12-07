#--------------------------------------------------------------------------------------------#
#	TID :  TID013433 
# 	Pre-Requisit: Org with basedata deployed.
#  	Product Area: Accounting - Budgets & Balances
# 	Story: 24496
#--------------------------------------------------------------------------------------------#

describe "Smoke test: This verify the functionality of budget and balances and merging two accounts.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
	   # Hold Base Data
       FFA.hold_base_data_and_wait
	   gen_start_test "TID013433 - Smoke test: Budget and Balance-Merge Accounts."
	end
	intersect_defination = "INTDEF01"
	account_j_boag_copy = "J Boag Brewingcompany"
	_current_year= (Time.now).year
	_last_year_value = _current_year - 1
	
	it "TID013433 :Budget and Balance." do
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_aus] ,true
		
		puts "TST017178 : Budget and Balance "
		begin
		    # 1.1 intersect definition
			begin
				SF.tab $tab_intersect_definitions
				SF.click_button_new
				ISD.set_intersect_definition_name intersect_defination
				ISD.set_entity_type true
				ISD.set_dimension1_type true
				SF.click_button_save	
				SF.wait_for_search_button
				# Expected Result
				name = ISD.get_intersect_definition_name
				gen_compare name , intersect_defination , "Expeced: return name should match with created name"
			end
			
			# 1.2 Account 
			begin
				SF.tab $tab_accounts
				SF.click_button_new
				Account.set_account_name  account_j_boag_copy
				Account.set_account_phone "36362 6300"
				Account.select_account_type "Other"
				Account.set_bank_account_name "Commonwealth"
				Account.set_bank_name "Commonwealth"
				Account.set_bank_sort_code "111"
				Account.set_bank_account_number "111"
				Account.set_bank_swift_number "111"
				Account.set_bank_iban_number "111"
				Account.set_account_trading_currency $bd_currency_aud
				Account.set_accounts_payable_control $bd_gla_account_payable_control_aud
				Account.set_accounts_receivable_control $bd_gla_account_receivable_control_aud
				Account.set_billing_street "39 William Street" 
				Account.set_billing_city "Launceston"
				Account.set_billing_state_province "TAS"
				Account.set_billing_country  "AUS" 
				SF.click_button_save
				SF.wait_for_search_button
				# Expected Result ccount should be saved
				name =  Account.get_account_name
				gen_include account_j_boag_copy , name , "Expeced: return name should match with created name"
			end
			# Create  Budget and balance
			begin
				SF.tab $tab_budgets_and_balances
				SF.click_button_new
				BBL.set_year _last_year_value.to_s , $company_merlin_auto_aus
				BBL.set_intersect_definition intersect_defination
				BBL.set_brought_forward_budget "400000"
				BBL.set_brought_forward_actual "5200"
				BBL.set_account  $bd_account_jboag_brewing
				BBL.set_dimension1_value $bd_dimension_queensland

				BBL.set_budget_period_amount  $budget_and_balances_budget_period_001_label , "1000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_002_label , "1000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_003_label , "1000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_004_label , "1000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_005_label , "1000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_006_label , "1000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_007_label , "2000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_008_label , "2000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_009_label , "2000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_010_label , "2000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_011_label , "2000"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_012_label , "2000"
				SF.click_button_save
				
		        # Expected Result
				budget_number1 = BBL.get_budget_number
				gen_include 'BUD', budget_number1 , "Expeced:Budget number should have prefix: BUD"	
			end
			
			#Budget and balance 2
			begin
				SF.tab $tab_budgets_and_balances
				SF.click_button_new
				BBL.set_year _last_year_value.to_s , $company_merlin_auto_aus
				BBL.set_intersect_definition intersect_defination
				BBL.set_brought_forward_budget "900000"
				BBL.set_brought_forward_actual "4800"
				BBL.set_account  account_j_boag_copy
				BBL.set_dimension1_value $bd_dim1_tasmania

				BBL.set_budget_period_amount  $budget_and_balances_budget_period_001_label , "555"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_002_label , "555"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_003_label , "555"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_004_label , "555"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_005_label , "555"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_006_label , "555"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_007_label , "666"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_008_label , "666"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_009_label , "666"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_010_label , "666"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_011_label , "666"
				BBL.set_budget_period_amount  $budget_and_balances_budget_period_012_label , "666"
				SF.click_button_save
				SF.wait_for_search_button
				budget_number2 = BBL.get_budget_number
				gen_include 'BUD', budget_number2 , "Expeced:Budget number should have prefix: BUD"	
			end
			
			# 1.3 Sales invocie
			begin
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account account_j_boag_copy
				FFA.click_account_toggle_icon
				SIN.set_account_dimension  $sin_dimension_1_label, $bd_dim1_tasmania
				FFA.click_account_toggle_icon
				SIN.set_invoice_date "16/01/"+_last_year_value.to_s
				SIN.set_currency_dual_rate "0.56"
				
				SIN.add_line 1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , "20" , "89.40" , "GST-Sales" , nil, nil
				SIN.add_line 2 , $bd_product_bbk_fuel_pump_power_plus_series_universal , "20" , "205.80" , "GST-Sales" ,nil, nil
				FFA.click_save_post
				
				#expected Result
				invoice_status = SIN.get_status
				gen_compare $bd_document_status_complete , invoice_status , "Expected Invoice Status to be Complete"
				sales_invoice_number = SIN.get_invoice_number
				transaction_number = SIN.get_transaction_number
				gen_include 'TRN', transaction_number , "Expeced:Transaction number should have prefix: TRN"
			end
			# 1.4 convert invoice into credit note
			begin
		    	SF.tab $tab_sales_invoices
				SF.click_button_go
			    SIN.open_invoice_detail_page sales_invoice_number
				SIN.click_connvert_to_credit_note_button
				SF.click_button_edit
				SCR.set_creditnote_date "30/01/"+_last_year_value.to_s
				SCR.line_set_quantity 1 , '1'
				SCR.line_set_quantity 2 , '1'
				SF.click_button_save
				SCR.click_post_match_credit_note
				page.has_text?("Complete")
				matched_status = SCR.expect_successful_matching_msg
				gen_compare true , matched_status , "Expected credit note Status to be matched successfully: true"	
				matched_credit_note_number = SCR.get_credit_note_number
				
				# Expected Result 
				credit_note_status = SCR.get_credit_note_status
				gen_compare $bd_document_status_complete , credit_note_status , "Expected credit note Status to be Complete"	
				transaction_number = SCR.get_transaction_number
				gen_include 'TRN', transaction_number , "Expeced:Transaction number should have prefix: TRN"
			end
			#1.5 create credit note
			begin
			    SF.tab $tab_sales_credit_notes
				SF.wait_for_search_button
				SF.click_button_new
				SCR.set_account account_j_boag_copy
				FFA.click_account_toggle_icon
				SCR.set_account_dimension $scn_dimension_1_label, $bd_dim1_tasmania
				FFA.click_account_toggle_icon
				SCR.set_creditnote_date "31/01/"+_last_year_value.to_s
				SCR.set_currency_dual_rate "0.56"
				SCR.add_line 1 , $bd_product_bbk_fuel_pump_power_plus_series_universal , "19" , "20" , "GST-Sales" ,nil
				FFA.click_save_post
				credit_note_number = SCR.get_credit_note_number
				credit_note_total = SCR.get_credit_note_total
				
				# Expected Result 
				gen_include credit_note_total, '$418.00' , "Expeced:Credit note total: $418.00"
				credit_note_status = SCR.get_credit_note_status
				gen_compare $bd_document_status_complete , credit_note_status , "Expected credit note Status to be Complete"	
				transaction_number = SCR.get_transaction_number
				gen_include 'TRN', transaction_number , "Expeced:Transaction number should have prefix: TRN"
			end
			
			# Merge Account
			begin
				SF.tab $tab_merge_accounts
				MA.set_master_account $bd_account_jboag_brewing
				MA.set_merge1_account account_j_boag_copy
				MA.click_run_button
				MA.confirm_button
				# Expected
				expect(page).to have_content($ma_merge_account_message)
				gen_report_test "Expected a successfull message on page for merging the accounts-> " + $ma_merge_account_message	
				SF.wait_for_apex_job
				# Assert account merge Id
				SF.tab $tab_accounts
				SF.click_button_go
				Account.view_account $bd_account_jboag_brewing
				merge_id_account1 = Account.get_merge_id

				SF.tab $tab_accounts
				SF.click_button_go
				Account.view_account account_j_boag_copy
				merge_id_account2 = Account.get_merge_id
				# Expected
				gen_compare  merge_id_account1, merge_id_account2 , "Merge Id for both account should be same"

				#Sales Invoice
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page sales_invoice_number
				SIN.click_transaction_number
				TRANX.click_on_account_line_item
				account_value = TRANX.get_account_line_item_account_value
				gen_compare  account_value, account_j_boag_copy , "Account line Item account Expected:J Boag Brewing COPY "
				
				#first credit note converted from invoice
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page matched_credit_note_number
				SIN.click_transaction_number
				TRANX.click_on_account_line_item
				account_value = TRANX.get_account_line_item_account_value
				gen_compare  account_value, account_j_boag_copy , "Account line Item account Expected:J Boag Brewing COPY "
				
				#second credit note 
				SF.tab $tab_sales_credit_notes
				SF.click_button_go
				SIN.open_invoice_detail_page credit_note_number
				SIN.click_transaction_number
				TRANX.click_on_account_line_item
				account_value = TRANX.get_account_line_item_account_value
				gen_compare  account_value, account_j_boag_copy , "Account line Item account Expected:J Boag Brewing COPY "
			end	
			#1.9
			begin
				SF.tab $tab_accounts
				Account.click_merge_account
				Account.set_find_account $bd_account_jboag_brewing
				Account.click_find_account
				Account.click_next
				Account.click_button_merge
				gen_alert_ok
				SF.wait_for_apex_job
				
				#expected
				SF.tab $tab_accounts
				SF.click_button_go
				deleted_status = Account.check_is_account_deleted account_j_boag_copy
				gen_compare  true, deleted_status , "Respected account should be should be deleted : true"
			end
			
			#1.10
			begin
				SF.tab $tab_budgets_and_balances
				SF.select_view $bd_select_view_all
				SF.click_button_go
				account_presence_status = page.has_text?(account_j_boag_copy)
				gen_compare  false, account_presence_status , "Account should be deleted , Expected : false"
			end
			
			#1.11
			begin
				SF.tab $tab_balance_update
				BALUPDATE.click_tab_balance_update_for_merged_accounts
				BALUPDATE.set_master_account $bd_account_jboag_brewing
				BALUPDATE.click_run_merge_account_button
				SF.wait_for_apex_job
				
				#Expected Result
				SF.tab $tab_budgets_and_balances
				SF.click_button_go
				BBL.open_budget_and_balance_detail_page budget_number1
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_001_label  
				gen_compare  period_value, '1,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_002_label  
				gen_compare  period_value, '1,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_003_label  
				gen_compare  period_value, '1,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_004_label  
				gen_compare  period_value, '1,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_005_label   
				gen_compare  period_value, '1,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_006_label   
				gen_compare  period_value, '1,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_007_label   
				gen_compare  period_value, '2,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_008_label  
				gen_compare  period_value, '2,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_009_label   
				gen_compare  period_value, '2,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_010_label   
				gen_compare  period_value, '2,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_011_label   
				gen_compare  period_value, '2,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_012_label   
				gen_compare  period_value, '2,000.00' , "Period value should be matched  Expected: 1,000.00"
				
				budget_forward_value  = BBL.get_budget_brought_budget_forward_value
				gen_compare  budget_forward_value, '400,000.00' , "Brought Budget forward value Expected: 400,000.00"
				
				budget_forward_actual  = BBL.get_budget_brought_forward_actual_value
				gen_compare  budget_forward_actual, '5,200.00' , "Brought Budget Actual value Expected: 5,200.00"
				
				#For second recent budget-
				SF.tab $tab_budgets_and_balances
				SF.click_button_go
				BBL.open_budget_and_balance_detail_page budget_number2
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_001_label    
				gen_compare  period_value, '555.00' , "Period value should be matched  Expected: 555.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_002_label  
				gen_compare  period_value, '555.00' , "Period value should be matched  Expected: 555.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_003_label  
				gen_compare  period_value, '555.00' , "Period value should be matched  Expected: 555.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_004_label  
				gen_compare  period_value, '555.00' , "Period value should be matched  Expected: 555.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_005_label  
				gen_compare  period_value, '555.00' , "Period value should be matched  Expected: 555.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_006_label  
				gen_compare  period_value, '555.00' , "Period value should be matched  Expected: 555.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_007_label  
				gen_compare  period_value, '666.00' , "Period value should be matched  Expected: 666.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_008_label 
				gen_compare  period_value, '666.00' , "Period value should be matched  Expected: 666.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_009_label  
				gen_compare  period_value, '666.00' , "Period value should be matched  Expected: 666.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_010_label  
				gen_compare  period_value, '666.00' , "Period value should be matched  Expected: 666.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_011_label  
				gen_compare  period_value, '666.00' , "Period value should be matched  Expected: 666.00"
				
				period_value = BBL.get_budget_period_value $budget_and_balances_budget_period_012_label  
				gen_compare  period_value, '666.00' , "Period value should be matched  Expected: 666.00"
				
				budget_forward_value  = BBL.get_budget_brought_budget_forward_value
				gen_compare  budget_forward_value, '900,000.00' , "Brought Budget forward value Expected:900,000.00"
				
				budget_forward_actual  = BBL.get_budget_brought_forward_actual_value
				gen_compare  budget_forward_actual, '4,800.00' , "Brought Budget Actual value Expected: 4,800.00"
			end				
		end
	end
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID013433 - Smoke test: Budget and Balance-Merge Accounts"
		SF.logout
	end
end