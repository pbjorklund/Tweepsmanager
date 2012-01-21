# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
  #TODO
  #c.filter_sensitive_data('<secret>') { 'key' }
end

OmniAuth.config.test_mode = true
#Should I perhaps set up a test twitter account?
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '19505451',
  :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
  :credentials => { token: '19505451-wwZ9Qt28u4BGUCxadxncM0oUXL1O8bralOfyWFTYV', secret: 'PaFSjUhN6meYmyiDlKJmuXjMEHWng8UO6SYaZO52Y' }
}

