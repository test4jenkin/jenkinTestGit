#--------------------------------------------------------------------#
#	TID :  
# 	Pre-Requisite: Org with basedata deployed.
#  	Product Area: FFA
# 	Story:  
#--------------------------------------------------------------------#
describe "UI Test - Cash Entry New Field Setup", :type => :request do
	include_context "login"

	it "Create custom field on Cash Entry object" do
		_field_label = "Test Field"
		_field_length = "80"
		_object_name = $ffa_object_cash_entry
		#check if field already exists then add it to layout
		if SF.is_object_field_exists _object_name, _field_label
			_page_layout_name="Cash Entry Layout"
			_layout_panel=$sf_layout_panel_fields
			_target_location=$sf_edit_page_layout_target_position
			SF.edit_layout_add_field _object_name, _page_layout_name, _layout_panel, [_field_label], _target_location
		else
			SF.create_text_type_field $ffa_object_cash_entry, _field_label, _field_length
		end
	end	

end
