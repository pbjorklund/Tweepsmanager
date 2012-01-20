VCR.configure do |c|
  c.casette_library_dir = Rails.root.join("features", "vcr")
  c.stub_with :fakeweb
end
