#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module PS
extend Capybara::DSL
# objects
$palette_section_master_label = "Master Label"
$palette_section_object_name = "Object Name"
$palette_section_apex_class  = "ApexClass"
$palette_section_save = "input[name=save]"
$palette_section_delete = "input[name=del]"

# Methods
	# open the palette section from the custom meta data type
	def PS.open_palette_sections
		SF.set_global_search "Custom Metadata Types"
		gen_click_link_and_wait "Custom Metadata Types"
		gen_click_link_and_wait "Manage Records"
	end
	# open a specific palette section 
	def	PS.open_palette_section palette_section_name 
		gen_click_link_and_wait palette_section_name
		page.has_css?($palette_section_delete)
	end 
	# creat a new palette section 
	def PS.new_palette_section master_label , object_name , apex_class 
		PS.open_palette_sections 
		SF.click_button_new
		fill_in $palette_section_master_label ,:with => master_label
		fill_in $palette_section_object_name ,:with => object_name
		fill_in $palette_section_apex_class ,:with => apex_class
		SF.click_button_save
		page.has_css?($palette_section_delete)
	end
	# delete a palette section by name
	def PS.delete_palette_section palette_section_name 
		if page.has_link?($palette_section_name)
			PS.open_palette_section palette_section_name
			SF.click_button_delete 
			gen_alert_ok
		end 
	end 
end
