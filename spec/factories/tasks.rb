# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { "MyString" }
    status { false }
  end
end
