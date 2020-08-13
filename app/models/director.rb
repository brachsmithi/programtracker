class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :programs_directors
    has_many :programs, :through => :programs_directors
    
    def self.all_but_default
        where.not(id: 1)
    end

    def self.default
        find(1)
    end

end
