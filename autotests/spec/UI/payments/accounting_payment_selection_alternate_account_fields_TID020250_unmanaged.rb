#--------------------------------------------------------------------#
#   TID : TID020250
#   Pre-Requisite: Org with basedata deployed; Deploy CODATID020250Data.cls on org.
#   Product Area: Accounting - Payments
#--------------------------------------------------------------------#

describe "Verify Alternate Account implementation on Payment Selection UI", :type => :request do
  include_context "login"
  include_context "logout_after_each"
	_suffix = '#TID020250'
	_corporate_gla_4001 = '4001'
	_corporate_gla_NAMEGLA_ACCOUNTSPAYABLECONTROLEUR = $bd_gla_account_payable_control_eur
	_corporate_gla_NAMEGLA_POSTAGEANDSTATIONERY = $bd_gla_postage_and_stationery
	_corporate_gla_NAMEGLA_VATINPUT = $bd_gla_vat_input
	_default_local_gla = 'Local Default'
	_local_accounts_payable_control_gla = 'Local APC'
	_local_accounts_payable_control_gla_reporting_code = 'Local APC'
	_local_settlement_account_gla = 'Local Settlement Acc 1'
	_local_writeoff_gla = 'Local WriteOff Acc 1'
	_local_gla = 'Local GLA'
	_settlement_discount_local_gla = 'Settlement Discount Local GLA'
	_curreny_write_off_local_gla = 'Currency Write-off Local GLA'

	before :all do
		#Hold Base Data
		gen_start_test "TID020250: Payment selection new field added on UI"
		FFA.hold_base_data_and_wait
		
		begin
			#login and select merlin auto spain company.
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain],true
			#Execute the apex methods
			_create_data = ["CODATID020250Data.selectCompany();", "CODATID020250Data.createData();", "CODATID020250Data.createDataExt1();"]
			APEX.execute_commands _create_data
		end
	end
  
	it "TST033305 - Verify the GLA displayed in GLA picklist on payment selection sencha UI.", :unmanaged => true do
		gen_start_test "TST033305 - Verify the GLA displayed in GLA picklist on payment selection sencha UI."
		begin
			current_date = Time.now
			date_after_60_days = FFA.add_days_to_date current_date , "60"
			SF.tab $tab_payment_selection
			gen_wait_until_object_disappear $page_loadmask_message
			gen_compare _local_gla, PAYSEL.get_gla_checkbox_label, "GLA Checkbox Label is Local GLA"
			
			PAYSEL.set_gla_filter true
			gen_compare _local_gla, PAYSEL.get_filter_gla_label, "Filter GLA picklist label is Local GLA"
			# Check that corporate GLAs are not present in the picklist
			PAYSEL.set_gla_value [_corporate_gla_4001,  $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us ]
			_paysel_gla_not_present = PAYSEL.get_matched_count_gla [_corporate_gla_4001,  $bd_gla_accounts_payable_control_eur, $bd_gla_settlement_discounts_allowed_us ]
			gen_compare 0, _paysel_gla_not_present, "GLAs should not be present #{_corporate_gla_4001}, #{$bd_gla_accounts_payable_control_eur}, #{$bd_gla_settlement_discounts_allowed_us}"
			
			# Check that local gla not fullfilling the default condition are not being shown
			PAYSEL.set_gla_value [_default_local_gla,_local_settlement_account_gla,_local_writeoff_gla]
			_paysel_gla_not_present = PAYSEL.get_matched_count_gla [_default_local_gla,_local_settlement_account_gla,_local_writeoff_gla]
			gen_compare 0, _paysel_gla_not_present, "GLAs should not be present #{_default_local_gla}, #{_local_settlement_account_gla}, #{_local_writeoff_gla}"
			
			# check that only local gla fullfilling the default condition are being shown
			displayed_local_gla = "#{_local_accounts_payable_control_gla} - #{_local_accounts_payable_control_gla_reporting_code}"
			PAYSEL.select_gla_value _local_accounts_payable_control_gla 
			_paysel_gla_present = PAYSEL.get_matched_count_gla [displayed_local_gla]
			gen_compare 1, _paysel_gla_present, "Local GLA #{displayed_local_gla} is present"
		end
		gen_end_test "TST033305 - Verify the GLA displayed in GLA picklist on payment selection sencha UI."
		gen_start_test "TST033306 - Verify Local GLA values are correctly transferred to Classic Payment UI from Payment Selection UI."
		begin
			SF.tab $tab_payment_selection
			gen_wait_until_object_disappear $page_loadmask_message
			PAYSEL.set_gla_filter true
			PAYSEL.select_gla_value _local_accounts_payable_control_gla 
			PAYSEL.set_due_date_end_date_filter date_after_60_days
			PAYSEL.click_retrieve_documents
			gen_wait_until_object_disappear $page_loadmask_message
			PAYSEL.select_all_transactions
			PAYSEL.click_create_payment
			gen_compare _settlement_discount_local_gla,PAYSEL.get_create_payment_settlement_field_label,"Label is #{_settlement_discount_local_gla}"
			gen_compare _curreny_write_off_local_gla,PAYSEL.get_create_payment_writeoff_field_label,"Label is #{_curreny_write_off_local_gla}"
			PAYSEL.set_create_payment_bank_account $bd_bank_account_santander_current_account
			PAYSEL.set_create_payment_settlement_discount _local_settlement_account_gla
			PAYSEL.set_create_payment_currency_write_off _local_writeoff_gla
			PAYSEL.choose_create_payment_payment_media $label_payment_media_check
			PAYSEL.click_create_button
			PAYSEL.click_go_to_payments_home_button
			gen_has_page_title $page_title_payments_home, "Expected user is redirected to Payment home page"
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			SF.edit_list_view $bd_select_view_all, $label_payment_status, 2
			_payment_number = FFA.get_column_value_in_grid $label_payment_status, $bd_payment_retrieved_status, $label_payment_number
			PAY.open_payment_detail_page _payment_number
			gen_compare _local_settlement_account_gla, find($pay_settlement_discount_local_gla_value).text,"Local settlement Discount gla value is #{_local_settlement_account_gla}"
			gen_compare _local_writeoff_gla, find($pay_write_off_local_gla_value).text,"Local writeOff gla value is #{_local_writeoff_gla}"
			gen_compare 1, (PAY.get_row_num_from_acc_to_pay_section $bd_account_audi), "Account retrieved successfully."
		end
		gen_end_test "TST033306 - Verify Local GLA values are correctly transferred to Classic Payment UI from Payment Selection UI."
	end
	
	after :all do
		login_user
		# Delete Test Data
		_delete_data = ["CODATID020250Data.destroyData();"]
		APEX.execute_commands _delete_data
		FFA.delete_new_data_and_wait		
		SF.logout
		gen_end_test "TID020250 : Verify Alternate Account implementation on Payment Selection UI."
	end
end