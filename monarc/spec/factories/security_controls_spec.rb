FactoryBot.define do
  factory :security_control do
    name {Faker::Lorem.word}
    control_id {Faker::Number.number(10)}
    status {Faker::Lorem.word}
    title {Faker::Lorem.word}
    security_policy_id {1}
    security_control_family_id {1}

  end
  
end