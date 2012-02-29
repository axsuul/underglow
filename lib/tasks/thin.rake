require 'rails'

# All thin operations
namespace :thin do
  desc "Stop thin server"
  task :stop => :environment do
    puts "Stopping thin server..."
    Rake::Task['system:kill_pid_from_file'].invoke(Rails.root.join('tmp', 'pids', 'thin.pid'))
  end

  desc "Start thin server"
  task :start do
    puts "Starting thin server..."
    puts `bundle exec thin start -d --pid tmp/pids/thin.pid`  # daemonize
  end

  desc "Restart thin server"
  task :restart => ['thin:stop', 'thin:start']
end