# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '7.0.8.1'

# db and server
gem 'pg', '~> 1.5.6'
gem 'pghero', '~> 3.4.1'
gem 'puma', '6.4.2'
gem 'redis', '~> 5.2'
gem 'redis-namespace'

# front tools
gem 'chartkick'
gem 'react-rails'
gem 'sassc-rails'
gem 'simple_form'
gem 'slim'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails', '~> 2.6.0'
gem 'turbo-rails', '~> 1.0.1'
gem 'vite_rails', '~> 3.0.15'

# backend jobs
gem 'acts_as_list'
gem 'api_tools'
gem 'jsonpath'
gem 'liquid'
gem 'mini_racer', '~> 0.12.0'
gem 'sidekiq', '~> 7.1'
gem 'sidekiq-cron'
gem 'sidekiq-failures', '~> 1.0.4'

# user center
gem 'devise', '~> 4.9.4'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'

# api
gem 'oj'
gem 'rack-attack', '~> 6.6.0'
gem 'rack-cors', require: 'rack/cors'

# tools
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'dotenv-rails', '~> 3.1.2'
gem 'enumerize', '~> 2.8.0'
gem 'groupdate', '~> 6.0'
gem 'image_processing', '~> 1.2'
gem 'jbuilder'
gem 'meta-tags', '~> 2.21.0'
gem 'net-http'
gem 'nokogiri', '>= 1.16.4'
gem 'pagy', '~> 8.4.0'
gem 'ransack'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# monitor
gem 'sentry-ruby'
gem 'sentry-sidekiq'

gem 'brakeman'
gem 'bundler-audit'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'ffaker', '~> 2.20'
  gem 'foreman'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.1.2'

  gem 'erb_lint', require: false
  gem 'lefthook'
  gem 'rubocop'
  gem 'rubocop-ast'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

group :development do
  gem 'web-console'
  # gem "rack-mini-profiler"
  gem 'annotate', '~> 3.2'
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'mocha'
  gem 'selenium-webdriver'
  gem 'webmock'
end
