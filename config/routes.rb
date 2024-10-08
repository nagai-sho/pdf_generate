Rails.application.routes.draw do
  root to: 'sheets#index'
  resources :sheets, only: [:index, :new, :create, :show, :destroy] 
  post 'sheets/preview_pdf', to: 'sheets#preview_pdf'
end
