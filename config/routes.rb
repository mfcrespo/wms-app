# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

Rails.application.routes.draw do
  root 'welcome#index'
  #devise_for :users
  resource :account, only: [:edit, :update]
  devise_for :users, controllers: { invitations: 'users/invitations', registrations: "users/registrations" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
