class TwilioController < ApplicationController
	require 'rubygems'
	require 'twilio-ruby'
	 
	# Get your Account Sid and Auth Token from twilio.com/user/account
	account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
	auth_token = '75a8952da02e44984f2f340f21c29cb8'
	@client = Twilio::REST::Client.new account_sid, auth_token
	 
	message = @client.account.messages.create(:body => "Jenny please?! I love you <3",
			:to => "+14152598215",     # Replace with your phone number
			:from => "+14155211825")   # Replace with your Twilio number
	puts message.sid

	call = client.account.calls.create(
			:to => '+14152598215',
			:from => '+1 415-521-1825',
			:url => 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.rock'
			)

	def receive_call
		# User dialing into Telegroup
		response = Twilio::TwiML::Response.new do |r|
			r.Say "Welcome to e b t", :voice => 'man'
			response_gather_pin(r)
		end
		render :xml => response.text, :status => 200
	end
end