class CreateDiscPackages < ActiveRecord::Migration[6.0]
  def change
    create_table :disc_packages do |t|
      t.belongs_to :disc, null: false, foreign_key: true
      t.belongs_to :package, null: false, foreign_key: true
      t.integer :sequence

      t.timestamps
    end
    add_index :disc_packages, [:disc, :package], :unique => true
  end
end
