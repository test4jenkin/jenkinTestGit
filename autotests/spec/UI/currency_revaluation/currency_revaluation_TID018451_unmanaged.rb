#--------------------------------------------------------------------#
#	TID : TID018451 
# 	Pre-Requisite : Base data should exist on the org; Deploy CODATID018451Data.cls on org.
#  	Product Area: Merlin Auto Spain- Currency Revaluation Regression
# 	driver=firefox rspec -fd -c spec/UI/currency_revaluation_TID018451.rb -fh -o pin_ext.html
#--------------------------------------------------------------------#


describe "Regression - Currency revaluation - TID018451", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID018451: Verify that user is able to revalue Only Home Value/ Dual Value."
	end
	
	it "TID018451 : Process currency revaluation for merlin auto spain", :unmanaged => true do
		_line1=1
		_line1_quantity ="1"
		_line1_amount = "1000"
		_document_rate = "0.7"
		_dual_rate = "1.4"
		_document_currency_gbp_to_eur = "GBP to EUR"
		_currency_reval_list_view_text = "Currency Revaluations"
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		begin
		_create_data = ["CODATID018451Data.selectCompany();", "CODATID018451Data.createData();", "CODATID018451Data.switchProfile();"]
		APEX.execute_commands _create_data
		SF.wait_for_apex_job
		end

		puts "TST028887: Verify that user is able to revalue only home value for a currency."
		begin
			gen_start_test "TST028887: Verify that user is able to revalue only home value for a currency."
			SF.tab $tab_currency_revaluations
			gen_wait_for_text _currency_reval_list_view_text
			SF.click_button_new
			CRV.check_balance_sheet_checkbox 
			CRV.select_balance_sheet_period_value "Opening Balances"
			# set current periods
			current_year = Date.today.strftime("%Y")
			current_month = Date.today.strftime("%m")
			next_month = current_month.to_i+1
			if next_month > 9
				next_period = current_year + "/0" + next_month.to_s
			else
				next_period = current_year + "/00" + next_month.to_s
			end
			current_period = current_year + "/0" + current_month
			CRV.select_period_to current_period , $company_merlin_auto_spain
			CRV.select_posting_period next_period , $company_merlin_auto_spain
			CRV.choose_exclude_from_selection_action
			# click on retrieve button
			CRV.click_retrieve_data_button
			page.has_text?(_document_currency_gbp_to_eur)
			CRV.set_document_rate _document_currency_gbp_to_eur ,_document_rate
			CRV.set_checkbox_dual_currency
			CRV.set_unrealized_gains_losses_gla $bd_gla_account_receivable_control_eur
			CRV.choose_copy_from_source_radio_button
			CRV.choose_summary_level_radio_button
			CRV.click_generate_button
			CRV.click_confirm_message_generate_button # confirm the processing
			SF.wait_for_apex_job
			_assert_data_TST028887 = ["CODATID018451Data.assertions_TST028887();"]
			APEX.execute_commands _assert_data_TST028887
			puts "TST028887:Assertions Passed"
			gen_end_test "TST028887: Verify that user is able to revalue only home value for a currency."
		end
		
		puts "TST028888: Verify that user is able to revalue only dual value for a currency."
		begin
			gen_start_test "TST028888: Verify that user is able to revalue only dual value for a currency."
			SF.tab $tab_currency_revaluations
			gen_wait_for_text _currency_reval_list_view_text
			SF.click_button_new
			CRV.check_balance_sheet_checkbox 
			CRV.select_balance_sheet_period_value "Opening Balances"
			# set current periods
			current_year = Date.today.strftime("%Y")
			current_month = Date.today.strftime("%m")
			current_period = current_year + "/0" + current_month
			CRV.select_period_to current_period , $company_merlin_auto_spain
			CRV.select_posting_period current_period , $company_merlin_auto_spain
			CRV.choose_exclude_from_selection_action
			# click on retrieve button
			CRV.click_retrieve_data_button
			page.has_text?(_document_currency_gbp_to_eur)
			CRV.set_document_rate _document_currency_gbp_to_eur ,""
			CRV.set_dual_rate _dual_rate
			CRV.set_unrealized_gains_losses_gla $bd_gla_account_receivable_control_eur
			CRV.choose_copy_from_source_radio_button
			CRV.choose_detail_level_radio_button
			CRV.click_generate_button
			CRV.click_confirm_message_generate_button # confirm the processing
			SF.wait_for_apex_job
			_assert_data_TST028888 = ["CODATID018451Data.assertions_TST028888();"]
			APEX.execute_commands _assert_data_TST028888
			puts "TST028888:Assertions Passed"
			gen_end_test "TST028888: Verify that user is able to revalue only dual value for a currency."
		end
	end
	after :all do
		login_user
		_destroy_data_TID018451 = ["CODATID018451Data.selectCompany();","CODATID018451Data.destroyData();"]
		APEX.execute_commands _destroy_data_TID018451
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID018451: Verify that user is able to revalue Only Home Value/ Dual Value."
		SF.logout
	end
end