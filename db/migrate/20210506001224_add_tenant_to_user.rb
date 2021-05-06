class AddTenantToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tenant, :string
  end
end
