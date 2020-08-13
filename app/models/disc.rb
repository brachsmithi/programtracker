class Disc < ApplicationRecord
  belongs_to :location
  has_many :disc_programs
  has_many :programs, through: :disc_programs

  before_save :set_default_location

  FORMATS = %w( DVD Blu-ray DVD-R ).freeze 
  validates :format, presence: true, inclusion: { in: FORMATS }

  STATES = %w( UNWATCHED FILED VIEWING LENT ).freeze
  validates :state, presence: true, inclusion: { in: STATES }

  def set_default_location
      location = Location.default if location.nil?
  end
end
