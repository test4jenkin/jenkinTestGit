#--------------------------------------------------------------------#
#	TID : TID016376 
# 	Pre-Requisite : Base data should exist on the org. 
#					CODATID016376Data.cls should be deployed on org.
#  	Product Area: Currency Revaluation
# 	
#--------------------------------------------------------------------#


describe "Regression - Currency revaluation - TID016376", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID016376: Verify that user is able to revalue Only Home Value/ Dual Value."
	end
	
	it "TID016376 : Process currency revaluation for merlin auto usa with already revalued GLA", :unmanaged => true do
		_document_currency_gbp_to_usd = "GBP to USD"
		_currency_reval_list_view_text = "Currency Revaluations"
		_document_to_home_row_value = "GBP to USD 0.50 1 GBP = 2.000000000 USD"
		_home_to_dual_row_value = "USD 1.00 1.00 1 USD = 1.000000000 USD"
		_period_2015_010 = "2015/010"
		_period_2016_011 = "2016/011"
		_doc_value_n20 = "-20.00"
		_prod_OctGBPIS = "OctGBPIS"
		_invoice_number_label = "Invoice Number"
		_account_label = "Account" 
		_invnum = ""
		_trx_line_item_value_prefix = "2015/010 #{_invnum}"
		_trx_line_item_value_suffix = "GBP -20.00 -40.00 -40.00"
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa],true
		begin
			_create_data = ["CODATID016376Data.selectCompany();", "CODATID016376Data.createData();", "CODATID016376Data.createDataExt1();","CODATID016376Data.switchProfile();"]
			APEX.execute_commands _create_data
		end
		# Login as accountant.
		SF.login_as_user SFACC_USER
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		SF.tab $tab_sales_invoices
		SF.select_view $bd_select_view_all
		SF.click_button_go
		_invnum = FFA.get_column_value_in_grid _account_label , _prod_OctGBPIS , _invoice_number_label
		gen_start_test "TST023565: Verify that TLIs included or excluded through the option in Lines Already Revalued."
		begin
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			# Set Balance Sheet parameters
			CRV.check_balance_sheet_checkbox 
			CRV.select_balance_sheet_period_value "Specific Period"
			CRV.select_period_from _period_2015_010 , $company_merlin_auto_usa
			CRV.select_period_to _period_2015_010 , $company_merlin_auto_usa
			CRV.select_posting_period _period_2016_011 , $company_merlin_auto_usa
			# Set Income Statement parameters
			CRV.check_income_statement_checkbox
			CRV.select_IS_period_from _period_2015_010 , $company_merlin_auto_usa
			CRV.select_IS_period_to _period_2015_010 , $company_merlin_auto_usa
			CRV.select_IS_posting_period _period_2016_011 , $company_merlin_auto_usa
			CRV.check_ignore_unused_currency_checkbox 
			CRV.choose_exclude_from_selection_action
			# click on retrieve button
			CRV.click_retrieve_data_button
			page.has_text?(_document_currency_gbp_to_usd)
			
			# Verify Document to Home  and Home to Dual currency row
			doc_to_home_row = CRV.get_doc_to_home_row_data _document_currency_gbp_to_usd
			home_to_dual_row = CRV.get_home_to_dual_row_data "USD"
			gen_compare _document_to_home_row_value , doc_to_home_row , "Expected Doc to home-GBP to USD row to be displayed as: #{_document_to_home_row_value}"
			gen_compare _home_to_dual_row_value , home_to_dual_row , "Expected DUal to Home: USD row to be displayed as: #{_home_to_dual_row_value}"
			
			# Set GLA and click on generate and post button
			CRV.set_unrealized_gains_losses_gla $bd_gla_account_receivable_control_eur
			CRV.click_generate_and_post_button
			CRV.click_confirm_message_generate_and_post_button # confirm the processing
			SF.wait_for_apex_job
			
			# Again Generate Currency Revauation
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			# Set Balance Sheet parameters
			CRV.check_balance_sheet_checkbox 
			CRV.select_balance_sheet_period_value "Specific Period"
			CRV.select_period_from _period_2015_010 , $company_merlin_auto_usa
			CRV.select_period_to _period_2015_010 , $company_merlin_auto_usa
			CRV.select_posting_period _period_2016_011 , $company_merlin_auto_usa
			# Set Income Statement parameters
			CRV.check_income_statement_checkbox
			CRV.select_IS_period_from _period_2015_010 , $company_merlin_auto_usa
			CRV.select_IS_period_to _period_2015_010 , $company_merlin_auto_usa
			CRV.select_IS_posting_period _period_2016_011 , $company_merlin_auto_usa
			CRV.check_ignore_unused_currency_checkbox 
			CRV.choose_exclude_from_selection_action
			# click on retrieve button
			CRV.click_retrieve_data_button
			page.has_text?(_document_currency_gbp_to_usd)
			
			# click on currency pair label
			CRV.click_document_currency _document_currency_gbp_to_usd
			#Assert number of transaction line item and its content
			gen_compare 1, CRV.get_num_of_trx_line_items , "Expected only 1 transaction line item to be present."
			
			trx_line_item_data =  CRV.get_trx_line_item_data _doc_value_n20
			gen_include _trx_line_item_value_prefix,trx_line_item_data , "Expected:Transaction Line Item prefix value to be- #{_trx_line_item_value_prefix}"
			gen_include _trx_line_item_value_suffix,trx_line_item_data , "Expected:Transaction Line Item suffix value to be- #{_trx_line_item_value_suffix}"
			#Close the popup 
			CRV.click_tli_pop_up_close_button
			gen_end_test "TST023565: Verify that TLIs included or excluded through the option in Lines Already Revalued."
		end
	end
	
	after :all do
		login_user
		_destroy_data_TID016376 = ["CODATID016376Data.selectCompany();","CODATID016376Data.destroyData();"]
		APEX.execute_commands _destroy_data_TID016376
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
	end
end