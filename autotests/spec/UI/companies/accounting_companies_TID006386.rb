#--------------------------------------------------------------------#
#	TID : TID006386
# 	Pre-Requisite : Org with basedata deployed
#  	Product Area: Accounting - Companies (UI Test)
# 	Story: 26060
#--------------------------------------------------------------------#
describe "UI Test - Accounting : Companies - Suspense GLA, Retained Earnings, YE Mode", :type => :request do
	include_context "login"
	include_context "logout_after_each"
	before :all do
		#Hold Base Data
		FFA.hold_base_data_and_wait
		gen_start_test "TID006386 : UI Test - Accounting : Companies - Suspense GLA, Retained Earnings, YE Mode"
	end
	
	
	it "TID006386 : Suspense GLA, Retained Earnings, YE Mode" do
		gen_start_test "TID006386 : Suspense GLA, Retained Earnings, YE Mode"
		
		_record_type_sut = "SUT"
		_record_type_vat = "VAT"
		_gla_retained_earnings_1 = "Retained Earnings1"
		_gla_retained_earnings_2 = "Retained Earnings2"
		
		gen_start_test "Additional data required for TID006386"
		begin	
			# login as Accountant
			SF.login_as_user SFACC_USER
			SF.tab $tab_select_company
			FFA.select_company [$company_merlin_auto_usa], true
			SF.tab $tab_general_ledger_accounts
			SF.click_button_new
			GLA.create _gla_retained_earnings_1, "RERC0001", $bdu_gla_type_retained_earnings, nil
			SF.click_button_save
			SF.tab $tab_general_ledger_accounts
			SF.click_button_new
			GLA.create _gla_retained_earnings_2, "RERC0002", $bdu_gla_type_retained_earnings, nil
			SF.click_button_save
		end
		
		gen_start_test "TST006420 : SUT - Suspense GLA"
		begin
			SF.tab $tab_companies
			SF.click_button_new
			Company.select_record_type _record_type_sut
			Company.click_continue_button
			gen_compare_object_visible $company_suspense_gla, true, "Expected Suspense GLA is available on UI"
			gen_compare_object_visible $company_retained_earnings_gla, true, "Expected Retained Earnings GLA is available on UI"
			gen_compare_object_visible $company_year_end_mode, true, "Expected Year End Mode is available on UI"
			Company.set_company_name 'YE Process SUT'
			Company.set_suspense_gla $bdu_gla_postage_and_stationery
			Company.set_retained_earnings_gla _gla_retained_earnings_1
			Company.click_save_button
			gen_compare $bdu_gla_postage_and_stationery, Company.get_suspense_gla, "Expected value of Suspense GLA field to be "+$bdu_gla_postage_and_stationery
			gen_compare _gla_retained_earnings_1, Company.get_retained_earnings_gla, "Expected value of Retained Earnings GLA field to be "+_gla_retained_earnings_1
			gen_compare $bdu_year_end_mode_full_accounting_code, Company.get_year_end_mode, "Expected value of Year End Mode field to be "+$bdu_year_end_mode_full_accounting_code
		end
		
		gen_start_test "TST006421 : VAT - Suspense GLA"
		begin
			SF.tab $tab_companies
			SF.click_button_new
			Company.select_record_type _record_type_vat
			Company.click_continue_button
			gen_compare_object_visible $company_suspense_gla, true, "Expected Suspense GLA is available on UI"
			gen_compare_object_visible $company_retained_earnings_gla, true, "Expected Retained Earnings GLA is available on UI"
			gen_compare_object_visible $company_year_end_mode, true, "Expected Year End Mode is available on UI"
			Company.set_company_name 'YE Process VAT'
			Company.set_suspense_gla $bdu_gla_sales_parts
			Company.set_retained_earnings_gla _gla_retained_earnings_2
			Company.select_year_end_mode $bdu_year_end_mode_gla_only
			Company.click_save_button
			gen_compare $bdu_gla_sales_parts, Company.get_suspense_gla, "Expected value of Suspense GLA field to be "+$bdu_gla_sales_parts
			gen_compare _gla_retained_earnings_2, Company.get_retained_earnings_gla, "Expected value of Retained Earnings GLA field to be "+_gla_retained_earnings_2
			gen_compare $bdu_year_end_mode_gla_only, Company.get_year_end_mode, "Expected value of Year End Mode field to be "+$bdu_year_end_mode_gla_only
		end
		gen_end_test "TID006386 : Suspense GLA, Retained Earnings, YE Mode"
	end
	after :all do
		login_user
		# Delete Test Data
		FFA.delete_new_data_and_wait
		SF.logout
		gen_end_test "TID006386 : UI Test - Accounting : Companies - Suspense GLA, Retained Earnings, YE Mode"
	end
end