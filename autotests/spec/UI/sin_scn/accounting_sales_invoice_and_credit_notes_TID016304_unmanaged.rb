#--------------------------------------------------------------------#
#	TID : TID016304
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Sales Invoices & Credit Notes(Batch)
# 	Story: 28373 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Sales Invoice and Credit Notes", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID016304 : Accounting - Sales Invoices & Credit Notes(Batch)"
	end
	
	_field_inv_description = ["Invoice Description"]
	_field_print_status = ["Print Status"]
	_field_to_search_inv_description = "Invoice Description"
	_position_to_add_field = 2
		
	it "TID016304 :  Income Schedule SUT Mode SUT Company Test", :unmanaged => true  do
		gen_start_test "TID016304 :  Income Schedule SUT Mode SUT Company Test"
			
		_field_to_search_inv_number = "Invoice Number"
		_field_jnl_debits = "Debits"
		_permission_set_names = [$ffa_permission_set_acc_billing_background_posting, $ffa_permission_set_acc_billing_background_posting_run_now]
		_amount_745 = "745.00"
		_amount_571_67 = "571.67"
		_amount_571_63 = "571.63"
		_no_of_rows_4 = 4
		_no_of_rows_12 = 12
		
		puts "Additional data"
		begin
			SF.set_user_permission_set_assignment _permission_set_names, $bdu_username_invoicing_clerk, false
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_invoice_line_item_extended_layout
			create_sales_invoices = ["CODATID016304Data.selectCompany();", "CODATID016304Data.createData();", "CODATID016304Data.createDataExt1();", "CODATID016304Data.createDataExt2();", "CODATID016304Data.switchProfile();"]
			APEX.execute_commands create_sales_invoices
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.edit_view_add_remove_fields _field_inv_description , _field_print_status, _position_to_add_field
		end
		
		#Login as Invoicingg clerk
		SF.login_as_user SFINVCLERK_USER 

		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		
		gen_start_test "TST023335 : Edit a SINV in SUT mode: Amend and Delete"
		begin
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			_invoice_number = FFA.get_column_value_in_grid _field_to_search_inv_description , "Test SInv" , _field_to_search_inv_number
			SINX.open_invoice_detail_page _invoice_number
			SINX.view_invoice_line_item_detail_page $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			_inv_line_item1 = SINX.get_line_invoice_line_item_id
			_actual_number_of_inc_schedule = SINX.get_number_of_income_schedule_line_items
			gen_compare _no_of_rows_4, _actual_number_of_inc_schedule, "Expected Total number of Periods to be 4"
			_actual_inc_schedule_amount_array = Array[]
			_actual_inc_schedule_amount_array = SINX.get_all_income_schedule_line_items_amount _inv_line_item1, _actual_number_of_inc_schedule 
			for i in 1.._actual_number_of_inc_schedule
				_inc_schedule_amount = _actual_inc_schedule_amount_array[i-1]
				gen_compare _amount_745, _inc_schedule_amount, "Expected amount of income schedule line items to be "+_amount_745
			end

			SF.click_link _invoice_number
			page.has_text?(_invoice_number)
			SINX.view_invoice_line_item_detail_page $bdu_product_bbk_fuel_pump_power_plus_series_universal
			_inv_line_item2 = SINX.get_line_invoice_line_item_id
			_actual_number_of_inc_schedule = SINX.get_number_of_income_schedule_line_items
			gen_compare _no_of_rows_12, _actual_number_of_inc_schedule, "Expected Total number of Periods to be 12"
			_actual_inc_schedule_amount_array = Array[]
			_actual_inc_schedule_amount_array = SINX.get_all_income_schedule_line_items_amount _inv_line_item2, _actual_number_of_inc_schedule 
			for i in 1.._actual_number_of_inc_schedule
				if(i == _no_of_rows_12)
					_inc_schedule_amount = _actual_inc_schedule_amount_array[i-1]
					gen_compare _amount_571_63, _inc_schedule_amount, "Expected amount of income schedule line items to be "+_amount_571_63
				else
					_inc_schedule_amount = _actual_inc_schedule_amount_array[i-1]
					gen_compare _amount_571_67, _inc_schedule_amount, "Expected amount of income schedule line items to be "+_amount_571_67
				end
			end
		end
		
		gen_start_test "TST023336 : Post a SINV in SUT mode"
		begin
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SINX.open_invoice_detail_page _invoice_number
			SINX.click_post_button
			SINX.click_post_invoice
			SF.tab $tab_background_posting_scheduler
			SF.click_button $ffa_run_now_button
			SF.wait_for_apex_job
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SINX.open_invoice_detail_page _invoice_number
			gen_compare $bdu_document_status_complete, SINX.get_invoice_status, "Expected Status of Sales Invoice to be complete"
			SF.tab $tab_journals
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			_reference_value = "Invoice "+_invoice_number
			_count_jnl_amount_745 = JNL.get_journals_count_having_same_value _reference_value, _field_jnl_debits, _amount_745
			gen_compare _no_of_rows_4, _count_jnl_amount_745, "Expected number of journals to be 4 with amount 745.00"
			_count_jnl_amount_571_67 = JNL.get_journals_count_having_same_value _reference_value, _field_jnl_debits, _amount_571_67
			gen_compare 11, _count_jnl_amount_571_67, "Expected number of journals to be 11 with amount 571.67"
			_count_jnl_amount_571_63 = JNL.get_journals_count_having_same_value _reference_value, _field_jnl_debits, _amount_571_63
			gen_compare 1, _count_jnl_amount_571_63, "Expected number of journals to be 1 with amount 571.63"
		end
	end
	
	after :all do
		login_user
		puts "Revert additional data created for TID016304"
		begin
			destroy_data = ["CODATID016304Data.destroyData();"]
			APEX.execute_commands destroy_data
			FFA.delete_new_data_and_wait
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_standard_user, $ffa_sales_invoice_normal_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_edit
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_new
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_view
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_standard_user, $ffa_sales_invoice_line_item_normal_layout
			FFA.edit_view_add_remove_fields _field_print_status , _field_inv_description, _position_to_add_field
			SF.logout
		end
		gen_end_test "TID016304 : Accounting - Sales Invoices & Credit Notes(Batch)"
	end
end