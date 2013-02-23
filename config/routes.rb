Rgb7::Application.routes.draw do
	match '/auth/:provider/callback' => 'sessions#create'
	match '/signin' => 'sessions#new', :as => :signin
	match '/signout' => 'sessions#destroy', :as => :signout
	match '/auth/failure' => 'sessions#failure'
	root :to => "home#index"
end
