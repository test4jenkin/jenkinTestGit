#--------------------------------------------------------------------#
#	# Example 1
#--------------------------------------------------------------------#

describe "Examples how to use framwork part 1", :type => :request do
	include_context "login"
	it "select app" do
		# 1. select an app
		SF.app "Sales"
		# 2. single company select 
		SF.tab "Leads"
		# 3. admin menu 
		SF.admin $sf_my_profile 
		SF.admin $sf_setup 
		# 4.logout 
		SF.logout
	end
end
