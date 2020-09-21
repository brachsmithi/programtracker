class ProgramsSearch < ApplicationRecord

  self.primary_key = 'id'

  def self.all_by_name
    self.all
  end

  def self.search_by_name q
    self.all_by_name.select { |p| p.search_name.include? q }
  end

  def readonly?
    true
  end

  def program
    Program.find self.id
  end

end
