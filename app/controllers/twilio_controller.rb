require 'twilio-ruby'

class TwilioController < ApplicationController
	include Webhookable

	after_filter :set_header

	# Get your Account Sid and Auth Token from twilio.com/user/account
	skip_before_action :verify_authenticity_token

	def welcome
		user= current_user
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token

		call= client.account.calls.create(
		:to => E164.normalize(user.phone),
		:from => '+14158013055',
		:url => 'http://www.feelbyebt.com/twilio/welcome_that_calls'
		)
		redirect_to connecting_path
	end




	def welcome_that_calls
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		call_from = client.account.calls.create(
		:to => '+14152598215',
		:from => '+14158013055',
		:url => 'http://www.feelbyebt.com/twilio/welcome_that_doesnt_call'
		)

		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Connecting you with a Welcomer'
			r.Dial do |d|
				d.Conference 'Connecting'
			end
		end
 
		render_twiml response
	end

	def welcome_that_doesnt_call
		user=current_user
		response = Twilio::TwiML::Response.new do |r|
			r.Say "Welcoming"
			r.Dial do |d|
				d.Conference 'Connecting'
			end
		end
 
		render_twiml response
	end

	 
	def call
		user= current_user
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		@caller = user
		call= client.account.calls.create(
		:to => E164.normalize(user.phone),
		:from => '+14155211825',
		:url => 'http://www.feelbyebt.com/twilio/conference_that_calls'
		)
		redirect_to connecting_path
	end


	def conference_that_calls
		users = (@caller.blank? ? User.all : User.where.not(:id => @caller.id))
		user_hash = users.where('approved' => true).order("RANDOM()").limit(1)
		user = user_hash.first
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		call_from = client.account.calls.create(
		:to => E164.normalize(user.phone),
		:from => '+14155211825',
		:url => 'http://www.feelbyebt.com/twilio/conference_that_doesnt_call'
		)

		response = Twilio::TwiML::Response.new do |r|
			r.Say "Connecting you with #{user.nick}. If they do not pick up in 30 seconds please hang up and try again"
			r.Dial do |d|
				d.Conference 'Double BOOM'
			end
		end
 
		render_twiml response
	end

	def conference_that_doesnt_call
		response = Twilio::TwiML::Response.new do |r|
			r.Say "Connecting you with a Feel community call. If you would like to answer it please stay on the line"
			r.Pause :lenght => 5
			r.Dial do |d|
				d.Conference 'Double BOOM'
			end
		end
 
		render_twiml response
	end

	def voice_community
		response = Twilio::TwiML::Response.new do |r|
			if User.where(:phone => params['From']).present? 
				user = User.where(:phone => params['From'])
				phone = user.first.nick
				r.Say "Hi, #{phone} this is the feel community line. Open the", :voice => 'alice'
				r.Dial :timeout => 30  do |d|
					d.Number '+14152598215'
				end 
			else
				r.Say "Hi you have received a call from the Feel community line.  To make a call visit feel by ebt dot com"
			end
		end
 
		render_twiml response
	end

	def voice_support
		response = Twilio::TwiML::Response.new do |r|
			r.Dial :timeout => 30  do |d|
				d.Number '+14152598215'
			end 
		end
 
		render_twiml response
	end
end