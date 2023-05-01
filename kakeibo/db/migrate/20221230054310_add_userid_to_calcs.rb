class AddUseridToCalcs < ActiveRecord::Migration[5.2]
  def change
    add_column :calcs, :user_id, :integer
  end
end
