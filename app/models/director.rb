class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :programs_directors, dependent: :delete_all
    has_many :programs, through: :programs_directors
    has_many :director_aliases, :class_name => 'DirectorAlias', dependent: :delete_all
    accepts_nested_attributes_for :director_aliases, reject_if: proc { |attributes| attributes['name'].blank? }

    def self.search_name q
      left_outer_joins(:director_aliases).where('directors.name like :q or director_aliases.name like :q', q: "%#{q}%").distinct.sort_by { |p| "#{p.last_name_sort_value} #{p.first_name_sort_value}" }
    end

    def self.all_by_first_name
      Director.all.sort_by { |p| p.first_name_sort_value }
    end

    def self.all_by_last_name
      Director.all.sort_by { |p| p.last_name_sort_value }
    end

    def first_name_sort_value
      self.name.downcase
    end

    def last_name_sort_value
      names = self.name.downcase.split(' ')
      if names[-3] == 'van' && names[-2] == 'den'
        "#{names[-3]} #{names[-2]} #{names.last}"
      elsif ['de', 'del', 'le', 'von'].include? names[-2]
        "#{names[-2]} #{names.last}"
      else
        names.last
      end
    end

end
