# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

Rails.application.routes.draw do
  #get 'boxes/index'
  root 'welcome#index'
  #devise_for :users
  devise_for :users, controllers: { invitations: 'users/invitations', registrations: "users/registrations" }
  
    
  scope :user do
    resource :tenants, only: [:update]
  end

  resources :account, only: [:edit, :update], controller: "accounts"
  resources :box, only: [:index, :new, :create, :show], controller: "boxes"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
