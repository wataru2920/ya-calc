class CreateCalcs < ActiveRecord::Migration[5.2]
  def change
    create_table :calcs do |t|
      t.integer :food
      t.integer :daily
      t.integer :housing
      t.integer :traffic
      t.integer :recreation
      t.integer :others

      t.timestamps
    end
  end
end
