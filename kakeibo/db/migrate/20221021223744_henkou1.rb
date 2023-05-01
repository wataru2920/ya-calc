class Henkou1 < ActiveRecord::Migration[5.2]
  def change
    rename_column :calcs, :Hinichi, :hizuke
  end
end
