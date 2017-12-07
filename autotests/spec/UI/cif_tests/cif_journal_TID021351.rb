#--------------------------------------------------------------------#
#   TID : TID021351 
#   Pre-Requisite : Base data should exist on the org.
#   Product Area: CIF
#   How to run : rspec spec/UI/cif_tests/cif_journal_TID021351.rb -fh -o cif_clone.html
#--------------------------------------------------------------------#

describe "TID021351: Verify cloning functionality from CIF view page for Journal", :type => :request do
	_JOURNAL_REFERENCE = 'JRNL_REF'
	_todays_date = Date.today
	_period = _todays_date.strftime("%Y") + "/0" + _todays_date.strftime("%m")
	_journal_description = 'Header Description'
	_line1_description = 'Line 1 Description'
	_line2_description = 'Line 2 Description'
	_line1_expected_values = '1 General Ledger Account Accounts Payable Control - EUR 10.00 VO-STD Purchase Apex EUR Account A4 Paper Line 1 Description Dim 1 EUR Dim 2 EUR 100.00'
	_line2_expected_values = '2 General Ledger Account Accounts Receivable Control - EUR -10.00 VO-STD Purchase Apex EUR Account A4 Paper Line 2 Description Dim 1 EUR Dim 2 EUR -100.00'
		
	
	include_context "login"
	include_context "logout_after_each"
	
    before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		
		_namspace_prefix = ""
		_namspace_prefix += ORG_PREFIX
		
		if(_namspace_prefix != nil && _namspace_prefix != "" )
			_namspace_prefix = _namspace_prefix.gsub! "__", "."
		end	
		
		_create_with_API = "Account acc = [select id, name from Account where MirrorName__c = 'Apex EUR Account'];"
		_create_with_API += "#{_namspace_prefix}CODAAPICommon_10_0.Context context = new #{_namspace_prefix}CODAAPICommon_10_0.Context();"
		_create_with_API += "context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));"
		_create_with_API +=	"List<#{_namspace_prefix}CODAAPIJournalTypes_12_0.Journal> journalList = new List<#{_namspace_prefix}CODAAPIJournalTypes_12_0.Journal>();"
		_create_with_API +=	"#{_namspace_prefix}CODAAPIJournalTypes_12_0.Journal journal = new #{_namspace_prefix}CODAAPIJournalTypes_12_0.Journal();"
		_create_with_API +=	"journal.JournalCurrency = #{_namspace_prefix}CODAAPICommon.getRef(null, 'EUR');"
		_create_with_API +=	"journal.JournalDate = Date.valueOf('#{_todays_date}');"
		_create_with_API +=	"journal.Period = #{_namspace_prefix}CODAAPICommon.getRef(null, '#{_period}');"
		_create_with_API +=	"journal.TypeRef = #{_namspace_prefix}CODAAPIJournalTypes_12_0.enumType.ManualJournal;"
		_create_with_API +=	"journal.Reference = '#{_JOURNAL_REFERENCE}';"
		_create_with_API +=	"journal.JournalDescription = '#{_journal_description}';"
		_create_with_API +=	"journal.JournalStatus = #{_namspace_prefix}CODAAPIJournalTypes_12_0.enumJournalStatus.InProgress;"

		_create_with_API +=	"journal.LineItems = new #{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.JournalLineItems();"
		_create_with_API +=	"journal.LineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.JournalLineItem>();"
		_create_with_API +=	"#{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.JournalLineItem lineItem1 = new #{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.JournalLineItem();"
		_create_with_API +=	"lineItem1.LineTypeRef = #{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.enumLineType.GeneralLedgerAccount;"
		_create_with_API +=	"lineItem1.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null, 'Accounts Payable Control - EUR');"
		_create_with_API +=	"lineItem1.Value = 100;"
		_create_with_API += "lineItem1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null, 'Dim 1 EUR');"
		_create_with_API += "lineItem1.Dimension2 = #{_namspace_prefix}CODAAPICommon.getRef(null, 'Dim 2 EUR');"
		_create_with_API += "lineItem1.TaxAnalysis1 = #{_namspace_prefix}CODAAPICommon.getRef(null, 'VO-STD Purchase');"
		_create_with_API += "lineItem1.AccountAnalysis = #{_namspace_prefix}CODAAPICommon.getRef(acc.Id, null);"
		_create_with_API += "lineItem1.ProductAnalysis = #{_namspace_prefix}CODAAPICommon.getRef(null, 'A4 Paper');"	
		_create_with_API += "lineItem1.LineDescription = '#{_line1_description}';"
		_create_with_API += "lineItem1.TaxValue1 = 10;"
		_create_with_API +=	"journal.LineItems.LineItemList.add(lineItem1);"     

		_create_with_API +=	"#{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.JournalLineItem lineItem2 = new #{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.JournalLineItem();"
		_create_with_API +=	"lineItem2.LineTypeRef = #{_namspace_prefix}CODAAPIJournalLineItemTypes_12_0.enumLineType.GeneralLedgerAccount;"
		_create_with_API +=	"lineItem2.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null, 'Accounts Receivable Control - EUR');"
		_create_with_API +=	"lineItem2.Value = -100;"
		_create_with_API += "lineItem2.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null, 'Dim 1 EUR');"
		_create_with_API +=	"lineItem2.Dimension2 = #{_namspace_prefix}CODAAPICommon.getRef(null, 'Dim 2 EUR');"
		_create_with_API += "lineItem2.TaxAnalysis1 =#{_namspace_prefix}CODAAPICommon.getRef(null, 'VO-STD Purchase');"
		_create_with_API += "lineItem2.AccountAnalysis = #{_namspace_prefix}CODAAPICommon.getRef(acc.Id, null);"
		_create_with_API += "lineItem2.ProductAnalysis = #{_namspace_prefix}CODAAPICommon.getRef(null, 'A4 Paper');"
		_create_with_API += "lineItem2.LineDescription = '#{_line2_description}';"
		_create_with_API += "lineItem2.TaxValue1 = -10;"		
		_create_with_API +=	"journal.LineItems.LineItemList.add(lineItem2);"
		
		_create_with_API +=	"journalList.add(journal);"
		_create_with_API +=	"#{_namspace_prefix}CODAAPIJournal_12_0.BulkCreateJournal(context, journalList);"
        gen_start_test "TID021351: Verify cloning functionality from CIF view page for Journal"
        begin
			SF.app $accounting
			#Create Data
            APEX.execute_commands [_create_with_API]
        end
    end
    
    it "TID021351 : Verify cloning functionality from CIF view page for Journal" do
        begin
			SF.tab $tab_journals
			SF.select_view $bd_select_view_all
            SF.click_button_go
            _journal_number = FFA.get_column_value_in_grid $label_journal_reference, _JOURNAL_REFERENCE, $label_journal_number
            JNL.open_journal_detail_page _journal_number
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			CIF.click_toggle_button
			CIF.click_clone_button
			#Verifying Toast message
			gen_compare $cif_msg_clone_document, CIF.get_header_toast_message, 'Toast message is matched.'
			CIF.wait_for_actions_to_complete $cif_buttons_loading_wait_message
			gen_report_test "TST037209: Verify that toast message is displayed on the newly created cloned Journal"	
			CIF_JNL.click_journal_save_button
			CIF.click_toggle_button
			#Verifying header fields
			CIF_JNL.compare_journal_header_details(_todays_date.strftime("%d/%m/%Y"), _period, $bd_currency_eur, _JOURNAL_REFERENCE, _journal_description, $bd_jnl_type_manual_journal, $bd_document_status_in_progress, '100.00', '-100.00', '0.00')
			gen_report_test "TST037210: Verify that all fields on header are cloned on clicking on Clone button for Journal"
			#Verifying line item fields
			gen_compare _line1_expected_values,CIF_JNL.get_grid_data_row(1),'Journal line item values of line 1 are verified'
			gen_compare _line2_expected_values,CIF_JNL.get_grid_data_row(2),'Journal line item values of line 2 are verified'
			gen_report_test "TST037210: Verify that all fields on Journal lines are cloned on clicking on Clone button for Journal"
			CIF.click_toggle_button
        end
    end
	
    after :all do
        login_user
		
		#Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
        gen_end_test "TID021351: Verify cloning functionality from CIF view page for Journal"    
    end
end