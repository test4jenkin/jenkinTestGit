#--------------------------------------------------------------------#
#	TID : TID005984
# 	Pre-Requisite : Org with basedata deployed and Media_setup.rb
#   setup data - media_setup.rb
#  	Product Area: Media - Overview
#--------------------------------------------------------------------#


describe "Smoke Test - Media - Overview", :type => :request do
include_context "login"
	_gla_name = "Test Sales Revenue Account GLA"
	_product_dbl_click = "DoubleClick Product"
	_pricebook_dbl_click = "DoubleClick Pricebook"
	_prod_standard_price_currency_usd = "USD - U.S. Dollar"
	_standard_price_1001 = 1001;
	_date_today =  Time.now.strftime("%d/%m/%Y")
	_previous_year = (Time.new.year - 1).to_s
	_dfp_startdate = Time.parse("01-12-#{_previous_year}").strftime("%m/%d/%Y")
	_dfp_enddate = Time.parse("31-12-#{_previous_year}").strftime("%m/%d/%Y")
	_ad_startdate = Time.parse("01-12-#{_previous_year}").strftime("%d/%m/%Y")
	_ad_enddate = Time.parse("31-12-#{_previous_year}").strftime("%d/%m/%Y") 
	 end_date_today_N3 =  (Date.today - 3).strftime("%d/%m/%Y")
	 end_date_today_N1 = (Date.today - 1).strftime("%d/%m/%Y")
	_sv_opportunity = "SV Test Opp-" + Time.now.strftime("%Y-%m-%d %H:%M:%S")
	_test_comments = "Test Comment"
	_po_001 = "PO-001"
	_closed_won = "Closed Won"
	_gross = "Gross"
	_budget_200 = 200
	_advertiser_discount_3_00 = "3.00%"
	_proposal_discount_4_00 = "4.00%"
	_additional_adjustment_65= "65"
	_agency_commission_3_65 = "3.65%"
	_expected_dsm_status = "Synced"
	_new_blank_space = "&nbsp"
	_blank = ""
	_budget_100 = "100"
	_net_rate_8_9721 = "8.9721"
	_net_rate_8_97 = "8.97"
	_quantity_1 = "1.00"
	_dfp_product_bulk_product_temp_1 = "Bulk Product Temp 1"
	_product_row_expected = "Edit | Del DoubleClick Product 1.00 USD 1,001.00 USD 8.97"
	_sales_agreement_validation_query = "Select Id,ffcm__Account__r.Name,ffm__AgencyCommission__c,ffm__CampaignStartDate__c,ffm__CampaignEndDate__c,ffm__ContractValue__c,"
	_sales_agreement_validation_query += "(Select ffcm__ProductName__r.Name,ffm__AdStartDate__c ,ffm__AdEndDate__c,ffm__LineValue__c from ffcm__SalesAgreementLineItems__r)"
	_sales_agreement_validation_query += "from ffcm__SalesAgreement__c where ffcm__Opportunity__c IN (Select ID from Opportunity where Name='"+_sv_opportunity+"')"
	_sales_disable_sales_agreement_generation = "ffcm__OpportunitySettings__c oppSetting = [select Id from ffcm__OpportunitySettings__c][0];"
	_sales_disable_sales_agreement_generation += "oppSetting.ffcm__DisableGenerateSalesAgreements__c="+$sf_param_substitute+";"
	_sales_disable_sales_agreement_generation += "UPDATE oppSetting;"
	_expected_account_name = "Name\":\"Apex EUR Account"
	_expected_agency_commision = "ffm__AgencyCommission__c\":3.65"
	_expected_campaign_start_date = "ffm__CampaignStartDate__c\":\""+ Time.parse(_ad_startdate).strftime("%Y-%m-%d")
	_expected_campaign_end_date = "fm__CampaignEndDate__c\":\""+ Time.parse(_ad_enddate).strftime("%Y-%m-%d")
	_expected_contract_value = "ffm__ContractValue__c\":8.97"
	_expected_line_item_size = "ffcm__SalesAgreementLineItems__r\":{\"totalSize\":1"
	_expected_line_item_ad_startdate = "ffm__AdStartDate__c\":\""+ Time.parse(_ad_startdate).strftime("%Y-%m-%d")
	_expected_line_item_ad_enddate = "ffm__AdEndDate__c\":\""+ Time.parse(_ad_enddate).strftime("%Y-%m-%d")
	_expected_line_item_line_value = "ffm__LineValue__c\":8.97" 
	_quantity_contracted_this_period_3 = 3
	_quantity_contracted_this_period_4 = 4
	_quantity_delivered_this_period_2 = 2
	_quantity_delivered_this_period_3 = 3	
	_sales_agreement_id = ""
	_sales_agreement_name = ""
	_sales_agreement_line_item_id = ""
	_sales_agreement_line_item_name = ""	
	_billing_total_cost_250 = "250.00"
	_billing_total_cost_200 = "200.00"
	_billing_total_cost_150 = "150"	
	_billing_period_startdate = (Date.today() - 4).strftime("%d/%m/%Y")
	_billing_period_enddate = (Date.today() - 3).strftime("%d/%m/%Y")
	_billing_quantity_1 = 1
	_billing_type_contracted = "Contracted"
	_integration_rule_1 = "Create Media Sales Credit Note"
	_integration_rule_2 = "Create Media Sales Invoice"
	_integration_rule_3 = "Create Media Sales Invoice from Opportunity"
	_integration_rule_4 = "Create Sales Invoice from Sales Agreement"
	_integration_rule_5 = "Display Sales Agreement references on Credit Note"
	_integration_rule_6 = "Create Media Sales Credit Note"
	_opportunity_id = "Opportunity ID (Id)"
	_sf_opportunity_id = "sf opportunity id"
	
	_proposal_line_item = "Proposal line item"
	_proposal = "Proposal"
	_sales_contract = "Sales contract"
	_proposal_line_item_billing_source = "Proposal line item billing source"
	_c14 = "c14"
	_c11 = "c11"
	_c12 = "c12"
	_c13 = "c13"
	_proposal_line_item_caps_and_rollovers = "Proposal line item caps and rollovers"
	_contracted_volume = "Contracted volume"
	_billing_type = "Billing Type"
	_quantity_delivered_this_period = "Quantity Delivered This Period"
	_total_cost = "Total Cost"
	_billable_quantity_to_date = "Billable Quantity To Date"
	_billable_quantity_this_period = "Billable Quantity This Period"
	_billing_cap = "Billing Cap"
	_quantity_contracted_this_period = "Quantity Contracted This Period"
	_confirm_message = "Creating Billing Line Items. You will be notified by email when the process is complete."
	_billing_period_start_date = "Billing Period Start Date"
	_name = "Name"
	custom_field_values = [100, 200, 300, 400]
	_month_dec = "DEC"
	_billing_startdate = Time.parse("01-12-#{_previous_year}").strftime("%d/%m/%Y")
	_billing_enddate = Time.parse("31-12-#{_previous_year}").strftime("%d/%m/%Y")
	_billing_line_item = "BL000002"	
	_quantity_contracted_this_period_1  = "1"
	_quantity_delivered_this_period_400 = "400"
	_billable_quantity_this_period_300 = "300"
	billable_quantity_to_date_200 = "200"		
	_rate_method = "CPC"	
	billing_type_actual = "Actual (third-party volume)"
	_total_cost_100 = "100.00"
	_ad_rate_value = "8.9700"
	_billing_cap_Capped = "Capped cumulative"
	_sales_agreement_name = ""
	_sales_agreement_line_item_name = ""
	_sales_invoice_name = ""
	_sales_invoice_id = ""
	_sales_agreement_id = ""
	_billing_line_item= ""
	_billing_status_completed = "Completed"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait		
	
		#Test Sales Revenue Account GLA (normal Balance sheet gla)
		create_gla = "#{ORG_PREFIX}codaGeneralLedgerAccount__c gla = new #{ORG_PREFIX}codaGeneralLedgerAccount__c(Name = '#{_gla_name}', #{ORG_PREFIX}Type__c = 'Balance Sheet', CurrencyIsoCode = 'USD', #{ORG_PREFIX}ReportingCode__c = 'TSR');"
		create_gla += "INSERT gla;"
		create_product = "Product2 prodDoubleClick = new Product2(Name='#{_product_dbl_click}', CurrencyIsoCode='USD', Description='Media_product',IsActive=true);"
		create_product += "INSERT prodDoubleClick;"
		create_pricebook = "Pricebook2 priceBookDoubleClick = new Pricebook2(Name='#{_pricebook_dbl_click}', IsActive=true);"
		create_pricebook += "INSERT priceBookDoubleClick;"
		create_data = [ create_gla, create_product,create_pricebook ]			
		APEX.execute_commands create_data
		
		# Create following
		# - An Active Product Named 'DoubleClick Product'
		# - An Active Price Book 'DoubleClick Pricebook'
		# Associate Product with the Price book.			
		# Add Product standard price
			SF.retry_script_block do 
			SF.tab $tab_products
			Product.search_product _product_dbl_click
			SF.click_link _product_dbl_click
			Product.click_add_standard_price_button
			Product.set_standard_price_to_product _prod_standard_price_currency_usd, _standard_price_1001 
			SF.click_button_save
		end
				
		#create Pricebook entry for product and Pricebook2
		create_pricebook_entry = "PricebookEntry priceBookDblClickEntry = new PriceBookEntry(UnitPrice = #{_standard_price_1001},UseStandardPrice =true );"
		create_pricebook_entry += "priceBookDblClickEntry.Product2Id = [Select ID from Product2 where Name='#{_product_dbl_click}'][0].Id;"
		create_pricebook_entry += "priceBookDblClickEntry.Pricebook2Id = [Select ID from Pricebook2 where Name='#{_pricebook_dbl_click}'][0].Id;"
		create_pricebook_entry += "priceBookDblClickEntry.IsActive = true;"
		create_pricebook_entry += "INSERT priceBookDblClickEntry;"
		create_data = [ create_pricebook_entry ]		
		APEX.execute_commands create_data	
		gen_start_test "TID005984 : COMPATIBILITY TEST - Contract Billing & Media"		

		puts "Contract Billing & Media Setup- Create Media Billing general Settings"
		_media_billing_gen_setting = "ffm__MediaBillingGeneral__c setting = new ffm__MediaBillingGeneral__c();"
		_media_billing_gen_setting += "setting.ffm__DFPNetworkCode__c = '#{$dfp_network_code}';"
		_media_billing_gen_setting += "INSERT setting;"		
		APEX.execute_commands [_media_billing_gen_setting]
		
		#"Contract Billing & Media Setup- #Go to DSM Mappings tab and create mappings. Create SF and DFP mapping on opportunity" , :run=>true   do
		SF.retry_script_block do 
			SF.tab $tab_dsm_mappings
			SF.wait_for_search_button
			if !(DSM.is_master_object_mapping_exists _opportunity_id, _sf_opportunity_id)
				SF.click_button_edit
				SF.wait_for_search_button
				DSM.add_master_object_mapping _opportunity_id, _sf_opportunity_id
				SF.click_button_save
				SF.wait_for_search_button
			end
		end
		
		puts "Contract Billing & Media Setup- Create Opportunity Settings"
		_opportunity_settings = "ffcm__OpportunitySettings__c oppSetting = new ffcm__OpportunitySettings__c();"
		_opportunity_settings += "oppSetting.ffm__DoubleClickProductName__c='#{_product_dbl_click}';"
		_opportunity_settings += "oppSetting.ffm__DoubleClickPricebook__c='#{_pricebook_dbl_click}';"
		_opportunity_settings += "INSERT oppSetting;"
		APEX.execute_commands [_opportunity_settings]
		
		puts "Contract Billing & Media Setup- Create Integration Rules Settings"
		_integration_rule_setting = "c2g__IntegrationRulesSettings__c setting = new c2g__IntegrationRulesSettings__c();"
		_integration_rule_setting += "setting.c2g__AllowTextToDimensionMapping__c = true;"
		_integration_rule_setting += "INSERT setting;"
		APEX.execute_commands [_integration_rule_setting]
	
		puts "Contract Billing & Media Setup- Create Product Type Settings"
		_product_type_settings = "ffm__ProductTypeSettings__c setting = new ffm__ProductTypeSettings__c(Name='Product Type');"
		_product_type_settings += "setting.ffm__SalesRevenueAccount__c = '#{_gla_name}';"
		_product_type_settings += "setting.ffm__SalesTaxStatus__c = 'Taxable';"
		_product_type_settings += "INSERT setting;"
		APEX.execute_commands [_product_type_settings]
		
		puts  "Contract Billing & Media Setup- create Integration rules by clicking on 'Generate Integration Rules' button."	
		login_user
		SF.tab $tab_integration_rules
		SF.wait_for_search_button
		SF.click_button_go
		SF.wait_for_search_button
		SF.click_button $ffa_integration_rule_generate_integration_rules_button
		SF.wait_for_search_button
		SF.wait_for_apex_job		
		#validate Integration rules
		SF.tab $tab_integration_rules
		SF.click_button_go
		SF.wait_for_search_button
		gen_compare_has_content _integration_rule_1, true , "Integration rule 1 created"
		gen_compare_has_content _integration_rule_2, true , "Integration rule 2 created"
		gen_compare_has_content _integration_rule_3, true , "Integration rule 3 created"
		gen_compare_has_content _integration_rule_4, true , "Integration rule 4 created"
		gen_compare_has_content _integration_rule_5, true , "Integration rule 5 created"
		gen_compare_has_content _integration_rule_6, true , "Integration rule 6 created"
		
		#Edit Opp. to sales Agreement Once
		SF.retry_script_block do
			SF.tab $tab_opportunity_to_sales_agreement_mappings
			SF.click_button_edit
			page.has_button?('Save')
			SF.click_button_save
			SF.wait_for_search_button
		end

		DFP.login
		DFP.open_proposal_page
		DFP.archive_my_proposals_and_confirm		
	end
		
	it "TID005984 :  COMPATIBILITY TEST - Contract Billing & Media" do
		login_user

		begin
			gen_start_test "TST017266- Opportunity can be pushed successfully to DFP, fields on Opportunity are successfully populated from newly created Proposal on DFP."
			#Create New Opportunity
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			SF.click_button $opp_new_opportunity_button
			OPP.set_opportunity_name _sv_opportunity
			OPP.set_account_name $bd_account_apex_eur_account
			OPP.set_dsm_comments _test_comments
			OPP.set_po_number _po_001
			OPP.set_close_date _date_today
			OPP.select_stage _closed_won
			OPP.set_pricing_model _gross
			OPP.set_budget _budget_200
			OPP.set_advertiser_discount _advertiser_discount_3_00
			OPP.set_proposal_discount _proposal_discount_4_00
			OPP.set_additional_adjustment _additional_adjustment_65
			OPP.set_agency_commission _agency_commission_3_65
			SF.click_button_save
			SF.wait_for_search_button
			gen_compare_has_content _sv_opportunity, true , "Opporntunity created and visible on view page"			
			#Push to DSM
			SF.click_button $opp_push_to_dsm
			SF.wait_for_search_button
			SF.click_button $opp_push_to_dsm_yes
			gen_compare_has_content $opp_proposal_success_message, true , "Proposal created"
			SF.click_button $opp_push_to_dsm_back
			SF.wait_for_search_button			
			#validations
			gen_not_include _new_blank_space , OPP.get_proposal_id , "Proposal Id generated-"
			gen_include _date_today , OPP.get_dsm_last_modified_date , "dsm_last_modified_date poplated"
			gen_compare _blank,	OPP.get_dsm_sync_error , "No error in proposal"
			gen_compare _blank, OPP.get_dsm_start_date , "start date is blank"
			gen_compare _blank, OPP.get_dsm_end_date , "end date is blank"
			gen_compare _expected_dsm_status, OPP.get_dsm_sync_status, "DSM sync status is correct"
			SF.logout 		
			gen_end_test "TST017266- Opportunity can be pushed successfully to DFP, fields on Opportunity are successfully populated from newly created Proposal on DFP."
		end

		begin
			gen_start_test "TST017268-Opportunity can be synced successfully from corresponding Proposal on DFP, corresponding Opportunity lines are created/synced from Proposal Line items on the Proposal."
			#1. Go to Proposal on DFP. 
			DFP.login
			DFP.open_proposal_page
			DFP.click_button_filters
			DFP.click_button_proposal_filter_by_click
			DFP.set_proposal_filter_text _sv_opportunity
			DFP.click_button_proposal_apply_filter
			SF.wait_for_search_button
			SF.click_link _sv_opportunity
			page.has_text?(_sv_opportunity)
			DFP.click_button_proposal_add_product
			SF.wait_for_search_button
			DFP.select_product_rate_card $dfp_gross_rate_card
			SF.wait_for_search_button
			DFP.add_product_to_proposal _dfp_product_bulk_product_temp_1
			DFP.set_product_budget _budget_200
			DFP.set_product_net_rate _net_rate_8_9721
			DFP.set_product_quantity _quantity_1
			DFP.set_product_start_date_and_end_date _dfp_startdate, _dfp_enddate
			DFP.click_button_update_proposal
			DFP.click_button_save_draft
						
			login_user
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			SF.wait_for_search_button
			SF.click_button $opp_dsm_sync
			SF.wait_for_search_button
			SF.click_button $opp_push_to_dsm_yes
			SF.wait_for_search_button
			gen_compare_has_content $opp_dsm_sync_success_message, true , "dsm sync "
			SF.click_button $opp_push_to_dsm_back
			SF.wait_for_search_button			
			
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_product_dbl_click)
			_row_text = OPP.get_product_row_output _product_dbl_click
			gen_include _product_row_expected , _row_text , "product, quantity, net rate  sync correct"	
			gen_end_test "TST017268-Opportunity can be synced successfully from corresponding Proposal on DFP, corresponding Opportunity lines are created/synced from Proposal Line items on the Proposal."
		end		
		
		begin
			gen_start_test "TST017269-Sales Agreement can be successfully generated from Opportunity."
			#select Create Sales Agreement and Sales Agreement Required
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button
			OPP.select_create_sales_agreement 
			OPP.select_sales_agreement_required
			SF.click_button_save
			SF.wait_for_search_button
			
			#generate sales agreement and confirm
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			FFA.select_row_in_list_gird $opp_opportunity_name_text , _sv_opportunity			
			OPP.click_button_generate_sales_agreement_button_and_confirm
			gen_compare_has_content $opp_sales_agreement_inprogress_message, true , "Generate Sales agreement in progress message "
			SF.wait_for_apex_job
			
			#validations			
			_sales_agreement_id, _sales_agreement_name = SA.get_sales_agreement_name_and_id_from_opportunity _sv_opportunity	 
			_sales_agreement_line_item_id, _sales_agreement_line_item_name = SA.get_sales_agreement_line_item _sales_agreement_id
			
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button			
			gen_compare $bd_account_apex_eur_account , SA.get_account_name , "sales Account Apex EUR Account is correct"
			gen_compare _agency_commission_3_65 , SA.get_agency_commision , "Agency Commission is correct"
			gen_compare _ad_startdate.to_s , SA.get_campaign_start_date , "CampaignStartDate is correct"
			gen_compare _ad_enddate.to_s , SA.get_campaign_end_date , "CampaignEndDate is correct"
			gen_compare _net_rate_8_97 , SA.get_contract_value , "Contract Value is correct"
			#validate line Items
			SA.view_sales_agreement_line_item _sales_agreement_line_item_name
			SF.wait_for_search_button		
			gen_compare _ad_startdate , SA.get_line_item_ad_start_date , "Ad StartDate is correct"
			gen_compare _ad_enddate , SA.get_line_item_ad_end_date , "Ad EndDate is correct"
			gen_compare _net_rate_8_97, SA.get_line_item_line_value , "LineValue is correct"	
			
			#Additional Validations from soql
			APEX.execute_soql _sales_agreement_validation_query
			query_result = APEX.get_execution_status_message						
			gen_include _expected_account_name , query_result , "sales Account Apex EUR Account is correct"
			gen_include _expected_agency_commision , query_result , "Agency Commission is correct"
			gen_include _expected_campaign_start_date , query_result , "CampaignStartDate is correct"
			gen_include _expected_campaign_end_date , query_result , "CampaignEndDate is correct"
			gen_include _expected_contract_value , query_result , "ContractValue is correct"
			
			gen_include _expected_line_item_size , query_result , "Line Item size is correct"
			gen_include _expected_line_item_ad_startdate , query_result , "Ad StartDate is correct"
			gen_include _expected_line_item_ad_enddate , query_result , "Ad EndDate is correct"
			gen_include _expected_line_item_line_value, query_result , "LineValue is correct"					
			gen_end_test  "TST017269-Sales Agreement can be successfully generated from Opportunity."
		end	
		
		begin
			gen_start_test "TST017270-Verify that sales invoice can be created from Sales Agreement."
			#select disable generate sales agreement in Opportunity custom setting 
			APEX.execute_commands [_sales_disable_sales_agreement_generation.gsub($sf_param_substitute,"true")]
			
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SA.view_sales_agreement_line_item _sales_agreement_line_item_name
			SF.wait_for_search_button		
			SA.click_new_billing_line_item
			SA.set_billing_line_item_billing_period_start_date _billing_period_startdate
			SA.set_billing_line_item_billing_period_end_date _billing_period_enddate
			SA.set_billing_line_item_ad_start_date _ad_startdate
			SA.set_billing_line_item_ad_end_date _ad_enddate
			SA.set_billing_line_item_quantity_contracted_this_period _quantity_contracted_this_period_3
			SA.set_billing_line_item_quantity_delivered_this_period _quantity_delivered_this_period_2
			SA.set_billing_line_item_quantity _billing_quantity_1
			SA.set_billing_line_item_billing_type _billing_type_contracted
			SA.set_billing_line_item_total_cost _billing_total_cost_150
			SF.click_button_save
			SF.wait_for_search_button
										
			#Click on Create sales invoice button on header of Sales agreement.
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SA.click_button_create_sales_invoice
			SA.set_sales_invoice_end_date end_date_today_N3
			SA.set_sales_invoice_date _date_today
			SA.click_button_create_sales_invoice_confirm
			SF.wait_for_search_button
			gen_compare_has_content $sa_create_sales_invoice_in_progress, true , "Creating Sales Invoice"
			SA.click_button_back_to_sales_agreement
			SF.wait_for_apex_job
						
			#Validation - A new sales invoice with In progress status should be created and values in fields 
			#get Sales invoice Id for sales Agreement
			_sales_invoice_id, _sales_invoice_name = SA.get_sales_invoice_details_from_sales_agreement _sales_agreement_id
									
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SF.click_link _sales_invoice_name
			SF.wait_for_search_button			
			gen_compare $bd_account_apex_eur_account , SINX.get_account_name_in_media_layout , "SINV account name is correct"
			gen_compare _date_today , SINX.get_invoice_date_in_media_layout , "SINV Invice date is correct"
			gen_compare_has_content _dfp_product_bulk_product_temp_1, true , "Product is present on page"		
			gen_end_test  "TST017270-Verify that sales invoice can be created from Sales Agreement."

		end		
	
		begin
			gen_start_test "TST017271	-Verify that sales invoice can be successfully converted to Credit Note."
			#Set On Bulk Product Temp 1 product give value of Sales Revenue Account = Test Sales Revenue Account GLA
			SF.tab $tab_products
			Product.search_product _dfp_product_bulk_product_temp_1
			SF.click_link _dfp_product_bulk_product_temp_1
			SF.wait_for_search_button
			SF.click_button_edit
			Product.set_sales_revenue_account _gla_name
			SF.click_button_save
			
			#Go to Sales Invoice
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SF.click_link _sales_invoice_name
			SF.wait_for_search_button
			SIN.click_post_button
			SF.wait_for_search_button
			SIN.click_post_invoices
			SINX.convert_to_credit_note
			SINX.convert_to_credit_note_confirm
			#validations
			_sales_credit_note_id, _sales_credit_note_name, _sales_credit_note_status =  SA.get_credit_note_details_from_sales_agreement _sales_agreement_id, _sales_invoice_id
			SCRX.open_credit_note_detail_page _sales_credit_note_name
			gen_compare $bd_document_status_in_progress,	_sales_credit_note_status , "Credit Note status is Inporgress"
			gen_end_test  "	TST017271	-Verify that sales invoice can be successfully converted to Credit Note."
		end	
		
		begin
			gen_start_test "	TST017272	-Verify that Media billing Adjustment Process is running successfully."
			#precondition 
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SA.view_sales_agreement_line_item _sales_agreement_line_item_name
			SF.wait_for_search_button		
			SA.click_new_billing_line_item
			SA.set_billing_line_item_billing_period_start_date _billing_period_startdate
			SA.set_billing_line_item_billing_period_end_date _billing_period_enddate
			SA.set_billing_line_item_ad_start_date _ad_startdate
			SA.set_billing_line_item_ad_end_date _ad_enddate
			SA.set_billing_line_item_quantity_contracted_this_period _quantity_contracted_this_period_3 
			SA.set_billing_line_item_quantity_delivered_this_period _quantity_delivered_this_period_2 
			SA.set_billing_line_item_quantity _billing_quantity_1
			SA.set_billing_line_item_billing_type _billing_type_contracted
			SA.set_billing_line_item_total_cost _billing_total_cost_200
			SF.click_button_save
			SF.wait_for_search_button
			
			# Click on Create sales invoice button on header of Sales agreement.
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SA.click_button_create_sales_invoice
			SA.set_sales_invoice_end_date end_date_today_N1
			SA.set_sales_invoice_date _date_today
			SA.click_button_create_sales_invoice_confirm
			gen_compare_has_content $sa_create_sales_invoice_in_progress, true , "Creating Sales Invoice"
			SA.click_button_back_to_sales_agreement
			SF.wait_for_apex_job
			
			#get inprogress invoice Number
			_sales_invoice_id, _sales_invoice_name = SA.get_inprogress_sales_invoice_details _sales_agreement_id
			# Post Sales Invoice
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SF.click_link _sales_invoice_name
			SF.wait_for_search_button
			SIN.click_post_button
			SF.wait_for_search_button			
			SIN.click_post_invoices
			
			#test step create another billing Line Item
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SA.view_sales_agreement_line_item _sales_agreement_line_item_name
			SF.wait_for_search_button		
			SA.click_new_billing_line_item
			SA.set_billing_line_item_billing_period_start_date _billing_period_startdate
			SA.set_billing_line_item_billing_period_end_date _billing_period_enddate
			SA.set_billing_line_item_ad_start_date _ad_startdate
			SA.set_billing_line_item_ad_end_date _ad_enddate
			SA.set_billing_line_item_quantity_contracted_this_period _quantity_contracted_this_period_4
			SA.set_billing_line_item_quantity_delivered_this_period _quantity_delivered_this_period_3
			SA.set_billing_line_item_quantity _billing_quantity_1
			SA.set_billing_line_item_billing_type _billing_type_contracted
			SA.set_billing_line_item_total_cost _billing_total_cost_250
			SF.click_button_save
			SF.wait_for_search_button
			
			# Click on Create sales invoice button on header of Sales agreement.
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SA.click_button_create_sales_invoice
			SA.set_sales_invoice_end_date end_date_today_N1
			SA.set_sales_invoice_date _date_today
			SA.click_button_create_sales_invoice_confirm
			gen_compare_has_content $sa_create_sales_invoice_in_progress, true , "Creating Sales Invoice 2 Inprogress"
			SA.click_button_back_to_sales_agreement
			SF.wait_for_apex_job
			
			#validations
			#6b. Old sales invoice should be converted to sales credit note automatically.
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SF.click_link _sales_invoice_name
			SF.wait_for_search_button			
			gen_compare SINX.get_invoice_status , $bd_document_status_complete , "Expected Invoice status : Complete."
			invoice_net_total = SINX.get_invoice_net_total_in_media_layout
			gen_include invoice_net_total , _billing_total_cost_200, "Expected Invoice total : 200."
			
			#read credit note status
			_sales_credit_note_id, _sales_credit_note_name, _sales_credit_note_status, _sales_credit_note_net_total = SA.get_credit_note_details_from_sales_agreement _sales_agreement_id, _sales_invoice_id
			gen_compare _sales_credit_note_status,	$bd_document_status_complete , "Expected Credit Note status is Inporgress"
			gen_include _sales_credit_note_net_total,	_billing_total_cost_200, "Expected Credit Note net Total is 200"
			
			#6a. A new sales invoice with In progress status should be created.
	        _sales_invoice_id, _sales_invoice_name = SA.get_inprogress_sales_invoice_details _sales_agreement_id
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SF.click_link _sales_invoice_name
			SF.wait_for_search_button			
			gen_compare SINX.get_invoice_status , $bd_document_status_in_progress , "Expected Invoice status : Inprogress."
			invoice_net_total = SINX.get_invoice_net_total_in_media_layout
			gen_include invoice_net_total , _billing_total_cost_250, "Expected Invoice total : 250."
			gen_end_test  "	TST017272	-Verify that Media billing Adjustment Process is running successfully."
		end			

		begin
			#1. Go to Proposal on DFP. 
			DFP.login
			DFP.open_proposal_page
			DFP.click_button_filters
			DFP.click_button_proposal_filter_by_click
			DFP.set_proposal_filter_text _sv_opportunity
			DFP.click_button_proposal_apply_filter
			SF.wait_for_search_button
			SF.click_link _sv_opportunity
			page.has_text?(_sv_opportunity)
			DFP.click_proposal_setting_tab
			DFP.set_proposal_setting_custom_field _c11, custom_field_values[0]
			DFP.set_proposal_setting_custom_field _c12, custom_field_values[1]
			DFP.set_proposal_setting_custom_field _c13, custom_field_values[2]
			DFP.set_proposal_setting_custom_field _c14, custom_field_values[3]
			DFP.set_proposal_setting_salesperson  $dfp_salesperson_name
			DFP.click_button_save_draft
			
			login_user 
			SF.tab $tab_dfp_configuration
			DFP.click_dfp_report_cofiguration_sub_tab $dfp_report_config_tab_mapping
			SF.click_button_edit
			DFP.click_report_config_add_mapping
			DFP.report_config_add_mapping _proposal_line_item, _proposal_line_item_billing_source ,  _billing_type
			DFP.click_report_config_add_mapping
			DFP.report_config_add_mapping _proposal, _c14 ,  _quantity_delivered_this_period 
			DFP.click_report_config_add_mapping
			DFP.report_config_add_mapping _proposal, _c11 ,  _total_cost
			DFP.click_report_config_add_mapping
			DFP.report_config_add_mapping _proposal, _c12 ,  _billable_quantity_to_date
			DFP.click_report_config_add_mapping
			DFP.report_config_add_mapping _proposal, _c13 ,  _billable_quantity_this_period
			DFP.click_report_config_add_mapping
			DFP.report_config_add_mapping _proposal_line_item, _proposal_line_item_caps_and_rollovers ,  _billing_cap
			DFP.click_report_config_add_mapping
			DFP.report_config_add_mapping _sales_contract, _contracted_volume ,  _quantity_contracted_this_period
			SF.click_button_save
			gen_wait_until_object_disappear $dfp_report_config_loading_span
			
			DFP.click_dfp_report_cofiguration_sub_tab $dfp_report_config_tab_schedule
			SF.click_button $dfp_report_config_schedule_retrieve_button
			gen_wait_until_object_disappear $dfp_report_config_loading_span
			DFP.select_report_config_schedule_year _previous_year
			DFP.select_report_config_schedule_month _month_dec
			DFP.click_button $dfp_report_config_schedule_confirm_button
			gen_wait_until_object_disappear $dfp_report_config_loading_span
			gen_compare (page.has_text?(_confirm_message)),true, "Creating Billing Line Items. You will be notified by email when the process is complete."
			SF.wait_for_apex_job
			
			#11. New record should be created for the selected month.
			SF.tab $tab_dfp_reports
			SF.click_button_go
			_report_name = FFA.get_column_value_in_grid _billing_period_start_date , _billing_startdate , _name
			SF.click_link _report_name
			SF.wait_for_search_button
			#12. A csv file should be attached on the record same as the attachment on TST.
			_csv_file_name= DFP.get_dfp_report_csv_file_name
			#13. Billing status should be completed.
			gen_compare _billing_status_completed, DFP.get_dfp_report_billing_status , "Billing Status is completed"
			gen_compare_objval_not_null _csv_file_name, true , "Billing Report CSV File is present"
			gen_include _csv_file_name, DFP.get_dfp_report_notes_and_attachment_text, "CSV file #{_csv_file_name} is present in attachments."

			#4.15. Billing line item record should be created on sales agreement line item.
			billing_line_item_query = "SELECT Name from ffm__BillingLineItem__c WHERE ffm__BillingCap__c = '#{_billing_cap_Capped}' AND ffm__BillingType__c = '#{billing_type_actual}'"
			APEX.execute_soql billing_line_item_query
			_billing_line_item = APEX.get_field_value_from_soql_result _name
			
			SF.tab $tab_opportunities
			OPP.all_opportunities_view
			SF.click_button_go
			OPP.view_opportunity _sv_opportunity
			page.has_text?(_sv_opportunity)
			SF.click_link _sales_agreement_name
			SF.wait_for_search_button
			SA.view_sales_agreement_line_item _sales_agreement_line_item_name
			SF.wait_for_search_button
			SF.click_link _billing_line_item
			gen_compare _dfp_product_bulk_product_temp_1,SA.get_billing_line_item_product_value ,"product vlue is correct"
			gen_compare _billing_startdate,SA.get_billing_line_item_billing_period_start_date_value,"Billing Status is correct"
			gen_compare _billing_enddate, SA.get_billing_line_item_billing_period_end_date_value ,"Billing Status is correct"
			gen_compare _billing_startdate, SA.get_billing_line_item_ad_start_date_value, "_ad_start_date_value is correct"
			gen_compare _billing_enddate, SA.get_billing_line_item_ad_end_date_value, "_end_date_value is correct"
			gen_compare _quantity_contracted_this_period_1,SA.get_billing_line_item_quantity_contracted_this_period_value,"_quantity_contracted_this_period is correct"
			gen_compare _quantity_delivered_this_period_400, SA.get_billing_line_item_quantity_delivered_this_period_value, "_quantity_delivered_this_period is correct"
			gen_compare _billable_quantity_this_period_300, SA.get_billing_line_item_billable_quantity_this_period_value, "_billable_quantity_this_period is correct"
			gen_compare billable_quantity_to_date_200,SA.get_billing_line_item_billable_quantity_to_date_value, "billable_quantity_to_date is correct"
			gen_compare _rate_method, SA.get_billing_line_item_rate_method_value, "_rate_method is correct"
			gen_compare billing_type_actual, SA.get_billing_line_item_billing_type_value, "billing_type is correct"
			gen_compare _billing_cap_Capped, SA.get_billing_line_item_billing_cap_value, "_billing_cap is correct"
			gen_compare _total_cost_100, SA.get_billing_line_item_total_cost_value, "_total_cost is correct"
			gen_compare _ad_rate_value,SA.get_billing_line_item_ad_rate_value, "_ad_rate_value is correct"			
		end
	end
	
	after :all do
		login_user
		FFA.delete_new_data_and_wait
		gen_end_test "TID005984 : COMPATIBILITY TEST - Contract Billing & Media"
	end
end