FactoryBot.define do
  factory :list do
    list_name { Faker::Lorem.characters(number: 7) }
    list_text { Faker::Lorem.sentence }
    privacy_id { Faker::Number.between(from: 2, to: 4) }
    association :user
  end
end
