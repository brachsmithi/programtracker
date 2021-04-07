class PackagePackage < ApplicationRecord
  belongs_to :wrapper_package, class_name: 'Package'
  belongs_to :contained_package, class_name: 'Package'

  validate :package_ids_are_not_identical

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end

  private

  def package_ids_are_not_identical
    if wrapper_package && contained_package
      errors.add(:wrapper_package, "must not contain itself") unless
      wrapper_package.id != contained_package.id
    end
  end 

end
