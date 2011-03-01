require 'spec_helper'
require 'tomahto'

describe "Tomahto::VERSION" do
  it "matches x.x.x" do
    Tomahto::VERSION.should match(/(\d+.){2}\d+/)
  end
end
