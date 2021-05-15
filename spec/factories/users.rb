# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    transient do
      pw { 'guest1234' }
    end

    sequence(:email) { |n| "guest#{format('%04d', n)}@example.com" }
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
