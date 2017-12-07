############################
For executing Bank Format Smoke scripts
############################


A.) Rake target for running Bank format Smoke scripts  :
1. To run the setup and smoke script of Bank format-
    Example - rake compatability_smoketests[bankformat,Yes,3]
	It will run the setup(spec/bankformat/smoke/setup_data/setup_data.rb) of bank format and after that all the smoke scripts mentioned under spec/bankformat/smoke/ScriptList.txt file.
	
	Example - rake compatability_smoketests[bankformat,No,3]
	It will skip running the setup(spec/bankformat/smoke/setup_data/setup_data.rb) of SRP and will directly run the smoke scripts mentioned under spec/bankformat/smoke/ScriptList.txt file.
	
	Rake Target Description-
		compatability_smoketests[:module,:executeSetup,:retryCount,:scriptFile]
		#@module - Name of the FFA compatible module which need to be run.
		#It should be the folder name of FFA compatible smokes scripts present in spec folder.
		#Example - bankformat , cashentry_ext , Lockbox , Media , SRP.		
		#Parameters 
		#@executeSetup : [Yes/No] Default Yes
		#   Yes: execute smoke setup scripts
		#   No: Do not run smoke setup scripts
		#@retryCount : retry in case of script failure. Default 2
		#@scriptFile()optional) : Script file to execute. default value spec/bankformat/smoke/ScriptList.txt
		#eg. rake compatability_smoketests[bankformat,Yes,3]
			# It will first run the setup of bankformat and once it is completed successfully , It will execute the smoke script mentioned under spec/bankformat/smoke/ScriptList.txt file.

B.) Rake Targets for running only bankformat setup files:
1. To run setup file for bankformat smoke setup-
	Example - rake compatiblesmokesetup[bankformat,2]
		It will run the setup file of SRP i.e spec/bankformat/smoke/setup_data/setup_data.rb and will retry for 2 times.
	Rake Target Description-
		#@retryCount : retry in case of script failure. Default 2

 