# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "NameAccount#{n}" }
    #user { build(:user) }
  end
end
