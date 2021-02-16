Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', action: :hello, controller: 'application'

  namespace :api do
    namespace :v1 do
      # Category
      resources :categories, only: [:create], controller: 'categories'
    end
  end
end
