Rails.application.routes.draw do
  get 'users/show'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }

  resources :users
  resources :tasks

  root "users#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
