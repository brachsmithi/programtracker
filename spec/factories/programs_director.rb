FactoryBot.define do
  factory :programs_director, class: ProgramsDirector do
    program_id { create(:program, name: 'Alien').id }
    director_id { create(:default_director, name: 'Ridley Scott').id }
  end
end