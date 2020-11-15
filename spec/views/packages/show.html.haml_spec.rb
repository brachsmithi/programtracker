require 'rails_helper'

RSpec.describe "packages/show.html.haml", type: :view do
  
  before(:each) do
    location = create(:location)
    program1 = create(:program, name: 'Alien', version: 'Director Cut')
    program2 = create(:program, name: 'Aliens', version: 'Extended')
    program3 = create(:program, name: 'Alien 3', version: 'Widescreen')
    program4 = create(:program, name: 'Alien: Resurrection', version: 'Full Screen')
    disc1 = create(:disc, location: location, format: 'DVD', name: 'Alien Double Feature')
    disc2 = create(:disc, location: location, format: 'Blu-ray')
    create(:disc_program, disc_id: disc1.id, program_id: program1.id)
    create(:disc_program, disc_id: disc1.id, program_id: program2.id)
    create(:disc_program, disc_id: disc2.id, program_id: program3.id)
    create(:disc_program, disc_id: disc2.id, program_id: program4.id)
    package = create(:package, name: 'Alien: Quadrilogy')
    create(:disc_package, disc_id: disc1.id, package_id: package.id, sequence: 1)
    create(:disc_package, disc_id: disc2.id, package_id: package.id, sequence: 2)
    series = create(:series, name: 'Xenomorphs')
    create(:series_package, package_id: package.id, series_id: series.id, sequence: 1)
    assign(:package, package)
  end

  it "should display package data" do
    
    render

    expect(rendered).to have_content 'Alien: Quadrilogy'
    expect(rendered).to have_link 'Alien Double Feature'
    expect(rendered).to have_link 'Alien (Director Cut)'
    expect(rendered).to have_link 'Aliens (Extended)'
    expect(rendered).to have_content '1 -'
    expect(rendered).to have_content 'DVD'
    expect(rendered).to have_link 'Alien 3 (Widescreen)'
    expect(rendered).to have_link 'Alien: Resurrection (Full Screen)'
    expect(rendered).to have_content '2 -'
    expect(rendered).to have_content 'Blu-ray'
    expect(rendered).to have_content 'Series'
    expect(rendered).to have_link 'Xenomorphs'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'Package'
    expect(rendered).to have_link 'Package List'
    expect(rendered).to have_link 'Edit'
  end
end
