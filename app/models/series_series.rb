class SeriesSeries < ApplicationRecord
  belongs_to :wrapper_series, class_name: 'Series'
  belongs_to :contained_series, class_name: 'Series'

  validate :series_ids_are_not_identical

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end

  private

  def series_ids_are_not_identical
    if wrapper_series && contained_series
      errors.add(:wrapper_series, "must not contain itself") unless
      wrapper_series.id != contained_series.id
    end
  end 

end
