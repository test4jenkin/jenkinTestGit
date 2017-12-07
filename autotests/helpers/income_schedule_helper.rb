 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Incomeschedule  
extend Capybara::DSL
##########################
#income schedule
##########################

# Selectors
$incomeschedule_name = "#Name"
$incomeschedule_number_of_journals = "//label[text()='Number of Journals']/../following-sibling::td/input"
$incomeschedule_period_interval = "//label[text()='Period Interval']/../following-sibling::td/input"
$incomeschedule_gla = ".lookupInput>input"
# Labels
$incomeschedule_gla_label = "General Ledger Account"
$incomeschedule_name_label = "Name"
$incomeschedule_num_of_journals_label = "Number of Journals"
$incomeschedule_period_interval_label = "Period Interval"

# methods
	def Incomeschedule.set_name income_schedule_name
		fill_in $incomeschedule_name_label, :with => income_schedule_name
	end
	
	def Incomeschedule.set_num_of_journals num_of_journals		
		fill_in $incomeschedule_num_of_journals_label, :with => num_of_journals 
	end
	
	def Incomeschedule.set_period_interval period_interval		
		fill_in $incomeschedule_period_interval_label, :with => period_interval
	end
	
	def Incomeschedule.set_gla gla		
		SF.fill_in_lookup $incomeschedule_gla_label , gla
	end	
end

	