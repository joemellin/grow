class TwilioController < ApplicationController
	 
	# Get your Account Sid and Auth Token from twilio.com/user/account

	 
	def call
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		call = client.account.calls.create(
		:to => '+1 415-521-1825',
		:from => '+1 415-521-1825',
		:url => 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.rock'
		)
		redirect_to root_path
	end

end