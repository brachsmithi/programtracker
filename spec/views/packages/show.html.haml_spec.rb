require 'rails_helper'

RSpec.describe "packages/show.html.haml", type: :view do
  
  before(:each) do
    location = create(:default_location)
    program1 = create(:program, name: 'Alien')
    program2 = create(:program, name: 'Aliens')
    program3 = create(:program, name: 'Alien 3')
    program4 = create(:program, name: 'Alien: Resurrection')
    disc1 = create(:disc, location: location)
    disc2 = create(:disc, location: location)
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
    expect(rendered).to match /Alien/
    expect(rendered).to match /1/
    expect(rendered).to match /Alien 3/
    expect(rendered).to match /2/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Package/
    expect(rendered).to match /Packages/
  end
end
