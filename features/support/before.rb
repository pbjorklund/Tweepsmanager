VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("features", "vcr")
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :once }
  c.ignore_localhost = true

  #c.allow_http_connections_when_no_cassette = true
  #TODO
  #c.filter_sensitive_data('<secret>') { 'key' }
end

OmniAuth.config.test_mode = true
#Should I perhaps set up a test twitter account?
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '19505451',
  :info => { name: 'Patrik Bjorklund', image: 'http://a0.twimg.com/profile_images/1419130846/196443_10150169133732184_712952183_8707081_374093_n_normal.jpg', nickname: 'pbjorklund', description: "Rockin and rolling" },
  :credentials => { token: '19505451-5novK9ZlWAbTu6mNWY4fCIRgD6aq0TzXjDULWAwA', secret: 'cMiCIzSgCECbzXw39g9rGV3CzzV3ySfKqhq6Dk3ryj0' }
}

Before('@logged_in') do
  visit "/auth/twitter"
end
