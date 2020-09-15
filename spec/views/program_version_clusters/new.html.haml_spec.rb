require 'rails_helper'

RSpec.describe "program_version_clusters/new.html.haml", type: :view do

  before(:each) do
    assign(:program_version_cluster, ProgramVersionCluster.new)
  end

  it 'displays the cluster form' do

    render

    expect(rendered).to have_content 'Program'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Cluster'
  end

end
