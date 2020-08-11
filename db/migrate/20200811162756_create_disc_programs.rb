class CreateDiscPrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :disc_programs do |t|
      t.belongs_to :disc, null: false, foreign_key: true
      t.belongs_to :program, null: false, foreign_key: true
      t.integer :sequence
      t.string :program_type

      t.timestamps
    end
    add_index :disc_programs, [:disc, :program], :unique => true
  end
end
