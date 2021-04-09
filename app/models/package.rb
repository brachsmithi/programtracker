class Package < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :disc_packages, dependent: :delete_all
  has_many :discs, through: :disc_packages
  has_many :series_packages, dependent: :delete_all
  has_many :series, through: :series_packages
  has_many :wrapper_package_packages, class_name: 'PackagePackage', foreign_key: 'contained_package_id', dependent: :delete_all
  has_many :contained_package_packages, class_name: 'PackagePackage', foreign_key: 'wrapper_package_id', dependent: :delete_all
  accepts_nested_attributes_for :disc_packages, reject_if: proc { |attributes| attributes['disc_id'].blank? }
  accepts_nested_attributes_for :series_packages, reject_if: proc { |attributes| attributes['series_id'].blank? }
  accepts_nested_attributes_for :contained_package_packages, allow_destroy: true
  accepts_nested_attributes_for :wrapper_package_packages, allow_destroy: false

  def self.search_name q
    where('name like :q', q: "%#{q}%")
  end

  def self.all_by_name
    Package.all.sort_by { |p| p.title_sort_value }
  end

  def self.no_discs
    left_outer_joins(:disc_packages).where(disc_packages: {id: nil})
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
