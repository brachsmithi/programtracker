require 'rails_helper'

RSpec.describe "discs/new.html.haml", type: :view do

  before(:each) do
    disc = Disc.new
    disc.disc_programs.build
    disc.build_disc_package
    assign(:disc, disc)
    assign(:locations, [create(:location)])
  end

  it 'displays the disc form' do

    render

    expect(rendered).to have_content 'Format'
    expect(rendered).to have_content 'State'
    expect(rendered).to have_content 'Location'
    expect(rendered).to have_content 'Select package'
    expect(rendered).to have_link 'Add Program'
    expect(rendered).to have_link 'Add Series'
    expect(rendered).to have_content 'Program type'
    expect(rendered).to have_content 'Sequence'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Disc'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end

end
