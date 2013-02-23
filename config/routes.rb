Rgb7::Application.routes.draw do
	match '/auth/:provider/callback' => 'sessions#create'
	match '/signin' => 'sessions#new', :as => :signin
	match '/signout' => 'sessions#destroy', :as => :signout
	match '/auth/failure' => 'sessions#failure'
	

	constraints(:subdomain => /^(?!www$)(.+)$/i) do
   		resources :users

   		match '', to: 'users#show'
   	end

   	#root :to => "home#index"
end
