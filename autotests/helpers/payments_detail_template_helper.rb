 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module PAYTEMPLATE
extend Capybara::DSL
#############################
# Payment detail Template(VF pages)
#############################
$paytemplate_template_currency_lookup= "img[title='Payment Currency Lookup (New Window)']"
#Labels of Input Field
# Payment Information
$paytemplate_template_name_label = "Payment Details Template Name"
$paytemplate_bank_account_name_label = "Bank Account"
$paytemplate_payment_currency_label = "Payment Currency"
$paytemplate_default_checkbox_label = "Default"
$paytemplate_payment_media_picklist_label= "Payment Method"

# Posting Information
$paytemplate_settlement_discount_gla_label = "Settlement Discount GLA"
$paytemplate_settlement_discount_dim1_label = "Settlement Discount Dimension 1"
$paytemplate_settlement_discount_dim2_label = "Settlement Discount Dimension 2"
$paytemplate_settlement_discount_dim3_label = "Settlement Discount Dimension 3"
$paytemplate_settlement_discount_dim4_label = "Settlement Discount Dimension 4"
$paytemplate_curr_write_off_gla_label = "Currency Write-off GLA"
$paytemplate_curr_write_off_dim1_label = "Currency Write-off Dimension 1"
$paytemplate_curr_write_off_dim2_label = "Currency Write-off Dimension 2"
$paytemplate_curr_write_off_dim3_label = "Currency Write-off Dimension 3"
$paytemplate_curr_write_off_dim4_label = "Currency Write-off Dimension 4"
#Methods
	# set template name
	def PAYTEMPLATE.set_template_name name
		fill_in $paytemplate_template_name_label , :with => name
	end

	# set Bank account name
	def PAYTEMPLATE.set_bank_acc_name name
		fill_in $paytemplate_bank_account_name_label , :with => name
	end
	
	# set template currency 
	def PAYTEMPLATE.set_template_currency currency_name , company_name
		FFA.select_currency_from_lookup $paytemplate_template_currency_lookup ,currency_name,company_name
	end
	# check default checkbox 
	def PAYTEMPLATE.check_default_checkbox
		SF.check_checkbox $paytemplate_default_checkbox_label
	end
	
	# select payment media
	def PAYTEMPLATE.select_payment_media media_type
		select(media_type , :from => $paytemplate_payment_media_picklist_label)
	end
	
	# set settlement discount GLA
	def PAYTEMPLATE.set_settlement_discount_gla gla_name
		fill_in $paytemplate_settlement_discount_gla_label , :with => gla_name
	end
	
	# set settlement discount  dimension 1
	def PAYTEMPLATE.set_settlement_discount_dim1 dim1_name
		fill_in $paytemplate_settlement_discount_dim1_label , :with => dim1_name
	end
	
	# set settlement discount  dimension 2
	def PAYTEMPLATE.set_settlement_discount_dim2 dim2_name
		fill_in $paytemplate_settlement_discount_dim2_label , :with => dim2_name
	end
	
	# set settlement discount  dimension 3
	def PAYTEMPLATE.set_settlement_discount_dim3 dim3_name
		fill_in $paytemplate_settlement_discount_dim3_label , :with => dim3_name
	end
	
	# set settlement discount  dimension 4
	def PAYTEMPLATE.set_settlement_discount_dim4 dim4_name
		fill_in $paytemplate_settlement_discount_dim4_label , :with => dim4_name
	end
	
	# set currency write-off gla
	def PAYTEMPLATE.set_curr_write_off_gla gla_name
		fill_in $paytemplate_curr_write_off_gla_label , :with => gla_name
	end
	
	# set currency write-off dimension 1
	def PAYTEMPLATE.set_curr_write_dim1 dim1_value
		fill_in $paytemplate_curr_write_off_dim1_label , :with => dim1_value
	end
	
	# set currency write-off dimension 2
	def PAYTEMPLATE.set_curr_write_dim2 dim2_value
		fill_in $paytemplate_curr_write_off_dim2_label , :with => dim2_value
	end
	
	# set currency write-off dimension 3
	def PAYTEMPLATE.set_curr_write_dim3 dim3_value
		fill_in $paytemplate_curr_write_off_dim3_label , :with => dim3_value
	end
	
	# set currency write-off dimension 4
	def PAYTEMPLATE.set_curr_write_dim4 dim4_value
		fill_in $paytemplate_curr_write_off_dim4_label , :with => dim4_value
	end
	
	# save template
	def PAYTEMPLATE.save_template
		first(:button, $sf_save_button).click
	end
end


