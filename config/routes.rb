Rails.application.routes.draw do
  get 'users/index'
  root 'rooms#top'
  get 'rooms/search'

  resources :rooms

  resources :users
  get 'users/:id/edit-account',to: 'users#edit_account', as: 'users_edit_account'
  patch 'users/:id/edit-account',to: 'users#update_account', as: 'users_update_account'
  get 'users/:id/edit-profile',to: 'users#edit_profile', as: 'users_edit_profile'
  patch 'users/:id/edit-profile',to: 'users#update_profile', as: 'users_update_profile'

  get 'signup',to: 'users#new'
  get 'login',to: 'users#login_form'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
