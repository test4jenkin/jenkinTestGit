#--------------------------------------------------------------------#
#	TID : TID014332
# 	Pre-Requisite : Org with basedata deployed 
#	Setup Data: pin_pcn_data.rb
#  	Product Area: Accounting - Payable Invoice and Credit Notes (UI Test)
# 	Story: 26951 
#--------------------------------------------------------------------#


describe "UI Test - Accounting - Payable Invoice  extended layout  ", :type => :request do
include_context "login"

	_name_space_name= ORG_PREFIX.gsub("__", ".").sub(" ","") 
	include_context "logout_after_each"
	_expected_error_message = "Period: You must enter a period that belongs to the current company. Object validation has failed. Period Field: You must enter a period that belongs to the current company."

	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID014332-UI Test - Accounting - Payable Invoice and Credit Notes"
	end
	
	it "TID014332: To check that admin user can create and update PCR for any company else than selected company." do
		_net_value_120 = "120.00"
		
		SF.app $accounting
		SF.tab $tab_select_company
		puts "select Merlin Auto Spain Company as currenct company"
		FFA.select_company [$company_merlin_auto_spain] ,true
		
		puts "Set Extended layout for Payable Credit Note. "
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
		gen_start_test "TST019327: Create and post PCR for Merlin Auto GB Company which is not set as current company."
		begin
			puts "Step 1 to 3: Create new payable credit note for merlin auto GB on extended layout and save it."
			SF.tab $tab_payable_credit_notes
			SF.click_button_new
			SF.wait_for_search_button
			PCREXT.set_company $bdu_company_merlin_auto_gb
			PCREXT.set_account $bdu_account_audi
			PCREXT.set_vendor_credit_note_number "PCRE213"
			SF.click_button_save
			SF.wait_for_search_button
			_credit_note_currency = PCREXT.get_credit_note_currency
			_credit_note_period = PCREXT.get_credit_note_period_value 
			_payablecredit_note_number = PCREXT.get_credit_note_number
		end
		
		begin
			puts "Step 4-5: Add new payable credit note expense line item."
			PCREXT.click_new_payable_credit_note_expense_line_item_button
			SF.wait_for_search_button
			PCREXT.set_net_value _net_value_120
			PCREXT.line_item_set_company_name $bdu_company_merlin_auto_gb
			SF.click_button_save
			gen_compare _payablecredit_note_number, PCREXT.line_item_get_payable_credit_note_number , "TST019327	: Expected new line item to be created successfully for "+ _payablecredit_note_number
			gen_compare $bdu_company_merlin_auto_gb, PCREXT.get_company_name , "TST019327	: Expected Company name for credit note expense line item to be " + $bdu_company_merlin_auto_gb
			PCREXT.click_payable_credit_note_number # clicking on payable credit note number from expense line item shows it is added successfully to payable credit note	
		end
		
		begin
			puts "Step-6: Post the payable credit note. "
			FFA.click_post
			FFA.click_post # Confirm the post operation
			gen_wait_until_object $page_vf_message_text
			gen_include _expected_error_message, PCREXT.get_error_message_on_post, "Expected Following error message should be displayed : #{_expected_error_message}" 
		end
		gen_end_test "TST019327: Create and post PCR for Merlin Auto GB Company which is not set as current company."
		
		gen_start_test "TST019328: Post the PCT using API scripts."
		begin
			post_payable_credit_note_script = [ "#{ORG_PREFIX}codaCompany__c comp = [select Id, Name from #{ORG_PREFIX}codaCompany__c where Name = 'Merlin Auto GB'];#{_name_space_name}CODAAPICommon_7_0.Context context = new #{_name_space_name}CODAAPICommon_7_0.Context();context.CompanyName = comp.Name; context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));#{_name_space_name}CODAAPICommon.Reference pinvrefer = #{_name_space_name}CodaAPICommon.getRef(null,'"+_payablecredit_note_number+"');#{_name_space_name}CODAAPIPurchaseCreditNote_7_0.PostPurchaseCreditNote(context, pinvrefer);"]
			APEX.execute_commands post_payable_credit_note_script 
			
			SF.tab $tab_payable_credit_notes
			SF.select_view $bdu_select_view_ffa_merlin_auto_gb
			SF.click_button_go
			PCR.open_credit_note_detail_page _payablecredit_note_number
			gen_compare $bdu_document_status_complete,PCREXT.get_credit_note_status, "TST019328: Expected payable credit note status to be complete. "
		end
		gen_end_test "TST019328: Post the PCT using API scripts."
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
		gen_end_test "TID014332-UI Test - Accounting - Payable Invoice and Credit Notes"
	end
end

