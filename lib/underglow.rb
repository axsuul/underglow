require "underglow/version"
require 'underglow/core_extensions'

module Underglow
  # Make gem's rake tasks available to Rails app
  if defined? Rails
    module Rails
      class Railtie < ::Rails::Railtie
        rake_tasks do
          # load all rake tasks, need to load them by full path so they don't get confused with any tasks of the same name in Rails app
          Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
        end
      end
    end
  end
end