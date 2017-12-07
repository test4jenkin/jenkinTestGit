#--------------------------------------------------------------------------------------------#
#	TID :TID020295
# 	Pre-Requisite: Org with basedata deployed.
#  	Product Area: Accounting - CIF
# 	How to run : rspec spec/UI/cif_tests/cif_view_related_list_TID020295.rb -fh -o cif_view_related_list_TID020295.html
#--------------------------------------------------------------------------------------------#
describe "TID020295-Verify the related lists functionality on CIF Documents ", :type => :request do
	field_list = []
	include_context "login"
	include_context "logout_after_each"	
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		begin
			#Data Setup 1
			_assign_permission_to_custom_object = ["PermissionSet ps =[select id,ProfileId FROM PermissionSet where Name = 'Accounting'];FieldPermissions fp = new FieldPermissions();fp.SobjectType = 'codaSalesOrderCustomObject__c';fp.parentid = ps.id;fp.PermissionsRead = true;fp.PermissionsEdit = true;fp.field = 'codaSalesOrderCustomObject__c.SalesInvoiceNumber__c';insert fp;"]
			APEX.execute_commands _assign_permission_to_custom_object
			
			#Data Setup 2
			_layout_name = "Sales Order Custom Object Layout"
			_field_to_add = ["Sales Invoice Number"]
			_object_name = "Sales Order Custom Object"
			SF.edit_layout_add_field _object_name, _layout_name, $sf_layout_panel_fields, _field_to_add, $sf_edit_page_layout_target_position
			SF.wait_for_search_button
			
			#Data Setup 3
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_gb] ,true
		end
	end
	
	it "TID020295 CIF | Verify that user can add, delete and edit related lists on Input Form Manager", :unmanaged => true do				
		gen_start_test "TST033310 - CIF | Verify that user can add ,delete and edit related list on Input Form Manager"
		begin
			_input_form_name = "SINV View Form"
			#Pre-Requisite step for Sales Invoice
			SF.tab $tab_input_form_manager
			gen_wait_until_object $cif_ifm_new_button
			CIF_IFM.create_new_form_type $cif_ifm_document_type_sales_invoice, $cif_ifm_form_type_view
			CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			CIF_IFM.set_form_name _input_form_name

			#Select Existing Related List
			gen_start_test "TST033310 - a. Verify that user can add existing related list using Input Form Manager"
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_notes]
			CIF_IFM.click_ok_button_on_related_list
			list_result = CIF_IFM.verify_related_list_on_ifm_editor [$cif_related_list_toolbar_label_attachments,$cif_related_list_toolbar_label_events,$cif_related_list_toolbar_label_notes], true
			gen_compare true, list_result.empty?,'Expected Related List item Attachments,Events and Notes are displayed'
			CIF_IFM.click_save_button
        	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK
			gen_end_test "TST033310 - a. Verify that user can add existing related list using Input Form Manager"
			
			#Delete Related list
			gen_start_test "TST033310 - b.i) Verify that user cannot delete existing managed related list using Input Form Manager"
			CIF_IFM.select_and_edit_form _input_form_name
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.edit_or_delete_related_list $cif_related_list_action_delete,$cif_related_list_toolbar_label_events
			gen_compare $cif_msg_cannot_delete_related_list , CIF_IFM.get_message_on_delete_related_list_popup , "Warning message #{$cif_msg_cannot_delete_related_list} is displayed"
			CIF_IFM.close_delete_popup
			CIF_IFM.deselect_related_list_if_selected $cif_related_list_toolbar_label_events
			CIF_IFM.click_ok_button_on_related_list
			list_result = CIF_IFM.verify_related_list_on_ifm_editor [$cif_related_list_toolbar_label_events], false
			gen_compare true, list_result.empty?,'Expected Related List item Events is not displayed'
			gen_end_test "TST033310 - b i). Verify that user can delete related list using Input Form Manager"
			
			gen_start_test "TST033310 - b.ii) Verify that user can delete newly created related lists using Input Form Manager"
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.click_new_related_list_button_on_related_list
			CIF_IFM.set_label_on_related_list_configuration "Lookups"
			CIF_IFM.set_list_name_on_related_list_configuration "Lookups"
			field_list = ["Account","Accounting Currency"]
			CIF_IFM.move_fields_from_available_to_displayed false,field_list
			CIF_IFM.set_sort_field_on_related_list_configuration  "Record ID"
			CIF_IFM.click_ok_button_related_list_configuration_popup
			CIF_IFM.edit_or_delete_related_list $cif_related_list_action_delete,$cif_related_list_toolbar_label_lookups
			gen_compare $cif_msg_permanently_delete_related_list , CIF_IFM.get_message_on_delete_related_list_popup , "Warning message #{$cif_msg_permanently_delete_related_list} is displayed"
			CIF_IFM.click_delete_on_delete_related_list_popup
			CIF_IFM.click_ok_button_on_related_list
			list_result = CIF_IFM.verify_related_list_on_ifm_editor [$cif_related_list_toolbar_label_lookups], false
			gen_compare true, list_result.empty?,'Expected Related List item Lookups is not displayed'
			
			gen_end_test "TST033310 - b ii). Verify that user can delete newly created related lists using Input Form Manager"
			
			#Add New Related
			gen_start_test "TST033310 - c. Verify that user can add new related list(FFA and Custom) using Input Form Manager"
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.click_new_related_list_button_on_related_list
			CIF_IFM.set_label_on_related_list_configuration "Intercompany Transfers"
			CIF_IFM.set_list_name_on_related_list_configuration "Intercompany Transfers"
			field_list = ["Destination Company","Record ID"]
			CIF_IFM.move_fields_from_available_to_displayed false,field_list
			CIF_IFM.set_sort_field_on_related_list_configuration  "Record ID"
			CIF_IFM.click_ok_button_related_list_configuration_popup

			CIF_IFM.click_new_related_list_button_on_related_list
			CIF_IFM.set_label_on_related_list_configuration "Sales Order Custom Object"
			CIF_IFM.set_list_name_on_related_list_configuration "Sales Order Custom Object" 
			field_list = []
			CIF_IFM.move_fields_from_available_to_displayed  true,field_list
			field_list = ["Currency ISO Code","Created By ID"]
			CIF_IFM.move_fields_from_displayed_to_available  false,field_list
			CIF_IFM.set_sort_field_on_related_list_configuration  "Record ID"
			CIF_IFM.click_ok_button_related_list_configuration_popup
			CIF_IFM.click_ok_button_on_related_list
			list_result = CIF_IFM.verify_related_list_on_ifm_editor [$cif_related_list_toolbar_label_intercompany_transfers,$cif_related_list_toolbar_label_sales_order_custom_object], true
			gen_compare true, list_result.empty?,'Expected Related List items Intercompany Transfers and Sales Order Custom Object are displayed'
			gen_end_test "TST033310 - c. Verify that user can add new related list(FFA and Custom) using Input Form Manager"
						
			#Edit the existing Related List
			gen_start_test "TST033310 - d. Verify that user can edit related list using Input Form Manager"
			CIF_IFM.click_add_or_edit_related_list_button
			CIF_IFM.edit_or_delete_related_list $cif_related_list_action_edit,$cif_related_list_toolbar_label_history_sales_invoice
			field_list = []
			CIF_IFM.move_fields_from_available_to_displayed  true,field_list
			CIF_IFM.set_sort_field_on_related_list_configuration  "Created Date"
			CIF_IFM.click_ok_button_related_list_configuration_popup
			CIF_IFM.select_related_list [$cif_related_list_toolbar_label_history_sales_invoice]
			CIF_IFM.click_ok_button_on_related_list
			list_result = CIF_IFM.verify_related_list_on_ifm_editor [$cif_related_list_toolbar_label_history_sales_invoice], true
			gen_compare true, list_result.empty?,'Expected Related List item History: Sales Invoice is displayed'
			gen_end_test "TST033310 - d. Verify that user can edit related list using Input Form Manager"
			
			#Save the Form
			CIF_IFM.click_save_button
        	CIF.wait_for_loading_mask_to_complete CIF_DEFAULT_TIME_FOR_LOADING_MASK

	        # Activate form layout
			CIF_IFM.select_input_form_manager_from_list _input_form_name
	        CIF_IFM.select_and_activate_form _input_form_name, $company_merlin_auto_gb
		end
		gen_end_test "TST033310 - CIF | Verify that user can add ,delete and edit related list on Input Form Manager"
	
		gen_start_test "TST033331 - CIF | Verify that user can view related list and create new Related List record on Sales Invoice Object"
		begin
			_file_to_attach = "SmokeTestStatement.CSV"
			_note_message = "Note for Related List Test"
			
			# Create a Sales Invoice
			SF.app $accounting
			SF.tab $tab_sales_invoices
			SF.click_button_new
			gen_wait_until_object $cif_sales_invoice_account 
			CIF_SINV.set_sinv_account $bd_account_bolinger
			
			#Add line items 
			CIF_SINV.click_new_row
			CIF_SINV.set_sinv_line_product $bd_product_champagne		
			CIF_SINV.set_sinv_line_quantity 1
			CIF_SINV.set_sinv_line_unit_price "50"
			CIF_SINV.set_sinv_line_dimesion_1 $bdu_dim1_gbp
			CIF_SINV.set_sinv_line_dimesion_2 $bdu_dim2_gbp
			CIF_SINV.set_sinv_line_tax_code $bdu_tax_code_vo_s
			CIF.click_toggle_button
			CIF_SINV.click_sinv_save_button
			SF.wait_for_search_button	
			
			#Asserting Related Lists
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_attachments, true, "Related List item Attachments is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			list_fields_order = CIF.verify_related_list_field_order ["File Name","Last Modified Date","Created By ID"], true
			gen_compare true, list_fields_order.empty?,'Expected Field Order in Related List Attachments'
			
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_notes, true, "Related List item Notes is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			list_fields_order = CIF.verify_related_list_field_order ["Title","Last Modified Date","Created By ID"], true
			gen_compare true, list_fields_order.empty?,'Expected Field Order in Related List Notes'
			
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_intercompany_transfers, true, "Related List item Intercompany Transfers is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_intercompany_transfers
			list_fields_order = CIF.verify_related_list_field_order ["Destination Company","Record ID"], true
			gen_compare true, list_fields_order.empty?,'Expected Field Order in Related List Intercompany Transfers'
			
			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_sales_order_custom_object, true, "Related List item Sales Order Custom Object is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_sales_order_custom_object
			list_fields_order = CIF.verify_related_list_field_order ["Account","Accounting Currency","Created Date","Customer Reference","Deleted","Dimension 1","Dimension 2","Dimension 3","Dimension 4","Due Date","External Id","Invoice Date","Last Modified By ID","Last Modified Date","Order Status","Owner ID","Period","Processed","Record ID","Sales Credit Note Number","Sales Invoice Custom Object Number","Sales Invoice Number","System Modstamp","Tax Code1","Tax Code2","Tax Code3","Unit of Work"], true
			gen_compare true, list_fields_order.empty?,'Expected Field Order in Related List Sales Order Custom Object'

			gen_compare_has_css_with_text $cif_sales_invoice_related_list_toolbar, $cif_related_list_toolbar_label_history_sales_invoice, true, "Related List item History: Sales Invoice is displayed"
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_history_sales_invoice
			list_fields_order = CIF.verify_related_list_field_order ["Created Date","Created By ID","Changed Field","Deleted","Entity History ID","New Value","Old Value","Parent ID"], true
			gen_compare true, list_fields_order.empty?,'Expected Field Order in Related List History: Sales Invoice'

			#Note creation
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			CIF_SINV.create_new_note _note_message
			
			#Attachment
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments			
			CIF_SINV.attach_file_in_related_list_toolbar _file_to_attach
			CIF.click_to_collapse_related_list_toolbar_view
			
			#Sales Order Custom Object
			_sales_invoice_number = CIF.get_document_number_from_header
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_sales_order_custom_object		
			CIF_SINV.create_related_list_sales_order_custom_object_record _sales_invoice_number

			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SIN.open_invoice_detail_page _sales_invoice_number
			#Posting the sales invoice
			CIF_SINV.click_sinv_post_button
			CIF.wait_for_buttons_to_load
			
			#Validate related list toolbar items
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_attachments
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 attachment record"
			
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_notes
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 Notes record"
		
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_history_sales_invoice
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 History: Sales Invoice record"
		
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_intercompany_transfers
			gen_compare "0", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 0 Intercompany Transfers record"
			CIF.click_to_collapse_related_list_toolbar_view	
							
			CIF.click_related_list_toolbar_item  $cif_related_list_toolbar_label_sales_order_custom_object
			gen_compare "1", CIF.get_count_of_lines_in_related_list_toolbar, "Expected 1 Sales Order Custom Object record"
			CIF.click_to_collapse_related_list_toolbar_view	
		end
		gen_end_test "TST033331 - CIF | Verify that user can view related list and create new Related List record on Sales Invoice Object"
	end

	after :all do
		login_user
		_revoke_permission_from_custom_object = ["delete[SELECT Id FROM FieldPermissions WHERE field = 'codaSalesOrderCustomObject__c.SalesInvoiceNumber__c' AND parent.Name = 'Accounting'];"]
		APEX.execute_commands _revoke_permission_from_custom_object
		FFA.delete_new_data_and_wait
		SF.logout
        gen_end_test "TID020295: Verify the related lists functionality on CIF Documents"    
	end
end
