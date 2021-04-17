class CreatePackagesSearches < ActiveRecord::Migration[6.0]
  def change
    create_view :packages_searches
  end
end
