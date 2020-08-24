require 'rails_helper'

RSpec.describe "packages/edit.html.haml", type: :view do
  
  before(:each) do
    location = create(:default_location)
    program1 = create(:program, name: 'Planet of the Apes')
    program2 = create(:program, name: 'Beneath the Planet of the Apes')
    program3 = create(:program, name: 'Escape from the Planet of the Apes')
    program4 = create(:program, name: 'Conquest of the Planet of the Apes')
    program5 = create(:program, name: 'Battle for the Planet of the Apes')
    disc1 = create(:disc, location: location, format: 'DVD')
    disc2 = create(:disc, location: location, format: 'DVD')
    disc3 = create(:disc, location: location, format: 'DVD')
    create(:disc_program, disc_id: disc1.id, program_id: program1.id)
    create(:disc_program, disc_id: disc2.id, program_id: program2.id)
    create(:disc_program, disc_id: disc2.id, program_id: program3.id)
    create(:disc_program, disc_id: disc3.id, program_id: program4.id)
    create(:disc_program, disc_id: disc3.id, program_id: program5.id)
    package = create(:package, name: 'The Planet of the Apes')
    create(:disc_package, disc_id: disc1.id, package_id: package.id)
    create(:disc_package, disc_id: disc2.id, package_id: package.id)
    create(:disc_package, disc_id: disc3.id, package_id: package.id)
    assign(:package, package)
  end

  it 'displays the package form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Planet of the Apes/
    expect(rendered).to match /Beneath the Planet of the Apes/
    expect(rendered).to match /Escape from the Planet of the Apes/
    expect(rendered).to match /Conquest of the Planet of the Apes/
    expect(rendered).to match /Battle for the Planet of the Apes/
    expect(rendered).to match /DVD/
    expect(rendered).to match /Sequence/
    expect(rendered).to match /Edit/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Package/
  end

end
