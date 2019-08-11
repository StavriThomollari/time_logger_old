# frozen_string_literal: true
FactoryBot.define do
  factory :project do |f|
    f.sequence (:name) { |n| "Project#{n}" }
  end
end