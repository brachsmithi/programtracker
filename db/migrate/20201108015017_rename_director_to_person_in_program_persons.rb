class RenameDirectorToPersonInProgramPersons < ActiveRecord::Migration[6.0]
  def change
    rename_column :program_persons, :director_id, :person_id
  end
end
