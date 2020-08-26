require 'rails_helper'

RSpec.describe "directors/show.html.haml", type: :view do

  context 'with director' do

    before(:each) do
      assign(:director, Director.create!(name: 'Edward D. Wood, Jr'))
    end
    
    it 'displays the director' do

      render

      expect(rendered).to match /Edward D. Wood, Jr/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Director/
      expect(rendered).to match /Directors/
    end

  end

  context 'with director that has aliases' do

    before(:each) do
      director = Director.create!(name: 'Edward D. Wood, Jr')
      DirectorAlias.create!(director: director, name: "Ed Wood")
      DirectorAlias.create!(director: director, name: "Ed Wood, Jr")
      assign(:director, director)
    end
    
    it 'displays all director names' do

      render

      expect(rendered).to match /Edward D. Wood, Jr/
      expect(rendered).to match /Ed Wood, Ed Wood, Jr/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Director/
      expect(rendered).to match /Directors/
    end

  end
  
  context 'with director that has programs' do

    before(:each) do
      director = create(:director, name: 'Edward D. Wood, Jr')
      program1 = create(:program, name: 'Glen or Glenda?')
      program2 = create(:program, name: 'Plan 9 from Outer Space')
      create(:programs_director, director_id: director.id, program_id: program1.id)
      create(:programs_director, director_id: director.id, program_id: program2.id)
      assign(:director, director)
    end
    
    it 'displays director and programs' do

      render

      expect(rendered).to match /Edward D. Wood, Jr/
      expect(rendered).to match /Glen or Glenda?/
      expect(rendered).to match /Plan 9 from Outer Space/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Director/
      expect(rendered).to match /Directors/
    end

  end
  
end

