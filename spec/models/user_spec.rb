# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has factory' do
    expect(create(:user)).to be_persisted
  end

  describe '#validations' do
    let(:user) {FactoryBot.build(:user)}

    it 'user cannot be saved with all fields empty' do
      user.username = user.email = user.password = user.password_confirmation = nil
      expect(user).not_to be_valid
    end

    it 'user cannot be saved with username field empty' do
      user.username = nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:username]).to include("Can't be blank")
    end

    it 'user cannot be saved with specials characters in username' do
      user.username = 'niño'
      expect(user).not_to be_valid
      expect(user.errors.messages[:username]).to include("Username with special character arent allowed, only \"-\" is allowed")
    end

    it 'user cannot be saved when username isn´t unique' do
      new_user = create(:user, username: 'mfcrespo' )
      expect(user).not_to be_valid
      expect(user.errors.messages[:username]).to include("has already been taken")
    end

    it 'user cannot be saved with email field empty' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("Can't be blank")
    end

    it 'user cannot be saved when email isn´t unique' do
      new_user = create(:user, email: 'mfcrespo77@gmail.com' )
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("has already been taken")
    end

    it 'user cannot be saved when email hasn´t correct format' do
      user.email = 'mfcrespo@gmail'
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("is not an email")
    end

    it 'user cannot be saved with password field empty' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to include("can't be blank")
    end

  end
end

