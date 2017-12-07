#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisit: Org with basedata deployed.
#   Packages : Lockbox
#  	Product Area: Accounting LockBox
#--------------------------------------------------------------------#

describe "LOCKBOX-Smoke Test - Setup", :type => :request do
	include_context "login"	
	it	"set remote site setting to execute apex command from UI." do
		SF.retry_script_block do
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
end
