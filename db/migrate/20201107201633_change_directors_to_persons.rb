class ChangeDirectorsToPersons < ActiveRecord::Migration[6.0]
  def change
    rename_table :directors, :persons
  end
end
