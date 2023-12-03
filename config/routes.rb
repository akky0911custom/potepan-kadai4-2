Rails.application.routes.draw do
  root 'rooms#top'
  get 'rooms/search'

  resources :rooms
  get 'rooms/:id/reservation/new',to: 'reservations#new', as: 'rooms_reservation_new'
  post 'rooms/:id/reservation/create', to: 'reservations#create', as: 'rooms_reservation_create'

  resources :users
  get 'users/:id/edit-account',to: 'users#edit_account', as: 'users_edit_account'
  patch 'users/:id/edit-account',to: 'users#update_account', as: 'users_update_account'
  get 'users/:id/edit-profile',to: 'users#edit_profile', as: 'users_edit_profile'
  patch 'users/:id/edit-profile',to: 'users#update_profile', as: 'users_update_profile'

  get 'users/:id/reservations',to: 'reservations#index', as: 'users_reservations'
  get 'users/:user_id/reservations/:id', to: 'reservations#show', as: 'users_reservation_show'
  get 'users/:user_id/reservations/:id/edit', to: 'reservations#edit', as: 'users_reservation_edit'
  patch 'users/:user_id/reservations/:id/update', to: 'reservations#update', as: 'users_reservation_update'
  delete 'users/:user_id/reservations/:id', to: 'reservations#destroy', as: 'users_reservation_destroy'

  get 'signup',to: 'users#new'
  get 'login',to: 'users#login_form'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
