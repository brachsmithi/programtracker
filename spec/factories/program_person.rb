FactoryBot.define do
  factory :program_person, class: ProgramPerson do
    program_id { create(:program, name: 'Alien').id }
    person_id { create(:person, name: 'Ridley Scott').id }
  end
end