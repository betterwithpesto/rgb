Rgb7::Application.routes.draw do
	constraints(:subdomain => /^(|www)$/i) do
		match '/signout' => 'sessions#destroy', :as => :signout
		match '/auth/:provider/callback' => 'sessions#create'
   		match '/auth/flickr' => 'sessions#new', :as => :signin
		root :to => "sessions#new"
	end

	constraints(:subdomain => /^(?!www$)(.+)$/i) do
   		resources :users
   		
   		match '/:set_id', to: 'users#show', as: :set
   		match '', to: 'users#show', as: :default
   		
   		match '/auth/failure' => 'sessions#failure'
   	end
end
