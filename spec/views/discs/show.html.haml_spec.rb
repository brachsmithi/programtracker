require 'rails_helper'

RSpec.describe "discs/show.html.haml", type: :view do

  context 'with empty disc' do

    before(:each) do
      create(:default_location)
      assign(:disc, Disc.create!(format: 'DVD', state: 'FILED'))
    end
    
    it 'displays the disc' do

      render

      expect(rendered).to have_content 'DVD'
      expect(rendered).to have_content 'FILED'
      expect(rendered).to have_content 'No Programs Listed'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Disc'
      expect(rendered).to have_link 'Disc List'
      expect(rendered).to have_link 'Edit'
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

      expect(rendered).to have_content 'DVD'
      expect(rendered).to have_content 'FILED'
      expect(rendered).to have_content '(NOT SET)'
      expect(rendered).to have_link 'Part of Midnight Movies'
      expect(rendered).to have_no_link 'No Programs Listed'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Disc'
      expect(rendered).to have_link 'Disc List'
      expect(rendered).to have_link 'Edit'
      expect(rendered).to have_no_link 'New Disc'
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

      expect(rendered).to have_content 'DVD'
      expect(rendered).to have_content 'FILED'
      expect(rendered).to have_content '(NOT SET)'
      expect(rendered).to have_link 'The Planet of the Apes'
      expect(rendered).to have_content '(Widescreen)'
      expect(rendered).to have_link 'Roddy McDowall Interview'
      expect(rendered).to have_content 'FEATURE'
      expect(rendered).to have_content 'BONUS'
      expect(rendered).to have_no_content 'No Programs Listed'
      expect(rendered).to have_no_content 'Part of'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Disc'
      expect(rendered).to have_link 'Disc List'
      expect(rendered).to have_link 'Edit'
      expect(rendered).to have_no_link 'New Disc'
    end

  end

  context 'with allow_new flag' do
    
    it 'should display a create button' do
      create(:default_location)
      assign(:disc, Disc.create!(format: 'DVD', state: 'FILED'))
      assign(:allow_new, true)

      render

      expect(rendered).to have_link 'New Disc'
    end

  end

end
