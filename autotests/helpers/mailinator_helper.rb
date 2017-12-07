
#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Mailinator  
extend Capybara::DSL
################################
# Mailinator Site 
################################
$mailinator_param_substitute='?'
$mailinator_site = "http://mailinator.com/"
$mailinator_user_id_box = "input#inboxfield"
$mailinator_check_it_button = "button[class='btn btn-dark']"
$mailinator_mail_subject_locator_pattern = "//div[contains(text(),'"+$mailinator_param_substitute+"')]"
$mailinator_inbox_section = "ul[id='inboxpane']"
$mailinator_mail_body = "div[id='msgpane']"
$mailinator_mail_content_frame = "msg_body"
$mailinator_mail_content = "html body"
$mailinator_delete_button = "span[title='Delete Emails'] i[class$='inverse']"

# Open mailnator and check for mail with subject -mail_subject and returns it content.
# user_mail_id= bcc email id ; delete_mail: If user want to delete the mail after getting the content.
	def Mailinator.get_mail_content user_mail_id, mail_subject , delete_mail
		mail_content = "NULL"
		# Currently mailinator is not supported on SAUCE lab, so skipping the verification of mail content when running script on SAUCE labs.
		# Once devops come up with some solution, we will remove the if condition.
		if !(DRIVER == "SAUCE")
			current_url_path=current_url
			visit $mailinator_site
			gen_wait_until_object $mailinator_user_id_box 
			find($mailinator_user_id_box).set user_mail_id
			find($mailinator_check_it_button).click
			gen_wait_until_object $mailinator_inbox_section
			mail_link = $mailinator_mail_subject_locator_pattern.gsub($mailinator_param_substitute, mail_subject)
			if page.has_xpath?(mail_link)
				find(:xpath, mail_link).click
				gen_wait_until_object $mailinator_mail_body
				within_frame($mailinator_mail_content_frame) do
					mail_content = find($mailinator_mail_content).text
				end
				# user want to delete mail
				if delete_mail
					find($mailinator_delete_button).click
					puts "Deleted mail after getting the content."
					sleep 1# wait for mail to delete and page to refresh.
				end
			else
				puts " WARNING:Mail Not yet delivered on mailinator with subject: #{mail_subject} "
			end
			visit current_url_path
			page.has_no_css?($mailinator_mail_body)
		else
			puts "  WARNING : Cannot access mailinator site on sauce machine. Skipping the mail verification on it."
		end
		return mail_content
	end
	
	# It will open a new window and will login to mailinator as per user_mail_id and will open the mail as per subject - mail_subject
	def Mailinator.open_mail_content user_mail_id, mail_subject
		Mailinator.sign_in user_mail_id
		Mailinator.open_email mail_subject
	end
	
	# open mailinator sie in new window and sign in as per username passed
	def Mailinator.sign_in user_mail_id
		within_window open_new_window do
			visit $mailinator_site
			gen_wait_until_object $mailinator_user_id_box 
			find($mailinator_user_id_box).set user_mail_id
			find($mailinator_check_it_button).click
			gen_wait_until_object $mailinator_inbox_section
		end
	end
	
	# open email on mailinator from inbox as per mail subject
	def Mailinator.open_email mail_subject
		within_window (page.driver.browser.window_handles.last) do
			mail_link = $mailinator_mail_subject_locator_pattern.gsub($mailinator_param_substitute, mail_subject)
			find(:xpath, mail_link).click
			page.has_css?($mailinator_mail_content_frame)
		end
	end
	
	# click on link in mailinator email body
	def Mailinator.click_link link_name
		within_window (page.driver.browser.window_handles.last) do
			page.has_css?($mailinator_mail_content_frame)
			within_frame($mailinator_mail_content_frame) do
				SF.click_link link_name
				sleep 1 # wait for new window to appear.
			end
		end
	end
	
	# signout and close the new window in which mailinator is opened.
	def Mailinator.sign_out
		num_of_windows =  page.driver.browser.window_handles.length
		within_window (page.driver.browser.window_handles.last) do
			SF.log_info "Number of windows opened: #{num_of_windows}"
			if (num_of_windows !=1)
				page.current_window.close
			end
		end
	end
end

