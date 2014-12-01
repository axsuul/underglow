namespace :unicorn do
  # Sends a USR2 signal to master unicorn to spawn a new master (based on the updated codebase)
  # When new master spawns new workers, the old master process is killed
  # This allows for zero downtime
  desc "Restarts Unicorn gracefully to serve updated code"
  task :restart do
    on roles(:web) do
      kill_process "unicorn", "USR2"
    end
  end

  desc "Kill Unicorn"
  task :reset do
    on roles(:web) do
      kill_process "unicorn", "SIGTERM"
    end
  end
end