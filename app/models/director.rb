class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :programs_directors
    has_many :programs, through: :programs_directors
    has_many :director_aliases
    
    def self.all_but_default
        where.not(name: 'NOT SET')
    end

    def self.default
        find_by_name 'NOT SET'
    end

end
