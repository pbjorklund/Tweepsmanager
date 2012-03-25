source 'https://rubygems.org'

gem 'rails', '~> 3.2.2'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'json_pure'
gem 'twitter'
gem 'less-rails-bootstrap'
gem 'thin'
gem 'activeadmin'
gem "pg"
  gem 'sass-rails',   '~> 3.2.0'

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false
  gem "factory_girl_rails"
  gem "capybara"
  gem "capybara-webkit"
  gem 'vcr'
  gem 'fakeweb'
  gem "launchy"

  if RUBY_PLATFORM.downcase.include?("darwin")
    gem "guard"
    gem "guard-rspec"
    gem "guard-cucumber"
    gem "guard-bundler"
    gem "guard-spork"
    gem 'spork'
    gem 'rb-fsevent'
    gem 'growl' # also install growlnotify from the Extras/growlnotify/growlnotify.pkg in Growl disk image
  end

end

group :development, :test do
  gem 'heroku', '~> 2.22.0'
  gem 'taps', '0.3.23'
  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'pry'
    gem 'pry-nav'
    gem 'pry-rails'
  end
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
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
