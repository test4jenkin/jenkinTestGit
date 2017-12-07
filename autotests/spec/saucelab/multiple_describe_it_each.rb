#--------------------------------------------------------------------#
#	# Example spec
#--------------------------------------------------------------------#

describe "Examples how to use framwork part 1", :type => :request do
	include_context "login_before_each"
	it "select app" do
		# 1. select an app
		SF.app "Sales"
	end 
	it "select tab Home" do
		# 2. single company select 
		SF.tab "Leads"
	end  	
end

describe "Examples how to use framwork part 2", :type => :request do
	include_context "login_before_each"

	it "select admin menu setup" do
		# 3. admin menu 
		SF.admin $sf_my_profile 
		SF.admin $sf_setup 
	end 
	it "logout" do	
		# 4.logout 
		SF.logout
	end 
end
