# frozen_string_literal: true

source 'https://gems.ruby-china.com'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'dotenv-rails'
gem 'hotwire-rails'
gem 'jbuilder', '~> 2.11.2'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.1.3.2'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.3.0'
# add
gem 'pg'
gem 'pghero'

gem 'hiredis'
gem 'liquid'
gem 'mini_racer'
gem 'rack-cors'
gem 'redis', require: ['redis', 'redis/connection/hiredis']
gem 'redis-objects'
gem 'redis-rails'

gem 'api_tools'
gem 'enumerize'
gem 'jsonpath'

gem 'acts_as_list'
gem 'paranoia'
gem 'pundit'
gem 'ransack'
gem 'simple_form'
gem 'slim-rails'
# sidekiq
gem 'sidekiq', '~> 5.2.2'
gem 'sidekiq-cron'
gem 'sidekiq-failures'

# file upload
gem 'clearance'
gem 'foreman'
gem 'jwt'
gem 'mini_magick'
gem 'oj'
gem 'pagy', '~> 3.10.0'
# gem "ferrum"
# tools

gem 'capybara', '>= 2.15'
gem 'selenium-webdriver'
gem 'webdrivers'

gem 'bootsnap', '>= 1.4.2', require: false

group :production do
  gem 'newrelic_rpm'
end
group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'

  gem 'rspec-rails'
  gem 'webmock'
  # gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
