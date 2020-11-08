class RenameDirectorToPersonInPersonAlias < ActiveRecord::Migration[6.0]
  def change
    rename_column :person_aliases, :director_id, :person_id
  end
end
