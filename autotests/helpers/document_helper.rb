#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved.
module Document  
extend Capybara::DSL

#############################
# Document Selectors
#############################
$document_list_folders_option = "//option[text()='"+$sf_param_substitute+"']"
$document_grid_view_document_link_pattern = ".documentBlock table tr:nth-of-type("+$sf_param_substitute+") a:nth-of-type(3)"
$document_grid_view_table_rows = "table[class='list'] tr"
$document_list_grid_row_pattern_document_name = $document_grid_view_table_rows + ":nth-of-type("+$sf_param_substitute+") " + "th a"

##Document List View
$document_list_view_column_name = "Name"

##########Methods##########################

##
#
# Method Summary : Open the Folder in the Documents tab
# @param [String] folder_name -   Name of the Folder to Open
#
def Document.open_document_folder folder_name
	folder_name = $document_list_folders_option.sub($sf_param_substitute,folder_name)
	find('#fcf').find(:xpath,folder_name).click
	click_button('Go!')	
end

##
#
# Method Summary : Click the View link in the Document list page
# @param [String] col_name_to_search - Name of the column to Search the Text
# @param [String] document_name - Name of the document to be search in the column
#
def Document.click_view_link_on_document_list_grid document_name 
	row_position = Document.get_row_number_in_grid_by_document_name(document_name)
	page.has_css?($document_grid_view_document_link_pattern.gsub($sf_param_substitute,(row_position).to_s))
	SF.retry_script_block do
		element = $document_grid_view_document_link_pattern.gsub($sf_param_substitute,(row_position).to_s)
		find(element).hover
		find(element).click
	end
	SF.wait_for_search_button
end

##
#
# Method Summary : Return  the row  number of a grid by searching every row for search_text string
# @param [String] search_text -  Name of the document to be searched in list view of documents
#
def Document.get_row_number_in_grid_by_document_name search_text 
	allrows  = all($document_grid_view_table_rows)
	row = 1
	result_grid_row_pattern = $document_list_grid_row_pattern_document_name
	# get the value of 
	while  row <= (allrows.count - 1)
		page_grid_row = result_grid_row_pattern.sub($sf_param_substitute , (row + 1).to_s)	
		cellvalue = find(page_grid_row).text
		if search_text == cellvalue
			row += 1
			break
		end
		row += 1
	end 
	return row
end	
end 
