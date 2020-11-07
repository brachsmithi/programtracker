class PersonAlias < ApplicationRecord
  belongs_to :director, :class_name => 'Director'
  
  validates :name, presence: true
end
