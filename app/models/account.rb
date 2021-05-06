# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class Account < ApplicationRecord
  has_many :guests, dependent: :destroy
  has_many :users, through: :guests, dependent: :destroy
  belongs_to :user
  has_many :boxes
  

  NAME_REGEX_VALID = /\A[a-zA-Z\d\s-]+\z/
  
  validates_presence_of :name, message: "Can't be blank"
  validates :name, uniqueness: true, format: { with: NAME_REGEX_VALID, message: 'Name with special character arent allowed, only "-" is allowed. Can be alphanumerical.' }
end
