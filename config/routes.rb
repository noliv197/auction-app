Rails.application.routes.draw do
  root to: 'home#index'
  resources :lots, only:[:show,:new,:create]
end
