##
#TID : TID021985
#Product Area: Product Area 'Accounting - Archiving' 
#Pre requisite :  Feature License Have DataArchiving Added
#Pre requisite : FFA Data Archiving is enabled in the org ( TID022050 can be referred For details ) 
#Story: AC-10826
##

describe "Archiving Feature - Introduced in v18, Following script Tests Feature console and its properties", :type => :request do
include_context "login"
include_context "logout_after_each"
	
	# Enable Archiving feature on org 
	it "TID021985 - Archiving: Enabling Archiving feature On Org " do
		#Enable Archiving on org using feature console.
		SF.tab $fc_tab
		#Expecting Page to Have Archiving Feature Link
		gen_compare_has_link $fc_feature_ffa_enable_archiving, true, 'FFA Data Archiving'
			
		#Open Data Archiving feature		
		FC.open_feature $fc_feature_ffa_enable_archiving
		
		#Expect page to have Step 1 , #Description = 'Assign the Accounting - Data Archiving permission set to the user.'
		#Action = 'Mark As Done'#Status = 'Not Done'
		gen_compare_has_link ACTION_MARK_AS_DONE, true, 'Mark As Done'
		gen_compare_has_content $arc_feature_step_description, true, 'Assign the Accounting - Data Archiving permission set to the user.'
		gen_compare_has_css_with_text $fc_step_status_not_done, $fc_status_not_done, true, 'Default Staus Not Done'
			
		# Error Condition to Turn ON feature without Step Done
		find($fc_enable_feature_button).click
		expect(page).to have_xpath($arc_feature_On_error_locator)
        gen_report_test "User Cannot Turn ON FFA Data Archiving without Marking Step as Done"		
		#Enable Archiving Feature
		SF.click_link ACTION_MARK_AS_DONE
		gen_compare_has_css_with_text $fc_step_status_done, $fc_status_done, true, 'Status Changed to Done'
		expect(page).to have_xpath($arc_feature_enabled_succesfully)
		gen_compare_has_link ACTION_REVERT, true, 'Revert Link should Appear'		
		# Switch ON Data Archiving feture
		FC.click_enable_feature_button
		# Error Condition to test , when Feature is ON Step Cannot be reverted
		SF.click_link ACTION_REVERT
		expect(page).to have_xpath($arc_feature_revert_error_locator)
        gen_report_test "User Cannot Revert Step if Feature is ON"		
		#Feature Can be disabled and Revert can also be performed
		FC.click_disable_feature_button
		expect(page).to have_xpath($arc_feature_disabled_succesfully)
		gen_report_test "User Can disable feature succesfully"
		SF.click_link ACTION_REVERT
		gen_compare_has_link ACTION_MARK_AS_DONE, true, 'Mark As Done'
		gen_compare_has_css_with_text $fc_step_status_not_done, $fc_status_not_done, true, 'Default Staus Not Done'
	end
end