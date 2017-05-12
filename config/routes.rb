Rails.application.routes.draw do
  post 'callback', to: 'bot#callback'
end
