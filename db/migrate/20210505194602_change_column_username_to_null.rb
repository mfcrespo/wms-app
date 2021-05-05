class ChangeColumnUsernameToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :username, true
  end
end
