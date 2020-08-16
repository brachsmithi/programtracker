class Package < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :disc_packages
  has_many :discs, through: :disc_packages
  accepts_nested_attributes_for :disc_packages, reject_if: proc { |attributes| attributes['disc_id'].blank? }
    
end
