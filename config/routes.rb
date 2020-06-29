Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :chats, only: [:index, :show, :create] do
    resources :messages, only: [:index, :create]
 end
end
