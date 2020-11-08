class PersonAlias < ApplicationRecord
  belongs_to :person, class_name: 'Person'
  
  validates :name, presence: true
end
