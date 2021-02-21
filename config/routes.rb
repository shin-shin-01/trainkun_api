Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', action: :hello, controller: 'application'

  namespace :api do
    namespace :v1 do
      # User
      resources :users, param: :uid, only: [:create], controller: 'users'
      # Category
      resources :categories, only: [:index, :create], controller: 'categories'
    end
  end
end
