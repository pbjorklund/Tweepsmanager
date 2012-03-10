OmniAuth.config.test_mode = true
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '19505451',
  :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
  :credentials => { token: APP_CONFIG['user_token'], secret: APP_CONFIG['user_secret'] }
}
