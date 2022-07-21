# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require File.expand_path('../config/environment.rb', __dir__)
require 'database_cleaner'
require 'sinatra'
require 'rack'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    Rake.load_rakefile 'Rakefile'
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:all) do
    Rake::Task['db:test:prepare'].execute
    DatabaseCleaner.clean
  end

  config.around(:each) do |clean|
    DatabaseCleaner.cleaning do
      clean.run
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
