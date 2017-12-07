#--------------------------------------------------------------------#
#	TID : TID019906	
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Accounting - FM Community (Smoke Test)
#--------------------------------------------------------------------#

describe "Smoke Test - FM Community", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	_line1 = 1
	_unit_price_100 = "100"
	_reference_number_sin1 = "SIN1_100"
	_unit_price_200 = "200"
	_reference_number_sin2 = "SIN2_200"
	invoice_document_type = "Invoices"
	credit_note_document_type = "Credit Notes"
	payment_document_type = "Payments"
	unallocated_payment_label = "Unallocated Payments"	
	_ce1_num = nil
	_ce2_num = nil
	_sin1_num = nil
	_sin2_num = nil
	_scr1_num = nil
	_scr2_num = nil
	inv1_due_date, inv2_due_date ,scr1_due_date,scr2_due_date  = nil,nil,nil,nil
	inv1_row_data,inv2_row_data,scr1_row_data,scr2_row_data,payment1_row,payment2_row = nil,nil,nil,nil,nil,nil
	#Message text
	welcome_text_message = "Welcome to MyAccount"
	myaccount_balance_msg = "Your account balance reflects the outstanding value of all invoices, billing invoices, credit notes, billing credit notes, unallocated cash and any internal adjustments posted to your account. All values on this page are in your account currency."
	date_today =  Time.now.strftime("%d/%m/%Y")
	
	before :all do
		# Hold Base Data
		FFA.hold_base_data_and_wait
		# Select Company
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true
		# Create Sales Invoices , Sales Credit Note and Cash Entry
		# Sales Invoice
		begin
			SF.tab $tab_sales_invoices
			SF.wait_for_search_button
			SF.click_button_new
			SIN.set_account $bd_account_bolinger
			SIN.set_invoice_date date_today
			# Add new line
			FFA.click_new_line
			SIN.line_set_product_name _line1 , $bd_product_a4_paper
			SIN.line_set_unit_price _line1 , _unit_price_100
			SIN.set_customer_reference _reference_number_sin1
			FFA.click_save_post
			_sin1_num = SIN.get_invoice_number
			inv1_due_date= SIN.get_due_date
			gen_compare $bd_document_status_complete, SIN.get_status, "Expected Sales Invoice status to be Complete"
			
		end
		begin
			SF.tab $tab_sales_invoices
			SF.wait_for_search_button
			SF.click_button_new
			SIN.set_account $bd_account_bolinger
			SIN.set_invoice_date date_today
			# Add new line
			FFA.click_new_line
			SIN.line_set_product_name _line1 , $bd_product_a4_paper
			SIN.line_set_unit_price _line1 , _unit_price_200
			SIN.set_customer_reference _reference_number_sin2
			FFA.click_save_post
			_sin2_num = SIN.get_invoice_number
			gen_compare $bd_document_status_complete, SIN.get_status, "Expected Sales Invoice status to be Complete"
			inv2_due_date= SIN.get_due_date
			
		end
		# sales credit note
		begin
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCR.set_account $bd_account_bolinger
			SCR.set_creditnote_date date_today
			FFA.click_new_line
			SCR.line_set_product_name _line1 , $bd_product_a4_paper
			SCR.line_set_unit_price _line1 , _unit_price_100
			FFA.click_save_post
			gen_compare $bd_document_status_complete, SCR.get_credit_note_status, "Expected sales credit note to be saved successfully"
			_scr1_num = SCR.get_credit_note_number
			scr1_due_date = SCR.get_due_date
		end
		
		begin
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCR.set_account $bd_account_bolinger
			SCR.set_creditnote_date date_today
			FFA.click_new_line
			SCR.line_set_product_name _line1 , $bd_product_a4_paper
			SCR.line_set_unit_price _line1 , _unit_price_200
			FFA.click_save_post
			gen_compare $bd_document_status_complete, SCR.get_credit_note_status, "Expected sales credit note to be saved successfully"
			_scr2_num = SCR.get_credit_note_number
			scr2_due_date = SCR.get_due_date
		end
		# Cash Entry
		begin
			SF.tab $tab_cash_entries
			SF.click_button_new 
			CE.select_cash_entry_type $bd_cash_entry_receipt_type
			CE.set_bank_account $bd_bank_account_bristol_euros_account
			CE.set_date date_today
			CE.set_currency $bd_currency_eur,$company_merlin_auto_usa
			CE.line_set_account_name $bd_account_bolinger
			#Add line
			FFA.click_new_line
			CE.line_set_cashentryvalue _line1 , _unit_price_200
			FFA.click_save_post
			gen_compare $bd_document_status_complete, CE.get_cash_entry_status, "Expected cash entry status to be Complete."
			_ce1_num = CE.get_cash_entry_number
		end
		
		begin
			SF.tab $tab_cash_entries
			SF.click_button_new
			CE.select_cash_entry_type $bd_cash_entry_refund_type
			CE.set_bank_account $bd_bank_account_bristol_euros_account
			CE.set_date date_today
			CE.set_currency $bd_currency_eur,$company_merlin_auto_usa
			CE.line_set_account_name $bd_account_bolinger
			# Add line
			FFA.click_new_line
			CE.line_set_cashentryvalue _line1 , _unit_price_100
			FFA.click_save_post
			gen_compare $bd_document_status_complete, CE.get_cash_entry_status, "Expected cash entry status to be Complete"
			_ce2_num = CE.get_cash_entry_number
		end
		begin
			# Cash matching of SIN/SCR with Cash entry
			# Cash matching wof CE1 and SIN2
			SF.tab $tab_cash_matching
			CM.set_cash_matching_account $bd_account_bolinger
			CM.set_matching_date date_today
			CM.click_retrieve
			page.has_text?(_ce2_num)
			CM.select_cashentry_doc_for_matching _ce1_num, 1
			CM.select_trans_doc_for_matching _sin2_num , 1
			CM.click_commit_data
			SF.wait_for_search_button
			# verify SIN payment status
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sin2_num
			payment_status = SIN.get_invoice_payment_status
			gen_compare $bd_document_payment_status_paid , payment_status , "Expected Invoice Status  to be paid for "	+_sin2_num
			
			# Cash Matching of Documents Cash entry 2 with sales credit note 2
			SF.tab $tab_cash_matching
			CM.set_cash_matching_account $bd_account_bolinger
			CM.set_matching_date date_today
			CM.click_retrieve
			page.has_text?(_ce2_num)
			CM.select_cashentry_doc_for_matching _ce2_num, 1
			CM.select_trans_doc_for_matching _scr2_num , 1
			CM.set_trans_doc_paid_amount "-100" , 1
			CM.click_commit_data
			SF.wait_for_search_button
			# check payment value
			SF.tab $tab_sales_credit_notes
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _scr2_num
			payment_status = SCR.get_document_payment_status
			gen_compare $bd_document_payment_status_part_paid , payment_status , "Expected Invoice Status  to be part paid for "	+_scr2_num
		end
		#Expected row data for documents
		inv1_row_data = "Merlin Auto USA #{_sin1_num} #{date_today} #{inv1_due_date} #{_reference_number_sin1} EUR 100.00 100.00 Unpaid EUR 100.00 100.00"
		inv2_row_data = "Merlin Auto USA #{_sin2_num} #{date_today} #{inv2_due_date} #{_reference_number_sin2} EUR 200.00 0.00 Paid EUR 200.00 0.00"
		scr1_row_data = "Merlin Auto USA #{_scr1_num} #{date_today} #{scr1_due_date} EUR -100.00 -100.00 Unpaid EUR -100.00 -100.00"
		scr2_row_data = "Merlin Auto USA #{_scr2_num} #{date_today} #{scr2_due_date} EUR -200.00 -100.00 Part Paid EUR -200.00 -100.00"
		payment1_row = "Merlin Auto USA Payment #{date_today} EUR -200.00 -200.00 0.00 EUR -200.00 -200.00 0.00"
		payment2_row = "Merlin Auto USA Refund #{date_today} EUR 100.00 100.00 0.00 EUR 100.00 100.00 0.00"
	end
	
	it "TID019906:TST032323 and TID019579-TST031598- Verify list view of (TST032323)MyAccount tab on Community and (TST031598)default home page of links. " do	
		#Navigate to contact tab to login to community as user.
		SF.tab  $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		SF.click_button_go
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		Contacts.open_contact_detail_page full_name
		Contacts.manage_external_user $contacts_login_to_community_as_user
		page.has_text?($tab_community_myaccounts)
		# Verify MyAccount tab on community
		gen_compare_has_content $tab_community_myaccounts , true , "Expected #{$tab_community_myaccounts}  to be displayed successfully."

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		# wait for the images to load
		gen_wait_until_object $myaccount_pie_chart_locator
		MYACCOUNT.expand_side_bar
		#Expect the links presence on myaccount tab
		gen_compare_has_link $myaccount_account_balance_summary_link , true , "Expected Account Balance Summary link to be displayed under My Account tab."
		gen_compare_has_link $myaccount_account_balance_details_link , true , "Expected Account Balance Details link to be displayed under My Account tab."
		
		#Expect message content to be displayed on myaccount tab
		gen_compare_has_content welcome_text_message , true , "Expected #{welcome_text_message} message to be displayed successfully."
		gen_compare_has_content myaccount_balance_msg , true , "Expected #{myaccount_balance_msg} message to be displayed successfully."
		
		# Expect pie chart on myaccount tab
		gen_compare_has_css $myaccount_pie_chart_locator , true , "Expected pie chart to be displayed."
		
		# Verify the details on account summary section-Company name and balance
		company_present =  MYACCOUNT.is_value_present_account_balance_section $company_merlin_auto_usa
		amount_present =  MYACCOUNT.is_value_present_account_balance_section "-100.00"
		gen_compare company_present, amount_present , "Expected Company Merlin auto USA:#{company_present} and amount -100.00#{amount_present} to be present under account balance section"
		
		# Verify the amount of documents under summary section
		invoice_amount =  MYACCOUNT.get_document_outstanding_amount invoice_document_type
		credit_note_amount =  MYACCOUNT.get_document_outstanding_amount credit_note_document_type
		unallocated_payment_amount =  MYACCOUNT.get_document_outstanding_amount unallocated_payment_label
		gen_compare "100.00" , invoice_amount, "Expected Amount for Invoices to be 100.00"
		gen_compare "-200.00" , credit_note_amount, "Expected Amount for Credit notes to be -200.00"
		gen_compare "0.00" , unallocated_payment_amount, "Expected Amount for Unallocated Payments to be 0.00"
		
		#Navigate to Account Balance detail section to verify as per TID019579-TST031598
		SF.click_link $myaccount_account_balance_details_link
		# Get the default selected value of document type and payment status filters and verify it.
		doc_type_value =  MYACCOUNT.get_document_type_picklist_selected_value
		gen_compare invoice_document_type, doc_type_value , "Expected Document type picklist value to be Invoices on balance details link"
		#Navigate to Account Balance summary  section to verify that landing page is displayed.
		SF.click_link $myaccount_account_balance_summary_link
		#Expect message content to be displayed when user go to balance summary link.
		gen_compare_has_content welcome_text_message , true , "Expected #{welcome_text_message} message to be displayed successfully on balance summary link page."
		gen_compare_has_content myaccount_balance_msg , true , "Expected #{myaccount_balance_msg} message to be displayed successfully on balance summary link page.."
		
		# Expect pie chart on landing page
		gen_compare_has_css $myaccount_pie_chart_locator , true , "Expected pie chart to be displayed on balance summary link page."
	end	
	
	it "TID019906:TST032324- Verify MyAccount:Account balance details section and document content. " do	
		login_user
		
		# Navigate to contact tab to login to community as user.
		SF.tab  $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		SF.click_button_go
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		Contacts.open_contact_detail_page full_name
		Contacts.manage_external_user $contacts_login_to_community_as_user
		page.has_text?($tab_community_myaccounts)
		# Verify MyAccount tab on community
		gen_compare_has_content $tab_community_myaccounts , true , "Expected #{$tab_community_myaccounts}  to be displayed successfully."

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		# wait for the images to load
		gen_wait_until_object $myaccount_pie_chart_locator
		MYACCOUNT.expand_side_bar
		#Navigate to Account Balance detail section
		SF.click_link $myaccount_account_balance_details_link
		page.has_css?($myaccount_apply_filter_button)
		
		# Get the default selected value of document type and payment status filters and verify it.
		doc_type_value =  MYACCOUNT.get_document_type_picklist_selected_value
		payment_value =  MYACCOUNT.get_payment_status_picklist_selected_value
		gen_compare invoice_document_type, doc_type_value , "Expected Document type picklist value to be Invoices"
		gen_compare "Outstanding", payment_value , "Expected Payment Status picklist value to be Outstanding"
		
		# Get the row data of Invoices Document type
		sin_row_data = MYACCOUNT.get_document_row_content _sin1_num
		gen_compare inv1_row_data , sin_row_data , "Expected row data for invoice to be -#{sin_row_data} "
		
		# select document type as credit notes and get the row content to verify.
		MYACCOUNT.select_document_type credit_note_document_type
		scr1_data = MYACCOUNT.get_document_row_content _scr1_num
		gen_compare scr1_row_data , scr1_data , "Expected row data for invoice to be -#{scr1_row_data} "
		scr2_data = MYACCOUNT.get_document_row_content _scr2_num
		gen_compare scr2_row_data , scr2_data , "Expected row data for invoice to be -#{scr2_row_data} "
		
		# Select payment as document type and verify the rows
		MYACCOUNT.select_document_type payment_document_type
		ce1_data = MYACCOUNT.get_payment_row_content "1"
		gen_compare payment1_row , ce1_data , "Expected row data for row 1 of payment to be -#{payment1_row} "
		ce2_data = MYACCOUNT.get_payment_row_content "2"
		gen_compare payment2_row , ce2_data , "Expected row data for row 2 of payment to be -#{payment2_row} "
	end	
	
	it "TID019906:TST032325- Verify print and view detail of document on community-MyAccount tab. " do	
		login_user
		
		# Navigate to contact tab to login to community as user.
		SF.tab  $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		SF.click_button_go
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		Contacts.open_contact_detail_page full_name
		Contacts.manage_external_user $contacts_login_to_community_as_user
		page.has_text?($tab_community_myaccounts)
		# Verify MyAccount tab on community
		gen_compare_has_content $tab_community_myaccounts , true , "Expected #{$tab_community_myaccounts}  to be displayed successfully."

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		# wait for the images to load
		gen_wait_until_object $myaccount_pie_chart_locator
		MYACCOUNT.expand_side_bar
		#Navigate to Account Balance detail section
		SF.click_link $myaccount_account_balance_details_link
		page.has_css?($myaccount_apply_filter_button)
		
		# Verify the presence of print pdf and view detail image for documents.
		MYACCOUNT.select_document_type invoice_document_type
		expect(page).to have_css($myaccount_document_print_locator ,:count => 1)
		gen_report_test "Expected one icon to print the document details."
		expect(page).to have_css($myaccount_document_view_detail_locator ,:count => 1)
		gen_report_test "Expected one icon to view detail page of the document details."
		
		# click on view details for invoice
		new_window_instance = window_opened_by do
			MYACCOUNT.click_view_detail _sin1_num
		end
		#Verify the details on view detail
		within_window (new_window_instance) do
			page.has_text?(_sin1_num)
			expect(page).to have_content(_sin1_num)
			gen_report_test "Expected: Detail page to display the Invoice number header details."
			expect(page).to have_content($bd_account_bolinger)
			gen_report_test "Expected: Detail page to display the account info in  header details."
			expect(page).to have_content($bd_product_a4_paper)
			gen_report_test "Expected: Detail page to display the Line Item details."	
			FFA.close_new_window
		end
		
		#click on print pdf for invoice
		new_window_pdf = window_opened_by do
			MYACCOUNT.click_print_pdf _sin1_num
		end
		
		#Verify the details on pdf
		within_window (new_window_pdf) do
			page.has_text?(_sin1_num)
			expect(page).to have_content(_sin1_num)
			gen_report_test "Expected: PDF report for created invoice is successfully generated."
			expect(page).to have_content($bd_product_a4_paper)
			gen_report_test "Expected: Line details to be displayed in PDF."
			FFA.close_new_window
		end
		
		# Select credit notes as document type
		MYACCOUNT.select_document_type credit_note_document_type
		# Verify the presence of print pdf and view detail image for documents. 
		expect(page).to have_css($myaccount_document_print_locator ,:count => 2)
		gen_report_test "Expected one icon to print the document details."
		expect(page).to have_css($myaccount_document_view_detail_locator ,:count => 2)
		gen_report_test "Expected one icon to view detail page of the document details."
		
		# click on view details for invoice
		new_window_scr_view = window_opened_by do
			MYACCOUNT.click_view_detail _scr1_num
		end
		
		#Verify the details on view detail
		within_window (new_window_scr_view) do
			page.has_text?(_scr1_num)
			expect(page).to have_content(_scr1_num)
			gen_report_test "Expected: Detail page to display the Invoice number header details."
			expect(page).to have_content($bd_account_bolinger)
			gen_report_test "Expected: Detail page to display the account info in  header details."
			FFA.close_new_window
		end
		
		#click on print pdf for invoice
		new_window_scr_pdf = window_opened_by do
			MYACCOUNT.click_print_pdf _scr1_num
		end
		
		#Verify the details on pdf
		within_window (new_window_scr_pdf) do
			page.has_text?(_scr1_num)
			expect(page).to have_content(_scr1_num)
			gen_report_test "Expected: PDF report for created invoice is successfully generated."
			expect(page).to have_content($bd_product_a4_paper)
			gen_report_test "Expected: Line details to be displayed in PDF."
			FFA.close_new_window
		end
	end
	
	it "TID019906:TST032326- Verify filters. " do	
		login_user
		
		# Navigate to contact tab to login to community as user.
		SF.tab  $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		SF.click_button_go
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		Contacts.open_contact_detail_page full_name
		Contacts.manage_external_user $contacts_login_to_community_as_user
		page.has_text?($tab_community_myaccounts)
		# Verify MyAccount tab on community
		gen_compare_has_content $tab_community_myaccounts , true , "Expected #{$tab_community_myaccounts}  to be displayed successfully."

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		# wait for the images to load
		gen_wait_until_object $myaccount_pie_chart_locator
		MYACCOUNT.expand_side_bar
		#Navigate to Account Balance detail section
		SF.click_link $myaccount_account_balance_details_link
		page.has_css?($myaccount_apply_filter_button)
		# select invoice as document type.
		MYACCOUNT.select_document_type invoice_document_type
		
		#Verify the filters present for Invoices.
		gen_compare_has_css $myaccount_document_type_fillter, true, "Expected document type filter to be displayed"
		gen_compare_has_css $myaccount_payment_status_fillter, true, "Expected payment status filter to be displayed"
		gen_compare_has_css $myaccount_document_number_from_date_fillter, true, "Expected document number from filter to be displayed"
		gen_compare_has_css $myaccount_document_number_to_date_fillter, true, "Expected document number to  filter to be displayed"
		gen_compare_has_css $myaccount_date_range_from_fillter, true, "Expected date range from filter to be displayed"
		gen_compare_has_css $myaccount_date_range_to_fillter, true, "Expected date range to filter to be displayed"
		gen_compare_has_css $myaccount_payment_type_fillter, false, "Expected payment type filter NOT  be displayed"
		
		# Select payment status as Paid for Invoices
		MYACCOUNT.select_payment_status $bd_document_payment_status_paid
		MYACCOUNT.click_apply_filter
		
		#Veify the retrieved SIN2 data.
		sin2_row_data = MYACCOUNT.get_document_row_content _sin2_num
		gen_compare inv2_row_data , sin2_row_data , "Expected row data for invoice to be -#{inv2_row_data} "
		
		# Select Credit Notes as Document type
		MYACCOUNT.select_document_type credit_note_document_type
		#Verify the filters present for Credit Notes.
		gen_compare_has_css $myaccount_document_type_fillter, true, "Expected document type filter to be displayed"
		gen_compare_has_css $myaccount_payment_status_fillter, true, "Expected payment status filter to be displayed"
		gen_compare_has_css $myaccount_document_number_from_date_fillter, true, "Expected document number from filter to be displayed"
		gen_compare_has_css $myaccount_document_number_to_date_fillter, true, "Expected document number to  filter to be displayed"
		gen_compare_has_css $myaccount_date_range_from_fillter, true, "Expected date range from filter to be displayed"
		gen_compare_has_css $myaccount_date_range_to_fillter, true, "Expected date range to filter to be displayed"
		gen_compare_has_css $myaccount_payment_type_fillter, false, "Expected payment type filter NOT  be displayed"
		
		# select part paid and apply filters
		MYACCOUNT.select_payment_status $bd_document_payment_status_part_paid
		MYACCOUNT.click_apply_filter
		
		#Veify the retrieved SCR2 data.
		scr2_data = MYACCOUNT.get_document_row_content _scr2_num
		gen_compare scr2_row_data , scr2_data , "Expected row data for invoice to be -#{scr2_row_data} "
		
		# Select payment as document type.
		MYACCOUNT.select_document_type payment_document_type
		#Verify the filters present for Payment
		gen_compare_has_css $myaccount_document_type_fillter, true, "Expected document type filter to be displayed"
		gen_compare_has_css $myaccount_payment_status_fillter, false, "Expected payment status filter NOT to be displayed"
		gen_compare_has_css $myaccount_document_number_from_date_fillter, false, "Expected document number from filter NOT to be displayed"
		gen_compare_has_css $myaccount_document_number_to_date_fillter, false, "Expected document number to  filter NOT to be displayed"
		gen_compare_has_css $myaccount_date_range_from_fillter, true, "Expected date range from filter to be displayed"
		gen_compare_has_css $myaccount_date_range_to_fillter, true, "Expected date range to filter to be displayed"
		gen_compare_has_css $myaccount_payment_type_fillter, true, "Expected payment type filter to  be displayed"
		
		# select part paid and apply filters
		MYACCOUNT.select_payment_type "Payment"
		MYACCOUNT.click_apply_filter
		
		#verify the payment row data CE1
		ce1_data = MYACCOUNT.get_payment_row_content "1"
		gen_compare payment1_row , ce1_data , "Expected row data for row 1 of payment to be -#{payment1_row} "
		
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID019906	 : FM community Smoke Test. "
		SF.logout
	end
end
