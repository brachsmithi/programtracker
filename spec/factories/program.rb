FactoryBot.define do
  factory :program, class: Program do
    name { 'Alien' }
    year { 1979 }
    version { 'Director Cut'}
    minutes { 117 }
  end
end