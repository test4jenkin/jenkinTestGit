#--------------------------------------------------------------------#
#	TID : TID012480
# 	Pre-Requisite : Org with basedata deployed;Deploy CODATID012480Data.cls on org.
#  	Product Area: Accounting - Income Schedule (UI Test)
# 	Story: 27346 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Income Schedule", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	
	_line_number1 = 1
	_line_number2= 2
	_quantity_1 =1
	_unit_price_100 = 100
	_income_schedule1= "Test Income Schedule 1"
	_income_schedule2= "Test Income Schedule 2"
	it "TID012480 : No currency adjustment journals shoudl be created if currency adjustment journal=false while posting sales invoice. ", :unmanaged => true  do
		gen_start_test "TID012480: Create Invoice without having currency adjustment journals."
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		APEX.execute_commands ["CODATID012480Data.selectCompany();","CODATID012480Data.createData();"]
		
		#Extract initial Journal count
		SF.tab $tab_journals
		SF.select_view $bd_select_view_all
		SF.click_button_go
		SF.wait_for_search_button
		initial_journal_count = FFA.ffa_listview_get_rows
				
		SF.tab $tab_sales_invoices
		SF.click_button_new
		SIN.set_account $bdu_account_cambridge_auto
		SIN.set_currency $bdu_currency_usd
		SIN.check_generate_adjustment_journal false
		FFA.click_new_line
		SIN.line_set_product_name _line_number1, $bdu_product_auto_com_clutch_kit_1989_dodge_raider
		SIN.line_set_quantity _line_number1,_quantity_1
		SIN.line_set_unit_price _line_number1, _unit_price_100
		SIN.line_set_income_schedule  _line_number1 , _income_schedule1
		FFA.click_new_line
		SIN.line_set_product_name _line_number2, $bdu_product_bbk_fuel_pump_power_plus_series_universal
		SIN.line_set_quantity _line_number2,_quantity_1
		SIN.line_set_unit_price _line_number2, _unit_price_100
		SIN.line_set_income_schedule  _line_number2 , _income_schedule2
		FFA.click_save_post
		page.has_css? $page_vf_message_text
		FFA.click_save_post
		SF.wait_for_search_button
		SF.tab $tab_background_posting_scheduler
		SF.click_button $ffa_run_now_button
		SF.wait_for_apex_job
		
		
		SF.tab $tab_journals
		SF.select_view $bd_select_view_all
		SF.click_button_go
		SF.wait_for_search_button
		new_journal_count = FFA.ffa_listview_get_rows
		actual_journal_count = new_journal_count - initial_journal_count
		journal_count = initial_journal_count+1
		
		for i in 1..actual_journal_count do
			JNL.open_journal_detail_page_by_position journal_count
			gen_compare $bdu_document_status_complete , JNL.get_journal_status , "Expected journal Status to be Complete. Actual: " + JNL.get_journal_status
			gen_include "Income Schedule" , JNL.get_journal_description , "Expected all journals created to be of Income schedule type and not Currency Adjustment. Got journal type: "+JNL.get_journal_description
			gen_click_link_and_wait $jnl_back_to_journal_list
			SF.select_view $bd_select_view_all
			SF.click_button_go
			journal_count = journal_count + 1
		end
		gen_end_test "TID012480: Create Invoice without having currency adjustment journals."
	end

	after :all do
		login_user
		APEX.execute_script "CODATID012480Data.destroyData();" # to delete data of identifier mapping table.
		FFA.delete_new_data_and_wait
		gen_end_test "TID012480: Create Invoice without having currency adjustment journals."
		SF.logout
	end
end