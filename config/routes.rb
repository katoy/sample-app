# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :tasks
  resources :charges

  namespace 'api' do
    namespace 'v1' do
      resources :tasks, only: %i[index create update destroy show]
      resources :users, only: %i[index create update destroy show]
    end
  end
end
