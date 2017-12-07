
#--------------------------------------------------------------------#
#	TID : TID021704
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Accounting - Allocations
#--------------------------------------------------------------------#

describe "TID021704-Smoke Test - Verify fixed and variable allocation process", :type => :request do

include_context "login"
include_context "logout_after_each"
#variables 
_value_10_33 = "10.33"
_value_10_25 = "10.25"
_value_10_14 = "10.14"
_value_10_00 = "10"
_value_10_05 = "10.05"
_value_10_06 = "10.06"
_value_10_34 = "10.34"
_value_10_26 = "10.26"
_value_10_15 = "10.15"
_value_10_01 = "10.01"
_value_100 = "100.0"
_allocation_name_smoke_fixed_rule = "Smoke fixed rule"
_allocation_rule_description = "Created for smoke testing"
_smoke_variable = "Smoke Variable"
_variable_allocation_rule_description = _allocation_rule_description
_value_7_6923 = "7.6923"
_value_7_6924 = "7.6924"
_value_100_percent = "100"
_statistical_basis_name = "Smoke basis"
_statistical_basis_date = Date.today
_statistical_basis_period = FFA.get_period_by_date _statistical_basis_date
_statistical_basis_description = _allocation_rule_description
_current_day = (Date.today).strftime("%d/%m/%Y")
_current_period = FFA.get_current_period
_next_period = FFA.get_period_by_date Date.today >> 1
_document_type_journals = "Journals"
_posting_period = FFA.get_period_by_date (Date.today + 60)
_posting_date =(Date.today + 60).strftime("%d/%m/%Y")
_template_name2 = "Template 2"
_template_description ="single Company template"
_amount_value_100 = "€(100.00)"
_warning_message_screen = "You have edited the selected allocation rule, but have not saved your changes. Click Yes to update the rule. Click No to use the edited rule details for this allocation only and leave the original allocation rule unchanged."
_destination_document_description = "Its a smoke test"
_template_name1 = "Template 1"
_template1_description = "Multi-Company template"
_allocation_method_value_variable = "Variable > Statistical"
_amount_value_344_34 = "$(344.34)"
_amount_value_134_40 = "€(134.40)"
_account_c_woermann_kg = "C.Woermann GmbH & Co. KG"
_name_space_name= ORG_PREFIX.gsub("__", ".").sub(" ","") 
_file_path = $upload_file_path[1,$upload_file_path.length] 
_csv_file_name = "allocationSmokeTest.csv"
_gla_col_index = "0"
_dim1_col_index = "1"
_dim2_col_index = "2"
_dim3_col_index = "3"
_dim4_col_index = "4"
template_success = FFA.fetch_label 'AllocationSaveTemplateSuccess'
_glas_copied_from_source = "Copied from Source"
_glas_copied_from_basis = "Copied from Basis"
_document_type_transactions = "Transactions"
_source_company_label = "Source Company"

	before :all do	
	
		# gen_start_test "Verify fixed and variable allocation process."
		# FFA.hold_base_data_and_wait
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		#delete CSV file
		gen_remove_file _file_path +_csv_file_name
		gen_end_test "Intercompany Smoke Test"
		#SF.logout
		
		begin

			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			#Make sure the following accounts exists:
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			page.has_text?($bd_intercompany_spain_account)
			gen_click_link_and_wait $bd_intercompany_spain_account
			page.has_text?($bd_intercompany_spain_account)
			SF.click_button_edit
			Account.set_account_trading_currency $bd_currency_eur
			SF.click_button_save
			SF.wait_for_search_button
			
			SF.tab $tab_companies
			SF.select_view $bd_select_view_all
			SF.click_button_go
			gen_click_link_and_wait $company_merlin_auto_spain
			SF.click_button_edit
			Company.set_intercompany_account $bd_intercompany_spain_account
			SF.click_button_save
			SF.wait_for_search_button			
			
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			gen_click_link_and_wait $bd_intercompany_usa_account
			page.has_text?($bd_intercompany_usa_account)
			SF.click_button_edit
			Account.set_account_trading_currency $bd_currency_usd
			SF.click_button_save
			SF.wait_for_search_button
			
			SF.tab $tab_companies
			SF.select_view $bd_select_view_all
			SF.click_button_go
			gen_click_link_and_wait $company_merlin_auto_usa
			SF.click_button_edit
			Company.set_intercompany_account $bd_intercompany_usa_account
			SF.click_button_save
			SF.wait_for_search_button
			
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_usa , $bd_gla_account_receivable_control_gbp, nil , nil , nil,nil ,$bd_gla_accounts_payable_control_eur,nil , nil , nil , nil
			SF.click_button_save
			SF.wait_for_search_button
			gen_compare_objval_not_null ICD.get_intercompany_definition_number, true , "Expected Intercompany definition for merlin auto spain  to be created successfully."
						
			#Note: Create all the cash entries of Type - Receipt
			_query_text_1 =  "#{ORG_PREFIX}CODACompany__c originCompany = [select Id,#{ORG_PREFIX}IntercompanyAccount__c from #{ORG_PREFIX}CODACompany__c where Name = '#{$company_merlin_auto_spain}'];"
			_query_text_1 += "#{ORG_PREFIX}CODABankAccount__c bankAccountSantandar = [select Id from #{ORG_PREFIX}CODABankAccount__c where Name = '#{$bd_bank_account_santander_current_account}' and #{ORG_PREFIX}OwnerCompany__c =: originCompany.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAPeriod__c period = [select Id from #{ORG_PREFIX}CODAPeriod__c where #{ORG_PREFIX}StartDate__c <= :System.today() and #{ORG_PREFIX}EndDate__c >= :System.today() and #{ORG_PREFIX}OwnerCompany__c =: originCompany.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAPeriod__c nextPeriod = [select Id from #{ORG_PREFIX}CODAPeriod__c where #{ORG_PREFIX}StartDate__c <= :System.today().addMonths(1) and #{ORG_PREFIX}EndDate__c >= :System.today().addMonths(1)  and #{ORG_PREFIX}OwnerCompany__c =: originCompany.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAAccountingCurrency__c currUSD = [select Id from #{ORG_PREFIX}CODAAccountingCurrency__c where Name = 'USD' and #{ORG_PREFIX}OwnerCompany__c =: originCompany.Id];"
			
			#Cash Entry 2 Create and Post
			_query_cashEntry_1 = "List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry> cashEntryList = new List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry>();"
			_query_cashEntry_1 += "#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry cashEntry1 = new #{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry();"
			_query_cashEntry_1 += "cashEntry1.BankAccount = #{_name_space_name}CODAAPICommon.getRef(bankAccountSantandar.Id,null);"
			_query_cashEntry_1 += "cashEntry1.CashEntryCurrency = #{_name_space_name}CODAAPICommon.getRef(currUSD.Id,null);"
			_query_cashEntry_1 += "cashEntry1.Reference = 'CSH_1';"
			_query_cashEntry_1 += "cashEntry1.DateValue = System.today();"
			_query_cashEntry_1 += "cashEntry1.Period = #{_name_space_name}CODAAPICommon.getRef(period.Id, null);"
			_query_cashEntry_1 += "cashEntry1.Status = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumStatus.InProgress;"
			_query_cashEntry_1 += "cashEntry1.TypeRef = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumType.Receipt;"
			_query_cashEntry_1 += "cashEntry1.PaymentMethod = 'Cash';"
			_query_cashEntry_1 += "cashEntry1.LineItems = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItems();"
			_query_cashEntry_1 += "cashEntry1.LineItems.LineItemList = new List<#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem>();"
			_query_cashEntry_1 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_1 += "cashlineItem.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_1 += "cashlineItem.Account = #{_name_space_name}CODAAPICommon.getRef(null, '#{_account_c_woermann_kg}');"
			_query_cashEntry_1 += "cashlineItem.CashEntryValue = #{_value_10_33};"
			_query_cashEntry_1 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem);"
			_query_cashEntry_1 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem2 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_1 += "cashlineItem2.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_1 += "cashlineItem2.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_1 += "cashlineItem2.CashEntryValue = #{_value_10_25};"
			_query_cashEntry_1 += "cashlineItem2.AccountDimension1 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_query_cashEntry_1 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem2);"
			_query_cashEntry_1 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem3 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_1 += "cashlineItem3.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_1 += "cashlineItem3.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_1 += "cashlineItem3.CashEntryValue = #{_value_10_14};"
			_query_cashEntry_1 += "cashlineItem3.AccountDimension2 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim2_eur}');"
			_query_cashEntry_1 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem3);"
			_query_cashEntry_1 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem4 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_1 += "cashlineItem4.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_1 += "cashlineItem4.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_1 += "cashlineItem4.CashEntryValue = #{_value_10_05};"
			_query_cashEntry_1 += "cashlineItem4.AccountDimension3 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim3_eur}');"
			_query_cashEntry_1 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem4);"
			_query_cashEntry_1 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem5=new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_1 += "cashlineItem5.AccountPaymentMethod='Cash';"
			_query_cashEntry_1 += "cashlineItem5.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_fastfit_ltd}');"
			_query_cashEntry_1 += "cashlineItem5.CashEntryValue = #{_value_10_00};"
			_query_cashEntry_1 += "cashlineItem5.AccountDimension4 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim4_eur}');"
			_query_cashEntry_1 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem5);"	
			_query_cashEntry_1 += "cashEntryList.add(cashEntry1);"
			_query_cashEntry_1 += "List<#{_name_space_name}CODAAPICommon.Reference> refCashCreate = #{_name_space_name}CODAAPICashEntry_7_0.BulkCreateCashEntry(null,cashEntryList);"
			_query_cashEntry_1 += "#{_name_space_name}CODAAPICashEntry_7_0.BulkPostCashEntry(null, refCashCreate);"
			APEX.execute_commands [_query_text_1 + _query_cashEntry_1]
			
			#Cash Entry 2 Create and Post
			_query_cashEntry_2 = "List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry> cashEntryList = new List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry>();"
			_query_cashEntry_2 += "#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry cashEntry1 = new #{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry();"
			_query_cashEntry_2 += "cashEntry1.BankAccount = #{_name_space_name}CODAAPICommon.getRef(bankAccountSantandar.Id,null);"
			_query_cashEntry_2 += "cashEntry1.CashEntryCurrency = #{_name_space_name}CODAAPICommon.getRef(currUSD.Id,null);"
			_query_cashEntry_2 += "cashEntry1.Reference = 'CSH_2';"
			_query_cashEntry_2 += "cashEntry1.DateValue = System.today().addMonths(1);"
			_query_cashEntry_2 += "cashEntry1.Period = #{_name_space_name}CODAAPICommon.getRef(nextPeriod.Id, null);"
			_query_cashEntry_2 += "cashEntry1.Status = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumStatus.InProgress;"
			_query_cashEntry_2 += "cashEntry1.TypeRef = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumType.Receipt;"
			_query_cashEntry_2 += "cashEntry1.PaymentMethod = 'Cash';"
			_query_cashEntry_2 += "cashEntry1.LineItems = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItems();"
			_query_cashEntry_2 += "cashEntry1.LineItems.LineItemList = new List<#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem>();"
			_query_cashEntry_2 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_2 += "cashlineItem.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_2 += "cashlineItem.Account = #{_name_space_name}CODAAPICommon.getRef(null, '#{_account_c_woermann_kg}');"
			_query_cashEntry_2 += "cashlineItem.CashEntryValue = #{_value_10_34};"
			_query_cashEntry_2 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem);"
			_query_cashEntry_2 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem2 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_2 += "cashlineItem2.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_2 += "cashlineItem2.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_2 += "cashlineItem2.CashEntryValue = #{_value_10_26};"
			_query_cashEntry_2 += "cashlineItem2.AccountDimension1 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_query_cashEntry_2 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem2);"
			_query_cashEntry_2 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem3 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_2 += "cashlineItem3.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_2 += "cashlineItem3.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_2 += "cashlineItem3.CashEntryValue = #{_value_10_15};"
			_query_cashEntry_2 += "cashlineItem3.AccountDimension2 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim2_eur}');"
			_query_cashEntry_2 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem3);"
			_query_cashEntry_2 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem4 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_2 += "cashlineItem4.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_2 += "cashlineItem4.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_2 += "cashlineItem4.CashEntryValue = #{_value_10_06};"
			_query_cashEntry_2 += "cashlineItem4.AccountDimension3 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim3_eur}');"
			_query_cashEntry_2 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem4);"
			_query_cashEntry_2 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem5=new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_2 += "cashlineItem5.AccountPaymentMethod='Cash';"
			_query_cashEntry_2 += "cashlineItem5.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_fastfit_ltd}');"
			_query_cashEntry_2 += "cashlineItem5.CashEntryValue = #{_value_10_01};"
			_query_cashEntry_2 += "cashlineItem5.AccountDimension4 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim4_eur}');"
			_query_cashEntry_2 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem5);"	
			_query_cashEntry_2 += "cashEntryList.add(cashEntry1);"
			_query_cashEntry_2 += "List<#{_name_space_name}CODAAPICommon.Reference> refCashCreate = #{_name_space_name}CODAAPICashEntry_7_0.BulkCreateCashEntry(null,cashEntryList);"
			_query_cashEntry_2 += "#{_name_space_name}CODAAPICashEntry_7_0.BulkPostCashEntry(null, refCashCreate);"
			APEX.execute_commands [_query_text_1 + _query_cashEntry_2]
			
			_query_cashEntry_3 = "List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry> cashEntryList = new List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry>();"
			_query_cashEntry_3 += "#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry cashEntry1 = new #{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry();"
			_query_cashEntry_3 += "cashEntry1.BankAccount = #{_name_space_name}CODAAPICommon.getRef(bankAccountSantandar.Id,null);"
			_query_cashEntry_3 += "cashEntry1.CashEntryCurrency = #{_name_space_name}CODAAPICommon.getRef(currUSD.Id,null);"
			_query_cashEntry_3 += "cashEntry1.Reference = 'CSH_6';"
			_query_cashEntry_3 += "cashEntry1.DateValue = System.today();"
			_query_cashEntry_3 += "cashEntry1.Period = #{_name_space_name}CODAAPICommon.getRef(period.Id, null);"
			_query_cashEntry_3 += "cashEntry1.Status = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumStatus.InProgress;"
			_query_cashEntry_3 += "cashEntry1.TypeRef = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumType.Receipt;"
			_query_cashEntry_3 += "cashEntry1.PaymentMethod = 'Cash';"
			_query_cashEntry_3 += "cashEntry1.LineItems = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItems();"
			_query_cashEntry_3 += "cashEntry1.LineItems.LineItemList = new List<#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem>();"
			_query_cashEntry_3 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_3 += "cashlineItem.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_3 += "cashlineItem.Account = #{_name_space_name}CODAAPICommon.getRef(null, '#{$bd_intercompany_usa_account}');"
			_query_cashEntry_3 += "cashlineItem.CashEntryValue = #{_value_100};"
			_query_cashEntry_3 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem);"
			_query_cashEntry_3 += "cashEntryList.add(cashEntry1);"
			_query_cashEntry_3 += "List<#{_name_space_name}CODAAPICommon.Reference> refCashCreate3 = #{_name_space_name}CODAAPICashEntry_7_0.BulkCreateCashEntry(null, cashEntryList);"
			_query_cashEntry_3 += "#{_name_space_name}CODAAPICashEntry_7_0.BulkPostCashEntry(null, refCashCreate3);"
			APEX.execute_commands [_query_text_1 + _query_cashEntry_3]
						
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_aus] ,true
			
			#Note: Create all the cash entries of Type - Receipt
			_query_text_1 =  "#{ORG_PREFIX}CODACompany__c originCompanyAus = [select Id,#{ORG_PREFIX}IntercompanyAccount__c from #{ORG_PREFIX}CODACompany__c where Name = '#{$company_merlin_auto_aus}'];"
			_query_text_1 += "#{ORG_PREFIX}CODABankAccount__c bankAccountCommonWealth = [select Id from #{ORG_PREFIX}CODABankAccount__c where Name = '#{$bd_bank_account_commonwealth_current_account}' and #{ORG_PREFIX}OwnerCompany__c =: originCompanyAus.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAPeriod__c period = [select Id from #{ORG_PREFIX}CODAPeriod__c where #{ORG_PREFIX}StartDate__c <= :System.today() and #{ORG_PREFIX}EndDate__c >= :System.today() and #{ORG_PREFIX}OwnerCompany__c =: originCompanyAus.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAPeriod__c nextPeriod = [select Id from #{ORG_PREFIX}CODAPeriod__c where #{ORG_PREFIX}StartDate__c <= :System.today().addMonths(1) and #{ORG_PREFIX}EndDate__c >= :System.today().addMonths(1)  and #{ORG_PREFIX}OwnerCompany__c =: originCompanyAus.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAAccountingCurrency__c currUSD = [select Id from #{ORG_PREFIX}CODAAccountingCurrency__c where Name = 'USD' and #{ORG_PREFIX}OwnerCompany__c =: originCompanyAus.Id];"
						
			#Cash Entry 2 Create and Post
			_query_cashEntry_4 = "List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry> cashEntryList = new List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry>();"
			_query_cashEntry_4 += "#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry cashEntry1 = new #{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry();"
			_query_cashEntry_4 += "cashEntry1.BankAccount = #{_name_space_name}CODAAPICommon.getRef(bankAccountCommonWealth.Id, null);"
			_query_cashEntry_4 += "cashEntry1.CashEntryCurrency = #{_name_space_name}CODAAPICommon.getRef(currUSD.Id, null);"
			_query_cashEntry_4 += "cashEntry1.Reference = 'CSH_3';"
			_query_cashEntry_4 += "cashEntry1.DateValue = System.today();"
			_query_cashEntry_4 += "cashEntry1.Period = #{_name_space_name}CODAAPICommon.getRef(period.Id, null);"
			_query_cashEntry_4 += "cashEntry1.Status = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumStatus.InProgress;"
			_query_cashEntry_4 += "cashEntry1.TypeRef = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumType.Receipt;"
			_query_cashEntry_4 += "cashEntry1.PaymentMethod = 'Cash';"
			_query_cashEntry_4 += "cashEntry1.LineItems = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItems();"
			_query_cashEntry_4 += "cashEntry1.LineItems.LineItemList = new List<#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem>();"
			_query_cashEntry_4 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_4 += "cashlineItem.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_4 += "cashlineItem.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_4 += "cashlineItem.CashEntryValue = #{_value_10_33};"
			_query_cashEntry_4 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem);"
			_query_cashEntry_4 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem2 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_4 += "cashlineItem2.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_4 += "cashlineItem2.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_4 += "cashlineItem2.CashEntryValue = #{_value_10_25};"
			_query_cashEntry_4 += "cashlineItem2.AccountDimension1 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_query_cashEntry_4 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem2);"
			_query_cashEntry_4 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem3 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_4 += "cashlineItem3.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_4 += "cashlineItem3.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_4 += "cashlineItem3.CashEntryValue = #{_value_10_14};"
			_query_cashEntry_4 += "cashlineItem3.AccountDimension2 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim2_eur}');"
			_query_cashEntry_4 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem3);"
			_query_cashEntry_4 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem4 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_4 += "cashlineItem4.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_4 += "cashlineItem4.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_4 += "cashlineItem4.CashEntryValue = #{_value_10_05};"
			_query_cashEntry_4 += "cashlineItem4.AccountDimension3 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim3_eur}');"
			_query_cashEntry_4 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem4);"
			_query_cashEntry_4 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem5 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_4 += "cashlineItem5.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_4 += "cashlineItem5.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_fastfit_ltd}');"
			_query_cashEntry_4 += "cashlineItem5.CashEntryValue = #{_value_10_00};"
			_query_cashEntry_4 += "cashlineItem5.AccountDimension4 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim4_eur}');"
			_query_cashEntry_4 += "cashEntry1.LineItems.LineItemlist.add(cashlineItem5);"	
			_query_cashEntry_4 += "cashEntryList.add(cashEntry1);"
			_query_cashEntry_4 += "List<#{_name_space_name}CODAAPICommon.Reference> refCashCreate = #{_name_space_name}CODAAPICashEntry_7_0.BulkCreateCashEntry(null, cashEntryList);"
			_query_cashEntry_4 += "#{_name_space_name}CODAAPICashEntry_7_0.BulkPostCashEntry(null, refCashCreate);"
			APEX.execute_commands [_query_text_1 + _query_cashEntry_4]
			
			#Cash Entry 2 Create and Post
			_query_cashEntry_5 = "List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry> cashEntryList = new List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry>();"
			_query_cashEntry_5 += "#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry cashEntry2 = new #{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry();"
			_query_cashEntry_5 += "cashEntry2.BankAccount = #{_name_space_name}CODAAPICommon.getRef(bankAccountCommonWealth.Id, null);"
			_query_cashEntry_5 += "cashEntry2.CashEntryCurrency = #{_name_space_name}CODAAPICommon.getRef(currUSD.Id, null);"
			_query_cashEntry_5 += "cashEntry2.Reference = 'CSH_4';"
			_query_cashEntry_5 += "cashEntry2.DateValue = System.today().addMonths(1);"
			_query_cashEntry_5 += "cashEntry2.Period = #{_name_space_name}CODAAPICommon.getRef(nextPeriod.Id, null);"
			_query_cashEntry_5 += "cashEntry2.Status = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumStatus.InProgress;"
			_query_cashEntry_5 += "cashEntry2.TypeRef = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumType.Receipt;"
			_query_cashEntry_5 += "cashEntry2.PaymentMethod = 'Cash';"
			_query_cashEntry_5 += "cashEntry2.LineItems = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItems();"
			_query_cashEntry_5 += "cashEntry2.LineItems.LineItemList = new List<#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem>();"
			_query_cashEntry_5 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_5 += "cashlineItem.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_5 += "cashlineItem.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_5 += "cashlineItem.CashEntryValue = #{_value_10_34};"
			_query_cashEntry_5 += "cashEntry2.LineItems.LineItemlist.add(cashlineItem);"
			_query_cashEntry_5 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem2 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_5 += "cashlineItem2.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_5 += "cashlineItem2.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_5 += "cashlineItem2.CashEntryValue = #{_value_10_26};"
			_query_cashEntry_5 += "cashlineItem2.AccountDimension1 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_query_cashEntry_5 += "cashEntry2.LineItems.LineItemlist.add(cashlineItem2);"
			_query_cashEntry_5 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem3 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_5 += "cashlineItem3.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_5 += "cashlineItem3.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_5 += "cashlineItem3.CashEntryValue = #{_value_10_15};"
			_query_cashEntry_5 += "cashlineItem3.AccountDimension2 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim2_eur}');"
			_query_cashEntry_5 += "cashEntry2.LineItems.LineItemlist.add(cashlineItem3);"
			_query_cashEntry_5 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem4 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_5 += "cashlineItem4.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_5 += "cashlineItem4.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_algernon_partners_co}');"
			_query_cashEntry_5 += "cashlineItem4.CashEntryValue = #{_value_10_06};"
			_query_cashEntry_5 += "cashlineItem4.AccountDimension3 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim3_eur}');"
			_query_cashEntry_5 += "cashEntry2.LineItems.LineItemlist.add(cashlineItem4);"
			_query_cashEntry_5 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem5 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_5 += "cashlineItem5.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_5 += "cashlineItem5.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_account_fastfit_ltd}');"
			_query_cashEntry_5 += "cashlineItem5.CashEntryValue = #{_value_10_01};"
			_query_cashEntry_5 += "cashlineItem5.AccountDimension4 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim4_eur}');"
			_query_cashEntry_5 += "cashEntry2.LineItems.LineItemlist.add(cashlineItem5);"	
			_query_cashEntry_5 += "cashEntryList.add(cashEntry2);"
			_query_cashEntry_5 += "List<#{_name_space_name}CODAAPICommon.Reference> refCashCreate2 = #{_name_space_name}CODAAPICashEntry_7_0.BulkCreateCashEntry(null, cashEntryList);"
			_query_cashEntry_5 += "#{_name_space_name}CODAAPICashEntry_7_0.BulkPostCashEntry(null, refCashCreate2);"
			APEX.execute_commands [_query_text_1 + _query_cashEntry_5]
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			SF.tab $tab_intercompany_definitions
			SF.click_button_new
			ICD.createInterCompanyDefnition $company_merlin_auto_spain , $bd_gla_account_receivable_control_eur, nil , nil , nil,nil ,$bd_gla_accounts_payable_control_gbp,nil , nil , nil , nil
			SF.click_button_save
			SF.wait_for_search_button
			gen_compare_objval_not_null ICD.get_intercompany_definition_number, true , "Expected Intercompany definition for merlin auto usa  to be created successfully."
						
			#Note: Create all the cash entries of Type - Receipt
			_query_text_1 =  "#{ORG_PREFIX}CODACompany__c originCompanyUsa = [select Id,#{ORG_PREFIX}IntercompanyAccount__c from #{ORG_PREFIX}CODACompany__c where Name = '#{$company_merlin_auto_usa}'];"
			_query_text_1 += "#{ORG_PREFIX}CODABankAccount__c bankAccountBristolchecking = [select Id from #{ORG_PREFIX}CODABankAccount__c where Name = '#{$bd_bank_account_bristol_checking_account}' and #{ORG_PREFIX}OwnerCompany__c =: originCompanyUsa.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAPeriod__c period = [select Id from #{ORG_PREFIX}CODAPeriod__c where #{ORG_PREFIX}StartDate__c <= :System.today() and #{ORG_PREFIX}EndDate__c >= :System.today() and #{ORG_PREFIX}OwnerCompany__c =: originCompanyUsa.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAPeriod__c nextPeriod = [select Id from #{ORG_PREFIX}CODAPeriod__c where #{ORG_PREFIX}StartDate__c <= :System.today().addMonths(1) and #{ORG_PREFIX}EndDate__c >= :System.today().addMonths(1)  and #{ORG_PREFIX}OwnerCompany__c =: originCompanyUsa.Id];"
			_query_text_1 += "#{ORG_PREFIX}CODAAccountingCurrency__c currGBP = [select Id from #{ORG_PREFIX}CODAAccountingCurrency__c where Name = 'GBP' and #{ORG_PREFIX}OwnerCompany__c =: originCompanyUsa.Id];"
			
			_query_cashEntry_6 = "List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry> cashEntryList = new List<#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry>();"
			_query_cashEntry_6 += "#{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry cashEntry3 = new #{_name_space_name}CODAAPICashEntryTypes_7_0.CashEntry();"
			_query_cashEntry_6 += "cashEntry3.BankAccount = #{_name_space_name}CODAAPICommon.getRef(bankAccountBristolchecking.Id, null);"
			_query_cashEntry_6 += "cashEntry3.CashEntryCurrency = #{_name_space_name}CODAAPICommon.getRef(currGBP.Id, null);"
			_query_cashEntry_6 += "cashEntry3.Reference = 'CSH_5';"
			_query_cashEntry_6 += "cashEntry3.DateValue = System.today();"
			_query_cashEntry_6 += "cashEntry3.Period = #{_name_space_name}CODAAPICommon.getRef(period.Id, null);"
			_query_cashEntry_6 += "cashEntry3.Status = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumStatus.InProgress;"
			_query_cashEntry_6 += "cashEntry3.TypeRef = #{_name_space_name}CODAAPICashEntryTypes_7_0.enumType.Receipt;"
			_query_cashEntry_6 += "cashEntry3.PaymentMethod = 'Cash';"

			_query_cashEntry_6 += "cashEntry3.LineItems = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItems();"
			_query_cashEntry_6 += "cashEntry3.LineItems.LineItemList = new List<#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem>();"
			_query_cashEntry_6 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_6 += "cashlineItem.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_6 += "cashlineItem.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_6 += "cashlineItem.CashEntryValue = #{_value_10_33};"
			_query_cashEntry_6 += "cashEntry3.LineItems.LineItemlist.add(cashlineItem);"
			
			_query_cashEntry_6 += "#{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem cashlineItem2 = new #{_name_space_name}CODAAPICashEntryLineItemTypes_7_0.CashEntryLineItem();"
			_query_cashEntry_6 += "cashlineItem2.AccountPaymentMethod = 'Cash';"
			_query_cashEntry_6 += "cashlineItem2.Account = #{_name_space_name}CODAAPICommon.getRef(null,'#{_account_c_woermann_kg}');"
			_query_cashEntry_6 += "cashlineItem2.CashEntryValue = #{_value_10_25};"
			_query_cashEntry_6 += "cashlineItem2.AccountDimension1 = #{_name_space_name}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_query_cashEntry_6 += "cashEntry3.LineItems.LineItemlist.add(cashlineItem2);"
			_query_cashEntry_6 += "cashEntryList.add(cashEntry3);"
			_query_cashEntry_6 += "List<#{_name_space_name}CODAAPICommon.Reference> refCashCreate3 = #{_name_space_name}CODAAPICashEntry_7_0.BulkCreateCashEntry(null, cashEntryList);"
			_query_cashEntry_6 += "#{_name_space_name}CODAAPICashEntry_7_0.BulkPostCashEntry(null, refCashCreate3);"
			APEX.execute_commands [_query_text_1 + _query_cashEntry_6]	

			#Modify IC Transfer for CSH_6 and set estination Bank Account to 'Bristol Euros Account'.
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_intercompany_transfers
			SF.select_view $bd_select_view_available
			SF.click_button_go
			FFA.click_edit_link_on_list_gird _source_company_label , $company_merlin_auto_spain
			ICT.set_destination_document_bank_account $bd_bank_account_bristol_checking_account , $company_merlin_auto_usa
			SF.click_button_save	
			#Process it (CSH_7) Go to cash entry generated (CSH_7) and post it
			SF.select_view $bd_select_view_available
			FFA.listview_select_all 
			ICT.click_button_process
			ict_processing_message = FFA.ffa_get_info_message
			gen_include $ffa_msg_ict_process_confirmation , ict_processing_message , "Expected a confirmation message for processing ICT record"
			ICT.click_confirm_ict_process
			SF.wait_for_apex_job
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_cash_entry_number = FFA.get_column_value_in_grid "Account" , $bd_intercompany_spain_account , $label_cashentry_number
			SF.click_link _cash_entry_number	
			FFA.click_post
			gen_compare $bd_document_status_complete , CE.get_cash_entry_status , "Expected cash entry status to be complete"
		
			#User companies for statndard user
			SF.tab $tab_user_companies
			SF.click_button_new
			USERCOMPANY.set_user_name $bd_user_fullname_StandardUser
			USERCOMPANY.set_company_name $company_merlin_auto_spain				
			SF.click_button_save
				
			SF.tab $tab_user_companies
			SF.click_button_new
			USERCOMPANY.set_user_name $bd_user_fullname_StandardUser
			USERCOMPANY.set_company_name $company_merlin_auto_usa				
			SF.click_button_save
				
			SF.tab $tab_user_companies
			SF.click_button_new
			USERCOMPANY.set_user_name $bd_user_fullname_StandardUser
			USERCOMPANY.set_company_name $company_merlin_auto_aus					
			SF.click_button_save

			# # Create CSV for Allocation Rule Import
			# # ------------------------------------------------------------------------
			# # GeneralLedgerAccount__c,Dimension1__c,Dimension2__c,Dimension4__c,Dimension2__c,Value__c
			# # account_receivable_control_eur,#{$bd_dim1_eur},#{$bd_dim2_eur},#{$bd_dim3_eur},#{$bd_dim4_eur}
			# # account_receivable_control_eur,#{$bd_dim1_eur},#{$bd_dim2_eur},#{$bd_dim3_eur},#{$bd_dim4_eur}
			# # account_receivable_control_eur,#{$bd_dim1_eur},#{$bd_dim2_eur},#{$bd_dim3_eur},#{$bd_dim4_eur}
			# # account_receivable_control_eur,#{$bd_dim1_eur},#{$bd_dim2_eur},#{$bd_dim3_eur},#{$bd_dim4_eur}
			# # account_receivable_control_eur,#{$bd_dim1_eur},#{$bd_dim2_eur},#{$bd_dim3_eur},#{$bd_dim4_eur}
			# # account_receivable_control_eur,#{$bd_dim1_eur},#{$bd_dim2_eur},#{$bd_dim3_eur},#{$bd_dim4_eur}
			# # ----------------- total 10 records in CSV ------------------------------------
			_id_column = "Id"
			_file_column_header = "#{ORG_PREFIX}GeneralLedgerAccount__c,#{ORG_PREFIX}Dimension1__c,#{ORG_PREFIX}Dimension2__c,#{ORG_PREFIX}Dimension3__c,#{ORG_PREFIX}Dimension4__c,#{ORG_PREFIX}value__c\n"
			_file_column_values =  "{0},{1},{2},{3},{4},20\n"
			
			_gla_script = "SELECT Id FROM #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name IN ('#{$bd_gla_account_receivable_control_eur}') ORDER BY Name LIMIT 1"
			APEX.execute_soql _gla_script
			_gla_id =  APEX.get_field_value_from_soql_result _id_column
			
			_dim1_script = "SELECT Id FROM #{ORG_PREFIX}codaDimension1__c WHERE Name IN ('#{$bd_dim1_eur}') ORDER BY Name LIMIT 1"
			APEX.execute_soql _dim1_script
			_dim1_id =  APEX.get_field_value_from_soql_result _id_column
			
			_dim2_script = "SELECT Id FROM #{ORG_PREFIX}codaDimension2__c WHERE Name IN ('#{$bd_dim2_eur}') ORDER BY Name LIMIT 1"
			APEX.execute_soql _dim2_script
			_dim2_id =  APEX.get_field_value_from_soql_result _id_column
			
			_dim3_script = "SELECT Id FROM #{ORG_PREFIX}codaDimension3__c WHERE Name IN ('#{$bd_dim3_eur}') ORDER BY Name LIMIT 1"
			APEX.execute_soql _dim3_script
			_dim3_id =  APEX.get_field_value_from_soql_result _id_column
			
			_dim4_script = "SELECT Id FROM #{ORG_PREFIX}codaDimension4__c WHERE Name IN ('#{$bd_dim4_eur}') ORDER BY Name LIMIT 1"
			APEX.execute_soql _dim4_script
			_dim4_id =  APEX.get_field_value_from_soql_result _id_column
			_file_column_values = _file_column_values.gsub("{"+_gla_col_index+"}", _gla_id.to_s)
			_file_column_values = _file_column_values.gsub("{"+_dim1_col_index+"}",_dim1_id.to_s)
			_file_column_values = _file_column_values.gsub("{"+_dim2_col_index+"}",_dim2_id.to_s)
			_file_column_values = _file_column_values.gsub("{"+_dim3_col_index+"}",_dim3_id.to_s)
			_file_column_values = _file_column_values.gsub("{"+_dim4_col_index+"}",_dim4_id.to_s)
			_file_con_temp = _file_column_values	
			for i in 1..9 do
				_file_column_values +=_file_con_temp
			end
			
			##write content to file
			gen_create_file _file_path + _csv_file_name ,_file_column_header + _file_column_values			

		end	

		end	

	it "TST038487-Verify fixed allocation rule process."  do

		gen_start_test "TST038487-Verify fixed allocation rule process."
		_permission_set_list = [$ffa_permission_set_acc_billing_user_companies, $ffa_permission_set_acc_billing_select_company, $ffa_permission_set_acc_billing_allocation_rules_save_edit]
		SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_StandardUser, true
		SF.login_as_user SFSTANDARD_USER
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			SF.tab $tab_allocation_rules
			SF.click_button_new
			AllocationRules.select_rule_type $allocationrules_type_fixed_label
			AllocationRules.set_rule_name _allocation_name_smoke_fixed_rule
			AllocationRules.set_rule_description _allocation_rule_description
			
			#7. All dimensions values of Dimension 1 type should be populated on column.
			AllocationRules.click_fixed_rule_menu_option $allocationrules_dim1_label, $allocationrules_type_populate_all_label
			gen_compare $bd_apex_eur_001 , AllocationRules.get_grid_row_value_by_column(1, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_apex_eur_001}"
			gen_compare $bd_apex_jpy_001 , AllocationRules.get_grid_row_value_by_column(2, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_apex_jpy_001}"
			gen_compare $bd_apex_usd_001 , AllocationRules.get_grid_row_value_by_column(3, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_apex_usd_001}"
			gen_compare $bd_dim1_eur , AllocationRules.get_grid_row_value_by_column(4, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_gbp}"
			gen_compare $bd_dim1_gbp , AllocationRules.get_grid_row_value_by_column(5, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_european}"
			gen_compare $bd_dim1_usd , AllocationRules.get_grid_row_value_by_column(6, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_european}"
			gen_compare $bd_dim1_european , AllocationRules.get_grid_row_value_by_column(7, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_european}"
			gen_compare $bd_dim1_massachusetts , AllocationRules.get_grid_row_value_by_column(8, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_massachusetts}"
			gen_compare $bd_dim1_new_york , AllocationRules.get_grid_row_value_by_column(9, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_new_york}"
			gen_compare $bd_dim1_north , AllocationRules.get_grid_row_value_by_column(10, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_north}"
			gen_compare $bd_dim1_queensland , AllocationRules.get_grid_row_value_by_column(11, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_queensland}"
			gen_compare $bd_dim1_south , AllocationRules.get_grid_row_value_by_column(12, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = #{$bd_dim1_south}"
			gen_compare $bd_tasmania , AllocationRules.get_grid_row_value_by_column(13, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected Dimension 1 = tasmania"
			
			# Give gla value "#{$bd_gla_account_receivable_is}" in all fields on GLA column.
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,1
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,2
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,3
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,4
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,5
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,6
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,7
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,8
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,9
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,10
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,11
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,12
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,13
			
			#1a. Percentage column should be populated with 7.6923 and 7.6924 at one place
			AllocationRules.click_fixed_rule_menu_option $allocationrules_percentage_label, $allocationrules_type_spread_evenly_label
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(1, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 1 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(2, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 2 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(3, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 3 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(4, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 4 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(5, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 5 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(6, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 6 = #{_value_7_6923}"
			gen_include _value_7_6924 , AllocationRules.get_grid_row_value_by_column(7, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 7 = #{_value_7_6924}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(8, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 8 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(9, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 9 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(10, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 10 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(11, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 11 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(12, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 12 = #{_value_7_6923}"
			gen_include _value_7_6923 , AllocationRules.get_grid_row_value_by_column(13, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 13 = #{_value_7_6923}"
			
			#11b. Total percentage should be 100%
			gen_include _value_100_percent , AllocationRules.get_total_percentage, "Expected total percentage is = #{_value_100_percent}"
			AllocationRules.set_is_active_checkbox
			AllocationRules.click_save_button
			#14. Rule should be saved
			gen_compare _allocation_name_smoke_fixed_rule, AllocationRules.get_rule_name, "Allocation Rule Name saved correctly."
				
			AllocationRules.click_edit_button
			AllocationRules.delete_fixed_rule_line 13
			#Line should be removed successfully.
			AllocationRules.set_fixed_rule_line_percentage "15.3846",12
			AllocationRules.click_save_button
			gen_compare _allocation_name_smoke_fixed_rule, AllocationRules.get_rule_name, "Allocation Rule Name updated correctly."
			gen_compare "15.3846" , AllocationRules.get_grid_row_value_by_column_view_page(12, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage 1 = 15.3846"
		end
		SF.logout
		gen_end_test "TST038487-Verify fixed allocation rule process."
		
		gen_start_test "TST038495-Verify Variable allocation rule process."
		_permission_set_list = [$ffa_permission_set_acc_billing_user_companies, $ffa_permission_set_acc_billing_select_company, $ffa_permission_set_acc_billing_statiscal_basis_save_edit]
		SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_StandardUser, true
		SF.login_as_user SFSTANDARD_USER
		begin			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true			
			SF.tab $tab_statistical_value
			SF.click_button_new
			SB.set_statistical_basis_name _statistical_basis_name
			SB.set_date _statistical_basis_date
			SB.set_company $company_merlin_auto_spain
			SB.set_period _statistical_basis_period
			SB.set_description _statistical_basis_description
			SB.set_unit_of_measure $sb_uom_picklist_people_label
			SB.import_csv_file _csv_file_name
			SB.click_button $sb_save_button	
			gen_compare(true, (SB.assert_total_value "Total 200"), "Stastical Basis saved correctly")
						
			SB.click_button $sb_edit_button
			SB.set_line_without_company true, 10, ["Apex Curr Write Off GLA EUR",'',$bd_apex_eur_002,'','',50.00]
			SB.click_button $sb_save_button
			gen_compare(true, (SB.assert_total_value "Total 230"), "Stastical Basis updated correctly")
			gen_end_test "TST038495-Verify Variable allocation rule process."
		end
		
		SF.logout
		login_user
		_permission_set_list = [$ffa_permission_set_acc_billing_user_companies, $ffa_permission_set_acc_billing_select_company, $ffa_permission_set_acc_billing_allocation_rules_save_edit]
		SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_StandardUser, true
		login_user
		SF.login_as_user SFSTANDARD_USER
		begin
			gen_start_test "TST038495-Verify Variable allocation rule process."
			grid_row_text = "#{$bd_gla_account_receivable_control_eur} #{$bd_dim2_eur} 20 8.6957"
			grid_row_edited_text = "Apex Curr Write Off GLA EUR Apex EUR 002 50 21.7391"
			grid_row_text2 = "#{$bd_gla_account_receivable_control_eur} #{$bd_dim2_eur} 20 11.1111"
						
			SF.tab $tab_allocation_rules
			SF.click_button_new
			AllocationRules.select_rule_type $allocationrules_type_variable_label
			AllocationRules.set_rule_name _smoke_variable
			AllocationRules.set_rule_description _variable_allocation_rule_description
			AllocationRules.select_statistical_bases _statistical_basis_name
			AllocationRules.select_distribution_fields [$allocationrules_gla_label,$allocationrules_dim2_label]
			AllocationRules.click_preview_button
			
			gen_compare 10,AllocationRules.get_count_of_grid_rows,"Expected Grid Row Size to be 10"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row1 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(2),"Expected Grid Row2 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(3),"Expected Grid Row3 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(4),"Expected Grid Row4 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(5),"Expected Grid Row5 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(6),"Expected Grid Row6 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(7),"Expected Grid Row7 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(8),"Expected Grid Row8 is displayed"
			gen_compare grid_row_text ,AllocationRules.get_allocation_rule_grid_row(9),"Expected Grid Row9 is displayed"
			gen_compare grid_row_edited_text ,AllocationRules.get_allocation_rule_grid_row(10),"Expected Grid Row10 is displayed"
			
			gen_compare '100',AllocationRules.get_total_percentage,"Expected Total Percentage 100 is displayed"
			gen_compare '230',AllocationRules.get_total_value,"Expected Total Value 230 is displayed"
			
			AllocationRules.click_show_filter_button
			AllocationRules.click_add_filter_button
			AllocationRules.set_filter_values $allocationrules_gla_label,$allocationrules_filter_operator_contains_label,$bd_gla_account_receivable_control_eur
			AllocationRules.click_add_filter_button
			AllocationRules.set_filter_values $allocationrules_dim2_label,$allocationrules_filter_operator_contains_label,$bd_dim2_eur,2
			AllocationRules.click_preview_button
			
			gen_compare 9,AllocationRules.get_count_of_grid_rows,"Expected Grid Row Size to be 9"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(1),"Expected Grid Row1 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(2),"Expected Grid Row2 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(3),"Expected Grid Row3 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(4),"Expected Grid Row4 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(5),"Expected Grid Row5 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(6),"Expected Grid Row6 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(7),"Expected Grid Row7 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(8),"Expected Grid Row8 is displayed"
			gen_compare grid_row_text2 ,AllocationRules.get_allocation_rule_grid_row(9),"Expected Grid Row9 is displayed"

			AllocationRules.set_is_active_checkbox
			AllocationRules.click_save_button
			gen_compare '100',AllocationRules.get_total_percentage,"Expected Total Percentage 100 is displayed"
			gen_compare '180',AllocationRules.get_total_value,"Expected Total Value 180 is displayed"	
			
		end	
		SF.logout
		gen_end_test "TST038495-Verify Variable allocation rule process."

		gen_start_test "TST038564-Verify that in fixed allocation process User is able to Post Journal."
		login_user
		_permission_set_list = [$ffa_permission_set_acc_billing_user_companies, $ffa_permission_set_acc_billing_select_company, $ffa_permission_set_acc_billing_allocations]
		 SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_StandardUser, true
		SF.login_as_user SFSTANDARD_USER
		begin
			new_tab = gen_open_link_in_new_tab $tab_home
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $ffa_msg_loading
			#Set Allocation filter criteria 
			#Allocation filter 1
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.set_timeperiod_period_selection _current_period,_next_period
			#Select the Allocation Method
			Allocations.click_on_next_button
			gen_wait_until_object $alloc_select_variable_allocation_method
			#next screen
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $ffa_msg_loading
			if page.has_css?($alloc_select_variable_allocation_method)
				Allocations.click_on_next_button
			end			
			Allocations.set_rule_name _allocation_name_smoke_fixed_rule
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $ffa_msg_loading
			Allocations.set_destination_document_description _allocation_rule_description
			Allocations.set_destination_document_type_value _document_type_journals
			Allocations.set_destination_date_value _posting_date
			Allocations.set_destination_period_value _posting_period
			#Saving the template
			Allocations.save_template
			gen_assert_disabled $alloc_template_save_popup_save_button
			gen_report_test "Save Template popup save button is disabled"
			Allocations.set_popup_template_name _template_name2
			Allocations.set_popup_template_description _template_description
			Allocations.popup_save_template
			gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'
			gen_report_test "#{_template_name2} created"
			
			#12. Verify the summary panel on right side of Posting Detail screen
			gen_compare _amount_value_134_40,Allocations.get_total_value,"Total Value on right panel is #{_amount_value_134_40}"
			gen_compare $allocationrules_type_fixed_label,Allocations.get_allocation_method ,"Allocation method is fixed"
			#gen_compare _posting_date,Allocations.get_distribution_date ,"Allocation posting date  is fixed"
			gen_compare _posting_period,Allocations.get_distribution_period ,"Allocation period is #{_posting_period}"
			
			expected_preview_grid_lines=["#{$bd_gla_account_receivable_control_eur} 13.78",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 13.67",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim4_eur} 13.34",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim1_usd} #{$bd_dim2_eur} 66.67",				
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim3_eur} 13.41",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim2_eur} 13.53",
				"#{$bd_gla_account_receivable_is} #{$bd_apex_eur_001} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_apex_jpy_001} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_apex_usd_001} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_eur} 10.33",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_gbp} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_usd} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_european} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_massachusetts} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_new_york} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_north} 10.33",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_queensland} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_south} 20.68"]
			CIF.click_toggle_button
			Allocations.click_posting_transaction_lines_preview_panel
			Allocations.click_on_source_section_expand_collapse_button
			Allocations.click_on_distribution_section_expand_collapse_button			
			expect(Allocations.assert_preview_panel_distributed_rows? expected_preview_grid_lines).to eq(true)
			
			Allocations.click_on_back_button
			AllocationRules.set_fixed_rule_line_gla $bd_gla_account_receivable_is,13
			AllocationRules.set_fixed_rule_line_dim1 $bd_dim1_tasmania , 13
			AllocationRules.set_fixed_rule_line_dim2 $bd_apex_eur_002 , 13
			AllocationRules.set_fixed_rule_line_dim3 $bd_apex_eur_003 , 13
			AllocationRules.set_fixed_rule_line_dim4 $bd_apex_eur_004 , 13
			
			Allocations.click_spread_evenly_link
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $ffa_msg_loading
			gen_compare _warning_message_screen, FFA.get_sencha_popup_warning_message, "Warning message matched"
			FFA.sencha_popup_click_ok
			CIF.click_toggle_button
			#Verify in New Tab
			#22. A new line should get added to rule. Now total 13 rule lines should be there and on last line
			within_window new_tab do
				SF.tab $tab_allocation_rules
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.click_link _allocation_name_smoke_fixed_rule
				CIF.click_toggle_button
				gen_compare "7.6923" , AllocationRules.get_grid_row_value_by_column_view_page(13, ALLOCATION_FIXED_RULE_GRID_PERCENTAGE_COLUMN) , "Expected percentage =7.6923"
				gen_compare $bd_dim1_tasmania , AllocationRules.get_grid_row_value_by_column_view_page(13, ALLOCATION_FIXED_RULE_GRID_DIMENSION1_COLUMN) , "Expected dim1 = #{$bd_dim1_tasmania}"
				gen_compare $bd_apex_eur_002 , AllocationRules.get_grid_row_value_by_column_view_page(13, ALLOCATION_FIXED_RULE_GRID_DIMENSION2_COLUMN) , "Expected dim1 = #{$bd_apex_eur_002}"
				gen_compare $bd_apex_eur_003 , AllocationRules.get_grid_row_value_by_column_view_page(13, ALLOCATION_FIXED_RULE_GRID_DIMENSION3_COLUMN) , "Expected dim2 = #{$bd_apex_eur_003}"
				gen_compare $bd_apex_eur_004 , AllocationRules.get_grid_row_value_by_column_view_page(13, ALLOCATION_FIXED_RULE_GRID_DIMENSION4_COLUMN) , "Expected dim3 = #{$bd_apex_eur_004}"
				page.current_window.close
			end
			CIF.click_toggle_button
			
			expected_preview_grid_lines=["#{$bd_gla_account_receivable_control_eur} 13.78",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 13.67",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim4_eur} 13.34",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim1_usd} #{$bd_dim2_eur} 66.67",				
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim3_eur} 13.41",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim2_eur} 13.53",
				"#{$bd_gla_account_receivable_is} #{$bd_apex_eur_001} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_apex_jpy_001} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_apex_usd_001} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_eur} 10.33",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_gbp} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_usd} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_european} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_massachusetts} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_new_york} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_north} 10.33",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_queensland} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_south} 10.34",
				"#{$bd_gla_account_receivable_is} #{$bd_dim1_tasmania} #{$bd_apex_eur_002} #{$bd_apex_eur_003} #{$bd_apex_eur_004} 10.34"]
			expect(Allocations.assert_preview_panel_distributed_rows? expected_preview_grid_lines).to eq(true)
			
			CIF.click_toggle_button
			Allocations.save_template
			Allocations.set_popup_template_name _template_name2
			Allocations.set_popup_template_description _template_description
			Allocations.popup_save_template
			Allocations.popup_save_template
			
			SF.tab $tab_allocations
			SF.wait_for_search_button
			SF.click_button_new
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.set_template _template_name2
			Allocations.load_template
			Allocations.set_timeperiod_period_selection _current_period,_next_period
			#click Next till Post Button
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $page_loadmask_message
			#Next to Distribute
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $page_loadmask_message
			#Next To Post
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $page_loadmask_message
			Allocations.click_on_post_button
			gen_wait_until_object_disappear $page_loadmask_message
			##32. The user should be redirected to Allocations List View
			Allocations.wait_for_list_view
			SF.tab $tab_allocations
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_allocation_name = FFA.get_column_value_in_grid $alloc_preview_panel_allocation_method_label , $allocationrules_type_fixed_label , $alloc_label_allocation_name
			SF.click_link _allocation_name
			SF.wait_for_search_button
			#33. Allocation record should have values as under.
			gen_compare _allocation_name,Allocations.get_allocation_detail_page_allocation_name,"allocation Name is #{_allocation_name}"
			gen_compare $allocationrules_type_fixed_label,Allocations.get_allocation_detail_page_allocation_method,"allocation method is #{$allocationrules_type_fixed_label}"
			##gen_compare _destination_document_description,Allocations.get_allocation_detail_page_description,"allocation description is #{_destination_document_description}"
			gen_compare _document_type_journals,Allocations.get_allocation_detail_page_output,"allocation output is #{_document_type_journals}"
			gen_compare _current_day,Allocations.get_allocation_detail_page_posting_date,"allocation posting_date is #{_current_day}"
			gen_compare _current_period,Allocations.get_allocation_detail_page_posting_period,"allocation posting_period is #{_current_period}"
			
			SF.logout
			#get Journal and validate its line Items
			_journal_name_query =  "SELECT Name, #{ORG_PREFIX}JournalStatus__c FROM #{ORG_PREFIX}codaJournal__c WHERE #{ORG_PREFIX}Allocation__r.Name = '#{_allocation_name}'"
			APEX.execute_soql _journal_name_query
			_journal_name =  APEX.get_field_value_from_soql_result "Name"
			_journal_status =  APEX.get_field_value_from_soql_result "#{ORG_PREFIX}JournalStatus__c"
			gen_compare $bd_document_status_in_progress,_journal_status,"Expected Journal status is in Progress"
			SF.tab $tab_journals
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.click_link _journal_name
			SF.wait_for_search_button
			vadidate_journal_line_items 1, $bd_gla_account_receivable_control_eur, "13.78" , "", "", "", ""
			vadidate_journal_line_items 2, $bd_gla_account_receivable_control_eur, "13.67" , $bd_dim1_eur, "", "", ""
			vadidate_journal_line_items 3, $bd_gla_account_receivable_control_gbp, "13.34" , "", "", "", $bd_dim4_eur
			vadidate_journal_line_items 4, $bd_gla_account_receivable_control_gbp, "66.67" , $bd_dim1_usd, $bd_dim2_eur, "", ""
			vadidate_journal_line_items 5, $bd_gla_account_receivable_control_usd, "13.41" , "", "", $bd_dim3_eur, ""
			vadidate_journal_line_items 6, $bd_gla_account_receivable_control_usd, "13.53" , "", $bd_dim2_eur, "", ""
			vadidate_journal_line_items 7, $bd_gla_account_receivable_is, "-10.34" , $bd_dim1_tasmania, $bd_apex_eur_002, $bd_apex_eur_003, $bd_apex_eur_004
			vadidate_journal_line_items 8, $bd_gla_account_receivable_is, "-10.34" , $bd_dim1_south, "", "", ""
			vadidate_journal_line_items 9, $bd_gla_account_receivable_is, "-10.34" , $bd_dim1_queensland, "", "", ""
			vadidate_journal_line_items 10,$bd_gla_account_receivable_is, "-10.33" , $bd_dim1_north, "", "", ""
			vadidate_journal_line_items 11,$bd_gla_account_receivable_is, "-10.34" , $bd_dim1_new_york, "", "", ""
			vadidate_journal_line_items 12,$bd_gla_account_receivable_is, "-10.34" , $bd_dim1_massachusetts, "", "", ""
			vadidate_journal_line_items 13,$bd_gla_account_receivable_is, "-10.34" , $bd_dim1_european, "", "", ""
			vadidate_journal_line_items 14,$bd_gla_account_receivable_is, "-10.34" , $bd_dim1_usd, "", "", ""
			vadidate_journal_line_items 15,$bd_gla_account_receivable_is, "-10.34" , $bd_dim1_gbp, "", "", ""
			vadidate_journal_line_items 16,$bd_gla_account_receivable_is, "-10.33" , $bd_dim1_eur, "", "", ""
			vadidate_journal_line_items 17,$bd_gla_account_receivable_is, "-10.34" , $bd_apex_usd_001, "", "", ""
			vadidate_journal_line_items 18,$bd_gla_account_receivable_is, "-10.34" , $bd_apex_jpy_001, "", "", ""
			vadidate_journal_line_items 19,$bd_gla_account_receivable_is, "-10.34" , $bd_apex_eur_001, "", "", ""
		end
		SF.logout
		gen_end_test "TST038564-Verify that in fixed allocation process User is able to Post Journal."
	
		gen_start_test "TST038543-Verify that in Variable Allocation process User is able to post transactions."
		login_user
		_permission_set_list = [$ffa_permission_set_acc_billing_user_companies, $ffa_permission_set_acc_billing_select_company, "Accounting and Billing - Allocations Multicompany",$ffa_permission_set_acc_billing_allocations]
		SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_StandardUser, true
		SF.login_as_user SFSTANDARD_USER

		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain, $company_merlin_auto_usa, $company_merlin_auto_aus] ,true		
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $ffa_msg_loading
			#Set Allocation filter criteria 
			
			#Allocation filter 1
			Allocations.set_filterset_field 1, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_spain
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, _current_period
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, _next_period
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 1, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			
			Allocations.click_on_add_filter_group_button
	
			#filter 2
			Allocations.set_filterset_field 2, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_usa
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, _current_period
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, _next_period
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 2, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			Allocations.click_on_add_filter_group_button
			
			#filter 3
			Allocations.set_filterset_field 3, $alloc_filter_set_company_field_object_label, $alloc_filter_set_equals_label, $company_merlin_auto_aus
			Allocations.set_filterset_field 3, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, _current_period
			Allocations.set_filterset_field 3, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, _next_period
			Allocations.set_filterset_field 3, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_eur
			Allocations.set_filterset_field 3, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_usd
			Allocations.set_filterset_field 3, $alloc_filter_set_gla_field_object_label, $alloc_filter_set_multiselect_label, $bd_gla_account_receivable_control_gbp
			
			gen_wait_until_object_disappear $ffa_msg_loading
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $ffa_msg_loading
			Allocations.select_variable_allocation_method_button
			Allocations.click_on_next_button
			gen_wait_until_object_disappear $ffa_msg_loading
			gen_compare_has_content $alloc_sb_page_title_label, true, "Expected statistical basis configuration screen."
			Allocations.select_variable_rule_name _smoke_variable
			Allocations.click_on_next_button
			gen_compare_has_content $alloc_label_statistical_distribution, true, "Expected statistical distribution screen."
			#9. In summary panel Source
			gen_compare _amount_value_344_34,Allocations.get_total_value,"Total Value on right panel is #{_amount_value_344_34}"
			gen_compare _allocation_method_value_variable, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare _glas_copied_from_source, Allocations.get_preview_panel_section_value($alloc_preview_panel_distribute_to_glas_label),"#{$alloc_preview_panel_distribute_to_glas_label} value matched"
			gen_compare _statistical_basis_name, Allocations.get_preview_panel_section_value($alloc_preview_panel_statistical_value_label),"#{$alloc_preview_panel_statistical_value_label} value matched"
			
			Allocations.click_on_next_button
			Allocations.set_destination_company_value $company_merlin_auto_aus
			Allocations.set_destination_document_type_value _document_type_transactions
			#Saving the template
			Allocations.save_template
			
			gen_assert_disabled $alloc_template_save_popup_save_button
			gen_report_test "Save Template popup save button is disabled"
			Allocations.set_popup_template_name _template_name1
			Allocations.set_popup_template_description _template1_description
			Allocations.popup_save_template
			gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'
			gen_report_test "#{_template_name1} created"
			expected_preview_grid_lines=["#{$bd_gla_account_receivable_control_eur} 20.67",
				"#{$bd_gla_account_receivable_control_eur} 20.66",
				"#{$bd_gla_account_receivable_control_eur} 20.67",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 20.51",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 20.50",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 20.51",				
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim4_eur} 20.01",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim1_usd} #{$bd_dim2_eur} 100.00",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim4_eur} 20.01",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim2_eur} 20.29",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim2_eur} 20.29",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim3_eur} 20.11",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim3_eur} 20.11",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim2_eur} 114.78",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim2_eur} 114.78",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim2_eur} 114.78"
				]
			
			CIF.click_toggle_button
			Allocations.click_posting_transaction_lines_preview_panel
			Allocations.click_on_source_section_expand_collapse_button
			Allocations.click_on_distribution_section_expand_collapse_button
			expect(Allocations.assert_preview_panel_distributed_rows? expected_preview_grid_lines).to eq(true)
					
			Allocations.click_on_back_button
			Allocations.set_copy_glas_picklist $alloc_copy_glas_picklist_from_basis_label
			Allocations.click_on_next_button
						
			expected_preview_grid_lines=["#{$bd_gla_account_receivable_control_eur} 20.67",
				"#{$bd_gla_account_receivable_control_eur} 20.66",
				"#{$bd_gla_account_receivable_control_eur} 20.67",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 20.51",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 20.51",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim1_eur} 20.50",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim1_usd} #{$bd_dim2_eur} 100.00",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim4_eur} 20.01",
				"#{$bd_gla_account_receivable_control_gbp} #{$bd_dim4_eur} 20.01",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim2_eur} 20.29",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim2_eur} 20.29",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim3_eur} 20.11",
				"#{$bd_gla_account_receivable_control_usd} #{$bd_dim3_eur} 20.11",
				"#{$bd_gla_account_receivable_control_eur} #{$bd_dim2_eur} 344.34",
			]
			
			expect(Allocations.assert_preview_panel_distributed_rows? expected_preview_grid_lines).to eq(true)
			CIF.click_toggle_button
			#9. In summary panel Source
			gen_compare _amount_value_344_34,Allocations.get_total_value,"Total Value on right panel is #{_amount_value_344_34}"
			gen_compare _allocation_method_value_variable, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare _glas_copied_from_basis, Allocations.get_preview_panel_section_value($alloc_preview_panel_distribute_to_glas_label),"#{$alloc_preview_panel_distribute_to_glas_label} value matched"
			gen_compare _statistical_basis_name, Allocations.get_preview_panel_section_value($alloc_preview_panel_statistical_value_label),"#{$alloc_preview_panel_statistical_value_label} value matched"
			Allocations.save_template
			Allocations.set_popup_template_name _template_name1
			Allocations.set_popup_template_description _template1_description
			Allocations.popup_save_template
			Allocations.popup_save_template
			gen_compare template_success,Allocations.get_toast_message,'Success Template Save Toast message appears'
			gen_report_test "#{_template_name1} Saved"
						
			SF.tab $tab_allocations
			SF.click_button_new
			gen_wait_until_object_disappear $ffa_msg_loading
			Allocations.set_template _template_name1
			Allocations.load_template
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, _current_period
			Allocations.set_filterset_field 1, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, _next_period
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, _current_period
			Allocations.set_filterset_field 2, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, _next_period
			Allocations.set_filterset_field 3, $alloc_filter_set_period_field_object_label, $alloc_filter_set_from_label, _current_period
			Allocations.set_filterset_field 3, $alloc_filter_set_period_field_object_label, $alloc_filter_set_to_label, _next_period
			#click Next till Post Button
			Allocations.click_on_next_button
			#Next to Distribute
			Allocations.click_on_next_button
			Allocations.click_on_next_button
			#Next Distribution UI
			#24. In summary panel Source
			gen_compare _amount_value_344_34,Allocations.get_total_value,"Total Value on right panel is #{_amount_value_344_34}"
			gen_compare _allocation_method_value_variable, Allocations.get_preview_panel_section_value($alloc_preview_panel_allocation_method_label),"#{$alloc_preview_panel_allocation_method_label} value matched"
			gen_compare _glas_copied_from_basis, Allocations.get_preview_panel_section_value($alloc_preview_panel_distribute_to_glas_label),"#{$alloc_preview_panel_distribute_to_glas_label} value matched"
			gen_compare _statistical_basis_name, Allocations.get_preview_panel_section_value($alloc_preview_panel_statistical_value_label),"#{$alloc_preview_panel_statistical_value_label} value matched"
			Allocations.select_distribute_to_gla_radio_button
			Allocations.set_glas_in_distribute_to_gla_picklist [$bd_gla_account_receivable_is, $bd_gla_apexaccgla001]
			Allocations.click_on_next_button
			Allocations.click_on_post_button
			Allocations.click_continue_button_on_popup
			gen_wait_until_object_disappear $page_loadmask_message			
			Allocations.wait_for_list_view
			
			SF.tab $tab_allocations
			SF.select_view $bd_select_view_all
			SF.click_button_go
			_allocation_name = FFA.get_column_value_in_grid $alloc_preview_panel_allocation_method_label ,_allocation_method_value_variable , $alloc_label_allocation_name
			SF.click_link _allocation_name
			SF.wait_for_search_button
			gen_compare _allocation_name,Allocations.get_allocation_detail_page_allocation_name,"variable allocation Name is #{_allocation_name}"
			gen_compare _allocation_method_value_variable,Allocations.get_allocation_detail_page_allocation_method,"allocation method is #{$allocationrules_type_variable_label}"
			gen_compare _document_type_transactions,Allocations.get_allocation_detail_page_output,"allocation output is #{_document_type_transactions}"
			gen_compare _current_day,Allocations.get_allocation_detail_page_posting_date,"allocation posting_date is #{_current_day}"
			gen_compare _current_period,Allocations.get_allocation_detail_page_posting_period,"allocation posting_period is #{_current_period}"
			
			SF.logout
			#get transactions and validate its line Items
			_trans_query =  "SELECT Name FROM #{ORG_PREFIX}codatransaction__c  WHERE #{ORG_PREFIX}Allocation__r.Name = '#{_allocation_name}'"
			APEX.execute_soql _trans_query
			_trans_name =  APEX.get_field_value_from_soql_result "Name"
			
			SF.tab $tab_allocations
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.click_link _allocation_name
			SF.wait_for_search_button
			SF.click_link _trans_name
			
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.97" , $bd_gla_account_receivable_control_eur,  "", "", "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.95" , $bd_gla_account_receivable_control_eur,  "", "", "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.97" , $bd_gla_account_receivable_control_eur,  "", "", "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.79" , $bd_gla_account_receivable_control_eur,  $bd_dim1_eur, "", "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.78" , $bd_gla_account_receivable_control_eur,  $bd_dim1_eur, "", "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.78" , $bd_gla_account_receivable_control_eur,  $bd_dim1_eur, "", "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.24" , $bd_gla_account_receivable_control_gbp,  "", "", "", $bd_dim4_eur,false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.23" , $bd_gla_account_receivable_control_gbp,  "", "", "", $bd_dim4_eur,false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "111.11" ,$bd_gla_account_receivable_control_gbp,  $bd_dim1_usd, $bd_dim2_eur, "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.35" , $bd_gla_account_receivable_control_usd,  "", "", $bd_dim3_eur, "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.34" , $bd_gla_account_receivable_control_usd,  "", "", $bd_dim3_eur, "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.55" , $bd_gla_account_receivable_control_usd,  "", $bd_dim2_eur, "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "22.54" , $bd_gla_account_receivable_control_usd,  "", $bd_dim2_eur, "", "",false
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "-191.30" ,$bd_gla_account_receivable_is,  "", $bd_dim2_eur, "", "",true
			validate_transaction_line_item _trans_name,$tranx_analysis_label, "-191.30" , $bd_gla_apexaccgla001,"", $bd_dim2_eur, "", "",true
		end	
		gen_end_test "TST038543-Verify that in Variable Allocation process User is able to post transactions."
	end

	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		#delete CSV file
		gen_remove_file _file_path +_csv_file_name
		gen_end_test "Intercompany Smoke Test"
		SF.logout
	end
end

#validate journal line item with line_number and assert gla value and dimensions
def vadidate_journal_line_items line_number, expected_gla_name, expected_amount , expected_dim1, expected_dim2, expected_dim3, expected_dim4
	gen_compare expected_gla_name,(JNL.line_get_journal_gla line_number),"expected_gla_name at No. #{line_number} is #{expected_gla_name}"
	gen_compare expected_amount,(JNL.line_get_journal_line_value line_number),"expected_amount at No. #{line_number} is #{expected_amount}"
	gen_compare expected_dim1,(JNL.line_get_journal_dimension1 line_number),"expected_dim1 at No. #{line_number} is #{expected_dim1}"
	gen_compare expected_dim2,(JNL.line_get_journal_dimension2 line_number),"expected_dim2 at No. #{line_number} is #{expected_dim2}"
	gen_compare expected_dim3,(JNL.line_get_journal_dimension3 line_number),"expected_dim3 at No. #{line_number} is #{expected_dim3}"
	gen_compare expected_dim4,(JNL.line_get_journal_dimension4 line_number),"expected_dim4 at No. #{line_number} is #{expected_dim4}"
end

#validate transaction line Item
def validate_transaction_line_item tranx_number,line_type,home_value , line_item_gla_name,  expected_dim1, expected_dim2, expected_dim3, expected_dim4,search_by_gla=false
	page.has_text?(tranx_number)
	TRANX.click_more
	if search_by_gla == true
		TRANX.click_more
		TRANX.open_transaction_line_item_by_gla line_item_gla_name
	else
		TRANX.open_transaction_line_item_by_home_value  home_value
	end
	SF.wait_for_search_button
	gen_compare line_item_gla_name , TRANX.get_line_item_gla_name ,"Expected GLA value to be #{line_item_gla_name}."
	gen_compare expected_dim1 , TRANX.get_line_item_dimension1_value ,"Expected Dimension 1 value to be #{expected_dim1}."
	gen_compare expected_dim2 , TRANX.get_line_item_dimension2_value ,"Expected Dimension 2 value to be #{expected_dim2}."
	gen_compare expected_dim3 , TRANX.get_line_item_dimension3_value ,"Expected Dimension 3 value to be #{expected_dim3}."
	gen_compare expected_dim4 , TRANX.get_line_item_dimension4_value ,"Expected Dimension 4 value to be #{expected_dim4}."
	gen_compare line_type ,	TRANX.get_line_item_line_type_value ,"Expected line type value to be #{line_type}."
	SF.click_link tranx_number
	page.has_text?(tranx_number)
end
