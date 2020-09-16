class DiscsSearch < ApplicationRecord

  self.primary_key = 'id'

  def self.all_by_name
    self.all.sort_by
  end

  def self.search_by_name q
    self.all_by_name.select { |d| d.sort_title.include? q }
  end

  def readonly?
    true
  end

  def disc
    Disc.find self.id
  end

end
