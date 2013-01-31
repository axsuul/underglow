Capistrano::Configuration.instance.load do
  namespace :db do
    desc "Seed database"
    task :seed, roles: :db do
      run "#{rake_command} db:seed"
    end
  end
end