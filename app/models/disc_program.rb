class DiscProgram < ApplicationRecord
  belongs_to :disc
  belongs_to :program

  PROGRAM_TYPES = %w( FEATURE SHORT BONUS EPISODE CHAPTER ).freeze
  validates :program_type, presence: true, inclusion: { in: PROGRAM_TYPES }

end
