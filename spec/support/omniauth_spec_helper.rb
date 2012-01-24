OmniAuth.config.test_mode = true
auth = OmniAuth.config.mock_auth[:twitter] = {
  provider: 'twitter',
  uid: '19505451',
  :info => { name: 'Patrik Bjorklund', image_url: 'blank', nickname: 'pbjorklund' },
  :credentials => { token: '19505451-wwZ9Qt28u4BGUCxadxncM0oUXL1O8bralOfyWFTYV', secret: 'PaFSjUhN6meYmyiDlKJmuXjMEHWng8UO6SYaZO52Y' }
}
