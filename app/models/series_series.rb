class SeriesSeries < ApplicationRecord
  belongs_to :series
  belongs_to :contained_series, class_name: 'Series'

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end

end
