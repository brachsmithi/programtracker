class Director < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    
end
