 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module USER
extend Capybara::DSL
#selectors
$user_new_user_button = "input[value='New User']"
$user_last_name = "input[id='name_lastName']"
$user_email_address = "input[id='Email']"
#Labels
$user_license_label = "User License"
$user_profile_label = "Profile"
$user_email_label = "Email"
$user_timezone_label = "Time Zone"
$user_locale_label = "Locale"
$user_language_label = "Language"
$user_last_name_label = "Last Name"
$user_username_label = "Username"
$user_role_label = "Role"
#for media Setup
$user_dsm_user_id_label = "DSM User ID"

#user details
$user_salesforce_license = "Salesforce"
#############################
# User Companies
#############################
	# click on new user button
	def USER.click_new_user_button
		SF.retry_script_block do
			find($user_new_user_button).click
			SF.wait_for_search_button
		end
	end

	# Set user Last name_lastName
	def USER.set_last_name last_name
		find($user_last_name).set last_name
		gen_tab_out $user_last_name

	end
# Set user email
	def USER.set_email email
		fill_in $user_email_label ,:with => email
		gen_tab_out $user_email_address
	end
	
	# select license
	def USER.select_license license
		select(license, :from => $user_license_label)
	end
	
	# select profile
	def USER.select_profile profile
		select(profile, :from => $user_profile_label)
	end
	
	#Set dsm user id , 
	#dfp_id - dfp user Id
	def USER.set_dsm_user_id dfp_id
		fill_in $user_dsm_user_id_label ,:with => dfp_id
	end
	
	#select user langauge
	def USER.select_user_language language
		select(language, :from => $user_language_label)
	end

	#select user langauge
	def USER.select_user_timezone timezone
		select(timezone, :from => $user_timezone_label)
	end
	
	#select user langauge
	def USER.select_user_locale locale
		select(locale, :from => $user_locale_label)
	end
	
	#select user role
	def USER.select_user_role user_role
		select(user_role, :from => $user_role_label)
	end
	
	# display all users on users page
	def USER.display_all_users
		select $sf_all_users_view_active_users, :from => $sf_all_users_view
		page.has_css?($user_new_user_button)
	end
end 
