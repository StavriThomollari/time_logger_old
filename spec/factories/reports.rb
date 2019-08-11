FactoryBot.define do
  factory :report do
    user
    project 
    hours { Faker::Number.between(1,40) }
    # created_at { Time.now - Faker::Number.between(1,40) }
  end
end