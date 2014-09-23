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
		:url => 'http://growapp.herokuapp.com/twilio/welcome_that_calls'
		)
		redirect_to connecting_path
	end




	def welcome_that_calls
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		call_from = client.account.calls.create(
		:to => '+14154469626',
		:from => '+14158013055',
		:url => 'http://growapp.herokuapp.com/twilio/welcome_that_doesnt_call'
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

		call= client.account.calls.create(
		:to => E164.normalize(user.phone),
		:from => '+14155211825',
		:url => 'http://growapp.herokuapp.com/twilio/conference_that_calls'
		)
		redirect_to connecting_path
	end




	def conference_that_calls
		users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id]))
		user_hash = users.where('approved' => true).order("RANDOM()").limit(1)
		user = user_hash.first
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

	def voice_community
		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Hi, you have dialed the Together community line.  When Together members call you, you will receive the calls from this number.  To connect with a member visit the site and click connect. ', :voice => 'alice'
				r.Play 'http://linode.rabasa.com/cantina.mp3'
		end
 
		render_twiml response
	end

	def voice_support
		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Hi, you have dialed the Together support line.  ', :voice => 'alice'
			r.Dial '+14152598215', :callerId => '+14155211825' 
			end
		end
 
		render_twiml response
	end
end