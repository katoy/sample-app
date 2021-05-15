# frozen_string_literal: true

require 'factory_bot'
include FactoryBot::Syntax::Methods
FactoryBot.definition_file_paths = [ Rails.root.join('spec', 'factories') ]
FactoryBot.reload

(1..10).each do |_x|
  create :user
  create :user, :with_one_task
  create :user, :with_two_tasks
  create :task, :with_one_user
  create :task, :with_two_users
end
