Capistrano::Configuration.instance.load do
  namespace :db do
    desc "Seed database"
    task :seed do
      run "#{rake_command} db:seed"
    end
  end
end