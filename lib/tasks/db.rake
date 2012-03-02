namespace :db do
  # This works on sqlite, mysql and postgresql databases
  desc "Drop all database connections"
  task drop_connections: :environment do
    if ENV['RAILS_ENV'].present?
      environments = [ENV['RAILS_ENV']]
    else
      environments = ["development", "test"]
    end

    environments.each do |environment|
      config = Rails.application.config.database_configuration[environment]

      case config['adapter']
      when /mysql/
        ActiveRecord::Base.establish_connection(config)
        ActiveRecord::Base.connection.drop_database config['database']
      when /^sqlite/
        require 'pathname'
        path = Pathname.new(config['database'])
        file = path.absolute? ? path.to_s : File.join(Rails.root, path)

        FileUtils.rm(file)
      when 'postgresql'
        ActiveRecord::Base.connection.select_all("select * from pg_stat_activity order by procpid;").each do |x|
          if config['database'] == x['datname'] && x['current_query'] == '<IDLE>'
      ActiveRecord::Base.connection.execute("select pg_terminate_backend(#{x['procpid']})")
          end
        end
        ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
        ActiveRecord::Base.connection.drop_database config['database']
      end
    end
  end
end