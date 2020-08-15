FactoryBot.define do
  factory :disc do
    format { 'DVD' }
    state { 'FILED' }
    location { create(:default_location) }
  end
end