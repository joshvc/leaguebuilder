Rails.application.routes.draw do

  root to: 'leagues#index'
  resources :leagues
end
