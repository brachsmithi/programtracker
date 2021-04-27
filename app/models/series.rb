class Series < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :series_programs, dependent: :delete_all
  has_many :programs, through: :series_programs
  has_many :series_packages, dependent: :delete_all
  has_many :packages, through: :series_packages

  has_many :series_discs, dependent: :delete_all

  has_many :wrapper_series_series, class_name: 'SeriesSeries', foreign_key: 'contained_series_id', dependent: :delete_all
  has_many :contained_series_series, class_name: 'SeriesSeries', foreign_key: 'wrapper_series_id', dependent: :delete_all

  accepts_nested_attributes_for :wrapper_series_series
  accepts_nested_attributes_for :contained_series_series, allow_destroy: true
  accepts_nested_attributes_for :series_programs, allow_destroy: true
  accepts_nested_attributes_for :series_discs, allow_destroy: true
  accepts_nested_attributes_for :series_packages, allow_destroy: true
    
  def self.search_name(q)
    where('name like :q', q: "%#{q}%")
  end

  def self.all_sort_by_name
    Series.all.sort_by { |s| s.sort_value }
  end

  def sort_value
    trim_article(self.name).downcase
  end

  private

  def trim_article(value)
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
