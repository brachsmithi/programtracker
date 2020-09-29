class ProgramVersionCluster < ApplicationRecord

  has_many :programs, dependent: :nullify
  accepts_nested_attributes_for :programs, allow_destroy: false

end
