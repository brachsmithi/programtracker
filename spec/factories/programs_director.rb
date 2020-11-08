FactoryBot.define do
  factory :programs_director, class: ProgramsDirector do
    program_id { create(:program, name: 'Alien').id }
    director_id { create(:person, name: 'Ridley Scott').id }
  end
end