# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    email  { 'mfcrespo77@gmail.com' }
    password  { '123456' }
    password_confirmation { '123456'}
  end
end
