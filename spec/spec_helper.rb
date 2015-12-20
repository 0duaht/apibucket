require "codeclimate-test-reporter"
require "factory_girl_rails"
require "simplecov"
SimpleCov.start
CodeClimate::TestReporter.start
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.include FactoryGirl::Syntax::Methods
  config.before(:all) do
    Rails.application.load_seed # loading seeds
  end
end
