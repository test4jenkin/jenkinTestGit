require './helpers/mailer_helper.rb'
require './helpers/general_helper.rb'

$default_status_file_name="examples.txt"
$default_log_name="LogExamples.txt"
NOTIFY_TO = ENV['NOTIFY_TO'] ? ENV['NOTIFY_TO'] : get_property("mail.notify_to") 
STATUS_FILE = ENV['STATUS_FILE'] ? ENV['STATUS_FILE'] : $default_status_file_name
LOG_FILE = ENV['LOG_FILE'] ? ENV['LOG_FILE'] : $default_log_name

puts "sending email of test result to: #{NOTIFY_TO}" 
if  !(NOTIFY_TO =="" || NOTIFY_TO == nil)
	to = NOTIFY_TO
	from = "Auto Tester(do not reply)"
	subject = "AutoTester:FFA Capybara_Test_Run_Results #{Time.now.strftime("%d/%m/%Y")} "
	body = "Capybara script execution : #{ARGV[0]}"
	file_path1=  STATUS_FILE
	file_path2=  LOG_FILE
	MAIL.sendmail to, from, subject, body, file_path1,file_path2,ARGV
	puts "email sent successfully"
else
	puts "email skipped as NOTIFY_TO property not set"
end