class DirectorAlias < ApplicationRecord
  belongs_to :director, :class_name => 'Director'
  
  validates :name, presence: true, uniqueness: true
end
