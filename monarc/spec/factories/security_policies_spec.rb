FactoryBot.define do
  
  factory :security_policy do
    name {"SP800-53"}
    version {Faker::Number.number(1)}
    
  end
end