Capistrano::Configuration.instance.load do
  # Make sure gem 'capistrano-ext' is installed for this
  after "multistage:ensure" do
    set :rails_env, stage
  end

  # Can't use File.exists? because it'll check the local filesystem, not remote
  def remote_file_exists?(path)
    'true' == capture("if [ -e #{path} ]; then echo 'true'; fi").strip
  end

  def read_remote_file(path)
    capture("cat #{path}").strip
  end

  # Sends kill signal if process is running
  def kill(process, signal)
    pidfile_path = "#{shared_path}/pids/#{process}.pid"

    if remote_file_exists?(pidfile_path)
      pid = read_remote_file(pidfile_path).to_i
      run "kill -#{signal} #{pid} > /dev/null 2>&1" # suppress errors
    end
  end
end
