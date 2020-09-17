class Series < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :series_programs, dependent: :delete_all
  has_many :programs, through: :series_programs

  has_many :series_series
  has_many :contained_series_series_series, class_name: 'SeriesSeries', foreign_key: 'contained_series_id'
  has_many :contained_series, through: :contained_series_series_series

  accepts_nested_attributes_for :series_series, reject_if: proc { |attributes| attributes['contained_seried_id'].blank?}
  accepts_nested_attributes_for :series_programs, reject_if: proc { |attributes| attributes['program_id'].blank? }
    
  def self.search_name q
    where('name like :q', q: "%#{q}%")
  end

  def self.all_sort_by_name
    Series.all.sort_by { |s| s.sort_value }
  end

  def sort_value
    trim_article(self.name).downcase
  end

  private

  def trim_article value
    if value.start_with? 'A '
      value.delete_prefix 'A '
    elsif value.start_with? 'An '
      value.delete_prefix 'An '
    elsif value.start_with? 'The '
      value.delete_prefix 'The '
    else
      value
    end
  end

end
