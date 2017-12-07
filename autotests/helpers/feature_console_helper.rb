#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.

ACTION_MARK_AS_DONE = 'Mark As Done'
ACTION_PERFORM = 'Perform'
ACTION_SKIP = 'Skip'
ACTION_REVERT = 'Revert'
module FC
  extend Capybara::DSL

  # Tabs
  $fc_tab = 'Feature Console'

  $fc_step_table = "tbody[id*='featureBlock'] tr:nth-of-type("+$sf_param_substitute+")"

  # Feature button elements locators.
  $fc_enable_feature_button = "img[src*='toggle-off']"
  $fc_feature_disable_button = "img[src*='toggle-on']"
  $fc_back_button = 'input[value="Back"]'
  $fc_remote_site_button = "input[value*='Remote']"
  $fc_feature_status_locator = "//tbody[contains(@id,'featuresPanel')]//a[text()='"+$sf_param_substitute+"']/../following-sibling::td[contains(@class,'status')]/label[not(contains(@class,'ffdc-fc-hidden'))]"
  $fc_step_status_locator = "tbody[id*='featureBlock'] tr:nth-of-type("+$sf_param_substitute+") label[class*='status']"
  $fc_step_status_done = "label[class*='ffdc-fcd-step-status-done']"
  $fc_step_status_not_done = "label[class*='ffdc-fcd-step-status-not-done']"
  $fc_action_link_text = "//label[@class='ffdc-fcd-step-status-not-done']/preceding::td[1]/span/a"
  
  #Step Numbers
  $fc_step_number_1 = '1'
  $fc_step_number_2 = '2'
  $fc_step_number_3 = '3'

  #features
  $fc_feature_erp_publications_and_subscriptions = 'ERP Publications and Subscriptions'
  $fc_feature_bc_publications_and_subscriptions = 'BC Publications and Subscriptions'
  $fc_feature_ffa_publications_and_subscriptions = 'FFA Publications and Subscriptions'
  $fc_feature_ffa_enable_spring_18 = 'FFA Enabling Spring 2018'
  $fc_feature_ffa_enable_archiving ='FFA Data Archiving'
  $fc_feature_ffa_payment_plus ='FFA Payments Plus'
  #Loading Icon
  $fc_in_progress_indicator = "span[class*='ffdc-fcd-in-progress']"

  #Status
  $fc_status_done = 'DONE'
  $fc_status_not_done = 'NOT DONE'

  ##
  #
  # Method Summary: Feature console requires remote site settings and this can be done automatically
  # by clicking the remote site settings button.
  #
  def FC.enable_remote_site_settings
	# craete remote site setting only when these are not already created.
	if(page.has_css?($fc_remote_site_button,:wait => DEFAULT_LESS_WAIT))
		find($fc_remote_site_button).click
	end
    #Adding Wait as creation of Remote Site Setting require 1 second
    gen_wait_less
  end

  ##
  #
  # Method Summary: Opens the feature from the features list.
  #
  # @param [String] feature_name   Name of the feature to open from the list.
  #
  def FC.open_feature(feature_name)
    click_link feature_name
    gen_wait_less
  end

   ##
  #
  # Method Summary: click the Mark as Done link to complete the setup 
  #
  def FC.click_action_mark_as_done
    click_link ACTION_MARK_AS_DONE
    gen_wait_until_object_disappear $fc_in_progress_indicator
  end
  
  ##
  #
  # Method Summary: Clicks the enable feature toggle switch button.
  #
  def FC.click_enable_feature_button
    find($fc_enable_feature_button).click
    gen_wait_until_object_disappear $fc_in_progress_indicator
  end

  ##
  #
  # Method Summary: Clicks the disable feature toggle switch button.
  #
  def FC.click_disable_feature_button
    find($fc_feature_disable_button).click
  end

  ##
  #
  # Method Summary: Clicks the back button on the feature screen.
  #
  def FC.click_back_button
    find($fc_back_button).click
  end

  ##
  #
  # Method Summary: Clicks the 'Perform' to enable the feature step.

  # @param [Integer] step_number   Feature step number
  #
  def FC.perform_feature_step(step_number)
    step_table = $fc_step_table.sub($sf_param_substitute,step_number.to_s)
    step_status = find($fc_step_status_locator.sub($sf_param_substitute, step_number)).text
    step_status_done = $fc_step_status_done.sub($sf_param_substitute, step_number)
    if(step_status != $fc_status_done)
      within(step_table) do
        click_link(ACTION_PERFORM)
        gen_wait_until_object_disappear $fc_in_progress_indicator
        page.evaluate_script("window.location.reload()")
        gen_wait_until_object step_status_done
      end
    end
  end
 
  # Method Summary: Enable Archiving Feature in the Org
 
  def FC.enable_archiving_feature
    SF.retry_script_block do
      SF.tab $fc_tab
      status = find(:xpath,$fc_feature_status_locator.sub($sf_param_substitute,$fc_feature_ffa_enable_archiving)).text
		if(status != 'ON')
		FC.open_feature $fc_feature_ffa_enable_archiving
		action =find(:xpath,$fc_action_link_text).text
			    if(action!='Revert')
				SF.click_link ACTION_MARK_AS_DONE
				FC.click_enable_feature_button
				else
				FC.click_enable_feature_button
				end
		 end		
	 end
  end	  
  ##
  #
  # Method Summary: Enable Feature Console Feature.
  #
  # @param [Integer] feature_name   Name of the feature to enable
  # @param List[Integer] steps          List of number of the steps to enable [$fc_step_number_1,$fc_step_number_2]
  #
  def FC.enable_feature feature_name,steps
    SF.retry_script_block do
      SF.tab $fc_tab
      status = find(:xpath,$fc_feature_status_locator.sub($sf_param_substitute,feature_name)).text
      if(status != 'ON')
        FC.open_feature(feature_name)
        steps.each do |step_number|
          FC.perform_feature_step(step_number)
        end
        FC.click_enable_feature_button
        FC.click_back_button
      end
    end
  end
end