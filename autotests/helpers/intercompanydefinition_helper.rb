 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module ICD
extend Capybara::DSL
#############################
# Inter-Company Definition (VF pages)
#############################

####################################
# Inter-Company Definition Selectors 
####################################
$icd_related_company_label = "Related Company"
$icd_account_recievable_gla_label = "Accounts Receivable GLA"
$icd_source_dimension1_label = "Source Dimension 1"
$icd_source_dimension2_label = "Source Dimension 2"
$icd_source_dimension3_label = "Source Dimension 3"
$icd_source_dimension4_label = "Source Dimension 4"
$icd_account_payable_gla_label = "Accounts Payable GLA"
$icd_destination_dimension1_label = "Destination Dimension 1"
$icd_destination_dimension2_label = "Destination Dimension 2"
$icd_destination_dimension3_label = "Destination Dimension 3"
$icd_destination_dimension4_label = "Destination Dimension 4"
$icd_intercompany_definition_number = "div[id='Name_ileinner'] , div[class='slds-media__body'] h1 span"

####################################
# Inter-Company Definition Methods 
####################################
# set information details
# set related company
	def ICD.set_related_company related_company
		SF.fill_in_lookup $icd_related_company_label , related_company
	end 

# set Source Analysis
# set account receivable GLA 
	def ICD.set_acc_recievable_gla recievable_GLA
		SF.fill_in_lookup $icd_account_recievable_gla_label , recievable_GLA
	end 
# set source dimension 1
	def ICD.set_source_dimension_1 source_dimension1
		SF.fill_in_lookup $icd_source_dimension1_label , source_dimension1
	end 
# set source dimension 2
	def ICD.set_source_dimension_2 source_dimension2
		SF.fill_in_lookup $icd_source_dimension2_label , source_dimension2
	end
# set source dimension 3
	def ICD.set_source_dimension_3 source_dimension3
		SF.fill_in_lookup $icd_source_dimension3_label , source_dimension3
	end
# set source dimension 4
	def ICD.set_source_dimension_4 source_dimension4
		SF.fill_in_lookup $icd_source_dimension4_label , source_dimension4
	end

# set Destination Analysis
# set account payable GLA 
	def ICD.set_acc_payable_gla payable_GLA
		SF.fill_in_lookup $icd_account_payable_gla_label , payable_GLA
	end 
# set destination dimension 1
	def ICD.set_destination_dimension_1 destination_dimension1
		SF.fill_in_lookup $icd_destination_dimension1_label , destination_dimension1
	end 
# set destination dimension 2
	def ICD.set_destination_dimension_2 destination_dimension2
		SF.fill_in_lookup $icd_destination_dimension2_label , destination_dimension2
	end 
# set destination dimension 3
	def ICD.set_destination_dimension_3 destination_dimension3
		SF.fill_in_lookup $icd_destination_dimension3_label , destination_dimension3
	end 
# set destination dimension 4
	def ICD.set_destination_dimension_4 destination_dimension4
		SF.fill_in_lookup $icd_destination_dimension4_label , destination_dimension4
	end
	
# get Intercompany Definition Number
	def ICD.get_intercompany_definition_number
		gen_wait_until_object $icd_intercompany_definition_number
		return find($icd_intercompany_definition_number).text
	end
	

# Full line in one go (default fields)
	def ICD.createInterCompanyDefnition relatedCompany , recievableGLA , sourceDimension1 , sourceDimension2 , sourceDimension3 , sourceDimension4 , payableGLA , destinationDimension1 , destinationDimension2 , destinationDimension3 , destinationDimension4
		if relatedCompany != nil 
			ICD.set_related_company relatedCompany 
		end 
		if recievableGLA != nil 
			ICD.set_acc_recievable_gla recievableGLA 
		end 
		if sourceDimension1 != nil 
			ICD.set_source_dimension_1 sourceDimension1
		end 
		if sourceDimension2 != nil 
			ICD.set_source_dimension_2 sourceDimension2 
		end 
		if sourceDimension3 != nil 
			ICD.set_source_dimension_3 sourceDimension3
		end 
		if sourceDimension4 != nil 
			ICD.set_source_dimension_4 sourceDimension4 
		end
		if payableGLA != nil 
			ICD.set_acc_payable_gla payableGLA
		end
		if destinationDimension1 != nil 
			ICD.set_destination_dimension_1 destinationDimension1 
		end 
		if destinationDimension2 != nil 
			ICD.set_destination_dimension_2 destinationDimension2
		end 
		if destinationDimension3 != nil 
			ICD.set_destination_dimension_3 destinationDimension3
		end 
		if destinationDimension4 != nil 
			ICD.set_destination_dimension_4 destinationDimension4
		end 
	end 
end 