# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "guest#{n}@example.com" }
    password { 'guest1234' }
    password_confirmation { 'guest1234' }
  end
end
