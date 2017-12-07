#--------------------------------------------------------------------#
#	TID : TID013449 
# 	Pre-Requisite : smoketest_data_setup.rb
#  	Product Area: Merlin Auto Spain- Online enquiry drilling,export (Smoke Test)
# 	Story: 24999  
#   For this script- set sf.browser_profile =firefox_profile1 in config_helper.rb
#--------------------------------------------------------------------#
describe "Merlin Auto Spain : Smoke Test - Online enquiry", :type => :request do
include_context "login"
include_context "logout_after_each"
	_dv_common_name_document_total = "DocTot"
	_export_template_result_name = "Export_template_data1"
	_export_template_json_file_name = "Export_template"
	
	before :all do
		gen_start_test "TID013449"
		#Hold Base Data
		FFA.hold_base_data_and_wait
		# Removing files(if exist any) from testUploadFiles
		filename1 = _export_template_result_name+".xlsx"
		gen_remove_file filename1
		file_name_with_json_extension = gen_downloaded_files_names ".json"
		if (file_name_with_json_extension.count != 0)
			filename2 = file_name_with_json_extension[0]
			gen_remove_file filename2
		end
	end

	it "TID013449 : Online enquiry test for drilling and Export " do
		_last_year_value = (Time.now).year - 1
		_dv_dataview_label = "Dataview"
		_inq_template_label = "Action View Template"
		_dv_invoice_head = "DV-InvHead"
		_inq_template_invoice = "ET-InvHead"
		_dv_invoice_line = "DV-InvLine"
		_inq_template_line = "ET-InvLine"
		_dv_transaction = "DV-Transaction"
		_inq_template_transaction = "ET-Transaction"
		_export_button = "Export"
		_dv_join_type_lookup = "lookup"
		_dv_join_type_relationship = "relationship"
		_ascending_order = "Ascending"
		_descending_order = "Descending"
		_export_data_with_sort_criteria = "Export Sort Criteria"
		_export_data_with_row_selection = "Export Row Selection"
		_line_item_data_prefix = "4,000.00 10.00 400.00 "
		_line_item_data_suffix = " BFD84 Bendix Front Brake Pad Set 1975-1983 Chrysler Cordoba"
		_trx_line_item_data_prefix = "Pyramid Construction Inc 838.00 "
		_trx_line_item_data_suffix  = " " + "0.00" + " " + _last_year_value.to_s + " " +"4,190.00" + " " +_last_year_value.to_s + "/001"
		_operator_starts_with = "starts with"
		_codainvoice_object_invoice_number = "codaInvoice__c.Invoice Number"
		_invoice_object_invoice_number = "Invoice__c.Invoice Number"
		_transaction_object_document_number = "codaTransaction__c.Document Number"
		_codainvoice_object_invoice_total = "codaInvoice__c.Invoice Total"
		_account_object_account_name = "Account__c.Account Name"
		_codainvoice_object_tax_total = "codaInvoice__c.Tax Total"

		begin
			SF.logout
			gen_switch_to_driver $driver_firefox , FIREFOX_PROFILE1
			gen_wait_less
			login_user
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain],true
			# Assigning permission set
			_permission_set_list = [$ffa_permission_set_acc_billing_background_posting,$ffa_permission_set_action_views_reporting_integration_run,$ffa_permission_set_action_views_reporting]
			SF.set_user_permission_set_assignment _permission_set_list, $bd_user_fullname_accountant, false
			# step to create a common name
			begin 
				DataView.add_new_value_in_common_name_picklist _dv_common_name_document_total 
				DataView.add_new_value_in_common_name_picklist $bd_dataview_common_name_invoice_number
				DataView.add_new_value_in_common_name_picklist $bd_dataview_common_name_invoice_total
			end

			SF.login_as_user $bd_user_accountant_alias
			SF.app $accounting
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_spain] ,true
			begin
				# Pre-Requisite
				SF.tab $tab_opportunities
				OPP.all_opportunities_view
				SF.click_button_go
				OPP.view_opportunity $bd_opp_pyramid_emergency_generators
				SF.click_button_edit
				page.has_text?($bd_account_pyramid_construction_inc)
				OPP.set_account_name $bd_account_pyramid_construction_inc
				SF.click_button_save
				SF.wait_for_search_button
				expect(page).to have_text($bd_account_pyramid_construction_inc)
				gen_report_test "Pyramid emergency generator opprtunity is successfully saved with account as pyramid construction inc."
				SF.tab $tab_opportunities
				OPP.all_opportunities_view
				SF.click_button_go
				OPP.view_opportunity $bd_opp_pyramid_emergency_generators_2
				SF.click_button_edit
				page.has_text?($bd_opp_pyramid_emergency_generators_2)
				OPP.set_account_name $bd_account_pyramid_construction_inc
				SF.click_button_save
				SF.wait_for_search_button
				expect(page).to have_text($bd_account_pyramid_construction_inc)
				gen_report_test "Pyramid emergency generator2 opprtunity is successfully saved with account as pyramid construction inc."				
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
				OPP.click_save_button_and_accept_alert
				SF.wait_for_apex_job
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				_new_invoice_count = FFA.ffa_listview_get_rows
				_actual_created_invoice_count = _new_invoice_count - _initial_invoice_count
				_invoice_count = _initial_invoice_count
				_sin_number_array = Array[]
				for i in 1.._actual_created_invoice_count do
					SIN.view_invoice_detail _invoice_count
					_sin_number_array[i-1] = SIN.get_invoice_number
					gen_compare $bd_document_status_in_progress , SIN.get_status , "Expected Invoice Status to be In Progress"
					SF.click_link $sin_back_to_list_sales_invoices
					SF.select_view $bd_select_view_all
					SF.click_button_go
					_invoice_count = _invoice_count + 1
				end
				
				for i in 1.._actual_created_invoice_count do
					FFA.select_row_from_grid  _sin_number_array[i-1]
				end
				SIN.click_post_button
				SF.click_button $sin_post_invoices_button
				SF.tab $tab_sales_invoices
				SF.click_button_new
				SF.wait_for_search_button
				SF.click_link $sin_convert_link
				OPP.convert_set_opp_name $bd_opp_pyramid_emergency_generators_2
				OPP.click_convert
				OPP.click_create_invoice
				_invoice_number6 = SIN.get_invoice_number
				SF.tab $tab_sales_invoices
				SF.select_view $bd_select_view_all
				SF.click_button_go
				FFA.select_row_from_grid _invoice_number6
				SIN.click_post_button
				SF.click_button $sin_post_invoices_button
				SF.wait_for_search_button
				SF.tab $tab_background_posting_scheduler
				SF.wait_for_search_button
				SF.click_button $ffa_run_now_button
				SF.wait_for_apex_job
			end
			# updating object fields as per org type
				if ORG_TYPE == MANAGED 
					_codainvoice_object_invoice_number = "#{ORG_PREFIX}"+_codainvoice_object_invoice_number
					_invoice_object_invoice_number = "#{ORG_PREFIX}"+_invoice_object_invoice_number
					_transaction_object_document_number  = "#{ORG_PREFIX}"+_transaction_object_document_number 
					_codainvoice_object_invoice_total  = "#{ORG_PREFIX}"+_codainvoice_object_invoice_total 
					_account_object_account_name  = "#{ORG_PREFIX}"+_account_object_account_name 
					_codainvoice_object_tax_total  = "#{ORG_PREFIX}"+_codainvoice_object_tax_total 
				end
				_coda_invoice_due_date= "#{ORG_PREFIX}"+$bd_field_due_date_api_name
				_coda_invoice_date = "#{ORG_PREFIX}"+$bd_field_invoice_date_api_name
				_coda_invoice_customer_reference = "#{ORG_PREFIX}"+$bd_field_customer_reference_api_name
				_coda_invoice_net_total = "#{ORG_PREFIX}"+$bd_field_net_total_api_name
				_coda_invoice_tax_total = "#{ORG_PREFIX}"+$bd_field_tax_total_api_name
				_coda_invoice_total_name = "#{ORG_PREFIX}"+$bd_field_sales_invoice_total_api_name

			# step 1.2 create data view and template and set drilling template
			begin
				gen_start_test "create data view and drilling template "
				SF.tab $tab_dataviews
				SF.click_button_new
				SF.wait_for_search_button
				gen_start_test "create a new dataview: " + _dv_invoice_head
				DataView.set_name _dv_invoice_head
				DataView.set_primary_object $bd_object_sales_invoice_api_name
				FFA.click_grid_tab_by_label $dataview_tab_joins
				DataView.add_join nil,$bd_object_account_api_name , nil
				# Add fields in the data view
				FFA.click_grid_tab_by_label $dataview_tab_fields
				DataView.add_field "1",$bd_object_account_api_name,$bd_field_name_api_name,nil,$bd_dataview_common_name_account,true,true,nil,nil,true
				# Select key for Dataview
				DataView.set_key $bd_field_name_api_name ,4 ,true
				DataView.add_field "2",$bd_object_sales_invoice_api_name,_coda_invoice_date,nil,nil,true,true,nil,nil,false
				DataView.add_field "3",$bd_object_sales_invoice_api_name,$bd_field_name_api_name,nil,$bd_dataview_common_name_invoice_number,true,true,nil,nil,false
				DataView.add_field "4",$bd_object_sales_invoice_api_name,_coda_invoice_due_date,nil,nil,true,true,nil,nil,false
				DataView.add_field "5",$bd_object_sales_invoice_api_name,_coda_invoice_customer_reference,nil,nil,true,true,nil,nil,false
				DataView.add_field "6",$bd_object_sales_invoice_api_name,_coda_invoice_net_total,nil,nil,true,true,nil,nil,false
				DataView.add_field "7",$bd_object_sales_invoice_api_name,_coda_invoice_tax_total,nil,nil,true,true,nil,nil,false
				DataView.add_field "8",$bd_object_sales_invoice_api_name,_coda_invoice_total_name,nil,$bd_dataview_common_name_invoice_total,true,true,nil,nil,false
				
				# save the dataview without addind ID
				DataView.save_with_ids false
				gen_report_test "Sales Invoice data view is saved."
				SF.tab $tab_dataviews
				SF.click_button_new
				SF.wait_for_search_button
				gen_start_test "create a new dataview: " + _dv_invoice_line
				DataView.set_name _dv_invoice_line
				DataView.set_primary_object $bd_object_invoice_line_item_api_name
				FFA.click_grid_tab_by_label $dataview_tab_joins
				DataView.add_join nil,$bd_object_sales_invoice_api_name , nil
				DataView.choose_node "Primary Object",$bd_object_invoice_line_item_api_name
				DataView.add_join nil,"Product__c" , nil
				# Add fields in the data view
				_invoice_line_item_net_value = "#{ORG_PREFIX}"+$bd_field_line_item_net_value_api_name
				_invoice_line_item_unit_price = "#{ORG_PREFIX}"+$bd_field_line_item_unit_price_api_name
				_invoice_line_item_quantity = "#{ORG_PREFIX}"+$bd_field_line_item_quantity_api_name
				FFA.click_grid_tab_by_label $dataview_tab_fields
				DataView.add_field "1",$bd_object_sales_invoice_api_name,$bd_field_name_api_name,nil,$bd_dataview_common_name_invoice_number,true,true,nil,nil,true
				# Select key for Dataview
				DataView.set_key $bd_field_name_api_name ,4 ,true
				DataView.add_field "2",$bd_object_product_api_name,$bd_field_product_code_api_name,nil,nil,true,true,nil,nil,false
				DataView.add_field "3",$bd_object_invoice_line_item_api_name,_invoice_line_item_quantity,nil,nil,true,true,nil,nil,false
				DataView.add_field "4",$bd_object_product_api_name,$bd_field_name_api_name,nil,nil,true,true,nil,nil,false
				DataView.add_field "5",$bd_object_invoice_line_item_api_name,_invoice_line_item_unit_price,nil,nil,true,true,nil,nil,false
				DataView.add_field "6",$bd_object_invoice_line_item_api_name,_invoice_line_item_net_value,nil,nil,true,true,nil,nil,false
				# save the dataview without adding ID
				DataView.save_with_ids false
				gen_report_test "Sales Invoice line item data view is saved."
				SF.tab $tab_dataviews
				SF.click_button_new
				SF.wait_for_search_button
				gen_start_test "create a new dataview: " + _dv_transaction
				DataView.set_name _dv_transaction
				DataView.set_primary_object $bd_object_transaction_api_name
				FFA.click_grid_tab_by_label $dataview_tab_joins
				DataView.add_join nil,$bd_object_account_api_name , nil
				DataView.choose_node "Primary Object",$bd_object_transaction_api_name
				DataView.add_join nil,$bd_object_period_api_name , nil
				DataView.choose_node  "Primary Object",$bd_object_transaction_api_name
				DataView.add_join _dv_join_type_relationship , $bd_ref_object_sales_invoice_api_name , nil
				# adding fields as per org type
				_transaction_document_number = "#{ORG_PREFIX}"+$bd_field_document_number_api_name
				_transaction_account_total = "#{ORG_PREFIX}"+$bd_field_account_total_api_name
				_transaction_home_value = "#{ORG_PREFIX}"+$bd_field_home_value_total_api_name
				_transaction_year_name = "#{ORG_PREFIX}"+$bd_field_year_api_name
				FFA.click_grid_tab_by_label $dataview_tab_fields
				DataView.add_field "1",$bd_object_transaction_api_name,_transaction_document_number,nil,$bd_dataview_common_name_invoice_number,true,true,nil,nil,true
				# Select key for Dataview
				DataView.set_key _transaction_document_number ,4 ,true
				DataView.add_field "2",$bd_object_account_api_name,$bd_field_name_api_name,nil,$bd_dataview_common_name_account,true,true,nil,nil,false
				DataView.add_field "3",$bd_object_transaction_api_name,_transaction_account_total,nil,nil,true,true,nil,nil,false
				DataView.add_field "4",$bd_object_sales_invoice_api_name,_coda_invoice_total_name,nil,_dv_common_name_document_total,true,true,nil,nil,false
				DataView.add_field "5",$bd_object_transaction_api_name,_transaction_home_value,nil,nil,true,true,nil,nil,false
				DataView.add_field "6",$bd_object_transaction_api_name,_transaction_year_name,nil,nil,true,true,nil,nil,false
				DataView.add_field "7",$bd_object_period_api_name,$bd_field_name_api_name,nil,$bd_field_period_api_name,true,true,nil,nil,false
				# save the dataview without addind ID
				DataView.save_with_ids false
				gen_report_test "Transaction data view is saved."
				
				SF.tab $tab_dataviews
				SF.click_button_go
				# Verify that data views are created 
				expect(page).to have_link(_dv_transaction,:text => _dv_transaction)
				gen_report_test "Transaction data view is created successfully."
				expect(page).to have_link(_dv_invoice_head,:text => _dv_invoice_head)
				gen_report_test "Sales Invoice data view is created successfully."
				expect(page).to have_link(_dv_invoice_line,:text => _dv_invoice_line)
				gen_report_test "Invoice Line  data view is created successfully."
				
				# Create inquiry template
				gen_start_test "create inquiry template : " + _inq_template_invoice
				SF.tab $tab_inquiry_template
				SF.click_button_new
				SF.wait_for_search_button
				InquiryTemplate.set_name _inq_template_invoice
				InquiryTemplate.set_dataview _dv_invoice_head
				InquiryTemplate.add_all
				InquiryTemplate.open_column_formatting_window _codainvoice_object_invoice_number
				InquiryTemplate.formatting_set_operator _operator_starts_with
				InquiryTemplate.formatting_set_from_value "S"
				InquiryTemplate.formatting_set_text_color_condition_true $black_color
				InquiryTemplate.formatting_set_fill_color_condition_true $red_color
				InquiryTemplate.formatting_set_text_color_condition_false $red_color
				InquiryTemplate.formatting_set_fill_color_condition_false $black_color
				InquiryTemplate.formatting_click_button_ok
				InquiryTemplate.save	
				page.has_text?(_inq_template_invoice)				
				gen_start_test "create inquiry template : " + _inq_template_line
				SF.tab $tab_inquiry_template
				SF.click_button_new
				SF.wait_for_search_button
				InquiryTemplate.set_name _inq_template_line
				InquiryTemplate.set_dataview _dv_invoice_line
				InquiryTemplate.add_all
				InquiryTemplate.open_column_formatting_window _invoice_object_invoice_number
				InquiryTemplate.formatting_set_operator _operator_starts_with
				InquiryTemplate.formatting_set_from_value "S"
				InquiryTemplate.formatting_set_text_color_condition_true $green_color
				InquiryTemplate.formatting_set_fill_color_condition_true $yellow_color
				InquiryTemplate.formatting_set_text_color_condition_false $yellow_color
				InquiryTemplate.formatting_set_fill_color_condition_false $green_color
				InquiryTemplate.formatting_click_button_ok
				InquiryTemplate.save
				
				gen_start_test "create inquiry template : " + _inq_template_transaction
				SF.tab $tab_inquiry_template
				SF.click_button_new
				SF.wait_for_search_button
				InquiryTemplate.set_name _inq_template_transaction
				InquiryTemplate.set_dataview _dv_transaction
				InquiryTemplate.add_all
				InquiryTemplate.open_column_formatting_window _transaction_object_document_number
				InquiryTemplate.formatting_set_operator _operator_starts_with
				InquiryTemplate.formatting_set_from_value "S"
				InquiryTemplate.formatting_set_text_color_condition_true $pink_color
				InquiryTemplate.formatting_set_fill_color_condition_true $blue_color
				InquiryTemplate.formatting_set_text_color_condition_false $blue_color
				InquiryTemplate.formatting_set_fill_color_condition_false $pink_color
				InquiryTemplate.formatting_click_button_ok
				InquiryTemplate.save
				
				SF.tab $tab_inquiry_template
				SF.click_button_go
				# Expect inquiry template created 
				expect(page).to have_link(_inq_template_invoice,:text => _inq_template_invoice)
				gen_report_test "Invoice  template is created successfully."
				expect(page).to have_link(_inq_template_transaction,:text => _inq_template_transaction)
				gen_report_test "Transaction template is created successfully."
				expect(page).to have_link(_inq_template_line,:text => _inq_template_line)
				gen_report_test "Invoice line  template is created successfully."
				
				
				# Set up the drilling template
				SF.tab $tab_inquiry_template
				SF.click_button_go
				InquiryTemplate.open _inq_template_invoice
				SF.wait_for_search_button
				page.has_text?(_account_object_account_name)
				InquiryTemplate.set_drill_template _codainvoice_object_invoice_total , _inq_template_transaction
				InquiryTemplate.set_drill_template _codainvoice_object_invoice_number , _inq_template_line
				InquiryTemplate.set_drill_template _account_object_account_name , _inq_template_transaction
				InquiryTemplate.save
				gen_report_test "Set the drilling template for INV-Head."
				# Set up the drilling template
				SF.tab $tab_inquiry_template
				SF.click_button_go
				InquiryTemplate.open _inq_template_line
				SF.wait_for_search_button
				page.has_text?(_invoice_object_invoice_number)
				InquiryTemplate.set_drill_template _invoice_object_invoice_number , _inq_template_transaction
				InquiryTemplate.save
				gen_report_test "Set the drilling template for INV-Line."
				# Set up the drilling template
				SF.tab $tab_inquiry_template
				SF.click_button_go
				InquiryTemplate.open _inq_template_transaction
				SF.wait_for_search_button
				page.has_text?(_transaction_object_document_number)
				InquiryTemplate.set_drill_template _transaction_object_document_number , _inq_template_invoice
				InquiryTemplate.save
				gen_report_test "Set the drilling template for INV-Transaction."
			end

			# step 1.3 to do drilling on templates
			begin
				gen_start_test "Drilling on templates"
				SF.tab $tab_online_inquiries
				OLI.run _inq_template_invoice
				page.has_text?(_invoice_number6)
				page.has_text?($bd_product_bendix_front_brake_pad_1975_83_chrysler_cordoba)
				gen_compare 6,OLI.get_grid_rows,"Expected number of invoices to be displayed is 6. "
				row = 1
				while row <= OLI.get_grid_rows
					OLI.check_cell_formatting row,7,"to_have",$black_color,$red_color
					row+=1
				end
				OLI.toolbar_sort
				OLI.add_sort 1,_codainvoice_object_invoice_number, "Ascending" , nil , nil,true
				griddata = Array.new 
					.push(OLI.get_grid_data_row 1)
					.push(OLI.get_grid_data_row 2)
					.push(OLI.get_grid_data_row 3)
					.push(OLI.get_grid_data_row 4)
					.push(OLI.get_grid_data_row 5)
					.push(OLI.get_grid_data_row 6)
				
				OLI.drill_on_cell 1 , 7
				gen_compare 1,OLI.get_grid_rows,"Expected only one line item to be displayed ."
				lineitemdata1 = OLI.get_grid_data_row 1
				line = _line_item_data_prefix + _sin_number_array[0] + _line_item_data_suffix
				gen_compare line,lineitemdata1 , "Expected single line item to be displayed with correct product information."
				OLI.check_cell_formatting 1,6,"to_have",$green_color,$yellow_color
				
				OLI.drill_on_cell 1 , 6
				gen_compare 1,OLI.get_grid_rows,"Expected only one transaction line item to be displayed. "
				trxlineitemdata = OLI.get_grid_data_row 1
				trx_line = _trx_line_item_data_prefix + _sin_number_array[0] + _trx_line_item_data_suffix
				gen_compare trx_line,trxlineitemdata , "Expected single transaction line item to be displayed with correct information."
				OLI.check_cell_formatting 1,7,"to_have",$pink_color,$blue_color
				
				OLI.drill_on_cell 1 , 5
				gen_compare 1,OLI.get_grid_rows,"Expected Only one invoice value to be displayed. "
				invheaddata = OLI.get_grid_data_row 1
				gen_include griddata[0],invheaddata, "Expected the listed invoice to be same as the one which is clicked first on drilling. "
				OLI.check_cell_formatting 1,7,"to_have",$black_color,$red_color
			end
			# step 1.4 to do sorting and export template results
			begin
				gen_start_test "Sorting and export template results."
				SF.tab $tab_inquiry_template
				SF.click_button_go
				InquiryTemplate.open _inq_template_invoice
				InquiryTemplate.tab_sort_and_group
				InquiryTemplate.add_sort 1 , _account_object_account_name  ,_ascending_order , nil , nil 
				InquiryTemplate.add_sort 2 , _codainvoice_object_invoice_number  ,_ascending_order , nil , nil 
				InquiryTemplate.add_sort 3 , _codainvoice_object_tax_total  ,_descending_order , nil , nil
				InquiryTemplate.save_and_run
				OLI.toolbar_export
				OLI.check_export_options_checkbox [_export_data_with_sort_criteria,_export_data_with_row_selection] 
				OLI.set_template_results_export_file_name _export_template_result_name
				OLI.click_inquiry_template_result_export_data_button
				SF.wait_for_search_button
				SF.tab $tab_inquiry_template # Switching to other tab to ensure that file is downloaded successfully before asserting the content of it.
				SF.click_button_go
								
				if OS_TYPE == OS_WINDOWS
					pwd = Dir.pwd + $upload_file_path
					file=pwd.gsub("/", "\\")
				else 
					file=Dir.pwd + $upload_file_path
				end
								
				file_path = file+_export_template_result_name+".xlsx"
				puts "Verifying the content of file: "+file_path
				# Assert the content of downloaded File
				workbook = RubyXL::Parser.parse(file_path)
				worksheet = workbook[0]
				inv_num_data =  worksheet.get_table([_codainvoice_object_invoice_number ])
				inv_list =  "#{inv_num_data[_codainvoice_object_invoice_number ]}"
				gen_include  _sin_number_array[0],inv_list.split(',')[0], "Expected sales Invoice in sorted order. 1.) " + _sin_number_array[0]
				gen_include  _sin_number_array[1],inv_list.split(',')[1], "Expected sales Invoice in sorted order. 2.) " + _sin_number_array[1]
				gen_include  _sin_number_array[2],inv_list.split(',')[2],"Expected sales Invoice in sorted order. 3.) " + _sin_number_array[2]
				gen_include  _sin_number_array[3],inv_list.split(',')[3], "Expected sales Invoice in sorted order. 4.)" + _sin_number_array[3]
				gen_include  _sin_number_array[4],inv_list.split(',')[4], "Expected sales Invoice in sorted order. 5.)" + _sin_number_array[4]
				gen_include  _invoice_number6,inv_list.split(',')[5], "Expected sales Invoice in sorted order. 6.)" +_invoice_number6
			end	
			# Step 1.5 and 1.6 to export the template and download it.
			begin	
				gen_start_test "Download the template records."
				FFA.select_row_from_grid _inq_template_line
				SF.click_button _export_button
				expect(page).to have_css($online_inquiries_export_export_name ,:count => 1)
				gen_report_test "Expected export data to be present at export section."
				#List of items to export
				itemstoexport  = Array.new 
				.push(gen_table_data_row $online_inquiries_export_all_baggage_grid,1)
				.push(gen_table_data_row $online_inquiries_export_all_baggage_grid,2)
				.push(gen_table_data_row $online_inquiries_export_all_baggage_grid,3)
				.push(gen_table_data_row $online_inquiries_export_all_baggage_grid,4)
				.push(gen_table_data_row $online_inquiries_export_all_baggage_grid,5)
				.push(gen_table_data_row $online_inquiries_export_all_baggage_grid,6)
				.sort
				
				itemexport1 = _dv_invoice_head + " " + _dv_dataview_label
				itemexport2 = _dv_invoice_line + " " + _dv_dataview_label
				itemexport3 = _dv_transaction + " " + _dv_dataview_label
				itemexport4 = _inq_template_invoice + " " + _inq_template_label
				itemexport5 = _inq_template_line + " " + _inq_template_label
				itemexport6 = _inq_template_transaction + " " + _inq_template_label
				# Assert Export Items
				gen_compare itemexport1,itemstoexport[0],"Expected items to export to have "+itemexport1 + ", Got " +itemstoexport[0]
				gen_compare itemexport2,itemstoexport[1],"Expected items to export to have "+itemexport2 + ", Got " +itemstoexport[1]
				gen_compare itemexport3,itemstoexport[2],"Expected items to export to have "+itemexport3 + ", Got " +itemstoexport[2]
				gen_compare itemexport4,itemstoexport[3],"Expected items to export to have "+itemexport4 + ", Got " +itemstoexport[3]
				gen_compare itemexport5,itemstoexport[4],"Expected items to export to have "+itemexport5 + ", Got " +itemstoexport[4]
				gen_compare itemexport6,itemstoexport[5],"Expected items to export to have "+itemexport6 + ", Got " +itemstoexport[5]
				
				OLI::Export.set_export_name _export_template_json_file_name
				OLI::Export.click_download
				gen_wait_for_download_to_complete
			end	
			begin	
				gen_start_test "Clean the dataview,template and read exported file."
				# Remove the drilling template of online inquiry before deleting these templates.
				SF.tab $tab_inquiry_template
				SF.click_button_go
				InquiryTemplate.open _inq_template_invoice
				InquiryTemplate.select_all_fields_checkbox
				InquiryTemplate.delete
				InquiryTemplate.add_all
				InquiryTemplate.save
				
				SF.tab $tab_inquiry_template
				SF.click_button_go
				InquiryTemplate.open _inq_template_line
				InquiryTemplate.select_all_fields_checkbox
				InquiryTemplate.delete
				InquiryTemplate.add_all
				InquiryTemplate.save
				
				SF.tab $tab_inquiry_template
				SF.click_button_go
				InquiryTemplate.open _inq_template_transaction
				InquiryTemplate.select_all_fields_checkbox
				InquiryTemplate.delete
				InquiryTemplate.add_all
				InquiryTemplate.save
				# verify the exported .json file.
				file_name = gen_downloaded_files_names ".json"
				exported_file_name = file_name[0]
				file_path = file+exported_file_name
				puts "Verifying the content of file: "+file_path
				jsonfile = File.read(file_path)
				gen_report_test "File with dataview and inquiry template is exported successfully."
			end
		end 
	end
	after :all do
		#Switching back to default driver,profile as mentioned in property file.
		gen_switch_to_driver DRIVER , BROWSER_PROFILE
		login_user
		job_id_for_queued_job_query = "SELECT id FROM CronTrigger where State = 'WAITING' limit 1"
		APEX.execute_soql job_id_for_queued_job_query
		soql_results = APEX.get_execution_status_message
		expected_result_with_one_item = "totalSize\":1,"
		if soql_results.include? expected_result_with_one_item
			puts "Aborting the job with queued status."
			job_id_array = soql_results.split("\"")
			array_length =  job_id_array.length
			queued_job_id = job_id_array[array_length-2]
			abort_queued_worker_item = "System.abortJob('#{queued_job_id}');"	
			APEX.execute_script abort_queued_worker_item
			gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."
		end
		# Delete Test Data
		FFA.delete_new_data_and_wait
		DataView.delete_value_from_common_name_picklist _dv_common_name_document_total
		gen_end_test "TID013449"
		SF.logout
	end
end
