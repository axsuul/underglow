require 'rubygems'
require 'bundler/setup'

require 'underglow' # and any other gems you need
require 'pry'

RSpec.configure do |config|
  # some (optional) config here

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end