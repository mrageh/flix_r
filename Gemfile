source 'https://rubygems.org'
ruby '2.1.0'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bcrypt'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password

group :production do
  gem 'pg'
end

group :development do
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'launchy'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
end
