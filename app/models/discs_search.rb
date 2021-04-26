class DiscsSearch < ApplicationRecord

  self.primary_key = 'id'

  def self.all_by_name
    self.all
  end

  def self.search_by_name(q)
    self.all_by_name.select { |d| d.sort_title.include?(q.downcase) || d.search_name.try(:include?, q.downcase) }
  end

  def self.with_no_programs
    where('NOT EXISTS (SELECT 1 FROM disc_programs WHERE disc_programs.disc_id = discs_searches.id)')
  end

  def readonly?
    true
  end

  def location
    self.disc.location
  end

  def disc
    Disc.find self.id
  end

end
