source 'https://gems.ruby-china.com'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

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
gem 'rack-cors'
gem 'mini_racer'

gem 'enumerize'
gem 'jsonpath'
gem 'api_tools'

gem 'pundit'
gem 'ransack'
gem 'simple_form'
gem "slim-rails"
gem 'paranoia'
gem 'acts_as_list'
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
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'ffaker'
  gem 'pry'
  gem 'pry-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'  
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'

  gem 'rspec-rails'
  gem 'webmock'  
  # gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
