class CreateSeriesDiscs < ActiveRecord::Migration[6.0]
  def change
    create_table :series_discs do |t|
      t.references :series, null: false, foreign_key: true
      t.references :disc, null: false, foreign_key: true
      t.integer :sequence

      t.timestamps
    end
  end
end
