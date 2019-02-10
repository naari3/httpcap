# frozen_string_literal: true

require 'bundler/setup'
require 'httpcap'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def fixture_root_path
  File.expand_path('fixtures', __dir__)
end

def fixture_path(file)
  File.expand_path(file, fixture_root_path)
end
