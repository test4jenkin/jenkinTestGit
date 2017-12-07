#--------------------------------------------------------------------#
#	TID : TID013546
# 	Pre-Requisit: smoketest_data_setup_merlin_auto_spain.rb
#  	Product Area: 
# 	Story: 25000 
#--------------------------------------------------------------------#

describe "Smoke Test:Create Sales Invoice and credit note with 81 line items using API ", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do	
		gen_start_test  "TID013546-Create Sales Invoice and credit note with 81 line items using API"
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "TID013546:Execute Script as Anonymous user , Post Invoice and Credit Notes with 81 line items." do
		invoice_total_text = "Invoice Total"
		invoice_total_value = "1,024,650.00"
		credit_note_total_text = "Credit Note Total"
		credit_note_total_value = "102,465.00"	
		invoice_status = "Invoice Status"
		credit_note_number = "Credit Note Number"
		
		begin
			# set extended layout
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_extended_layout
			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_invoice_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_credit_note_line_item_extended_layout
			# Edit properties for New , Edit and View button in Sales invoice and credit notes
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout 
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout
		end
		#"Execute Script as Anonymous user" 
		begin
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			SF.tab $tab_sales_invoices
			scripttext = "CreateInvoiceCreditnoteUsingAPI.createInvoiceThroughApi('"+$company_merlin_auto_usa +"',81);"
			APEX.execute_script scripttext
			script_status = APEX.get_execution_status_message
			gen_include "Script executed successfully." ,script_status, "Expected- successful Apex script execution."
			SF.wait_for_apex_job
		end
	
		#Post sales invoice
		begin	
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.edit_list_view $bd_select_view_all, invoice_total_text, 5
			invnum = FFA.get_column_value_in_grid invoice_total_text , invoice_total_value , "Invoice Number"
			FFA.select_row_from_grid invnum
			SIN.click_post_button
			SF.wait_for_search_button
			SIN.click_post_invoices
			
			# Status of Invoice 
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page invnum
			SF.wait_for_search_button
			invstatus = SINX.get_invoice_status
			gen_compare $bd_document_status_ready_to_post , invstatus , 'Status of Invoice is Ready To Post'
		end
		#"Post sales credit note" 
		begin
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.edit_list_view $bd_select_view_all, credit_note_total_text, 5
			CreditNoteNo = FFA.get_column_value_in_grid credit_note_total_text , credit_note_total_value , credit_note_number
			FFA.select_row_from_grid CreditNoteNo
			SCR.click_post_button
			SF.wait_for_search_button
			SCR.click_post_credit_note

			#Sales credit Notes Status 
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			
			SCRX.open_credit_note_detail_page CreditNoteNo
			SF.wait_for_search_button
			gen_compare $bd_document_status_ready_to_post , SCRX.get_credit_note_status , 'Status of credit note  should be  Ready To Post'
		end
	
		# "Background Posting Scheduler and click on ‘Run now’ and check status of invoice " 
		begin
			SF.tab $tab_background_posting_scheduler
			SF.wait_for_search_button
			SF.click_button $ffa_run_now_button
			SF.wait_for_apex_job
			# Status of Invoice 
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			SIN.open_invoice_detail_page invnum
			SF.wait_for_search_button
			invstatus = SINX.get_invoice_status
			gen_compare  $bd_document_status_complete , invstatus , 'Status of Invoice is Complete.'
			SF.wait_for_search_button
			gen_include "TRN", SINX.get_invoice_transaction_number , "Expected transaction number to be generated for posted invoice."
			SINX.click_transaction_number
			gen_compare invoice_total_value,TRANX.get_account_total, "Expected account total to be 1,024,650.00"
			gen_compare invoice_total_value,TRANX.get_account_outstanding_total, "Expected account outstanding total to be 1,024,650.00"
			gen_compare "2,049,300.00",TRANX.get_home_debits, "Expected account home debits total to be 2,049,300.00"
			gen_compare "2,049,300.00",TRANX.get_dual_debits, "Expected account dual debits total to be 2,049,300.00"
		end
	
		# "Sales credit Notes status " 
		begin
			#Sales credit Notes Status 
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			
			SCRX.open_credit_note_detail_page CreditNoteNo
			SF.wait_for_search_button
			gen_compare $bd_document_status_complete , SCRX.get_credit_note_status , 'Status of credit note  should be  complete'
			gen_include "TRN", SCRX.get_credit_note_transaction_number , "Expected transaction number to be generated for posted invoice."
			SCRX.click_transaction_number
			gen_compare "-102,465.00",TRANX.get_account_total, "Expected account total to be -102,465.00"
			gen_compare "-102,465.00",TRANX.get_account_outstanding_total, "Expected account outstanding total to be -102,465.00"
			gen_compare "204,930.00",TRANX.get_home_debits, "Expected account home debits total to be 204,930.00"
			gen_compare "204,930.00",TRANX.get_dual_debits, "Expected account dual debits total to be -204,930.00"
		end
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		# Changing the layout of invoice,credit note and line items again to normal layout
		SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_normal_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_normal_layout
		SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_sales_invoice_line_item_normal_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_sales_credit_note_line_items_normal_layout
		# changing button properties to normal
		# changing button properties to normal
		SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_new
		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_edit
		
		SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_view
		
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_new
		
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_edit
		
		SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
		SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_view	
		gen_end_test "TID013546-Create Sales Invoice and credit note with 81 line items using API"	
		SF.logout 
	end
end
