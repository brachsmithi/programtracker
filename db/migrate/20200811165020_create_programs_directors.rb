class CreateProgramsDirectors < ActiveRecord::Migration[6.0]
  def change
    create_table :programs_directors, :id => false do |t|
      t.references :program, null: false, foreign_key: true
      t.references :director, null: false, foreign_key: true

      t.timestamps
    end
  end
end
