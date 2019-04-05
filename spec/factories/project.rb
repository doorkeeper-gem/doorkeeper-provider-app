# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    sequence(:url)  { |n| "https://example#{n}.com" }
    user
  end
end
