# frozen_string_literal: true
FactoryBot.define do
  factory :user do |f|
    f.email 'aaa@outlook.com'
    f.password 'password'
    f.password_confirmation 'password'
  end
end