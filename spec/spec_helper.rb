if ENV.fetch('CIRCLE_ARTIFACTS', false)
  require 'simplecov'
  SimpleCov.coverage_dir(File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage'))
  SimpleCov.start 'rails'
end

require 'webmock/rspec'

# http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = 'tmp/rspec_examples.txt'
  config.order = :random
end

WebMock.disable_net_connect!(allow_localhost: true)
