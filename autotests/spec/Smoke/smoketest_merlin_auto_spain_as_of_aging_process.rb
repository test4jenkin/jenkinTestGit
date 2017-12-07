#--------------------------------------------------------------------------------------------#
#	TID :  TID013773
# 	Pre-Requisit: Org with basedata deployed.
#  	Product Area: Accounting As of Age Reporting - Other
# 	Story: 24495
#--------------------------------------------------------------------------------------------#

describe "Smoke Test for processing As of Aging.", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
	   # Hold Base Data
       FFA.hold_base_data_and_wait
	end
	_invoice_number1 = nil
	_invoice_number2 = nil
	_credit_note_number = nil
	it "TID013773 : Run As Of Aging process and verify the as of aging band for Posted documents." do
		gen_start_test "TID013773 :  Run As Of Aging process and verify the as of aging band for Posted documents"
		_line = 1
		_line_quantity = 1
		_discard_reason = "Discarded"
		_pin_expense_line_net_value = "200.00"
		_pcr_expense_line_net_value = "100.00"
		_layout_name = "Opportunity Layout"
		_line_number = 1
		_tagname_span = "span"
		journal_type_year_end_journal = "Year End Journal"
		last_year_value = (Time.now).year - 1
		today_date = Time.now.strftime("%d/%m/%Y")
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			
			puts "Additional data for TID013773 "
			begin
				puts "#Account Setting"
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
				puts "# Creating payable invoice"
				begin
					SF.tab $tab_payable_invoices
					SF.click_button_new
					SF.wait_for_search_button
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
				puts "# Creating payable credit Note"
				begin
					SF.tab $tab_payable_credit_notes
					SF.click_button_new
					SF.wait_for_search_button
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
				
				puts "# Creating sales invoice through opportunity"
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
					gen_compare $label_page_name_recurring_invoice , gen_get_page_name , "Expected title of page to be Recurring Invoice page"
						
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
						SF.click_link $sin_back_to_list_sales_invoices
						SF.select_view $bd_select_view_all
						SF.click_button_go
						_invoice_count = _invoice_count + 1
					end
					
					#Post invoices from Sales Invoices list view screen	
					for i in 1.._actual_created_invoice_count do
						FFA.select_row_in_list_gird "Invoice Number" , _sin_number_array[i-1]
					end
					FFA.click_post
					SF.click_button $sin_post_invoices_button
					SF.wait_for_search_button
					
					# Run Background posting scheduler and wait for apex job to complete
					SF.tab $tab_background_posting_scheduler
					SF.wait_for_search_button
					SF.click_button $ffa_run_now_button
					page.has_text?($ffa_msg_executing_background_posting)
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
				puts "# create new sales credit note"
				 begin	
						SF.tab $tab_sales_credit_notes
						SF.click_button_new
						SF.wait_for_search_button
						SCR.set_account $bd_account_pyramid_construction_inc
						credit_note_date =  "15/02/"+last_year_value.to_s
						inv_date =  "01/02/"+last_year_value.to_s
						SCR.set_creditnote_date credit_note_date
						SCR.set_invoice_date inv_date
						FFA.click_new_line
						SCR.line_set_product_name _line_number, $bd_product_benedix_front_brake
						SCR.line_set_quantity _line_number, 1
						SCR.line_set_unit_price _line_number, 400
						SCR.line_set_tax_code _line_number, $bd_tax_code_vo_r_salles
						FFA.click_save_post
						sales_credit_note_number = SCR.get_credit_note_number
				end		
			end
			gen_start_test "TST018039: Run As Of Aging process and verify the as of aging band for Posted documents.."
			begin
				SF.tab $tab_as_of_aging
				SF.click_button_new
				AOA.set_as_of_date today_date
				AOA.click_start_process_button
				SF.wait_for_apex_job

				# Go to sales invoice list view and verify every invoice as of age band value
				begin
					_invoice_count = _initial_invoice_count
					for i in 1.._actual_created_invoice_count do
						SF.tab $tab_sales_invoices		#Added as the common approach in both SF and Lightning org
						SF.select_view $bd_select_view_all
						SF.click_button_go
						SIN.view_invoice_detail _invoice_count
						SIN.click_transaction_number
						TRANX.click_on_account_line_item
						as_of_age_band = TRANX.get_as_of_age_band
						gen_compare $bd_as_of_age_band_121_plus_days ,as_of_age_band,  "Expected As of aging band 121+"						
						_invoice_count = _invoice_count + 1
					end
				end
				#assert value for sales credit note
				begin
					SF.tab $tab_sales_credit_notes
					SF.select_view $bd_select_view_all
					SF.click_button_go
					SF.wait_for_search_button
					SCR.open_credit_note_detail_page sales_credit_note_number
					SCR.click_transaction_number
					TRANX.click_on_account_line_item
					as_of_age_band = TRANX.get_as_of_age_band
					gen_compare as_of_age_band, $bd_as_of_age_band_121_plus_days, "Expected As of aging band : 121+"
				end
				
				#assert value for payable invoice
				begin
					SF.tab $tab_payable_invoices
					SF.select_view $bd_select_view_all
					SF.click_button_go
					PIN.open_invoice_detail_page payable_invoice_number
					PIN.click_transaction_number
					TRANX.click_on_account_line_item
					as_of_age_band = TRANX.get_as_of_age_band
					gen_compare as_of_age_band, $bd_as_of_age_band_current, "Expected As of aging band : Current"
				end
				
					#assert value for payable credit note
				begin
					SF.tab $tab_payable_credit_notes
					SF.select_view $bd_select_view_all
					SF.click_button_go
					PCR.open_credit_note_detail_page payable_credit_note
					PCR.click_transaction_number
					TRANX.click_on_account_line_item
					as_of_age_band = TRANX.get_as_of_age_band
					gen_compare as_of_age_band, $bd_as_of_age_band_current, "Expected As of aging band : Current"
				end
			end
			gen_end_test "TID013773 : Run As Of Aging process and verify the as of aging band for Posted documents."
		end	
			
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout 
	end
end
