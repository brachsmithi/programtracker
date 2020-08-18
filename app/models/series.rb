class Series < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :series_programs, dependent: :delete_all
  has_many :programs, through: :series_programs
    
end
