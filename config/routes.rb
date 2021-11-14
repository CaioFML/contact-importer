# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :contacts, only: :index
  resources :contact_files, only: %i[index new create]

  root to: "contacts#index"
end
