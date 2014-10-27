Capistrano::Configuration.instance.load do
  # So we can use rake within commands
  after "multistage:ensure" do
    set :rake_command, "RAILS_ENV=#{stage} #{current_path}/bin/rake -f #{current_path}/Rakefile"
  end

  before "deploy:update_code" do
    # We are about to update code, so we need to use release path because the current path will be the old code
    set :rake_command, "RAILS_ENV=#{stage} #{release_path}/bin/rake -f #{release_path}/Rakefile"
  end

  namespace :rake do
    # Note: do not name this task to "run"
    desc "Invoke a rake task, ex: cap production rake:invoke TASK=db:migrate TRACE=true ENV=FOO=BAR,BAZ=BOO"
    task :invoke do
      arguments = []

      # Extract special environment variables
      trace = ENV.delete('TRACE')
      task = ENV.delete('TASK')
      env = ENV.delete('ENV')

      # Build arguments list
      arguments << "--trace" if trace
      arguments_command = arguments.join(' ')

      # Build environment variables to pass in
      env_command = env.split(',').join(' ') if env

      run "#{env_command} #{rake_command} #{task} #{arguments_command}"
    end
  end
end