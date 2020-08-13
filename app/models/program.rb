class Program < ApplicationRecord
    validates :name, presence: true

    has_many :programs_directors
    has_many :directors, :through => :programs_directors
    
    before_save :set_default_director

    def set_default_director
        directors << Director.default if directors.empty?
    end
end
