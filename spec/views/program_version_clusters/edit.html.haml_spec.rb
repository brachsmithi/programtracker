require 'rails_helper'

RSpec.describe "program_version_clusters/edit.html.haml", type: :view do
    
  before(:each) do
    program = create(:program)
    pvc = create(:program_version_cluster)
    pvc.programs << program
    assign(:program_version_cluster, pvc)
  end

  it 'displays the program form' do

    render

    expect(rendered).to match /Program/
    expect(rendered).to match /Update/
    expect(rendered).to match /Cancel/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Cluster/
  end

end
