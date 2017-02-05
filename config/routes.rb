Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "users#new"

  resources :users, :only => [:new, :create, :update, :index]
  resource :session, :only => [:new, :create, :destroy]
  get 'login' => "sessions#new"
  delete 'logout' => "sessions#destroy"



end
