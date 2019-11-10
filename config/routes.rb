Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :account do
      resources :application do
        resources :vault_value do
          member do
            get 'parent'
            get 'children'
          end
        end
      end
    end
  end
end
