require 'rails_helper'

RSpec.describe "packages/edit.html.haml", type: :view do
  context 'with discs' do
    before(:each) do
      location = create(:location)
      program1 = create(:program, name: 'Planet of the Apes')
      program2 = create(:program, name: 'Beneath the Planet of the Apes')
      program3 = create(:program, name: 'Escape from the Planet of the Apes')
      program4 = create(:program, name: 'Conquest of the Planet of the Apes')
      program5 = create(:program, name: 'Battle for the Planet of the Apes')
      disc1 = create(:disc, location: location, format: 'DVD', name: 'Disc 1')
      disc2 = create(:disc, location: location, format: 'DVD', name: 'Disc 2')
      disc3 = create(:disc, location: location, format: 'DVD', name: 'Disc 3')
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

      expect(rendered).to have_content 'Name'
      expect(rendered).to have_content 'Disc 1'
      expect(rendered).to have_content 'Planet of the Apes'
      expect(rendered).to have_content 'Disc 2'
      expect(rendered).to have_content 'Beneath the Planet of the Apes'
      expect(rendered).to have_content 'Escape from the Planet of the Apes'
      expect(rendered).to have_content 'Disc 3'
      expect(rendered).to have_content 'Conquest of the Planet of the Apes'
      expect(rendered).to have_content 'Battle for the Planet of the Apes'
      expect(rendered).to have_content 'DVD'
      expect(rendered).to have_content 'Sequence'
      expect(rendered).to have_content 'Series'
      expect(rendered).to have_content 'Add Wrapper Package'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Package'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end
  end

  context 'with contained and wrapper packages' do
    
    before(:each) do
      location = create(:location)
      package = create(:package, name: 'The Avengers 65: Set 1')
      wp = create(:package, name: 'The Avengers 65')
      cp = create(:package, name: 'The Avengers 65: Set 1, volume 1')
      create(:package_package, wrapper_package: wp, contained_package: package)
      create(:package_package, wrapper_package: package, contained_package: cp)
      assign(:package, package)
    end

    it 'displays the package form' do

      render

      expect(rendered).to have_content 'The Avengers 65: Set 1'
      expect(rendered).to have_content 'The Avengers 65'
      expect(rendered).to have_content 'The Avengers 65: Set 1, volume 1'
      expect(rendered).to have_content 'Add Wrapper Package'
      expect(rendered).to have_content 'Sequence'
      expect(rendered).to have_content 'Name'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Package'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end

  end

end
