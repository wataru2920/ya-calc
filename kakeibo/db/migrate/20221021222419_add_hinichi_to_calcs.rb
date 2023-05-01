class AddHinichiToCalcs < ActiveRecord::Migration[5.2]
  def change
    add_column :calcs, :Hinichi, :date
  end
end
