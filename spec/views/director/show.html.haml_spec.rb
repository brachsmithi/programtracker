require 'rails_helper'

RSpec.describe "directors/show.html.haml", type: :view do

  context 'with director' do

    before(:each) do
      assign(:director, Director.create!(name: 'Edward D. Wood, Jr'))
    end
    
    it 'displays the director' do

      render

      expect(rendered).to have_content 'Edward D. Wood, Jr'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Director'
      expect(rendered).to have_link 'Director List'
      expect(rendered).to have_link 'Edit'
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

      expect(rendered).to have_content 'Edward D. Wood, Jr'
      expect(rendered).to have_content 'Ed Wood, Ed Wood, Jr'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Director'
      expect(rendered).to have_link 'Director List'
      expect(rendered).to have_link 'Edit'
    end

  end
  
  context 'with director that has programs' do

    before(:each) do
      director = create(:director, name: 'Edward D. Wood, Jr')
      program1 = create(:program, name: 'Glen or Glenda?', year: '1953')
      program2 = create(:program, name: 'Plan 9 from Outer Space', year: '1957', version: 'Colorized')
      create(:programs_director, director_id: director.id, program_id: program1.id)
      create(:programs_director, director_id: director.id, program_id: program2.id)
      assign(:director, director)
    end
    
    it 'displays director and programs' do

      render

      expect(rendered).to have_content 'Edward D. Wood, Jr'
      expect(rendered).to have_link 'Glen or Glenda? (1953)'
      expect(rendered).to have_link 'Plan 9 from Outer Space (1957) - Colorized'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Director'
      expect(rendered).to have_link 'Director List'
      expect(rendered).to have_link 'Edit'
    end

  end
  
end

