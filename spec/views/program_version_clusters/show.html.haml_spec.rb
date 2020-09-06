require 'rails_helper'

RSpec.describe "program_version_clusters/show.html.haml", type: :view do
  
  before(:each) do
    dir = create(:director, name: 'Richard Donner')
    p1 = create(:program, name: 'Maverick', version: 'Widescreen', year: '1994')
    p2 = create(:program, name: 'Maverick', version: 'Full Screen', year: '1994')
    p1.directors << dir
    p2.directors << dir
    pvc = create(:program_version_cluster)
    pvc.programs << p1
    pvc.programs << p2
    assign(:program_version_cluster, pvc)
  end

  it "should display cluster data" do
    
    render

    expect(rendered).to match /Maverick/
    expect(rendered).to match /1994/
    expect(rendered).to match /Richard Donner/
    expect(rendered).to match /Widescreen/
    expect(rendered).to match /Full Screen/

  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Program Version Cluster/
  end

end
