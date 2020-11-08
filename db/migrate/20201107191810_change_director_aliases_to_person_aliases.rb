class ChangeDirectorAliasesToPersonAliases < ActiveRecord::Migration[6.0]
  def change
    rename_table :director_aliases, :person_aliases
  end
end
