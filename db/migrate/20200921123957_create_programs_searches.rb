class CreateProgramsSearches < ActiveRecord::Migration[6.0]
  def change
    create_view :programs_searches
  end
end
