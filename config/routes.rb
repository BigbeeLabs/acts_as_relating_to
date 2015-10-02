ActsAsRelatingTo::Engine.routes.draw do
	resources :relationships, except: [:index]

end
