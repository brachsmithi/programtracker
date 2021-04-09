class DiscPackage < ApplicationRecord
  belongs_to :disc
  belongs_to :package

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end
  
end
