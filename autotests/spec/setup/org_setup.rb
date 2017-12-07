#--------------------------------------------------------------------#
#	TID : None 
#	Pre-Requisit: Org with basedata deployed.
#	Product Area: None
# 	Story: None 
#--------------------------------------------------------------------#
describe "Initial Org Setup before starting the execution of Tests.", :type => :feature do
	before :all do
		puts "Org Setup before Test Execution"
	end
	include_context "login"
	_lightning_app_launcher = "[class*=appLauncher]"
	_menu_button = "button[class*=oneUserProfileCardTrigger]"
	_login_access_checkbox = "input[name*=adminsCanLogInAsAny]"
	_session_setting = "//label[text()='Force relogin after Login-As-User']"
	_gbp_currency = "\'#{$bd_currency_gbp}\'"
	_algernon_and_partners_co_ac = "\'#{$bd_account_algernon_partners_co}\'"
	# Set the User Locale to GB / Europe/London
	_user_locale= ""
	_user_locale += "for (Account acc_algernon : [Select Name, Id,"+ORG_PREFIX+"CODAAccountTradingCurrency__c From Account where MirrorName__c = "+_algernon_and_partners_co_ac+"])"
	_user_locale +="{ acc_algernon."+ORG_PREFIX+"CODAAccountTradingCurrency__c = "+_gbp_currency+";"
	_user_locale +="update acc_algernon; }"
	_user_locale +="List<User> smokeUserList= [SELECT Alias,LocaleSidKey,Name,TimeZoneSidKey,Username,LanguageLocaleKey  FROM User ];"
	_user_locale +="for (User usr : smokeUserList)\r\n{ usr.LocaleSidKey='en_GB';"
	_user_locale +="usr.LanguageLocaleKey='en_US'; "
	_user_locale +="usr.TimeZoneSidKey='Asia/Kolkata'; }"
	_user_locale +="update smokeUserList;"
	
	it "Initial Org Setup before starting the execution of Tests" do
		if page.has_css?(_lightning_app_launcher)
			puts "switching to Classic"
			find(_menu_button).click 
			gen_wait_less 
			click_link "Switch to Salesforce Classic"
			gen_wait_less 
			SF.wait_for_search_button 
		else 
			puts "Already in Classic Mode"
		end 

		# Set remote site setting to execute apex command from UI.
		APEX.visit_base_date_page 
		api_url = page.current_url
		SF.remote_site_settings_create_new
		SF.remote_site_settings_set_site_name "SALESFORCE_API"
		SF.remote_site_settings_set_site_url api_url
		SF.remote_site_settings_set_disable_protocol_security "true"  
		SF.click_button_save
		puts "Remote Settings set"

		puts "Update user locale and timezone and language."
		APEX.execute_script _user_locale
		gen_include $apex_script_executed_successfully_message_value ,APEX.get_execution_status_message, "Expected- successful Apex script execution."
		# Collapse the side bar 
		SF.user_interface_option ['Enable Collapsible Sidebar'],true
		SF.click_button_save
		SF.wait_for_search_button
		puts "Collapsible Sidebar Enabled."
		
		# # Enable Admin to log on as other users 
		SF.admin $sf_setup
		find($sf_global_search).set "Login Access Policies"
		SF.click_link "Login Access Policies"
		find(_login_access_checkbox).set true 
		SF.click_button_save
		puts "Admin Can Login-As-User Enabled"
		
		# Diable 
		# Force relogin after Login-As-User
		SF.admin $sf_setup
		find($sf_global_search).set "Session Settings"
		SF.click_link "Session Settings"
		checkbox_id = find(:xpath , _session_setting)[:for]
		uncheck(checkbox_id)
		SF.click_button_save
		puts "Force relogin after Login-As-User Disabled"

	end
	
	#Activate the price book for only managed org.
	it "Activate the Standard PriceBook on Managed org" do
		login_user
		if (ORG_TYPE == MANAGED)
			SF.tab $tab_price_book
			SF.click_button_go
			SF.wait_for_search_button
			FFA.activate_pricebook $bd_pricebook_standard_price_book , true
		end
	end
	
	# disable lightning component org wide, so that all users are on non lightning org.
	it "Disable lightning component on org. " do
		login_user
		SF.disable_lightning_component
	end
	
	# Create new year on org , if it does not exist on org.
	it "Year:create next year for spain company if it does not exist on org." do
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
		# craete new year if it does not exist.
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
			SF.wait_for_search_button
			gen_compare next_year.to_s , YEAR.get_year_name , "TST017670: Expected  periods  to be created successfully for year 2015. "
		end	
	end
	
	after :all do
		gen_end_test "End of ORG setup"
	end
end	
