class CreatePrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.string :sort_name
      t.string :year

      t.timestamps
    end
  end
end
