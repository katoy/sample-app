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
class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :status

  has_many :users
end
