#--------------------------------------------------------------------#
#	TID : TID021066 
# 	Pre-Requisite : Base data should exist on the org. 
#					CODATID021066Data.cls should be deployed on org.
#  	Product Area: Currency Revaluation
#	driver=firefox rspec -fd -c spec/UI/currency_revaluation/currency_revaluation_TID021066.rb -fh -o TID021066.html
#--------------------------------------------------------------------#


describe "TID021066: Verify the Currency revaluation process is completed successfully with reversal period applied.", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID021066: Verify the Currency revaluation process is completed successfully with reversal period applied."
	end
	
	it "TID021066 : Currency revaluation process is completed successfully with reversal period applied", :unmanaged => true do
		_document_currency_eur_to_eur = "EUR to EUR"
		_document_currency_gbp_to_eur = "GBP to EUR"
		_document_currency_usd_to_eur = "USD to EUR"
		_currency_reval_list_view_text = "Currency Revaluations"
		_document_rate = "1.600000000"
		_dual_rate = "3.0"
		_next_month_period = FFA.get_period_by_date  ((Date.today) + 31)
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		begin
			_create_data = ["CODATID021066Data.selectCompany();", "CODATID021066Data.createData();", "CODATID021066Data.createDataExt1();", "CODATID021066Data.createDataExt2();"]
			APEX.execute_commands _create_data
		end
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		gen_start_test "TST035918: Verify that CRV process completed successfully when reversal period is applied in any one Revaluation Type."
		begin
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			# Set Balance Sheet parameters
			CRV.check_balance_sheet_checkbox 
			CRV.select_balance_sheet_period_value "Opening Balances"
			# set current periods
			current_year = Date.today.strftime("%Y")
			current_month = Date.today.strftime("%m")
			current_period = current_year + "/0" + current_month
			CRV.select_period_to current_period , $company_merlin_auto_spain
			CRV.select_posting_period current_period , $company_merlin_auto_spain
			CRV.select_reversal_period _next_month_period, $company_merlin_auto_spain 
			
			# Set Income Statement parameters
			CRV.check_income_statement_checkbox
			CRV.select_IS_period_from current_period , $company_merlin_auto_spain
			CRV.select_IS_period_to current_period , $company_merlin_auto_spain
			CRV.select_IS_posting_period current_period , $company_merlin_auto_spain
			CRV.check_ignore_unused_currency_checkbox 
			CRV.choose_exclude_from_selection_action
			
			# click on retrieve button
			CRV.click_retrieve_data_button
			
			CRV.set_document_rate _document_currency_gbp_to_eur ,_document_rate
			CRV.set_document_rate _document_currency_usd_to_eur ,_dual_rate
			CRV.set_dual_rate _dual_rate
			CRV.set_unrealized_gains_losses_gla $bd_gla_exchange_gain_loss_us
			CRV.choose_copy_from_source_radio_button
			CRV.choose_summary_level_radio_button
			CRV.click_generate_button
			CRV.click_confirm_message_generate_button # confirm the processing
			SF.wait_for_apex_job
			SF.tab $tab_currency_revaluations
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.edit_list_view $bd_select_view_all, $crv_revaluation_group_label, 5
			currency_reval_group  = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate ,$crv_revaluation_group_label
			SF.click_link currency_reval_group
			SF.wait_for_search_button
			CRV.click_group_post_button
			SF.wait_for_apex_job
			_assert_data_TST035918 = ["CODATID021066Data.assertions_TST035918();"]
			APEX.execute_commands _assert_data_TST035918
			puts "TST035918: Balance sheet reversal period Assertions Passed"
			
			FFA.hold_base_data_and_wait
			begin
			_create_data1 = ["CODATID021066Data.destroyData();", "CODATID021066Data.selectCompany();", "CODATID021066Data.createData();", "CODATID021066Data.createDataExt1();", "CODATID021066Data.createDataExt2();"]
			APEX.execute_commands _create_data1
			end
			
			SF.tab $tab_currency_revaluations
			SF.click_button_new
			# Set Balance Sheet parameters
			CRV.check_balance_sheet_checkbox 
			CRV.select_balance_sheet_period_value "Opening Balances"
			# set current periods
			current_year = Date.today.strftime("%Y")
			current_month = Date.today.strftime("%m")
			current_period = current_year + "/0" + current_month
			CRV.select_period_to current_period , $company_merlin_auto_spain
			CRV.select_posting_period current_period , $company_merlin_auto_spain
			
			# Set Income Statement parameters
			CRV.check_income_statement_checkbox
			CRV.select_IS_period_from current_period , $company_merlin_auto_spain
			CRV.select_IS_period_to current_period , $company_merlin_auto_spain
			CRV.select_IS_posting_period current_period , $company_merlin_auto_spain
			CRV.select_IS_reversal_period _next_month_period, $company_merlin_auto_spain
			CRV.check_ignore_unused_currency_checkbox 
			CRV.choose_exclude_from_selection_action
			
			# click on retrieve button
			CRV.click_retrieve_data_button
			
			CRV.set_document_rate _document_currency_gbp_to_eur ,_document_rate
			CRV.set_document_rate _document_currency_usd_to_eur ,_dual_rate
			CRV.set_dual_rate _dual_rate
			CRV.set_unrealized_gains_losses_gla $bd_gla_exchange_gain_loss_us
			CRV.choose_copy_from_source_radio_button
			CRV.choose_summary_level_radio_button
			CRV.click_generate_button
			CRV.click_confirm_message_generate_button # confirm the processing
			SF.wait_for_apex_job
			SF.tab $tab_currency_revaluations
			SF.select_view $bd_select_view_all
			SF.click_button_go
			
			currency_reval_group  = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate ,$crv_revaluation_group_label
			SF.click_link currency_reval_group
			SF.wait_for_search_button
			CRV.click_group_post_button
			SF.wait_for_apex_job
			_assert_data_TST035918 = ["CODATID021066Data.assertions_TST035918();"]
			APEX.execute_commands _assert_data_TST035918
			puts "TST035918: Income statement reversal period Assertions Passed"
		
			gen_end_test "TST035918: Verify that CRV process completed successfully when reversal period is applied in any one Revaluation Type."
		end
	end
	after :all do
		login_user
		_destroy_data_TID021066 = ["CODATID021066Data.selectCompany();","CODATID021066Data.destroyData();"]
		APEX.execute_commands _destroy_data_TID021066
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
	end
end