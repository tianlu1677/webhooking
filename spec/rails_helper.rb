require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'webmock/rspec'
require 'sidekiq/testing'
require 'database_cleaner'
#require 'pundit/rspec'
require 'ffaker'
#require "clearance/rspec"

# Add additional requires below this line. Rails is not loaded until this point!

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!
end
