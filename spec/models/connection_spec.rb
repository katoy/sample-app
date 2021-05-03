# frozen_string_literal: true

# == Schema Information
#
# Table name: connections
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_connections_on_task_id  (task_id)
#  index_connections_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Connection, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
