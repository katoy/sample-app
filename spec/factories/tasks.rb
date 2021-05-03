# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task_#{n}" }
    status { false }
  end

  trait :as_down do
    status { true }
  end

  trait :with_one_user do
    users { buid_list(:user, 1) }
  end

  trait :with_two_user do
    users { buid_list(:user, 2) }
  end
end
