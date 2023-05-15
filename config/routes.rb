Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :bids, only:[:index]
  resources :lots, only:[:show,:new,:create] do
    resources :bids, only:[:create,:new]
    get 'pending', on: :collection
    post 'approved', on: :member
  end
  resources :item_models, only:[:show,:new,:create]
end
