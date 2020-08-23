class SeriesProgram < ApplicationRecord
  belongs_to :series
  belongs_to :program

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end

end
