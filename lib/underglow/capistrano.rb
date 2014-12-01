# First require capistrano helpers
require 'underglow/capistrano/helpers'

# Load all capistrano tasks
Dir.glob(File.expand_path("../capistrano/tasks/*.rake", __FILE__)).each do |task|
  load task
end