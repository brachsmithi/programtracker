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

    expect(rendered).to have_content 'Program'
    expect(rendered).to have_content 'Name'
    expect(rendered).to have_content 'Sort name'
    expect(rendered).to have_content 'Year'
    expect(rendered).to have_link 'Update'
    expect(rendered).to have_link 'Cancel'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'Edit Cluster'
  end

end
