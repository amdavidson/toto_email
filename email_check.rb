#!/usr/bin/ruby

require 'net/pop'
require 'openssl'

require ./passwords

Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
Net::POP3.start('pop.gmail.com', 995, username, password) do |pop|
	if pop.mails.empty?
		puts 'No mail.'
	else
		pop.each_mail do |mail|
			p mail.header
		end
	end
end


