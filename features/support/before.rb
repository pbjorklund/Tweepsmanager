OmniAuth.config.test_mode = true
#Should I perhaps set up a test twitter account?
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '123545',
  :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
  :credentials => { token: '19505451-uPUdguO89vHK5GQqu7JsVnxCGQht8ppNGLXWDEwc', secret: '91gdF5owHz0YCclQxzw4beprQjKjtGMJh1ynKVGNk' }
}

Before('@logged_in') do
  visit "/auth/twitter"
end
