require 'twilio-ruby'

class TwilioController < ApplicationController
	include Webhookable 

	after_filter :set_header

	skip_before_action :verify_authenticity_token

	def send_tutor_request
		account_sid = 
		auth_token = 
		@client = Twilio::REST::Client.new account_sid, auth_token

		@client.account.messages.create({
			:from => '+16173408968'
			})
	end

end