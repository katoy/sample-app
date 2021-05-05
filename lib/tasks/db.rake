# frozen_string_literal: true

host = 'db'
user = 'root'
password = 'password'
database = 'sample_app_development'

namespace :db do
  task :dump do
    file = "db/#{database}-#{Time.now.strftime('%Y%m%d%H%M%S')}.dump"
    cmd = "docker-compose run --rm db mysqldump -h #{host} -u #{user} -p#{password} #{database} > #{file}"
    puts cmd
  end

  task :restore do
    cmd = "cat dump_file | docker-compose run --rm db mysql -h #{host} -u #{user} -p#{password} #{database}"
    puts cmd
  end
end

