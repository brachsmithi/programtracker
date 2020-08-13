class Location < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :discs

    def self.all_but_default
        where.not(id: 1)
    end

    def self.default
        find(1)
    end
end
