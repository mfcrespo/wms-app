# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class AddAccountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :account_id, :integer
    add_index :users, :account_id
  end
end
