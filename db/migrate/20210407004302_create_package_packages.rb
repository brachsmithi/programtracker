class CreatePackagePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :package_packages do |t|
      t.references :wrapper_package, null: false
      t.references :contained_package, null: false
      t.integer :sequence

      t.timestamps
    end
    add_foreign_key :package_packages, :packages, column: :contained_package_id
    add_foreign_key :package_packages, :packages, column: :wrapper_package_id
  end
end
