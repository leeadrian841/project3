Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }, :controllers => {registrations: 'users/registrations'}

  resources :users, :only =>[:show]
  authenticate :user do
    
    resources :tasks do
      member do
        patch 'apply'
      end
      member do
        patch 'drop_role'
      end
    end

    patch '/tasks/:id/accept/:worker' => 'tasks#accept', as: :acceptedworker
    
    resources :search
  end

  
  root "users#home"
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
