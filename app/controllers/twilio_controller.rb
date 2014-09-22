require 'twilio-ruby'

class TwilioController < ApplicationController
	include Webhookable

	# Get your Account Sid and Auth Token from twilio.com/user/account
	skip_before_action :verify_authenticity_token

	 
	def call
		user= current_user
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token

		call= client.account.calls.create(
		:to => E164.normalize(user.phone),
		:from => '+14155211825',
		:url => 'http://growapp.herokuapp.com/twilio/conference_that_calls'
		)
		redirect_to connecting_path
	end




	def conference_that_calls
		user=User.first
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		call_from = client.account.calls.create(
		:to => E164.normalize(user.phone),
		:from => '+14155211825',
		:url => 'http://growapp.herokuapp.com/twilio/conference_that_doesnt_call'
		)

		response = Twilio::TwiML::Response.new do |r|
			r.Say 'BOOM'
			r.Dial do |d|
				d.Conference 'Double BOOM'
			end
		end
 
		render_twiml response
	end

	def conference_that_doesnt_call
		response = Twilio::TwiML::Response.new do |r|
			r.Say 'BOOM'
			r.Dial do |d|
				d.Conference 'Double BOOM'
			end
		end
 
		render_twiml response
	end

end