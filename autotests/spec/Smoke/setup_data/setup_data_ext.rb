#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisit: Org with basedata and data setup deployed.
#  	Product Area: ffa smoke test data setup extension
# 	Story:  
#--------------------------------------------------------------------#

describe "Smoke Test - Extended Data Setup", :type => :request do
	include_context "login"
		_erp_namespace_prefix = "fferpcore" 
		_layout_name = "Opportunity Layout"
		_gbp_currency = "\'#{$bd_currency_gbp}\'"
		_algernon_and_partners_co_ac = "\'#{$bd_account_algernon_partners_co}\'"
		_merlin_auto_spain = "\'#{$company_merlin_auto_spain}\'"
		account_layout_fields_to_add =[$account_trading_currency_label,$account_merge_id_label,$account_currency_label]
										
		sales_inv_extended_layout_fields_to_add = [$tax_code_combined_taxcode_label,$sinx_derive_unit_price_from_product_label]
		product_layout_fields_to_add = [$product_sales_revenue_account_label]
		currency_layout_fields_to_add = [$acc_curr_currency_label]
		sales_invoice_layout_fields_to_add = [$ffa_print_pdf_button]
		opportunities_layout_fields_to_add = [$opp_create_invoice_button]
		bank_account_layout_fields_to_add = [$ba_sort_code_label,$ba_swift_number_label,$ba_iban_label,$ba_direct_debit_originator_reference_label]
		fm_community_transaction_target_value = "#{ORG_PREFIX}Transaction__c.#{ORG_PREFIX}Account__c"

	it "Assigning Financial force layout to Product and Account Object for Admin User" do
		puts "Assigning FFA layout to Product Object"
		SF.set_page_layout_for_standard_objects $ffa_objects_products,$ffa_profile_system_administrator,$ffa_financialforce_product_layout
		puts "Assigning FFA layout to Account Object"
		SF.set_page_layout_for_standard_objects $ffa_object_accounts,$ffa_profile_system_administrator,$ffa_financialforce_account_layout
	end
	
	it "Adding required fields/buttons on account layout" do	
		login_user
		# add fields on account
		puts "adding field on account layout"
		SF.stdobj_edit_layout_add_field $ffa_object_accounts, $ffa_financialforce_account_layout, $sf_layout_panel_fields, account_layout_fields_to_add, $sf_edit_page_layout_target_position
	end
	
	it "Add currency at accounting currency" do
		login_user
		puts "adding field on curreny layout"
		SF.edit_layout_add_field $ffa_object_accounting_currency, $label_currency_layout, $sf_layout_panel_fields, currency_layout_fields_to_add, $sf_edit_page_layout_target_position
	end	

	# set remote site settings on org.
	it "set remote site setting to execute apex command from UI." do	
		login_user
		#get page URL for salesforce API Usage 
		url_prefix = page.current_url.split('/')[0]
		url_host = page.current_url.split('/')[2]
		run_anonymous_url = url_prefix +"//"+url_host+"/apex/BaseDataJob"
		visit run_anonymous_url
		gen_wait_until_object $apex_delete_new_data_button      
		api_url = page.current_url
		SF.remote_site_settings_create_new
		SF.remote_site_settings_set_site_name "SALESFORCE_API"
		SF.remote_site_settings_set_site_url api_url
		SF.remote_site_settings_set_disable_protocol_security "true"  
		SF.click_button_save
	end
	
	it "Assign FFR license to accountant user" , :run=>true  do
		# Trimming the __ suffix of package 
		ffr_package_namespace = REPORTING_PREFIX.tr('__','')
		login_user
		package_query = "SELECT Id FROM PackageLicense where NamespacePrefix  = '#{ffr_package_namespace}'"
		APEX.execute_soql package_query
		soql_results = APEX.get_execution_status_message
		expected_result_with_one_item = "totalSize\":1,"
		#Assign FFR package only when FFR package is installed.
		if soql_results.include? expected_result_with_one_item
			puts "Assigning FFR license to Accountant."
			SF.assign_license $financial_force_reporting_license , $bd_user_accountant_alias
		else
			puts "WARNING: FFR Package is not installed on org."
		end
	end

	it "Add fields on sales invoice line item-extended layout" do
		login_user
		# Add fields on sales invoice line item extended layout
		puts "Adding field on sales invoice line item extended layout"
		SF.edit_layout_add_field $ffa_object_sales_invoice_line_item, $ffa_invoice_line_item_extended_layout, $sf_layout_panel_fields, sales_inv_extended_layout_fields_to_add, $sf_edit_page_layout_target_position
	end
	
	it "Adding fields on sales invoice extended layout" do
		login_user
		puts "adding field on sales invoice extended layout"
		# Add buttons on sales invoice extended layout
		SF.edit_layout_add_field $ffa_object_sales_invoice, $ffa_sales_invoice_extended_layout, $sf_layout_panel_button, sales_invoice_layout_fields_to_add, $sf_edit_page_layout_target_position_button
	end
	
	it "Add Create invoice button to opportunity layout" do	
		login_user
		SF.stdobj_edit_layout_add_field $tab_opportunities, $ffa_opportunity_layout, $sf_layout_panel_button, opportunities_layout_fields_to_add, $sf_edit_page_layout_target_position_button
	end

	it "Update Bank Account details" do	
		login_user
		SF.edit_layout_add_field $ffa_object_bank_account, $ffa_bank_layout, $sf_layout_panel_fields, bank_account_layout_fields_to_add, $sf_edit_page_layout_target_position
	end
	
	it "update Account Trading currency of Algernon and Partners Co and update user timezone and locale of all users" do	
		login_user
		# update Account Trading currency of Algernon and Partners Co and update user timezone and locale of all users.
		_command_to_execute= ""
		_command_to_execute += "for (Account acc_algernon : [Select Name, Id,"+ORG_PREFIX+"CODAAccountTradingCurrency__c From Account where MirrorName__c = "+_algernon_and_partners_co_ac+"])"
		_command_to_execute +="{ acc_algernon."+ORG_PREFIX+"CODAAccountTradingCurrency__c = "+_gbp_currency+";"
		_command_to_execute +="update acc_algernon; }"
		_command_to_execute +="List<User> smokeUserList= [SELECT Alias,LocaleSidKey,Name,TimeZoneSidKey,Username,LanguageLocaleKey  FROM User ];"
		_command_to_execute +="for (User usr : smokeUserList)\r\n{ usr.LocaleSidKey='en_GB';"
		_command_to_execute +="usr.LanguageLocaleKey='en_US'; "
		_command_to_execute +="usr.TimeZoneSidKey='Asia/Kolkata'; }"
		_command_to_execute +="update smokeUserList;"
		# Execute command
		APEX.execute_script _command_to_execute
		gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."
	end	
	
	it "Enabling user Interface settings before running the smoke tests." do	
		login_user	
		SF.user_interface_option [$user_interface_enable_related_list_hover_link_option , $user_interface_enable_separated_loading_of_related_list_option],false
		SF.click_button $ffa_save_button
		SF.wait_for_search_button
	end
	
	it "Enabling accounting app for standard user" do
		login_user
		SF.retry_script_block do 
			SF.check_custom_app_setting [$accounting], $ffa_profile_standard_user , true
			SF.click_button $ffa_save_button
		end
		SF.wait_for_search_button
	end
	
	
	it "update admin user first and last name." do
		login_user
		_command_to_update_admin_name= ""
		_command_to_update_admin_name +="User adminuser= [select Id,FirstName, LastName from User where Username  ='#{SFUSER}'];"
		_command_to_update_admin_name +="adminuser.FirstName='System'; adminuser.LastName='Administrator';"
		_command_to_update_admin_name +="update adminuser;"
		# Execute command
		APEX.execute_script _command_to_update_admin_name
		gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."
	end
	
	it "Activate the Standard PriceBook on Managed org" do
		login_user
		if (ORG_TYPE == MANAGED)
			SF.tab $tab_price_book
			SF.click_button_go
			SF.wait_for_search_button
			FFA.activate_pricebook $bd_pricebook_standard_price_book , true
		end
	end
	
	it "Create Intersect definition." do
		login_user
		_command_to_create_intersect_definition= ""
		_command_to_create_intersect_definition += "List<#{ORG_PREFIX}codaIntersectDefinition__c> idList = new List<#{ORG_PREFIX}codaIntersectDefinition__c>();"
		_command_to_create_intersect_definition += "idList.add(new #{ORG_PREFIX}codaIntersectDefinition__c(Name = 'FAC', #{ORG_PREFIX}Dimension1__c = false, #{ORG_PREFIX}Dimension2__c = false, #{ORG_PREFIX}Dimension3__c = false, #{ORG_PREFIX}Dimension4__c = false, #{ORG_PREFIX}Entity__c = false, #{ORG_PREFIX}FullAccountingCode__c = true, #{ORG_PREFIX}GeneralLedgerAccount__c = false));"
		_command_to_create_intersect_definition += "idList.add(new #{ORG_PREFIX}codaIntersectDefinition__c(Name = 'GLA',  #{ORG_PREFIX}Dimension1__c = false, #{ORG_PREFIX}Dimension2__c = false, #{ORG_PREFIX}Dimension3__c = false, #{ORG_PREFIX}Dimension4__c = false, #{ORG_PREFIX}Entity__c = false,  #{ORG_PREFIX}FullAccountingCode__c = false,  #{ORG_PREFIX}GeneralLedgerAccount__c = true));"
		_command_to_create_intersect_definition += "idList.add(new #{ORG_PREFIX}codaIntersectDefinition__c(Name = 'DIMENSIONSGLA', #{ORG_PREFIX}Dimension1__c = true, #{ORG_PREFIX}Dimension2__c = true, #{ORG_PREFIX}Dimension3__c = true, #{ORG_PREFIX}Dimension4__c = false,#{ORG_PREFIX}Entity__c = false, #{ORG_PREFIX}FullAccountingCode__c = false,  #{ORG_PREFIX}GeneralLedgerAccount__c = true));"
		_command_to_create_intersect_definition += "insert idList;"
		# Execute command
		APEX.execute_script _command_to_create_intersect_definition
		gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution for creating intersect definition."
	end
	
	it "Updating purchasing analysis Account Value of Product Dell PC on [Unmanaged or Namespace] org" do
		login_user	
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			puts "Updating purchasing analysis Account Value of Product Dell PC on Unmanaged Org"
			_command_to_update_purchase_analysis_account= ""
			_command_to_update_purchase_analysis_account+= "codaGeneralLedgerAccount__c gla1 = [select Id from codaGeneralLedgerAccount__c where Name='#{$bd_gla_stock_parts}'];"
			_command_to_update_purchase_analysis_account+= "Product2 prodToUpdate = [select Id,CODAPurchaseAnalysisAccount__c from Product2 where Name='#{$bd_product_dell_pc}'];"
			_command_to_update_purchase_analysis_account+= "prodToUpdate.CODAPurchaseAnalysisAccount__c =gla1.Id;"
			_command_to_update_purchase_analysis_account+= "update prodToUpdate;"
			APEX.execute_script _command_to_update_purchase_analysis_account
			gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution for UPDATING purchase analysis account on un managed org."	
		end
	end
	
	it "Updating tax rate for City Tax Code on [Unmanaged or Namespace] org" do
		login_user	
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			_command_to_execute= ""
		    _command_to_execute +=" codaTaxRate__c  citytaxcoderate = [select id,Rate__c from codaTaxRate__c where TaxCode__r.name='#{$bd_tax_code_city_tax_code_sut}'];"
		    _command_to_execute +=" citytaxcoderate.Rate__c = 8.250;"
		    _command_to_execute +=" update citytaxcoderate; "
			APEX.execute_script _command_to_execute	
			gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution for UPDATING citytax code rate in un managed org."					  
		end
	end
	
	it "Creating new GLA GLA Suspense and Retained Earning on [Unmanaged or Namespace] org" do
		login_user	
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			puts "Create suspense and retained earning GLA on unmanaged org"
			_command_to_create_gla= ""
			_command_to_create_gla+= "codaGeneralLedgerAccount__c Gla1= new codaGeneralLedgerAccount__c();"
			_command_to_create_gla+= "Gla1.Name='#{$bdu_gla_suspense}'; Gla1.Type__c=CODAGeneralLedgerAccount.TYPE_PROFITANDLOSS;"
			_command_to_create_gla+= "Gla1.ReportingCode__c='SUSP'; Gla1.CurrencyIsoCode='#{$bdu_currency_eur}';"
			_command_to_create_gla+= "Gla1.BalanceSheet1__c=CODAGeneralLedgerAccount.BALANCESHEET1_BALANCESHEET;"
			_command_to_create_gla+= "Gla1.BalanceSheet2__c=CODAGeneralLedgerAccount.BALANCESHEET2_CURRENTLIABILITIES;"
			_command_to_create_gla+= "Gla1.BalanceSheet3__c=CODAGeneralLedgerAccount.BALANCESHEET3_CREDITORS;"
			_command_to_create_gla+= "Gla1.TrialBalance1__c=CODAGeneralLedgerAccount.TRIALBALANCE1_BALANCESHEET;"
			_command_to_create_gla+= "Gla1.TrialBalance2__c=CODAGeneralLedgerAccount.TRIALBALANCE2_CURRENTLIABILITIES;"
			_command_to_create_gla+= "Gla1.TrialBalance3__c=CODAGeneralLedgerAccount.TRIALBALANCE1_BALANCESHEET;"
			_command_to_create_gla+= "insert Gla1;"
			_command_to_create_gla+= "codaGeneralLedgerAccount__c Gla2= new codaGeneralLedgerAccount__c();"
			_command_to_create_gla+= "Gla2.Name='#{$bdu_gla_retained_earnings}'; Gla2.Type__c=CODAGeneralLedgerAccount.TYPE_RETAINEDEARNINGS;"
			_command_to_create_gla+= "Gla2.ReportingCode__c='RE'; Gla2.CurrencyIsoCode='#{$bdu_currency_eur}';"
			_command_to_create_gla+= "Gla2.BalanceSheet1__c=CODAGeneralLedgerAccount.BALANCESHEET1_BALANCESHEET;"
			_command_to_create_gla+= "Gla2.BalanceSheet2__c=CODAGeneralLedgerAccount.BALANCESHEET2_SHAREHOLDERSFUNDS;"
			_command_to_create_gla+= "Gla2.BalanceSheet3__c=CODAGeneralLedgerAccount.BALANCESHEET3_CAPITALANDRESERVES;"
			_command_to_create_gla+= "Gla2.TrialBalance1__c=CODAGeneralLedgerAccount.TRIALBALANCE1_BALANCESHEET;"
			_command_to_create_gla+= "Gla2.TrialBalance2__c=CODAGeneralLedgerAccount.TRIALBALANCE2_SHAREHOLDERSFUNDS;"
			_command_to_create_gla+= "Gla2.TrialBalance3__c=CODAGeneralLedgerAccount.TRIALBALANCE3_CAPITALANDRESERVES;"
			_command_to_create_gla+= "insert Gla2;"
			APEX.execute_script _command_to_create_gla
			gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution for UPDATING purchase analysis account on un managed org."	
		end
	end
	
	it "update discount and offset value for account algernon and partners co on [Unmanaged or Namespace]" do	
		login_user
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			puts "update discount and offset value for account algernon and partners co as per unmanaged org."
			_command_to_execute= ""
			_command_to_execute += "for (Account acc_algernon : [Select Name, Id,"+ORG_PREFIX+"CODADiscount1__c,"+ORG_PREFIX+"CODADaysOffset1__c From Account where MirrorName__c = "+_algernon_and_partners_co_ac+"])"  
			_command_to_execute +="{ acc_algernon."+ORG_PREFIX+"CODADiscount1__c = 1;"
			_command_to_execute +="{ acc_algernon."+ORG_PREFIX+"CODADaysOffset1__c = 10;"
			_command_to_execute +="update acc_algernon; }}"
			# Execute command
			APEX.execute_script _command_to_execute
			gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."
		end
	end
	
	it "update days offset, description, discount and basedate value for Merlin Auto spain company on [Unmanaged or Namespace]" do	
		login_user
		if (ORG_TYPE == UNMANAGED or ORG_IS_NAMESPACE == "true")
			puts "update days offset, description, discount and basedate value for Merlin Auto spain company as per unmanaged org."
			_command_to_execute= ""
			_command_to_execute += "for (codacompany__c  com_merlin_auto_spain : [Select Name, Id,"+ORG_PREFIX+"CODADescription1__c,"+ORG_PREFIX+"CODADescription2__c,"+ORG_PREFIX+"codadaysoffset1__c,"+ORG_PREFIX+"codadaysoffset2__c,"+ORG_PREFIX+"codabasedate1__c,"+ORG_PREFIX+"codabasedate2__c,"+ORG_PREFIX+"codadiscount1__c,"+ORG_PREFIX+"codadiscount2__c From codacompany__c  where Name = "+_merlin_auto_spain+"])"  
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"CODADescription1__c = 'Standard Terms';"
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"CODADescription2__c = 'Standard Terms';"
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"codadaysoffset1__c = 30;"
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"codadaysoffset2__c = 7;"
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"codabasedate1__c = 'Invoice Date';"
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"codabasedate2__c = 'Invoice Date';"
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"codadiscount1__c = 0.00;"
			_command_to_execute +="{ com_merlin_auto_spain."+ORG_PREFIX+"codadiscount2__c = 5.00;"
			_command_to_execute +="update com_merlin_auto_spain; }}}}}}}}"
			# Execute command
			APEX.execute_script _command_to_execute
			gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."
		end	
	end
	
	it "Add company column in the search lookup for year" do
		login_user
		SF.add_field_to_search_layout $budget_and_balances_year_label,$bd_search_layout_lookup_dialogs, $company_label	
	end	
	
	# new view for merlin auto usa- sales credit note
	it "Create new view for merlin auto usa company to display sales tax and status for sales credit note." do
		login_user
		SF.tab $tab_sales_credit_notes
		fields_name = [$label_credit_note_number,$label_sales_tax_status,$label_credit_note_status]
		FFA.create_new_view $bd_new_view_auto_usa_sales_tax_calculation ,fields_name
	end
	
	# new view for merlin auto usa- sales invoice.
	it "Create new view for merlin auto usa company to display sales tax and status for Sales Invoice." do
		login_user
		SF.tab $tab_sales_invoices
		fields_name = [$label_invoice_number,$label_sales_tax_status,$label_invoice_status]
		FFA.create_new_view $bd_new_view_auto_usa_sales_tax_calculation ,fields_name
	end
	
	# Enable and setup community
	it "Enable and setup a new community." do
		login_user
		# To make the community and domain name unique.
		current_time = Time.now
		$bd_community_domain_name = $bd_community_domain_name + current_time.nsec.to_s
		$bd_community_name = $bd_community_name + current_time.nsec.to_s
		SF.enable_community $bd_community_domain_name
		SF.set_user_role SFUSER , $bd_user_ceo_role
		SF.setup_community $bd_community_name, $bd_community_sf_vf_template
	end	
	
	# community management
	it "Community Management-Assign Tab." do
		login_user
		begin
			# Open the new window to add permission set 
			new_window_instance = window_opened_by do
				SF.manage_community $bd_community_name
			end
			gen_wait_less # wait for new window to appear.
			within_window (new_window_instance) do
				SF.select_community_tab [$tab_community_myaccounts]
				FFA.close_new_window
			end
		# "a is null" exception is generated after completing all the steps without impacting the script.So handling it in rescue.
		rescue Exception => e
			if e.message.include?("a is null") then
			   SF.log_info ("a is null is known issue with capybara,error skipped")
			else
			   raise e
			end
		end
	end	
	
	# community management
	it "Community Management-permission set assignment." do
		login_user
		begin
			# Open the new window to add permission set 
			new_window_instance = window_opened_by do
				SF.manage_community $bd_community_name
			end
			gen_wait_less # wait for new window to appear.
			within_window (new_window_instance) do
				SF.assign_community_permission_set [$ffa_community_permission_fm_community]
				FFA.close_new_window
			end
		# "a is null" exception is generated after completing all the steps without impacting the script.So handling it in rescue.
		rescue Exception => e
			if e.message.include?("a is null") then
			   SF.log_info ("a is null is known issue with capybara,error skipped")
			else
			   raise e
			end
		end
	end
	
	# Create new Community Contact
	it "Create new community Contact" do
		login_user
		SF.tab  $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		SF.click_button_go
		# Only create a new user, if it not created already.
		if (page.has_no_text?(full_name,:wait => DEFAULT_LESS_WAIT))
			SF.log_info "Creating a new user: #{$bd_community_user_first_name} "
			Contacts.click_new_contact
			Contacts.set_frist_name $bd_community_user_first_name
			Contacts.set_last_name $bd_community_user_last_name
			Contacts.set_account_name $bd_account_bolinger
			Contacts.save
		end
	end	
	
	# Enable new contact as community user
	it "Enable new contact as community user" do
		login_user 
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		SF.tab  $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		SF.click_button_go
		Contacts.open_contact_detail_page full_name
		Contacts.manage_external_user $contacts_enable_customer_user_label
		USER.set_email $bd_community_user_name
		USER.select_license $bd_customer_community_license
		USER.select_profile $bd_customer_community_user_profile
		USER.select_user_language $bd_user_english_language
		USER.select_user_timezone $bd_user_asia_kolkata_timezone
		USER.select_user_locale $bd_user_english_uk_locale
		SF.click_button_save
	end

	# Assign permission set to FM community user
	it "Assign Permisison to Communty user." do
		login_user 
		SF.set_user_permission_set_assignment [$ffa_community_permission_fm_community],$bd_community_user_name ,true
	end
	
	# Assign permission set to FM community user
	it "Add Sharing setting to Community." do
		login_user 
		SF.admin $sf_setup
		SF.set_global_search $sf_fm_community_setting_label
		SF.click_link $sf_fm_community_setting_label
		find($sf_community_new_sharing_setting_button).click
		SF.set_community_sharing_setting_name $bd_community_sharing_set_name
		SF.select_community_sharing_profile [$bd_customer_community_user_profile]
		SF.select_community_sharing_objects	[$ffa_object_sales_invoice, $ffa_object_sales_credit_note, $ffa_object_cash_entry]
		SF.setup_configure_access $ffa_object_cash_entry,$bd_community_account_user,fm_community_transaction_target_value,$bd_community_read_only_access
		SF.setup_configure_access $ffa_object_sales_invoice,$bd_community_account_user,fm_community_transaction_target_value,$bd_community_read_only_access
		SF.setup_configure_access $ffa_object_sales_credit_note,$bd_community_account_user,fm_community_transaction_target_value,$bd_community_read_only_access
		first(:button, $sf_save_button).click
	end
	
	# Edit Home Page layout for Customer Community User
	it "Set Home page layout for Customer COmmunity User Profile." do
		login_user 
		SF.set_home_page_layout $bd_customer_community_user_profile, $ffa_community_home_page_layout
	end
	
	# Edit transaction Line Item layout for chart of account validations
	it "Add fields on transaction line item layout." do
		login_user 
		tranx_fields = [ $trans_local_gla_label, $trans_local_gla_currency_label, $trans_local_gla_value_label]
		SF.edit_layout_add_field $ffa_object_transaction_line_item, $ffa_financialforce_transaction_line_item_layout, $sf_layout_panel_fields,tranx_fields, $sf_edit_page_layout_target_position
	end
	
	# Assign accounting license to community user.
	it "Assign accounting license to community user." do
		login_user
		# Need to assign the package license only on managed org.
		if (ORG_TYPE == MANAGED)
			SF.assign_license $financial_force_accounting_license , $bd_community_user_alias
		end
	end
	
	# Hide companies and tax codes tabs from ERP package on managed org.
	it "Hide duplicate tab on manahed org." do
		login_user
		if (ORG_TYPE == MANAGED)
			SF.hide_duplicate_tab $bd_user_admin_user ,$tab_companies , _erp_namespace_prefix
			SF.click_button_save
			SF.hide_duplicate_tab $bd_user_admin_user ,$tab_tax_codes , _erp_namespace_prefix
			SF.click_button_save
		end
	end
	
	# Enable payment plus feature on org 
	it "Payment Plus: Enable payment plus feature on org through feature console tab. " do
		# Trimming the __ suffix of package 
		erp_package_prefix = $ffa_erp_package_prefix.tr('__','')
		login_user
		#Enable Payment Plus on org using feature console.
		package_query = "SELECT Id FROM PackageLicense where NamespacePrefix  = '#{erp_package_prefix}'"
		APEX.execute_soql package_query
		soql_results = APEX.get_execution_status_message
		expected_result_with_one_item = "totalSize\":1,"
		#Enable feature console features only when ERP package is installed on org.
		if soql_results.include? expected_result_with_one_item
			SF.tab $fc_tab
			SF.wait_for_search_button
			FC.enable_remote_site_settings
			FC.open_feature $fc_feature_ffa_enable_spring_18
			#Enable override of payment page to paymentview
			SF.click_link ACTION_MARK_AS_DONE
			gen_wait_until_object_disappear $fc_in_progress_indicator
			page.has_css?($page_vf_message_text)
			SF.click_link ACTION_PERFORM
			gen_wait_until_object_disappear $fc_in_progress_indicator
			page.has_css?($page_vf_message_text)
		else
			puts "WARNING:ERP Package not installed on ORG"
		end
	end
end

