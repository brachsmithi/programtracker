class Package < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :disc_packages, dependent: :delete_all
  has_many :discs, through: :disc_packages
  accepts_nested_attributes_for :disc_packages, reject_if: proc { |attributes| attributes['disc_id'].blank? }

  def self.search_name q
    where('name like :q', q: "%#{q}%")
  end

  def self.all_by_name
    Package.all.sort_by { |p| p.title_sort_value }
  end

  def title_sort_value
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
