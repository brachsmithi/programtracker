class Location < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :discs

    def self.all_but_default
        where.not(name: 'NOT SET')
    end

    def self.default
        find_by_name('NOT SET')
    end
end
