VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :once }
  c.filter_sensitive_data('<TOKEN>') { '19505451-wwZ9Qt28u4BGUCxadxncM0oUXL1O8bralOfyWFTYV' }
  c.filter_sensitive_data('<SECRET>') { 'PaFSjUhN6meYmyiDlKJmuXjMEHWng8UO6SYaZO52Y' }
  c.filter_sensitive_data('<CONSUMER_KEY>') { 'SYxcRw70lHqqHplj4DLRZA' }
  c.filter_sensitive_data('<CONSUMER_SECRET>') { 'q3ybMrQQ7fqwOUv6X9XUJxKqWvF5RoL3FElcM2XQ' }
end
