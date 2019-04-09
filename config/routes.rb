Rails.application.routes.draw do
  root to: 'pages#teste'
  get 'pages/teste'
  get 'events/list'
  resources :events, only: [:index,:create]
end
