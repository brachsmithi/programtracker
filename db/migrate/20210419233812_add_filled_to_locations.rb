class AddFilledToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :filled, :boolean
  end
end
