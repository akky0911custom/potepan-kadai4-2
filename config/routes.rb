Rails.application.routes.draw do
  root 'rooms#top'
  get 'rooms/search'

  resources :rooms

end
