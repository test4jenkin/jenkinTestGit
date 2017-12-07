#--------------------------------------------------------------------#
# 	Pre-Requisite :Install latest versions of following packages on Org in same order
#				  # org with base data and SCM, AvaTax for SCM, SCM to FFA Connector, SCM Avatax Plugins
#  	Product Area: Accounting - Check
#--------------------------------------------------------------------#
describe "Smoke Test - SCM connector", :type => :request do
include_context "login"
	
	it	"set remote site setting to execute apex command from UI." do
		SF.retry_script_block do
			#get page URL for salesforce API Usage 
			url_prefix = page.current_url.split('/')[0]
			url_host = page.current_url.split('/')[2]
			run_anonymous_url = url_prefix +"//"+url_host+"/apex/BaseDataJob"
			visit run_anonymous_url
			gen_wait_until_object $apex_delete_new_data_button      
			api_url = page.current_url
			SF.remote_site_settings_create_new
			SF.remote_site_settings_set_site_name "SALESFORCE_API"
			SF.remote_site_settings_set_site_url api_url
			SF.remote_site_settings_set_disable_protocol_security "true"  
			SF.click_button_save
		end
	end	
	
	it	"Remote Site Settings , Add URL" do
		login_user
		SF.retry_script_block do
			api_url = "https://development.avalara.net/"
			SF.remote_site_settings_create_new
			SF.remote_site_settings_set_site_name "AVALARA"
			SF.remote_site_settings_set_site_url api_url
			SF.remote_site_settings_set_disable_protocol_security "true"  
			SF.click_button_save
		end
	end
	
	it	"Add custom tab" do
		login_user
		SF.retry_script_block do
			#add custom Tab
			SF.create_tab_for_custom_object $ffa_object_product_group, $tab_product_groups
		end
	end
	
	it	"Product Group Layout changes" do
		login_user
		SF.retry_script_block do
			_layout_name = "Product Group Layout"
			_field_to_add = ["Product"]
			SF.edit_layout_add_field $ffa_object_product_group, _layout_name, $sf_layout_panel_fields, _field_to_add, $sf_edit_page_layout_target_position
			SF.wait_for_search_button
		end
	end
	
	it	"ICP Layout layout changes" do
		login_user
		SF.retry_script_block do
			_layout_name = "ICP Layout"
			_field_to_add = ["Company"]
			SF.edit_layout_add_field $ffa_object_icp, _layout_name, $sf_layout_panel_fields, _field_to_add, $sf_edit_page_layout_target_position
			SF.wait_for_search_button
		end
	end
	
	it	"Invoicing Layout layout changes" do
		login_user
		SF.retry_script_block do
			_layout_name = "Invoicing Layout"
			_buttons_to_add = [$so_tax_and_push_to_ffa.to_s]
			SF.edit_layout_add_field $ffa_object_invoicing, _layout_name, $sf_layout_panel_button, _buttons_to_add,  $sf_edit_page_layout_target_position_button
			SF.wait_for_search_button
		end
	end
	
	it	"Account Layout layout changes" do	
		login_user
		SF.retry_script_block do
			_layout_name = "Account Layout"
			_field_to_add = [$account_trading_currency_label.to_s, $account_accounts_receivable_control_label.to_s]
			SF.stdobj_edit_layout_add_field $ffa_object_accounts, _layout_name, $sf_layout_panel_fields, _field_to_add,  $sf_edit_page_layout_target_position
			SF.wait_for_search_button
		end
	end
	
	it	"Account Layout layout changes" do	
		login_user
		SF.retry_script_block do
			_layout_name = "Invoicing Layout"
			_field_to_add = [$so_invoicing_sales_invoice_label, $so_invoicing_sales_invoice_status_label]
			SF.edit_layout_add_field "Invoicing", _layout_name, $sf_layout_panel_fields, _field_to_add,  $sf_edit_page_layout_target_position
			SF.wait_for_search_button
		end
	end
end