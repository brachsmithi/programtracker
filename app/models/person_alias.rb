class PersonAlias < ApplicationRecord
  belongs_to :person, class_name: 'Person', foreign_key: 'director_id'
  
  validates :name, presence: true
end
