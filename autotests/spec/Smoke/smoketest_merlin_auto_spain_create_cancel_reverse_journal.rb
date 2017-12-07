#--------------------------------------------------------------------#
#	TID  :  TID013437
#	Pre-Requisit: execute smoketest_data_setup.rb to setup data for smoke tests
#	Product Area:	Accounting - Journals - Smoke Test
#	Story: 23694
#--------------------------------------------------------------------#
describe "Smoke Test for Journals", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		gen_start_test "TID013437"
		#Hold Base Data
		FFA.hold_base_data_and_wait
	end
	it "TID013437 : create a journal and amend it" do
	
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		_journal_amount_100 = "100.00"
		_journal_amount_n100 = "-100.00"
		_journal_amount_n50 = "-50.00"
		_line_1 = 1
		_line_2 = 2
		_line_3 = 3
		_line_4 = 4
		_line_5 = 5
		_line_6 = 6
		_line_7 = 7
		_journal_debit_100 = "100.00"
		_journal_credit_n100 = "-100.00"
	
		gen_start_test "Test Step ID TST017184 : Create a journal containing all line types excluding intercompany and then amend it."
		begin
			# TST017184 : 1.1
			begin
				SF.tab $tab_journals
				SF.click_button_new
				
				JNL.select_journal_line_type $bd_jnl_line_type_account_customer
				JNL.select_journal_line_value $bd_account_pyramid_construction_inc
				JNL.add_line _line_1 , $bd_gla_write_off_uk  , _journal_amount_100 , nil , nil ,nil, nil,nil
				JNL.add_line_analysis_details _line_1,"10.00", nil,nil
				
				JNL.select_journal_line_type $bd_jnl_line_type_account_vendor
				JNL.select_journal_line_value $bd_account_algernon_partners_co
				JNL.add_line _line_2 , $bd_gla_write_off_uk  , _journal_amount_n50 , nil , nil ,nil, nil,nil
				
				JNL.select_journal_line_type $bd_jnl_line_type_tax_code
				JNL.select_journal_line_value $bd_tax_code_vo_s
				JNL.add_line _line_3 , $bd_gla_vat_output  , _journal_amount_n50 , nil , nil ,nil, nil,nil
				JNL.add_line_analysis_details _line_3,nil,"-6.00", nil

				JNL.select_journal_line_type $bd_jnl_line_type_product_sales
				JNL.select_journal_line_value $bd_product_sla_gold
				JNL.add_line _line_4 , $bd_gla_sales_parts  , _journal_amount_100 , nil , nil ,nil, nil,nil
				JNL.add_line_analysis_details _line_4,"6.00", nil,nil

				JNL.select_journal_line_type $bd_jnl_line_type_product_purchases
				JNL.select_journal_line_value $bd_product_sla_silver
				JNL.add_line _line_5 , $bd_gla_sales_parts  , _journal_amount_n100 , nil , nil ,nil, nil,nil
				
				JNL.select_journal_line_type $bd_jnl_line_type_bank_account
				JNL.select_journal_line_value $bd_bank_account_santander_current_account
				JNL.add_line _line_6 , $bd_gla_write_off_us  , _journal_amount_100 , nil , nil ,nil, nil,nil
				JNL.add_line_analysis_details _line_6,nil,nil, $bd_account_apex_eur_account
				
				JNL.select_journal_line_type $bd_jnl_line_type_gla
				JNL.select_journal_line_value $bd_gla_vat_input
				JNL.add_line _line_7 , nil  , _journal_amount_n100 , nil , nil ,nil, nil,nil
				
				gen_compare "16.00", JNL.get_journal_tax_total , "Expected Journal Tax Total to be 16.00"
				gen_compare "-6.00" , JNL.get_journal_taxable_value_total , "Expected Journal Taxable Value Total to be -6.00"
				FFA.click_save_post
				gen_compare $bd_jnl_type_manual_journal , JNL.get_journal_type , "Expected Journal type to be Manual Journal"
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
				gen_compare_objval_not_null JNL.get_journal_transaction_number, true, "Expected Transaction number should be generated for posted journal."
			end
		
			#"TST017184 : 1.2"
			begin
				SF.click_button $ffa_amend_document_button
				JNL.set_journal_reference "Sprint "+Date.today.to_s
				SF.click_button_save
				_expected_ref_no = "Sprint "+Date.today.to_s
				gen_compare _expected_ref_no , JNL.get_journal_reference , "Expected Journal reference to be updated with value"+_expected_ref_no
			end
		end
		
		gen_start_test "Test Step TST017185 : Cancel the journal with override currency and amend it."
		begin
			# TST017185 : 1.1
			begin
				SF.tab $tab_journals
				SF.click_button_new
				JNL.select_journal_line_type $bd_jnl_line_type_product_sales
				JNL.select_journal_line_value $bd_product_sla_gold
				JNL.add_line _line_1 , $bd_gla_sales_parts  , _journal_amount_100 , nil , nil ,nil, nil,nil
				
				JNL.select_journal_line_type $bd_jnl_line_type_product_purchases
				JNL.select_journal_line_value $bd_product_sla_silver
				JNL.add_line _line_2 , $bd_gla_sales_parts  , _journal_amount_n100 , nil , nil ,nil, nil,nil
				
				SF.click_button_save
				gen_compare $bd_document_status_in_progress , JNL.get_journal_status , "Expected Journal Status to be In Progress"
			end
				
			# TST017185 : 1.2
			begin
				SF.click_button_edit
				JNL.header_click_override_currency_values
				page.has_css?($jnl_journal_override_currency_acc_lookup)
				FFA.select_currency_from_lookup $jnl_journal_override_currency_acc_lookup, $bd_currency_usd, $company_merlin_auto_spain
				JNL.set_total_override_debit_value _line_1, "50"
				JNL.save_override_curr_values
				FFA.click_save_post
				gen_compare $bd_jnl_type_manual_journal , JNL.get_journal_type , "Expected Journal type to be Manual Journal"
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
				gen_compare_objval_not_null JNL.get_journal_transaction_number, true, "Expected Transaction number should be generated for posted journal."
			end
			
			# TST017185 : 1.3
			begin
				SF.click_button $jnl_cancel_journal
				FFA.click_save_post
				gen_compare $bd_jnl_type_cancelling_journal , JNL.get_journal_type , "Expected Journal type to be Cancelling Journal"
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
				gen_compare_objval_not_null JNL.get_journal_transaction_number, true, "Expected Transaction number should be generated for posted journal."
			end
			
			# TST017185 : 1.4
			begin
				SF.click_button $ffa_amend_document_button
				_expected_ref_no = "Sprint "+Date.today.to_s
				JNL.set_journal_reference _expected_ref_no
				SF.click_button_save
				gen_compare _expected_ref_no , JNL.get_journal_reference , "Expected Journal reference to be updated with value"+_expected_ref_no
			end
		end

		gen_start_test "Test Step TST017186 : Reverse a journal with override currency at line level and cancel the reversal process"
		begin
			# TST017186 : 1.1
			begin
				delete = "delete [select id from #{ORG_PREFIX}codaAccountingSettings__c ];"
				APEX.execute_commands [delete]
				custom_setting = "#{ORG_PREFIX}codaAccountingSettings__c setting = new #{ORG_PREFIX}codaAccountingSettings__c(#{ORG_PREFIX}OverrideCurrencyValuesonJournalLine__c = true);"
				custom_setting += "INSERT setting;"
				APEX.execute_commands [custom_setting]
			end
			
			# TST017186 : 1.2
			begin
				SF.login_as_user $bd_user_accountant_alias
				SF.app $accounting
				SF.tab $tab_select_company
				FFA.select_company [$company_merlin_auto_spain] ,true
				SF.tab $tab_journals
				SF.click_button_new
				JNL.select_journal_line_type $bd_jnl_line_type_product_sales
				JNL.select_journal_line_value $bd_product_sla_gold
				JNL.add_line _line_1 , $bd_gla_sales_parts  , _journal_amount_100 , nil , nil ,nil, nil,nil

				JNL.select_journal_line_type $bd_jnl_line_type_product_purchases
				JNL.select_journal_line_value $bd_product_sla_silver
				JNL.add_line _line_2 , $bd_gla_sales_parts  , _journal_amount_n100 , nil , nil ,nil, nil,nil
				#Reverse the journal
				SF.click_button $ffa_reverse_button
				current_period = FFA.get_current_period
				JNL.set_reverse_period current_period,$company_merlin_auto_spain
				SF.click_button $ffa_reverse_button #This step is to confirm the reverse process for journal
				gen_compare $bd_jnl_type_manual_journal , JNL.get_journal_type , "Expected Journal type to be Manual Journal"
				gen_compare $bd_document_status_in_progress , JNL.get_journal_status , "Expected Journal Status to be In Progress"
			end
			
			# TST017186 : 1.3
			begin
				SF.click_button_edit
				JNL.line_click_override_currency_values _line_1
				JNL.set_override_curr_values_dual_usd "100"
				JNL.save_line_override_curr_values
				JNL.line_click_override_currency_values _line_2
				JNL.set_override_curr_values_dual_usd "-100"
				JNL.save_line_override_curr_values
				FFA.click_save_post
				gen_compare $bd_jnl_type_manual_journal , JNL.get_journal_type , "Expected Journal type to be Manual Journal"
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
				gen_compare _journal_credit_n100 , JNL.get_journal_credits , "Expected Credits should be generated as #{_journal_credit_n100}"
				gen_compare _journal_debit_100 , JNL.get_journal_debits , "Expected Debits should be generated as #{_journal_debit_100}"
				gen_compare "0.00" , JNL.get_journal_total , "Expected Total should be generated as 0.00"
				gen_compare_objval_not_null JNL.get_journal_transaction_number, true, "Expected Transaction number should be generated for posted journal."
			end
			
			# TST017186 : 1.4
			begin
				SF.tab $tab_journals
				SF.select_view $bd_select_view_all
				SF.click_button_go
				_journal_number = FFA.get_column_value_in_grid $label_journal_type , $bd_jnl_type_reversing_journal , $label_journal_number
				JNL.open_journal_detail_page _journal_number
				FFA.click_post
				gen_compare $bd_jnl_type_reversing_journal , JNL.get_journal_type , "Expected Journal type to be Reversing Journal"
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
				gen_compare _journal_credit_n100 , JNL.get_journal_credits , "Expected Credits should be generated as #{_journal_credit_n100}"
				gen_compare _journal_debit_100 , JNL.get_journal_debits , "Expected Debits should be generated as #{_journal_debit_100}"
				gen_compare "0.00" , JNL.get_journal_total , "Expected Total should be generated as 0.00"
				gen_compare_objval_not_null JNL.get_journal_transaction_number, true, "Expected Transaction number should be generated for posted journal."
			end
			
			# TST017186 : 1.5
			begin
				SF.click_button $jnl_cancel_journal
				FFA.click_save_post
				gen_compare $bd_jnl_type_cancelling_journal , JNL.get_journal_type , "Expected Journal type to be Cancelling Journal"
				gen_compare $bd_document_status_complete , JNL.get_journal_status , "Expected Journal Status to be Complete"
				gen_compare_objval_not_null JNL.get_journal_transaction_number, true, "Expected Transaction number should be generated for posted journal."
			end
		end
	end
	after :all do
		login_user
		puts "Revert custom setting"
		# Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID013437"
		SF.logout 
	end
end