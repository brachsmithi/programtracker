class Program < ApplicationRecord
    validates :name, presence: true

    belongs_to :program_version_cluster, optional: true
    has_many :program_persons, dependent: :delete_all
    has_many :persons, through: :program_persons, source: :person
    has_many :disc_programs, dependent: :delete_all
    has_many :discs, through: :disc_programs
    has_many :series_programs, dependent: :delete_all
    has_many :series, through: :series_programs
    has_many :alternate_titles, dependent: :delete_all
    accepts_nested_attributes_for :series_programs, reject_if: proc { |attributes| attributes['series_id'].blank? }
    accepts_nested_attributes_for :program_persons, reject_if: proc { |attributes| attributes['person_id'].blank? }
    accepts_nested_attributes_for :alternate_titles, reject_if: proc { |attributes| attributes['name'].blank? }

    def self.duplicates
      joins(:disc_programs).group('program_id').having('count(program_id) > 1')
    end

    def self.unused
      left_outer_joins(:disc_programs).where(disc_programs: {id: nil})
    end

end
