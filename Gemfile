source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.2'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3'
gem 'js_cookie_rails', '~> 2.1'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Mongoid
gem 'mongoid', '~> 6.2.1'
gem 'mongoid_paranoia', '~> 0.3.0'
gem 'mongoid-versioning', github: 'niksosf/mongoid-versioning'
# Simditor
gem 'simditor', '~> 2.3.6'
# Semantic UI
gem 'semantic-ui-sass', '~> 2.2.12'
# I18n
gem 'rails-i18n', '~> 5.0.0'
# Captcha
gem 'simple_captcha2', '~> 0.4.3'
# Paperclip
gem 'paperclip', '~> 5.1.0'
gem 'mongoid-paperclip', '~> 0.0.11'
# Calendar
gem "simple_calendar", "~> 2.0.6"
# Paginator
gem 'kaminari', '~> 1.0.0'
gem 'kaminari-mongoid', '~> 1.0.0'
# Authorization
gem 'cancancan', '~> 2.0.0'
# API
gem 'grape', '~> 1.0.0'
gem 'grape-entity', '~> 0.6.1'
gem 'grape-cancan', '~> 0.0.2'

gem 'doorkeeper', '~> 4.2.6'
gem "doorkeeper-mongodb", '~> 3.0.0'
gem 'doorkeeper-i18n', '~> 4.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-particles.js', '~> 2.0.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Testing Framework
  gem "rspec-rails", "~> 3.6.1"
  # Factory Gril
  gem "factory_girl_rails", "~> 4.8.0"
  # `assigns` has been extracted to a gem
  gem 'rails-controller-testing', '~> 1.0.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0'
end

group :test do
  gem 'faker', '~> 1.8.4'
  gem 'capybara', '~> 2.15.0'
  gem 'database_cleaner', '~> 1.5.1'
  gem 'mongoid-rspec', github: 'mongoid-rspec/mongoid-rspec'
end
