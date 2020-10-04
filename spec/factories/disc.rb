FactoryBot.define do
  factory :disc, class: Disc do
    format { 'DVD' }
    state { 'FILED' }
    location { create(:location) }
  end
end