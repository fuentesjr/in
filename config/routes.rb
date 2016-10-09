Rails.application.routes.draw do
  root 'profiles#index'
  resources :profiles, only: [:index, :create] do
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
