require "spec_helper"

describe 'critical_chain app folder' do
  let(:deploy_path) { '/var/www/critical_chain' }
  let(:github_repo_path) { 'https://github.com/kirushik/critical_chain.git' }
  let(:app_user) { 'critical_chain' }

  it "should checkout a github repo" do
    expect(file(deploy_path)).to be_directory
    expect(file(deploy_path)).to be_owned_by app_user

    expect(file("#{deploy_path}/.git")).to be_directory
    expect(file("#{deploy_path}/.git/config")).to contain "url = #{github_repo_path}"
  end
end