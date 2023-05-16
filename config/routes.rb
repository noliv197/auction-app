Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :bids, only:[:index]
  resources :lot_items, only:[:index]
  resources :lots, only:[:show,:new,:create,:edit,:update] do
    resources :lot_items, only:[:new,:create,:destroy] 
    resources :bids, only:[:create,:new]
    get 'pending', on: :collection
    get 'to_close', on: :collection
    post 'approved', on: :member
    post 'canceled', on: :member
    post 'closed', on: :member
  end
  resources :item_models, only:[:show,:new,:create,:edit,:update]
end
