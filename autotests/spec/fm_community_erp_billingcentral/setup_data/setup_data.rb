#--------------------------------------------------------------------#
#	Pre-Requisite: 
#		a)ERP Package
#		b)Billing Central Package
#		c)Org with basedata and data setup deployed.
#  	Product Area: Accounting - FM Communities
#
#--------------------------------------------------------------------#

describe "Data Setup for FM Community", :type => :request do
	include_context "login"

	#Variables
	object_billing_documents = "Billing Documents"
	object_billing_document = 'Billing Document'
	permission_set = "FM Community - Billing Document"
	billing_document_layout_name = 'Billing Document Layout'
	billing_document_complete_button = 'Complete'
	profile_name = "Customer Community User"
	profile_name_admin = "System Administrator"
    page_layout_billing_central = "Billing Document Layout (Installed Package: FinancialForce Billing Central)"
	page_layout_community = "Billing Document Layout (community)"

	erp_company = "ERP Company"
	_unit_price_400 = "400"
	_unit_price_200 = "200"
	quantity = "1"
	line_description = "Product Line"
	customerReference = "REF 123"
	description_inv = "Billing Document Invoice"
	description_crn = "Billing Document Credit Note"
	date_today =  Time.now.strftime("%d/%m/%Y")
	due_date =  (Time.now + (60*60*24*30)).strftime("%d/%m/%Y")
	
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
    
    it "Enabling user Interface settings before running the tests." do    
        login_user    
        SF.user_interface_option [$user_interface_enable_related_list_hover_link_option , $user_interface_enable_separated_loading_of_related_list_option],false
        SF.click_button $ffa_save_button
        SF.wait_for_search_button
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
	it "Community Management-Tab and permission set assignment." do
		login_user
		SF.manage_community $bd_community_name
		gen_wait_less # wait for new window to appear.
		FFA.new_window do
			SF.select_community_tab [$tab_community_myaccounts]
			SF.assign_community_permission_set [permission_set]
		end
	end	
	
	# Create new Community Contact
	it "Create new community Contact" do
		login_user
		SF.tab $tab_contacts
		SF.select_view $bd_select_view_all_contacts
		full_name = $bd_community_user_last_name + ", "+$bd_community_user_first_name
		SF.click_button_go
		# Only create a new user, if it not created already.
		if (page.has_no_text?(full_name,:wait => DEFAULT_LESS_WAIT))
			SF.log_info "Creating a new user: #{$bd_community_user_first_name} "
			Contacts.click_new_contact
			Contacts.set_frist_name $bd_community_user_first_name
			Contacts.set_last_name $bd_community_user_last_name
			Contacts.set_account_name $bd_account_algernon_partners_co
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
		SF.click_button_save
	end

	# Assign permission set to FM community user
	it "Assign Permisison to Communty user." do
		login_user 
		SF.set_user_permission_set_assignment [permission_set],$bd_community_user_name ,true
	end
	
	# Edit Home Page layout for Customer Community User
	it "Set Home page layout for Customer Community User Profile." do
		login_user 
		SF.set_home_page_layout $bd_customer_community_user_profile, $ffa_community_home_page_layout
	end

	#Add Complete Button to Billing Documents layout
	it "Add Complete Button to Billing Documents layout" do
		login_user
		SF.edit_layout_add_field object_billing_document, billing_document_layout_name, $sf_layout_panel_button, [billing_document_complete_button], $sf_edit_page_layout_target_position_button
	end

	it "Update user timezone and locale of all users." do	
		login_user
		# Update user timezone and locale of all users.
		_command_to_execute= ""
		_command_to_execute +="List<User> UserList= [SELECT Alias,LocaleSidKey,Name,TimeZoneSidKey,Username FROM User];"
		_command_to_execute +="for (User usr : UserList)\r\n{ usr.LocaleSidKey='en_GB';"
		_command_to_execute +="usr.TimeZoneSidKey='Asia/Kolkata'; }"
		_command_to_execute +="update UserList;"
		# Execute command
		APEX.execute_script _command_to_execute
	end	

	#Change layout for Customer Community User to Billing Documents layout
	it "Add Complete Button to Billing Documents layout" do
		login_user
		
		#Change Field Level Security
		# Need to Change Field Level Security only on unmanaged org.
		if (ORG_TYPE != MANAGED)
			assignPS = "PermissionSet ps = new PermissionSet();ps.Label = 'TID021760_Permission_Set';ps.Name = 'TID021760_Permission_Set';insert ps;"
			assignPS += "FieldPermissions fp = new FieldPermissions();fp.SobjectType = 'fferpcore__Company__c';fp.parentid = ps.id;fp.PermissionsRead = true;fp.PermissionsEdit = true;fp.field = 'fferpcore__Company__c.#{ORG_PREFIX}msg_link_ffa_id__c';insert fp;"
			assignPS += "fp = new FieldPermissions();fp.SobjectType = 'fferpcore__BillingDocument__c';fp.parentid = ps.id;fp.PermissionsRead = true;fp.PermissionsEdit = true;fp.field = 'fferpcore__BillingDocument__c.#{ORG_PREFIX}PostingStatus__c';insert fp;"
			assignPS += "fp = new FieldPermissions();fp.SobjectType = 'fferpcore__BillingDocument__c';fp.parentid = ps.id;fp.PermissionsRead = true;fp.field = 'fferpcore__BillingDocument__c.#{ORG_PREFIX}PaymentStatus__c';insert fp;"
			assignPS += "PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = ps.id, AssigneeId = UserInfo.getUserId());insert psa;" 
			APEX.execute_commands [assignPS]
		end
		
		SF.set_page_layout_for_custom_objects object_billing_document,profile_name,page_layout_community
		SF.set_page_layout_for_custom_objects object_billing_document,profile_name_admin,page_layout_billing_central
	end
	
	#Perform Integration in Feature Console and Check Subscription and Publication for BC,ERP and FFA
	it "Perform Integration in Feature Console and Check Subscription and Publication for BC,ERP and FFA" do
		login_user
		SF.tab $fc_tab
		if(page.has_css?($fc_remote_site_button))
			FC.enable_remote_site_settings
		end
		steps = [$fc_step_number_1,$fc_step_number_2]
		FC.enable_feature $fc_feature_erp_publications_and_subscriptions,[$fc_step_number_1]
		FC.enable_feature $fc_feature_bc_publications_and_subscriptions,steps
		FC.enable_feature $fc_feature_ffa_publications_and_subscriptions,steps

		SF.tab $erpsetup_tab
		ERPSETUP.click_tab $erpsetup_tab_publications_and_subscription
		gen_wait_until_object_disappear $erpsetup_sencha_loading_mask
		ERPSETUP.set_publication_and_subscription PRODUCT_NAME_BILLING_CENTRAL, "BillingDocument.Complete"
		ERPSETUP.set_subscription PRODUCT_NAME_BILLING_CENTRAL, "BillingDocument.Completion.Process"
		ERPSETUP.set_publication PRODUCT_NAME_BILLING_CENTRAL, "BillingDocument.Completion.Response"
		ERPSETUP.set_publication_and_subscription PRODUCT_NAME_BILLING_CENTRAL, "WorkQueue.BillingCentral"
		ERPSETUP.set_publication PRODUCT_NAME_ERP, "BillingDocument.Complete"
		ERPSETUP.set_publication PRODUCT_NAME_ERP, "BillingDocument.Completion.Process"
		ERPSETUP.set_subscription PRODUCT_NAME_ERP, "BillingDocument.Completion.Response"
		ERPSETUP.set_subscription PRODUCT_NAME_FFA, "BillingDocument.Complete"
		ERPSETUP.click_button BUTTON_SAVE
		ERPSETUP.click_popup_save_button
	end

	#Create ERP Company
	it "Create ERP Company" do
		login_user
		#Data Setup 1
		script = "List<#{ORG_PREFIX}codaCompany__c> companyID = [SELECT Id FROM #{ORG_PREFIX}codaCompany__c WHERE Name = 'Merlin Auto Spain'];"
		script += "fferpcore__Company__c comp = new fferpcore__Company__c();"
		script += "comp.Name = '#{erp_company}';"
		script += "comp.#{ORG_PREFIX}msg_link_ffa_id__c = companyID[0].Id;"
		script += "insert comp;"
		APEX.execute_commands [script]
	end

	#Create & Post Billing Invoices and Billing Credit Note
	it "Create and Post Billing Invoices , Billing Credit Note" do	
		login_user	
		# Billing Invoice
		begin
			SF.tab $tab_billing_documents
			SF.wait_for_search_button
			SF.click_button_new
			ERPBD.set_document_type DOCUMENT_TYPE_INVOICE
			ERPBD.set_document_account $bd_account_algernon_partners_co
			ERPBD.set_document_date date_today
			ERPBD.set_document_due_date due_date
			ERPBD.set_document_company erp_company
			ERPBD.set_document_customer_reference customerReference
			ERPBD.set_document_description description_inv
			SF.click_button_save
            SF.wait_for_search_button
			document_number_inv = ERPBD.get_document_number
			
			# Add new line
			SF.click_button $erpbd_new_billing_document_line_item
			ERPBD.set_product_on_line $bd_product_a4_paper
			ERPBD.set_unit_price_on_line _unit_price_400
			ERPBD.set_quantity_on_line quantity
			ERPBD.set_description_on_line line_description
			SF.click_button_save
			gen_click_link_and_wait document_number_inv
			
			#Complete the document
			gen_compare BILLING_DOCUMENT_STATUS_DRAFT, ERPBD.get_document_status, "Expected Billing Invoice status to be Draft"
			SF.click_button $erpbd_complete_button
			SF.wait_for_search_button
			#Click Complete on intermediate page
			SF.click_button $erpbd_complete_button
			SF.wait_for_search_button
			gen_compare BILLING_DOCUMENT_STATUS_COMPLETE, ERPBD.get_document_status, "Expected Billing Invoice Document status to be Complete"
		end
		
		# Billing credit note
		begin
			SF.tab $tab_billing_documents
			SF.wait_for_search_button
			SF.click_button_new
			ERPBD.set_document_type DOCUMENT_TYPE_CREDIT_NOTE
			ERPBD.set_document_account $bd_account_algernon_partners_co
			ERPBD.set_document_date date_today
			ERPBD.set_document_due_date due_date
			ERPBD.set_document_company erp_company
			ERPBD.set_document_customer_reference customerReference
			ERPBD.set_document_description description_crn
			SF.click_button_save
            SF.wait_for_search_button
			document_number_crn = ERPBD.get_document_number
			
			# Add new line
			SF.click_button $erpbd_new_billing_document_line_item
			ERPBD.set_product_on_line $bd_product_a4_paper
			ERPBD.set_unit_price_on_line _unit_price_200
			ERPBD.set_quantity_on_line quantity
			ERPBD.set_description_on_line line_description
			SF.click_button_save
			gen_click_link_and_wait document_number_crn
			
			#Complete the document
			gen_compare BILLING_DOCUMENT_STATUS_DRAFT, ERPBD.get_document_status, "Expected Billing Credit Note status to be Draft"
			SF.click_button $erpbd_complete_button
			SF.wait_for_search_button
			#Click Complete on intermediate page
			SF.click_button $erpbd_complete_button
			SF.wait_for_search_button
			
			gen_compare BILLING_DOCUMENT_STATUS_COMPLETE, ERPBD.get_document_status, "Expected Billing Credit Note Document status to be Complete"
		end

		#Post the Billing Documents
		begin
			# Run Background posting scheduler and wait for apex job to complete
			SF.tab $tab_background_posting_scheduler
			SF.wait_for_search_button
			SF.click_button $ffa_run_now_button
			page.has_text?($ffa_msg_executing_background_posting)
			gen_compare $ffa_msg_executing_background_posting , FFA.ffa_get_info_message , "Expected message to be Background posting executing now."
			SF.wait_for_apex_job
		end
	end

    # Assign accounting license to community user.
    it "Assign accounting license to community user." do
        login_user
        # Need to assign the package license only on managed org.
        if (ORG_TYPE == MANAGED)
            SF.assign_license $financial_force_accounting_license , $bd_community_user_alias
        end
    end
end