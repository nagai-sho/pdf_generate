Rails.application.routes.draw do
  root to: 'sheets#index'
  resources :sheets, only: [:index, :new, :create]
end
