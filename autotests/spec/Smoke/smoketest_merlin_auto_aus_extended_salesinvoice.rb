#--------------------------------------------------------------------#
#	TID : TID013406
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: InterCompany Account (Smoke Test)
# 	Story: 23713
#--------------------------------------------------------------------#

describe "Smoke Test Create sales invoice.", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		# Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID013406 : Convert invoice into creditnote on extended layout"
	end
	
it "TID013406:Invoice- Create a new sales invoice and convert it into credit note using extended layout. " do
	# using general method to get date as date format is always set to dd/mm/yyyy through smoke_setup scripts.
	_today_date_plus_8 = gen_date_plus_days 8
	_today_date = gen_date_plus_days 0

	SF.app $accounting
	#1.1
	begin
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_aus] ,true
	end
			
	#Prerequisite 
	gen_start_test  'Test Step TST017138, Additional Comments'
	begin
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_extended_layout
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

			SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_invoice_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_credit_note_line_item_extended_layout
	end
	gen_start_test  'Test Step TST017138, Create and post sales invoice.'
	begin
			#Section 1.1
			begin
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SF.wait_for_search_button
				SINX.set_account $bd_account_jboag_brewing
				SINX.set_account_dimension $sinx_dimension1_label ,$bd_dim1_tasmania
				SINX.set_invoice_date _today_date
				SINX.set_dual_rate "0.56"
				SF.click_button_save
				SF.wait_for_search_button
				FFA.click_manage_line
				SINX.add_line_items "1" , $bd_product_auto_com_clutch_kit_1989_dodge_raider , "20" , "89.40" , $bd_tax_code_gst_sales
				SINX.add_new_line
				SINX.add_line_items "2" , $bd_product_bbk_fuel_pump_power_plus_series_universal , "20" , "205.80" , $bd_tax_code_gst_sales
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				page.has_button?($ffa_post_button)
				FFA.click_post
				SINX.click_post_invoice
				# 1.1 Expected Result
				
				_transaction_number = SINX.get_invoice_transaction_number
				_invoice_number = SINX.get_invoice_number
				gen_include "TRN" ,  _transaction_number , "TST017138: Expected transaction number generated to have prefix TRN."
				_invoice_status = SINX.get_invoice_status
				gen_include _invoice_status , $bd_document_status_complete , "TST017138: Expected Invoice status : Complete."
		
				SINX.click_transaction_number
				_account_total = TRANX.get_account_total
				gen_compare "6,435.36" , _account_total , "TID012955-Expected Invoice total amount 6,435.36."
				
				_account_outstanding_total = TRANX.get_account_outstanding_total
				gen_compare "6,435.36" , _account_outstanding_total , "TID012955-Expected Invoice outstanding total: 6,435.36"
				
				_home_debits = TRANX.get_home_debits
				gen_compare "6,435.36" , _home_debits , "TID012955-Expected Invoice home debit value : 6,435.36."
				
				_dual_debits = TRANX.get_dual_debits
				gen_compare "3,603.80" , _dual_debits , "TID012955-Expected Invoice Dual debit: 3,603.80 "
			end
			# Section 1.2

			begin
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SINX.open_invoice_detail_page _invoice_number
				FFA.click_classic_view
				FFA.click_amend_document
				page.has_button?('Save')
				SINX.set_customer_reference_on_amend_document 'sprint135'
				SF.click_button_save
				SF.wait_for_search_button
				#Section 1.2 expected Result
				_customer_reference = SINX.get_customer_reference_number
				gen_compare "sprint135" , _customer_reference , "TID012955-Expect Invoice customer Reference to be sprint135."
			end
			
			# Section 1.3
			begin
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SINX.open_invoice_detail_page _invoice_number
				FFA.click_classic_view
				SF.wait_for_search_button
				new_window_pdf = window_opened_by do
					FFA.click_print_pdf
				end
				#Expected Result
				# Section 1.3 expected Result
				within_window (new_window_pdf) do
					page.has_text?(_invoice_number)
					expect(page).to have_content(_invoice_number)
					gen_report_test "Expected: PDF report for created invoice is successfully generated."
					page.current_window.close
				end
			end
	end
	gen_start_test  'Test Step TST017172, Convert sales invoice into credit note.'
	begin
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SINX.open_invoice_detail_page _invoice_number
			SINX.convert_to_credit_note
			SINX.convert_to_credit_note_confirm
			SF.click_button_edit
			SCRX.set_creditnote_date _today_date_plus_8
			SF.click_button_save
			SF.wait_for_search_button
			FFA.click_manage_line
			SCRX.line_set_quantity  "1" , "1"
			SCRX.line_set_quantity  "2" , "1"
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
			page.has_button?($ffa_post_button)
			FFA.click_post_match
			FFA.click_match
			
			# 1.1 Expected Result
			_credit_note_description = SCRX.get_credit_note_description  
			gen_include _invoice_number , _credit_note_description , "TST010972- Expected invoice number to be updated in credit note description. "
			gen_include "TRN" ,  SCRX.get_credit_note_transaction_number , "TST017172: Expected transaction number generated to have prefix TRN."
			_credit_note_invoice_date = SCRX.get_credit_note_invoice_date
			gen_compare  _today_date , _credit_note_invoice_date ,"TST017172-Expect credit note invoice Date to be today: " + _today_date
			_credit_note_payment_status = SCRX.get_payment_status_from_matched_payment_section _invoice_number
			gen_compare $bd_document_payment_status_part_paid,_credit_note_payment_status ,  "TST010977-Expect credit note Payment status: Paid."
			gen_compare _invoice_number , SCRX.get_invoice_number , "TST017172-Expected Invoice number in credit note to be "	+_invoice_number
			_credit_note_status = SCRX.get_credit_note_status
			gen_compare $bd_document_status_complete , _credit_note_status , "TST017172: Expected credit Note status status : Complete."
	end
	
	gen_start_test  'Test Step TST017173, Create sales invoice with dual exchange rate and post it.'
	begin
			# Section 1.1
			begin
				SF.tab $tab_sales_credit_notes
				SF.click_button_new
				SF.wait_for_search_button
				SCRX.set_account $bd_account_jboag_brewing
				SCRX.set_account_dimension $scrx_dimension_1_label,$bd_dim1_tasmania
				SCRX.set_creditnote_date _today_date_plus_8
				SCRX.set_dual_rate "0.56"
				SF.click_button_save
				SF.wait_for_search_button
				FFA.click_manage_line
				SCRX.add_line_items "1" , $bd_product_bbk_fuel_pump_power_plus_series_universal , "19" , "20" , $bd_tax_code_gst_sales
				SF.click_button_save
				gen_wait_until_object_disappear $ffa_manage_lines_saving_locator
				page.has_button?($ffa_post_button)
				FFA.click_post
				SF.wait_for_search_button
				FFA.click_continue
				SF.wait_for_search_button
				_credit_note_number = SCRX.get_credit_note_number
				_transaction_number = SCRX.get_credit_note_transaction_number
				
				# Section 1.1 expected result
				gen_include "TRN" ,  _transaction_number , "TST017173: Expected transaction number generated to have prefix TRN."
				_credit_note_status = SCRX.get_credit_note_status
				gen_compare _credit_note_status , $bd_document_status_complete , "TST017173: Expected credit note status : Complete."
				
				_credit_note_total = SCRX.get_credit_note_total
				gen_compare  "414.20" ,_credit_note_total, "TST017173: Expected credit note Total : 414.20."
			end
			# Section 1.2
			begin
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SCRX.open_credit_note_detail_page _credit_note_number
				FFA.click_classic_view
				FFA.click_amend_document
				# Performing operation from classic view(vf page), calling vf page method to edit customer reference.
				SCR.edit_customer_reference  "sprint135"
				SF.click_button_save
				SF.wait_for_search_button
				# Expected Result
				_customer_reference = SCRX.get_customer_reference_number
				gen_compare "sprint135" , _customer_reference , "TST017173-Expect Invoice customer Reference to be sprint135."
			end
			
			# Section 1.3
			begin
				SF.tab $tab_sales_credit_notes
				SF.select_view $bd_select_view_all
				SF.click_button_go
				SCRX.open_credit_note_detail_page _credit_note_number
				FFA.click_classic_view
				new_tab = window_opened_by do
					FFA.click_print_pdf
				end
				#Expected Result
				within_window (new_tab) do
					page.has_text?(_credit_note_number)
					expect(page).to have_content(_credit_note_number)
					gen_report_test "Expected: PDF report for created Credit note is successfully generated."
					page.current_window.close
				end
			end
	end
end
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		# Changing the layout of invoice,credit note and line items again to normal layout
		SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_normal_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_normal_layout
		SF.edit_extended_layout $ffa_object_sales_invoice_line_item, $ffa_profile_system_administrator, $ffa_sales_invoice_line_item_normal_layout
		SF.edit_extended_layout $ffa_object_sales_credit_note_line_item, $ffa_profile_system_administrator, $ffa_sales_credit_note_line_items_normal_layout
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
	
		gen_end_test "TID013406 : Convert invoice into creditnote on extended layout"
		SF.logout 
	end
end	
