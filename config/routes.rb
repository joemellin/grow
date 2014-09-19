Rails.application.routes.draw do
	resources :users
	root to: 'visitors#index'
	get '/auth/:provider/callback' => 'sessions#create'
	get '/signin' => 'sessions#new', :as => :signin
	get '/signout' => 'sessions#destroy', :as => :signout
	get '/auth/failure' => 'sessions#failure'
	get 'twilio/call' => 'twilio#call'
	post '/twilio/conference_that_calls' => 'twilio#conference_that_calls'
	post '/twilio/conference_that_doesnt_call' => 'twilio#conference_that_doesnt_call'
end
