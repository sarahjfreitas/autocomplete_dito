Rails.application.routes.draw do
  root to: 'pages#teste'
  get 'pages/teste'
  resources :events, only: [:index,:create]
end
