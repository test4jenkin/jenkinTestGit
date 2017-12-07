#--------------------------------------------------------------------#
#	TID : None 
#	Pre-Requisit: Org with basedata deployed.
#	Product Area: Allocation 
# 	Story: None 
#--------------------------------------------------------------------#
describe "Data required for Allocation Scheduler , allocations template and allocation scheduler tests.", :type => :request do
	include_context "login"
	before :all do
		# login to merlin auto gbp 
		SF.app $accounting
		SF.tab $tab_select_company
		FFA.select_company [$company_merlin_auto_gb],true
	end
	it "Create Data required for UI tests - Create Sale Invoice 1" do
		login_user
		# Create Sale Invoice 1
		SF.tab $tab_sales_invoices
		SF.click_button_new
		SIN.set_account $bd_account_algernon_partners_co
		SIN.set_customer_reference "REF1"
 		SIN.select_shipping_method $bdu_shipping_method_fedex
		SIN.set_currency $bd_currency_gbp
		SIN.set_description "SIN1 DESCRIPTION1"
		SIN.add_line 1, $bd_product_a4_paper , 1 , 1000 , nil , nil , nil
		FFA.click_save_post
		gen_report_test "Invoice 1 created and posted"
	end
	it "Create Data required for UI tests - Create Sale Invoice 2" do
		login_user
		# Create Sales invoices 2
		SF.tab $tab_sales_invoices
		SF.click_button_new
		SIN.set_account $bd_account_coda_harrogate
		SIN.set_customer_reference "REF2"
		SIN.select_shipping_method $bdu_shipping_method_fedex
		SIN.set_currency $bd_currency_gbp
		SIN.set_description "SIN2 DESCRIPTION2"
		SIN.add_line 1, $bd_product_bendix_front_brake_pad_1975_83_chrysler_cordoba , 1 , 500 , nil , nil , nil
		FFA.click_save_post
		gen_report_test "Invoice 2 created and posted"
	end
	it "Create Data required for UI tests - Create first template" do
		login_user
		# Create first template
		# SF.tab $tab_allocations
		# gen_wait_until_object_disappear $page_loadmask_message
		# Allocations.set_gla $bd_gla_account_receivable_control_usd
		# Allocations.retrieve

		# Allocations.set_split_all_in_one "1", $bd_gla_rent, "90"
		# Allocations.set_split_all_in_one "2", $bd_gla_account_receivable_control_gbp, "10"
		# Allocations.save_template

		# Allocations.set_template_name "Template 01"
		# Allocations.set_template_desc "GLA ARC - USD to Rent and ARC - GBP"
		# Allocations.popup_save_template
		# gen_report_test "Template 1 created"
	end
	
	it "Create Data required for UI tests - Create second template" do
		login_user
		# Create second template
		SF.tab $tab_allocations
		gen_wait_until_object_disappear $page_loadmask_message
		Allocations.set_gla $bd_gla_account_receivable_control_gbp
		Allocations.retrieve

		Allocations.set_split_all_in_one "1", $bd_gla_heat_light_power, "80"
		Allocations.set_split_all_in_one "2", $bd_gla_sales_parts, "20"
		Allocations.save_template

		Allocations.set_template_name "Template 02"
		Allocations.set_template_desc "GLA ARC - EUR to Rent and Marketing"
		Allocations.popup_save_template
		gen_report_test "Template 2 created"
	end
end
