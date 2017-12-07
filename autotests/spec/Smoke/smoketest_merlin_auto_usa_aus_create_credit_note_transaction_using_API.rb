#--------------------------------------------------------------------#
#	TID : 	TID018749
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Accounting API - Sales Credit Notes
# 	Story: AC-3939 
#--------------------------------------------------------------------#


describe "Smoke Test - Accounting API - Sales Credit Notes", :type => :request do
include_context "login"
include_context "logout_after_each"
	_namspace_prefix = ""
	_namspace_prefix += ORG_PREFIX
	_trans_type_alias = "CREDIT_NOTE_COUNT"
	_transaction_count = "0"
	_string_to_replace1 = "\"#{_trans_type_alias}\":"
	_string_to_replace2 = "}]}"
	_type_credit_note = "Credit Note"

	if(_namspace_prefix != nil && _namspace_prefix != "" )
		_namspace_prefix = _namspace_prefix.gsub! "__", "."
	end		
		
	_post_with_API = "Date currentDate = system.today();"
	_post_with_API += " #{ORG_PREFIX}codaCompany__c compMerlinAutoUSA = [select id, name from #{ORG_PREFIX}codaCompany__c where name = 'Merlin Auto USA'];"
	_post_with_API += " Account accAlgernon = [Select id, name from Account where MirrorName__c = 'Algernon Partners & Co'];" 
	_post_with_API += " #{ORG_PREFIX}codaGeneralLedgerAccount__c glaARCUSD = [Select id, name from #{ORG_PREFIX}codaGeneralLedgerAccount__c where name = 'Accounts Receivable Control - USD'];"
	_post_with_API += " #{ORG_PREFIX}codaGeneralLedgerAccount__c glaSalesParts = [Select id, name from #{ORG_PREFIX}codaGeneralLedgerAccount__c where name = 'Sales - Parts'];"
	_post_with_API += " #{ORG_PREFIX}codaAccountingCurrency__c currUSD = [Select id, name from #{ORG_PREFIX}codaAccountingCurrency__c where name = 'USD' and #{ORG_PREFIX}OwnerCompany__c = :compMerlinAutoUSA.Id];"
	_post_with_API += " Set<String> specialPeriods = new Set<String> {'000', '100', '101'};"
	_post_with_API += " #{ORG_PREFIX}codaPeriod__c period = [Select id, #{ORG_PREFIX}EndDate__c from #{ORG_PREFIX}codaPeriod__c where #{ORG_PREFIX}StartDate__c <= :currentDate and #{ORG_PREFIX}EndDate__c >= :currentDate and #{ORG_PREFIX}OwnerCompany__c = :compMerlinAutoUSA.Id and #{ORG_PREFIX}Closed__c = false and #{ORG_PREFIX}PeriodNumber__c not in :specialPeriods];"
	_post_with_API += " Product2 prodAutoCom = [select id, Description from Product2 where name = 'Auto Com Clutch Kit 1989 Dodge Raider'][0];"
	_post_with_API += " #{ORG_PREFIX}codaTaxCode__c CityTaxCodeSUT = [select id, #{ORG_PREFIX}Description__c from #{ORG_PREFIX}codaTaxCode__c where name = 'City Tax Code SUT'];"
	_post_with_API += "  #{_namspace_prefix}TransactionService.AccountingTransaction trans = new #{_namspace_prefix}TransactionService.AccountingTransaction();"
	_post_with_API += " trans.setTransactionDate(currentDate);"
	_post_with_API += " trans.setPeriodId(period.Id);"
	_post_with_API += " trans.setTransactionType(#{_namspace_prefix}TransactionService.TransactionType.SALES_CREDITNOTE);"
	_post_with_API += " List<#{_namspace_prefix}TransactionService.AccountingTransactionLine> transLines = new List<#{_namspace_prefix}TransactionService.AccountingTransactionLine>();"
	_post_with_API += "  /* Account Line */ "
	_post_with_API += "#{_namspace_prefix}TransactionService.AccountingTransactionLine line = new #{_namspace_prefix}TransactionService.AccountingTransactionLine();"
	_post_with_API += " line.setLineType(#{_namspace_prefix}TransactionService.TransactionLineType.ACCOUNT);"
	_post_with_API += " line.setAccountId(accAlgernon.Id);"
	_post_with_API += " line.setDocumentValue(-15);"
	_post_with_API += " line.setDocumentCurrencyId(currUSD.Id);"
	_post_with_API += " line.setGeneralLedgerAccountId(glaARCUSD.Id);"
	_post_with_API += " line.setDueDate(currentDate + 10);"
	_post_with_API += " transLines.add(line);"
	_post_with_API += "  /* Analisys line*/"
	_post_with_API += " line = new #{_namspace_prefix}TransactionService.AccountingTransactionLine();"
	_post_with_API += " line.setLineType(#{_namspace_prefix}TransactionService.TransactionLineType.ANALYSIS);"
	_post_with_API += " line.setDocumentValue(10);"
	_post_with_API += " line.setDocumentCurrencyId(currUSD.Id);"
	_post_with_API += " line.setGeneralLedgerAccountId(glaSalesParts.Id);"
	_post_with_API += " line.setProductId(prodAutoCom.Id);"
	_post_with_API += " line.setTaxCode1Id(CityTaxCodeSUT.Id);"
	_post_with_API += " line.setDocumentTaxValue1(0.0);"
	_post_with_API += " transLines.add(line);"
	_post_with_API += "  /* Tax line */"
	_post_with_API += " #{_namspace_prefix}TransactionService.AccountingTransactionLine taxLine = new #{_namspace_prefix}TransactionService.AccountingTransactionLine();"
	_post_with_API += " taxLine.setLineType(#{_namspace_prefix}TransactionService.TransactionLineType.TAX);"
	_post_with_API += " taxLine.setTaxCode1Id(CityTaxCodeSUT.Id);"
	_post_with_API += " taxLine.setDocumentValue(5);"
	_post_with_API += " taxLine.setDocumentCurrencyId(currUSD.Id);"
	_post_with_API += " taxLine.setGeneralLedgerAccountId(glaARCUSD.Id);"
	_post_with_API += " transLines.add(taxLine);"
	_post_with_API += " trans.TransactionLineItems = transLines;"
	_post_with_API += "  #{_namspace_prefix}TransactionService.PostOptions postOp = new #{_namspace_prefix}TransactionService.PostOptions();"
	_post_with_API += " postOp.DestinationCompanyId = compMerlinAutoUSA.Id;"
	_post_with_API += " List<ID> transIDs = #{_namspace_prefix}TransactionService.post(new List<#{_namspace_prefix}TransactionService.AccountingTransaction> {trans}, postOp);"
	
	_transaction_count_query = "SELECT COUNT(ID) #{_trans_type_alias} FROM  #{ORG_PREFIX}codaTransaction__c"
	_transaction_count_query +=" WHERE  #{ORG_PREFIX}TransactionType__c = '"+ _type_credit_note +"' AND #{ORG_PREFIX}OwnerCompany__c "
	_transaction_count_query +="IN (select Id from #{ORG_PREFIX}codaCompany__c WHERE NAME = '"+$company_merlin_auto_usa+"')"

	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "Smoke: Create credit note transaction using API"			
	end
	
	it "TST029631:Create Credit note transaction using API" do
		begin		
			# get Apex Transaction count before execution
			APEX.execute_soql _transaction_count_query
			query_result = APEX.get_execution_status_message
			msg_arr = query_result.split(",")
			tran_count_msg = msg_arr[-1].gsub! _string_to_replace1, ""
			_transaction_count = msg_arr[-1].gsub! _string_to_replace2, ""	
			
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa, $company_merlin_auto_aus] ,true
			SF.tab $tab_home
			
			#Execute API command
			APEX.execute_commands [_post_with_API]	
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
						
			# #validation
			APEX.execute_soql _transaction_count_query
			query_result = APEX.get_execution_status_message
			msg_arr = query_result.split(",")
			tran_count_msg = msg_arr[-1].gsub! _string_to_replace1, ""
			_transaction_count2 = msg_arr[-1].gsub! _string_to_replace2, ""
			gen_compare (_transaction_count.to_i + 1).to_s ,_transaction_count2, "Expected- 1 Transaction with transaction type Credit note generated successfully."
		end 			
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "Smoke: Create credit note transaction using API"
		SF.logout
	end
end
