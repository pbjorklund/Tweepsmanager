OmniAuth.config.test_mode = true
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '123545',
  :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
  :credentials => { token: 'blank', secret: 'blank' }
}

Before('@logged_in') do
  visit "/auth/twitter"
end
