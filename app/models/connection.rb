# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
