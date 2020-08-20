FactoryBot.define do
  factory :disc_program, class: DiscProgram do
    program_id { 1 }
    disc_id { 1 }
    program_type { 'FEATURE' }
  end
end