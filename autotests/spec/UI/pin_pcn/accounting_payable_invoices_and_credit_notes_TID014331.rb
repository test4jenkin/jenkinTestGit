#--------------------------------------------------------------------#
#	TID : TID014331
# 	Pre-Requisite : Org with basedata deployed , 
#	Setup Data: pin_pcn_data.rb
#  	Product Area: Accounting - Payable Invoice and Credit Notes (UI Test)
# 	Story: 26951 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Payable Credit Note extended layout  ", :type => :request do
include_context "login"
include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID014331-UI Test - Accounting - Payable Invoice and Credit Notes"
	end
	
	it "TID014331: To check that admin user can create and update PCR for any company else than selected company." do
		_net_value_120 = "120.00"
		SF.app $accounting
		SF.tab $tab_select_company
		puts "select Merlin Auto Spain Company as current company"
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		puts "Set Extended layout for Payable Credit Notes"
		begin
			SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_system_administrator, $ffa_purchase_credit_note_extended_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_line_item_extended_layout
			SF.edit_extended_layout $ffa_object_payable_credit_note_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_expense_line_item_extended_layout
		
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
			SF.set_button_property_for_extended_layout			
			SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
			SF.set_button_property_for_extended_layout			
		end
		
		gen_start_test "TST019325: Create a new PCR for Merlin Auto GB Company which is not set as current company. "
		begin
			puts "Step 1 to 3: Create new payable credit note for merlin auto GB on extended layout and save it."
			SF.tab $tab_payable_credit_notes
			SF.click_button_new
			SF.wait_for_search_button
			PCREXT.set_company $bdu_company_merlin_auto_gb
			PCREXT.set_account $bdu_account_audi
			PCREXT.set_vendor_credit_note_number "PCRE_213"
			SF.click_button_save
			SF.wait_for_search_button
			_credit_note_currency = PCREXT.get_credit_note_currency
			_credit_note_period = PCREXT.get_credit_note_period_value 
			_payablecredit_note_number = PCREXT.get_credit_note_number
			gen_compare $bdu_company_merlin_auto_gb, PCREXT.get_company_name , "TST019325: Expected Company name for credit note to be " + $bdu_company_merlin_auto_gb
			gen_compare $bdu_document_status_in_progress, PCREXT.get_credit_note_status, "TST019325:Expected New payable credit note to be created successfully with status In progress. " + _payablecredit_note_number
			# Asserting the period and currency of created payable credit note
			PCREXT.click_credit_note_currency 
			gen_include $bdu_company_merlin_auto_gb,AccountingCurrency.get_owner_value ,"Expected owner company of Currency to be " + $bdu_company_merlin_auto_gb
			SF.tab $tab_payable_credit_notes
			SF.select_view $bdu_select_view_ffa_merlin_auto_gb
			SF.click_button_go
			PCR.open_credit_note_detail_page _payablecredit_note_number
			PCREXT.click_on_credit_note_period
			gen_include $bdu_company_merlin_auto_gb,PERIOD.get_owner_company, "Expected owner company of period to be " + $bdu_company_merlin_auto_gb
		end
		
		begin
			puts "Step 4-5: Add new payable credit note expense line item."
			SF.tab $tab_payable_credit_notes
			SF.select_view $bdu_select_view_ffa_merlin_auto_gb
			SF.click_button_go
			PCR.open_credit_note_detail_page _payablecredit_note_number
			PCREXT.click_new_payable_credit_note_expense_line_item_button
			SF.wait_for_search_button
			PCREXT.set_exp_destination_net_value _net_value_120
			PCREXT.set_net_value _net_value_120
			PCREXT.line_item_set_company_name $bdu_company_merlin_auto_gb
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_saving_button_locator
			gen_compare _payablecredit_note_number, PCREXT.line_item_get_payable_credit_note_number , "TST019325: Expected new line item to be created successfully for "+ _payablecredit_note_number
			gen_compare $bdu_company_merlin_auto_gb, PCREXT.get_company_name , "TST019325: Expected Company name for credit note expense line item to be " + $bdu_company_merlin_auto_gb
			PCREXT.click_payable_credit_note_number # clicking on payable credit note number from expense line item shows it is added successfully to payable credit note
			
		end
			
		begin
			puts "Step 6-7: Add new payable credit note line item."
			# Create new payable credit note line item(product)
			PCREXT.click_new_payable_credit_note_line_item_button
			SF.wait_for_search_button
			PCREXT.set_product $bdu_product_auto_com_clutch_kit_1989_dodge_raider
			PCREXT.line_item_set_company_name $bdu_company_merlin_auto_gb
			PCREXT.set_prod_line_destination_unit_price _net_value_120
			#PCREXT.set_net_value _net_value_120
			PCREXT.set_prod_line_destination_quantity 1
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_saving_button_locator
			gen_compare _payablecredit_note_number, PCREXT.line_item_get_payable_credit_note_number , "TST019325: Expected new line item to be created successfully for "+ _payablecredit_note_number
			gen_compare $bdu_company_merlin_auto_gb, PCREXT.get_company_name , "TST019325: Expected Company name for credit note product line item to be " + $bdu_company_merlin_auto_gb
			PCREXT.click_payable_credit_note_number # clicking on payable credit note number from expense line item shows it is added successfully to payable credit note
		end
		gen_end_test "TST019325: Create a new PCR for Merlin Auto GB Company which is not set as current company. "
		
		gen_start_test "TST019326: Update the PCR of Merlin Auto GB Company which is not set as current company."
		begin
			# view PCR created in above steps
			SF.tab $tab_payable_credit_notes
			SF.select_view $bdu_select_view_ffa_merlin_auto_gb
			SF.click_button_go
			PCR.open_credit_note_detail_page _payablecredit_note_number
			SF.click_button_edit
			SF.wait_for_search_button
			PCREXT.set_vendor_credit_note_number "VIN14284"
			SF.click_button_save
			gen_wait_until_object_disappear $ffa_saving_button_locator
			gen_compare "VIN14284" , PCREXT.get_vendor_credit_note_number , "Expected vendor credit note number to be updated with VIN14284 value"
			gen_compare $bdu_document_status_in_progress, PCREXT.get_credit_note_status, "TST019325:Expected New payable credit note to be created successfully with status In progress. " + _payablecredit_note_number
			# Asserting the period and currency of created payable credit note
			PCREXT.click_credit_note_currency 
			gen_include $bdu_company_merlin_auto_gb,AccountingCurrency.get_owner_value ,"Expected owner company of Currency to be " + $bdu_company_merlin_auto_gb
			SF.tab $tab_payable_credit_notes
			SF.select_view $bdu_select_view_ffa_merlin_auto_gb
			SF.click_button_go
			PCR.open_credit_note_detail_page _payablecredit_note_number
			PCREXT.click_on_credit_note_period
			gen_include $bdu_company_merlin_auto_gb,PERIOD.get_owner_company, "Expected owner company of period to be " + $bdu_company_merlin_auto_gb
		
		end
		gen_end_test "TST019326: Update the PCR of Merlin Auto GB Company which is not set as current company."
	end
	
	after :all do
		# Delete Data
		login_user
		FFA.delete_new_data_and_wait
		puts "Reverting extended layout changes for payable credit note"
		SF.edit_extended_layout $ffa_object_payable_credit_note, $ffa_profile_system_administrator, $ffa_purchase_credit_note_layout
		SF.edit_extended_layout $ffa_object_payable_credit_note_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_line_item_layout
		SF.edit_extended_layout $ffa_object_payable_credit_note_expense_line_item, $ffa_profile_system_administrator, $ffa_purchase_credit_note_expense_line_item_layout
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_edit_button
		SF.choose_visualforce_page $ffa_vf_page_coda_payable_credit_note_edit
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_new_button
		SF.choose_visualforce_page $ffa_vf_page_coda_payable_credit_note_new
		SF.object_button_edit $ffa_object_payable_credit_note, $sf_view_button
		SF.choose_visualforce_page $ffa_vf_page_coda_payable_credit_note_view 
		gen_end_test "TID014331-UI Test - Accounting - Payable Invoice and Credit Notes"
	end
end