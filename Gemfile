# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'pg'
gem 'puma'
gem 'rack'
gem 'rake'
gem 'redis'
gem 'sidekiq'
gem 'sinatra'
gem 'sinatra-activerecord'

group :development, :test do
  gem 'database_cleaner'
  gem 'pry-byebug'
  gem 'rack-test'
  gem 'rspec'
end
