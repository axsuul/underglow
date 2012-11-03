namespace :system do
  desc "Kill process with pid in *.pid file"
  task :kill_pid_from_file, :path do |t, args|
    pid_path = args[:path]

    if File.exists?(pid_path) # if the process is running at all
      pid = File.read(pid_path).to_i  # Get pid from file

      begin
        Process.kill("TERM", pid) # then kill it
      rescue 
        # If process not found, do nothing
      end

      # remove the pid file
      File.delete(pid_path)
    end
  end
end