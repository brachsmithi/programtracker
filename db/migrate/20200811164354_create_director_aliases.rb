class CreateDirectorAliases < ActiveRecord::Migration[6.0]
  def change
    create_table :director_aliases do |t|
      t.string :name
      t.belongs_to :director, null: false, foreign_key: true

      t.timestamps
    end
  end
end
