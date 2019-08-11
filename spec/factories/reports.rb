FactoryBot.define do
  factory :report do
    user
    project 
    hours { Faker::Number.between(from: 1, to: 40) }
  end
end