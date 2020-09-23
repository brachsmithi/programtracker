class SeriesDisc < ApplicationRecord
  belongs_to :series
  belongs_to :disc

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end

end
