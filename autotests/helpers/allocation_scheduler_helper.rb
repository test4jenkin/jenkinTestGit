 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.

ALLOCATION_SCHEDULER_COLUMN_DELETE_SCHEDULE = 1
ALLOCATION_SCHEDULER_COLUMN_ID = 2
ALLOCATION_SCHEDULER_COLUMN_SCHEDULE_NAME = 3

module AS
extend Capybara::DSL
#############################
# Allocation Scheduler (VF pages)
#############################

# buttons
$as_create_schedule = "a[data-ffid=createScheduleButton]"
$as_save_schedule = "a[data-ffid=saveButton]"
$as_click_run_now = "a[data-ffid=runButton]"
$as_click_continue = "a[data-ffid=ok]"
$as_click_save_schedule = "a[data-ffid=ok]"
$as_click_refresh_button = "a[data-ffid=reloadScheduleGridButton]"
$as_click_schedule_list_button = "a[data-ffid=backToListButton]"

# Labels
$as_tab_select_template = "Select Templates"
$as_tab_set_schedule_frequency = "Set Schedule Frequency"
$as_tab_retrieve_transactions = "Retrieve Transactions"
$as_tab_set_posting_details = "Set Posting Details"
$as_schedule_hourly = "Hourly"
$as_schedule_daily = "Daily"
$as_schedule_weekly = "Weekly"
$as_schedule_monthly = "Monthly"
$as_schedule_specific_date = "Specific Date"
$as_schedule_ends_no_end = "No End"
$as_schedule_ends_after = "After" 
$as_schedule_ends_by = "By"
$as_date_range_static = "Static"
$as_date_range_dynamic = "Dynamic"
$as_date_range_advanced = "Advanced"

# objects
$as_allocsched_name = "input[name='userDefinedName']"
$as_allocsched_description = "input[name='description']"
$as_allocsched_status = "div[data-ffid=active] input"
$as_allocsched_template = "input[name='templateSelection']"
$as_hourly_interval = "table[data-ffid=cronInterval] input"
$as_hourly_offset = "table[data-ffid=cronOffset] input"
$as_schedule_ends = "input[name=scheduleExpiresOption]"
$as_schedule_end_after_occurence = "table[data-ffid=after] input"
$as_schedule_end_by_date = "table[data-ffid=endDate] input"
$as_transaction_from_date = "table[data-ffid=retrieveTransactionsFromDate] input"
$as_transaction_to_date = "table[data-ffid=retrieveTransactionsToDate] input"
$as_date_range_period = "div[data-ffid=dynamicDateRangeType]:nth-of-type(1) div[data-ffid=dynamicDateRangeType] span[class*='f-form-radio']"
$as_date_range_month = "div[data-ffid=dynamicDateRangeType]:nth-of-type(2) div[data-ffid=dynamicDateRangeType] span[class*='f-form-radio']"
$as_dynamic_by_period = "table[data-ffid=retrieveTransactionsByPeriod] input"
$as_dynamic_by_month = "input[name=retrieveTransactionsByMonth]"
$as_advanced_date_of_first = "div[data-ffid=advancedDateRangeType]:nth-of-type(1) table[data-ffid=advancedDateRangeType] input"
$as_advanced_date_before_to_date = "div[data-ffid=advancedDateRangeType]:nth-of-type(2) table[data-ffid=advancedDateRangeType] input"
$as_advanced_days_prior_to_date = "table[data-ffid=daysPriorToToDate] input"
$as_advanced_transaction_to_date = "table[data-ffid=daysBeforeOrAfterRunDate] input"
$as_posting_date_days_offset = "div[data-ffid=postingDateOption]:nth-of-type(1) div[data-ffid=postingDateOption] span[class*='f-form-radio']"
$as_posting_date_specific_date = "div[data-ffid=postingDateOption]:nth-of-type(2) table[data-ffid=postingDateOption] span[class*='f-form-radio']"
$as_posting_date_offset = "input[name=postingOffset]"
$as_posting_specific_date = "table[data-ffid=postingDate] input"
$as_period_from_posting_date = "div[data-ffid=periodOption]:nth-of-type(1) table[data-ffid=periodOption] input"
$as_period_from_run_date = "div[data-ffid=periodOption]:nth-of-type(2) table[data-ffid=periodOption] input"
$as_period_offset_from_posting_date = "div[data-ffid=periodOption]:nth-of-type(3) div[data-ffid=periodOption] span[class*='f-form-radio']"
$as_alloc_period_from_offset = "input[name=periodOffset]"
$as_daily_start_time = "table[data-ffid=cronDailyCardHour] input"
$as_weekly_start_time = "table[data-ffid=cronWeekCardHour] input"
$as_monthly_day_option = "div[data-ffid=cronMonthlyType]:nth-of-type(1) table[data-ffid=cronMonthlyType] span[class*='f-form-radio']"
$as_monthly_week_option = "div[data-ffid=cronMonthlyType]:nth-of-type(2) div[data-ffid=cronMonthlyType] span[class*='f-form-radio']"
$as_monthly_day = "table[data-ffid=cronMonthDay] input"
$as_monthly_day_start_time = "table[data-ffid=cronMonthlyByMonthDayHour] input"
$as_monthly_week_occurrence = "input[name=cronDayOccurrence]"
$as_monthly_week_occurrence_weekday = "input[name=cronWeekDay]"
$as_monthly_week_start_time = "input[name=cronMonthlyByWeekDayHour]"
$as_specific_date = "table[data-ffid=cronDateCardDateTime] input"
$as_get_warning_message = "h1[class*=ALLOCATIONSCHEDULE]"
$as_allocation_scheduler_grid = "div[data-ffxtype=tableview] table tbody"
$as_schedule_summary_messages = "div[data-ffid=summaryDetails] a[data-ffid^=step]:not([style*='display: none;']):nth-of-type(nnn)" 
$as_schedule_list_page = "div[data-ffid=scheduleList]"
$as_delete_a_schedule = "img[class*='ALLOCATIONSCHEDULE-icon-remove-line']"

###################################################
# methods
###################################################
# opens a new schedule
	def	AS.create_schedule
		find($as_create_schedule).click
		FFA.wait_page_message $ffa_msg_loading 
	end

	# sets schedule name
	def AS.set_allocsched_name schedname
		find($as_allocsched_name).set schedname
	end

	# sets schedule description
	def AS.set_allocsched_description scheddesc
		find($as_allocsched_description).set scheddesc
	end

	# sets schedule status
	def AS.set_allocsched_status 
		find('label', :text => 'Active').click
		gen_wait_less
	end
	# select allocation schedule tabs by name 
	def AS.select_tab  tab_name
		FFA.click_grid_tab_by_label tab_name
	end 
	
	# selects a template	
	def AS.select_allocsched_template alloc_template
		find($as_allocsched_template).set alloc_template
		gen_tab_out $as_allocsched_template
	end

	# select an option for tab 2.
	def AS.set_schedule schedule
		find('label', :text => schedule).click
	end 

	# Hourly Frequency
	# Set Schedule Frequency -> Hourly ->Interval
	def AS.set_repeat_interval hourly_interval
		find($as_hourly_interval).set hourly_interval
		gen_tab_out $as_hourly_interval
	end

	# Set Schedule Frequency -> Hourly ->Offset
	def AS.set_start_offset hourly_offset
		find($as_hourly_offset).set hourly_offset
		gen_tab_out $as_hourly_offset
	end

	# All hourly option in one method
	def AS.set_hourly_inoneline hourly_int, offset_hourly
		AS.set_repeat_interval hourly_int
		AS.set_start_offset offset_hourly
	end

	# Daily Frequency
	# set schedule frequency -> daily -> start time
	def AS.set_daily_start_time daily_start
        find($as_daily_start_time).click
        find($gen_f_list_plain).find("li",:text => daily_start).click
    end

    # Weekly Frequency
    # set schedule frequency -> weekly -> days of the week
    def AS.set_weekly_days weekly_days
    	find('label', :text => weekly_days).click
    end

    # set schedule frequency -> weekly -> start time
    def AS.set_weekly_start_time weekly_start_time
    	find($as_weekly_start_time).click 
    	find($gen_f_list_plain).find("li",:text => weekly_start_time).click  
    end

    # Monthly Frequency
    # monthly day option
    def AS.select_monthly_day_option
     	find($as_monthly_day_option).click	
    end

    # Set Schedule Frequency -> Monthly -> By Month day
	def AS.set_monthly_day day
		find($as_monthly_day).set day
		gen_tab_out $as_monthly_day
	end

	# Set schedule frequency -> Monthly -> start time
	def AS.set_monthly_day_start_time monthly_day_start_time
		find($as_monthly_day_start_time).click
		find($gen_f_list_plain).find("li",:text => monthly_day_start_time).click
	end

	# set monthly option one in one roll
	def AS.set_monthly_day_all_in_one monthly_day , starttime
		AS.select_monthly_day_option
		AS.set_monthly_day monthly_day
		AS.set_monthly_day_start_time starttime
	end

    # monthly weekly option
    def AS.select_monthly_weekly_option
    	find($as_monthly_week_option).click
    end

	#Set Schedule Frequency -> Monthly -> By Occurrence
	def AS.set_monthly_day_occurrence occurrence
		find($as_monthly_week_occurrence).set occurrence
		gen_tab_out $as_monthly_week_occurrence
	end

	# Set Schedule Frequency -> Monthly -> By Occurrence -> weekday
	def AS.set_monthly_day_occurrence_weekday weekday
		find($as_monthly_week_occurrence_weekday).set weekday
		gen_tab_out $as_monthly_week_occurrence_weekday
	end

	# set schedule frequency -> monthly -> by occurrence -> weekday -> start time
	def AS.set_monthly_occurrence_start_time occurrence_start_time
		find($as_monthly_week_start_time).click
		find($gen_f_list_plain).find("li", :text => occurrence_start_time).click
	end

	# set monthly option two in one roll
	def AS.set_monthly_week_all_in_one day_occurrence , weekday_occurrence , occurrence_starttime
		AS.select_monthly_weekly_option
		AS.set_monthly_day_occurrence day_occurrence
		AS.set_monthly_day_occurrence_weekday weekday_occurrence
		AS.set_monthly_occurrence_start_time occurrence_starttime
	end

	# set schedule ends
	def AS.set_schedule_ends schedule_ends
		find($as_schedule_ends).click 
		find($gen_f_list_plain).find("li", :text => schedule_ends).click
	end

	#set schedule ends occurrence
	def AS.set_schedule_end_after_occurence schedule_end_after_occurence 
		find($as_schedule_end_after_occurence).set schedule_end_after_occurence
		gen_tab_out $as_schedule_end_after_occurence
	end

	#set schedule end - by date
	def AS.set_schedule_end_by_date schedule_end_by_date
		find($as_schedule_end_by_date).set schedule_end_by_date
		gen_tab_out $as_schedule_end_by_date
	end
	
	# set Retrieve Transactions Date Range
	def AS.set_date_range_type date_range_type
		find('label', :text => date_range_type).click
	end

	# date range type -> static
	# select static transaction from date
	def AS.set_transaction_from_date transaction_from_date
		find($as_transaction_from_date).set transaction_from_date
		gen_tab_out $as_transaction_from_date
	end
	#select static transaction to date
	def AS.set_transaction_to_date transaction_to_date
		find($as_transaction_to_date).set transaction_to_date
		gen_tab_out $as_transaction_to_date
	end

	# date range type -> dynamic
	def AS.select_transaction_by transaction_by
		if transaction_by.upcase == "PERIOD"
			find($as_date_range_period).click 
		elsif transaction_by.upcase == "MONTH"
				find($as_date_range_month).click 
		end 	
	end
	# select dynamic transaction by - period
	def AS.select_transaction_by_period transaction_by_period
		find($as_dynamic_by_period).click
		find($gen_f_list_plain).find("li", :text => transaction_by_period).click
	end

	# select dynamic transaction by - month
	def AS.select_transaction_by_month transaction_by_month
		find($as_dynamic_by_month).click
		find($gen_f_list_plain).find("li", :text => transaction_by_month).click
	end

	# date range type -> Advanced
	# select first available transaction
	def AS.select_transaction_from_first_avail
		find($as_advanced_date_of_first).click
	end

	# select transactions from number of days before the selected to date
	def AS.select_transaction_from_days_before_to_date days_before_to_date
		find($as_advanced_date_before_to_date).click
		find($as_advanced_days_prior_to_date).set days_before_to_date
		gen_tab_out $as_advanced_days_prior_to_date
	end

	# set advanced transaction to date.
	def AS.select_advanced_transaction_to advanced_transaction_to 
		find($as_advanced_transaction_to_date).set advanced_transaction_to
		gen_tab_out $as_advanced_transaction_to_date
	end
	
	# set posting details
	# posting date by days offset from run date
	def AS.set_posting_date_offset run_date_offset
		find($as_posting_date_days_offset).click
		find($as_posting_date_offset).set run_date_offset
		gen_tab_out $as_posting_date_offset
	end

	# posting date by specific date
	def AS.set_posting_specific_date posting_specific_date
		find($as_posting_date_specific_date).click
		find($as_posting_specific_date).set posting_specific_date
		gen_tab_out $as_posting_specific_date
	end

	# posting allocation period derived from posting date
	def AS.select_period_from_posting_date
		find($as_period_from_posting_date).click
	end

	# posting allocation period derived from run date
	def AS.select_period_from_run_date
		find($as_period_from_run_date).click
	end
	# posting allocation period from periods offset from the posting date
	def AS.select_period_from_offset_posting_date period_from_offset_posting_date
		find($as_period_offset_from_posting_date).click
		find($as_alloc_period_from_offset).set period_from_offset_posting_date
		gen_tab_out $as_alloc_period_from_offset
	end

	# return the mesage from the schedule summary 
	def AS.get_summary_message index 
		selector = $as_schedule_summary_messages.gsub('nnn',index.to_s)
		return find(selector).text 
	end 

	# Accepting the pop up message
	def AS.confirm_error_message
		find($as_click_continue).click
	end

	# delete a schedule from the scheduler list view 
	def AS.delete_schedule schedule_name
		row = gen_get_row_in_grid $as_allocation_scheduler_grid, schedule_name, ALLOCATION_SCHEDULER_COLUMN_SCHEDULE_NAME
		find("#{$as_allocation_scheduler_grid} :nth-of-type(#{row}) td:nth-of-type(#{ALLOCATION_SCHEDULER_COLUMN_DELETE_SCHEDULE}) img").click
	end

	# delete all schedule
	def AS.delete_all_schedule 
		counter = 0
		while (page.has_css?($as_delete_a_schedule)) and counter < DEFAULT_TIME_OUT
			find("#{$as_allocation_scheduler_grid} :nth-of-type(1) td:nth-of-type(#{ALLOCATION_SCHEDULER_COLUMN_DELETE_SCHEDULE}) img").click
			AS.confirm_warning_message
		end			
	end

	# saves a schedule
	def AS.save_schedule
		find($as_save_schedule).click
		FFA.wait_page_message $ffa_msg_loading 
	end

	# run now button
	def AS.click_run_now
		find($as_click_run_now).click
		FFA.wait_page_message $ffa_msg_loading
	end

	# refresh screen
	def AS.click_refresh_button
		find($as_click_refresh_button).click
		FFA.wait_page_message $ffa_msg_loading
	end

	# click save schedule button when "The transactions to date for the next run will be after the run date" warning message is displayed
	def AS.confirm_warning_message
		find($as_click_save_schedule).click
		FFA.wait_page_message $ffa_msg_loading
	end

	# click the schedule list button to go back to the allocation scheduler list view.
	def AS.click_schedule_list_button
		find($as_click_schedule_list_button).click
		find($as_click_continue).click
		FFA.wait_page_message $ffa_msg_loading
	end

end
