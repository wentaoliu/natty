if ENV['USE_OFFICIAL_GEM_SOURCE']
  source 'https://rubygems.org'
else
  source 'https://ruby.taobao.org' #Mirror provided by Taobao
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.7'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.1.0'
gem 'jquery-cookie-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.3'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Mongoid
gem 'mongoid', '~> 5.1.0'
gem 'mongoid-paranoia', '~> 1.3.0'
gem 'mongoid-versioning', '~> 1.2.0'
# Simditor
gem 'simditor', '~> 2.3.6'
# Semantic UI
gem 'semantic-ui-sass', '~> 2.1.8.0'
# I18n
gem 'rails-i18n', '~> 4.0.0'
# Captcha
gem 'simple_captcha2', '~> 0.4.0'
# Paperclip
gem 'paperclip', '~> 4.3.2'
gem 'mongoid-paperclip', '~> 0.0.10', :require => "mongoid_paperclip"
# Calendar
gem "simple_calendar", "~> 2.0.3"
# Paginator
gem 'kaminari', '~> 0.16.3'
# Authorization
gem 'cancancan', '~> 1.13.1'
# API
gem 'grape', '~> 0.14.0'
gem 'grape-entity', '~> 0.5.0'
gem 'grape-cancan', '~> 0.0.2'

gem 'doorkeeper', '~> 3.1'
gem "doorkeeper-mongodb", github: "doorkeeper-gem/doorkeeper-mongodb"
gem 'doorkeeper-i18n', '~> 3.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-particles.js', '~> 2.0.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Testing Framework
  gem "rspec-rails", "~> 3.4.0"
  # Factory Gril
  gem "factory_girl_rails", "~> 4.5.0"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.6.2'
end

group :test do
  gem 'faker', '~> 1.6.1'
  gem 'capybara', '~> 2.6.0'
  gem 'database_cleaner', '~> 1.5.1'
  gem 'mongoid-rspec', '~> 3.0'
end
