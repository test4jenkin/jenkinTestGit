 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BFM
extend Capybara::DSL

#Labes
$bfm_name_label = "Name"
$bfm_bank_format_definition_name= "Bank Format Definition"
$bfm_root_source_object_label = "Root Source Object"
$bfm_currency_label = "Currency"

$bfm_date_format_label = "Date Format"
$bfm_decimal_separator_label = "Decimal Separator"
$bfm_thousand_separator_label = "Thousands Separator"
#button
$bfm_bank_format_mapping_join_button="New Bank Format Mapping Join"
# Bank format mapping record type related list lables
$bfm_record_type_name_label = "Name"
$bfm_definition_record_type_label = "Bank Format Definition Record Type"
$bfm_record_type_root_source_object_label = "Root Source Object"
$bfm_record_type_bank_format_mapping_label = "Bank Format Mapping"
$bfm_record_type_output_type_sequence_label = "Output Type Sequence"

# Bank format mapping join related list 
$bfm_mapping_join_name_label = "Bank Format Mapping"
$bfm_mapping_join_object_from_label =  "Object From" 
$bfm_mapping_join_object_from_field_label =  "Object From Field" 
$bfm_mapping_join_object_to_label =  "Object To" 
$bfm_mapping_join_object_to_field_label =  "Object To Field" 
# Methods

	# set name of mapping
	def BFM.set_name name
		fill_in $bfm_name_label, with: name
	end

	# set bank format definition name
	def BFM.set_bank_format_definition format_definition_name
		fill_in $bfm_bank_format_definition_name, with: format_definition_name
	end

	# set root source object
	def BFM.set_root_source_object name
		fill_in $bfm_root_source_object_label, with: name
	end

	# set date format pattern
	def BFM.set_date_format date_format
		fill_in $bfm_date_format_label, with: date_format
	end

	# set decimal separator
	def BFM.select_decimal_separator decimal_separator
		element_id = find(:field_by_label,$bfm_decimal_separator_label)[:for]
		select(decimal_separator , :from => element_id)
	end

	# set thousand separatir value
	def BFM.select_thousand_separator thousand_separator
		element_id = find(:field_by_label,$bfm_thousand_separator_label)[:for]
		select(thousand_separator , :from => element_id)
	end

# Bank format mapping related list
	def BFM.set_record_type_name name
		fill_in $bfm_record_type_name_label, with: name
	end

	def BFM.set_format_definition_record_type record_type
		fill_in $bfm_definition_record_type_label, with: record_type
	end
	
	def BFM.set_record_type_root_source_object name
		fill_in $bfm_record_type_root_source_object_label, with: name
	end
	
	def BFM.set_record_type_bank_format_mapping name
		fill_in $bfm_record_type_bank_format_mapping_label, with: name
	end
	
	def BFM.set_record_type_output_type_sequence name
		fill_in $bfm_record_type_output_type_sequence_label, with: name
	end
	
# bank format mapping join label
	def BFM.set_bfm_mapping_joing_name name
		fill_in $bfm_mapping_join_name_label, with: name
	end
	
	def BFM.set_bfm_mapping_join_object_from object_from_value
		fill_in $bfm_mapping_join_object_from_label, with: object_from_value
	end
	
	def BFM.set_bfm_mapping_join_object_from_field object_from_field_value
		fill_in $bfm_mapping_join_object_from_field_label, with: object_from_field_value
	end
	
	def BFM.set_bfm_mapping_join_object_to object_to_value
		fill_in $bfm_mapping_join_object_to_label, with: object_to_value
	end
	
	def BFM.set_bfm_mapping_join_object_to_field object_to_field_value
		fill_in $bfm_mapping_join_object_to_field_label, with: object_to_field_value
	end
end	
