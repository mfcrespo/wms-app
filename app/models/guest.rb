# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :account
end
