class Series < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :series_programs, dependent: :delete_all
  has_many :programs, through: :series_programs

  accepts_nested_attributes_for :series_programs, reject_if: proc { |attributes| attributes['program_id'].blank? }
    
end
