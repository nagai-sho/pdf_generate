Rails.application.routes.draw do
  root to: 'sheets#index'
  resources :sheets, only: [:index, :new, :create] do
    collection do
      get :new_pdf
    end
  end
end
