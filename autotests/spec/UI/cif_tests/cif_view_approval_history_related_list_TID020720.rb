#--------------------------------------------------------------------------------------------#
#	TID :TID020720
# 	Pre-Requisite: Org with basedata deployed.
#   			   Username and Password for Invoicing clerk apart from System Admin
#  	Product Area: Accounting - CIF
# 	How to run : rspec spec/UI/cif_tests/cif_view_approval_history_related_list_TID020720.rb -fh -o cif_view_approval_history_related_list_TID020720.html
#--------------------------------------------------------------------------------------------#
describe "TID020720: Verify the approval history related list on Sales Invoice", :type => :request do
	include_context "login"	
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		begin
			#Data Setup 1
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_gb] ,true

	        #Data Setup 2
	        #Update Manager Field of "Invoicing Clerk" to automatically assign for Approval
			_command_to_execute_update_user = ""
			_command_to_execute_update_user +="User user1 = [SELECT Id, ManagerId FROM User where Username = '#{SFINVCLERK_USER}'] [0];"
			_command_to_execute_update_user +="user1.ManagerId = UserInfo.getUserId();"
			_command_to_execute_update_user +="update user1;"
			APEX.execute_commands [_command_to_execute_update_user]
		end
	end
	
	it "TST034635 CIF | Verify that status of record on Approval History Related List when Admin Approves it" do				
		gen_start_test "TST034635 CIF | Verify that status of record on Approval History Related List when Admin Approves it"
		begin
			SF.login_as_user SFINVCLERK_USER
			# Create a Sales Invoice
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_gb] ,true
			SF.tab $tab_sales_invoices
			SF.click_button_new
			gen_wait_until_object $cif_sales_invoice_account 
			CIF_SINV.set_sinv_account $bd_account_bolinger
			CIF_SINV.set_sinv_invoice_description "Approval Process Testing in CIF"
			
			#Add line items 
			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_champagne
			CIF.click_toggle_button
			CIF_SINV.click_sinv_save_button
			SF.wait_for_search_button
			gen_wait_until_object $cif_edit_record_button
			#Asserting Related List
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_approval_history, true, "Related List item Approval History is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			
			#Submit for Approval by Invoicing Clerk
			CIF.click_related_list_submit_for_approval_button
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_related_list_approval_record_status
			gen_compare $cif_related_list_approval_history_status_pending, _record_status, 'Status should be Pending'
			_sales_invoice_number = CIF.get_document_number_from_header
			SF.logout

			#Login back with admin to approve the record
			login_user
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			#Approving Request
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			CIF.click_related_list_approve_or_reject_link
			CIF.click_approval_history_action_button $cif_related_list_approval_history_action_approve, 'Record Approved by Admin'

			#Assert Status with Invoicing Clerk
			SF.login_as_user SFINVCLERK_USER 
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_related_list_approval_record_status
			gen_compare $cif_related_list_approval_history_status_approved, _record_status, 'Status should be Approved'
		end
		gen_end_test "TST034635 CIF | Verify that status of record on Approval History Related List when Admin Approves it"
	end

	it "TST034636 CIF | Verify that status of record on Approval History Related List when Admin Rejects it" do				
		gen_start_test "TST034636 CIF | Verify that status of record on Approval History Related List when Admin Rejects it"
		begin
			login_user
			SF.login_as_user SFINVCLERK_USER 
			# Create a Sales Invoice
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_gb] ,true
			SF.tab $tab_sales_invoices
			SF.click_button_new
			gen_wait_until_object $cif_sales_invoice_account 
			CIF_SINV.set_sinv_account $bd_account_bolinger
			CIF_SINV.set_sinv_invoice_description "Approval Process Testing in CIF"
			
			#Add line items 
			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_champagne
			CIF_SINV.click_sinv_save_button
			SF.wait_for_search_button
			gen_wait_until_object $cif_edit_record_button
			#Asserting Related List
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_approval_history, true, "Related List item Approval History is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history

			#Submit for Approval by Invoicing Clerk
			CIF.click_related_list_submit_for_approval_button
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_related_list_approval_record_status
			gen_compare $cif_related_list_approval_history_status_pending, _record_status, 'Status should be Pending'
			_sales_invoice_number = CIF.get_document_number_from_header
			SF.logout

			#Login back with admin to approve the record
			login_user
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			#Rejecting Approval Request
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			CIF.click_related_list_approve_or_reject_link
			CIF.click_approval_history_action_button $cif_related_list_approval_history_action_reject, 'Record Rejected by Admin'
			
			#Assert Status with Invoicing Clerk
			SF.login_as_user SFINVCLERK_USER
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			#Posting the sales invoice
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_related_list_approval_record_status
			gen_compare $cif_related_list_approval_history_status_rejected, _record_status, 'Status should be Rejected'
		end
		gen_end_test "TST034636 CIF | Verify that status of record on Approval History Related List when user Rejects it"
	end
	
	it "TST034637 CIF | Verify that status of record on Approval History Related List when Admin Recalls it" do				
		gen_start_test "TST034637 CIF | Verify that status of record on Approval History Related List when Admin Recalls it"
		begin
			login_user
			SF.login_as_user SFINVCLERK_USER
			# Create a Sales Invoice
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_gb] ,true
			SF.tab $tab_sales_invoices
			SF.click_button_new
			gen_wait_until_object $cif_sales_invoice_account 
			CIF_SINV.set_sinv_account $bd_account_bolinger
			CIF_SINV.set_sinv_invoice_description "Approval Process Testing in CIF"
			
			#Add line items 
			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_champagne
			CIF_SINV.click_sinv_save_button
			SF.wait_for_search_button
			gen_wait_until_object $cif_edit_record_button
			#Asserting Related Lists
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_approval_history, true, "Related List item Approval History is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history

			#Submit for Approval and then recall it for Invoicing Clerk
			CIF.click_related_list_submit_for_approval_button
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_related_list_approval_record_status
			gen_compare $cif_related_list_approval_history_status_pending, _record_status, 'Status should be Pending'
			CIF.click_related_list_recall_approval_request_button
			CIF.click_approval_history_action_button $cif_related_list_approval_history_action_recall_request, 'Record is recalled'
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_related_list_approval_record_status
			gen_compare $cif_related_list_approval_history_status_recalled, _record_status, 'Status should be Recalled'
		end
		gen_end_test "TST034637 CIF | Verify that status of record on Approval History Related List when Admin Recalls it"
	end

	it "TST034675 CIF | Verify that status of record on Approval History Related List when Admin Reassigns it back to Invoicing Clerk" do				
		gen_start_test "TST034675 CIF | Verify that status of record on Approval History Related List when Admin Reassigns it back to Invoicing Clerk"
		begin
			login_user
			SF.login_as_user SFINVCLERK_USER 
			# Create a Sales Invoice
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_gb] ,true
			SF.tab $tab_sales_invoices
			SF.click_button_new
			gen_wait_until_object $cif_sales_invoice_account 
			CIF_SINV.set_sinv_account $bd_account_bolinger
			CIF_SINV.set_sinv_invoice_description "Approval Process Testing in CIF"
			
			#Add line items 
			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_champagne
			CIF_SINV.click_sinv_save_button
			SF.wait_for_search_button
			gen_wait_until_object $cif_edit_record_button
			#Asserting Related Lists
			gen_compare_has_css_with_text $cif_related_list_toolbar, $cif_related_list_toolbar_label_approval_history, true, "Related List item Approval History is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history

			#Submit for Approval by Invoicing Clerk
			CIF.click_related_list_submit_for_approval_button
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_related_list_approval_record_status
			gen_compare $cif_related_list_approval_history_status_pending, _record_status, 'Status should be Pending'
			_sales_invoice_number = CIF.get_document_number_from_header
			SF.logout

			#Login back with admin to reassign the record
			login_user
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number

			#Reassigning and cancel
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			CIF.click_related_list_reassign_link
			SF.click_button_cancel

			#Reassigning again
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			CIF.click_related_list_reassign_link
			CIF.click_approval_history_reassign_the_approval_request_button "Invoicing"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_approval_history
			_record_status = CIF.get_approval_related_list_reassign_status
			gen_compare $cif_related_list_approval_history_status_reassigned, _record_status, 'Status should be Reassigned'
		end
		gen_end_test "TST034675 CIF | Verify that status of record on Approval History Related List when Admin Reassigns it back to Invoicing Clerk"
	end
	after :all do
		login_user
		_command_to_execute_update_user = ""
		_command_to_execute_update_user +="User user1 = [SELECT Id, ManagerId FROM User where Name = 'Invoicing Clerk'] [0];"
		_command_to_execute_update_user +="user1.ManagerId = null;"
		_command_to_execute_update_user +="update user1;"
		APEX.execute_commands [_command_to_execute_update_user]
		FFA.delete_new_data_and_wait
		SF.logout
        gen_end_test "TID020720: Verify the approval history related list on Sales Invoice"    
	end
end
