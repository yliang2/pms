source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'

#Use Puma as the app server
#gem 'puma', '~> 3.0'
# Use postgresql as the database for Active Record
#gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use ActiveModel has_secure_password
 gem 'bcrypt', '~> 3.1.7'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'




group :test, :development do
  gem "rspec-rails"
  gem "parallel_tests"
  gem "zeus-parallel_tests"
  gem 'byebug'
  gem 'rtask-db-drop-connections', '~> 1.0'
  gem 'web-console'
  gem 'sqlite3'
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "rb-fsevent"
  gem "zeus"
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end
