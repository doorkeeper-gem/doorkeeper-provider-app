# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { "test123" }
    password_confirmation { "test123" }
  end
end
