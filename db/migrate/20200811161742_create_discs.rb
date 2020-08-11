class CreateDiscs < ActiveRecord::Migration[6.0]
  def change
    create_table :discs do |t|
      t.string :format
      t.belongs_to :location, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
