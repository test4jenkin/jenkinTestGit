#--------------------------------------------------------------------#
#	TID : TID020818
# 	Pre-Requisite : Cash Entry Extension package on org
#  	Product Area: Cash Entry extended layout
#--------------------------------------------------------------------#

describe "Smoke Test:Create Cash Entry on extended layout", :type => :request do
include_context "login"

	_current_date = Date.today.strftime("%d/%m/%Y")
	_current_period = ""
	_reciept_cash_entry_num = ""
	_ce_value_100 = "100.00"
	_ce_value_200 = "200.00"
	_ce_value_0 = "0.00"
	_row2 = 2
	_line_num2 = 2
	
	before :all do
		#Hold Base Data
		gen_start_test "TID020818"
		FFA.hold_base_data_and_wait
		# Change Cash entry and its line item layout to Extended.
		SF.edit_extended_layout $ffa_object_cash_entry, $ffa_profile_system_administrator, $ffa_cash_entry_extended_layout
		SF.edit_extended_layout $ffa_object_cash_entry_line_item, $ffa_profile_system_administrator, $ffa_cash_entry_line_item_line_item_extended_layout
		SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
		SF.set_button_property_for_extended_layout
		SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
		SF.set_button_property_for_extended_layout
		SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
		SF.set_button_property_for_extended_layout
	end
	
	
	it "TID020818-TST034981 : Create a cash entry of Receipt type and post it on extended layout. " do
		gen_start_test "TID020818-TST034981"
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		SF.tab $tab_cash_entries
		
		# Create New Cash Entry
		SF.click_button_new
		CEX.select_cash_entry_type  $bd_cash_entry_receipt_type
		CEX.uncheck_derive_bank_account_checkbox
		CEX.set_bank_account_name $bd_bank_account_santander_usd_account
		CEX.set_cash_entry_date  _current_date
		CEX.check_derive_period_checkbox
		CEX.check_derive_currency_checkbox
		CEX.select_cash_entry_payment_method $bd_cash_entry_payment_method_cash
		CEX.click_save_button
		
		# Assert saved Cash Entry
		_current_period = FFA.get_current_period
		_reciept_cash_entry_num = CEX.get_cash_entry_number
		
		gen_compare $bd_cash_entry_receipt_type , CEX.get_cash_entry_type , "Expected #{_reciept_cash_entry_num} of reciept type."
		gen_compare _current_period , CEX.get_cash_entry_period , "Expected #{_current_period} for #{_reciept_cash_entry_num} of reciept type."
		gen_compare $bd_currency_usd , CEX.get_cash_entry_currency , "Expected USD currency for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_value , "Expected 0.00 cash entry value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare "" , CEX.get_cash_entry_bank_account_value , "Expected cash entry bank account value for #{_reciept_cash_entry_num} of reciept type to be blank."
		# Add new line
		CEX.click_add_new_line_button
		CEX.set_line_item_account $bd_account_cambridge_auto
		CEX.check_derive_line_num_checkbox
		CEX.check_derive_payment_method_checkbox
		CEX.set_line_item_cash_entry_value _ce_value_100
		CEX.click_save_button
		
		# Assert New line added and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page
		SF.click_link _reciept_cash_entry_num
		SF.wait_for_search_button
		
		# Click on manage line button and add line button to add new row
		CEX.click_manage_line_button
		CEX.click_add_line_button
		CE.set_manage_line_account _row2 , $bd_account_cambridge_auto
		CE.set_manage_line_ce_value _row2 , _ce_value_100
		
		#Assert autocomplete value
		_line2_net_value = CEX.get_line_net_value _row2
		gen_compare _ce_value_100 , _line2_net_value , "Expected 100.00 cash entry line net value for #{_reciept_cash_entry_num} of reciept type."
		expect(page).to have_text($bd_cash_entry_payment_method_electronic ,:count => 2)
		gen_report_test "Expected Payment method to be auto -populated as electronic for new row."
		# Save cash entry line item
		CEX.click_save_button
		
		# Open line item detail page
		CEX.open_cash_entry_line_detail_page _line_num2
		# Assert New line added through manage line and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page and post the Cash entry
		SF.click_link _reciept_cash_entry_num
		SF.wait_for_search_button
		CEX.click_post_button
		
		# Assert posted cash entry
		gen_compare  $bd_document_status_complete, CEX.get_status  , "Expected status as complete for  #{_reciept_cash_entry_num}."
		gen_compare _ce_value_200 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_reciept_cash_entry_num} of reciept type."
		gen_compare _ce_value_200 , CEX.get_net_banked_value , "Expected 100.00 cash entry net banked value for #{_reciept_cash_entry_num} of reciept type."

		gen_end_test "TID020818-TST034981"
		SF.logout
	end
	
	it "TID020818-TST034984 : Create a cash entry of Refund type and post it on extended layout. " do
		login_user
		gen_start_test "TID020818-TST034984"
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		SF.tab $tab_cash_entries
		
		# Create New Cash Entry
		SF.click_button_new
		CEX.select_cash_entry_type  $bd_cash_entry_refund_type
		CEX.uncheck_derive_bank_account_checkbox
		CEX.set_bank_account_name $bd_bank_account_santander_usd_account
		CEX.set_cash_entry_date  _current_date
		CEX.check_derive_period_checkbox
		CEX.check_derive_currency_checkbox
		CEX.select_cash_entry_payment_method $bd_cash_entry_payment_method_cash
		CEX.click_save_button
		
		# Assert saved Cash Entry
		_current_period = FFA.get_current_period
		_refund_cash_entry_num = CEX.get_cash_entry_number
		
		gen_compare $bd_cash_entry_refund_type , CEX.get_cash_entry_type , "Expected #{_refund_cash_entry_num} of refund type."
		gen_compare _current_period , CEX.get_cash_entry_period , "Expected #{_current_period} for #{_refund_cash_entry_num} of refund type."
		gen_compare $bd_currency_usd , CEX.get_cash_entry_currency , "Expected USD currency for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_value , "Expected 0.00 cash entry value for #{_refund_cash_entry_num} of refund type."
		gen_compare "" , CEX.get_cash_entry_bank_account_value , "Expected cash entry bank account value for #{_refund_cash_entry_num} of refund type to be blank."
		# Add new line
		CEX.click_add_new_line_button
		CEX.set_line_item_account $bd_account_cambridge_auto
		CEX.check_derive_line_num_checkbox
		CEX.check_derive_payment_method_checkbox
		CEX.set_line_item_cash_entry_value _ce_value_100
		CEX.click_save_button
		
		# Assert New line added and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_refund_cash_entry_num} of refund type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page
		SF.click_link _refund_cash_entry_num
		SF.wait_for_search_button
		
		# Click on manage line button and add line button to add new row
		CEX.click_manage_line_button
		CEX.click_add_line_button
		CE.set_manage_line_account _row2 , $bd_account_cambridge_auto
		CE.set_manage_line_ce_value _row2 , _ce_value_100
		
		#Assert autocomplete value
		_line2_net_value = CEX.get_line_net_value _row2
		gen_compare _ce_value_100 , _line2_net_value , "Expected 100.00 cash entry line net value for #{_refund_cash_entry_num} of refund type."
		expect(page).to have_text($bd_cash_entry_payment_method_electronic ,:count => 2)
		gen_report_test "Expected Payment method to be auto -populated as electronic for new row."
		# Save cash entry line item
		CEX.click_save_button
		
		# Open line item detail page
		CEX.open_cash_entry_line_detail_page _line_num2
		# Assert New line added through manage line and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_refund_cash_entry_num} of refund type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page and post the Cash entry
		SF.click_link _refund_cash_entry_num
		SF.wait_for_search_button
		CEX.click_post_button
		
		# Assert posted cash entry
		gen_compare  $bd_document_status_complete, CEX.get_status  , "Expected status as complete for  #{_refund_cash_entry_num}."
		gen_compare _ce_value_200 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_refund_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_net_banked_value , "Expected 100.00 cash entry net banked value for #{_refund_cash_entry_num} of refund type."

		gen_end_test "TID020818-TST034984"
		SF.logout
	end
	
	it "TID020818-TST034985 : Create a cash entry of Payment type and post it on extended layout. " do
		login_user
		gen_start_test "TID020818-TST034986"
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		SF.tab $tab_cash_entries
		
		# Create New Cash Entry
		SF.click_button_new
		CEX.select_cash_entry_type  $bd_cash_entry_payment_type
		CEX.uncheck_derive_bank_account_checkbox
		CEX.set_bank_account_name $bd_bank_account_santander_usd_account
		CEX.set_cash_entry_date  _current_date
		CEX.check_derive_period_checkbox
		CEX.check_derive_currency_checkbox
		CEX.select_cash_entry_payment_method $bd_cash_entry_payment_method_cash
		CEX.click_save_button
		
		# Assert saved Cash Entry
		_current_period = FFA.get_current_period
		_payment_cash_entry_num = CEX.get_cash_entry_number
		
		gen_compare $bd_cash_entry_payment_type , CEX.get_cash_entry_type , "Expected #{_payment_cash_entry_num} of refund type."
		gen_compare _current_period , CEX.get_cash_entry_period , "Expected #{_current_period} for #{_payment_cash_entry_num} of refund type."
		gen_compare $bd_currency_usd , CEX.get_cash_entry_currency , "Expected USD currency for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_value , "Expected 0.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare "" , CEX.get_cash_entry_bank_account_value , "Expected cash entry bank account value for #{_payment_cash_entry_num} of refund type to be blank."
		# Add new line
		CEX.click_add_new_line_button
		CEX.set_line_item_account $bd_account_bmw_automobiles
		CEX.check_derive_line_num_checkbox
		CEX.check_derive_payment_method_checkbox
		CEX.set_line_item_cash_entry_value _ce_value_100
		CEX.click_save_button
		
		# Assert New line added and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_payment_cash_entry_num} of refund type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page
		SF.click_link _payment_cash_entry_num
		SF.wait_for_search_button
		
		# Click on manage line button and add line button to add new row
		CEX.click_manage_line_button
		CEX.click_add_line_button
		CE.set_manage_line_account _row2 , $bd_account_bmw_automobiles
		CE.set_manage_line_ce_value _row2 , _ce_value_100
		
		#Assert autocomplete value
		_line2_net_value = CEX.get_line_net_value _row2
		gen_compare _ce_value_100 , _line2_net_value , "Expected 100.00 cash entry line net value for #{_payment_cash_entry_num} of refund type."
		expect(page).to have_text($bd_cash_entry_payment_method_electronic ,:count => 2)
		gen_report_test "Expected Payment method to be auto -populated as electronic for new row."
		# Save cash entry line item
		CEX.click_save_button
		
		# Open line item detail page
		CEX.open_cash_entry_line_detail_page _line_num2
		# Assert New line added through manage line and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_0, CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_payment_cash_entry_num} of refund type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page and post the Cash entry
		SF.click_link _payment_cash_entry_num
		SF.wait_for_search_button
		CEX.click_post_button
		
		# Assert posted cash entry
		gen_compare  $bd_document_status_complete, CEX.get_status  , "Expected status as complete for  #{_payment_cash_entry_num}."
		gen_compare _ce_value_200 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_net_banked_value , "Expected 100.00 cash entry net banked value for #{_payment_cash_entry_num} of refund type."

		gen_end_test "TID020818-TST034985"
		SF.logout
	end
	
	it "TID020818-TST034986 : Create a cash entry of Payment refund type and post it on extended layout. " do
		login_user
		gen_start_test "TID020818-TST034986"
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		SF.tab $tab_cash_entries
		
		# Create New Cash Entry
		SF.click_button_new
		CEX.select_cash_entry_type  $bd_cash_entry_payment_refund_type
		CEX.uncheck_derive_bank_account_checkbox
		CEX.set_bank_account_name $bd_bank_account_santander_usd_account
		CEX.set_cash_entry_date  _current_date
		CEX.check_derive_period_checkbox
		CEX.check_derive_currency_checkbox
		CEX.select_cash_entry_payment_method $bd_cash_entry_payment_method_cash
		CEX.click_save_button
		
		# Assert saved Cash Entry
		_current_period = FFA.get_current_period
		_payment_cash_entry_num = CEX.get_cash_entry_number
		
		gen_compare $bd_cash_entry_payment_refund_type , CEX.get_cash_entry_type , "Expected #{_payment_cash_entry_num} of refund type."
		gen_compare _current_period , CEX.get_cash_entry_period , "Expected #{_current_period} for #{_payment_cash_entry_num} of refund type."
		gen_compare $bd_currency_usd , CEX.get_cash_entry_currency , "Expected USD currency for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_value , "Expected 0.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare "" , CEX.get_cash_entry_bank_account_value , "Expected cash entry bank account value for #{_payment_cash_entry_num} of refund type to be blank."
		# Add new line
		CEX.click_add_new_line_button
		CEX.set_line_item_account $bd_account_bmw_automobiles
		CEX.check_derive_line_num_checkbox
		CEX.check_derive_payment_method_checkbox
		CEX.set_line_item_cash_entry_value _ce_value_100
		CEX.click_save_button
		
		# Assert New line added and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_payment_cash_entry_num} of refund type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page
		SF.click_link _payment_cash_entry_num
		SF.wait_for_search_button
		
		# Click on manage line button and add line button to add new row
		CEX.click_manage_line_button
		CEX.click_add_line_button
		CE.set_manage_line_account _row2 , $bd_account_bmw_automobiles
		CE.set_manage_line_ce_value _row2 , _ce_value_100
		
		#Assert autocomplete value
		_line2_net_value = CEX.get_line_net_value _row2
		gen_compare _ce_value_100 , _line2_net_value , "Expected 100.00 cash entry line net value for #{_payment_cash_entry_num} of refund type."
		expect(page).to have_text($bd_cash_entry_payment_method_electronic ,:count => 2)
		gen_report_test "Expected Payment method to be auto -populated as electronic for new row."
		# Save cash entry line item
		CEX.click_save_button
		
		# Open line item detail page
		CEX.open_cash_entry_line_detail_page _line_num2
		# Assert New line added through manage line and other values of cash entry
		gen_compare _ce_value_100 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_100 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_0 , CEX.get_cash_entry_line_charge_value , "Expected 0.00 cash entry line charges value for #{_payment_cash_entry_num} of refund type."
		gen_compare $bd_cash_entry_payment_method_electronic , CEX.get_line_item_payment_method  , "Expected payment method as #{CEX.get_line_item_payment_method} for new line item added."
		
		# Navigate to cash entry detail page and post the Cash entry
		SF.click_link _payment_cash_entry_num
		SF.wait_for_search_button
		CEX.click_post_button
		
		# Assert posted cash entry
		gen_compare  $bd_document_status_complete, CEX.get_status  , "Expected status as complete for  #{_payment_cash_entry_num}."
		gen_compare _ce_value_200 , CEX.get_cash_entry_value , "Expected 100.00 cash entry value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_bank_account_value , "Expected 100.00 cash entry bank account value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_cash_entry_net_value , "Expected 100.00 cash entry net value for #{_payment_cash_entry_num} of refund type."
		gen_compare _ce_value_200 , CEX.get_net_banked_value , "Expected 100.00 cash entry net banked value for #{_payment_cash_entry_num} of refund type."

		gen_end_test "TID020818-TST034986"
		SF.logout
	end

	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		# change layout back to normal
		SF.edit_extended_layout $ffa_object_cash_entry, $ffa_profile_system_administrator, $ffa_cash_entry_normal_layout
		SF.edit_extended_layout $ffa_object_cash_entry_line_item, $ffa_profile_system_administrator, $ffa_cash_entry_line_item_line_item_normal_layout
		SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_new
		SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_edit
		SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_view
		gen_end_test "TID020818"
		SF.logout 
	end
end	