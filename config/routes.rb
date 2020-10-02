Rails.application.routes.draw do
  devise_for :users
  root 'main#index'
  post 'create', to: 'main#create_tweet', as: 'create_tweet'
  post 'like/:tweet', to: 'main#like_tweet', as: 'like_tweet'
  post 'unlike/:tweet', to: 'main#unlike_tweet', as: 'unlike_tweet'
  post 'retweet/:tweet', to: 'main#retweet', as: 'retweet'
  get 'show/:tweet', to: 'main#show', as: 'show'
end
