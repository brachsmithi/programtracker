FactoryBot.define do
  factory :series_series, class: SeriesSeries do
    series_id { 1 }
    contained_series_id { 1 }
  end
end
