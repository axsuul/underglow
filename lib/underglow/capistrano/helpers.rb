Capistrano::Configuration.instance.load do
  # Make sure gem 'capistrano-ext' is installed for this
  after "multistage:ensure" do
    set :rails_env, stage
  end

  # Run remote command via SSH
  def run_remote(command)
    exec "ssh #{stage} -t 'source ~/.profile && #{command}'"
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
    run "if [ -e #{pidfile_path} ]; then kill -#{signal} `cat #{pidfile_path}` > /dev/null 2>&1; fi"
  end
end
