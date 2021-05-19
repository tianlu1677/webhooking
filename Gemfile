source 'https://gems.ruby-china.com'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.1.3.2'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.3.0'
gem 'jbuilder', '~> 2.11.2'
gem 'hotwire-rails'
gem 'dotenv-rails'
# add
gem 'pg'
gem 'pghero'

gem 'hiredis'
gem 'redis', require: ["redis", "redis/connection/hiredis"]
gem 'redis-objects'
gem 'redis-rails'
gem 'liquid' # 用于渲染response 的内容

gem 'enumerize'

gem 'pundit'
gem 'ransack'
gem 'simple_form'
gem "slim-rails"
gem 'paranoia'
# sidekiq
gem 'sidekiq', '~> 5.2.2'
gem 'sidekiq-cron'
gem 'sidekiq-failures'

# file upload
gem 'mini_magick'
gem 'jwt'
gem 'pagy', '~> 3.10.0'
gem 'oj'
gem 'foreman'
gem "clearance"
# tools

gem 'bootsnap', '>= 1.4.2', require: false

group :production do
  gem 'newrelic_rpm'
end
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'ffaker'
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'webmock'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
