FactoryBot.define do
  factory :security_control_family do
    title {Faker::Lorem.word}
    abv {Faker::Lorem.word}
    family {Faker::Lorem.word}
    title {Faker::Lorem.word}
    security_policy_id {1}
    
  end
end