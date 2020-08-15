class DirectorAlias < ApplicationRecord
  belongs_to :director
  
  validates :name, presence: true, uniqueness: true
end
