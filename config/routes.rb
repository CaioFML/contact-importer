require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users

  mount Sidekiq::Web, at: "/sidekiq"

  resources :contacts, only: :index
  resources :contact_files, only: %i[index new create]

  root to: "contacts#index"
end
