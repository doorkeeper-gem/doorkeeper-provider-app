# frozen_string_literal: true

FactoryBot.define do
  factory :application, class: "Doorkeeper::Application" do
    sequence(:name) { |n| "Project #{n}" }
    sequence(:redirect_uri)  { |n| "https://example#{n}.com" }
    association :owner, factory: :user
  end
end
