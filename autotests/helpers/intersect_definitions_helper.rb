 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module ISD
extend Capybara::DSL

###################################################
#Selectors 
###################################################
$isd_type_entity =  "//label[contains(text(),  'Entity')]/../following-sibling::td//input | //span[text()='Entity']/ancestor::label[1]/following::input[1]"
$isd_type_diemension_1 =  "//label[contains(text(),  'Dimension 1')]/../following-sibling::td//input | //span[text()='Dimension 1']/ancestor::label[1]/following::input[1]"
$isd_intersect_definition_name = "//td[text() = 'Intersect Definition Name']/following-sibling::td[1]//div | //span[text() = 'Intersect Definition Name']/../following::div[1]/div/span"

###################################################
#Methods
###################################################
# set intersect definition name
	def ISD.set_intersect_definition_name intersect_definition_name
			fill_in "Intersect Definition Name" ,:with => intersect_definition_name
	end
# View interset definition detail page 
	def ISD.open_intersect_definition_detail_page intersect_definition_name
			click_link intersect_definition_name
	end
# Set entity type
	def ISD.set_entity_type checked_value
		if(checked_value)
			find(:xpath , $isd_type_entity).set true
		else
			find(:xpath , $isd_type_entity).set false
		end
	end
# set dimension1 type value
	def ISD.set_dimension1_type checked_value
		if(checked_value)
			find(:xpath , $isd_type_diemension_1).set true
		else
			find(:xpath , $isd_type_diemension_1).set false
		end
	end
# get intersect definition name
	def ISD.get_intersect_definition_name
		page.has_xpath?($isd_intersect_definition_name)
		find(:xpath ,$isd_intersect_definition_name).text
	end
end
