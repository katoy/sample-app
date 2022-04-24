# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id(ID)       :string(26)       not null, primary key
#  name         :string(255)      not null
#  status       :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tasks_on_name    (name) UNIQUE
#  index_tasks_on_status  (status)
#
class Task < ApplicationRecord
  has_many :connections, dependent: :destroy
  has_many :users, -> { order(id: :DESC) }, through: :connections

  validates :id, uniqueness: { case_sensitive: true }
  validates :name,
            presence: true, length: { in: 1..100 },
            uniqueness: { case_sensitive: true }
end
