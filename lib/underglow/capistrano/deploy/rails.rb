Capistrano::Configuration.instance.load do
  desc "Estbalish SSH session into rails directory"
  task :ssh, roles: :app do
    run_remote "cd #{current_path}"
  end

  desc "Run rails console"
  task :console, roles: :app do
    run_remote "cd #{current_path} && #{deploy_to}/environment bin/rails c"
  end

  desc "View rails log"
  task :log, roles: :app do
    run_remote "cd #{current_path} && vi log/#{stage}.log"
  end

  desc "Tail rails log"
  task :log, roles: :app do
    run_remote "cd #{current_path} && tail -f log/#{stage}.log"
  end
end