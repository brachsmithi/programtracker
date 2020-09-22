class Disc < ApplicationRecord
  belongs_to :location
  has_many :disc_programs, dependent: :delete_all
  has_many :programs, through: :disc_programs
  has_one :disc_package, dependent: :delete
  has_one :package, through: :disc_package
  accepts_nested_attributes_for :disc_programs, reject_if: proc { |attributes| attributes['program_id'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :disc_package, reject_if: proc { |attributes| attributes['package_id'].blank? }

  before_validation :set_default_location

  FORMATS = %w( DVD Blu-ray Blu-ray\ 3D DVD-R DIGITAL\ COPY CD DVD\ GAME ).freeze 
  validates :format, presence: true, inclusion: { in: FORMATS }

  STATES = %w( UNWATCHED FILED VIEWING LENT ).freeze
  validates :state, presence: true, inclusion: { in: STATES }
  
  def self.not_located
    self.where(location_id: Location.default.id)
  end

  def set_default_location
    self.location ||= Location.default
  end

end
