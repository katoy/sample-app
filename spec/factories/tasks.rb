# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  status     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tasks_on_name    (name) UNIQUE
#  index_tasks_on_status  (status)
#
FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task_#{format('%04d', n)}" }
    status { false }
  end

  trait :as_down do
    status { true }
  end

  trait :with_one_user do
    users { create_list(:user, 1) }
  end

  trait :with_two_users do
    users { create_list(:user, 2) }
  end
end
