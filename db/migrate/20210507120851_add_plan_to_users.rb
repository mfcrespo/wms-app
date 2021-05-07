class AddPlanToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :plan, :string
  end
end
