class SeriesSeries < ApplicationRecord
  belongs_to :series
  belongs_to :contained_series, class_name: 'Series'

  validate :series_ids_are_not_identical

  def safe_sequence
    self.sequence.nil? ?  0 : self.sequence
  end

  private

  def series_ids_are_not_identical
    if series && contained_series
      errors.add(:series, "must not contain itself") unless
          series.id != contained_series.id
    end
  end 

end
