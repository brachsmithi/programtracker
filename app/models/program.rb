class Program < ApplicationRecord
    validates :name, presence: true

    has_many :programs_directors
    has_many :directors, through: :programs_directors
    has_many :disc_programs
    has_many :discs, through: :disc_programs
    has_many :series_programs
    has_many :series, through: :series_programs
    has_many :alternate_titles
    
    before_save :set_default_director

    def set_default_director
        directors << Director.default if directors.empty?
    end
end
