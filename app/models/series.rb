class Series < ApplicationRecord
    has_many :series_programs
    has_many :programs, through: :series_programs
    
end
