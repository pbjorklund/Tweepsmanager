VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("features", "vcr")
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :once }
  #TODO
  #c.filter_sensitive_data('<secret>') { 'key' }
end

OmniAuth.config.test_mode = true
#Should I perhaps set up a test twitter account?
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '123545',
  :info => { name: 'Patrik Bjorklund', image: 'http://twitter.com/bild.jpg', nickname: 'pbjorklund' },
  :credentials => { token: '19505451-wwZ9Qt28u4BGUCxadxncM0oUXL1O8bralOfyWFTYV', secret: 'PaFSjUhN6meYmyiDlKJmuXjMEHWng8UO6SYaZO52Y' }
}

Before('@logged_in') do
  visit "/auth/twitter"
end
