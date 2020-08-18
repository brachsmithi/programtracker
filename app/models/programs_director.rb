class ProgramsDirector < ApplicationRecord
  belongs_to :program, class_name: 'Program'
  belongs_to :director, class_name: 'Director'
  
end
