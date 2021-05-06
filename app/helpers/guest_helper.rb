# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

module GuestHelper

  def guest_name(account_id)
    account = Account.find_by(id: account_id)
    account.name unless account.nil?
  end
  
end
