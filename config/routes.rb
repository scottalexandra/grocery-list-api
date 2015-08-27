Rails.application.routes.draw do
  get 'welcome/index'

  root "welcome#index"

  namespace :api do
    namespace :v1 do
      resources :lists
      resources :items
    end
  end
end
