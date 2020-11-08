class ProgramPerson < ApplicationRecord
  self.table_name = 'program_persons'
  
  belongs_to :program
  belongs_to :person
  
end
