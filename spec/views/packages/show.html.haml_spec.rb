require 'rails_helper'

RSpec.describe "packages/show.html.haml", type: :view do
  
  before(:each) do
    location = create(:default_location)
    program1 = create(:program, name: 'Alien', version: 'Director Cut')
    program2 = create(:program, name: 'Aliens', version: 'Extended')
    program3 = create(:program, name: 'Alien 3', version: 'Widescreen')
    program4 = create(:program, name: 'Alien: Resurrection', version: 'Full Screen')
    disc1 = create(:disc, location: location, format: 'DVD')
    disc2 = create(:disc, location: location, format: 'Blu-ray')
    create(:disc_program, disc_id: disc1.id, program_id: program1.id)
    create(:disc_program, disc_id: disc1.id, program_id: program2.id)
    create(:disc_program, disc_id: disc2.id, program_id: program3.id)
    create(:disc_program, disc_id: disc2.id, program_id: program4.id)
    package = create(:package, name: 'Alien: Quadrilogy')
    create(:disc_package, disc_id: disc1.id, package_id: package.id, sequence: 1)
    create(:disc_package, disc_id: disc2.id, package_id: package.id, sequence: 2)
    assign(:package, package)
  end

  it "should display package data" do
    
    render

    expect(rendered).to match /Alien: Quadrilogy/
    expect(rendered).to match /Alien \(Director Cut\), Aliens \(Extended\)/
    expect(rendered).to match /1 -/
    expect(rendered).to match /DVD/
    expect(rendered).to match /Alien 3 \(Widescreen\), Alien: Resurrection \(Full Screen\)/
    expect(rendered).to match /2 -/
    expect(rendered).to match /Blu-ray/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Package/
    expect(rendered).to match /Packages/
  end
end
