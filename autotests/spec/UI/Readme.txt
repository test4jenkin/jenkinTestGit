############################
For executing UI scripts
############################

A.) Pre requisite for running UI scripts:
1. Un manage Org with base data deployed on it.
2. Run new ant target run.deployclienttest to deploy all the required in execution of UI scripts.
3. Run common UI setup which is required for all UI script as pre-requisite
   rake runUISetup[3,"uitest_data_setup_ext_unmanaged.rb"]

   Rake Target Description
   -- runUISetup[:retryCount,:scriptFile] 
   -- retryCount - retry in case of script failure.
   -- scriptFile - Name of the script file. i.e -uitest_data_setup_ext_unmanaged.rb


B.) Rake target for running all script of a module including setup files:
1. To run all the script of a module and setup file
    Example - rake UITests["companies"]
	It will run common UI setup , Module setup and after that all the scripts under companies folder will be executed
2. To run all the scripts from a folder but no need to run the Common UI setup
    Example - rake UITests["companies","No"]
	It will skip common UI setup but will run Module setup and after that all the scripts under companies folder will be executed
3. To run only the scripts under a folder without any setup file execution
    Example - rake UITests["companies","No", "No"]
	It will run all the UI scripts present under companies folder and will skip any setup execution.
  Rake Target Description-
  -- UITests[:uiFolderName,:executeCommonUISetup,:executeModuleSetup,:retryCount,:scriptFile]
  -- Parameters 
     #@uiFolderName(Required) -Name of the module folder, which scripts need to be executed. 
     #@executeCommonUISetup(Optional) : [Yes/No] Default Yes to execute the common setup for UI scripts
	#   Yes: execute UI setup scripts
	#   No: Do not run UI setup scripts
     #@executeModuleSetup(Optional) : [Yes/No] Default Yes to execute the module setup file for module specific UI scripts
	#   Yes: execute UI module setup scripts
	#   No: Do not run UI module setup scripts
     #@retryCount(Optional): retry in case of script failure. Default 2
     #@scriptFile(Optional):Name of the Script file which contains the script names to execute. 
	Default is UIScriptListFile.txt file present in correspnding module folder.
	eg. rake UITests["companies","No","No",2,"UIScriptListFile.txt"]
	It will first run the common UI setup file
	and after that it will run all the scripts which are in companies/UIScriptListFile.txt file of companies folder.


C.)Additional Rake Targets for running module setup files:
1. To run setup file for pin_pcn module only-
	rake runUIModuleSetup["pin_pcn"]
	It will run setup file (present in pin_pcn/setup_data/) for pin_pcn module only.

  Rake Target Description-
  -- runUIModuleSetup[:moduleFolderName ,:retryCount]
   -- moduleFolderName(Required) - Name of the module folder.
   -- retryCount(Optional) - retry in case of script failure.

D.) Running a single script:
1. Command to run single UI script-
  Example for allocation module script- 
	$ driver=firefox rspec -fd -c spec/ui/allocation/allocations_show_all_tlis_TID015958.rb -fh -o TID015958_result.html 
 