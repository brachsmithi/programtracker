class AlternateTitle < ApplicationRecord
  belongs_to :program
  
  validates :name, presence: true, uniqueness: true
end
