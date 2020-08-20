FactoryBot.define do
  factory :disc, class: Disc do
    format { 'DVD' }
    state { 'FILED' }
    location { create(:default_location) }
  end
end