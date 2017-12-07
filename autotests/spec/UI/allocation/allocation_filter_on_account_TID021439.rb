#--------------------------------------------------------------------#
#	TID : TID021439
#	Product Area: Allocations
#   driver=firefox rspec -fd -c spec/UI/allocation/allocation_filter_on_account_TID021439.rb -fh -o TID021439.html
#   Compatible with = Managed org
#--------------------------------------------------------------------#
describe "TID021439 - This TID verifies the TLIs retrieve when user filter specific set of data in single company Mode with Account Filter ", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		# Hold Base Data
		gen_start_test "TID021439: This TID verifies the TLIs retrieve when user filter specific set of data in single company Mode with Account Filter"
		FFA.hold_base_data_and_wait
	end
	
	it "Verify the TLIs retrieve in Allocation process in single company Mode." do
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_gb], true
		_namspace_prefix = ""
		_namspace_prefix += ORG_PREFIX
		
		if(_namspace_prefix != nil && _namspace_prefix != "" )
			_namspace_prefix = _namspace_prefix.gsub! "__", "."
		end	
		error_message_filter_selection_with_no_results = "[1]Either your current filter selection has returned no results or there is no balance to allocate. Amend your filters and try again.;"
		error_message_no_filter_selected = "Allocation Each filter group must have at least one period, and either an account, a General Ledger Account, or one or more dimensions."
		CURRENT_PERIOD = FFA.get_current_period
		PREVIOUS_PERIOD1 = FFA.get_period_by_date Date.today<<3
		_total_1 = "£83.33"
		_total_2 = "£333.34"
		_zero_total = "0.00"
		
		begin
			# Create test data  for tests
			_create_invoice1 = ""
			_create_invoice1 += "Id bmwAccId;"
			_create_invoice1 += "for(Account acc : [select Name from Account]) {"
			_create_invoice1 += "if(acc.Name == '#{$bd_account_bmw_automobiles}')"
			_create_invoice1 += "{bmwAccId = acc.Id;break;}}"
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice inv = new #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();"
			_create_invoice1 += "inv.Account = #{_namspace_prefix}CODAAPICommon.getRef(bmwAccId, '#{$bd_account_bmw_automobiles}');"
			_create_invoice1 += "inv.InvoiceDate = system.today();"
			_create_invoice1 += "inv.Period = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{CURRENT_PERIOD}');"
			_create_invoice1 += "inv.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim1_north}');"
			_create_invoice1 += "inv.AccountInvoiceNumber = 'TID021439_001';"
			_create_invoice1 += "inv.InvoiceStatus = #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.enumInvoiceStatus.InProgress;"
			
			_create_invoice1 += "inv.ExpLineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItems();"
			_create_invoice1 += "inv.ExpLineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem>();"
						
			_create_invoice1 += "inv.LineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();"
			_create_invoice1 += "inv.LineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();"
			
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
			_create_invoice1 += "expLine1.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_gla_rent}');"
			_create_invoice1 += "expLine1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim1_eur}');"
			_create_invoice1 += "expLine1.NetValue = 100.00;"
			_create_invoice1 += "inv.ExpLineItems.LineItemList.add(expLine1);"
			
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine2 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
			_create_invoice1 += "expLine2.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_gla_marketing}');"
			_create_invoice1 += "expLine2.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_apex_eur_001}');"
			_create_invoice1 += "expLine2.Dimension3 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_apex_eur_003}');"
			_create_invoice1 += "expLine2.NetValue = 400.00;"
			_create_invoice1 += "inv.ExpLineItems.LineItemList.add(expLine2);"
			
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem prodLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			_create_invoice1 += "prodLine1.Product = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			_create_invoice1 += "prodLine1.Dimension2 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_apex_eur_002}');"
			_create_invoice1 += "prodLine1.Dimension4 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_apex_eur_004}');"
			_create_invoice1 += "prodLine1.Quantity = 1.00;"
			_create_invoice1 += "prodLine1.UnitPrice = 100.00;"
			_create_invoice1 += "inv.LineItems.LineItemList.add(prodLine1);"
			
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem prodLine2 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			_create_invoice1 += "prodLine2.Product = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_product_a4_paper}');"
			_create_invoice1 += "prodLine2.Quantity = 1.00;"
			_create_invoice1 += "prodLine2.UnitPrice = 200.00;"
			_create_invoice1 += "inv.LineItems.LineItemList.add(prodLine2);"
			
			_create_invoice1 += "#{_namspace_prefix}CODAAPICommon_9_0.Context context = new #{_namspace_prefix}CODAAPICommon_9_0.Context();"
			_create_invoice1 += "context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1', Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));"
			
			_create_invoice1 += "Id dto2Id = #{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, inv).Id;"
			_create_invoice1 += "#{_namspace_prefix}CODAAPICommon.Reference purchaseInvoiceIds = #{_namspace_prefix}CODAAPICommon.getRef(dto2Id, null);"
			_create_invoice1 += "#{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(context, purchaseInvoiceIds );"
			
			APEX.execute_script _create_invoice1
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
			
			_create_invoice2 = ""
			_create_invoice2 += "Id bmwAccId;"
			_create_invoice2 += "for(Account acc : [select Name from Account]) {"
			_create_invoice2 += "if(acc.Name == '#{$bd_account_bmw_automobiles}')"
			_create_invoice2 += "{bmwAccId = acc.Id;break;}}"
			_create_invoice2 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice inv = new #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.PurchaseInvoice();"
			_create_invoice2 += "inv.Account = #{_namspace_prefix}CODAAPICommon.getRef(bmwAccId, '#{$bd_account_audi}');"
			_create_invoice2 += "inv.InvoiceDate = system.today();"
			_create_invoice2 += "inv.Period = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{PREVIOUS_PERIOD1}');"
			_create_invoice2 += "inv.AccountInvoiceNumber = 'TID021439_002';"
			_create_invoice2 += "inv.InvoiceStatus = #{_namspace_prefix}CODAAPIPurchaseInvoiceTypes_9_0.enumInvoiceStatus.InProgress;"
			
			_create_invoice2 += "inv.ExpLineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItems();"
			_create_invoice2 += "inv.ExpLineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem>();"
						
			_create_invoice2 += "inv.LineItems = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItems();"
			_create_invoice2 += "inv.LineItems.LineItemList = new List<#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem>();"
			
			_create_invoice2 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
			_create_invoice2 += "expLine1.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_gla_marketing}');"
			_create_invoice2 += "expLine1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim1_gbp}');"
			_create_invoice2 += "expLine1.Dimension4 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_harrogate}');"
			_create_invoice2 += "expLine1.NetValue = 100.00;"
			_create_invoice2 += "inv.ExpLineItems.LineItemList.add(expLine1);"
			
			_create_invoice2 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem expLine2 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceExpLineTypes_9_0.PurchaseInvoiceExpenseLineItem();"
			_create_invoice2 += "expLine2.GeneralLedgerAccount = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_gla_sales_parts}');"
			_create_invoice2 += "expLine2.NetValue = 400.00;"
			_create_invoice2 += "inv.ExpLineItems.LineItemList.add(expLine2);"
			
			_create_invoice2 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem prodLine1 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			_create_invoice2 += "prodLine1.Product = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_product_auto_com_clutch_kit_1989_dodge_raider}');"
			_create_invoice2 += "prodLine1.Dimension1 = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_dim1_gbp}');"
			_create_invoice2 += "prodLine1.Quantity = 1.00;"
			_create_invoice2 += "prodLine1.UnitPrice = 100.00;"
			_create_invoice2 += "inv.LineItems.LineItemList.add(prodLine1);"
			
			_create_invoice2 += "#{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem prodLine2 = new #{_namspace_prefix}CODAAPIPurchaseInvoiceLineItemTypes_9_0.PurchaseInvoiceLineItem();"
			_create_invoice2 += "prodLine2.Product = #{_namspace_prefix}CODAAPICommon.getRef(null,'#{$bd_product_a4_paper}');"
			_create_invoice2 += "prodLine2.Quantity = 1.00;"
			_create_invoice2 += "prodLine2.UnitPrice = 200.00;"
			_create_invoice2 += "inv.LineItems.LineItemList.add(prodLine2);"
			
			_create_invoice2 += "#{_namspace_prefix}CODAAPICommon_9_0.Context context = new #{_namspace_prefix}CODAAPICommon_9_0.Context();"
			_create_invoice2 += "context.token = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1', Blob.valueOf('0000000000000000C000000000000046' + UserInfo.getUserId() + 'PROBABLEMENTE EL MEJOR SOFTWARE DE CONTABILIDAD EN EL MUNDO')));"
			
			_create_invoice2 += "Id dto2Id = #{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.CreatePurchaseInvoice(context, inv).Id;"
			_create_invoice2 += "#{_namspace_prefix}CODAAPICommon.Reference purchaseInvoiceIds = #{_namspace_prefix}CODAAPICommon.getRef(dto2Id, null);"
			_create_invoice2 += "#{_namspace_prefix}CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(context, purchaseInvoiceIds );"
			
			APEX.execute_script _create_invoice2
			script_status = APEX.get_execution_status_message
			gen_include $apex_script_executed_successfully_message_value ,script_status, "Expected- successful Apex script execution."
		end
		
		gen_start_test "TST037586 - Verify the TLIs and Total in preview panel on retrieve when From-To option is selected for Account."
		begin
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_timeperiod_period_selection CURRENT_PERIOD, CURRENT_PERIOD
			
			Allocations.click_on_next_button
			 
			gen_compare error_message_no_filter_selected, Allocations.get_toast_message_retrieve, "Error message matched"
			
			Allocations.click_account_filter_fromto_button 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_from_label,$bd_account_audi
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_to_label,$bd_account_audi
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_marketing
			
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			Allocations.click_on_next_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			Allocations.click_on_selected_filter_clear_group_button 1
			Allocations.click_account_filter_fromto_button 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_from_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_to_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			
			Allocations.click_on_next_button
			gen_compare _total_1, Allocations.get_total_value,"Total Value retrieve after filter selection."
			gen_end_test "TST037586 - Verify the TLIs and Total in preview panel on retrieve when From-To option is selected for Account."
		end
		
		gen_start_test "TST037587 - Verify the tlis ans total in preview panel on retrieve when Multiselect option is selected for Account."
		begin
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_timeperiod_period_selection CURRENT_PERIOD, CURRENT_PERIOD
			
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_audi
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_marketing
			
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			Allocations.click_on_next_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			Allocations.click_on_selected_filter_clear_group_button 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			
			Allocations.click_on_next_button
			gen_compare _total_1, Allocations.get_total_value,"Total Value retrieve after filter selection."
			gen_end_test "TST037587 - Verify the tlis ans total in preview panel on retrieve when Multiselect option is selected for Account."
		end
		
		gen_start_test "TST037588 - Verify the tlis ans total in preview panel on retrieve when from to option is selected for Account,GLA and Dimension."
		begin
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_timeperiod_period_selection CURRENT_PERIOD, CURRENT_PERIOD
			Allocations.click_account_filter_fromto_button 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_from_label,$bd_account_audi
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_to_label,$bd_account_audi
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_marketing
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			Allocations.click_on_next_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			Allocations.click_on_selected_filter_clear_group_button 1
			Allocations.click_account_filter_fromto_button 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_from_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_to_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			
			Allocations.click_on_next_button
			gen_compare _total_1, Allocations.get_total_value,"Total Value retrieve after filter selection."
			gen_end_test "TST037588 - Verify the tlis ans total in preview panel on retrieve when from to option is selected for Account,GLA and Dimension."
		end
		
		gen_start_test "TST037589 - Verify the tlis ans total in preview panel on retrieve when Multiselect option is selected for Account,GLA and Dimension."
		begin
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			Allocations.set_allocation_type $alloc_type_label
			Allocations.set_timeperiod_period_selection CURRENT_PERIOD, CURRENT_PERIOD
			
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_audi
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_marketing
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			
			Allocations.click_on_preview_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			Allocations.click_on_next_button
			gen_compare error_message_filter_selection_with_no_results,FFA.get_sencha_popup_error_message,"Amend filters to retrieve TLIs"
			FFA.sencha_popup_click_continue
			gen_compare _zero_total,Allocations.get_total_value,"Total Value retrieve after filter selection."
			Allocations.click_on_selected_filter_clear_group_button 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			Allocations.set_filterset_field_value 1,$alloc_filter_set_dimension2_field_object_label,$alloc_filter_set_multiselect_label,$bd_apex_eur_002
			
			Allocations.click_on_next_button
			gen_compare _total_1, Allocations.get_total_value,"Total Value retrieve after filter selection."
			gen_end_test "TST037589 - Verify the tlis ans total in preview panel on retrieve when Multiselect option is selected for Account,GLA and Dimension."
		end
	
		gen_start_test "TST037590 - Verify the TLIs and total in preview panel after updating the filter criteria in Account field."
		begin
			SF.tab $tab_allocations
			Allocations.allocation_list_view_click_new_button
			Allocations.set_allocation_type $alloc_type_label
			
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_bmw_automobiles
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_stock_parts
			
			Allocations.click_on_next_button
			gen_compare _total_1,Allocations.get_total_value,"Total Value retrieve after filter selection."
			
			Allocations.click_on_back_button
			# Update filter
			Allocations.click_on_selected_filter_clear_group_button 1
			Allocations.set_filterset_field_value 1,$alloc_filter_set_account_field_object_label,$alloc_filter_set_multiselect_label,$bd_account_audi
			Allocations.set_filterset_field_value 1,$alloc_filter_set_gla_field_object_label,$alloc_filter_set_multiselect_label,$bd_gla_sales_parts
			
			Allocations.click_on_next_button
			gen_compare _total_2, Allocations.get_total_value,"Total Value retrieve after filter selection."
			gen_end_test "TST037590 - Verify the TLIs and total in preview panel after updating the filter criteria in Account field."
		end
	end	

	after :all do
		login_user
		Delete Test Data
		FFA.delete_new_data_and_wait
		SF.wait_for_apex_job
		SF.logout
		gen_end_test "TID021439: This TID verifies the TLIs retrieve when user filter specific set of data in single company Mode"
	end
end