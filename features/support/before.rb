VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("features", "vcr")
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :once }
  c.ignore_localhost = true
  c.filter_sensitive_data('<TOKEN>') { APP_CONFIG['app_token'] }
  c.filter_sensitive_data('<SECRET>') { APP_CONFIG['app_secret'] }
  c.filter_sensitive_data('<CONSUMER_KEY>') { APP_CONFIG['consumer_key'] }
  c.filter_sensitive_data('<CONSUMER_SECRET>') { APP_CONFIG['consumer_secret'] }
  c.filter_sensitive_data('<USER_TOKEN>') { APP_CONFIG['user_token'] }
  c.filter_sensitive_data('<USER_SECRET>') { APP_CONFIG['user_secret'] }

  #c.allow_http_connections_when_no_cassette = true
  #TODO - Remove all api keys from solution
  #c.filter_sensitive_data('<secret>') { 'key' }
end

OmniAuth.config.test_mode = true
#Should I perhaps set up a test twitter account?
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '19505451',
  :info => { name: 'Patrik Bjorklund', image: 'http://a0.twimg.com/profile_images/1419130846/196443_10150169133732184_712952183_8707081_374093_n_normal.jpg', nickname: 'pbjorklund', description: "Rockin and rolling" },
  :credentials => { token: APP_CONFIG['user_token'], secret: APP_CONFIG['user_secret'] }
}

Before('@logged_in') do
  visit "/auth/twitter"
end
