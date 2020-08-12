class Program < ApplicationRecord
    validates :name, presence: true

    has_many :programs_directors
    has_many :directors, :through => :programs_directors
    
end
