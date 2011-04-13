#!/usr/bin/ruby

require 'net/pop'
require 'openssl'
require 'rubygems'

username = ENV['ECUSER']
password = ENV['ECPASS']

Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
Net::POP3.start('pop.gmail.com', 995, username, password) do |pop|
	if pop.mails.empty?
		puts 'No mail.'
	else
		pop.each_mail do |mail|
            
      if mail.pop =~ /From: Andrew Davidson <andrew@amdavidson.com>/
        d = Date.parse(mail.pop.scan(/Date: (\w.*)/).to_s)   
        t = mail.pop.scan(/Subject: (\w.*)/).to_s.downcase.sub!(/\s/,"-")
        puts "Year: " + d.year.to_s
        puts "Month: " + d.month.to_s
        puts "Title: " + t
        filename = "messages/" + d.year.to_s + "-" + d.month.to_s + "-" + t
        puts "Saving post as " + filename
        File.open(filename, 'w') { |f| f.write(mail.pop) }
      else
        puts "Not from Andrew."
      end

    end
	end
end



