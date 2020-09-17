class CreateSeriesSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :series_series do |t|
      t.references :series, null: false, foreign_key: true
      t.references :contained_series, null: false
      t.integer :sequence

      t.timestamps
    end
    add_foreign_key :series_series, :series, column: :contained_series_id
  end
end
