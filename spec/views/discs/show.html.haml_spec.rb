require 'rails_helper'

RSpec.describe "discs/show.html.haml", type: :view do

  context 'with empty disc' do

    before(:each) do
      create(:default_location)
      assign(:disc, Disc.create!(format: 'DVD', state: 'FILED'))
    end
    
    it 'displays the disc' do

      render

      expect(rendered).to match /DVD/
      expect(rendered).to match /FILED/
      expect(rendered).to match /No Programs Listed/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Disc/
      expect(rendered).to match /Disc List/
      expect(rendered).to match /Edit/
    end

  end

  context 'with a package' do

    before(:each) do
      create(:default_location)
      disc = Disc.create!(format: 'DVD', state: 'FILED')
      disc.package = create(:package, name: 'Midnight Movies')
      assign(:disc, disc)
    end
    
    it 'displays the disc' do

      render

      expect(rendered).to match /DVD/
      expect(rendered).to match /FILED/
      expect(rendered).to match /\(NOT SET\)/
      expect(rendered).to match /Part of Midnight Movies/
      expect(rendered).to match /No Programs Listed/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Disc/
      expect(rendered).to match /Disc List/
      expect(rendered).to match /Edit/
    end

  end

  context 'with program' do

    before(:each) do
      create(:default_location)
      disc = Disc.create!(format: 'DVD', state: 'FILED')
      DiscProgram.create(disc: disc, program_type: 'FEATURE', program: create(:program, name: 'The Planet of the Apes', version: 'Widescreen'))
      DiscProgram.create(disc: disc, program_type: 'BONUS', program: create(:program, name: 'Roddy McDowall Interview'))
      assign(:disc, disc)
    end
    
    it 'displays the disc and programs' do

      render

      expect(rendered).to match /DVD/
      expect(rendered).to match /FILED/
      expect(rendered).to match /\(NOT SET\)/
      expect(rendered).to match /The Planet of the Apes/
      expect(rendered).to match /\(Widescreen\)/
      expect(rendered).to match /Roddy McDowall Interview/
      expect(rendered).to match /FEATURE/
      expect(rendered).to match /BONUS/
      expect(rendered).to_not match /No Programs Listed/
      expect(rendered).to_not match /Part of/
      expect(rendered).to_not match /\(\)/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Disc/
      expect(rendered).to match /Disc List/
      expect(rendered).to match /Edit/
    end

  end

end
