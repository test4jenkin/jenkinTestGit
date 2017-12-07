#--------------------------------------------------------------------#
#	TID  :  TID012153
#	Pre-Requisit: execute smoketest_data_setup.rb and smoketest_data_setup_ext to setup data for smoke tests
#	Product Area:	Accounting - Sales Invoices & Credit Notes(Batch) - Smoke Test
#	Story: 23564
#--------------------------------------------------------------------#
describe "Smoke Test for Accounting - Sales Invoices & Credit Notes(Batch)", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		FFA.hold_base_data_and_wait	
		gen_start_test "TID012153: Create recurring Invoice from opportunity and convert Sales Invoice into Credit Note."
	end
	it "TID012153 : Create sales invoice and convert it into credit note" do
		
		_line_number = 1
		_tagname_span = "span"
		current_date = Date.today
		current_date_plus45_days=current_date+45
		current_date_plus30_days=current_date+30
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		puts "Additional Data for TID012153"
		begin
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			OPP.view_opportunity $bd_opp_pyramid_emergency_generators
			SF.click_button_edit
			OPP.set_account_name $bd_account_pyramid_construction_inc
			SF.click_button_save
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			OPP.view_opportunity $bd_opp_pyramid_emergency_generators_2
			SF.click_button_edit
			OPP.set_account_name $bd_account_pyramid_construction_inc
			SF.click_button_save
		end
		
		puts "Test Step TST015551 :  Sales Invoices (recurring from opportunity), adding exchange rate to opportunity"
		begin
			# TST015551 : 1.01 : Create invoice from opportunity with invoice rate 5
			begin
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				_initial_invoice_count = FFA.ffa_listview_get_rows
				SF.tab $tab_opportunities
				OPP.all_opportunities_view
				OPP.view_opportunity $bd_opp_pyramid_emergency_generators
				OPP.click_create_invoice
				
				gen_compare_object_editable $opp_opportunity_name, false, "Expected Opportunity Name to be non-editable"
				gen_compare_object_editable	$opp_first_invoice_date, false, "Expected First Invoice Date to be non-editable"
				gen_compare_object_editable	$opp_first_due_date, false, "Expected First Due Date to be non-editable"
				gen_compare_object_editable	$opp_currency, false, "Expected Currency to be non-editable"
				gen_compare_object_editable	$opp_first_period, false, "Expected First Period to be non-editable"
				gen_compare_object_editable	$opp_current_document_rate, false, "Expected Current Document Rate to be non-editable"
				gen_compare_object_editable	$opp_invoice_rate, true, "Expected Invoice Rate to be editable"
		
				OPP.set_invoice_rate 5
				OPP.click_create_invoice
				gen_compare $label_page_name_recurring_invoice , gen_get_page_name , "Expected title of page to be Recurring Invoice page"
			end 
			
			# TST015551 : 1.02 : Save invoice and go to sales invoice list view and compare invoice status
			begin	
				OPP.click_save_button_and_accept_alert				
				SF.wait_for_apex_job
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				_new_invoice_count = FFA.ffa_listview_get_rows
				_actual_created_invoice_count = _new_invoice_count - _initial_invoice_count
				gen_compare 5 , _actual_created_invoice_count , "Expected total number of invoices to be 5"
				_invoice_count = _initial_invoice_count
				_sin_number_array = Array[]
				for i in 1.._actual_created_invoice_count do
					SIN.view_invoice_detail _invoice_count
					page.has_text?($sin_back_to_list_sales_invoices)
					_sin_number_array[i-1] = SIN.get_invoice_number
					gen_compare $bd_document_status_in_progress , SIN.get_status , "Expected Invoice Status to be In Progress"
					SF.click_link $sin_back_to_list_sales_invoices
					SF.select_view $bd_select_view_all
					SF.click_button_go
					_invoice_count = _invoice_count + 1
				end
			end
			# TST015551 : 1.03 : Post invoices from Sales Invoices list view screen
			begin
				for i in 1.._actual_created_invoice_count do
					FFA.select_row_in_list_gird "Invoice Number" , _sin_number_array[i-1]
				end
				FFA.click_post
				SF.click_button $sin_post_invoices_button
				gen_wait_until_object_disappear $ffa_processing_button_locator
				gen_has_page_title $page_title_sales_invoices_list_view_all, "Expected page title to be Sales Invoices"
				_invoice_count = _initial_invoice_count
				for i in 1.._actual_created_invoice_count do
					SIN.view_invoice_detail _invoice_count
					gen_compare $bd_document_status_ready_to_post , SIN.get_status , "Expected Invoice Status to be Ready to Post"
					SF.click_link $sin_back_to_list_sales_invoices
					SF.select_view $bd_select_view_all
					SF.click_button_go
					_invoice_count = _invoice_count + 1
				end
			end
			
			# TST015551 : 1.04 : Run Background posting scheduler and wait for apex job to complete
			begin
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				gen_compare $ffa_msg_executing_background_posting , FFA.ffa_get_info_message , "Expected message to be Background posting executing now."
				SF.wait_for_apex_job
			end
			
			# TST015551 : 1.05 : Go to sales invoice list view and verify every invoice detail
			begin
				_invoice_count = _initial_invoice_count
				for i in 1.._actual_created_invoice_count do
					SF.tab $tab_sales_invoices
					SF.select_view $bd_select_view_all
					SF.click_button_go
					SIN.view_invoice_detail _invoice_count
					FFA.click_toggle_exchange_rates
					gen_compare "5.000000000" , SIN.get_invoice_rate , "Expected invoice rate to be 5.000000000"
					gen_compare $bd_document_status_complete , SIN.get_status , "Expected Invoice Status to be Complete"
					SIN.click_transaction_number
					gen_compare "838.00" , TRANX.get_account_total , "Expected Account Total at Transaction to be 838.00"
					gen_compare "838.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total at Transaction to be 838.00"
					gen_compare "838.00" , TRANX.get_home_debits , "Expected Home Debits at Transaction to be 838.00"
					gen_compare "4,190.00" , TRANX.get_dual_debits , "Expected Dual Debits at Transaction to be 4,190.00"
					_invoice_count = _invoice_count + 1
				end
			end			
		end

		puts "Test Step TST015614 : Create Sales Invoice from opportunity (Pull)"
		begin
			# TST015614 : 1.1 : Create new Sales Invoice and click on Convert link
			begin
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SF.click_link $sin_convert_link
				gen_compare_object_visible $opp_opportunity_lookup, true, "Expected Opportunity lookup field to be displayed on UI"
				gen_compare_has_button $opp_convert_button , true, "Expected Convert button to be displayed on UI"
				gen_compare_has_button $sf_cancel_button , true, "Expected Cancel button to be displayed on UI"
			end
		
			# TST015614 : 1.2 : Set opportunity name and click convert button
			begin
				OPP.convert_set_opp_name $bd_opp_pyramid_emergency_generators_2
				OPP.click_convert
				gen_compare $ffa_msg_creating_invoice , FFA.ffa_get_info_message , "Expected message to be You are about to create an invoice. Do you want to continue?"
				gen_compare_object_editable $opp_opportunity_name, false, "Expected Opportunity Name to be non-editable"
				_opp_invoice_date = OPP.get_invoice_date
				gen_compare_objval_not_null _opp_invoice_date, true, "Expected Invoice Date should be pre-selected"
				_opp_due_date = OPP.get_due_date
				gen_compare_objval_not_null _opp_due_date, true, "Expected Due Date should be pre-selected"
				_opp_period = OPP.get_period
				gen_compare_objval_not_null _opp_period, true, "Expected Period should be pre-selected"
				gen_compare_object_editable $opp_currency, false, "Expected Currency to be non-editable"
				OPP.click_create_invoice			
			end
		
			# TST015614 : 1.3 : Post invoice from Sales Invoices list view screen
			begin
				_invoice_number = SIN.get_invoice_number
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				FFA.select_row_in_list_gird "Invoice Number" , _invoice_number
				FFA.click_post
				SF.click_button $sin_post_invoices_button
				gen_has_page_title $page_title_sales_invoices_list_view_all, "Expected page title to be Sales Invoices"
				SIN.open_invoice_detail_page _invoice_number
				gen_compare $bd_document_status_ready_to_post , SIN.get_status , "Expected Sales Invoice Status to be Ready to Post"
			end
		
			# TST015614 : 1.4 : Run Background posting scheduler and wait for apex job to complete
			begin
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				gen_compare $ffa_msg_executing_background_posting , FFA.ffa_get_info_message , "Expected message to be Background posting executing now."
				SF.wait_for_apex_job
			end
		
			# TST015614 : 1.5 : Go to sales invoice list view and verify every invoice detail
			begin
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page _invoice_number
				gen_compare $bd_document_status_complete , SIN.get_status , "Expected Sales Invoice Status to be Complete"
				SIN.click_transaction_number
				gen_compare "2,844.00" , TRANX.get_account_total , "Expected Account Total at Transaction to be 2,844.00"
				gen_compare "2,844.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total at Transaction to be 2,844.00"
				gen_compare "2,844.00" , TRANX.get_home_debits , "Expected Home Debits at Transaction to be 2,844.00"
				gen_compare "4,266.00" , TRANX.get_dual_debits , "Expected Dual Debits at Transaction to be 4,266.00"			
			end			
		end
		
		puts "Test Step TST015697 : Convert sales Invoice into credit note without changing anything."
		begin
			# TST015697 : 1.1 : Click Convert to credit Note Button on posted invoice of TST015614
			begin
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page _invoice_number
				SF.click_button $sin_convert_to_credit_note_button
				gen_wait_until_object_disappear $ffa_processing_button_locator
				gen_compare $label_page_name_sales_credit_note , gen_get_page_name , "Expected Sales Credit Note screen to be opened"
			end
			
			# TST015697 : 1.2 : Verify the details of created Credit Note.
			begin
				gen_compare $bd_document_status_in_progress , SCR.get_credit_note_status , "Expected Sales Credit Note status to be In Progress"
				gen_compare $bd_account_pyramid_construction_inc , SCR.get_account_name , "Expected Account to be same as of invoice i.e. Pyramid Construction Inc"
				_lineitem_prod_name = SCR.line_get_product_name _line_number
				gen_compare $bd_product_centric_rear_brake_hose_1987_1989_dodge_raider , _lineitem_prod_name , "Expected Credit Note should have line item Centric Rear Brake Hose 1987-1989 Dodge Raider"			
			end
		
			# TST015697 : 1.3 : Click Post button
			begin
				FFA.click_post
				gen_compare $bd_document_status_complete , SCR.get_credit_note_status , "Expected Sales Credit Note status to be Complete"
				SCR.click_transaction
				gen_compare "-2,844.00" , TRANX.get_account_total , "Expected Account Total at Transaction to be -2,844.00"
				gen_compare "-2,844.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total at Transaction to be -2,844.00"
				gen_compare "2,844.00" , TRANX.get_home_debits , "Expected Home Debits at Transaction to be 2,844.00"
				gen_compare "4,266.00" , TRANX.get_dual_debits , "Expected Dual Debits at Transaction to be 4,266.00"			
			end			
		end
		
		puts "Test Step TST015699 : Convert sales invoice to credit note with changes, create credit note and post both credit notes using batch processing."
		begin
			# TST015699 : 1.1 : Click Convert to credit Note Button on posted invoice of TST015614
			begin
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SIN.open_invoice_detail_page _invoice_number
				SF.click_button $sin_convert_to_credit_note_button
				gen_wait_until_object_disappear $ffa_processing_button_locator
				gen_compare $label_page_name_sales_credit_note , gen_get_page_name , "Expected Sales Credit Note screen to be opened"
			end
		
			# TST015699 : 1.2 : Click on Edit button and update the line quantity to 5
			begin
				SF.click_button_edit
				gen_wait_until_object_disappear $ffa_processing_button_locator
				SCR.line_set_quantity _line_number , 5
				_lineitem_net_value = SCR.line_get_net_value _line_number
				gen_compare "$2,000.00" , _lineitem_net_value , "Expected Credit Note Net value should be $2,000.00 on update"
			end
			
			# TST015699 : 1.3 : Save Sales Credit note
			begin
				SF.click_button_save
				_credit_note_number = SCR.get_credit_note_number
				_lineitem_net_value = SCR.line_get_net_value _line_number
				gen_compare "$2,000.00" , _lineitem_net_value , "Expected Credit Note Net value should be $2,000.00 after save"
			end
			
			# TST015699 : 1.4 : Go to Sales Credit Note screen and create new sales credit with given details
			begin		
				SF.tab $tab_sales_credit_notes
				SF.click_button_new
				SCR.set_account $bd_account_pyramid_construction_inc
				SCR.set_creditnote_date current_date_plus30_days.strftime("%d/%m/%Y")
				SCR.set_invoice_date current_date_plus45_days.strftime("%d/%m/%Y")
				FFA.click_new_line
				SCR.line_set_product_name _line_number, "Bendix Front Brake"
				SCR.line_set_unit_price _line_number, 400
				SCR.line_set_tax_code _line_number, "VO-R Sales"
				SF.click_button_save
				_credit_note_number2 = SCR.get_credit_note_number
				gen_compare $bd_document_status_in_progress , SCR.get_credit_note_status , "Expected Sales Credit Note status to be In Progress"
				
			end
		
			# TST015699 : 1.5 : Post sales credit notes from Sales Credit Notes list view screen
			begin
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				FFA.select_row_in_list_gird "Credit Note Number" , _credit_note_number
				FFA.select_row_in_list_gird "Credit Note Number" , _credit_note_number2
				FFA.click_post
				SF.click_button $scn_post_credit_notes_button
				SCR.open_credit_note_detail_page _credit_note_number
				gen_compare $bd_document_status_ready_to_post , SCR.get_credit_note_status , "Expected Sales Credit Note status to be Ready to Post"
				SF.click_link $scn_back_to_list_sales_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SCR.open_credit_note_detail_page _credit_note_number2
				gen_compare $bd_document_status_ready_to_post , SCR.get_credit_note_status , "Expected Sales Credit Note status to be Ready to Post"			
			end
		
			# TST015699 : 1.6 : Run Background posting scheduler and wait for apex job to complete
			begin
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				page.has_text?($ffa_msg_executing_background_posting)
				gen_compare $ffa_msg_executing_background_posting , FFA.ffa_get_info_message , "Expected message to be Background posting executing now."
				SF.wait_for_apex_job
			end
		
			# TST015699 : 1.7 : Go to sales credit notes list view and verify every details
			begin
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SCR.open_credit_note_detail_page _credit_note_number
				gen_compare $bd_document_status_complete , SCR.get_credit_note_status , "Expected Sales Credit Note status to be Complete"
				SCR.click_transaction
				gen_compare "-1,422.00" , TRANX.get_account_total , "Expected Account Total at Transaction to be -1,422.00"
				gen_compare "-1,422.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total at Transaction to be -1,422.00"
				gen_compare "1,422.00" , TRANX.get_home_debits , "Expected Home Debits at Transaction to be 1,422.00"
				gen_compare "2,133.00" , TRANX.get_dual_debits , "Expected Dual Debits at Transaction to be 2,133.00"	
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SCR.open_credit_note_detail_page _credit_note_number2
				gen_compare $bd_document_status_complete , SCR.get_credit_note_status , "Expected Sales Credit Note status to be Complete"
				SCR.click_transaction
				gen_compare "-419.00" , TRANX.get_account_total , "Expected Account Total at Transaction to be -419.00"
				gen_compare "-419.00" , TRANX.get_account_outstanding_total , "Expected Account Outstanding Total at Transaction to be -419.00"
				gen_compare "419.00" , TRANX.get_home_debits , "Expected Home Debits at Transaction to be 419.00"
				gen_compare "628.50" , TRANX.get_dual_debits , "Expected Dual Debits at Transaction to be 628.50"	
			end
		end		
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		gen_end_test "TID012153: Create recurring Invoice from opportunity and convert Sales Invoice into Credit Note."
		SF.logout 
	end
end
