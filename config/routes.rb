Rails.application.routes.draw do
  resources :ratings

	resources :users
	root to: 'visitors#index'
	get '/auth/:provider/callback' => 'sessions#create'
	get '/signin' => 'sessions#new', :as => :signin
	get '/signout' => 'sessions#destroy', :as => :signout
	get '/auth/failure' => 'sessions#failure'

	get 'twilio/call' => 'twilio#call'
	post '/twilio/conference_that_calls' => 'twilio#conference_that_calls'
	post '/twilio/conference_that_doesnt_call' => 'twilio#conference_that_doesnt_call'

	get 'twilio/welcome' => 'twilio#welcome'
	post '/twilio/welcome_that_calls' => 'twilio#welcome_that_calls'
	post '/twilio/welcome_that_doesnt_call' => 'twilio#welcome_that_doesnt_call'
	
	post 'twilio/voice_community' => 'twilio#voice_community'
	post 'twilio/voice_support' => 'twilio#voice_support'

	get 'twilio/handle_gather' => 'twilio#handle_gather'

	get 'connecting' => 'calls#connecting'
	get 'first' => 'calls#first'
	get '/users/:id/admin' => 'users#admin'
	get 'howitworks' => 'calls#howitworks'
end
