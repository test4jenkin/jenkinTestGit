#--------------------------------------------------------------------------------------------#
#	TID :  TID013450
# 	Pre-Requisit: Org with basedata deployed.
#  	Product Area: Accounting - Year End & Period End
# 	Story: 24495
#--------------------------------------------------------------------------------------------#

describe "Smoke Test for Year End Process.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
	   # Hold Base Data
       FFA.hold_base_data_and_wait
	end
	_invoice_number1 = nil
	_invoice_number2 = nil
	_credit_note_number = nil
	_year_to_close = (Time.now).year.to_s
	it "TID013450 :  Year end process for Merlin auto spain" do
			gen_start_test "TID013450 :  Year end process for Merlin auto spain"
			_line = 1
			_line_quantity = 1
			_discard_reason = "Discarded"
			_pin_expense_line_net_value = "200.00"
			_pcr_expense_line_net_value = "100.00"
			_layout_name = "Opportunity Layout"
			_line_number = 1
			_tagname_span = "span"
			journal_type_year_end_journal = "Year End Journal"
			today_date = Time.now.strftime("%d/%m/%Y")
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			gen_start_test "Additional data for TID013450"
			begin
				gen_start_test "#Account Setting"
				begin
			    	SF.tab $tab_accounts
					SF.select_view $bd_select_view_all_accounts
					SF.click_button_go
					Account.view_account $bd_account_algernon_partners_co
					SF.click_button_edit
					page.has_text?($bd_account_algernon_partners_co)
					Account.set_accounts_payable_control $bd_gla_accounts_payable_control_eur
					SF.click_button_save
					page.has_text?($bd_account_algernon_partners_co)
				end
				gen_start_test "# Creating payable invoice"
				begin
					SF.tab $tab_payable_invoices
					SF.click_button_new
					PIN.set_account $bd_account_algernon_partners_co
					PIN.change_invoice_currency $bd_currency_eur
					PIN.set_vendor_invoice_number "ABC1003"
					PIN.set_vendor_invoice_total "470.00"
					PIN.set_expense_line_gla $bd_gla_accounts_payable_control_eur
					PIN.click_new_expense_line
					PIN.set_expense_line_net_value _line, _pin_expense_line_net_value
					PIN.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
					PIN.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
					PIN.click_product_new_line
					PIN.set_product_line_quantity _line, _line_quantity
					PIN.set_product_line_unit_price _line, "200.00"
					PIN.set_product_line_tax_code _line, $bd_tax_code_vo_std_purchase
					FFA.click_save_post
					payable_invoice_number = PIN.get_invoice_number					
				end	
				gen_start_test "# Creating payable credit Note"
				begin
					SF.tab $tab_payable_credit_notes
					SF.click_button_new
					PCR.set_account $bd_account_algernon_partners_co
					PCR.select_credit_note_reason $bd_credit_note_reason_incorrect_shipment
					PCR.change_credit_note_currency $bd_currency_eur
					PCR.set_vendor_credit_note_number "VCN3"
					PCR.set_vendor_credit_note_total "235.00"
					PCR.set_expense_line_gla $bd_gla_accounts_payable_control_eur
					PCR.click_new_expense_line
					PCR.set_expense_line_net_value _line, _pcr_expense_line_net_value
					PCR.set_expense_line_tax_code _line, $bd_tax_code_vo_std_purchase
					PCR.set_product_name $bd_product_auto_com_clutch_kit_1989_dodge_raider
					PCR.click_product_new_line
					PCR.set_product_line_quantity _line, _line_quantity
					PCR.set_product_line_unit_price _line, "100.00"
					PCR.set_product_line_tax_code _line, $bd_tax_code_vo_std_purchase
					FFA.click_save_post
					payable_credit_note = PCR.get_credit_note_number
				end	
				
				gen_start_test "# Creating sales invoice through opportunity"
				begin
					SF.tab $tab_opportunities
					OPP.all_opportunities_view
					OPP.view_opportunity $bd_opp_pyramid_emergency_generators
					SF.click_button_edit
					page.has_text?($bd_opp_pyramid_emergency_generators)
					OPP.set_account_name $bd_account_pyramid_construction_inc
					SF.click_button_save
					page.has_text?($bd_opp_pyramid_emergency_generators)
					SF.tab $tab_opportunities
					OPP.all_opportunities_view
					OPP.view_opportunity $bd_opp_pyramid_emergency_generators_2
					SF.click_button_edit
					page.has_text?($bd_opp_pyramid_emergency_generators_2)
					OPP.set_account_name $bd_account_pyramid_construction_inc
					SF.click_button_save
					page.has_text?($bd_opp_pyramid_emergency_generators_2)
					#initial counter of invoice	
					SF.tab $tab_sales_invoices
					SF.select_view $bd_select_view_all
					SF.click_button_go
					_initial_invoice_count = FFA.ffa_listview_get_rows
					
					SF.tab $tab_opportunities
					OPP.all_opportunities_view
					OPP.view_opportunity $bd_opp_pyramid_emergency_generators
					OPP.click_create_invoice
				
					OPP.set_invoice_rate 5
					OPP.click_create_invoice
											
					#Save invoice and go to sales invoice list view and compare invoice status
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
						_sin_number_array[i-1] = SIN.get_invoice_number
						_invoice_status = FFA.get_document_status $sin_status
						gen_compare $bd_document_status_in_progress , _invoice_status , "Expected Invoice Status to be In Progress for invoice: " +_sin_number_array[i-1]
						gen_click_link_and_wait $sin_back_to_list_sales_invoices
						SF.select_view $bd_select_view_all
						SF.click_button_go
						_invoice_count = _invoice_count + 1
					end
					
					#Post invoices from Sales Invoices list view screen	
					for i in 1.._actual_created_invoice_count do
						FFA.select_row_in_list_gird "Invoice Number" , _sin_number_array[i-1]
					end
					FFA.click_post
					SF.wait_for_search_button
					SF.click_button $sin_post_invoices_button
					SF.wait_for_search_button
					_invoice_count = _initial_invoice_count
					
					# Run Background posting scheduler and wait for apex job to complete
					SF.tab $tab_background_posting_scheduler
					SF.wait_for_search_button
					SF.click_button $ffa_run_now_button
					gen_compare $ffa_msg_executing_background_posting , FFA.ffa_get_info_message , "Expected message to be Background posting executing now."
					SF.wait_for_apex_job
					
					# Go to sales invoice list view and verify every invoice status to be complete		
					SF.tab $tab_sales_invoices
					SF.select_view $bd_select_view_all
					SF.click_button_go
					_invoice_count = _initial_invoice_count
					for i in 1.._actual_created_invoice_count do
						SIN.view_invoice_detail _invoice_count
						_invoice_status = FFA.get_document_status $sin_status
						gen_compare $bd_document_status_complete , _invoice_status , "Expected Invoice Status to be Complete"
						gen_click_link_and_wait $sin_back_to_list_sales_invoices
						SF.select_view $bd_select_view_all
						SF.click_button_go
						_invoice_count = _invoice_count + 1
					end
				 end
				#Go to Sales Credit Note screen and create new sales credit with given details
				 begin	
						SF.tab $tab_sales_credit_notes
						SF.click_button_new
						SCR.set_account $bd_account_pyramid_construction_inc
						_credit_note_date = "15/02/"+_year_to_close
						SCR.set_creditnote_date _credit_note_date
						_invoice_date = "01/02/"+_year_to_close
						SCR.set_invoice_date _invoice_date
						FFA.click_new_line
						SCR.line_set_product_name _line_number, $bd_product_benedix_front_brake
						SCR.line_set_quantity _line_number, 1
						SCR.line_set_unit_price _line_number, 400
						SCR.line_set_tax_code _line_number, $bd_tax_code_vo_r_salles
						FFA.click_save_post
						sales_credit_note_number = SCR.get_credit_note_number
				end		
			end
			gen_start_test "TST017192: Year end process for Merlin auto spain"
			_line_number = 1
			begin
				#Extract initial Journal count
				SF.tab $tab_journals
				SF.select_view $bd_select_view_all
				SF.click_button_go
				initial_journal_count = FFA.ffa_listview_get_rows
				
				# create current+1 year if it does not exist as year can not be processes if current year+1 does not exist.
				current_year = (Time.now).year
				next_year = current_year+1
				SF.tab $tab_years
				SF.select_view $bd_select_view_company_ff_merlin_auto_spain
				SF.click_button_go
				year_not_exist=true
				within(find($year_list_grid)) do
					if page.has_text?(next_year.to_s)
						year_not_exist=false
					end
				end
				puts "Next year need to be created: "+year_not_exist.to_s
				if year_not_exist
					SF.tab $tab_years
					SF.click_button_new
					YEAR.set_year_name next_year.to_s
					YEAR.set_start_date  "01/01/"+next_year.to_s
					YEAR.set_year_end_date  "31/12/"+next_year.to_s
					YEAR.set_number_of_periods "12"
					YEAR.select_period_calculation_basis $bd_period_calculation_basis_month_end
					SF.click_button_save
					SF.wait_for_search_button
					#calculate periods
					YEAR.click_calculate_periods_button
					gen_include $ffa_msg_calculate_period_confirmation, FFA.ffa_get_info_message , "TST017670: Expected a confirmation message for calculating periods."
					#confirm the process
					YEAR.click_calculate_periods_button
					gen_compare next_year.to_s , YEAR.get_year_name , "TST017670: Expected  periods  to be created successfully for year 2015. "
				end	
				gen_start_test "#1.1 A) Navigate to Year tab and start end process"
				SF.tab $tab_years
				SF.select_view $bd_select_view_company_ff_merlin_auto_spain
				SF.click_button_go
				YEAR.open_year_detail_page _year_to_close ,$bd_select_view_company_ff_merlin_auto_spain
				page.has_text?(_year_to_close)
				SF.click_button_edit
				YEAR.set_suspense_gla $bd_gla_suspense
				YEAR.set_retained_earning_gla $bd_gla_retained_earnings
				SF.click_button_save
				
				YEAR.click_start_year_end_button
				YEAR.click_run_year_end_button
				SF.wait_for_apex_job
				
				SF.tab $tab_years
				SF.select_view $bd_select_view_company_ff_merlin_auto_spain
				SF.click_button_go
				YEAR.open_year_detail_page _year_to_close ,$bd_select_view_company_ff_merlin_auto_spain
				page.has_text?(_year_to_close)
				YEAR.click_go_to_period_list
				gen_compare true , PERIOD.expect_all_period_status_as_closed  , "Expected all period of year 2015 -Merlin Auto SPain to be closed. "
				
				gen_start_test "#1.1 B) Verify Newly generated journal"
				SF.tab $tab_journals
				SF.select_view $bd_select_view_all
				SF.click_button_go
				new_journal_count = FFA.ffa_listview_get_rows
				actual_journal_count = new_journal_count - initial_journal_count
				journal_count = initial_journal_count + 1
				
				#Expected result for First journal
				JNL.open_journal_detail_page_by_position journal_count
				journal_type = JNL.get_journal_type 
				gen_compare journal_type, journal_type_year_end_journal, "Expected journal type is : Year End Journal"
				journal_ref = JNL.get_journal_reference 
				_expected_journal_ref="PL - Year End "+_year_to_close
				gen_compare journal_ref, _expected_journal_ref, "Expected journal Reference : PL - Year End "+_year_to_close
				journal_status = JNL.get_journal_status
				gen_compare journal_status, "Complete", "Expected journal status : Complete"
				journal_period = JNL.get_journal_period
				_expected_journal_period=_year_to_close+"/101"
				gen_compare journal_period, _expected_journal_period, "Expected journal Period : "+_expected_journal_period
				
				JNL.click_back_to_journal_list
				SF.select_view $bd_select_view_all
				SF.click_button_go
				journal_count = journal_count + 1
				
				#Expected result for second journal
				JNL.open_journal_detail_page_by_position journal_count
				journal_type = JNL.get_journal_type 
				gen_compare journal_type, journal_type_year_end_journal, "Expected journal type is : Year End Journal"
				journal_ref = JNL.get_journal_reference 
				_expected_journal_ref="BS - Year End "+_year_to_close
				gen_compare journal_ref, _expected_journal_ref, "Expected journal Reference : "+_expected_journal_ref
				journal_status = JNL.get_journal_status
				gen_compare  $bd_select_view_complete, journal_status, "Expected journal status : Complete"
				journal_period = JNL.get_journal_period
				_expected_journal_period=_year_to_close+"/101"
				gen_compare journal_period, _expected_journal_period, "Expected journal Period : "+_expected_journal_period
				
				JNL.click_back_to_journal_list
				SF.select_view $bd_select_view_all
				SF.click_button_go
				journal_count = journal_count + 1
				
				#Expected result for Third journal
				JNL.open_journal_detail_page_by_position journal_count
				journal_type = JNL.get_journal_type 
				gen_compare journal_type, journal_type_year_end_journal, "Expected journal type is : Year End Journal"
				journal_ref = JNL.get_journal_reference
				_expected_journal_ref="BS - Year End "+_year_to_close
				gen_compare journal_ref, _expected_journal_ref, "Expected journal Reference : "+_expected_journal_ref
				journal_status = JNL.get_journal_status
				gen_compare  $bd_select_view_complete,journal_status, "Expected journal status : Complete"
				journal_period = JNL.get_journal_period
				_expected_journal_period=(_year_to_close.to_i+1).to_s+"/000"
				gen_compare journal_period, _expected_journal_period, "Expected journal Period : "+_expected_journal_period
					
				gen_start_test "#1.1 C) Start Year end process again and expect error message"
				SF.tab $tab_years
				SF.select_view $bd_select_view_company_ff_merlin_auto_spain
				SF.click_button_go
				YEAR.open_year_detail_page _year_to_close ,$bd_select_view_company_ff_merlin_auto_spain
				page.has_text?(_year_to_close)
				YEAR.click_start_year_end_button
				gen_include $period_end_process_already_run_message, FFA.ffa_get_info_message , "Expected a error message that year is already closed: " + $period_end_process_already_run_message
				
				gen_start_test "#1.1 D) Expect error message when creating a sales credit note for closed period"
				SF.tab $tab_sales_credit_notes
				SF.click_button_new
				SCR.set_account $bd_account_pyramid_construction_inc
				_credit_note_date="15/02/"+_year_to_close
				SCR.set_creditnote_date _credit_note_date
				_invoice_date="01/02/"+_year_to_close
				SCR.set_invoice_date _invoice_date
				FFA.click_new_line
				SCR.line_set_product_name _line_number, $bd_product_benedix_front_brake
				SCR.line_set_quantity _line_number, 1
				SCR.line_set_unit_price _line_number, 400
				SCR.line_set_tax_code _line_number, $bd_tax_code_vo_r_salles
				FFA.click_save_post
				gen_compare_has_content $ffa_msg_obj_validation_failed_closed_period_error,true, "Expected error message for creating document in closed year.Expected: #{$ffa_msg_obj_validation_failed_closed_period_error}"				
			end
			gen_end_test "TID013450 :  Year end process for Merlin auto spain"
	end 
	after :all do
		login_user
		#Reopen closed year
		FFA.open_closed_year _year_to_close, $company_merlin_auto_spain
		#Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout 
	end
end
