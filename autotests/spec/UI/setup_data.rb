#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisite: Org with basedata deployed.
#  	Product Area: FFA UI test data setup extension
# 	Story:  
#--------------------------------------------------------------------#
describe "UI Test - Extended Data Setup", :type => :request do
	include_context "login"
	_erp_namespace_prefix = "fferpcore" 
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
	
	it "Activate the Standard PriceBook on Managed org" do
		login_user
		if (ORG_TYPE == MANAGED)
			SF.tab $tab_price_book
			SF.click_button_go
			SF.wait_for_search_button
			FFA.activate_pricebook $bd_pricebook_standard_price_book , true
		end
	end
	
	# Hide companies and tax codes tabs from ERP package on managed org.
	it "Hide duplicate tab on managed org." do
		login_user
		if (ORG_TYPE == MANAGED)
			SF.hide_duplicate_tab $bd_user_admin_user ,$tab_companies , _erp_namespace_prefix
			SF.click_button_save
			SF.hide_duplicate_tab $bd_user_admin_user ,$tab_tax_codes , _erp_namespace_prefix
			SF.click_button_save
		end
	end
	
	it "Create Next if it doesn't exist" do
		login_user
		current_year = (Time.now).year
		next_year = current_year+1
		SF.tab $tab_years
		SF.select_view $bd_select_view_company_ff_merlin_auto_spain
		SF.click_button_go
		year_not_exist=true
		
		within(find($year_list_grid)) do
			if page.has_text?(next_year.to_s)
				year_not_exist=false
			end
		end
		
		if year_not_exist
			SF.tab $tab_years
			SF.click_button_new
			YEAR.set_year_name next_year.to_s
			YEAR.set_start_date  "01/01/"+next_year.to_s
			YEAR.set_year_end_date  "31/12/"+next_year.to_s
			YEAR.set_number_of_periods "12"
			YEAR.select_period_calculation_basis $bd_period_calculation_basis_month_end
			SF.click_button_save
			SF.wait_for_search_button
			#calculate periods
			YEAR.click_calculate_periods_button
			gen_include $ffa_msg_calculate_period_confirmation, FFA.ffa_get_info_message , "TST017670: Expected a confirmation message for calculating periods."
			#confirm the process
			YEAR.click_calculate_periods_button
			gen_compare next_year.to_s , YEAR.get_year_name , "TST017670: Expected  periods  to be created successfully for year 2015. "
		end	
	end
end
