class CreateSeriesPackages < ActiveRecord::Migration[6.0]
  def change
    create_table :series_packages do |t|
      t.references :series, null: false, foreign_key: true
      t.references :package, null: false, foreign_key: true
      t.integer :sequence

      t.timestamps
    end
  end
end
