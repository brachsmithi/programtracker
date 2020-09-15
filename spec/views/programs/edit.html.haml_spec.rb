require 'rails_helper'

RSpec.describe "programs/edit.html.haml", type: :view do

  context 'with a director' do
    
    before(:each) do
      director = create(:director)
      series = create(:series)
      program = create(:program)
      create(:programs_director, director_id: director.id, program_id: program.id)
      assign(:program, program)
      assign(:series, [series])
      assign(:directors, [director])
    end

    it 'displays the program form' do

      render

      expect(rendered).to have_content 'Name'
      expect(rendered).to have_content 'Sort name'
      expect(rendered).to have_content 'Year'
      expect(rendered).to have_content 'Version'
      expect(rendered).to have_content 'Length'
      expect(rendered).to have_content 'Director'
      expect(rendered).to have_content 'Series'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Program'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end

  end
  
end
