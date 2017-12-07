#--------------------------------------------------------------------#
#	TID : TID021377	
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Allocations(UI Test)
#--------------------------------------------------------------------#

describe "TID021377 : Verify the Import CSV and Attachment functionality for Statistical Basis", :type => :request do
	_csv_file_name = "StatisticalBases.csv"
	_csv_file_name_2 = "SmokeTestStatement.csv"
	_document_list_column_name = "Name"
	_statistical_basis_name = "Test statistical basis"
	_statistical_basis_name_2 = "Test statistical basis 2"
	_statistical_basis_name_3 = "Test statistical basis 3"
	_statistical_basis_date = Date.today
	_statistical_basis_description = "TID021377-Statistical Value"
	_statistical_basis_title = "Statistical Bases"
	_statistical_basis_period = FFA.get_period_by_date _statistical_basis_date
	_company_column = "Company"
	_period_column = "Period"
	line_content_1 = [$company_merlin_auto_spain, $bd_gla_apexaccgla001, $bd_dim1_eur, $bd_dim2_eur, $bd_dim3_eur, $bd_dim4_eur, '20']
	line_content_2 = [$company_merlin_auto_spain, $bd_gla_sales_parts, $bd_dim1_usd, $bd_dim2_usd, $bd_dim3_usd, $bd_dim4_usd, '20']
		
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		gen_start_test "TID021377 : Verify the Import CSV and Attachment functionality for Statistical Basis"
		FFA.hold_base_data_and_wait
		
		script = "List<#{ORG_PREFIX}codaCompany__c> companyID = [SELECT Id FROM #{ORG_PREFIX}codaCompany__c WHERE Name = 'Merlin Auto Spain'];"
		script += "List<#{ORG_PREFIX}codaGeneralLedgerAccount__c> glaIds = [SELECT Id FROM #{ORG_PREFIX}codaGeneralLedgerAccount__c WHERE Name IN ('APEXACCGLA001','Sales - Parts') ORDER BY Name];"
		script += "List<#{ORG_PREFIX}codaDimension1__c> dim1Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension1__c WHERE Name IN ('Dim 1 USD','Dim 1 EUR') ORDER BY Name];"
		script += "List<#{ORG_PREFIX}codaDimension2__c> dim2Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension2__c WHERE Name IN ('Dim 2 USD','Dim 2 EUR') ORDER BY Name];"
		script += "List<#{ORG_PREFIX}codaDimension3__c> dim3Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension3__c WHERE Name IN ('Dim 3 USD','Dim 3 EUR') ORDER BY Name];"
		script += "List<#{ORG_PREFIX}codaDimension4__c> dim4Ids = [SELECT Id FROM #{ORG_PREFIX}codaDimension4__c WHERE Name IN ('Dim 4 USD','Dim 4 EUR') ORDER BY Name];"
		script += "string header = '#{ORG_PREFIX}Company__c,#{ORG_PREFIX}GeneralLedgerAccount__c,#{ORG_PREFIX}Dimension1__c,#{ORG_PREFIX}Dimension2__c,#{ORG_PREFIX}Dimension3__c,#{ORG_PREFIX}Dimension4__c,#{ORG_PREFIX}Value__c\\n';"
		script += "string finalstr = header ;"
		script += "for(Integer i = 0 ; i < 2; i++)"
		script += "{"
		script += "String recordString = companyID[0].Id + ',' + glaIds[i].Id + ',' + dim1Ids[i].Id + ',' + dim2Ids[i].Id + ',' + dim3Ids[i].Id + ',' + dim4Ids[i].Id + ',' + 20 + '\\n';"
		script += "finalstr = finalstr + recordString;"
		script += "}"
		script += "Blob txtcsv = Blob.valueOf(finalstr);"
		script += "Document doc = new Document();"
		script += "doc.Name ='#{_csv_file_name}';"
		script += "doc.Body = txtcsv;"
		script += "doc.Type = 'csv';"
		script += "doc.FolderId = Userinfo.getUserId();"
		script += "insert doc;"
		
		APEX.execute_commands [script]
	end
	
	it "TID021377 : Import CSV and Attachment functionality for Statistical Basis" do

		SF.logout
		gen_switch_to_driver $driver_firefox , FIREFOX_PROFILE1
		login_user
		SF.app $accounting
		SF.tab $tab_documents
		Document.open_document_folder 'My Personal Documents'
		Document.click_view_link_on_document_list_grid _csv_file_name 
		
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_spain],true
		
		begin
			gen_start_test "TST037349: Verify that user can add Statistical Value lines using Import CSV"

			SF.tab $tab_statistical_value
			SF.click_button_new
			###Step 2 - Import CSV###
			SB.set_statistical_basis_name _statistical_basis_name
			SB.set_description _statistical_basis_description
			SB.set_unit_of_measure $sb_uom_picklist_people_label
			SB.set_date _statistical_basis_date	
			SB.import_csv_file _csv_file_name
			SB.show_gla_column
			SB.delete_line 3
			SB.click_button $sb_save_button
			SB.assert_total_value 40
			SB.assert_line_with_gla true, 1, line_content_1
			SB.assert_line_with_gla true, 2, line_content_2
			
			gen_end_test "TST037349: Verify that user can add Statistical Value lines using Import CSV"
			gen_start_test "TST037350: Verify that user can add Attachment from View Page"
			
			SB.click_button $sb_open_attachment_button
			SB.attach_file_in_attachment_popup _csv_file_name
			gen_compare "1", SB.get_attachment_count, 'Expected Attachment count is 1'
			
			SB.click_button $sb_open_attachment_button
			SB.attach_file_in_attachment_popup _csv_file_name_2
			gen_compare "2", SB.get_attachment_count, 'Expected Attachment count is 2'
			gen_end_test "TST037350: Verify that user can add Attachment from View Page"
			gen_start_test "TST037352: Verify that user can delete attachment from Attachment popup"
			
			SB.click_button $sb_open_attachment_button
			SB.delete_attachment_in_attachment_popup _csv_file_name
			SB.delete_attachment_in_attachment_popup _csv_file_name_2
			
			SB.click_close_button_in_attachment_popup
			gen_compare '0', SB.get_attachment_count, 'Expected Attachment count is 0'
			gen_end_test "TST037352: Verify that user can delete attachment from Attachment popup"
		end
			
		begin
			gen_start_test "TST037353: Verify that company column in grid gets hidden upon selecting company in Header"
			SF.tab $tab_statistical_value
			SF.click_button_new
			SB.set_statistical_basis_name _statistical_basis_name_2
			SB.set_description _statistical_basis_description
			SB.set_date _statistical_basis_date			
			SB.set_unit_of_measure $sb_uom_picklist_people_label
			SB.set_company $company_merlin_auto_gb
			SB.set_period _statistical_basis_period
			gen_compare false,SB.is_company_column_present?,'Company Column is Hidden in the grid'
			SB.set_statistical_basis_line_gla 1,$bd_gla_account_receivable_control_eur
			SB.set_statistical_basis_line_dimension1 1,$bd_dim1_eur
			SB.set_statistical_basis_line_dimension2 1,$bd_dim2_eur
			SB.set_statistical_basis_line_dimension3 1,$bd_dim3_eur
			SB.set_statistical_basis_line_dimension4 1,$bd_dim4_eur
			SB.set_statistical_basis_line_value 1, 250
			SB.set_line_without_company true, 2, [$bd_gla_account_receivable_control_usd,'',$bd_dim2_usd,'','',200]
			SB.set_company nil
			gen_compare true,SB.is_company_column_present?,'Company Column is visible in the grid'
			SB.set_statistical_basis_line_company 1,$company_merlin_auto_gb
			SB.click_button $sb_save_button
			SB.assert_total_value 450
			gen_end_test "TST037353: Verify that company column in grid gets hidden upon selecting company in Header"
			
			gen_start_test "TST037354: Verify that company column in Header gets disabled upon selecting company in grid"
			SF.tab $tab_statistical_value
			SF.click_button_new
			SB.set_statistical_basis_name _statistical_basis_name_3
			SB.set_description _statistical_basis_description
			SB.set_date _statistical_basis_date			
			SB.set_unit_of_measure $sb_uom_picklist_people_label
			
			SB.set_statistical_basis_line_company 1,$company_merlin_auto_gb
			SB.set_statistical_basis_line_dimension1 1,''
			gen_compare false ,SB.is_field_enabled?(_company_column),'Company field in the Header is disabled'
			gen_compare false ,SB.is_field_enabled?(_period_column),'Period field in the Header is disabled'
			SB.set_statistical_basis_line_dimension1 1,$bd_dim1_eur
			SB.set_statistical_basis_line_dimension2 1,$bd_dim2_eur
			SB.set_statistical_basis_line_dimension3 1,$bd_dim3_eur
			SB.set_statistical_basis_line_dimension4 1,$bd_dim4_eur
			SB.set_statistical_basis_line_value 1, 250
			
			#Clears the company field in the line_content
			SB.set_statistical_basis_line_company 1,nil
			SB.set_statistical_basis_line_dimension1 1,''
			gen_compare true ,SB.is_field_enabled?(_company_column),'Company field in the Header is enabled'
			SB.set_company $company_merlin_auto_gb
			SB.set_period _statistical_basis_period
			SB.click_button $sb_save_button
			SB.assert_total_value 250
			gen_end_test "TST037354: Verify that company column in Header gets disabled upon selecting company in grid"
		end
	end
	
	after :all do
		gen_switch_to_driver DRIVER , BROWSER_PROFILE
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		
		#Remove Downloaded file
		gen_remove_file _csv_file_name
				
		script1 = "delete[SELECT Id FROM Document WHERE Name = '#{_csv_file_name}' and FolderId = :Userinfo.getUserId()];"
		script2 = "delete[SELECT Id FROM #{ORG_PREFIX}StatisticalBasis__c];"
		APEX.execute_commands [script1,script2]
		SF.logout
		gen_end_test "TID021377 : Verify the Import CSV and Attachment functionality for Statistical Basis"
	end
end
	