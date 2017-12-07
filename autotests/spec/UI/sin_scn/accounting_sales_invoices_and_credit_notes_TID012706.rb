#--------------------------------------------------------------------#
#	TID : TID012706
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Sales Invoices & Credit Notes (UI Test)
# 	Story: 27096 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Sales Invoices & Credit Notes", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID012706 : Accounting - Sales Invoices & Credit Notes UI Test"
	end
	
	it "TID012706 : Verify the transaction details after save &post" do
		gen_start_test "TID012706 : Verify the transaction details after save &post"
		
		_quantity_99 = "999999999999.999999"
		_unit_price_74 = "74.5"
		_total_87_537 = "87,537,500,000,000.00"
		_home_debits_109 = "109,421,875,000,000.00"
		_home_credits_n109 = "-109,421,875,000,000.00"
		_home_value_total_0 = "0.00"
		_home_value_109 = "109,421,875,000,000.00"
		_home_tax_total_16 = "16,296,875,000,000.00"
		_home_value_93 = "93,125,000,000,000.00"
		_home_value_16 = "16,296,875,000,000.00"
		_home_taxable_value_93 = "93,125,000,000,000.00"
		_home_tax_total_0 = "0.00"
		
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true	
		
		puts "Additional data required to execute TID012706"
		begin
			# Set extended layout for sales invoice
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.set_button_property_for_extended_layout
			
			# Set extended layout for sales credit note
			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout
		end
		
		gen_start_test "TST016347 : Verify the transaction details of sales invoice having quantity with range Number(12,6)"
		begin
			SF.tab $tab_sales_invoices
			SF.click_button_new
			SINX.set_company $company_merlin_auto_spain
			SINX.set_account $bdu_account_cambridge_auto
			SF.click_button_save
			_invoice_number = SINX.get_invoice_number
			SINX.click_new_sales_invoice_line_items_button
			SINX.set_product_name $bdu_product_auto1_com_clutch_kit_1989_dodge_raider
			SINX.set_product_quantity _quantity_99
			SINX.set_unit_price_for_line _unit_price_74
			SINX.set_tax_code $bdu_tax_code_vo_std_sales
			SF.click_button_save
			SF.click_link _invoice_number
			SF.wait_for_search_button
			FFA.click_post
			SINX.click_post_invoice
			SINX.click_transaction_number
			
			# verify Account line summary details
			gen_compare _total_87_537, TRANX.get_account_total, "Expected account total to be #{_total_87_537}"
			gen_compare _total_87_537, TRANX.get_account_outstanding_total, "Expected account outstanding total to be #{_total_87_537}"
			gen_compare _total_87_537, TRANX.get_document_total, "Expected document total to be #{_total_87_537}"
			gen_compare _total_87_537, TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be #{_total_87_537}"
			gen_compare $bdu_account_cambridge_auto, TRANX.get_account_value, "Expected account to be #{$bdu_account_cambridge_auto}"
			
			# Verify Transaction details :
			gen_compare _home_debits_109, TRANX.get_home_debits, "Expected home debits total to be #{_home_debits_109}"
			gen_compare _home_credits_n109, TRANX.get_home_credits_value, "Expected home credits total to be #{_home_credits_n109}"
			gen_compare _home_value_total_0, TRANX.get_home_value_total, "Expected home value total to be #{_home_value_total_0}"
			
			# Verify Transaction line items values : Line Type: Account
			_home_value_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_home_value_label
			gen_compare _home_value_109, _home_value_account_line_type, "Expected home value of account line type is #{_home_value_109}"
			_home_tax_total_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_home_tax_total_label
			gen_compare _home_tax_total_16, _home_tax_total_account_line_type, "Expected home tax total of account line type is #{_home_tax_total_16}"
			_home_taxable_value_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_home_taxable_value_label
			gen_compare "", _home_taxable_value_account_line_type, "Expected home taxable value of account line type is empty"
			_general_ledger_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_general_ledger_account_label
			gen_compare $bdu_gla_account_receivable_control_usd, _general_ledger_account_line_type, "Expected home taxable value of account line type is #{$bdu_gla_account_receivable_control_usd}"
		
			# Verify Transaction line items values : Line Type: Analysis 
			_home_value_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_home_value_label
			gen_compare "-#{_home_value_93}", _home_value_analysis_line_type, "Expected home value of analysis line type is -#{_home_value_93}"
			_home_tax_total_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_home_tax_total_label
			gen_compare "-#{_home_tax_total_16}", _home_tax_total_analysis_line_type, "Expected home tax total of analysis line type is -#{_home_tax_total_16}"
			_home_taxable_value_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_home_taxable_value_label
			gen_compare "", _home_taxable_value_analysis_line_type, "Expected home taxable value of analysis line type is empty"
			_general_ledger_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_general_ledger_account_label
			gen_compare $bdu_gla_sales_parts, _general_ledger_analysis_line_type, "Expected home taxable value of analysis line type is #{$bdu_gla_sales_parts}"

			# Verify Transaction line items values : Line Type: Tax 
			_home_value_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_home_value_label
			gen_compare "-#{_home_value_16}", _home_value_tax_line_type, "Expected home value of tax line type is -#{_home_value_16}"
			_home_tax_total_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_home_tax_total_label
			gen_compare _home_tax_total_0, _home_tax_total_tax_line_type, "Expected home tax total of tax line type is #{_home_tax_total_0}"
			_home_taxable_value_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_home_taxable_value_label
			gen_compare "-#{_home_taxable_value_93}", _home_taxable_value_tax_line_type, "Expected home taxable value of tax line type is -#{_home_taxable_value_93}"
			_general_ledger_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_general_ledger_account_label
			gen_compare $bdu_gla_vat_output, _general_ledger_tax_line_type, "Expected home taxable value of tax line type is #{$bdu_gla_vat_output}"
		end
		
		gen_start_test "TST016348 : Verify the transaction details of sales credit note having quantity with range Number(12,6)."
		begin
			SF.tab $tab_sales_credit_notes
			SF.click_button_new
			SCRX.set_account $bdu_account_cambridge_auto
			SF.click_button_save
			_credit_note_number = SCRX.get_credit_note_number
			SCRX.click_new_sales_credit_note_line_items_button
			SCRX.set_product $bdu_product_auto1_com_clutch_kit_1989_dodge_raider
			SCRX.set_quantity _quantity_99
			SCRX.set_unit_price _unit_price_74
			SCRX.set_tax_code $bdu_tax_code_vo_std_sales
			SF.click_button_save
			SF.click_link _credit_note_number
			FFA.click_post
			SF.click_button $ffa_continue
			SCRX.click_transaction_number
			
			# Verify Transaction details :
			gen_compare _home_debits_109, TRANX.get_home_debits, "Expected home debits total to be #{_home_debits_109}"
			gen_compare _home_credits_n109, TRANX.get_home_credits_value, "Expected home credits total to be #{_home_credits_n109}"
			gen_compare _home_value_total_0, TRANX.get_home_value_total, "Expected home value total to be #{_home_value_total_0}"
			
			# verify Account line summary details
			gen_compare "-#{_total_87_537}", TRANX.get_account_total, "Expected account total to be -#{_total_87_537}"
			gen_compare "-#{_total_87_537}", TRANX.get_account_outstanding_total, "Expected account outstanding total to be -#{_total_87_537}"
			gen_compare "-#{_total_87_537}", TRANX.get_document_total, "Expected document total to be -#{_total_87_537}"
			gen_compare "-#{_total_87_537}", TRANX.get_document_outstanding_total_value, "Expected document outstanding total to be -#{_total_87_537}"
			gen_compare $bdu_account_cambridge_auto, TRANX.get_account_value, "Expected account to be #{$bdu_account_cambridge_auto}"
			
			# Verify Transaction line items values : Line Type: Account
			_home_value_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_home_value_label
			gen_compare "-#{_home_value_109}", _home_value_account_line_type, "Expected home value of account line type is -#{_home_value_109}"
			_home_tax_total_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_home_tax_total_label
			gen_compare "-#{_home_tax_total_16}", _home_tax_total_account_line_type, "Expected home tax total of account line type is -#{_home_tax_total_16}"
			_home_taxable_value_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_home_taxable_value_label
			gen_compare "", _home_taxable_value_account_line_type, "Expected home taxable value of account line type is empty"
			_general_ledger_account_line_type = TRANX.get_line_item_data $tranx_account_label , $tranx_general_ledger_account_label
			gen_compare $bdu_gla_account_receivable_control_usd, _general_ledger_account_line_type, "Expected home taxable value of account line type is #{$bdu_gla_account_receivable_control_usd}"
		
			# Verify Transaction line items values : Line Type: Analysis 
			_home_value_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_home_value_label
			gen_compare _home_value_93, _home_value_analysis_line_type, "Expected home value of analysis line type is #{_home_value_93}"
			_home_tax_total_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_home_tax_total_label
			gen_compare _home_tax_total_16, _home_tax_total_analysis_line_type, "Expected home tax total of analysis line type is #{_home_tax_total_16}"
			_home_taxable_value_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_home_taxable_value_label
			gen_compare "", _home_taxable_value_analysis_line_type, "Expected home taxable value of analysis line type is empty"
			_general_ledger_analysis_line_type = TRANX.get_line_item_data $tranx_analysis_label , $tranx_general_ledger_account_label
			gen_compare $bdu_gla_sales_parts, _general_ledger_analysis_line_type, "Expected home taxable value of analysis line type is #{$bdu_gla_sales_parts}"

			# Verify Transaction line items values : Line Type: Tax 
			_home_value_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_home_value_label
			gen_compare _home_value_16, _home_value_tax_line_type, "Expected home value of tax line type is #{_home_value_16}"
			_home_tax_total_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_home_tax_total_label
			gen_compare _home_tax_total_0, _home_tax_total_tax_line_type, "Expected home tax total of tax line type is #{_home_tax_total_0}"
			_home_taxable_value_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_home_taxable_value_label
			gen_compare _home_taxable_value_93, _home_taxable_value_tax_line_type, "Expected home taxable value of tax line type is #{_home_taxable_value_93}"
			_general_ledger_tax_line_type = TRANX.get_line_item_data $tranx_tax_label , $tranx_general_ledger_account_label
			gen_compare $bdu_gla_vat_output, _general_ledger_tax_line_type, "Expected home taxable value of tax line type is #{$bdu_gla_vat_output}"
		end
		gen_end_test "TID012706 : Verify the transaction details after save &post"
	end
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		puts "Revert additional data created for TID012706"
		begin
			SF.edit_extended_layout $ffa_object_sales_invoice, $ffa_profile_system_administrator, $ffa_sales_invoice_normal_layout
			SF.object_button_edit $ffa_object_sales_invoice, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_edit
			SF.object_button_edit $ffa_object_sales_invoice, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_new
			SF.object_button_edit $ffa_object_sales_invoice, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_invoice_view

			SF.edit_extended_layout $ffa_object_sales_credit_note, $ffa_profile_system_administrator, $ffa_sales_credit_note_normal_layout
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_edit_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_edit
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_new_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_new
			SF.object_button_edit $ffa_object_sales_credit_note, $sf_view_button
			SF.choose_visualforce_page $ffa_vf_page_coda_creditnote_view
			SF.logout
		end
		gen_end_test "TID012706 : Accounting - Sales Invoices & Credit Notes UI Test"
	end
end