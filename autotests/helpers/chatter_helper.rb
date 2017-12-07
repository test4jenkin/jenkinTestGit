 #FinancialForce.com, inc. claims copyright in this software, its screen display designs and
 #supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
 #Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
 #result in criminal or other legal proceedings.
 #Copyright FinancialForce.com, inc. All rights reserved.
module Chatter
extend Capybara::DSL
# Selectors
$chatter_button_share_label = "Share"
$chatter_iframe = "iframe[class*='cke_wysiwyg_frame cke_reset']"
$chatter_post_text_box = "body[class*='chatterPublisherRTE']"
$chatter_action = "a[title='More Actions']"
$chatter_action_menu = "More Actions"
$chatter_action_menu_edit = "Edit this post"
$chatter_action_menu_bookmark = "Bookmark this post"
$chatter_action_menu_delete = "Delete this post"
$chatter_action_menu_add_topics = "Add topics to this post"
$chatter_file_share_wrapper = "div[class=publisherWrapper]"



	Capybara.add_selector(:action_menu) do
		css { |label_value| "a[title='#{label_value}']"}
	end
# Methods 
	def Chatter.show_feed
		if  page.has_link? "Show Feed" 
			click_link "Show Feed"
			page.has_css?($chatter_post_text_box)
			sleep 1 
		end 
	end 
	#  Click on share button 
	def Chatter.share 
		click_button $chatter_button_share_label
		gen_wait_less 
	end 
	# share a post in chatter 
	def Chatter.share_post post_text 	
		click_link "Post"	
		chatter_frame = find($chatter_iframe)
		within_frame(chatter_frame) do 
			find($chatter_post_text_box).set post_text
		end 
		Chatter.share
		gen_wait_less 
	end 
	# Share a link 
	def Chatter.share_link link_url ,link_name 
		click_link "Link"
		fill_in "url" , :with => link_url
		fill_in "urlName" , :with => link_name
		Chatter.share 
	end 
	# share a poll on chatter
	def Chatter.share_poll poll_text , option1, option2
		click_link "Poll"
		fill_in "publishereditablearea" , :with => poll_text
		fill_in "choiceinput1" , :with => option1
		fill_in "choiceinput2" , :with => option2
		Chatter.share 
	end 
	# open more action menu on first feed 
	def Chatter.more_action_menu 
		find(:action_menu,$chatter_action_menu).click
	end 
	# From more action menu select edit 
	def Chatter.action_edit
		Chatter.more_action_menu 
		find(:action_menu,$chatter_action_menu_edit).click
	end 
	# From more action menu select book mark 
	def Chatter.action_bookmark
		Chatter.more_action_menu 
		find(:action_menu,$chatter_action_menu_bookmark).click
	end 
	# From more action menu select Delete
	def Chatter.action_delete 
		Chatter.more_action_menu 
		find(:action_menu,$chatter_action_menu_delete).click
		sleep 1
		gen_alert_ok
	end 
	# From more action menu Add topics
	def Chatter.action_add_topics 
		Chatter.more_action_menu 
		find(:action_menu,$chatter_action_menu_add_topics).click
	end 
	# delete all posts on an object
	def Chatter.delete_all_posts
		counter = 0
		while(page.has_css?($chatter_action)) and counter < DEFAULT_TIME_OUT
			Chatter.action_delete 
			counter += 1
		end
	end 
end