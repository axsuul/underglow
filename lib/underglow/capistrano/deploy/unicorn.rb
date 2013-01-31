Capistrano::Configuration.instance.load do
  namespace :unicorn do
    # Sends a USR2 signal to master unicorn to spawn a new master (based on the updated codebase)
    # When new master spawns new workers, the old master process is killed
    # This allows for zero downtime
    desc "Restarts Unicorn gracefully to serve updated code"
    task :restart, roles: :web do
      kill "unicorn", "USR2"
    end

    desc "Kill Unicorn"
    task :reset, roles: :web do
      kill "unicorn", "SIGTERM"
    end
  end
end