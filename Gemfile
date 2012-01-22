source 'https://rubygems.org'

gem 'rails', '3.2.0.rc1'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'json_pure'
gem 'twitter'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

group :development, :test do
  gem 'vcr'
  gem 'fakeweb'
  gem 'database_cleaner'
  gem "launchy"
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem "factory_girl_rails", "~> 1.2"
  gem "capybara"
  gem "guard"
  gem "guard-rspec"
  gem "guard-cucumber"
  gem "guard-bundler"
  gem "guard-spork"
  gem 'spork', '~> 0.9.0.rc'
  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent'
    gem 'growl' # also install growlnotify from the Extras/growlnotify/growlnotify.pkg in Growl disk image
    gem 'pry'
    gem 'pry-rails'
  end
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.0'
  gem 'coffee-rails', '~> 3.2.0'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
