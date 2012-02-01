require 'spec_helper'

describe Relationship do
  it "creates a new relationship" do
    rel = Relationship.new
    rel.should be_valid
  end
end
