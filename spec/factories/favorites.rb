FactoryBot.define do
  factory :favorite do
    association :user
    association :list
  end
end
