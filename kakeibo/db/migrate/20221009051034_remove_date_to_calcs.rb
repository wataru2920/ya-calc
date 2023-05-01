class RemoveDateToCalcs < ActiveRecord::Migration[5.2]
  def change
    remove_column :calcs, :date
    remove_column :calcs, :total
  end
end
