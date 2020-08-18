class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :programs_directors, dependent: :delete_all
    has_many :programs, through: :programs_directors
    has_many :director_aliases

end
