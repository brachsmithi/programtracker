class Program < ApplicationRecord
    validates :name, presence: true

    belongs_to :program_version_cluster, optional: true
    has_many :programs_directors, dependent: :delete_all
    has_many :directors, through: :programs_directors, source: :director
    has_many :disc_programs, dependent: :delete_all
    has_many :discs, through: :disc_programs
    has_many :series_programs, dependent: :delete_all
    has_many :series, through: :series_programs
    has_many :alternate_titles, dependent: :delete_all
    accepts_nested_attributes_for :series_programs, reject_if: proc { |attributes| attributes['series_id'].blank? }
    accepts_nested_attributes_for :programs_directors, reject_if: proc { |attributes| attributes['director_id'].blank? }
    accepts_nested_attributes_for :alternate_titles, reject_if: proc { |attributes| attributes['name'].blank? }

    def self.all_by_sort_title
      self.sort_records_by_title_and_year Program.all
    end
    
    def self.search_name q
      self.sort_records_by_title_and_year left_outer_joins(:alternate_titles).where('programs.name like :q or programs.sort_name like :q or alternate_titles.name like :q', q: "%#{q}%").distinct
    end

    def self.duplicates
      joins(:disc_programs).group('program_id').having('count(program_id) > 1')
    end

    def self.unused
      left_outer_joins(:disc_programs).where(disc_programs: {id: nil})
    end

    def title_sort_value
      self.sort_name.blank? ? self.name.downcase : self.sort_name.downcase
    end

    private 
    
    def self.sort_records_by_title_and_year records
      records.sort_by {|p| [p.title_sort_value, p.year]}
    end

end
