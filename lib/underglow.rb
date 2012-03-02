require "underglow/version"
require 'underglow/core_extensions'

module Underglow
  # Make gem's rake tasks available to Rails app
  if defined? Rails
    module Rails
      class Railtie < ::Rails::Railtie
        rake_tasks do
          load 'tasks/system.rake'
          load 'tasks/thin.rake'
          load 'tasks/db.rake'
        end
      end
    end
  end
end