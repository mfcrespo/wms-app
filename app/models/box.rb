# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class Box < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :boxname, presence: true, uniqueness: {scope: :account, case_sensitive: false}
end
