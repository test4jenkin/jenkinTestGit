#--------------------------------------------------------------------#
# TID : TID018079
# Pre-Requisit: Org with basedata deployed and smoke base data scripts executed.
# Product Area: Mass Email.
# Story: AC-2294
#--------------------------------------------------------------------#

describe "Smoke test:Merlin Auto USA-Mass Email", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		FFA.hold_base_data_and_wait	
		gen_start_test "TID018079"
	end
	_line1 =1
	_line1_quantity_1 =1
	_line1_amount_100 =100
	_sin_selection_definition_name = "SINV"
	_scrn_selection_definition_name = "SCRN"
	_finance_correspondence_contact = "Smoke Test"
	_mail_subject_for_invoice = "Merlin Auto USA Invoice: "
	_mail_subject_for_credit_note = "Merlin Auto USA Credit Note: "
	_mail_content_for_invoice = "Please find attached invoice number #{$sf_param_substitute} Thank you for using FinancialForce Accounting. Created by FinancialForce.com http://www.FinancialForce.com/"
	_mail_content_for_credit_note = "Please find attached credit note number #{$sf_param_substitute} Thank you for using FinancialForce Accounting. Created by FinancialForce.com http://www.FinancialForce.com/"
	
	it "TID018079- Mass email for sales invoice and sales credit note."  do
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_usa] ,true	
		puts "TST027752:1.1- Create a new contact."	
		begin
			SF.tab $tab_contacts
			SF.click_button_new
			Contacts.set_frist_name "Smoke"
			Contacts.set_last_name "Test"
			Contacts.set_email $bd_mail_id_ffa_autotest_user
			Contacts.save
			page.has_text?($bd_mail_id_ffa_autotest_user)
			gen_compare "Smoke Test" , Contacts.get_contact_name , "Expected COntact-Smoke Test to be created successfully."
		end
		puts "TST027752:1.1- update #{$bd_account_algernon_partners_co} finance correspondence details."	
		begin
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			SF.listview_filter_result_by_alphabet "A"
			page.has_text?($bd_account_algernon_partners_co)
			SF.click_link $bd_account_algernon_partners_co
			page.has_button?($sf_edit_button)
			SF.click_button_edit
			SF.wait_for_search_button
			Account.set_finance_correspondence_email $bd_mail_id_ffa_autotest_user
			Account.set_finance_correspondence_contact _finance_correspondence_contact			
			SF.click_button_save
			gen_compare (Account.verify_detail_content $bd_mail_id_ffa_autotest_user), true, "Email for finance correspondence updated successfully."
			gen_compare (Account.verify_detail_content _finance_correspondence_contact)	, true, "Contact Info for finance correspondence updated successfully."
		end
		puts "TST027752:1.3: creating new selection definition for sales invoice and sales credit note."
		begin
			SF.tab $tab_selection_definitions
			SF.click_button_new
			SELDEF.set_selection_definition_name _sin_selection_definition_name
			SELDEF.select_master_object $ffa_object_sales_invoice
			SELDEF.select_detail_object $ffa_object_sales_invoice_installment_line_item
			SF.click_button_save
			page.has_text?(_sin_selection_definition_name)
			gen_compare _sin_selection_definition_name, SELDEF.get_selection_definition_name , "Expected selection definition name to be #{_sin_selection_definition_name}"
			SF.tab $tab_selection_definitions
			SF.click_button_new
			SELDEF.set_selection_definition_name _scrn_selection_definition_name
			SELDEF.select_master_object $ffa_object_sales_credit_note
			SELDEF.select_detail_object $ffa_object_sales_credit_note_line_item
			SF.click_button_save
			page.has_text?(_scrn_selection_definition_name)
			gen_compare _scrn_selection_definition_name, SELDEF.get_selection_definition_name , "Expected selection definition name to be #{_scrn_selection_definition_name}"
			
		end
		puts "TST027752:1.4,5- creating new sales invoice and sales credit note."
		begin
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_algernon_partners_co
			SIN.add_line _line1 , $bd_product_champagne , _line1_quantity_1, _line1_amount_100 , nil , nil , nil
			FFA.click_save_post
			page.has_text?($bd_document_status_complete)
			gen_compare $bd_document_status_complete , SIN.get_status ,"Expected SIN status to be complete."
			sin_number = SIN.get_invoice_number
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCR.set_account $bd_account_algernon_partners_co
			SCR.add_line _line1 , $bd_product_champagne , _line1_quantity_1 , _line1_amount_100 , nil , nil 	
			FFA.click_save_post
			page.has_text?($bd_document_status_complete)
			credit_note_number = SCR.get_credit_note_number
			gen_compare $bd_document_status_complete , SCR.get_credit_note_status ,"Expected SCR status to be complete."
		end
		
		puts "TST027752:1.6- Sales Invoice Email"
		begin
			SF.tab $tab_mass_email
			ME.set_selection_definition_name _sin_selection_definition_name
			ME.select_email_template $bd_mass_email_sales_invoice_standard_template
			ME.click_send_button
			gen_compare $ffa_msg_mass_email_sending_information, FFA.ffa_get_info_message,"Expected a confirmation message for sending an email."
			SF.wait_for_apex_job
			# check email 
			_mail_content_for_invoice = _mail_content_for_invoice.sub($sf_param_substitute,sin_number)
			mail_subject = _mail_subject_for_invoice +sin_number
			mass_email_content = Mailinator.get_mail_content  $bd_mail_id_ffa_autotest_user ,mail_subject  , true
			if mass_email_content.include?(_mail_content_for_invoice)
				gen_report_test "Mass Email content are verified successfully for sales invoice."
			else
				gen_report_test "WARNING: MAIL not delivered successfully at mailinator. Expected: #{_mail_content_for_invoice} and Actual: #{mass_email_content}"
			end
		end
		
		puts "TST027752:1.7-Sales credit note Email"
		begin
			SF.tab $tab_mass_email
			ME.set_selection_definition_name _scrn_selection_definition_name
			ME.select_email_template $bd_mass_email_sales_credit_note_standard_template
			ME.click_send_button
			gen_compare $ffa_msg_mass_email_sending_information, FFA.ffa_get_info_message,"Expected a confirmation message for sending an email."
			SF.wait_for_apex_job
			# check email
			_mail_content_for_credit_note = _mail_content_for_credit_note.sub($sf_param_substitute,credit_note_number)
			mail_subject = _mail_subject_for_credit_note +credit_note_number
			mass_email_content = Mailinator.get_mail_content  $bd_mail_id_ffa_autotest_user ,mail_subject  , true
			if mass_email_content.include?(_mail_content_for_credit_note)
				gen_report_test "Mass Email content are verified successfully for sales credit note."
			else
				gen_report_test "WARNING: MAIL not delivered successfully at mailinator.Expected: #{_mail_content_for_credit_note} and Actual: #{mass_email_content}"
			end
		end
	end
	
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID018057:Transaction Reconciliation Smoke Test"
		SF.logout
	end
end
