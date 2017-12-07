#--------------------------------------------------------------------#
#	TID : TID013389 
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Merlin Auto USA- Currency Revaluation (Smoke Test)
# 	Story: 23484 
#--------------------------------------------------------------------#


describe "Smoke Test - Currency revaluation", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID013389: Process currency revaluation for merlin auto usa."
	end
	
	it "TID013389 : Process currency revaluation for merlin auto usa" do
		_line1=1
		_line1_quantity ="1"
		_line1_amount = "1000"
		_document_rate_without_autopost = "0.550000000"
		_dual_rate_without_autopost = "0.60"
		_document_rate_with_autopost = "0.540000000"
		_dual_rate_with_autopost = "0.61"
		_dual_rate_on_crv_document = "0.600000000"
		_dual_rate_on_autopost_crv_document = "0.610000000"
		_document_currency_gbp_to_usd = "GBP to USD"
		_gla_sequence_in_list = 1
		
		SF.app $accounting
		puts "TST017117: Create a Currency Revaluation document and post it."
		begin
			# Pre-requisite
			gen_start_test "Create a new Sales Invoice as a pre-requisite for currency revaluation doc."
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_algernon_partners_co
			SIN.set_currency $bd_currency_gbp
			SIN.add_line _line1 , $bd_product_sla_gold , _line1_quantity , _line1_amount , nil , nil , nil	
			FFA.click_save_post
			gen_end_test "Create a new Sales Invoice as a pre-requisite for currency revaluation doc."
			#1.1
			begin
				gen_start_test "Create a new currency revaluation doc."
				SF.tab $tab_currency_revaluations
				SF.click_button_new
				CRV.check_balance_sheet_checkbox 
				CRV.select_balance_sheet_period_value "Opening Balances"
				# set current periods
				current_year = Date.today.strftime("%Y")
				current_month = Date.today.strftime("%m")
				current_period = current_year + "/0" + current_month
				CRV.select_period_to current_period , $company_merlin_auto_usa
				CRV.select_posting_period current_period , $company_merlin_auto_usa
				CRV.choose_pick_gla_to_include
				page.has_text?($bd_gla_account_receivable_control_usd)
				CRV.pick_gla_from_list $bd_gla_account_receivable_control_usd
				CRV.choose_exclude_from_selection_action
				# click on retrieve button
				CRV.click_retrieve_data_button
				page.has_text?(_document_currency_gbp_to_usd)
				CRV.set_document_rate _document_currency_gbp_to_usd ,_document_rate_without_autopost
				
				CRV.set_unrealized_gains_losses_gla $bd_gla_exchange_gain_loss_us
				CRV.choose_copy_from_source_radio_button
				CRV.choose_summary_level_radio_button
				CRV.click_generate_button
				CRV.click_confirm_message_generate_button # confirm the processing
				SF.wait_for_apex_job
				SF.tab $tab_currency_revaluations
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SF.edit_list_view $bd_select_view_all, $label_crv_status, 5
				SF.edit_list_view $bd_select_view_all, $crv_revaluation_group_label, 6
				# get currency revaluation details
				currency_reval_status = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate_without_autopost ,$label_crv_status
				currency_reval_number = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate_without_autopost ,$label_crv_currency_revaluation_name
				currency_reval_group  = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate_without_autopost ,$crv_revaluation_group_label
				# Assert Status to be In progress				
				gen_compare $bd_document_status_in_progress , currency_reval_status  ,"Expected Currency revaluation status to be In Progress"
				SF.click_link currency_reval_group
				SF.wait_for_search_button
				# Assert that CRV group is marked as complete.
				crv_group_status = CRV.get_currency_revaluation_group_status
				gen_compare $bd_document_status_complete , crv_group_status ,"Expected Currency revaluation group status to be Complete."
			end
			#1.2
			begin				
				# Post the currency revaluation
				gen_start_test "Post the Generated Currency Revaluation document."
				SF.tab $tab_currency_revaluations
				SF.select_view $bd_select_view_all
				SF.click_button_go				
				CRV.open_currency_revaluation_detail_page currency_reval_number
				SF.click_action $ffa_post_button
				SF.wait_for_search_button
				SF.click_button $ffa_post_button # Confirm the process
				SF.wait_for_apex_job
				
				SF.tab $tab_currency_revaluations
				SF.select_view $bd_select_view_all
				SF.click_button_go
				# Assert Status to be Complete.
				currency_reval_status = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate_without_autopost ,$label_crv_status
				gen_compare $bd_document_status_complete , currency_reval_status  ,"Expected Currency revaluation status to be Complete"
			end
			#1.3
			begin
				# New Currency Revaluation and click on Generate and post button
				gen_start_test "Generate and Post a currency revaluation doc."
				SF.tab $tab_currency_revaluations
				SF.click_button_new
				CRV.check_balance_sheet_checkbox 
				CRV.select_balance_sheet_period_value "Opening Balances"
				# set current periods
				current_year = Date.today.strftime("%Y")
				current_month = Date.today.strftime("%m")
				current_period = current_year + "/0" + current_month
				CRV.select_period_to current_period , $company_merlin_auto_usa
				CRV.select_posting_period current_period , $company_merlin_auto_usa
				CRV.choose_pick_gla_to_include
				page.has_text?($bd_gla_account_receivable_control_usd)
				CRV.pick_gla_from_list $bd_gla_account_receivable_control_usd
				CRV.choose_exclude_from_selection_action
				# click on retrieve button
				CRV.click_retrieve_data_button
				page.has_text?(_document_currency_gbp_to_usd)
				CRV.set_document_rate _document_currency_gbp_to_usd ,_document_rate_with_autopost
				
				CRV.set_unrealized_gains_losses_gla $bd_gla_exchange_gain_loss_us
				CRV.choose_copy_from_source_radio_button
				CRV.choose_summary_level_radio_button
				CRV.click_generate_and_post_button
				CRV.click_confirm_message_generate_and_post_button # confirm the processing
				SF.wait_for_apex_job
				SF.tab $tab_currency_revaluations
				SF.select_view $bd_select_view_all
				SF.click_button_go
				# get currency revaluation details
				currency_reval_status = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate_with_autopost ,$label_crv_status
				currency_reval_number = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate_with_autopost ,$label_crv_currency_revaluation_name
				currency_reval_group  = FFA.get_column_value_in_grid $crv_document_exchange_rate_label ,_document_rate_with_autopost ,$crv_revaluation_group_label
				# Assert Status to be Complete
				gen_compare $bd_document_status_complete , currency_reval_status  ,"Expected Currency revaluation status to be Complete"
				SF.click_link currency_reval_group
				SF.wait_for_search_button
				# Assert that CRV group is marked as complete.
				gen_compare $bd_document_status_complete , CRV.get_currency_revaluation_group_status  ,"Expected Currency revaluation group status to be Complete."
			end
		end
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID013389: Process currency revaluation for merlin auto usa."
		SF.logout
	end
end