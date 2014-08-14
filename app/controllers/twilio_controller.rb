require 'twilio-ruby'

class TwilioController < ApplicationController
	include Webhookable 

	after_filter :set_header

	skip_before_action :verify_authenticity_token

	def voice
		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Sorry, this number only makes outgoing calls.  Go to the website and contact us with any concerns.', :voice => 'alice'
		end

		render_twiml response
	end
end