# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#Validations' do
    let (:account) { build(:account) }

    it 'account cannot be saved with the same name' do
      account.save
      account2 = build(:account, name: 'mfcrespo')
      expect(account2).not_to be_valid
    end
  end
end
