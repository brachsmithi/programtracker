class CreateAlternateTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :alternate_titles do |t|
      t.string :name
      t.belongs_to :program, null: false, foreign_key: true

      t.timestamps
    end
  end
end
