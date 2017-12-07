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

	# Set the User Locale to GB / Europe/London
	_user_locale =  "User current_user = [select name from User where UserName like  '#{SFUSER}'];"
	_user_locale += "current_user.LocaleSidKey='en_GB';"
	_user_locale += "current_user.TimeZoneSidKey='Europe/London';"
	_user_locale += "update current_user;"

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
	end
	after :all do
		gen_end_test "End of ORG setup"
	end
end	
