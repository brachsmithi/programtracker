class ChangeProgramsDirectorsToProgramPersons < ActiveRecord::Migration[6.0]
  def change
    rename_table :programs_directors, :program_persons
  end
end
