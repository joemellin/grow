class TwilioController < ApplicationController
	 
	# Get your Account Sid and Auth Token from twilio.com/user/account

	 
	def call
		account_sid = 'AC8cc36fc273d176324fd6e2526c24b104'
		auth_token = '75a8952da02e44984f2f340f21c29cb8'
		client = Twilio::REST::Client.new account_sid, auth_token
		call_to = client.account.calls.create(
		:to => '+14152598215',
		:from => '+13106969558',
		:url => 'http://growapp.herokuapp.com/conference'
		)
		call_from = client.account.calls.create(
		:to => '+13106969558',
		:from => '+14152598215',
		:url => 'http://growapp.herokuapp.com/conference'
		)
		redirect_to root_path
	end

	def conference
		 response = Twilio::TwiML::Response.new do |r|
      r.Dial 
        r.Conference 'EBT Community Connection'
    end
 
    render_twiml response
	end

end