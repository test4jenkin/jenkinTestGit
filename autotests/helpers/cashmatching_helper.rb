 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module CM
extend Capybara::DSL
#############################
# cash matching (VF pages)
#############################
#selectors
$cashmatching_account = "input[id$='account']"
$cashmatching_currency_mode = "input[value='"+$sf_param_substitute+"']"
$cashmatching_select_currency = "[id$='selectCurrency']>option[value='"+$sf_param_substitute+"']"
$cashmatching_matching_date_input = "input[id$=':matchingDate']"
$cashmatching_retrieve_link = "input[id$='retrieveData']"
$cashmatching_undo_link = "input[id$='undoMatch']"
$cashmatching_matching_tables = ".dataTables_wrapper"
$cashmatching_undo_tables = ".ffdcTable"
$cashmatching_undo_table_search_text = "input[id$=':searchField']"
$cashmatching_transactiontable_search = "input[id$=':rigthSearchField']"
$cashmatching_transactiontable_search_button = "[id$=':rightTableOuter']>div>div:nth-of-type(2)>input"
$cashmatching_transactiontable_doc_select = "table[id='TRTable'] tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(1)>div"
$cashmatching_cashentrytable_search = "input[id$=':leftSearchField']"
$cashmatching_cashentrytable_search_button = "[id$=':leftTableOuter']>div>div:nth-of-type(2)>input"
$cashmatching_cashentrytable_doc_select = "table[id='CETable'] tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type(1)>div"
$cashmatching_trans_doc_paid_amount = "table[id='TRTable'] tr:nth-of-type("+$sf_param_substitute+") td:nth-of-type("+$sf_param_substitute+")>.paidClass"
$cashmatching_matchtotal = "#matchTotalBalance"
$cashmatching_commitdata = "input[id$='commitData']"
$cashmatching_undo_reason = "[id$=':undoReason']>option[value='"+$sf_param_substitute+"']"
$cashmatching_undotable_doc_select = "//span[text()='"+$sf_param_substitute+"']/../..//td//div[@class='status']"
$cashmatching_commit_undo_link = "input[id*='undoButton']"
$cashmatching_retrieving_message = "Retrieving..."
$cashmatching_commit_message = "div[class='message infoM3']"
$cashmatching_retrieving_loading_msg = "//span[text()='Retrieving...']"
# cash matching Header 
#cash matching set account
	def CM.set_cash_matching_account account_name
		SF.execute_script do
			find($cashmatching_account).set account_name
		end
	end
# set cash matching currency mode
	def CM.set_cash_matching_currencymode currency_mode
		SF.execute_script do
			find($cashmatching_currency_mode.sub($sf_param_substitute,currency_mode)).click
		end
	end	
# select cirrency
	def CM.select_currency currency
		SF.execute_script do
			find($cashmatching_select_currency.sub($sf_param_substitute,currency)).click
		end
	end
# click on retrieve button
	def CM.click_retrieve
		SF.execute_script do
			SF.retry_script_block do
				find($cashmatching_retrieve_link).click
			end	
		end
		page.has_no_xpath?($cashmatching_retrieving_loading_msg)
		SF.wait_for_search_button
	end
# click on undomatching button
	def CM.click_undomatching
		SF.execute_script do
			SF.retry_script_block do
				find($cashmatching_undo_link).click
			end
		end
		SF.wait_for_search_button
	end	
# click on commit button to undo matching
	def CM.click_commit_undomatching
		SF.execute_script do
			find($cashmatching_commit_undo_link).click
			gen_wait_until_object $cashmatching_retrieve_link
		end	
	end
	
# set matching date
	def CM.set_matching_date date
		find($cashmatching_matching_date_input).set date
	end
# click retreive retrieve cash matching 
	def CM.retrieve_cashmatching account_name, currencymode, currency
		CM.set_cash_matching_account account_name
		CM.set_cash_matching_currencymode currencymode
		CM.select_currency currency
		CM.click_retrieve	
		gen_wait_until_object $cashmatching_matching_tables
	end
# Click on undo matching and retrieve the documents.
	def CM.undo_cashmatching account_name, currencymode, currency, undo_reason
		CM.set_cash_matching_account account_name
		CM.set_cash_matching_currencymode currencymode
		CM.select_currency currency
		CM.click_undomatching
		SF.execute_script do
			gen_wait_until_object $cashmatching_undo_reason.gsub($sf_param_substitute,undo_reason)
			find($cashmatching_undo_reason.gsub($sf_param_substitute,undo_reason)).click
			CM.click_retrieve
			gen_wait_until_object $cashmatching_undo_table_search_text
		end
	end
# select transaction document for matching	
	def CM.select_trans_doc_for_matching doc_number, doc_position_in_list
		SF.execute_script do
			find($cashmatching_transactiontable_search).set doc_number
			find($cashmatching_transactiontable_search_button).click
			FFA.wait_page_message $cashmatching_retrieving_message
			gen_wait_until_object $cashmatching_transactiontable_doc_select.sub($sf_param_substitute,doc_position_in_list.to_s)
			find($cashmatching_transactiontable_doc_select.sub($sf_param_substitute,doc_position_in_list.to_s)).click
		end
	end
# select cash entry documents for matching
	def CM.select_cashentry_doc_for_matching doc_number, doc_position_in_list
		SF.execute_script do
			find($cashmatching_cashentrytable_search).set doc_number
			find($cashmatching_cashentrytable_search_button).click
			FFA.wait_page_message $cashmatching_retrieving_message
			find($cashmatching_cashentrytable_doc_select.sub($sf_param_substitute,doc_position_in_list.to_s)).click
		end
	end
# set paid amount for transaction document	
	def CM.set_trans_doc_paid_amount paid_amount, doc_position_in_list
		SF.execute_script do
			cashMatchingTablePaidfield = $cashmatching_trans_doc_paid_amount.sub($sf_param_substitute,doc_position_in_list.to_s).sub($sf_param_substitute,"5".to_s)
			if page.has_no_css?(cashMatchingTablePaidfield)
				cashMatchingTablePaidfield = $cashmatching_trans_doc_paid_amount.sub($sf_param_substitute,doc_position_in_list.to_s).sub($sf_param_substitute,"4".to_s)	
			end
			SF.retry_script_block do
				find(cashMatchingTablePaidfield).set paid_amount
				gen_tab_out cashMatchingTablePaidfield
			end	
		end
	end
# get matching total
	def CM.get_match_total
		SF.execute_script do
			return find($cashmatching_matchtotal).text
		end
	end
# click on commit data button
	def CM.click_commit_data
		SF.execute_script do
			find($cashmatching_commitdata).click
			gen_wait_until_object $cashmatching_retrieve_link
			page.has_css?($cashmatching_commit_message)
		end
	end
# select document as per its amount to undo the matching
	def CM.select_undo_doc_by_amount amount
		SF.execute_script do
			SF.retry_script_block do
				page.has_xpath?($cashmatching_undotable_doc_select.gsub($sf_param_substitute,amount))
				find(:xpath,$cashmatching_undotable_doc_select.gsub($sf_param_substitute,amount)).click
			end	
		end
	end
	# return the cash matching success message 
	def CM.get_cash_matching_commit_operation_message
		SF.retry_script_block do
			SF.execute_script do
				page.has_css?($cashmatching_commit_message)
				return find($cashmatching_commit_message).text
			end
		end
	end
end