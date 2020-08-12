class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :programs_directors
    has_many :programs, :through => :programs_directors

end
