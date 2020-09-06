require 'rails_helper'

RSpec.describe "program_version_clusters/new.html.haml", type: :view do

  before(:each) do
    assign(:program_version_cluster, ProgramVersionCluster.new)
  end

  it 'displays the cluster form' do

    render

    expect(rendered).to match /Program/
    expect(rendered).to match /Create/
    expect(rendered).to match /Cancel/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Cluster/
  end

end
