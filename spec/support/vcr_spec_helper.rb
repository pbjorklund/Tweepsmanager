VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
  c.filter_sensitive_data('<TOKEN>') { APP_CONFIG['app_token'] }
  c.filter_sensitive_data('<SECRET>') { APP_CONFIG['app_secret'] }
  c.filter_sensitive_data('<CONSUMER_KEY>') { APP_CONFIG['consumer_key'] }
  c.filter_sensitive_data('<CONSUMER_SECRET>') { APP_CONFIG['consumer_secret'] }
  c.filter_sensitive_data('<USER_TOKEN>') { APP_CONFIG['user_token'] }
  c.filter_sensitive_data('<USER_SECRET>') { APP_CONFIG['user_secret'] }
end
