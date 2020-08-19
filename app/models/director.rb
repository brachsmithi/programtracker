class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :programs_directors, dependent: :delete_all
    has_many :programs, through: :programs_directors
    has_many :director_aliases, :class_name => 'DirectorAlias', dependent: :delete_all
    accepts_nested_attributes_for :director_aliases, reject_if: proc { |attributes| attributes['name'].blank? }

end
