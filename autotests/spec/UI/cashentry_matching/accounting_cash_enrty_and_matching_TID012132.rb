#--------------------------------------------------------------------#
#	TID : TID012132
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Cash entry and Matching (UI Test)
# 	Story: 26949 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Cash entry and Matching", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID012132 : Accounting - Cash entry and Matching UI Test"
	end
	
	it "TID012132 :  error message will be displayed on updating a 'Complete' status 'Cash entry' from edit list view on Classic UI." do
		gen_start_test "TID012132 :  error message will be displayed on updating a 'Complete' status 'Cash entry' from edit list view on Classic UI."
		
		_column_cash_entry_number = "Cash Entry Number"
		_expected_error_message = "Cash Entry: Object validation has failed. You cannot update a cash entry of this status."
		_expected_line_item_error_message = "Cash Entry Line Item: Object validation has failed. You cannot update a cash entry of this status."
		_line = 1
		_line_2 = 2
		_text_tid012132 = "TID012132"
		_cashentry_value_200 = "200.00"
		_charge_20 = "20.00"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		gen_start_test "Additional data required for TID012132"
		begin
			SF.new_custom_setting $ffa_custom_setting_accounting_settings
			SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, true
			SF.click_button_save
			SF.tab $tab_cash_entries
			SF.click_button_new
			CE.set_bank_account $bdu_bank_account_santander_current_account
			CE.line_set_account_name $bdu_account_algernon_partners_co
			FFA.click_new_line
			CE.line_set_cashentryvalue _line , "100.00"
			CE.line_set_account_reference _line, "CE123"
			FFA.click_save_post
			_cash_entry_number = CE.get_cash_entry_number
			gen_compare	$bdu_document_status_complete, CE.get_cash_entry_status, "Expected cash entry status to be complete"
			SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_cashentry_edit
			#get user locale
			_user_locale = gen_get_current_user_locale
		end
		
		gen_start_test "TST015543"
		begin
			SF.tab $tab_cash_entries
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating cash entry period
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			FFA.select_period_from_lookup $cashentry_period_lookup_icon, "2015/008", $company_merlin_auto_spain
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating Bank account
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.select_bank_account_from_lookup $cashentry_bank_account_lookup_icon, $bdu_bank_account_apex_eur_b_account, $company_merlin_auto_spain
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating date
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			_date = gen_get_current_date
			_date_after_5_days = _date + 5
			_date_uk_locale = gen_locale_format_date _date_after_5_days, _user_locale
			CE.set_date _date_uk_locale
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating Reference
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_reference _text_tid012132
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating Payment method
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_payment_method $bdu_payment_method_check
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating Bank Charges GLA
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_bank_charges_gla $bdu_gla_account_payable_control_eur
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating description
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_cash_entry_description _text_tid012132
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating bank charge
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.set_bank_charge _charge_20
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating account reference in account line item
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.line_set_account_reference _line, _text_tid012132
			SF.click_button_save
			gen_include _expected_line_item_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating Payment method in account line item
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.line_set_payment_method_value _line , $bdu_payment_method_cash
			SF.click_button_save
			gen_include _expected_line_item_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating Cash entry value in account line item
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.line_set_cashentryvalue _line , _cashentry_value_200
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Updating line charges in account line item
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.line_set_line_charges _line, _charge_20
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
		
			# Delete line item
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			FFA.click_cross_link_to_delete_line_item _line
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			
			# Add account line items
			FFA.click_edit_link_on_list_gird _column_cash_entry_number , _cash_entry_number
			CE.line_set_account_name $bdu_account_algernon_partners_co
			FFA.click_new_line
			CE.line_set_cashentryvalue _line_2 , _cashentry_value_200
			CE.line_set_account_reference _line_2, "CE1234"
			SF.click_button_save
			gen_include _expected_error_message, FFA.get_error_message2, "Expected following error message to be displayed : #{_expected_error_message}"
			SF.click_button_cancel
			SF.select_view $bdu_select_view_all
			SF.click_button_go
		end
		gen_end_test "TID012132 :  error message will be displayed on updating a 'Complete' status 'Cash entry' from edit list view on Classic UI."
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		SF.new_custom_setting $ffa_custom_setting_accounting_settings
		SF.set_custom_setting_property $ffa_accounting_settings_enable_edit_dimensions_after_posting, false
		SF.click_button_save
		gen_end_test "TID012132 : Accounting - Cash entry and Matching UI Test"
	end
end