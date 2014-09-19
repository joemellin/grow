require 'twilio-ruby'

class TwilioController < ApplicationController
	include Webhookable

	# Get your Account Sid and Auth Token from twilio.com/user/account
	skip_before_action :verify_authenticity_token

	 
	def call
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		call_to = client.account.calls.create(
		:to => '+14152598215',
		:from => '+14152598215',
		:url => 'http://growapp.herokuapp.com/twilio/conference'
		)
		call_from = client.account.calls.create(
		:to => '+13106969558',
		:from => '+14152598215',
		:url => 'http://growapp.herokuapp.com/twilio/conference'
		)
		redirect_to root_path
	end

	def conference
		 response = Twilio::TwiML::Response.new do |r|
			r.Dial do |d|
				d.Conference 'BOOM'
		end
 
		render_twiml response
	end

end