OmniAuth.config.test_mode = true
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '19505451',
  :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
  :credentials => { token: twitter_user_token, secret: twitter_user_secret }
}
