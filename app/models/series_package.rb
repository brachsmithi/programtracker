class SeriesPackage < ApplicationRecord
  belongs_to :series
  belongs_to :package

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end

end
