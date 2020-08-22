class Disc < ApplicationRecord
  belongs_to :location
  has_many :disc_programs, dependent: :delete_all
  has_many :programs, through: :disc_programs
  has_one :disc_package, dependent: :delete
  has_one :package, through: :disc_package
  accepts_nested_attributes_for :disc_programs, reject_if: proc { |attributes| attributes['program_id'].blank? }
  accepts_nested_attributes_for :disc_package, reject_if: proc { |attributes| attributes['package_id'].blank? }

  before_validation :set_default_location

  FORMATS = %w( DVD Blu-ray DVD-R ).freeze 
  validates :format, presence: true, inclusion: { in: FORMATS }

  STATES = %w( UNWATCHED FILED VIEWING LENT ).freeze
  validates :state, presence: true, inclusion: { in: STATES }

  def set_default_location
    self.location ||= Location.default
  end

  def display_name
    features = self.disc_programs.select { |dp| dp.program_type == 'FEATURE' }
    if features.any?
      features.sort_by {|f| f.sequence}.first.program.name
    else
      package = self.package
      if package.nil?
        self.programs.any? ? self.programs.first.name : '--No Programs--'
      else
        package.name
      end
    end
  end

end
