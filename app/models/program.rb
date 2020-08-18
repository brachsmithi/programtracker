class Program < ApplicationRecord
    validates :name, presence: true

    has_many :programs_directors, dependent: :delete_all
    has_many :directors, through: :programs_directors, source: :director
    has_many :disc_programs
    has_many :discs, through: :disc_programs
    has_many :series_programs
    has_many :series, through: :series_programs
    has_many :alternate_titles
    accepts_nested_attributes_for :series_programs, reject_if: proc { |attributes| attributes['series_id'].blank? }
    accepts_nested_attributes_for :programs_directors, reject_if: proc { |attributes| attributes['director_id'].blank? }
    
end
