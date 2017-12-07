#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisite: Org with basedata deployed.
#  	Product Area: FFA test data setup
# 	Story:  
#--------------------------------------------------------------------#
describe "Bank Format:Smoke Test - Data Setup", :type => :request do
	include_context "login"
	
	bank_account_layout_fields_to_add = [$ba_sort_code_label,$ba_swift_number_label,$ba_iban_label,$ba_direct_debit_originator_reference_label]
	
	it "Enabling user Interface settings before running scripts" do
		puts "Enabling user Interface settings before running scripts"
		begin
			SF.user_interface_option [$user_interface_enable_related_list_hover_link_option , $user_interface_enable_separated_loading_of_related_list_option],false
			SF.click_button $ffa_save_button
			SF.wait_for_search_button
		end
	end

	it	"set remote site setting to execute apex command from UI." do
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
	
	it "Assigning Financial force layout to Account Object for Admin User" do
		login_user
		puts "Assigning FFA layout to Account Object"
		SF.set_page_layout_for_standard_objects $ffa_object_accounts,$ffa_profile_system_administrator,$ffa_financialforce_account_layout
	end
	
	it "Add bank account fields on layout." do	
		login_user
		SF.edit_layout_add_field $ffa_object_bank_account, $ffa_bank_layout, $sf_layout_panel_fields, bank_account_layout_fields_to_add, $sf_edit_page_layout_target_position
	end
	
	
	it "Adding generate bank file button on payment list view." do
		login_user
		puts "Add Generate FIle Button on Payment List view"
		SF.add_buttons_to_list_view_layout $ffa_object_payment, $ffa_financialforce_payments_list_view_layout , [$pay_generate_bank_file_button]
	end
end
