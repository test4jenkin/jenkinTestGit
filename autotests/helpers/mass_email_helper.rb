 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module ME  
extend Capybara::DSL
#############################
# Mass Email Helper
#############################
#selector
$me_selection_definition_name = "input[id$='selectionField']"
$me_email_template_picklist = "select[id$='emailTemplateDetailField']"
$me_send_button = "input[name$=':send']"
#methods

	# set selection definition name$
	def ME.set_selection_definition_name name
		SF.execute_script do
			find($me_selection_definition_name).set name
		end 
	end
	
	# select email template
	def ME.select_email_template template_name
		SF.execute_script do
			email_template_id = find($me_email_template_picklist)[:id]
			select(template_name, :from => email_template_id)
		end 
	end
	
	# click on send button
	def ME.click_send_button
		SF.execute_script do
			find($me_send_button).click
			page.has_css?($page_vf_message_text)
		end		
	end
	
end 
