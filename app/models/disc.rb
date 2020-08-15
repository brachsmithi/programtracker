class Disc < ApplicationRecord
  belongs_to :location
  has_many :disc_programs
  has_many :programs, through: :disc_programs
  accepts_nested_attributes_for :disc_programs, reject_if: proc { |attributes| attributes['program_id'].blank? }

  before_validation :set_default_location

  FORMATS = %w( DVD Blu-ray DVD-R ).freeze 
  validates :format, presence: true, inclusion: { in: FORMATS }

  STATES = %w( UNWATCHED FILED VIEWING LENT ).freeze
  validates :state, presence: true, inclusion: { in: STATES }

  def set_default_location
    self.location ||= Location.default
  end
end
