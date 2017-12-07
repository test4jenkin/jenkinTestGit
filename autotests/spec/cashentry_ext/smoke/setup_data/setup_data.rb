#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisite: Org with basedata deployed.
#  	Product Area: FFA test data setup
# 	Story:  
#--------------------------------------------------------------------#
describe "Smoke Test - Data Setup", :type => :request do
	include_context "login"

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
end
