Rails.application.routes.draw do
  get 'bot', to: 'bot#index'
  post 'callback', to: 'bot#callback'
end
