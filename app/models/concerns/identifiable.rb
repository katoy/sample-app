# frozen_string_literal: true

module Identifiable
  extend ActiveSupport::Concern

  included do
    before_create :set_id
  end

  def set_id
    self.id = ULID.generate
  end
end
