require 'rails_helper'

RSpec.describe "discs/edit.html.haml", type: :view do
  
  context 'without programs or package' do

    before(:each) do
      disc = create(:disc)
      program = create(:program)
      assign(:disc, disc)
      assign(:locations, [disc.location])
      assign(:packages, [create(:package, name: 'The Americans: The Complete Series')])
      assign(:programs, [ProgramsSearch.find(program.id)])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to have_content 'Name'
      expect(rendered).to have_content 'Format'
      expect(rendered).to have_content 'State'
      expect(rendered).to have_content 'Location'
      expect(rendered).to have_content 'Edit'
      expect(rendered).to have_link 'Add Program'
      expect(rendered).to have_no_content 'Package'
      expect(rendered).to have_no_content 'The Americans: The Complete Series'
      expect(rendered).to have_no_content 'Program Type'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Disc'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end

  end

  context 'with programs and empty package' do

    before(:each) do
      disc = create(:disc)
      disc.build_disc_package
      program1 = create(:program, name: 'The Planet of the Apes')
      program2 = create(:program, name: 'Roddy McDowall Interview')
      program3 = create(:program, name: 'Beneath the Planet of the Apes')
      DiscProgram.create(disc: disc, program_type: 'FEATURE', program: program1)
      DiscProgram.create(disc: disc, program_type: 'BONUS', program: program2)
      assign(:disc, disc)
      assign(:locations, [disc.location])
      assign(:programs, [
        ProgramsSearch.find(program1.id), 
        ProgramsSearch.find(program2.id), 
        ProgramsSearch.find(program3.id)])
      assign(:packages, [create(:package, name: 'The Americans: The Complete Series')])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to have_content 'Format'
      expect(rendered).to have_content 'State'
      expect(rendered).to have_content 'Location'
      expect(rendered).to have_content 'Edit Disc'
      expect(rendered).to have_content 'Package'
      expect(rendered).to have_content 'The Americans: The Complete Series'
      expect(rendered).to have_content 'Program'
      expect(rendered).to have_content 'Program type'
      expect(rendered).to have_content 'Sequence'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Disc/
      expect(rendered).to match /Update/
      expect(rendered).to match /Cancel/
    end

  end

end
