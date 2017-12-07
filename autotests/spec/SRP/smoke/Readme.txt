############################
For executing SRP Smoke scripts
############################


A.) Rake target for running SRP Smoke scripts  :
1. To run the setup of SRP and smoke script of SRP-
    Example - rake SRPsmoketests[Yes,3]
	It will run the setup(spec/srp/smoke/setup_smoketest_data.rb) of SRP and after that all the smoke scripts mentioned under spec/srp/smoke/SmokeScriptListFile.txt file.
	
	Example - rake SRPsmoketests[No,3]
	It will skip running the setup(spec/srp/smoke/setup_smoketest_data.rb) of SRP and will directly run the smoke scripts mentioned under spec/srp/smoke/SmokeScriptListFile.txt file.
	
	Rake Target Description-
		#Parameters 
		#@executeSetup : [Yes/No] Default Yes
		#   Yes: execute smoke setup scripts
		#   No: Do not run smoke setup scripts
		#@retryCount : retry in case of script failure. Default 2
		#@scriptFile()optional) : Script file to execute. default value spec/srp/smoke/SmokeScriptListFile.txt
		#eg. rake SRPsmoketests[Yes,3]
			# It will first run the setup of SRP and once it is completed successfully , It will execute the smoke script mentioned under spec/srp/smoke/SmokeScriptListFile.txt file.

C.) Rake Targets for running only SRP setup files:
1. To run setup file for SRP smoke-
	Example - rake runSRPSmokeSetup[2]
		It will run the setup file of SRP i.e spec/srp/smoke/setup_smoketest_data.rb and will retry for 2 times.
	Rake Target Description-
		#@retryCount : retry in case of script failure. Default 2

 