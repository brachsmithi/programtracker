require 'rails_helper'

RSpec.describe "programs/edit.html.haml", type: :view do

  context 'with a person' do
    
    before(:each) do
      person = create(:person)
      series = create(:series)
      program = create(:program)
      create(:programs_director, 'director_id': person.id, program_id: program.id)
      assign(:program, program)
      assign(:series, [series])
      assign(:persons, [person])
    end

    it 'displays the program form' do

      render

      expect(rendered).to have_content 'Name'
      expect(rendered).to have_content 'Sort name'
      expect(rendered).to have_content 'Year'
      expect(rendered).to have_content 'Version'
      expect(rendered).to have_content 'Length'
      expect(rendered).to have_content 'Person'
      expect(rendered).to have_content 'Series'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Program'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end

  end

  context 'with a program cluster' do
    
    before(:each) do
      series = create(:series)
      program = create(:program, version: 'Full Screen')
      program2 = create(:program, version: 'Widescreen')
      program3 = create(:program, version: 'R-Rated Cut')
      pvc = ProgramVersionCluster.create!
      pvc.programs << program
      pvc.programs << program2
      pvc.programs << program3
      assign(:program, program)
      assign(:series, [series])
    end

    it 'should display the program cluster information' do
      
      render

      expect(rendered).to have_content 'part of cluster'
      expect(rendered).to have_content 'with'
      expect(rendered).to have_content 'Widescreen'
      expect(rendered).to have_content 'R-Rated Cut'
      
      expect(rendered).to have_link 'New Version'
      expect(rendered).to have_no_link 'part of cluster'
      expect(rendered).to have_no_link 'Widescreen'
      expect(rendered).to have_no_link 'R-Rated Cut'
    end
    
  end
  
end
