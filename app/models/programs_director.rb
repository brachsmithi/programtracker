class ProgramsDirector < ApplicationRecord
  belongs_to :program
  belongs_to :person, class_name: 'Person', foreign_key: 'director_id'
  
end
