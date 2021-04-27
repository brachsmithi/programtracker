FactoryBot.define do
  factory :disc, class: Disc do
    #noinspection RubyArgCount
    format { 'DVD' }
    state { 'FILED' }
    location { create(:location) }
  end
end