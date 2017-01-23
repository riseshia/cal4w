source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "5.0.1"
gem "puma"

gem "sqlite3"
gem "mysql2"

gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.1.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "react-rails"
gem "summernote-rails"

gem "devise"
gem "omniauth-weirdx", git: "https://github.com/riseshia/omniauth-weirdx.git"
gem "omniauth-slack_signin"
gem "slack-ruby-client"

gem "figaro"

# https://github.com/riseshia/cal4w/issues/308
gem "faraday_middleware", "0.10.1"

# UI
gem "bootstrap-sass"
gem "font-awesome-sass"

group :development do
  gem "capistrano", require: false
  gem "capistrano-rbenv", require: false
  gem "capistrano-rails",   require: false
  gem "capistrano-bundler", require: false
  gem "capistrano3-puma",   require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "rails_best_practices", require: false
  gem "rubocop", require: false
end

group :test do
  gem "codeclimate-test-reporter", require: false
  gem "coveralls", require: false
  gem "database_cleaner"
  gem "factory_girl"
  gem "factory_girl_rails"
  gem "rails-controller-testing"
  gem "rspec-mocks"
  gem "rspec-rails", "~> 3.0"
  gem "shoulda-matchers"
  gem "simplecov"
end

group :development, :test do
  gem "byebug"
end
