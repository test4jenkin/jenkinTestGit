#--------------------------------------------------------------------#
#	TID : TID021760
#	TID : TID021873
#   Org Type : Managed and Unmanaged
#	Pre-Requisite: 
#		a) Run setup_data.rb in the setup_data folder
#		b) Install FinancialFore ERP Package
#		c) Install FinancialFore Billing Central Package
#		d) For Unmanaged : Deploy FFA with deploy.light property
#		e) For Managed : Deploy the FFA Package
#	Product Area: Accounting - FM Communities
#   driver=firefox rspec spec/fm_community_erp_billingcentral/fm_community_billing_documents_TID021760.rb -o TID021760.html
#   
#--------------------------------------------------------------------#

describe "TID021760 | TID021873-Verify that user is able to view Billing Documents of document type - Invoice and Credit Notes ,that are exposed in FF Communities | Verify that user is able to print Billing Documents that are exposed in FF Communities.", :type => :request do
	include_context "login"
	include_context "logout_after_each"

	invoice_document_type = "Billing Invoices"
	credit_note_document_type = "Billing Credit Notes"
	document_type = "Billing Documents"
	billing_document_type_invoices = "Invoices"
	billing_document_type_credit_notes = "Credit Notes"
	invoice_label = "Invoice"
	credit_note_label = "Credit Note"
	invoice_document_total = "USD 400.00"
	crn_document_total = "USD 200.00"
	document_number_inv = nil
	document_number_crn = nil

	date_today =  Time.now.strftime("%d/%m/%Y")
	due_date =  (Time.now + (60*60*24*30)).strftime("%d/%m/%Y")
	inv_row_data  = "#{invoice_label} #{date_today} #{due_date} REF 123 USD 400.00 400.00 Unpaid"
	crn_row_data  = "#{credit_note_label} #{date_today} #{due_date} REF 123 USD 200.00 -200.00 Unpaid"
	community_inv_row = "A4 Paper 1.000000 400.000000000 0.000 USD 0.00 USD 400.00"
	community_crn_row = "A4 Paper 1.000000 200.000000000 0.000 USD 0.00 USD 200.00"
	#Message text
	welcome_text_message = "Welcome to MyAccount"
	myaccount_balance_msg = "Your account balance reflects the outstanding value of all invoices, billing invoices, credit notes, billing credit notes, unallocated cash and any internal adjustments posted to your account. All values on this page are in your account currency."

	erp_company = "ERP Company"
	query = "Select Name From fferpcore__BillingDocument__c WHERE fferpcore__DocumentType__c = '#{$sf_param_substitute}' AND #{ORG_PREFIX}PostingStatus__c = 'Posted'"

	before :all do
		## Hold Base Data
		FFA.hold_base_data_and_wait
		## Select Company
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		#Fetch Invoice Number
		APEX.execute_soql query.gsub($sf_param_substitute,invoice_label)
		document_number_inv = APEX.get_field_value_from_soql_result "Name"

		#Fetch Credit Note Number
		APEX.execute_soql query.gsub($sf_param_substitute,credit_note_label)
		document_number_crn = APEX.get_field_value_from_soql_result "Name"
	end
	
	it "TID021760:TST038640- Verify list view of MyAccount tab on Community. " do
		login_in_as_community_user

		# Verify MyAccount tab on community
		gen_compare_has_content $tab_community_myaccounts , true , "Expected #{$tab_community_myaccounts}  to be displayed successfully."

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		# wait for the images to load
		gen_wait_until_object $myaccount_pie_chart_locator
		
		#Expect message content to be displayed on myaccount tab
		gen_compare_has_content welcome_text_message , true , "Expected #{welcome_text_message} message to be displayed successfully."
		gen_compare_has_content myaccount_balance_msg , true , "Expected #{myaccount_balance_msg} message to be displayed successfully."
		
		# Expect pie chart on myaccount tab
		gen_compare_has_css $myaccount_pie_chart_locator , true , "Expected pie chart to be displayed."
		
		# Verify the details on account summary section-Company name and balance
		company_present =  MYACCOUNT.is_value_present_account_balance_section $company_merlin_auto_spain
		amount_present =  MYACCOUNT.is_value_present_account_balance_section "200.00"
		gen_compare company_present, amount_present , "Expected Company Merlin auto Spain:#{company_present} and amount 200.00#{amount_present} to be present under account balance section"
		
		# Verify the amount of documents under summary section
		invoice_amount =  MYACCOUNT.get_document_outstanding_amount invoice_document_type
		credit_note_amount =  MYACCOUNT.get_document_outstanding_amount credit_note_document_type
		gen_compare "400.00" , invoice_amount, "Expected Amount for Invoices to be 400.00"
		gen_compare "-200.00" , credit_note_amount, "Expected Amount for Credit notes to be -200.00"
	end	

	it "TID021760:TST038641- Verify that filters exists for newly created Billing Documents of Invoice And Credit Note type." do	
		login_user
		login_in_as_community_user

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		gen_wait_until_object $myaccount_pie_chart_locator
		
		#Navigate to Account Balance detail section
		SF.click_link $myaccount_account_balance_details_link
		page.has_css?($myaccount_apply_filter_button)
		# select invoice as document type.
		MYACCOUNT.select_document_type document_type
		
		#Verify the filters present for Invoices.
		gen_compare_has_css $myaccount_document_type_fillter, true, "Expected document type filter to be displayed"
		gen_compare_has_css $myaccount_payment_status_fillter, true, "Expected payment status filter to be displayed"
		gen_compare_has_css $myaccount_billing_document_type_filter, true, "Expected Billing Document Type filter to be displayed"
		gen_compare_has_css $myaccount_document_number_from_date_fillter, true, "Expected document number from filter to be displayed"
		gen_compare_has_css $myaccount_document_number_to_date_fillter, true, "Expected document number to  filter to be displayed"
		gen_compare_has_css $myaccount_date_range_from_fillter, true, "Expected date range from filter to be displayed"
		gen_compare_has_css $myaccount_date_range_to_fillter, true, "Expected date range to filter to be displayed"
		
		# Select payment status as Paid for Invoices
		MYACCOUNT.select_payment_status $bd_document_payment_status_unpaid
		MYACCOUNT.select_billing_document_type billing_document_type_invoices
		MYACCOUNT.click_apply_filter
		
		#Verify the retrieved Invoice data.
		bd_inv_row_data = MYACCOUNT.get_document_row_content document_number_inv
		inv_row_data_1 = document_number_inv + " " + inv_row_data
		gen_compare inv_row_data_1 , bd_inv_row_data , "Expected row data for invoice to be -#{inv_row_data_1} "
		
		# Select Credit Notes as Document type
		MYACCOUNT.select_billing_document_type billing_document_type_credit_notes
		MYACCOUNT.click_apply_filter
		
		#Verify the retrieved Credit Note data.
		bd_crn_row_data = MYACCOUNT.get_document_row_content document_number_crn
		crn_row_data_1 = document_number_crn + " " + crn_row_data
		gen_compare crn_row_data_1 , bd_crn_row_data , "Expected row data for credit note to be -#{crn_row_data_1} "
	end
	
	it "TID021760:TST038642|TST038643 - Verify that account balance summary for Billing Documents of Invoice and Credit Note type when applying filters." do	
		login_user
		login_in_as_community_user

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		gen_wait_until_object $myaccount_pie_chart_locator
		
		#Navigate to Account Balance detail section
		SF.click_link $myaccount_account_balance_details_link
		page.has_css?($myaccount_apply_filter_button)
		
		gen_start_test "TST038642| Verify that account balance summary for Billing Documents of Invoice type when applying filters."
		# Filter Set 1 Invoice
		MYACCOUNT.select_payment_status $bd_document_payment_status_paid
		MYACCOUNT.select_billing_document_type billing_document_type_invoices
		MYACCOUNT.click_apply_filter
		expect(page).to have_no_css($myAccount_grid)
		gen_report_test "Expected My Account grid is not present for filter set 1 Invoice"
		
		# Filter Set 2 Invoice
		MYACCOUNT.select_payment_status "All"
		MYACCOUNT.select_billing_document_type billing_document_type_invoices
		MYACCOUNT.set_document_number_from document_number_inv
		MYACCOUNT.set_document_number_to document_number_inv
		MYACCOUNT.click_apply_filter

		expect(page).to have_css($myAccount_grid_rows ,:count => 1)
		gen_report_test "Expected 1 Row is present for filter set 2 Invoice"

		#Verify the retrieved Invoice data.
		bd_inv_row_data = MYACCOUNT.get_document_row_content document_number_inv
		inv_row_data_1 = document_number_inv + " " + inv_row_data
		gen_compare inv_row_data_1 , bd_inv_row_data , "Expected row data for invoice to be -#{inv_row_data_1} "
		
		# Filter Set 3 Invoice
		MYACCOUNT.select_payment_status $bd_document_payment_status_unpaid
		MYACCOUNT.select_billing_document_type billing_document_type_invoices
		MYACCOUNT.set_document_number_from document_number_inv
		MYACCOUNT.set_document_number_to document_number_inv
		MYACCOUNT.set_date_range_from date_today
		MYACCOUNT.set_date_range_to date_today
		MYACCOUNT.click_apply_filter
		expect(page).to have_css($myAccount_grid_rows ,:count => 1)
		gen_report_test "Expected 1 Row is present for filter set 3 Invoice"

		#Verify the retrieved Invoice data.
		bd_inv_row_data = MYACCOUNT.get_document_row_content document_number_inv
		inv_row_data_1 = document_number_inv + " " + inv_row_data
		gen_compare inv_row_data_1 , bd_inv_row_data , "Expected row data for invoice to be -#{inv_row_data_1} "

		gen_end_test "TST038642| Verify that account balance summary for Billing Documents of Invoice type when applying filters."
		
		#Verify for credit note
		gen_start_test "TST038643| Verify that account balance summary for Billing Documents of Credit Notes type when applying filters."
		# Filter Set 1 Credit Note
		MYACCOUNT.select_payment_status $bd_document_payment_status_paid
		MYACCOUNT.select_billing_document_type billing_document_type_credit_notes
		MYACCOUNT.click_apply_filter
		expect(page).to have_no_css($myAccount_grid)
		gen_report_test "Expected My Account grid is not present for filter set 1 Credit Note"
		
		# Filter Set 2 Credit Note
		MYACCOUNT.select_payment_status "All"
		MYACCOUNT.select_billing_document_type billing_document_type_credit_notes
		MYACCOUNT.set_document_number_from document_number_crn
		MYACCOUNT.set_document_number_to document_number_crn
		MYACCOUNT.click_apply_filter
		expect(page).to have_css($myAccount_grid_rows ,:count => 1)
		gen_report_test "Expected 1 Row is present for filter set 2 Credit Note"
		#Verify the retrieved Credit Note data.
		bd_crn_row_data = MYACCOUNT.get_document_row_content document_number_crn
		crn_row_data_1 = document_number_crn + " " + crn_row_data
		gen_compare crn_row_data_1 , bd_crn_row_data , "Expected row data for credit note to be -#{crn_row_data_1} "
		
		# Filter Set 3 Credit Note
		MYACCOUNT.select_payment_status $bd_document_payment_status_unpaid
		MYACCOUNT.select_billing_document_type billing_document_type_credit_notes
		MYACCOUNT.set_document_number_from document_number_crn
		MYACCOUNT.set_document_number_to document_number_crn
		MYACCOUNT.set_date_range_from date_today
		MYACCOUNT.set_date_range_to date_today
		MYACCOUNT.click_apply_filter
		expect(page).to have_css($myAccount_grid_rows ,:count => 1)
		gen_report_test "Expected 1 Row is present for filter set 3 Credit Note"
		#Verify the retrieved Credit Note data.
		bd_crn_row_data = MYACCOUNT.get_document_row_content document_number_crn
		crn_row_data_1 = document_number_crn + " " + crn_row_data
		gen_compare crn_row_data_1 , bd_crn_row_data , "Expected row data for credit note to be -#{crn_row_data_1} "
		gen_end_test "TST038643| Verify that account balance summary for Billing Documents of Credit Notes type when applying filters."
	end
	
	it "TID021760:TST038644|TST038645 - Verify that detail page for Billing Documents of Invoice and Credit Note type when applying filters." do	
		login_user
		login_in_as_community_user

		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		gen_wait_until_object $myaccount_pie_chart_locator
		
		#Navigate to Account Balance detail section
		SF.click_link $myaccount_account_balance_details_link
		page.has_css?($myaccount_apply_filter_button)
		
		gen_start_test "TST038644 - Verify that detail page for Billing Documents of Invoice type when applying filters."
		# Invoice
		MYACCOUNT.select_payment_status $bd_document_payment_status_unpaid
		MYACCOUNT.select_billing_document_type billing_document_type_invoices
		MYACCOUNT.set_document_number_from document_number_inv
		MYACCOUNT.set_document_number_to document_number_inv
		MYACCOUNT.set_date_range_from date_today
		MYACCOUNT.set_date_range_to date_today
		MYACCOUNT.click_apply_filter
		
		# click on view details for invoice
		MYACCOUNT.click_view_detail document_number_inv
		#Verify the details on view detail
		FFA.new_window do
			gen_compare $bd_account_algernon_partners_co,ERPBD.get_account_community_layout, "Account #{$bd_account_algernon_partners_co} is found on Community Layout"
			gen_compare invoice_label,ERPBD.get_document_type_community_layout, "Document type #{invoice_label} is found on Community Layout"
			gen_compare $bd_document_payment_status_unpaid ,ERPBD.get_payment_status_community_layout, "Payment Status #{$bd_document_payment_status_unpaid} is found on Community Layout"
			gen_compare "400.00",ERPBD.get_outstanding_value_community_layout, "Outstanding Value 400.00 is found on Community Layout"
			
			gen_compare community_inv_row,ERPBD.get_billing_document_line_on_community_layout(1),"Row Matched for Invoice"
		end
		gen_end_test "TST038644 - Verify that detail page for Billing Documents of Invoice type when applying filters."
		
		gen_start_test "TST038645 - Verify that detail page for Billing Documents of Credit Note type when applying filters."
		# Invoice
		MYACCOUNT.select_payment_status $bd_document_payment_status_unpaid
		MYACCOUNT.select_billing_document_type billing_document_type_credit_notes
		MYACCOUNT.set_document_number_from document_number_crn
		MYACCOUNT.set_document_number_to document_number_crn
		MYACCOUNT.set_date_range_from date_today
		MYACCOUNT.set_date_range_to date_today
		MYACCOUNT.click_apply_filter
		
		# click on view details for invoice
		MYACCOUNT.click_view_detail document_number_crn
		#Verify the details on view detail
		FFA.new_window do
			gen_compare $bd_account_algernon_partners_co,ERPBD.get_account_community_layout, "Account #{$bd_account_algernon_partners_co} is found on Community Layout"
			gen_compare credit_note_label,ERPBD.get_document_type_community_layout, "Document type #{invoice_label} is found on Community Layout"
			gen_compare $bd_document_payment_status_unpaid ,ERPBD.get_payment_status_community_layout, "Payment Status #{$bd_document_payment_status_unpaid} is found on Community Layout"
			gen_compare "-200.00",ERPBD.get_outstanding_value_community_layout, "Outstanding Value 200.00 is found on Community Layout"
			
			gen_compare community_crn_row,ERPBD.get_billing_document_line_on_community_layout(1),"Row Matched for Credit Note"
		end
		gen_end_test "TST038645 - Verify that detail page for Billing Documents of Credit Note type when applying filters."
	end
	
	it "TID021837:TST038983|TST038984 - Verify User can print billing document of invoice and Credit Note type exposed in community. " do
		login_user
		login_in_as_community_user
		#Navigate to MyAccount tab
		SF.click_link $tab_community_myaccounts
		# wait for the images to load
		gen_wait_until_object $myaccount_pie_chart_locator
		
		#Navigate to Account Balance detail section
		SF.click_link $myaccount_account_balance_details_link
		
		gen_start_test "TID021837:TST038983- Verify User can print billing document of invoice type exposed in community."
		# Invoice
		MYACCOUNT.select_payment_status $bd_document_payment_status_unpaid
		MYACCOUNT.select_billing_document_type billing_document_type_invoices
		MYACCOUNT.set_document_number_from document_number_inv
		MYACCOUNT.set_document_number_to document_number_inv
		MYACCOUNT.set_date_range_from date_today
		MYACCOUNT.set_date_range_to date_today
		MYACCOUNT.click_apply_filter
		
		# click on print button
		MYACCOUNT.click_print_pdf document_number_inv
		#Verify the details on pdf
		FFA.new_window do
			page.has_text?(invoice_label)
			expect(page).to have_content(document_number_inv)
			gen_report_test "Expected: PDF report for created invoice is successfully generated."
			expect(page).to have_content($bd_product_a4_paper)
			gen_report_test "Expected: Line details to be displayed in PDF."
			expect(page).to have_content(invoice_document_total)
			gen_report_test "Expected: Amount to be displayed in PDF."
		end
		gen_end_test "TID021837:TST038983 - Verify User can print billing document of invoice type exposed in community."
	
		gen_start_test "TID021837:TST038984 - Verify User can print billing document of credit note type exposed in community."
		#Credit Note
		MYACCOUNT.select_payment_status $bd_document_payment_status_unpaid
		MYACCOUNT.select_billing_document_type billing_document_type_credit_notes
		MYACCOUNT.set_document_number_from document_number_crn
		MYACCOUNT.set_document_number_to document_number_crn
		MYACCOUNT.set_date_range_from date_today
		MYACCOUNT.set_date_range_to date_today
		MYACCOUNT.click_apply_filter
		
		# click on print button
		MYACCOUNT.click_print_pdf document_number_crn
		#Verify the details on pdf
		FFA.new_window do
			page.has_text?(credit_note_label)
			expect(page).to have_content(document_number_crn)
			gen_report_test "Expected: PDF report for created credit note is successfully generated."
			expect(page).to have_content($bd_product_a4_paper)
			gen_report_test "Expected: Line details to be displayed in PDF."
			expect(page).to have_content(crn_document_total)
			gen_report_test "Expected: Amount to be displayed in PDF."
		end
		gen_end_test "TID021837:TST038984 - Verify User can print billing document of credit note type exposed in community."
	end

	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID021760	 : Verify that user is able to view Billing Documents that are exposed in FF Communities."
		SF.logout
	end

	def login_in_as_community_user
		#Navigate to contact tab to login to community as user.
		SF.tab $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		SF.click_button_go
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		Contacts.open_contact_detail_page full_name
		Contacts.manage_external_user $contacts_login_to_community_as_user
		page.has_text?($tab_community_myaccounts)
	end
end
