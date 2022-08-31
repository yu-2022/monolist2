FactoryBot.define do
  factory :item do
    item_name { Faker::Lorem.characters(number: 7) }
    item_text { Faker::Lorem.sentence }
    item_date { Faker::Date }
    association :user
    association :list
  end
end
