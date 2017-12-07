#--------------------------------------------------------------------------------------------#
#	TID :TID013067,TID012970
# 	Pre-Requisit: Org with basedata deployed.
#  	Product Area: Calculate sales And use tax for sales invoice and sales credit note
# 	Story: 23169
#--------------------------------------------------------------------------------------------#

describe "Smoke Test - Calculate sales And use tax for sales invoice and sales credit note", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	_line_number = 1
	_quantity = 1
	_unit_price = 100
	before :all do
		FFA.hold_base_data_and_wait
		#Enable the external tax calculation setting for company
		SF.tab $tab_companies
		SF.click_button_go
		SF.click_link $company_merlin_auto_usa
		SF.click_button_edit
		Company.set_company_external_calculation_setting "Enabled"
		Company.click_save_button
		# enable external sales tax setting
		SF.tab $tab_sales_tax_calculation_settings
		SalesTaxCalc.set_enable_external_sales_tax_calculation "true"	
		SF.click_button_save
	end
	
	it "TID013067 Implemented : Calculate sales And use tax for sales credit note." do
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		
		puts "TST016746 : Calculate sales And use tax for sales credit note."
		begin
			puts "#1.1 credit note creation"
			begin
				SF.tab $tab_sales_credit_notes
				SF.click_button_new
				SCR.set_account $bd_account_algernon_partners_co
				FFA.click_new_line
				gen_wait_less
				SCR.line_set_product_name 1, $bd_product_auto_com_clutch_kit_1989_dodge_raider
				SCR.line_set_quantity _line_number,_quantity
				SCR.line_set_unit_price _line_number, _unit_price
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, SCR.get_credit_note_status ,"Expected credit note status to be In Progress."
				credit_note_num = SCR.get_credit_note_number
			end		
			
			puts "# Setting existing credit note status as uncommitted in AVALARA"
			begin
 				Avalara.set_existing_doc_status_uncommitted credit_note_num	
 			end	
 			
			puts "#1.2 assert status of credit note"
			begin
				login_user			
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_new_view_auto_usa_sales_tax_calculation
				SF.click_button_go
				tax_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_not_calc , tax_status , "Expected Tax status Not Calculated"
	
				credit_note_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num ,  $label_credit_note_status
  				gen_compare $bd_document_status_in_progress , credit_note_status , "Expected credit note status In Progress"				
			end
			
			puts "#1.3, 1.4 credit note calculate tax"
			begin
				FFA.select_row_from_grid credit_note_num
				SCR.click_calculate_tax_button
				SF.wait_for_search_button
				SF.click_button $ffa_Calculate_tax_on_Credit_Notes_button
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				SF.wait_for_apex_job
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_new_view_auto_usa_sales_tax_calculation
				SF.click_button_go
				
				tax_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_calc , tax_status , "Expected Tax status Calculated"
	
				credit_note_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num ,  $label_credit_note_status
  				gen_compare $bd_document_status_in_progress , credit_note_status , "Expected credit note status In Progress"							
			end
			
			puts "#1.5, 1.6 credit note post"
			begin
				FFA.select_row_from_grid credit_note_num
				FFA.click_post
				SCR.click_post_credit_note
				
				tax_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_calc , tax_status , "Expected Tax status Calculated"
	
				credit_note_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num ,  $label_credit_note_status
  				gen_compare $bd_document_status_ready_to_post , credit_note_status , "Expected credit note status Ready to Post"	
  				
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				SF.wait_for_apex_job
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_new_view_auto_usa_sales_tax_calculation
				SF.click_button_go
				tax_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_finalized , tax_status , "Expected Tax status Finalized"

				credit_note_status = FFA.get_column_value_in_grid $label_credit_note_number , credit_note_num ,  $label_credit_note_status
  				gen_compare $bd_document_status_complete , credit_note_status , "Expected credit note status Complete"							
			end
			
			puts "#1.7 assertion in avalara"
			begin
				within_window open_new_window do	
					Avalara.login
					
					Avalara.select_transaction_tab
					Avalara.search_doc_from_list credit_note_num
					
					_doc_status = Avalara.get_doc_status
					gen_compare $bd_document_status_committed , _doc_status, "expected doc status commited"
						
					Avalara.select_first_doc_from_list
					Avalara.set_expand_collapse_true
					
					_line_ammount= Avalara.get_line_amount
					gen_compare "-100.00" , _line_ammount, "expected line amount -100"	
							
					_item_code = Avalara.get_item_code
					gen_compare "ACR3E75013" , _item_code, "expected item code ACR3E75013"
					
					_tax = Avalara.get_tax_value			
					gen_compare "-6.25" , _tax, "expected tax -6.25"

					_Jurisdiction_Type = Avalara.get_Jurisdiction_Type
					gen_compare "STA" , _Jurisdiction_Type, "expected Jurisdiction Type STA"
					# If new instance of browser is opened,close it.
					FFA.close_new_window
				end
			end				
		end
	end	
	
	it "TID012970 Implemented : Calculate sales And use tax for sales Invoice." do
		begin
			login_user	
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
		end
		
		puts "TST016631 : Calculate sales And use tax for sales Invoice."
		begin		
			puts "#1.1 Sales Invoice creation"
			begin
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SIN.set_account $bd_account_algernon_partners_co
				FFA.click_new_line
				SIN.line_set_product_name _line_number, $bd_product_auto_com_clutch_kit_1989_dodge_raider
				SIN.line_set_quantity _line_number,_quantity
				SIN.line_set_unit_price _line_number, _unit_price
				SF.click_button_save
				gen_compare $bd_document_status_in_progress, SIN.get_status ,"Expected sales invoice status to be In Progress."
				invoice_num = SIN.get_invoice_number
			end
			
			puts "# Setting existing invoice status as uncommitted in AVALARA"
			begin
 				Avalara.set_existing_doc_status_uncommitted invoice_num	
 			end	
			
			puts "#1.2 Sales Invoice status assertion"
			begin
				login_user
				SF.tab $tab_sales_invoices
				SF.select_view $bd_new_view_auto_usa_sales_tax_calculation 
				SF.click_button_go
				tax_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_not_calc , tax_status , "Expected Tax status Not Calculated"
	
				inv_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_invoice_status
  				gen_compare $bd_document_status_in_progress , inv_status , "Expected Invoice status In Progress"	
  			end
  			
			puts "# 1.3, 1.4 Sales Invoice calculate tax"
			begin
				FFA.select_row_from_grid invoice_num
				SIN.click_calculate_tax_button
				SF.wait_for_search_button
				SF.click_button $ffa_Calculate_tax_on_invoices_button
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				SF.wait_for_apex_job
				SF.tab $tab_sales_invoices
				SF.select_view $bd_new_view_auto_usa_sales_tax_calculation
				SF.click_button_go
				
				tax_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_calc , tax_status , "Expected Tax status Calculated"
	
				inv_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_invoice_status
  				gen_compare $bd_document_status_in_progress , inv_status , "Expected Invoice status In Progress"	
			end
			
			puts "#1.5, 1.6 Sales Invoice status assertion"
			begin
				FFA.select_row_from_grid invoice_num
				FFA.click_post
				SIN.click_post_invoices
				
				tax_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_calc , tax_status , "Expected Tax status Calculated"
	
				inv_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_invoice_status
  				gen_compare $bd_document_status_ready_to_post , inv_status , "Expected Invoice status Ready to Post"	
				
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				SF.wait_for_apex_job
				SF.tab $tab_sales_invoices
				SF.select_view $bd_new_view_auto_usa_sales_tax_calculation
				SF.click_button_go
				
				tax_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_sales_tax_status
  				gen_compare $bd_document_sales_tax_status_finalized , tax_status , "Expected Tax status Finalized"
	
				inv_status = FFA.get_column_value_in_grid $label_invoice_number , invoice_num , $label_invoice_status
  				gen_compare $bd_document_status_complete , inv_status , "Expected Invoice Status to be completed"	
			end

			puts "#1.7 assertion in avalara"
			begin
				within_window open_new_window do
					Avalara.login					
					Avalara.select_transaction_tab
					Avalara.search_doc_from_list invoice_num
					
					_doc_status = Avalara.get_doc_status
					gen_compare $bd_document_status_committed , _doc_status, "expected doc status commited"
						
					Avalara.select_first_doc_from_list
					Avalara.set_expand_collapse_true
					
					_line_ammount= Avalara.get_line_amount
					gen_compare "100.00" , _line_ammount, "expected line amount 100"	
					
					_item_code = Avalara.get_item_code
					gen_compare "ACR3E75013" , _item_code, "expected item code ACR3E75013"
					
					_tax = Avalara.get_tax_value			
					gen_compare "6.25" , _tax, "expected tax 6.25"
		
					_Jurisdiction_Type = Avalara.get_Jurisdiction_Type
					gen_compare "STA" , _Jurisdiction_Type, "expected Jurisdiction Type STA"
					# If new instance of browser is opened,close it.
					FFA.close_new_window
				end
			end	
		end	
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		# added code in after :all to make sure that setting is disabled before executing next set of testcases.
		SF.tab $tab_sales_tax_calculation_settings
		SalesTaxCalc.set_enable_external_sales_tax_calculation "false"
		SF.click_button_save
		#Disable the external tax calculation setting for company
		SF.tab $tab_companies
		SF.click_button_go
		SF.click_link $company_merlin_auto_usa
		SF.click_button_edit
		Company.set_company_external_calculation_setting "Disabled"
		Company.click_save_button
		SF.logout 
	end
end		