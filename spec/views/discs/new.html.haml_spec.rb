require 'rails_helper'

RSpec.describe "discs/new.html.haml", type: :view do

  context 'without an empty disc program' do

    before(:each) do
      program = create(:program)
      assign(:disc, Disc.new)
      assign(:packages, [create(:package, name: 'Star Trek: Season One')])
      assign(:locations, [create(:default_location)])
      assign(:programs, [ProgramsSearch.find(program.id)])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to have_content 'Name'
      expect(rendered).to have_content 'Format'
      expect(rendered).to have_content 'State'
      expect(rendered).to have_content 'Location'
      expect(rendered).to have_link 'Add Program'
      expect(rendered).to have_link 'Add Series'
      expect(rendered).to have_no_content 'Sequence'
      expect(rendered).to have_no_content 'Package'
      expect(rendered).to_not have_content 'Star Trek: Season One'
      expect(rendered).to have_no_content 'Program Type'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'New Disc'
      expect(rendered).to have_link 'Create'
      expect(rendered).to have_link 'Cancel'
    end

  end

  context 'with an empty disc program and package' do

    before(:each) do
      disc = Disc.new
      disc.disc_programs.build
      disc.build_disc_package
      program = create(:program)
      assign(:disc, disc)
      assign(:locations, [create(:default_location)])
      assign(:programs, [ProgramsSearch.find(program.id)])
      assign(:packages, [create(:package, name: 'Star Trek: Season One')]) 
    end

    it 'displays the disc form' do

      render

      expect(rendered).to have_content 'Format'
      expect(rendered).to have_content 'State'
      expect(rendered).to have_content 'Location'
      expect(rendered).to have_content 'Package'
      expect(rendered).to have_content 'Star Trek: Season One'
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

end
