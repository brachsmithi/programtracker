class AlternateTitle < ApplicationRecord
  belongs_to :program
  
  validates :name, presence: true

  def self.all_by_name
    AlternateTitle.all.sort_by { |p| p.title_sort_value }
  end

  def title_sort_value
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
