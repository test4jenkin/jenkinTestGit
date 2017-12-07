#--------------------------------------------------------------------#
#	TID : TID012734
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Cash entry and Matching (UI Test)
# 	Story: 26840 
#--------------------------------------------------------------------#
describe "UI Test - Accounting - Cash entry and Matching", :type => :request do
include_context "login"
include_context "logout_after_each"	
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID012734 : UI Test - Accounting - Cash entry and Matching"
	end
	
	it "TID012734 :  Verify error message will be displayed on updating a 'Complete' status 'Cash entry' from edit list view." do
		gen_start_test "TID012734 : Verify error message will be displayed on updating a 'Complete' status 'Cash entry' from edit list view."
		
		_line = 1
		_column_cash_entry_number = "Cash Entry Number"
		_expected_error_message = "Object validation has failed. Cash Entry: Object validation has failed. You cannot update a cash entry of this status."
		_rate= "5"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true	
		
		gen_start_test "Additional data required"
		begin
			SF.tab $tab_cash_entries
			SF.click_button_new
			CE.set_bank_account $bdu_bank_account_santander_current_account
			CE.line_set_account_name $bdu_account_algernon_partners_co
			FFA.click_new_line
			CE.line_set_cashentryvalue _line , "100.00"
			CE.line_set_account_reference _line, "CE123"
			FFA.click_save_post
			_cash_entry_number = SF.get_page_description
			SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
			SF.set_button_property_for_extended_layout			
		end
		
		gen_start_test "TST016457"
		begin
			SF.tab $tab_cash_entries
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating period
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			FFA.select_period_from_lookup $cashentry_period_lookup_icon, "2015/008", $company_merlin_auto_spain
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating bank account
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			FFA.select_bank_account_from_lookup $cashentry_bank_account_lookup_icon, $bdu_bank_account_apex_eur_b_account, $company_merlin_auto_spain
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating date
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_date_for_standard "05/05/2012"
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating reference
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_reference_for_standard "CE1234"
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating payment method
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_payment_method_for_standard $bdu_payment_method_check
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating charges gla
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_charges_gla_for_standard $bdu_gla_account_payable_control_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating description
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_description_for_standard "Testing TID012734"
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating bank charge
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_bank_charge_for_standard "12.00"
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating dimension1
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_dimension_for_standard $cashentry_dimension_1_label, $bdu_dim1_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating dimension1
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_dimension_for_standard $cashentry_dimension_2_label, $bdu_dim2_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating dimension3
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_dimension_for_standard $cashentry_dimension_3_label, $bdu_dim3_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating dimension4
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_dimension_for_standard $cashentry_dimension_4_label, $bdu_dim4_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating bank account dimension1
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_bank_account_dimension_for_standard $cashentry_bank_account_dimension_1_label, $bdu_dim1_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating bank account dimension2
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_bank_account_dimension_for_standard $cashentry_bank_account_dimension_2_label, $bdu_dim2_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating bank account dimension3
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_bank_account_dimension_for_standard $cashentry_bank_account_dimension_3_label, $bdu_dim3_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating bank account dimension4
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_bank_account_dimension_for_standard $cashentry_bank_account_dimension_4_label, $bdu_dim4_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating account dimension1
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_account_dimension_for_standard $cashentry_account_dimension_1_label, $bdu_dim1_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating account dimension2
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_account_dimension_for_standard $cashentry_account_dimension_2_label, $bdu_dim2_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating account dimension3
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_account_dimension_for_standard $cashentry_account_dimension_3_label, $bdu_dim3_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating account dimension4
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_account_dimension_for_standard $cashentry_account_dimension_4_label, $bdu_dim4_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating cash entry rate
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_cash_entry_rate_for_standard _rate
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating dual rate
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_dual_rate_for_standard _rate
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# updating currency
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			FFA.select_currency_from_lookup $cashentry_currency_lookup, $bdu_currency_usd, $company_merlin_auto_spain
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message, "Expected following error message to be displayed #{_expected_error_message}"
			SF.click_button_cancel
		end
		gen_end_test "TID012734 : Verify error message will be displayed on updating a 'Complete' status 'Cash entry' from edit list view."
	end	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
		SF.choose_visualforce_page $ffa_vf_page_coda_cashentry_edit
		SF.logout
		gen_end_test "TID012734 : UI Test - Accounting - Cash entry and Matching"
	end
end