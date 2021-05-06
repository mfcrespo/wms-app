# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class Guest < ApplicationRecord
  belongs_to :account
  belongs_to :user

  validates :account, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true
end
