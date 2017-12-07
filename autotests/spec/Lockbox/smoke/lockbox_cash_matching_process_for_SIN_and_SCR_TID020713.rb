#--------------------------------------------------------------------#
#TID : TID020713
#Pre-Requisit: org with base data and deploy with lockbox package
#Product Area: Accounting LockBox - Cash Matching Process
#--------------------------------------------------------------------#

describe "Accounting LockBox - Cash Matching Process for SIN and SCR", :type => :request do
include_context "login"
	_date_today = Time.now.strftime("%d/%m/%Y")
	_line1_quantity_1 = "1"
	_line_unit_price_150 = "150.00"
	_matching_mode = "Document"
	_decimal_seperator_period = ". (period)"
	_thousands_seperator_comma = ", (comma)"
	_file_delimiter_semicolon = "; (semicolon)"
	_date_format_dd_mm_yyy = "dd/mm/yyyy"
	_line1 = 1;

	_bank_lockbox_col_number= "0";
	_deposite_date_col_number= "1";
	_remitter_col_number= "2" ;
	_check_box_col_number= "3";
	_document_ref_col_number= "4";
	_amount_col_number= "5";		
	_type_col_number= "6";
	_file_content = "{0};{1};{2};{3};{4};{5};{6}"
	_file2_content = "{0};{1};{2};{3};{4};{5};{6}"
	_lockbox_number = ""
	_sinv_total = "189.76"
	_scrn_total = "189.76"

	#file parameters
	file_name = "AR_cash_transaction.csv"
	_wire_number = ""
	_sin = "SIN"
	_scr = "SCR"
	_check_num1 = "112233441"
	_check_num2 = "112233442"
	_sinv_name = ""
	_scr_name = ""
	_num_100 = "100.00"
	_num_100_N = "-100.00"
	_lbx = "LBX"
before :all do
	#Hold Base Data
	gen_start_test  "TID020713-Process lock box Cash matching process for SIN and SCR"
	FFA.hold_base_data_and_wait	
end
	it "TST034582- Process Cash matching process for SIN" do		
		#create SINV 
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa],true	
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SIN.set_account $bd_account_algernon_partners_co
			SIN.set_invoice_date _date_today
			SIN.add_line 1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , _line1_quantity_1 , _line_unit_price_150 , nil , nil, nil
			FFA.click_save_post
			#expected Result
			_sinv_name = SIN.get_invoice_number
			invoice_status = SIN.get_status
			gen_compare $bd_document_status_complete , invoice_status , "Expected Invoice Status to be Complete"
			
			#Step 1: Goto Bank Lockboxes and create a new lockbox as below:
			SF.tab $tab_bank_lockboxes
			SF.click_button_new
			LOCKBOX.set_bank_account $bd_bank_account_bristol_checking_account, $company_merlin_auto_usa
			_wire_number = LOCKBOX.get_unique_number
			LOCKBOX.set_unique_number _wire_number
			LOCKBOX.set_currency $bd_currency_usd , $company_merlin_auto_usa
			LOCKBOX.set_matching_mode _matching_mode
			LOCKBOX.set_discount_gla $bd_gla_account_receivable_control_usd
			LOCKBOX.set_write_off_gla $bd_gla_write_off_us
			LOCKBOX.set_currency_write_off_gla $bd_gla_write_off_us
			LOCKBOX.set_bank_charges_gla $bd_gla_account_receivable_control_usd
			SF.click_button_save
			SF.wait_for_search_button
			_lockbox_number = LOCKBOX.get_bank_lockbox_number
			gen_compare_has_content _lockbox_number , true , "Lockbox created "
			
			#Step 2:Click on New Bank Lockbox Import Definition button and create new definition as below-
			SF.click_button $lockbox_new_import_defination_button
			LOCKBOX.set_import_defination_decimal_seperator _decimal_seperator_period
			LOCKBOX.set_import_defination_thousand_seperator _thousands_seperator_comma
			LOCKBOX.set_import_defination_file_delimiter _file_delimiter_semicolon
			LOCKBOX.set_import_defination_date_format _date_format_dd_mm_yyy
			SF.click_button_save
			SF.wait_for_search_button
			
			#Validate B.) New import definition should be created successfully.
			_defination_name = LOCKBOX.get_import_defination_decimal_seperator
			_decimal_seperator = LOCKBOX.get_import_defination_decimal_seperator
			_thousands_separator = LOCKBOX.get_import_defination_thousands_sepertor
			_file_delimiter = LOCKBOX.get_import_defination_file_delimeter
			_date_format = LOCKBOX.get_import_defination_date_format
			gen_compare _decimal_seperator, _decimal_seperator_period , "_decimal_seperator as expected"
			gen_compare _thousands_separator, _thousands_seperator_comma , "thousands_separator as expected"
			gen_compare _file_delimiter, _file_delimiter_semicolon , "file_delimiter as expected"
			gen_compare _date_format, _date_format_dd_mm_yyy , "date_format as expected"

			#step 3 Click on manage import mapping and create mapping 
			SF.click_button $lockbox_manage_import_mappings
			SF.wait_for_search_button
			LOCKBOX.set_deposite_date_column_number _deposite_date_col_number
			LOCKBOX.set_amount_column_number _amount_col_number
			LOCKBOX.set_bank_lockbox_num_column_number _bank_lockbox_col_number
			LOCKBOX.set_mapping_check_number_column_number _check_box_col_number
			LOCKBOX.set_remitter_column_number _remitter_col_number
			LOCKBOX.set_type_column_number _type_col_number
			LOCKBOX.set_document_ref_column_number _document_ref_col_number
			SF.click_button_save
			SF.wait_for_search_button	
			
			#C.) Import mapping should be saved successfully.
			LOCKBOX.click_more
			gen_compare LOCKBOX.get_deposite_date_column_number, _deposite_date_col_number , "deposite_date_col_number as expected"
			gen_compare LOCKBOX.get_amount_column_number, _amount_col_number , "amount_col_number as expected"
			gen_compare LOCKBOX.get_bank_lockbox_num_column_number, _bank_lockbox_col_number , "bank_lockbox_col_number as expected"
			gen_compare LOCKBOX.get_mapping_check_number_column_number, _check_box_col_number , "check_box_col_number as expected"
			gen_compare LOCKBOX.get_remitter_column_number, _remitter_col_number , "remitter_col_number as expected"
			gen_compare LOCKBOX.get_type_column_number, _type_col_number , "type_col_number as expected"
			gen_compare LOCKBOX.get_document_ref_column_number, _document_ref_col_number , "document_ref_col_number as expected"
					
			##Step 4. Goto Lockbox created in Step A and click on New AR Cash Transaction from detail page.
			SF.click_link _lockbox_number
			SF.wait_for_search_button
			SF.click_button $lockbox_new_ar_cash_transation
			_file_content = _file_content.gsub("{"+_bank_lockbox_col_number+"}", _wire_number.to_s)
			_file_content = _file_content.gsub("{"+_deposite_date_col_number+"}", _date_today)
			_file_content = _file_content.gsub("{"+_remitter_col_number+"}", _sin)
			_file_content = _file_content.gsub("{"+_check_box_col_number+"}", _check_num1)
			_file_content = _file_content.gsub("{"+_document_ref_col_number+"}", _sinv_name)
			_file_content = _file_content.gsub("{"+_amount_col_number+"}", _num_100)
			_file_content = _file_content.gsub("{"+_type_col_number+"}", "LBX")
			
			##write content to file
			gen_create_file file_name, _file_content
			gen_move_file Dir.pwd + "/" + file_name, Dir.pwd + $upload_file_path + file_name
			LOCKBOX.import_ar_cash_transaction file_name	
           	LOCKBOX.click_button_import
			SF.wait_for_search_button
			SF.wait_for_apex_job		
			
			##get AR cash transaction details 
			_ar_cash_trans_id, _ar_cash_trans_name = LOCKBOX.get_ar_cash_transaction_details _lockbox_number 
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _lockbox_number
			SF.wait_for_search_button
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			_ar_cash_transation_status = LOCKBOX.get_ar_cash_trasaction_status
			gen_compare _ar_cash_transation_status, $bd_document_status_imported , "_ar_cash_transation_status is imported"
			gen_compare_has_content _sinv_name , true , "SINV present in related list"
						
			##Step 5.Once File is imported, click on Create Cash Entry button
			SF.click_button $lockbox_create_cash_entry
			SF.wait_for_search_button
			LOCKBOX.select_cash_enrtry_radio_option $lockbox_cash_entry_for_lbx_only
			SF.click_button $lockbox_create_cash_entry
			SF.wait_for_search_button
			SF.wait_for_apex_job
			
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _lockbox_number
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			gen_compare LOCKBOX.get_ar_cash_trasaction_status, $bd_document_status_complete , "_ar_cash_transation_status is complete"
			gen_compare LOCKBOX.get_ar_cash_trasaction_type, $lockbox_cash_entry_for_lbx_only , "_ar_cash_transation_status is complete"
			gen_compare LOCKBOX.get_ar_cash_trasaction_no_of_cash_entries , "1" , "no_of_cash_entries correct"
			gen_compare LOCKBOX.get_ar_cash_trasaction_total_of_cash_entries, _num_100 , "_ar_cash_transation_status is complete"
			
			#Step 6 and validate F -A new cash entry should be created as
			#get Cash entry from AR Transaction 
			_ar_cash_entry_id, _ar_cash_entry_name	= LOCKBOX.get_cash_entry_details_from_ar_cash_transaction _ar_cash_trans_name 
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _ar_cash_entry_name
			SF.wait_for_search_button
			gen_compare _date_today, CE.get_cash_entry_date , "cash_entry_date is as expected"
			gen_compare_has_content $bd_bank_account_bristol_checking_account , true ,  "bank_account_name #{$bd_bank_account_bristol_checking_account} is as expected"
			gen_compare_has_content $bd_account_algernon_partners_co , true ,  "account_name is as expected #{$bd_account_algernon_partners_co}"
			gen_compare _num_100, CE.get_cashentry_value , "cashentry_value is as expected"
			
			#Step 7 Navigate to Lock box created in step 1 and open AR transaction detail page.
			#Click on match button and wait for the matching process to complete and check G
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _lockbox_number
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			SF.click_button $ffa_match
			SF.wait_for_search_button
			SF.click_button $lockbox_yes
			SF.wait_for_search_button
			SF.wait_for_apex_job
			#validate - G.) AR status= Matched, Payment status of SIN = Part Paid
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _lockbox_number
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			_ar_cash_transation_status = LOCKBOX.get_ar_cash_trasaction_status
			gen_compare _ar_cash_transation_status, $bd_payment_matched_status , "_ar_cash_transation_status is matched"
			
			SF.tab $tab_sales_invoices
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _sinv_name
			SF.wait_for_search_button
			invoice_payment_status = SIN.get_invoice_payment_status
			gen_compare $bd_document_payment_status_part_paid , invoice_payment_status , "Expected Invoice payment Status to be #{ $bd_document_payment_status_part_paid} "
			SF.logout
		end			
	end
	
	it "TST034587- Process Cash matching process for SCR" do	
	    login_user
		#create SCRN
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa],true
			
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCR.set_account  $bd_account_algernon_partners_co
			SCR.set_creditnote_date _date_today
			SCR.add_line _line1 , $bd_product_auto_com_clutch_kit_1989_dodge_raider , _line1_quantity_1 , _line_unit_price_150 , nil , nil 	
			FFA.click_save_post
			creditnote_status = SCR.get_credit_note_status
			_scr_name = SCR.get_credit_note_number
			#Assert credit note status
			gen_compare $bd_document_status_complete , creditnote_status ,"Expected SCR status to be complete."
				
			#Step 1: Goto Bank Lockboxes and create a new lockbox as below:
			SF.tab $tab_bank_lockboxes
			SF.click_button_new
			LOCKBOX.set_bank_account $bd_bank_account_bristol_checking_account, $company_merlin_auto_usa
			_wire_number = LOCKBOX.get_unique_number
			LOCKBOX.set_unique_number _wire_number
			LOCKBOX.set_currency $bd_currency_usd , $company_merlin_auto_usa
			LOCKBOX.set_matching_mode _matching_mode
			LOCKBOX.set_discount_gla $bd_gla_account_receivable_control_usd
			LOCKBOX.set_write_off_gla $bd_gla_write_off_us
			LOCKBOX.set_currency_write_off_gla $bd_gla_write_off_us
			LOCKBOX.set_bank_charges_gla $bd_gla_account_receivable_control_usd
			SF.click_button_save
			SF.wait_for_search_button
			_lockbox_number = LOCKBOX.get_bank_lockbox_number
			gen_compare_has_content _lockbox_number , true , "Lockbox created "
			
			#Step 2:Click on New Bank Lockbox Import Definition button and create new definition as below-
			SF.click_button $lockbox_new_import_defination_button
			LOCKBOX.set_import_defination_decimal_seperator _decimal_seperator_period
			LOCKBOX.set_import_defination_thousand_seperator _thousands_seperator_comma
			LOCKBOX.set_import_defination_file_delimiter _file_delimiter_semicolon
			LOCKBOX.set_import_defination_date_format _date_format_dd_mm_yyy
			SF.click_button_save
			SF.wait_for_search_button
			#Validate B.) New import definition should be created successfully.
			_defination_name = LOCKBOX.get_import_defination_decimal_seperator
			_decimal_seperator = LOCKBOX.get_import_defination_decimal_seperator
			_thousands_separator = LOCKBOX.get_import_defination_thousands_sepertor
			_file_delimiter = LOCKBOX.get_import_defination_file_delimeter
			_date_format = LOCKBOX.get_import_defination_date_format
			gen_compare _decimal_seperator, _decimal_seperator_period , "_decimal_seperator as expected"
			gen_compare _thousands_separator, _thousands_seperator_comma , "thousands_separator as expected"
			gen_compare _file_delimiter, _file_delimiter_semicolon , "file_delimiter as expected"
			gen_compare _date_format, _date_format_dd_mm_yyy , "date_format as expected"

			#step 3 Click on manage import mapping and create mapping 
			SF.click_button $lockbox_manage_import_mappings
			SF.wait_for_search_button
			LOCKBOX.set_deposite_date_column_number _deposite_date_col_number
			LOCKBOX.set_amount_column_number _amount_col_number
			LOCKBOX.set_bank_lockbox_num_column_number _bank_lockbox_col_number
			LOCKBOX.set_mapping_check_number_column_number _check_box_col_number
			LOCKBOX.set_remitter_column_number _remitter_col_number
			LOCKBOX.set_type_column_number _type_col_number
			LOCKBOX.set_document_ref_column_number _document_ref_col_number
			SF.click_button_save
			SF.wait_for_search_button	
			#C.) Import mapping should be saved successfully.
			LOCKBOX.click_more
			gen_compare LOCKBOX.get_deposite_date_column_number, _deposite_date_col_number , "deposite_date_col_number as expected"
			gen_compare LOCKBOX.get_amount_column_number, _amount_col_number , "amount_col_number as expected"
			gen_compare LOCKBOX.get_bank_lockbox_num_column_number, _bank_lockbox_col_number , "bank_lockbox_col_number as expected"
			gen_compare LOCKBOX.get_mapping_check_number_column_number, _check_box_col_number , "check_box_col_number as expected"
			gen_compare LOCKBOX.get_remitter_column_number, _remitter_col_number , "remitter_col_number as expected"
			gen_compare LOCKBOX.get_type_column_number, _type_col_number , "type_col_number as expected"
			gen_compare LOCKBOX.get_document_ref_column_number, _document_ref_col_number , "document_ref_col_number as expected"
					
			##Step 4. Goto Lockbox created in Step A and click on New AR Cash Transaction from detail page.
			SF.click_link _lockbox_number
			SF.wait_for_search_button
			SF.click_button $lockbox_new_ar_cash_transation
			_file2_content = _file2_content.gsub("{"+_bank_lockbox_col_number+"}", _wire_number.to_s)
			_file2_content = _file2_content.gsub("{"+_deposite_date_col_number+"}", _date_today)
			_file2_content = _file2_content.gsub("{"+_remitter_col_number+"}", _scr)
			_file2_content = _file2_content.gsub("{"+_check_box_col_number+"}", _check_num2)
			_file2_content = _file2_content.gsub("{"+_document_ref_col_number+"}", _scr_name)
			_file2_content = _file2_content.gsub("{"+_amount_col_number+"}", _num_100_N)
			_file2_content = _file2_content.gsub("{"+_type_col_number+"}", "LBX")
			##write content to file
			gen_create_file file_name, _file2_content
			gen_move_file Dir.pwd + "/" + file_name, Dir.pwd + $upload_file_path + file_name
			LOCKBOX.import_ar_cash_transaction file_name	
           	LOCKBOX.click_button_import
			SF.wait_for_search_button
			SF.wait_for_apex_job		
			
			##get AR cash transaction details 
			_ar_cash_trans_id, _ar_cash_trans_name = LOCKBOX.get_ar_cash_transaction_details _lockbox_number 
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _lockbox_number
			SF.wait_for_search_button
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			_ar_cash_transation_status = LOCKBOX.get_ar_cash_trasaction_status
			gen_compare _ar_cash_transation_status, $bd_document_status_imported , "_ar_cash_transation_status is imported"
			gen_compare_has_content _scr_name , true , "SCRN present in related list"
						
			##Step 5.Once File is imported, click on Create Cash Entry button
			SF.click_button $lockbox_create_cash_entry
			SF.wait_for_search_button
			LOCKBOX.select_cash_enrtry_radio_option $lockbox_cash_entry_for_lbx_only
			SF.click_button $lockbox_create_cash_entry
			SF.wait_for_search_button
			SF.wait_for_apex_job
			
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.click_link _lockbox_number
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			gen_compare LOCKBOX.get_ar_cash_trasaction_status, $bd_document_status_complete , "_ar_cash_transation_status is complete"
			gen_compare LOCKBOX.get_ar_cash_trasaction_type, $lockbox_cash_entry_for_lbx_only , "_ar_cash_transation_status is complete"
			gen_compare LOCKBOX.get_ar_cash_trasaction_no_of_cash_entries , "1" , "no_of_cash_entries correct"
			gen_compare LOCKBOX.get_ar_cash_trasaction_total_of_cash_entries, _num_100_N , "_ar_cash_transation_status is complete"
			
			#Step 6 and validate F -A new cash entry should be created as
			#get Cash entry from AR Transaction 
			_ar_cash_entry_id, _ar_cash_entry_name	= LOCKBOX.get_cash_entry_details_from_ar_cash_transaction _ar_cash_trans_name 
			SF.tab $tab_cash_entries
			SF.select_view $bd_select_view_all
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _ar_cash_entry_name
			SF.wait_for_search_button
			gen_compare _date_today, CE.get_cash_entry_date , "cash_entry_date is as expected"
			gen_compare_has_content $bd_bank_account_bristol_checking_account , true ,  "bank_account_name #{$bd_bank_account_bristol_checking_account} is as expected"
			gen_compare_has_content $bd_account_algernon_partners_co , true ,  "account_name is as expected #{$bd_account_algernon_partners_co}"
			gen_compare _num_100, CE.get_cashentry_value , "cashentry_value is as expected"
			
			#Step 7 Navigate to Lock box created in step 1 and open AR transaction detail page.
			#Click on match button and wait for the matching process to complete and check G
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _lockbox_number
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			SF.click_button $ffa_match
			SF.wait_for_search_button
			SF.click_button $lockbox_yes
			SF.wait_for_search_button
			SF.wait_for_apex_job
			#validate - G.) AR status= Matched, Payment status of SIN = Part Paid
			SF.tab $tab_bank_lockboxes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _lockbox_number
			SF.click_link _ar_cash_trans_name 
			SF.wait_for_search_button
			_ar_cash_transation_status = LOCKBOX.get_ar_cash_trasaction_status
			gen_compare _ar_cash_transation_status, $bd_payment_matched_status , "_ar_cash_transation_status is matched"
			
			SF.tab $tab_sales_credit_notes
			SF.click_button_go
			SF.wait_for_search_button
			SF.click_link _scr_name
			SF.wait_for_search_button
			document_payment_status = SCR.get_document_payment_status
			gen_compare $bd_document_payment_status_part_paid , document_payment_status , "Expected SCRN  payment Status to be #{ $bd_document_payment_status_part_paid} "
			SF.logout
		end			
	end
	
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		SF.tab $tab_ar_cash_transaction
		SF.click_button_go
		FFA.delete_all_record 
		SF.tab $tab_bank_lockboxes
		SF.click_button_go
		FFA.delete_all_record 
		
		#delete CSV file
		gen_remove_file file_name
		gen_end_test "TID020713-Process lock box Cash matching process for SIN and SCR"
	end
end