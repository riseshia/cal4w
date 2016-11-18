# frozen_string_literal: true
require "coveralls"
Coveralls.wear!

if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  SimpleCov.start "rails" do
    add_filter "/vendor/"
    add_filter "/spec/"
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
