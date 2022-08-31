FactoryBot.define do
  factory :user do
    user_name { Faker::Lorem.characters(number: 7) }
    email { Faker::Internet.free_email }
    password { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    user_text { Faker::Lorem.sentence }
  end
end
