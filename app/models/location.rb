class Location < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :discs

    def self.all_by_name
      all_but_default.sort_by { |l| l.name }
    end

    def self.all_but_default
        where.not(name: 'NOT SET')
    end

    def self.search_name q
      all_but_default.where('name like :q', q: "%#{q}%")
    end

    def self.default
        find_by_name('NOT SET')
    end
end
