#FinancialForce.com, inc. claims copyright in this software, its screen display designs and
#supporting documentation. FinancialForce and FinancialForce.com are trademarks of FinancialForce.com, inc.
#Any unauthorized use, copying or sale of the above may constitute an infringement of copyright and may
#result in criminal or other legal proceedings.
#Copyright FinancialForce.com, inc. All rights reserved. 
module MAIL
require 'mail'
options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'mail.google.com',
            :user_name            => 'testsmoke33@gmail.com',
            :password             => 'metacube#1234',
            :authentication       => 'plain',
            :enable_starttls_auto => true
}
Mail.defaults do
  delivery_method :smtp, options
end
def MAIL.sendmail _to, _from, _subject, _body,_filePath1,_filePath2,*others
	Mail.deliver do
		to _to
		from _from
		subject _subject
		body _body
		if File.exist?("#{_filePath1}")
			add_file  _filePath1
		else
			puts "File Not Found (#{_filePath1}), Skipping from email"
		end
		if File.exist?("#{_filePath2}")
			add_file  _filePath2
		else
			puts "File Not Found (#{_filePath2}), Skipping from email"
		end
		
		row = 0
		others[0].each do |file_path|
			if row >0
				if File.exist?("#{file_path}")
					add_file  "./#{file_path}"
				else
					puts "File Not Found (#{file_path}), Skipping from email"
				end
			end
			row = row + 1
		end
	end
end
end
