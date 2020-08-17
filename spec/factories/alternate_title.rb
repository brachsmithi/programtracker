FactoryBot.define do
  factory :alternate_title, class: AlternateTitle do
    program_id { create(:program, name: 'Rat Pfink a Boo Boo').id }
    name { 'The Adventures of Rat Pfink and Boo Boo' }
  end
end