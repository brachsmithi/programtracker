class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :programs_directors, dependent: :delete_all
    has_many :programs, through: :programs_directors
    has_many :director_aliases, :class_name => 'DirectorAlias', dependent: :delete_all
    accepts_nested_attributes_for :director_aliases, reject_if: proc { |attributes| attributes['name'].blank? }

    def self.all_by_first_name
      Director.all.sort_by { |p| p.first_name_sort_value }
    end

    def self.all_by_last_name
      Director.all.sort_by { |p| p.last_name_sort_value }
    end

    def first_name_sort_value
      self.name.split(' ').first.downcase
    end

    def last_name_sort_value
      self.name.split(' ').last.downcase
    end

end
