class PackagesSearch < ApplicationRecord

  self.primary_key = 'id'

  def self.all_by_name
    self.all
  end

  def self.search_by_name(q)
    self.all_by_name.to_a.select { |pkg| pkg.sort_title.include?(q.downcase) || pkg.search_name.try(:include?, q.downcase) }
  end

  def self.with_no_discs
    where('NOT EXISTS (SELECT 1 FROM disc_packages WHERE disc_packages.package_id = packages_searches.id)')
  end

  def package
    Package.find self.id
  end

end