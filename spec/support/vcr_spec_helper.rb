VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
  c.filter_sensitive_data('<CONSUMER_KEY>') { twitter_api_key }
  c.filter_sensitive_data('<CONSUMER_SECRET>') { twitter_api_secret }
  c.filter_sensitive_data('<USER_TOKEN>') { twitter_user_token }
  c.filter_sensitive_data('<USER_SECRET>') { twitter_user_secret }
end
