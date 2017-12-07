require 'capybara'
require 'capybara/dsl'
require 'rspec/core'
require 'capybara/rspec/matchers'
require 'capybara/rspec/features'
require "selenium-webdriver"
require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require './helpers/general_helper.rb'
require 'rubyXL'
require 'json'


SFUSER = ENV['SFUSERNAME'] ? ENV['SFUSERNAME'] : get_property("sf.username")
SFPASS = ENV['SFPASSWORD'] ? ENV['SFPASSWORD'] : get_property("sf.password") 
DRIVER = ENV['DRIVER'] ? ENV['DRIVER'] : get_property("driver")
BROWSER_PROFILE = ENV['SF.BROWSER_PROFILE'] ? ENV['SF.BROWSER_PROFILE'] : get_property("sf.browser_profile") 
ORG_TYPE = ENV['ORG.TYPE'] ? ENV['ORG.TYPE'] : get_property("org.type") 
ORG_PREFIX = ENV['ORG.PREFIX'] ? ENV['ORG.PREFIX'] : get_property("org.prefix") 
ORG_IS_NAMESPACE = ENV['ORG.IS_NAMESPACE'] ? ENV['ORG.IS_NAMESPACE'] : get_property("org.is_namespace")  
REPORTING_PREFIX = ENV['REPORTING.PREFIX'] ? ENV['REPORTING.PREFIX'] : get_property("reporting.prefix") 
OS_TYPE = ENV['OS_NAME'] ? ENV['OS_NAME'] : get_property("sf.os_type")  
DEFAULT_WAIT = ENV['DEFAULT_WAIT_TIME'] ? ENV['DEFAULT_WAIT_TIME'] : get_property("sf.default_wait_time") 
NOTIFY_TO = ENV['NOTIFY_TO'] ? ENV['NOTIFY_TO'] : get_property("mail.notify_to") 
ORG_IS_LIGHTNING = ENV['ORG.IS_LIGHTNING'] ? ENV['ORG.IS_LIGHTNING'] : get_property("org.is_lightning") 
ORG_IS_ENCRYPTION_ON = ENV['ORG_IS_ENCRYPTION_ON'] ? ENV['ORG_IS_ENCRYPTION_ON'] : get_property("org.enableencryption")

OS_WINDOWS = "windows"
MANAGED = "managed"
UNMANAGED = "unmanaged"
DEBUGGING_MESSAGES = false 
DEFAULT_TIME_OUT = 60

Capybara.register_driver :chrome do |app|
	Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :safari do |app|
	Capybara::Selenium::Driver.new(app, :browser => :safari)
end

Capybara.register_driver :internet_explorer do |app|
  Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
end 

#Browser profiles
FIREFOX_PROFILE1 = "firefox_profile1"
#firefox Profile 1
begin
	$firefox_profile1 = Selenium::WebDriver::Firefox::Profile.new
	if OS_TYPE == OS_WINDOWS
		file_path = Dir.pwd+ "\\testUploadFiles\\"
		filepath = file_path.gsub("/", "\\")
	else
		filepath = Dir.pwd+ '/testUploadFiles/'
	end
	$firefox_profile1['browser.download.folderList'] = 2
	$firefox_profile1['browser.download.dir'] = filepath
	$firefox_profile1['browser.download.downloadDir']=filepath
	$firefox_profile1['browser.download.defaultFolder']=filepath
	$firefox_profile1['browser.helperApps.alwaysAsk.force'] = false
	$firefox_profile1['browser.download.manager.showWhenStarting'] = false
	$firefox_profile1['browser.download.manager.alertOnEXEOpen'] = false
	$firefox_profile1['browser.helperApps.neverAsk.saveToDisk'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet , application/csv , application/json , application/xls , text/csv "
end

if DRIVER == "firefox"
    if BROWSER_PROFILE == NIL || BROWSER_PROFILE ==''
		Capybara.default_driver = :selenium 
	elsif BROWSER_PROFILE == FIREFOX_PROFILE1
		Capybara.register_driver :selenium_custom do |app|
			Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => $firefox_profile1)
		end
		Capybara.default_driver = :selenium_custom
	end
elsif DRIVER == "chrome"
	Capybara.default_driver = :chrome 

elsif DRIVER == "safari"
	Capybara.default_driver = :safari

elsif DRIVER == "internet_explorer"
	Capybara.default_driver = :internet_explorer
end

unless DRIVER == "firefox" || DRIVER == "chrome" || DRIVER == "safari" || DRIVER == "internet_explorer" || DRIVER == "SAUCE"
  raise "You must Have a Valid Driver"
end

Capybara.configure do |config|
	config.app_host = "https://login.salesforce.com"
	config.ignore_hidden_elements = true 
	config.app_host = @url
	config.run_server = false
	config.match =:prefer_exact
	
	if (DEFAULT_WAIT == nil || DEFAULT_WAIT == '')
		config.default_max_wait_time = 4 # the default time is 2 seconds
	else
		config.default_max_wait_time = DEFAULT_WAIT.to_i # as per  value provided in uitest property file.
	end
	if (DRIVER == "firefox" || DRIVER == "chrome" || DRIVER == "safari" || DRIVER == "internet_explorer")
		config.current_session.driver.browser.manage.window.maximize
	end 
end

RSpec.configure do |config|
	config.include Capybara::DSL, :type => :request
	config.include Capybara::DSL, :type => :acceptance
	config.include Capybara::RSpecMatchers, :type => :request
	config.include Capybara::RSpecMatchers, :type => :acceptance
	config.after do
		Capybara.use_default_driver
	end 
  #config.before do    
	#Capybara.current_driver = Capybara.javascript_driver if example.metadata[:js]
	#Capybara.current_driver = example.metadata[:driver] if example.metadata[:driver]
  #end
end

# Code to take screenshot on chrome browser
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

def login_user 
	$current_user = SFUSER
	visit "https://login.salesforce.com"
	gen_accept_alert_if_present
	page.has_text?("Username")
	fill_in "username", with: SFUSER
	fill_in "password", with: SFPASS
	click_button "Login"
	page.has_css?($sf_application_button)
end 
	
shared_context "login" do
	before :all do 
		login_user 
	end
end
shared_context "login_before_each" do
	before :each do 
		login_user
	end
end

shared_context "logout_after_each" do
	# Take screenshot if example has failed.
	after(:each) do |example|
		if example.exception != nil
			puts "#{example.description} failed, taking screenshot"
			screenshot_and_save_page
		end
		SF.logout
	end
end
