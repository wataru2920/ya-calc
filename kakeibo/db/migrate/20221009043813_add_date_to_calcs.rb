class AddDateToCalcs < ActiveRecord::Migration[5.2]
  def change
    add_column :calcs, :date, :date
    add_column :calcs, :total, :integer
  end
end
