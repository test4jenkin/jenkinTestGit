#--------------------------------------------------------------------------------------------#
#	TID :TID018092
# 	Pre-Requisit: Org with basedata deployed.
#  	Product Area: Accounting - Sales Invoices & Credit Notes
# 	Story: AC-2944
#--------------------------------------------------------------------------------------------#
describe "Smoke Test:Create documents on CIF UI and Post ", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	_sin_scr_layout_changed_to_cif_page=false
	_pin_pcr_layout_changed_to_cif_page=false
	_cash_entry_layout_changed_to_cif_page=false
	_journal_layout_changed_to_cif_page=false
	_link_term_of_use = "Terms of use"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		
		#Update Accounts Payable Control for Bolinger Account and Update Purchase Analysis Account for Champagne
		_command_to_execute_update_account= ""
		_command_to_execute_update_account +=" Account  acc = [SELECT Id, "+ORG_PREFIX+"CODAAccountsPayableControl__c FROM Account where MirrorName__c='Bolinger'];"
		_command_to_execute_update_account +=""+ORG_PREFIX+"codaGeneralLedgerAccount__c gla =[select id from "+ORG_PREFIX+"codaGeneralLedgerAccount__c where name ='Accounts Payable Control - EUR'] ;"
		_command_to_execute_update_account +=" acc."+ORG_PREFIX+"CODAAccountsPayableControl__c= gla.id;"
		_command_to_execute_update_account +=" update acc;"
		
		_command_to_execute_update_product= ""
		_command_to_execute_update_product +=" Product2 prod = [SELECT Id, Name, "+ORG_PREFIX+"CODAPurchaseAnalysisAccount__c FROM Product2 where name='Champagne'];"
		_command_to_execute_update_product +=""+ORG_PREFIX+"codaGeneralLedgerAccount__c gla = [select id from "+ORG_PREFIX+"codaGeneralLedgerAccount__c where name ='Sales - Parts'];"
		_command_to_execute_update_product +=" prod."+ORG_PREFIX+"CODAPurchaseAnalysisAccount__c = gla.id;"
		_command_to_execute_update_product +=" update prod;"		
		#Execute commands for Account and Product update
		APEX.execute_commands [_command_to_execute_update_account, _command_to_execute_update_product]
		
		begin
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_gb] ,true
		end
	end
	
	it "TID018092 - TST027800 - CIF | Verify post operation and transaction details of sales invoice and sales credit note" do				
		gen_start_test "TST027800 - CIF | Verify post operation and transaction details of sales invoice and sales credit note"
		
		_file_to_attach = "SmokeTestStatement.CSV"
		_note_message ="Note cif invoice"
		_chatter_message = "Sales invoice chat"
		_event_message = "Meeting"
		_task_email  = "Email"
		begin
			_sin_scr_layout_changed_to_cif_page = true
			# Setting page layout to custom Sales Invoice  layout(Sencha)
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_edit		
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_new				
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_invoice_view							
			# Setting page layout to custom Sales credit note  layout(Sencha)
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_credit_note_edit				
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_credit_note_new				
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_credit_note_view	
		
			# Pre-Requisite step for Sales Invoice and Sale Credit Note
			SF.tab $tab_input_form_manager
			CIF_IFM.create_new_form_type $cif_ifm_document_type_sales_invoice, $cif_ifm_form_type_input
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.verify_save_success 'SIN-Input'
			CIF_IFM.create_new_form_type $cif_ifm_document_type_sales_invoice, $cif_ifm_form_type_view
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
					
			# Add and Edited Related list
			# Select sales invoice related lists
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_history_sales_invoice,$cif_related_list_toolbar_label_notes,$cif_related_list_toolbar_label_tasks]
			CIF_IFM.click_ok_button_on_related_list
			CIF_IFM.set_form_name 'SIN-View'
			CIF_IFM.click_save_button
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

			SF.tab $tab_input_form_manager
			CIF_IFM.create_new_form_type $cif_ifm_document_type_sales_credit_note, $cif_ifm_form_type_input
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.verify_save_success 'SCR-Input'
			CIF_IFM.create_new_form_type $cif_ifm_document_type_sales_credit_note, $cif_ifm_form_type_view
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_history_sales_credit_note,$cif_related_list_toolbar_label_notes,$cif_related_list_toolbar_label_tasks]
			CIF_IFM.click_ok_button_on_related_list

			CIF_IFM.set_form_name 'SCR-View'
			CIF_IFM.click_save_button
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			SF.tab $tab_input_form_manager
			# Activate form layout
			CIF_IFM.select_and_activate_form 'SIN-Input', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'SIN-Input'

			CIF_IFM.select_and_activate_form 'SIN-View', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'SIN-View'
			CIF_IFM.select_and_activate_form 'SCR-Input', $company_merlin_auto_gb
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.select_input_form_manager_from_list 'SCR-Input'

			CIF_IFM.select_and_activate_form 'SCR-View', $company_merlin_auto_gb
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.select_input_form_manager_from_list 'SCR-View'
			
			#Pre-requisite - Enable chatter feed for Sales invoice
			SF.set_feed_tracking $ffa_feedtracking_object_sales_invoice , "true"
			
			# step 1.1
			SF.tab $tab_sales_invoices
			SF.click_button_new
			gen_wait_until_object $cif_sales_invoice_account 
			CIF_SINV.set_sinv_account $bd_account_bolinger			
			#add line items 
			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_champagne		
			CIF_SINV.set_sinv_line_quantity 1
			CIF_SINV.set_sinv_line_unit_price "50"
			CIF_SINV.set_sinv_line_dimesion_1 $bdu_dim1_gbp
			CIF_SINV.set_sinv_line_dimesion_2 $bdu_dim2_gbp
			CIF_SINV.set_sinv_line_tax_code $bdu_tax_code_vo_s
			CIF.click_toggle_button
			CIF_SINV.click_sinv_save_button
			gen_wait_until_object $cif_post_button
			SF.wait_for_search_button
			_sales_invoice_number = CIF.get_document_number_from_header	
			begin
			    gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
				gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_events, true, "Related List item Events is displayed"
				gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_sales_invoice, true, "Related List item History: Sales Invoice is displayed"
				gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
				gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_tasks, true, "Related List item Tasks is displayed"
				gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
				gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
				gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_chatter, true, "Related List item Chatter is displayed"
				
				# Events creation				
				CIF.click_related_list_toolbar_item $cif_related_list_toolbar_events
				CIF_SINV.create_new_event _event_message
				
				#Tasks creation
				CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_tasks
				CIF_SINV.create_new_task _task_email
				
				#Note creation
				CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
				CIF_SINV.create_new_note _note_message			
				
				# Chatter creation
				CIF.click_related_list_toolbar_item $cif_related_list_toolbar_chatter			
				CIF_SINV.create_new_chat_message _chatter_message
				CIF.click_to_collapse_related_list_toolbar_view
				
				#Attachment
				CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments			
				CIF_SINV.attach_file_in_related_list_toolbar _file_to_attach
				CIF.click_to_collapse_related_list_toolbar_view
			end
			CIF.click_back_to_list_button
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			#Posting the sales invoice
			gen_wait_until_object $cif_post_button
			CIF_SINV.click_sinv_post_button
			#Validate related list toolbar items
			gen_wait_until_object $cif_amend_button
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 attachment record"
		
			CIF.click_related_list_toolbar_item $cif_related_list_toolbar_events
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 Event record"
		
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_tasks
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 Task record"
		
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 Notes record"
		
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_history_sales_invoice
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 History: Sales Invoice record"
		
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_groups
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Groups record"
			CIF.click_to_collapse_related_list_toolbar_view
			CIF.click_back_to_list_button
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			
			CIF.click_transaction_link
			gen_compare "57.50", TRANX.get_account_total, "Expected account total to be 57.50"
			gen_compare "57.50", TRANX.get_document_total, "Expected document total to be 57.50"
			gen_compare "57.50", TRANX.get_account_outstanding_total, "Expected account outstanding total to be 57.50"
			gen_compare "57.50", TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be 57.50"			
			gen_compare "-57.50", TRANX.get_dual_credits, "Expected dual credits to be -57.50"			
			
			# Step 1.2
			SF.tab $tab_sales_invoices
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			SF.wait_for_search_button
			CIF.click_convert_to_credit_note_button
			SF.wait_for_search_button
			page.has_link?(_link_term_of_use)
			_sales_credit_notes_number = CIF.get_document_number_from_header
			CIF.click_edit_button
			CIF_SCN.set_scn_line_unit_price "10"
			CIF_SCN.click_post_match_button
			SF.wait_for_search_button

			# Validation of related list
		    gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_events, true, "Related List item Events is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_sales_credit_note, true, "Related List item History: Sales Credit Note is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_tasks, true, "Related List item Tasks is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
			
			#Validate related list toolbar items
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 attachment record"
			CIF.click_related_list_toolbar_item $cif_related_list_toolbar_events
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Event record"

			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_tasks
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Task record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Notes record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_history_sales_credit_note
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 History: Sales Credit Note record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_groups
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Groups record"
			CIF.click_to_collapse_related_list_toolbar_view

			gen_compare $bd_document_status_complete,  CIF_SCN.get_crn_document_status, "Expected CRN should be with Complete status"		
			gen_compare $bd_document_payment_status_paid,  CIF_SCN.get_crn_payment_status, "Expected CRN payment status to be Paid status"			
			# Verify values in the transaction			
			_credit_note_transaction = find($cif_transaction_number).text
			CIF.click_transaction_link
			gen_compare "-11.50",  TRANX.get_account_total, "Expected account total to be -11.50"
			gen_compare "-11.50",  TRANX.get_document_total, "Expected document total to be -11.50"
			gen_compare "0.00",  TRANX.get_account_outstanding_total, "Expected account outstanding total to be 0.00"
			gen_compare "0.00",  TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be 0.00"
			gen_compare "-11.50",  TRANX.get_dual_credits, "Expected dual credits to be -11.50"
		end
		gen_end_test "TST027800 - CIF | Verify post operation and transaction details of sales invoice and sales credit note"
	end
	
	it "TID018092 - TST027801 - CIF| Verify post operation and transaction details of payable invoice and payable credit notes." do
	
		gen_start_test "TST027801 - CIF| Verify post operation and transaction details of payable invoice and payable credit notes."
		login_user
		begin
			_pin_pcr_layout_changed_to_cif_page = true
			# Setting page layout to custom purchase Invoice  layout(Sencha)
			SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_edit			
			SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_new				
			SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_payable_invoice_view			
			# Setting page layout to custom payable credit note layout(Sencha)
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_edit				
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_new				
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_purchase_credit_note_view
			
			#Pre-Requisite step for Payable Invoice and Payable Credit Note
			SF.tab $tab_input_form_manager
			CIF_IFM.create_new_form_type $cif_ifm_document_type_payable_invoice, $cif_ifm_form_type_input
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.verify_save_success 'PIN-Input'
			CIF_IFM.create_new_form_type $cif_ifm_document_type_payable_invoice, $cif_ifm_form_type_view
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			# Add related list
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_history_payable_invoice,$cif_related_list_toolbar_label_notes,$cif_related_list_toolbar_label_tasks]
			CIF_IFM.click_ok_button_on_related_list
			CIF_IFM.set_form_name 'PIN-View'
			CIF_IFM.click_save_button
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.create_new_form_type $cif_ifm_document_type_payable_credit_note, $cif_ifm_form_type_input
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.verify_save_success 'PCR-Input'
			
			CIF_IFM.create_new_form_type $cif_ifm_document_type_payable_credit_note, $cif_ifm_form_type_view
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_history_payable_credit_note,$cif_related_list_toolbar_label_notes,$cif_related_list_toolbar_label_tasks]
			CIF_IFM.click_ok_button_on_related_list

			CIF_IFM.set_form_name 'PCR-View'
			CIF_IFM.click_save_button
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			# Activate the Input form
			SF.tab $tab_input_form_manager
			# Activate form layout
			CIF_IFM.select_and_activate_form 'PIN-Input', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'PIN-Input'

			CIF_IFM.select_and_activate_form 'PIN-View', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'PIN-View'
			
			# Activate form layout
			CIF_IFM.select_and_activate_form 'PCR-Input', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'PCR-Input'

			CIF_IFM.select_and_activate_form 'PCR-View', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'PCR-View'
			
			# step 1.1
			SF.tab $tab_payable_invoices
			SF.click_button_new
			CIF_PINV.set_pinv_account $bd_account_bolinger			
			CIF_PINV.set_pinv_vendor_invoice_number "PIN_12"			
			CIF_PINV.click_payable_invoice_line_items_tab
			#add line items 
			CIF_PINV.click_new_row			
			CIF_PINV.set_pinv_line_product $bd_product_champagne
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_quantity_column_number
			CIF_PINV.set_pinv_line_quantity 1
			CIF_PINV.set_pinv_line_unit_price "50"
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_dimension1_column_number
			CIF_PINV.set_pinv_line_dimesion_1 $bdu_dim1_gbp
			CIF_PINV.set_pinv_line_dimesion_2 $bdu_dim2_gbp
			CIF_PINV.click_column_grid_data_row 1, $cif_payable_invoice_line_item_input_tax_code_column_number
			CIF_PINV.set_pinv_line_input_tax_code $bd_tax_code_vi_s			
			CIF.click_toggle_button
			CIF_PINV.click_pinv_save_post_button
			SF.wait_for_search_button
			page.has_css?($cif_header_document_number)
			
			
			# Validation of related list
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_events, true, "Related List item Events is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_payable_invoice, true, "Related List item History: Payable Invoice is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_tasks, true, "Related List item Tasks is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
			
			# #Validate related list toolbar items
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 attachment record"					
			CIF.click_related_list_toolbar_item $cif_related_list_toolbar_events
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Event record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_tasks
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Task record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Notes record"
			
			CIF.click_related_list_toolbar_item $cif_related_list_toolbar_label_history_payable_invoice
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 History: Payable Invoice record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_groups
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Groups record"
			CIF.click_to_collapse_related_list_toolbar_view
			
			# Verify values in the transaction
			_payable_invoice_number = CIF.get_document_number_from_header			
			CIF.click_transaction_link
			gen_compare "-57.50",  TRANX.get_account_total, "Expected account total to be -57.50"
			gen_compare "-57.50",  TRANX.get_document_total, "Expected document total to be -57.50"
			gen_compare "-57.50",  TRANX.get_account_outstanding_total, "Expected account outstanding total to be -57.50"
			gen_compare "-57.50",  TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be -57.50"
			gen_compare "-57.50",  TRANX.get_dual_credits, "Expected dual credits to be -57.50"	
			gen_compare "47.92",  TRANX.get_home_debits, "Expected dual credits to be 47.92"	
			gen_compare "57.50",  TRANX.get_dual_debits, "Expected dual credits to be 57.50"	
			
			SF.tab $tab_payable_invoices
			SF.click_button_go
			PIN.open_invoice_detail_page _payable_invoice_number
			CIF.click_convert_to_credit_note_button
			PCR.set_vendor_credit_note_number_convert "PCN_12"
			SF.click_button $sin_convert_to_credit_note_button
			gen_wait_until_object $cif_edit_record_button			
			CIF.click_edit_button
			CIF_PCN.click_payable_credit_note_line_items_tab
			CIF_PCN.set_PCN_line_unit_price "10"
			CIF_PCN.click_post_match_button
			CIF.click_continue_button
			SF.wait_for_search_button
			
			# Validation of related list
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_events, true, "Related List item Events is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_payable_credit_note, true, "Related List item History: Payable Credit Note is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_tasks, true, "Related List item Tasks is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
			
			#Validate related list toolbar items
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 attachment record"
			CIF.click_related_list_toolbar_item $cif_related_list_toolbar_events
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Event record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_tasks
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Task record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Notes record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_history_payable_credit_note
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 History: payable credit note record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_groups
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Groups record"
			CIF.click_to_collapse_related_list_toolbar_view
			
			gen_compare $bd_document_status_complete,  CIF_PCN.get_payable_credit_note_status, "Expected CRN should be with Complete status"
			CIF.click_transaction_link
			gen_compare "9.58",  TRANX.get_home_debits, "Expected home debits to be 9.58"	
			gen_compare "0.00",  TRANX.get_home_value_total, "Expected home value to be 0.00"	
			gen_compare "11.50",  TRANX.get_dual_debits, "Expected dual debits to be 11.50"	
			gen_compare "-11.50",  TRANX.get_dual_credits, "Expected dual credits to be  -11.50"	
			gen_compare "11.50",  TRANX.get_account_total, "Expected account total to be 11.50"
			gen_compare "11.50",  TRANX.get_document_total, "Expected document total to be 11.50"
			gen_compare "0.00",  TRANX.get_account_outstanding_total, "Expected account outstanding total to be 0.00"
			gen_compare "0.00",  TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be 0.00"			
		end
		gen_end_test "TST027801 - CIF| Verify post operation and transaction details of payable invoice and payable credit notes."
	end

	it "TID018092 - TST027802 - CIF| Verify post operation and transaction details for cash entry" do
	
		gen_start_test "TST027802 - CIF| Verify post operation and transaction details for cash entry"
		login_user
		begin
			_cash_entry_layout_changed_to_cif_page = true
			# Setting page layout to custom Cash Entry layout(Sencha)
			SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_edit	
			SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_new	
			SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_cash_entry_view
			
			#Pre-Requisite step for Cash Entry
			SF.tab $tab_input_form_manager
			CIF_IFM.create_new_form_type $cif_ifm_document_type_cash_entry, $cif_ifm_form_type_input
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.verify_save_success 'CSE-Input'
			CIF_IFM.create_new_form_type $cif_ifm_document_type_cash_entry, $cif_ifm_form_type_view
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			# Add related list
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_history_cash_entry,$cif_related_list_toolbar_label_notes]
			CIF_IFM.click_ok_button_on_related_list
			CIF_IFM.set_form_name 'CSE-View'
			CIF_IFM.click_save_button
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			
			SF.tab $tab_input_form_manager
			# Activate form layout
			CIF_IFM.select_and_activate_form 'CSE-Input', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'CSE-Input'

			CIF_IFM.select_and_activate_form 'CSE-View', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'CSE-View'

			SF.tab $tab_cash_entries
			SF.click_button_new
			CIF_CE.set_ce_type $bd_cash_entry_receipt_type
			CIF_CE.set_ce_bank_account $bdu_bank_account_barclays_current_account		
			CIF_CE.set_ce_payment_method $bd_cash_entry_payment_method_cash
			CIF_CE.click_new_row
			CIF_CE.set_ce_account $bd_account_bolinger			
			CIF_CE.set_ce_cash_entry_value "100.00"
			CIF_CE.click_sinv_save_post_button
			SF.wait_for_search_button
			
			# Validation of related list
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_cash_entry, true, "Related List item History: Sales Invoice is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
			
			#Validate related list toolbar items
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 attachment record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Notes record"
			
			CIF.click_related_list_toolbar_item $cif_related_list_toolbar_label_history_cash_entry
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 History: Sales Invoice record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_groups
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Groups record"
			CIF.click_to_collapse_related_list_toolbar_view
			
			gen_compare $bd_document_status_complete,  CIF_CE.get_ce_document_status, "Expected Cash Entry should be with Complete status"
			# Verify values in the transaction			
			CIF.click_transaction_link
			gen_compare "-120.00",  TRANX.get_account_total, "Expected account total to be -120.00"
			gen_compare "-100.00",  TRANX.get_document_total, "Expected document total to be -100.00"
			gen_compare "-120.00",  TRANX.get_account_outstanding_total, "Expected account outstanding total to be -120.00"
			gen_compare "-100.00",  TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be -100.00"
			gen_compare "100.00",  TRANX.get_home_debits, "Expected dual credits to be 100.00"
			gen_compare "120.00",  TRANX.get_dual_debits, "Expected dual credits to be 120.00"
		end
		gen_end_test "TST027802 - CIF| Verify post operation and transaction details for cash entry"
	end
	
	it "TID018092 - TST027803 - CIF|Verify post operation and transaction details for journals" do
	
		gen_start_test "TST027803 - CIF|Verify post operation and transaction details for journals"
		login_user
		begin
			_journal_layout_changed_to_cif_page = true
			# Setting page layout to custom journal layout(Sencha)
			SF.object_button_edit $ffa_object_journal, $sf_edit_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_edit
			SF.object_button_edit $ffa_object_journal, $sf_new_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_new	
			SF.object_button_edit $ffa_object_journal, $sf_view_button
			CIF.select_vf_page_for_cif_layout $ffa_vf_page_coda_custom_journal_view	
			
			#Pre-Requisite step for Journal
			SF.tab $tab_input_form_manager
			CIF_IFM.create_new_form_type $cif_ifm_document_type_journal, $cif_ifm_form_type_input
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.verify_save_success 'JRNL-Input'
			CIF_IFM.create_new_form_type $cif_ifm_document_type_journal, $cif_ifm_form_type_view
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			 # Select sales invoice related lists
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_files,$cif_related_list_toolbar_label_groups,$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_history_journal,$cif_related_list_toolbar_label_notes]
			CIF_IFM.click_ok_button_on_related_list
			CIF_IFM.set_form_name 'JRNL-View'
			CIF_IFM.click_save_button
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			
			SF.tab $tab_input_form_manager

			# Activate form layout
			CIF_IFM.select_and_activate_form 'JRNL-Input', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'JRNL-Input'

			CIF_IFM.select_and_activate_form 'JRNL-View', $company_merlin_auto_gb
			CIF_IFM.select_input_form_manager_from_list 'JRNL-View'

			SF.tab $tab_journals
			SF.click_button_new			
			# Line 1
			CIF_JNL.click_toggle_button
			CIF.click_new_row
			CIF_JNL.set_line_type $bd_jnl_line_type_account_customer
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_write_off_uk
			CIF_JNL.set_account $bd_account_bolinger
			CIF_JNL.set_tax_value "10.00"
			CIF_JNL.set_value "100.00",1
			# Line 2
			CIF_JNL.set_line_type $bd_jnl_line_type_account_vendor,2
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_write_off_uk,2
			CIF_JNL.set_account $bd_account_bolinger,2
			CIF_JNL.set_tax_value "-5.00", 2
			CIF_JNL.set_value "-50.00" ,2
			# Line 3			
			CIF_JNL.set_line_type $bd_jnl_line_type_tax_code ,3
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_vat_output ,3
			CIF_JNL.set_tax_code $bd_tax_code_vo_s, 3
			CIF_JNL.set_taxable_value "-6.00", 3
			CIF_JNL.set_value "-50.00", 3
			# Line 4
			CIF_JNL.set_line_type $bd_jnl_line_type_product_sales, 4 
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_sales_parts,4
			CIF_JNL.set_product $bd_product_champagne, 4	
			CIF_JNL.set_tax_value "5.00",4
			CIF_JNL.set_value "100.00", 4	
			# Line 5			
			CIF_JNL.set_line_type $bd_jnl_line_type_product_sales, 5
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_sales_parts,5
			CIF_JNL.set_product $bd_product_champagne,5			
			CIF_JNL.set_tax_value "-5.00",5 
			CIF_JNL.set_value "-100.00", 5 					
			# Line 6			
			CIF_JNL.set_line_type $bd_jnl_line_type_bank_account,6
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_write_off_us,6
			CIF_JNL.set_bank_account $bdu_bank_account_barclays_current_account,6
			CIF_JNL.set_account_analysis_value $bd_account_bolinger,6
			CIF_JNL.set_value "100.00",6		
			# Line 7			
			CIF_JNL.set_line_type $bd_jnl_line_type_gla,7
			CIF_JNL.click_toggle_button
			CIF_JNL.set_gla $bd_gla_vat_input,7
			CIF_JNL.set_value "-100.00",7			
			CIF_JNL.click_toggle_button
			#click on save and post button
			CIF_JNL.click_journal_save_post_button
			SF.wait_for_search_button
			gen_wait_until_object $cif_transaction_number
			
			# Validation of related list
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_journal, true, "Related List item History: Journal is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_groups, true, "Related List item Groups is displayed"
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_files, true, "Related List item Files is displayed"
			
			#Validate related list toolbar items
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 attachment record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Notes record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_history_journal
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 History: Journal record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_groups
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Groups record"
			CIF.click_to_collapse_related_list_toolbar_view
			
			gen_compare $bd_document_status_complete,  CIF_JNL.get_journal_document_status, "Expected Journal should be with Complete status"
			CIF.click_transaction_link
			gen_compare "60.00",  TRANX.get_account_total, "Expected account total to be 60.00"
			gen_compare "50.00",  TRANX.get_document_total, "Expected document total to be 50.00"
			gen_compare "60.00",  TRANX.get_account_outstanding_total, "Expected account outstanding total to be 60.00"
			gen_compare "50.00",  TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be 50.00"
			gen_compare "300.00",  TRANX.get_home_debits, "Expected dual credits to be 300.00"
			gen_compare "-360.00",  TRANX.get_dual_credits, "Expected dual credits to be -360.00"
		end
		gen_end_test "TST027803 - CIF|Verify post operation and transaction details for journals"	
	end	
	
	after :all do
		#Delete Test Data
		login_user
		FFA.delete_new_data_and_wait			
		
		#Update Accounts Payable Control for Bolinger Account and Update Purchase Analysis Account for Champagne
		_command_to_execute_update_account= ""
		_command_to_execute_update_account +=" Account  acc = [SELECT Id, "+ORG_PREFIX+"CODAAccountsPayableControl__c FROM Account where MirrorName__c='Bolinger'];"
		_command_to_execute_update_account +=""+ORG_PREFIX+"codaGeneralLedgerAccount__c gla =[select id from "+ORG_PREFIX+"codaGeneralLedgerAccount__c where name ='Accounts Payable Control - EUR'] ;"
		_command_to_execute_update_account +=" acc."+ORG_PREFIX+"CODAAccountsPayableControl__c= null;"
		_command_to_execute_update_account +=" update acc;"
		
		_command_to_execute_update_product= ""
		_command_to_execute_update_product +=" Product2 prod = [SELECT Id, Name, "+ORG_PREFIX+"CODAPurchaseAnalysisAccount__c FROM Product2 where name='Champagne'];"
		_command_to_execute_update_product +=""+ORG_PREFIX+"codaGeneralLedgerAccount__c gla = [select id from "+ORG_PREFIX+"codaGeneralLedgerAccount__c where name ='Sales - Parts'];"
		_command_to_execute_update_product +=" prod."+ORG_PREFIX+"CODAPurchaseAnalysisAccount__c = null;"
		_command_to_execute_update_product +=" update prod;"
		#Execute commands for Account and Product revert back the changes
		APEX.execute_commands [_command_to_execute_update_account, _command_to_execute_update_product]

		begin				
			# Reverting back the changes of page button layout			
			if(_sin_scr_layout_changed_to_cif_page)
				# Setting page layout to VF sales Invoice  layout
				SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_edit			
				SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_new			
				SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_invoice_view
			
				# Setting page layout to VF sales credit note  layout
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_edit			
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_new			
				SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_creditnote_view
				
				# Disable chatter feed for Sales invoice
				
			end
			
			if(_pin_pcr_layout_changed_to_cif_page)
				# Setting page layout to VF purchase Invoice  layout
				SF.object_button_edit $ffa_object_payable_invoice, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_edit			
				SF.object_button_edit $ffa_object_payable_invoice, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_new			
				SF.object_button_edit $ffa_object_payable_invoice, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_purchase_invoice_view
				# Setting page layout to VF payable credit note  layout
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_edit			
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_new			
				SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_payable_credit_note_view
			end

			if(_cash_entry_layout_changed_to_cif_page)
				# Setting page layout to VF cash entry  layout
				SF.object_button_edit $ffa_object_cash_entry, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_edit			
				SF.object_button_edit $ffa_object_cash_entry, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_new			
				SF.object_button_edit $ffa_object_cash_entry, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_cashentry_view
			end
			
			if(_journal_layout_changed_to_cif_page)
				# Setting page layout to VF journal  layout
				SF.object_button_edit $ffa_object_journal, $sf_edit_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_edit			
				SF.object_button_edit $ffa_object_journal, $sf_new_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_new			
				SF.object_button_edit $ffa_object_journal, $sf_view_button
				SF.set_button_property_for_visualforce_page_layout $ffa_vf_page_coda_journal_view			
			end
			SF.set_feed_tracking $ffa_feedtracking_object_sales_invoice , "false"	
			gen_end_test "TID018092 : Smoke Test- Create all type of document on new CIF UI and post them and verify the details of posted documents."
			SF.logout 
		end
	end
end
