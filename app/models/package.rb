class Package < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :disc_packages
  has_many :discs, through: :disc_packages
end
