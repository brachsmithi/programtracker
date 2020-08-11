class CreateSeriesPrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :series_programs do |t|
      t.belongs_to :series, null: false, foreign_key: true
      t.belongs_to :program, null: false, foreign_key: true
      t.integer :sequence

      t.timestamps
    end
    add_index :series_programs, [:series, :program], :unique => true
  end
end
