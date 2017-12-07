#--------------------------------------------------------------------#
#	TID : TID016374
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Sales Invoices & Credit Notes(Batch)
# 	Story: 28478 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Sales Invoice and Credit Notes", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID016374 : Accounting - Sales Invoices & Credit Notes(Batch)"
	end
	
	_field_inv_description = ["Invoice Description"]
	_field_print_status = ["Print Status"]
	_field_to_search_inv_description = "Invoice Description"
	_position_to_add_field = 2
		
	it "TID016374 :  Sales invoice with two products with the different Income Schedule and add a product with different Income", :unmanaged => true  do
		gen_start_test "TID016374 :  Sales invoice with two products with the different Income Schedule and add a product with different Income"
			
		_field_to_search_inv_number = "Invoice Number"
		_field_jnl_debits = "Debits"
		_permission_set_names = [$ffa_permission_set_acc_billing_background_posting, $ffa_permission_set_acc_billing_background_posting_run_now]
		_amount_149 = "149.00"
		_amount_66 = "66.00"
		_amount_210 = "210.00"
		_no_of_rows_4 = 4
		_no_of_rows_2 = 2
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
			create_sales_invoice = ["CODATID016374Data.selectCompany();", "CODATID016374Data.createData();", "CODATID016374Data.createDataExt1();", "CODATID016374Data.switchProfile();"]
			APEX.execute_commands create_sales_invoice
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.edit_view_add_remove_fields _field_inv_description , _field_print_status, _position_to_add_field
			SF.tab $tab_journals
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			SF.edit_list_view $bdu_select_view_all, _field_jnl_debits, 2
		end
		
		#Login as invoicing clerk.
		SF.login_as_user SFINVCLERK_USER 

		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		
		gen_start_test "TST023560 : Sales invoice with two products with the different Income Schedule and add a product with different Income"
		begin
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			_invoice_number = FFA.get_column_value_in_grid _field_to_search_inv_description , "Test SInv" , _field_to_search_inv_number
			SINX.open_invoice_detail_page _invoice_number
			SINX.view_invoice_line_item_detail_page $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			_inv_line_item1 = SINX.get_line_invoice_line_item_id
			_actual_number_of_inc_schedule = SINX.get_number_of_income_schedule_line_items
			gen_compare _no_of_rows_12, _actual_number_of_inc_schedule, "Expected Total number of Periods to be 12"
			_actual_inc_schedule_amount_array = Array[]
			_actual_inc_schedule_amount_array = SINX.get_all_income_schedule_line_items_amount _inv_line_item1 , _actual_number_of_inc_schedule
			for i in 1.._actual_number_of_inc_schedule
				_inc_schedule_amount = _actual_inc_schedule_amount_array[i-1]
				gen_compare _amount_149, _inc_schedule_amount, "Expected amount of income schedule line items to be "+_amount_149
			end

			SF.click_link _invoice_number
			SINX.view_invoice_line_item_detail_page $bdu_product_bendix_front_brake_pad_1975_83_chrysler_cordoba
			_inv_line_item2 = SINX.get_line_invoice_line_item_id
			_actual_number_of_inc_schedule = SINX.get_number_of_income_schedule_line_items
			gen_compare _no_of_rows_4, _actual_number_of_inc_schedule, "Expected Total number of Periods to be 4"
			_actual_inc_schedule_amount_array = Array[]
			_actual_inc_schedule_amount_array = SINX.get_all_income_schedule_line_items_amount _inv_line_item2 , _actual_number_of_inc_schedule
			for i in 1.._actual_number_of_inc_schedule
				_inc_schedule_amount = _actual_inc_schedule_amount_array[i-1]
				gen_compare _amount_66, _inc_schedule_amount, "Expected amount of income schedule line items to be "+_amount_66
			end
			
			SF.click_link _invoice_number
			SF.wait_for_search_button
			SINX.view_invoice_line_item_detail_page $bdu_product_bosch_oil_filter_ford_mustang_1994_2003
			_inv_line_item3 = SINX.get_line_invoice_line_item_id
			_actual_number_of_inc_schedule = SINX.get_number_of_income_schedule_line_items
			gen_compare _no_of_rows_2, _actual_number_of_inc_schedule, "Expected Total number of Periods to be 2"
			_actual_inc_schedule_amount_array = Array[]
			_actual_inc_schedule_amount_array = SINX.get_all_income_schedule_line_items_amount _inv_line_item3 , _actual_number_of_inc_schedule
			for i in 1.._actual_number_of_inc_schedule
				_inc_schedule_amount = _actual_inc_schedule_amount_array[i-1]
				gen_compare _amount_210, _inc_schedule_amount, "Expected amount of income schedule line items to be "+_amount_210
			end
		end
		
		gen_start_test "TST023561 : Post a SINV in SUT mode"
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
			_count_jnl_amount_149 = JNL.get_journals_count_having_same_value _reference_value, _field_jnl_debits, _amount_149
			gen_compare _no_of_rows_12, _count_jnl_amount_149, "Expected number of journals to be 12 with amount "+_amount_149
			_count_jnl_amount_66 = JNL.get_journals_count_having_same_value _reference_value, _field_jnl_debits, _amount_66
			gen_compare _no_of_rows_4, _count_jnl_amount_66, "Expected number of journals to be 4 with amount "+_amount_66
			_count_jnl_amount_210 = JNL.get_journals_count_having_same_value _reference_value, _field_jnl_debits, _amount_210
			gen_compare _no_of_rows_2, _count_jnl_amount_210, "Expected number of journals to be 2 with amount "+_amount_210
		end
	end
	
	after :all do
		login_user
		puts "Revert additional data created for TID016374"
		begin
			destroy_data = ["CODATID016374Data.destroyData();"]
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
			SF.tab $tab_sales_invoices
			SF.select_view $bdu_select_view_all
			SF.click_button_go
			FFA.edit_view_add_remove_fields _field_print_status , _field_inv_description, _position_to_add_field
			SF.logout
		end
		gen_end_test "TID016374 : Accounting - Sales Invoices & Credit Notes(Batch)"
	end
end