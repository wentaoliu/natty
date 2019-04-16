source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0.beta3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0.0.beta2'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '>= 4.0.0.rc.3'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# I18n
gem 'rails-i18n', '~> 6.0.0.beta1'
# Calendar
gem 'simple_calendar', '~> 2.3.0'
# Paginator
gem 'kaminari', '~> 1.1.0'
# Authentication
gem 'devise', '~> 4.6.2'
# Authorization
gem 'cancancan', '~> 3.0.1'
# API
gem 'grape', '~> 1.2.3'
gem 'grape-entity', '~> 0.7.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.1', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Testing Framework
  gem 'rspec-rails', '~> 3.8.2'
  # Factory Gril
  gem 'factory_bot_rails', '~> 5.0.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.5'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'faker', '~> 1.8.4'
  gem 'capybara', '~> 2.15.0'
  gem 'database_cleaner', '~> 1.5.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]