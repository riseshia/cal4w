source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'

gem 'sqlite3'
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'responders'

gem 'devise'
gem 'omniauth-weirdx', github: 'riseshia/omniauth-weirdx'
gem 'slack-ruby-client'

gem 'figaro'

# UI
gem 'bootstrap-sass'
gem 'momentjs-rails'
gem 'font-awesome-sass'

gem 'puma'
group :development do
  gem 'capistrano', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'database_cleaner'

  gem 'rubocop'
  gem 'rails_best_practices'
  gem 'codeclimate-test-reporter', require: nil
end
