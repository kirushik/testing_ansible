require 'spec_helper.rb'

describe "ruby 2.2" do
  it "should be installed from PPA" do
    expect(ppa('ppa:brightbox/ruby-ng')).to be_enabled
    expect(package('ruby2.2')).to be_installed
    expect(command('ruby --version').stdout).to contain 'ruby 2.2'
  end
end