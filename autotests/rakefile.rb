require 'rspec/core/rake_task'
require './helpers/general_helper.rb'

$default_status_file_name="Examples.txt"
STATUS_FILE = ENV['STATUS_FILE'] ? ENV['STATUS_FILE'] : $default_status_file_name
ORG_TYPE = ENV['ORG.TYPE'] ? ENV['ORG.TYPE'] : get_property("org.type") 
task :default =>[:alltests]

task :createdata do
  puts "Create Data for UI Action View / RCP Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/actionviews/data_*.rb'
  end
  Rake::Task["spec"].execute
end
task :dataview do
  puts "Running Dataview Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/actionviews/dataview*.rb'
  end
  Rake::Task["spec"].execute
end
task :actionviews do
  puts "Running Action Views Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/actionviews/online_inquiries*.rb'
  end
  Rake::Task["spec"].execute
end
task :rcpdata do
  puts "Creating Data for Related Contant Pane Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/relatedcontentpane/data*.rb'
  end
  Rake::Task["spec"].execute
end
task :rcp do
  puts "Running Related Content Pane Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/relatedcontentpane/rcp*.rb'
  end
  Rake::Task["spec"].execute
end
task :alltests do
  puts "Running All Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/*.rb'
  end
  Rake::Task["spec"].execute
end

task:runSmokeSetup,[:retryCount,:scriptFile] do |t,args|
  scriptList = ["spec/smoke/setup_data/setup_data.rb","spec/Smoke/setup_data/setup_data_ext.rb"]
  retryCount=args.retryCount
  scriptFile=args.scriptFile
  if retryCount == nil || retryCount == ""
	 retryCount = 0
  end
  if scriptFile == nil || scriptFile == ""
     scriptFile = "setup_data.txt" #default script file
  end  
  puts "running smoke test with retry count: #{retryCount}"
  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/Smoke/setup_#{scriptFile}.html"
end
#
#run all smoke test
#Parameters 
#@executeSetup : [Yes/No] Default Yes
#   Yes: execute smoke setup scripts
#   No: Do not run smoke setup scripts
#@retryCount: retry in case of script failure. Default 2
#@scriptFile: Script file to execute
#eg. rake smoketests[Yes,3]
# to execute scripts in multiple orgs use following arguments
#PROPERTY_FILE=uitest.run.org1.properties STATUS_FILE="status_org1.txt" LOG_FILE="Log_org1.txt" rake #UITests[Yes,5,SmokeScriptSet1.txt] >Log_org1.txt
#
task :smoketests, [:executeSetup,:retryCount,:scriptFile] do |t, args|
  puts "Running All Smoke Tests with parameter #{args.executeSetup} #{args.retryCount}"
  is_executeSetup=args.executeSetup
  retryCount=args.retryCount
  scriptFile=args.scriptFile
  if is_executeSetup == nil || is_executeSetup==""
     is_executeSetup = "Yes" #default run smoke setup
  end 
  if retryCount == nil || retryCount == ""
     retryCount = 2 #default retry count
  end 
  if scriptFile == nil || scriptFile == ""
     scriptFile = "ScriptList.txt" #default script file
  end
  puts "Running smoke tests with executeSetup:#{is_executeSetup} retryCount: #{retryCount} "
  pass_count=0
  fail_count=0
  if is_executeSetup.casecmp("Yes")==0
    puts "****Starting Smoke setup execution****"
	sh "rake runSmokeSetup[#{retryCount},#{scriptFile}]"
	pass_count,fail_count = get_PassFailScriptCount
	puts "smoke setup execution Done with passed examples: #{pass_count}, Failed examples: #{fail_count}"
  end
  if fail_count >0
     puts "smoke setup scripts failed, skipping smoke execution"
  else
	  puts "****Starting smoke test execution****"
	  sh "rake runScriptsFromFile[spec/Smoke/#{scriptFile},#{retryCount}]"
	  puts "smoke test execution Done"
  end
end


#run SRP smoke test
#Parameters 
#@executeSetup : [Yes/No] Default Yes
#   Yes: execute smoke setup scripts
#   No: Do not run smoke setup scripts
#@retryCount : retry in case of script failure. Default 2
#@scriptFile : Script file to execute
#eg. rake SRPsmoketests[Yes,3]
# to execute scripts in multiple orgs use following arguments
task :SRPsmoketests, [:executeSetup,:retryCount,:scriptFile] do |t, args|
  puts "Running All Smoke Tests with parameter #{args.executeSetup} #{args.retryCount}"
  is_executeSetup=args.executeSetup
  retryCount=args.retryCount
  scriptFile=args.scriptFile
  if is_executeSetup == nil || is_executeSetup==""
     is_executeSetup = "Yes" #default run smoke setup
  end 
  if retryCount == nil || retryCount == ""
     retryCount = 2 #default retry count
  end 
  if scriptFile == nil || scriptFile == ""
     scriptFile = "ScriptList.txt" #default script file
  end
  puts "Running smoke tests with executeSetup:#{is_executeSetup} retryCount: #{retryCount} "
  pass_count=0
  fail_count=0
  if is_executeSetup.casecmp("Yes")==0
    puts "****Starting Smoke setup execution****"
	sh "rake runSRPSmokeSetup[#{retryCount}]"
	pass_count,fail_count = get_PassFailScriptCount
	puts "smoke setup execution Done with passed examples: #{pass_count}, Failed examples: #{fail_count}"
  end
  if fail_count >0
     puts "smoke setup scripts failed, skipping smoke execution"
  else
	  puts "****Starting smoke test execution****"
	  sh "rake runScriptsFromFile[spec/SRP/Smoke/#{scriptFile},#{retryCount}]"
	  puts "smoke test execution Done"
  end
end

# Rake target to run smoke setup for SRP 
#@retryCount : retry in case of script failure. Default 2
task:runSRPSmokeSetup,[:retryCount] do |t,args|
  scriptList = ["spec/SRP/Smoke/setup_data/setup_data.rb"]
  retryCount=args.retryCount
  scriptFile="setup_data.rb"
  if retryCount == nil || retryCount == ""
	 retryCount = 2
  end
  
  puts "running smoke test with retry count: #{retryCount}"
  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/SRP/Smoke/setup_#{scriptFile}.html"
end

#run cash entry extended smoketest
#Parameters 
#@executeSetup : [Yes/No] Default Yes
#   Yes: execute smoke setup scripts
#   No: Do not run smoke setup scripts
#@retryCount : retry in case of script failure. Default 2
#@scriptFile : Script file to execute
#eg. rake CEext_smoketests[Yes,3]
# to execute scripts in multiple orgs use following arguments
task :CEext_smoketests, [:executeSetup,:retryCount,:scriptFile] do |t, args|
  puts "Running All Smoke Tests with parameter #{args.executeSetup} #{args.retryCount}"
  is_executeSetup=args.executeSetup
  retryCount=args.retryCount
  scriptFile=args.scriptFile
  # Cash Entry setup rake and script path
  cash_entry_smoke_script_path = "spec/cashentry_ext/smoke"
  cash_entry_ext_setup_rake_target = "runcashentryextSmokeSetup"
  puts " Received rake argument as executeSetup - #{is_executeSetup} ; retryCount- #{retryCount} and scriptFile as - #{scriptFile}}"
  # Invoking rake taregt to do setup and smoke script execution as per arguments.
  executeSetup_SmokeScript cash_entry_smoke_script_path,cash_entry_ext_setup_rake_target ,is_executeSetup, retryCount , scriptFile
end

# Rake target to run smoke setup for cash entry extended 
#@retryCount : retry in case of script failure. Default 2
task:runcashentryextSmokeSetup,[:retryCount] do |t,args|
  scriptList = ["spec/cashentry_ext/smoke/setup_data/setup_data.rb"]
  retryCount=args.retryCount
  scriptFile="setup_data.rb"
  if retryCount == nil || retryCount == ""
	 retryCount = 2
  end
  # RUn setup script with retry
  puts "running smoke test with retry count: #{retryCount}"
  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/cashentry_ext/Smoke/setup_#{scriptFile}.html"
end

#run FFA compatible smoketests
#Parameters 
#@module - Name of the FFA compatible module which need to be run.
#		   It should be the folder name of FFA compatible smokes scripts present in spec folder.
# 		   Example - bankformat , cashentry_ext , Lockbox , Media , SRP.		
#@executeSetup : [Yes/No] Default Yes
#   Yes: execute smoke setup scripts
#   No: Do not run smoke setup scripts
#@retryCount : retry in case of script failure. Default 2
#@scriptFile : Script file to execute
#eg. rake compatability_smoketests[SRP,Yes,3]
task :compatability_smoketests, [:module,:executeSetup,:retryCount,:scriptFile] do |t, args|
	is_executeSetup=args.executeSetup
	retryCount=args.retryCount
	scriptFile=args.scriptFile
	module_to_run = args.module
	smoke_script_path = "spec/#{module_to_run}/smoke"
	puts "Running #{module_to_run} Smoke Tests with parameter #{args.executeSetup} #{args.retryCount}"
	if is_executeSetup == nil || is_executeSetup==""
		 is_executeSetup = "Yes" #default run smoke setup
	end 	
	if retryCount == nil || retryCount == ""
		 retryCount = 2 #default retry count
	end 
	if scriptFile == nil || scriptFile == ""
		 scriptFile = "ScriptList.txt" #default script file
	end
	puts "Running #{module_to_run} smoke tests with executeSetup:#{is_executeSetup} retryCount: #{retryCount} "
	pass_count=0
	fail_count=0
	if is_executeSetup.casecmp("Yes")==0
		puts "****Starting #{module_to_run} Smoke setup execution****"
		
		sh "rake CompatibleSmokeSetup[#{module_to_run},#{retryCount}]"
		pass_count,fail_count = get_PassFailScriptCount
		puts "smoke setup execution Done with passed examples: #{pass_count}, Failed examples: #{fail_count}"
	end
	if fail_count >0
		puts "smoke setup scripts failed for #{module_to_run}, skipping smoke execution"
	else
		puts "****Starting #{module_to_run} smoke test execution****"
		sh "rake runScriptsFromFile[#{smoke_script_path}/#{scriptFile},#{retryCount}]"
		puts "smoke test execution Done"
	end  
end

# Rake target to run smoke setup for FFA compatible Smoke tests(ex- SRP, Media, Cash Entry Ext, Lockbox , Bank Format) 
#@module - Name of the module which need to be run. It should be the folder name of FFA compatible smokes scripts present in spec folder 
# 		   Example - bankformat , cashentry_ext , Lockbox , Media , SRP
#@retryCount : retry in case of script failure. Default 2
task:CompatibleSmokeSetup,[:module,:retryCount] do |t,args|
  module_to_run = args.module
  retryCount=args.retryCount
  scriptFile="setup_data.rb"
  scriptList = ["spec/#{module_to_run}/smoke/setup_data/setup_data.rb"]
  if retryCount == nil || retryCount == ""
	 retryCount = 2
  end 
  puts "running #{module_to_run } setup test with retry count: #{retryCount}"
  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/#{module_to_run}/smoke/setup_#{scriptFile}.html"
end


# run a single TID
# rake run[TID011394]
task :run, [:tid] do |t, args|
  puts "Running Tests  #{args.tid}"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/*#{args.tid}*.rb"
  end
  Rake::Task["spec"].execute
end
#run ledger inquiry data
task :ledgerdata do
  puts "Create Data for Ledger Inquiry Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/ledger_inquiry/data_*.rb'
  end
  Rake::Task["spec"].execute
end
#Run all tests on the ledger inquiry tab
task :ledgertests do
  puts "Running All Ledger Inquiry Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/ledger_inquiry/*.rb'
  end
  Rake::Task["spec"].execute
end
#Run all tests of the accounting sales invoice and credit notes
task :AccSinAndCrnTests do
  puts "Running All Sales Invoice and Credit Note Tests."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/UI/accounting_sales_invoice_and_credit_notes_*.rb'
  end
  Rake::Task["spec"].execute
end

task:runUISetup,[:retryCount,:scriptFile] do |t,args|
  scriptList = ["spec/UI/setup_data.rb"]
  retryCount=args.retryCount
  scriptFile=args.scriptFile
  if retryCount == nil || retryCount == ""
	 retryCount = 0
  end 
  if scriptFile == nil || scriptFile == ""
     scriptFile = "setup_data.txt" #default script file
  end
  puts "running UI setup with retry count: #{retryCount}"
  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/UI/setup_#{scriptFile}.html"
end

# Rake target to run the setup file module wise.
#Parameters 
#@moduleFolderName :Name of the module folder in string format.
#@retryCount: retry in case of script failure as integer. Default 2
#eg. rake runUIModuleSetup["pin_pcn",2] 
# 
task:runUIModuleSetup,[:moduleFolderName ,:retryCount] do |t,args|
  moduleName = args.moduleFolderName
  scriptList = ["spec/UI/#{moduleName}/setup_data/*_data.rb"]
  retryCount=args.retryCount
  if retryCount == nil || retryCount == ""
	 retryCount = 2
  end 
 setup_data_file_count =  get_number_of_files "spec/UI/#{moduleName}/setup_data/*_data.rb"
 puts "Run the module setup only if setup data files are present. Number of setup files- #{setup_data_file_count}"
  if (setup_data_file_count > 0)
	  puts "running UI Module- #{moduleName} setup script  with retry count: #{retryCount}"
	  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/UI/ui_setup_#{moduleName}.html"
  end
end

#
#run all UI test
#Parameters 
#@uiFolderName - Name of the module folder, which scripts need to be executed. 
#@executeCommonUISetup : [Yes/No] Default Yes to execute the common setup for UI scripts
#   Yes: execute UI setup scripts
#   No: Do not run UI setup scripts
#@executeModuleSetup : [Yes/No] Default Yes to execute the module setup file for module specific UI scripts
#   Yes: execute UI module setup scripts
#   No: Do not run UI module setup scripts
#@retryCount: retry in case of script failure. Default 2
#@scriptFile: Name of the Script file which contains the script names to execute. 
#			  Default is UIScriptListFile.txt file present in correspnding module folder.
#@tagName - To run those it block which are tagged with some name.
#			 Currently, only ie tag exist which enables to filter all script and run only those it which are tagged with ie on internet_explorer
#eg. rake UITests["companies","yes","No",2,"UIScriptListFile.txt"]
#Run all UI tests
task :UITests, [:uiFolderName,:executeCommonUISetup,:executeModuleSetup,:retryCount,:scriptFile,:tagName] do |t, args|
  is_executeSetup=args.executeCommonUISetup
  is_executeModuleSetup = args.executeModuleSetup
  retryCount=args.retryCount
  folderName = args.uiFolderName
  tagValue = args.tagName
  #if managed org excludeit blocks with unmanaged tags
  if ORG_TYPE.downcase == "managed"
		if tagValue == "" || tagValue == nil 
			tagValue = "~unmanaged"			
		else
			tagValue = tagValue.to_s + " --tag ~unmanaged"
		end
  end
  puts "Running  UI Tests with #{tagValue} tag for module #{folderName} with parameter UI setup: #{is_executeSetup}, Module Setup: #{is_executeModuleSetup} and retry count:#{args.retryCount}"
  scriptFile=args.scriptFile
  if is_executeSetup == nil || is_executeSetup==""
     is_executeSetup = "Yes" #default run UI setup
  end 
  if is_executeModuleSetup == nil || is_executeModuleSetup==""
     is_executeModuleSetup = "Yes" #default run module UI setup
  end 
  if retryCount == nil || retryCount == ""
     retryCount = 2 #default retry count
  end 
  if scriptFile == nil || scriptFile == ""
     scriptFile = "ScriptList.txt" #default script file
  end 

  puts "Running UI tests with executeCommonUISetup:#{is_executeSetup} retryCount: #{retryCount} "
  pass_count=0
  fail_count=0
  # To run the common setup for UI script
  if is_executeSetup.casecmp("Yes")==0
    puts "****Starting common UI setup execution****"
	sh "rake runUISetup[#{retryCount},#{scriptFile}]"
	pass_count,fail_count = get_PassFailScriptCount
	puts "UI setup execution Done with passed examples: #{pass_count}, Failed examples: #{fail_count}"
  end
  module_pass_count = 0
  module_fail_count = 0
  # To run the Setup file as per module
  if is_executeModuleSetup.casecmp("Yes")==0
    puts "****Starting module setup execution****"
	sh "rake runUIModuleSetup[#{folderName},#{retryCount}]"
	module_pass_count,module_fail_count = get_PassFailScriptCount
	puts "UI module setup execution Done with passed examples: #{pass_count}, Failed examples: #{fail_count}"
  end
  # Dont run the script if Ui setup or module setup has failed.
  if (fail_count >0 or module_fail_count>0)
     puts "UI setup scripts failed, skipping UI test execution"
  else
	  puts "****Starting UI test execution****"
	  sh "rake runScriptsFromFile[spec/UI/#{folderName}/#{scriptFile},#{retryCount},#{tagValue}]"
	  puts "UI test execution Done"
  end
end

#Run all smoke tests for merlin auto aus
task :SmokeTestsForMerlinAutoAUS do
  puts "Running All Smoke Tests for Merlin Auto AUS company."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/smoke/smoketest_merlin_auto_aus*.rb'
  end
  Rake::Task["spec"].execute
end

#Run all smoke tests for merlin auto spain
task :SmokeTestsForMerlinAutoSpain do
  puts "Running All Smoke Tests for Merlin Auto Spain Company."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/smoke/smoketest_merlin_auto_spain*.rb'
  end
  Rake::Task["spec"].execute
end

#Run all smoke tests for merlin auto usa
task :SmokeTestsForMerlinAutoUSA do
  puts "Running All Smoke Tests for Merlin Auto USA company."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/smoke/smoketest_merlin_auto_usa*.rb'
  end
  Rake::Task["spec"].execute
end

#Run all smoke tests for merlin auto usa
task :SmokeTestsForMerlinAutoCAN do
  puts "Running All Smoke Tests for new company Merlin Auto Canada."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/smoke/smoketest_merlin_auto_canada*.rb'
  end
  Rake::Task["spec"].execute
end

#Run all smoke tests for intercompany
task :SmokeTestsForIntercompanyProcess do
  puts "Running All Smoke Tests for Intercompany Process."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/smoke/smoketest_accounting_intercompany*.rb'
  end
  Rake::Task["spec"].execute
end

#Run all Volume tests for Sales Invoice Income Schedule Module
task :VolumeTestForIncomeSchedule do
  puts "Running All Volume Tests for Sales Invoice Income Schedule."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/volume/volume_test_*Income_schedule*.rb'
  end
  Rake::Task["spec"].execute
end

# run a single script
# rake runSmokeScript[scriptName]
task :runSmokeScript, [:script] do |t, args|
  puts "Running Tests  #{args.script}"
  RSpec::Core::RakeTask.new(:spec) do |t|
	t.pattern = "spec/Smoke/*#{args.script}*.rb"
    t.rspec_opts = "--require spec_helper --color --format progress --format html --out Result-#{args.script}.html"
  end
  Rake::Task["spec"].execute
end


# run a single script
# rake runUIScript[scriptName]
# rake runUIScript[TID012734]
task :runUIScript, [:script] do |t, args|
  puts "Running Tests  #{args.script}"
  RSpec::Core::RakeTask.new(:spec) do |t|
	t.pattern = "spec/UI/*#{args.script}*.rb"
    t.rspec_opts = "--require spec_helper --color --format progress --format html --out Result-#{args.script}.html"
  end
  Rake::Task["spec"].execute
end

#
# run spec files from list given in txt file 
# and in case of some failure of examples rerun only failure examples.
# Parameters: 
#:scriptListFile: list spec files with complete path, Add a blank line at end of file.
#          spec/UI/accounting_cash_enrty_and_matching_TID012132.rb
#          spec/UI/accounting_currency_revaluation_TID016916.rb
# :reRunTimes: How many times failure examples are to re-run.
# eg.
# rake runScriptsFromFile[spec/Smoke/SmokeScriptListFile.txt,3]
#
task :runScriptsFromFile, [:scriptListFile,:reRunTimes, :tagName] do |t, args|
	puts "Running Tests from file: #{args.scriptListFile}"
	
	scriptList = get_ListOfScripts(args.scriptListFile)
	outFileName = "result-#{args.scriptListFile}"
	
	runScriptsAndRetry scriptList,args.reRunTimes,outFileName,args.tagName
end

#run only failed scripts from previous run. If no run deducted then then all scripts given in parameter. 
#rake reRunFailureScriptsOnly [UITestScripts1.txt,2]
task :reRunFailureScriptsOnly, [:scriptListFile,:reRunTimes] do |t, args|
	puts "Running only failure scripts: #{args.scriptListFile}"
	
	scriptList = get_ListOfScripts(args.scriptListFile)
	outFileName = "result-#{args.scriptListFile}"
	
	runFailedScriptsOnly(args.reRunTimes,scriptList,outFileName)
end

def runScriptsAndRetry scriptPattern,reRunTimes,outFileName, tagName=nil
    puts "Script Pattern to run"
	puts scriptPattern
	puts "check and remove examples.txt file if exists"
	if File.exist?(STATUS_FILE)
	   File.delete(STATUS_FILE)
	end
	if !(tagName == nil || tagName == "")
		tagName = "--tag #{tagName}"
	end
	puts "Running Tests in retry mode: Max rerun requested #{reRunTimes}"
	RSpec::Core::RakeTask.new(:spec) do |t|
		t.pattern = scriptPattern
		t.rspec_opts = "--require spec_helper #{tagName} --color --format progress --format html --out #{outFileName}.html"
	end
  
	begin
	Rake::Task["spec"].execute
	rescue Exception => e
		#do Nothing
	ensure
		runFailedScriptsOnly(reRunTimes,scriptPattern,outFileName)
	end
end

#method to re run(multiple times) failed script
#reRunTimes - Number of times script to run
#scriptPattern - script pattern to include for run
#outFileName  - use for reporting output 
def runFailedScriptsOnly reRunTimes, scriptPattern,outFileName
	runResult = Array.new 
	number_of_runs = reRunTimes
	pass_count,fail_count = get_PassFailScriptCount
	puts "#{Time.now.strftime('%d/%m/%Y %H:%M')}: Result examples passed : #{pass_count} failed : #{fail_count}"
	runResult.push("#{Time.now.strftime('%d/%m/%Y %H:%M')}: Result after first execution examples -> passed : #{pass_count} failed : #{fail_count}")
	runNo=1
	report_file=""
	email_files=""
	if File.exist?("#{outFileName}.html")
		email_files="'#{outFileName}.html'"
	end
	while (runNo<=number_of_runs.to_i && (pass_count ==0 || fail_count >0)) do
		begin
			puts "Running Only Failed scripts run number: #{runNo}"
			RSpec::Core::RakeTask.new(:spec2) do |t|
				t.pattern = scriptPattern
				tagValue = ""
					if ORG_TYPE.downcase == "managed"
						tagValue = " --tag ~unmanaged"						
					end
				if pass_count ==0 && fail_count ==0
				    report_file = "'#{outFileName}.html'"
					t.rspec_opts = "--require spec_helper --color --format progress --format html --out #{report_file}" + tagValue
				else
					#if managed org excludeit blocks with unmanaged tags
					report_file = "#{outFileName}-ReRunFailure-#{runNo}.html"
					t.rspec_opts ="--only-failure --require spec_helper --color --format progress --format html --out #{report_file}" + tagValue
				end
			 end
			Rake::Task[:spec2].execute
		rescue Exception => e
			#do nothing
		end
		Rake::Task[:spec2].clear
		if File.exist?(report_file) && !email_files.include?(report_file)
		   email_files = "#{email_files} '#{report_file}'"
		end
		pass_count,fail_count = get_PassFailScriptCount
		puts "#{Time.now.strftime('%d/%m/%Y %H:%M')}: Result after rerun: #{runNo} examples passed : #{pass_count} failed : #{fail_count}"
		runResult.push("#{Time.now.strftime('%d/%m/%Y %H:%M')}: Result after rerun #{runNo} examples -> passed : #{pass_count} failed : #{fail_count}")
		runNo=runNo+1
	end
	logExecutionResult runResult
	#send email with all re-run files
    ruby "./emailResult.rb 'script Pattern:#{scriptPattern} Final Results #{runResult}' #{email_files} " 	
end

#read file and return list of spec files to run
def get_ListOfScripts fileName 
	scriptList = Array.new
	File.open(fileName, "r") do |infile|
		while (row = infile.gets)
			if !(row[0]=="#")
				scriptList.push(row.chop)
			end
		end
	end
	return  scriptList
end

#get pass and fail example count
def get_PassFailScriptCount
    fail_count = 0
	pass_count = 0
	
	if ! File.exist?(STATUS_FILE)
	   return 0,0
	end
	File.open(STATUS_FILE, "r") do |infile|
		while (row = infile.gets)
			if row.include? "failed"
				fail_count = fail_count + 1
			elsif row.include? "passed"
				pass_count = pass_count + 1
			end
		end
	end
	return  pass_count,fail_count
end

#log formatted execution result on console 
def logExecutionResult runResultList
	puts "*********************************************************"
	puts "Result after each run"
	puts runResultList
	puts "*********************************************************"
end

# run a single script
# rake runVolumeScript[scriptName]
# rake runVolumeScript[TID012734]
task :runVolumeScript, [:script] do |t, args|
  puts "Running Tests  #{args.script}"
  RSpec::Core::RakeTask.new(:spec) do |t|
	t.pattern = "spec/Volume/*#{args.script}*.rb"
    t.rspec_opts = "--require spec_helper --color --format progress --format html --out Result-#{args.script}.html"
  end
  Rake::Task["spec"].execute
end

# to get the number of files present in a directory
# file_name_pattern = path+file name pattern 
# ex- spec/UI/companies/setup_data/*_data.rb  - It will return number of files present in spec/UI/companies/setup_data folder which ends with _data.rb
def get_number_of_files file_name_pattern
	return Dir["#{file_name_pattern}"].length
end

#run Media smoke test
#Parameters 
#@executeSetup : [Yes/No] Default Yes
#   Yes: execute smoke setup scripts
#   No: Do not run smoke setup scripts
#@retryCount : retry in case of script failure. Default 2
#@scriptFile : Script file to execute
#eg. rake Mediasmoketests[Yes,3]
# to execute scripts in multiple orgs use following arguments
task :Mediasmoketests, [:executeSetup,:retryCount,:scriptFile] do |t, args|
  puts "Running All Smoke Tests with parameter #{args.executeSetup} #{args.retryCount}"
  is_executeSetup=args.executeSetup
  retryCount=args.retryCount
  scriptFile=args.scriptFile
  if is_executeSetup == nil || is_executeSetup==""
     is_executeSetup = "Yes" #default run smoke setup
  end 
  if retryCount == nil || retryCount == ""
     retryCount = 2 #default retry count
  end 
  if scriptFile == nil || scriptFile == ""
     scriptFile = "ScriptList.txt" #default script file
  end
  puts "Running smoke tests with executeSetup:#{is_executeSetup} retryCount: #{retryCount} "
  pass_count=0
  fail_count=0
  if is_executeSetup.casecmp("Yes")==0
    puts "****Starting Smoke setup execution****"
	sh "rake runMediaSmokeSetup[#{retryCount}]"
	pass_count,fail_count = get_PassFailScriptCount
	puts "smoke setup execution Done with passed examples: #{pass_count}, Failed examples: #{fail_count}"
  end
  if fail_count >0
     puts "smoke setup scripts failed, skipping smoke execution"
  else
	  puts "****Starting smoke test execution****"
	  sh "rake runScriptsFromFile[spec/Media/Smoke/#{scriptFile},#{retryCount}]"
	  puts "smoke test execution Done"
  end
end

# Rake target to run smoke setup for Media 
#@retryCount : retry in case of script failure. Default 2
task:runMediaSmokeSetup,[:retryCount] do |t,args|
  scriptList = ["spec/Media/smoke/setup_data/setup_data.rb"]
  retryCount=args.retryCount
  scriptFile="setup_data.rb"
  if retryCount == nil || retryCount == ""
	 retryCount = 2
  end
  
  puts "running smoke test with retry count: #{retryCount}"
  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/Media/setup/setup_#{scriptFile}.html"
end

#run Lockbox extended smoketest
#Parameters 
#@executeSetup : [Yes/No] Default Yes
#   Yes: execute smoke setup scripts
#   No: Do not run smoke setup scripts
#@retryCount : retry in case of script failure. Default 2
#@scriptFile : Script file to execute
#eg. rake Lockbox_smoketests[Yes,3]
# to execute scripts in multiple orgs use following arguments
task :Lockbox_smoketests, [:executeSetup,:retryCount,:scriptFile] do |t, args|
  puts "Running All Smoke Tests with parameter #{args.executeSetup} #{args.retryCount}"
  is_executeSetup=args.executeSetup
  retryCount=args.retryCount
  scriptFile=args.scriptFile
  # Lockbox setup rake and script path
  lockbox_smoke_script_path = "spec/Lockbox/smoke"
  lockbox_setup_rake_target = "runLockboxSmokeSetup"
  puts " Received rake argument as executeSetup - #{is_executeSetup} ; retryCount- #{retryCount} and scriptFile as - #{scriptFile}}"
  # Invoking rake taregt to do setup and smoke script execution as per arguments.
  executeSetup_SmokeScript lockbox_smoke_script_path,lockbox_setup_rake_target ,is_executeSetup, retryCount , scriptFile
end

# Rake target to run smoke setup for lockbox
#@retryCount : retry in case of script failure. Default 2
task:runLockboxSmokeSetup,[:retryCount] do |t,args|
  scriptList = ["spec/Lockbox/smoke/setup_data/setup_data.rb"]
  retryCount=args.retryCount
  scriptFile="setup_data.rb"
  if retryCount == nil || retryCount == ""
	 retryCount = 2
  end
  # RUn setup script with retry
  puts "running smoke test with retry count: #{retryCount}"
  runScriptsAndRetry scriptList,"#{retryCount}","Result-spec/Lockbox/Smoke/setup_#{scriptFile}.html"
end

# execute smoke setup and script
# Generalized code to execute the setup and script files of any smoke module.
# @smoke_script_path - Path of the script folder where smoke scripts are present.
#						ex - for cash entry extended layout smoke - "spec/cashentry_ext/smoke"
# @setup_rake_target_name - name of the setup rake target of smoke module.
#						ex - Name of the setup rake target for cash entry extend - "runcashentryextSmokeSetup"
# @is_executeSetup - pass as yes if setup data need to be executed. Default =yes
# #@retryCount : retry in case of script failure. Default 2
#	@scriptFile : Script file to execute	
# Example to call the below method for executing cash entry smoke test with setup=No and retry count as 3.
#	executeSetup_SmokeScriptexecuteSetup_SmokeScript ""spec/cashentry_ext/smoke"","runcashentryextSmokeSetup" ,No, 2 , scriptFile	,"SmokeScriptListFile.txt"					
def executeSetup_SmokeScript smoke_script_path,setup_rake_target_name ,is_executeSetup, retryCount , scriptFile
	if is_executeSetup == nil || is_executeSetup==""
		 is_executeSetup = "Yes" #default run smoke setup
	end 	
	if retryCount == nil || retryCount == ""
		 retryCount = 2 #default retry count
	end 
	if scriptFile == nil || scriptFile == ""
		 scriptFile = "ScriptList.txt" #default script file
	end
	puts "Running smoke tests with executeSetup:#{is_executeSetup} retryCount: #{retryCount} "
	pass_count=0
	fail_count=0
	if is_executeSetup.casecmp("Yes")==0
		puts "****Starting Smoke setup execution****"
		sh "rake #{setup_rake_target_name}[#{retryCount}]"
		pass_count,fail_count = get_PassFailScriptCount
		puts "smoke setup execution Done with passed examples: #{pass_count}, Failed examples: #{fail_count}"
	end
	if fail_count >0
		puts "smoke setup scripts failed, skipping smoke execution"
	else
		puts "****Starting smoke test execution****"
		sh "rake runScriptsFromFile[#{smoke_script_path}/#{scriptFile},#{retryCount}]"
		puts "smoke test execution Done"
	end
end