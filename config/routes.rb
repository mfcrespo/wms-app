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

  resources :accounts, only: [:edit, :update]
  
  resources :boxes, only: [:index, :new, :create, :show] do
    resources :items, only: [:new, :create, :destroy]
  end

  scope :item do
    resources :moves, only: [:edit, :update]
    resources :uses, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
