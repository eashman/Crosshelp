# frozen_string_literal: true

source 'https://gems.ruby-china.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Elasticsearch
gem 'kaminari'
gem 'searchkick', '1.3.4'
# api框架
gem 'grape', '~> 0.18.0'
gem 'grape-entity'
gem 'grape-swagger-rails'
# api doc
gem 'grape-swagger'

# dashboard
gem 'trestle'
gem 'trestle-auth'
gem 'trestle-tinymce'
# cross-domain
gem 'rack-cors'
# Sentry support
gem 'sentry-raven'
# token
gem 'has_secure_token'
# password
gem 'bcrypt'
# RongCloud Server API
gem 'rong_cloud_server'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'enumerize'
# cache data
gem 'hiredis'
gem 'redis'
gem 'redis', require: %w[redis redis/connection/hiredis]
gem 'redis-namespace'
gem 'redis-objects'
gem 'redis-rails'
# yml params
gem 'config'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'sidekiq' # async events

gem 'action-store'

# oss
gem 'aliyun-sdk'
# jpush
gem 'jpush'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # model
  gem 'annotate'
  # Deployment system
  gem 'mina', '~> 0.3.8', require: false
  gem 'mina-multistage', require: false
  gem 'mina-puma', require: false
  gem 'mina-sidekiq', require: false
  gem 'rubocop', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
