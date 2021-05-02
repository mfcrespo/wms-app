# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has factory' do
    expect(create(:user)).to be_persisted
  end
end
