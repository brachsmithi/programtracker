class DiscsSearch < ApplicationRecord

  self.primary_key = 'id'

  def self.all_by_name
    self.all
  end

  def self.search_by_name q
    self.all_by_name.select { |d| d.sort_title.include? q }
  end

  def readonly?
    true
  end

  def display_name
    self.disc.display_name
  end

  def location
    self.disc.location
  end

  def disc
    Disc.find self.id
  end

end