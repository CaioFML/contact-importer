require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "api/v1/sign_in", to: "devise/sessions#create", defaults: { format: :json }
  end

  mount Sidekiq::Web, at: "/sidekiq"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :contacts, only: :index
    end
  end

  resources :contacts, only: :index
  resources :contact_files, only: %i[index new create]

  root to: "contacts#index"
end
