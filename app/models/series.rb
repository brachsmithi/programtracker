class Series < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :series_programs
  has_many :programs, through: :series_programs
    
end
