# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    transient do
      pw { 'guest1234' }
    end

    sequence(:email) { |n| "guest#{n}@example.com" }
    password { pw }
    password_confirmation { pw }
  end

  trait :with_one_task do
    tasks { build_list(:task, 1) }
  end

  trait :with_two_tasks do
    tasks { build_list(:task, 2) }
  end
end
