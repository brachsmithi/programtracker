class AddVersionToPrograms < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :version, :string
    add_column :programs, :minutes, :integer
  end
end
