#--------------------------------------------------------------------#
#TID : TID021320
#Pre-Requisit: org with base data and SCM, AvaTax for SCM, SCM to FFA Connector, SCM Avatax Plugins
#Product Area: Accounting - Check
#--------------------------------------------------------------------#

describe "TID021320 Smoke Test: Verify connection between SCM, Avalara and FFA systems", :type => :request do
	include_context "login"
	#variables
	account_number = "1100092360"
	_license_key = "4C228AB7A7B81685"
	service_url = "https://development.avalara.net/"
	avatax_timeout = "60000"
	company_code = "Circa96"
	tax_code_freight = "FR"
	tax_code_miscellaneous = "MS"	
	_org_address_name = "52 Maple PI"
	_org_address_city = "Boston"
	_org_address_state = "MA"
	_org_address_postal_zip= "02111"
	_org_address_country = "US"
	_item_type_consumable = "Consumable"
	_scm_line_type_tax = "Tax"
	_product_apex_001 = "Apex Product 001"
	_so_site_sold_to_value = $bd_account_abc_parts_co
	_so_line_item_item_master = "Widget-1"
	_so_line_item_quantity_1 = "1"
	_so_line_item_commitment_date = (Date.today).strftime("%d/%m/%Y")
	_so_line_item_price = "50"
	_so_line_item_condition_new = "New"
	_expected_invoice_line_1 = "#{_so_line_item_commitment_date} ABC Parts Co. USD 50.00"
	_expected_invoice_line_item_tax_text = "Tax USD 5.05 USD 5.05 #{_so_line_item_commitment_date}"
	_carrier_ups = "UPS"
	_carrier_service_ups_standard = "UPS Standard"
	_row_1 = 1
	_row_2 = 2
	
	before :all do
		gen_start_test "TID021320-SCM Connector Compatibility Test"
		#Hold Base Data
		FFA.hold_base_data_and_wait
		
		##SCM-FFA Connector Settings Set Default Company = Merlin Auto USA
		custom_setting ="list<SCMFFA__SCM_FFA_Connector_Settings__c> settingList = [SELECT ID from SCMFFA__SCM_FFA_Connector_Settings__c];"
		custom_setting +="SCMFFA__SCM_FFA_Connector_Settings__c setting;"
		custom_setting +="if(settingList.size() == 0)"
		custom_setting +="{"
		custom_setting +="setting = new SCMFFA__SCM_FFA_Connector_Settings__c();"
		custom_setting +="}"
		custom_setting +="else"
		custom_setting +="{"
		custom_setting +="setting = settingList[0];"
		custom_setting +="}"
		custom_setting += "setting.SCMFFA__Default_Company__c =  '#{$company_merlin_auto_usa}';"
		custom_setting += "UPSERT setting;"
		APEX.execute_commands [custom_setting]

		##SCM PluginsSet Set Sales Invoice Bill, Sales Invoice Credit and invoice Void After values
		custom_setting ="list<SCMC__SCM_Plugins__c> settingList = [SELECT ID from SCMC__SCM_Plugins__c];"
		custom_setting +="SCMC__SCM_Plugins__c setting;"
		custom_setting +="if(settingList.size() == 0)"
		custom_setting +="{"
		custom_setting +="setting = new SCMC__SCM_Plugins__c();"
		custom_setting +="}"
		custom_setting +="else"
		custom_setting +="{"
		custom_setting +="setting = settingList[0];"
		custom_setting +="}"
		custom_setting += "setting.SCMC__Sales_Invoice_Bill__c =  'SCMAVAFFA.SCMFFAAvalaraBillPlugin';"
		custom_setting += "setting.SCMC__Sales_Invoice_Credit__c =  'SCMAVAFFA.CreditInvoiceExportPlugin';"
		custom_setting += "setting.SCMC__Invoice_Void_After__c =  'SCMAVAFFA.VoidInvoiceExportPlugin';"
		custom_setting += "UPSERT setting;"
		APEX.execute_commands [custom_setting]

		##Extension Settings (FF), Set: top Using Journal Extension Package => True, Stop Using AP Extension Package => True
		custom_setting ="list<#{ORG_PREFIX}BillingSettings__c> settingList = [SELECT ID from #{ORG_PREFIX}BillingSettings__c];"
		custom_setting +="#{ORG_PREFIX}BillingSettings__c setting;"
		custom_setting +="if(settingList.size() == 0)"
		custom_setting +="{"
		custom_setting +="setting = new #{ORG_PREFIX}BillingSettings__c();"
		custom_setting +="}"
		custom_setting +="else"
		custom_setting +="{"
		custom_setting +="setting = settingList[0];"
		custom_setting +="}"
		custom_setting += "setting.#{ORG_PREFIX}StopUsingJournalExtensionPackage__c = true;"
		custom_setting += "setting.#{ORG_PREFIX}StopUsingAPExtensionPackage__c = true;"
		custom_setting += "UPSERT setting;"
		APEX.execute_commands [custom_setting]

		##Avalara Valid Countries 
		custom_setting ="list<SCMAVA__Avalara_Valid_Countries__c> settingList = [SELECT ID from SCMAVA__Avalara_Valid_Countries__c];"
		custom_setting +="SCMAVA__Avalara_Valid_Countries__c setting;"
		custom_setting +="if(settingList.size() == 0)"
		custom_setting +="{"
		custom_setting +="setting = new SCMAVA__Avalara_Valid_Countries__c();"
		custom_setting +="}"
		custom_setting +="else"
		custom_setting +="{"
		custom_setting +="setting = settingList[0];"
		custom_setting +="}"
		custom_setting += "setting.Name = 'US';"
		custom_setting += "UPSERT setting;"
		APEX.execute_commands [custom_setting]
	end
	
	it "TID021320-TST037118: check the connection between SCM, Avalara and FFA systems" do
		gen_start_test "TST037118: check the connection between SCM, Avalara and FFA systems"
		begin
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa] ,true
			
			SF.tab $tab_accounts
			SF.select_view $bd_select_view_all_accounts
			SF.click_button_go
			gen_click_link_and_wait $bd_account_abc_parts_co
			page.has_text?($bd_account_abc_parts_co)
			SF.click_button_edit
			Account.set_account_trading_currency $bd_currency_usd
			Account.set_accounts_receivable_control $bd_gla_account_receivable_control_usd 		
			SF.click_button_save
			SF.wait_for_search_button
			
			SF.tab $tab_avalara_settings
			Avalara_Settings.click_edit_button
			Avalara_Settings.set_account_number account_number
			Avalara_Settings.set_license_key _license_key		
			Avalara_Settings.set_service_url service_url 
			Avalara_Settings.set_company_code company_code 
			Avalara_Settings.set_avatax_timeout avatax_timeout
			Avalara_Settings.uncheck_disable_address_validation 
			Avalara_Settings.uncheck_disable_tax_calculation
			Avalara_Settings.uncheck_enable_automatic_tax_calculation_quote
			Avalara_Settings.uncheck_enable_automatic_tax_calculation_sales_order
			Avalara_Settings.uncheck_enable_automatic_tax_calculation_invoice
			Avalara_Settings.uncheck_enable_automatic_tax_calculation_voucher
			Avalara_Settings.set_tax_code_freight tax_code_freight = "FR"
			Avalara_Settings.set_tax_code_miscellaneous tax_code_miscellaneous = "MS"
			Avalara_Settings.uncheck_return_validated_address_in_upper_case
			Avalara_Settings.check_enable_logging
			SF.click_button_save
			SF.wait_for_search_button

			Avalara_Settings.click_orgnization_address_edit_button
			Avalara_Settings.set_orgnization_address_name  _org_address_name
			Avalara_Settings.set_orgnization_address_street  _org_address_name
			Avalara_Settings.set_orgnization_address_city _org_address_city
			Avalara_Settings.set_orgnization_address_state _org_address_state
			Avalara_Settings.set_orgnization_address_postal_zip _org_address_postal_zip
			Avalara_Settings.set_orgnization_address_country _org_address_country
			SF.click_button_save
			SF.wait_for_search_button
			
			SF.tab $tab_avalara_tax_mappings
			SF.click_button_new
			AVA_TAX_MAP.set_product_group $bd_product_group_finished_goods
			AVA_TAX_MAP.set_item_type _item_type_consumable
			SF.click_button_save
			SF.wait_for_search_button
			
			SF.tab $tab_scm_product_mappings
			SF.click_button_new
			SCM_Product_Mapping.set_scm_line_type _scm_line_type_tax
			SCM_Product_Mapping.set_product _product_apex_001
			SF.click_button_save
			SF.wait_for_search_button
			
			SF.tab $tab_product_groups
			SF.click_button_go
			Product_Group.click_product_group_name_in_grid $product_group_finished_goods
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button
			Product_Group.set_product $bd_product_auto_com_clutch_kit_1989_dodge_raider
			SF.click_button_save
			SF.wait_for_search_button
			
			##verify that Item = Widget-1 has “Finished Goods” in Product Group and “Consumable” in Item Type,
			SF.click_link $product_group_item_master_widget_1
			SF.wait_for_search_button
			gen_compare _item_type_consumable, Product_Group.get_item_master_item_type, "Expected item type is  #{_item_type_consumable}."
			gen_compare $product_group_finished_goods, Product_Group.get_item_master_product_group, "Expected product group is  #{$product_group_finished_goods}."
			
			SF.tab $tab_inventory_network
			Inventory_Network.select_radio_option $inventory_network_radio_option_icp_west
			SF.click_button $inventory_network_edit_icp_button
			SF.wait_for_search_button
			Inventory_Network.set_company $company_merlin_auto_usa
			SF.click_button_save
			SF.wait_for_search_button
			
			##1. create new Sales Order
			SF.tab $tab_sales_orders
			SF.click_button_new
			SF.wait_for_search_button
			SF.click_button $ffa_continue
			SO.set_customer_site_sold_to _so_site_sold_to_value
			SF.click_button_save
			SF.wait_for_search_button
			_sales_order_name = SO.get_sales_order_number
			
			##Create Sale Order Line Item
			SF.click_button $sop_new_sales_order_line_item
			SF.wait_for_search_button
			SF.click_button $ffa_continue
			SO.set_line_item_item_master _so_line_item_item_master
			SO.set_line_item_quantity _so_line_item_quantity_1
			SO.set_line_item_commitment_date _so_line_item_commitment_date
			SO.set_line_item_price _so_line_item_price
			SO.set_line_item_condition _so_line_item_condition_new
			SF.click_button_save
			SF.wait_for_search_button
			gen_compare(SO.get_line_item_status, $so_line_item_status_new, "Expected line Item status is New")
			
			##set shipment status Allocated
			SF.click_link _sales_order_name
			SF.wait_for_search_button
			SF.click_button $so_button_allocate
			SF.wait_for_search_button
			SO.click_submit_for_approval
			_sales_order_status = SO.get_status
			_sales_order_shipment_status = SO.get_shipment_status
			_invoice_row_text = SO.get_invoice_row_text _row_1
			gen_compare(_sales_order_status, $so_status_approved, "Expected Sales order sttus is #{$so_status_approved}")
			gen_compare(_sales_order_shipment_status, $so_shipment_status_pending_pulling_all_items, "Expected Sales order shipment status is #{$so_shipment_status_pending_pulling_all_items}")
			gen_include(_expected_invoice_line_1 ,_invoice_row_text, " Invoice is present.")
			
			##Go to Action Queues > Warehouse tab.   For sales order created above select Confirm 
			SF.tab $tab_action_queues
			SF.wait_for_search_button
			AQ.click_tab $aq_tab_warehouse
			AQ.click_sales_order_confirm _sales_order_name
			SF.wait_for_search_button
			AQ.click_tab $aq_tab_shipping
			AQ.click_sales_order_shipment_link _sales_order_name
			SF.wait_for_search_button
			SF.click_button_edit
			SF.wait_for_search_button
			AQ.set_shipment_carrier _carrier_ups
			AQ.set_shipment_carrier_service _carrier_service_ups_standard
			SF.click_button_save
			SF.wait_for_search_button
			SF.click_button $aq_shipment_confirmed
			SF.wait_for_search_button
			
			sales_order_query = "SELECT Name, SCMFFA__Sales_Invoice__c from SCMC__Invoicing__c WHERE SCMC__Sales_Order__r.Name = '#{_sales_order_name}'"
			APEX.execute_soql sales_order_query
			invoice_name = APEX.get_field_value_from_soql_result "Name"
			
			#Go back to the order created above.  Select the Invoice created, click on “Tax and Push to FFA” 
			SF.tab $tab_sales_orders
			SF.click_button_go
			SF.click_link _sales_order_name
			SF.wait_for_search_button
			SF.click_link invoice_name
			SF.wait_for_search_button
			SF.click_button $so_tax_and_push_to_ffa
			SF.wait_for_search_button
			#verify the Tax line 
			row_text = INVOICING.get_line_item_row_text _row_2
			gen_include(_expected_invoice_line_item_tax_text , row_text, "Expected line item tax line is available")
			
			#validate Sales Invoice Generated
			APEX.execute_soql sales_order_query
			sales_invoice_Id = APEX.get_field_value_from_soql_result "SCMFFA__Sales_Invoice__c"
			
			APEX.execute_soql "SELECT Name from #{ORG_PREFIX}CODAInvoice__c where ID='#{sales_invoice_Id}'"
			sales_invoice_name = APEX.get_field_value_from_soql_result "Name"
			SF.tab $tab_sales_invoices
			SF.select_view $bd_select_view_all 
			SF.click_button_go
			SIN.open_invoice_detail_page sales_invoice_name
			SF.click_button $ffa_post_button
			invoice_status = SIN.get_status
			gen_compare $bd_document_status_complete , invoice_status , "Expected Sales Invoice Status to be Complete"	
			SF.logout
			
			#Logon to Avalara and ensure invoice number generated in the order is set to ‘uncommitted’
			Avalara.login
			Avalara.select_transaction_tab
			Avalara.search_doc_from_list invoice_name
			_doc_status = Avalara.get_doc_status
			gen_compare $avalara_doc_status_uncommitted , _doc_status, "expected doc status #{$avalara_doc_status_uncommitted}"
		end
		gen_end_test "TST037118: check the connection between SCM, Avalara and FFA systems"
	end
	after :all do
		login_user
		#Delete Test Data
		FFA.delete_new_data_and_wait
		gen_end_test "TID021320-SCM Connector Compatibility Test"
	end
end
