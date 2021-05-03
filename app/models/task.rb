# frozen_string_literal: true

class Task < ApplicationRecord
  has_many :connections
  has_many :users, through: :connections, dependent: :destroy

  validates :name,
    presence: true, length: { in: 1..100 }, uniqueness: true
end
