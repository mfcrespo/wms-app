# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

module GuestHelper

  def guest_name(account_id)
    Account.find(account_id).name
  end
  
end
