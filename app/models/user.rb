# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  has_one :account, dependent: :destroy

  has_many :guests, dependent: :destroy
  has_many :accounts, through: :guests
  has_many :boxes

  has_many :items, dependent: :nullify

  before_save :sanitize_text
  
  attr_accessor :invitation_instructions
  
  before_validation :set_account
  

  USERNAME_REGEX_VALID = /\A[a-zA-Z\d\s-]+\z/

  validates_presence_of :username,:email, message: "Can't be blank"
  validates :username, uniqueness: { message: "has already been taken" }, format: { with: USERNAME_REGEX_VALID, message: 'Username with special character arent allowed, only "-" is allowed' }                     
  validates :email, email: true, uniqueness: true, length: {maximum:100}

  def sanitize_text
    self.email = email.downcase
  end

  def is_admin?
    ActsAsTenant.current_tenant.id == account.id unless account.nil? || ActsAsTenant.current_tenant.nil?
  end

  def guest_list
    account_list = []
    account_list.append(self.account.name) unless self.account.nil?
    account_list.append(self.guests.uniq.pluck(:account_id).map {|x| Account.find(x).name}) unless self.guests.empty?
    account_list.flatten!
    account_list
  end

  def block_from_invitation?
    # If the user has not been confirmed yet, we let the usual controls work
    if invitation_accepted_at.blank?
      return invited_to_sign_up?
    else # if the user was confirmed
      return false
    end
  end

    def add_guest!(account_id)
    guests.create!(account_id: account_id)
  end

  def delete_guest(account_id)
    guests.find_by(account_id: account_id).destroy
  end

  def is_a_guest?(account_id)
    guests.exists?(account_id: account_id)
  end

  private

  def set_account
    self.build_account(name: username) if id.nil?
  end
end
