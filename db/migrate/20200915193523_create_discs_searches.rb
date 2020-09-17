class CreateDiscsSearches < ActiveRecord::Migration[6.0]
  def change
    create_view :discs_searches
  end
end
