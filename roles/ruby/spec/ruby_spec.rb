require 'spec_helper.rb'

describe "latest ruby" do
  it "should be installed from PPA" do
    expect(ppa('ppa:brightbox/ruby-ng')).to be_enabled
    expect(package('ruby2.2')).to be_installed
  end
end