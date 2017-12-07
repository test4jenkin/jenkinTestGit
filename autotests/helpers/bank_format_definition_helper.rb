 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module BFD
extend Capybara::DSL

$bfd_new_bank_format_definition_record_type  = "New Bank Format Definition Record Type"
$bfd_new_bank_format_mapping_record_type = "New Bank Format Mapping Record Type"
$bfd_name_textbox = "input[id*='Name']"
$bfd_external_id_textbox = "//label[text()='External Id']/../following-sibling::td[1]/div/input"
$bfd_csv_output_checkbox = "//label[text()='CSV Output']/../following-sibling::td[1]/input"
$bfd_uppercase_checkbox = "//label[text()='Upper Case']/../following-sibling::td[1]/input"
$bfd_double_quotes = "//label[text()='Double Quotes']/../following-sibling::td[1]/input"
$bdf_document_name = "//td[text()='Document Name']/following::td[1]"
$bfd_record_type_name_textbox = "input[id*='Name']"
$bfd_record_type_option = "//label[text()='Record Type']/../following-sibling::td[1]/span/select"
$bfd_record_type_currency_option = "//label[text()='Currency']/../following-sibling::td[1]/div/select"
$bfd_record_type_output_type_sequence_textbox = "//label[text()='Output Type Sequence']/../following-sibling::td[1]/div/input"
$bfd_record_type_output_sequence_textbox = "//label[text()='Output Sequence']/../following-sibling::td[1]/div/input"
$bfd_record_type_external_id_textbox = "//label[text()='External Id']/../following-sibling::td[1]/div/input"
$bfd_record_type_detail = "Detail"


	# set Bank format defination Name
	def BFD.set_name name
		SF.execute_script do
			return find($bfd_name_textbox).set name
		end
	end
	
	# set Bank format defination external Id
	def BFD.set_external_id external_id
		SF.execute_script do
			return find(:xpath,$bfd_external_id_textbox).set external_id
		end
	end
	
	# set Bank format csv output 
	# check_csv_output -true (check checkbox), false - uncheck checkbox
	def BFD.set_csv_output check_csv_output
		SF.execute_script do
			return find(:xpath,$bfd_csv_output_checkbox).set check_csv_output
		end
	end
	
	# set Bank format uppercase
	# check_uppercase -true (check checkbox), false - uncheck checkbox
	def BFD.set_uppercase check_uppercase
		SF.execute_script do
			return find(:xpath,$bfd_uppercase_checkbox).set check_uppercase
		end
	end
	
	# set Bank format double_quotes
	# check_double_quotes -true (check checkbox), false - uncheck checkbox
	def BFD.set_double_quotes check_double_quotes
		SF.execute_script do
			return find(:xpath,$bfd_double_quotes).set check_double_quotes
		end
	end	
	
	# set Bank format defination record type Name
	def BFD.set_record_type_name name
		SF.execute_script do
			return find($bfd_record_type_name_textbox).set name
		end
	end
	
	# set Bank format defination record type option
	def BFD.set_record_type_option option_name
		SF.execute_script do
			return find(:xpath, $bfd_record_type_option).set option_name
		end
	end
	
	# set Bank format defination record Output Type Sequence
	def BFD.set_record_type_output_type_sequence seq_value
		SF.execute_script do
			return find(:xpath,$bfd_record_type_output_type_sequence_textbox).set seq_value
		end
	end
	
	# set Bank format defination record Output Sequence
	def BFD.set_record_type_output_sequence seq_value
		SF.execute_script do
			return find(:xpath,$bfd_record_type_output_sequence_textbox).set seq_value
		end
	end
	
	# set Bank format defination record External Id
	def BFD.set_record_type_external_id external_id
		SF.execute_script do
			return find(:xpath,$bfd_record_type_external_id_textbox).set external_id
		end
	end
	
	# get document name
	def BFD.get_document_name
		page.has_xpath?($bdf_document_name)
		return find(:xpath,$bdf_document_name).text
	end
end	
