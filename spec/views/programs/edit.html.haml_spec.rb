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

      expect(rendered).to match /Name/
      expect(rendered).to match /Sort name/
      expect(rendered).to match /Year/
      expect(rendered).to match /Version/
      expect(rendered).to match /Length/
      expect(rendered).to match /Director/
      expect(rendered).to match /Series/
      expect(rendered).to match /Edit/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Program/
    end

  end

  context 'without a director' do
    
    before(:each) do
      director = create(:default_director)
      series = create(:series)
      program = create(:program)
      create(:programs_director, director_id: director.id, program_id: program.id)
      assign(:program, program)
      assign(:series, [series])
      assign(:directors, [director])
    end

  end
  
end
