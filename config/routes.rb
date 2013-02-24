Rgb7::Application.routes.draw do
	constraints(:subdomain => /^(|www)$/i) do
		match '/auth/:provider/callback' => 'sessions#create'
		#match '/signin' => 'sessions#new', :as => :signin
		match '/signout' => 'sessions#destroy', :as => :signout
		match '/auth/failure' => 'sessions#failure'
		root :to => "sessions#new"
	end

	constraints(:subdomain => /^(?!www$)(.+)$/i) do
   		resources :users
   		match '/:set_id', to: 'users#show', as: :set
   		match '', to: 'users#show', as: :default

   	end
end
