require 'active_support'
require 'active_support/core_ext/object/blank'

require 'pry'

def remote_file_exists?(path)
  test("[ -e #{command.options[:in]}/#{path} ]")
end

def capture_remote_file(path)
  return unless remote_file_exists?(path)

  capture(:cat, path).strip
end

# SSH with pseudo-tty
def execute_with_tty(*args)
  exec "ssh #{host.user}@#{host.hostname} -t '#{command(*args).to_command}'"
end

# Sends kill signal to process is running
def kill_process(process, signal)
  within "#{shared_path}/pids" do
    pid = capture_remote_file("#{process}.pid")

    execute :kill, "-#{signal}", pid, raise_on_non_zero_exit: false unless pid.blank?
  end
end