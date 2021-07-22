# frozen_string_literal: true

# See https://qiita.com/k-yamada-github/items/e8dbd6f53c638a930588

namespace :db do
  desc 'Dump the database to tmp/dbname.dump'
  task dump: %i[environment load_config] do
    config = ActiveRecord::Base.configurations[Rails.env]
    database = "#{config['database']}"
    ignore_table_option = %w[ar_internal_metadata schema_migrations].map { |table| "--ignore-table=#{config['database']}.#{table}" }.join(' ')
    file = "tmp/#{database}-#{Time.now.strftime('%Y%m%d%H%M%S')}.dump"
    sh "mysqldump -u #{config['username']} -p#{config['password']} #{config['database']} --no-create-info #{ignore_table_option} --host=#{config['host']} > #{file}"
    sh "gzip #{file}"
    sh "cp #{file}.gz tmp/#{database}.dump.gz"
  end

  desc 'Restore the database from tmp/#{config["database"]}.dump.gz'
  task restore: %i[environment load_config] do
    config = ActiveRecord::Base.configurations[Rails.env]
    database = "#{config['database']}"
    file = "tmp/#{database}.dump"
    sh "zcat #{file}.gz | mysql -u #{config['username']} -p#{config['password']} #{config['database']} --host=#{config['host']}"
  end

  desc 'Dump and reset and restore'
  task dump_reset_restore: %i[environment load_config] do
    Rake::Task['db:dump'].invoke
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['db:restore'].invoke
  end
end


