class AddNameColumnToDiscs < ActiveRecord::Migration[6.0]
  def change
    add_column :discs, :name, :string
  end
end
