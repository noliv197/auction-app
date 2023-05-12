Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :lots, only:[:show,:new,:create]
  resources :item_models, only:[:show,:new,:create]
end
