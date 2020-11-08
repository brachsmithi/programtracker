require 'rails_helper'

RSpec.describe "program_version_clusters/show.html.haml", type: :view do
  
  before(:each) do
    dir = create(:person, name: 'Richard Donner')
    p1 = create(:program, name: 'Maverick', version: 'Widescreen', year: '1994')
    p2 = create(:program, name: 'Maverick', version: 'Full Screen', year: '1994')
    p1.persons << dir
    p2.persons << dir
    pvc = create(:program_version_cluster)
    pvc.programs << p1
    pvc.programs << p2
    assign(:program_version_cluster, pvc)
  end

  it "should display cluster data" do
    
    render

    expect(rendered).to have_content 'Maverick'
    expect(rendered).to have_content '1994'
    expect(rendered).to have_link 'Richard Donner'
    expect(rendered).to have_link 'Widescreen'
    expect(rendered).to have_link 'Full Screen'

  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'Program Version Cluster'
  end

end
