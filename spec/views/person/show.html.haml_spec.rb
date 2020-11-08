require 'rails_helper'

RSpec.describe "persons/show.html.haml", type: :view do

  context 'with person' do

    before(:each) do
      assign(:person, Person.create!(name: 'Edward D. Wood, Jr'))
    end
    
    it 'displays the person' do

      render

      expect(rendered).to have_content 'Edward D. Wood, Jr'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Person'
      expect(rendered).to have_link 'Person List'
      expect(rendered).to have_link 'Edit'
    end

  end

  context 'with person that has aliases' do

    before(:each) do
      person = Person.create!(name: 'Edward D. Wood, Jr')
      PersonAlias.create!('director_id': person.id, name: "Ed Wood")
      PersonAlias.create!('director_id': person.id, name: "Ed Wood, Jr")
      assign(:person, person)
    end
    
    it 'displays all person names' do

      render

      expect(rendered).to have_content 'Edward D. Wood, Jr'
      expect(rendered).to have_content 'Ed Wood, Ed Wood, Jr'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Person'
      expect(rendered).to have_link 'Person List'
      expect(rendered).to have_link 'Edit'
    end

  end
  
  context 'with person that has programs' do

    before(:each) do
      person = create(:person, name: 'Edward D. Wood, Jr')
      program1 = create(:program, name: 'Glen or Glenda?', year: '1953')
      program2 = create(:program, name: 'Plan 9 from Outer Space', year: '1957', version: 'Colorized')
      create(:programs_director, director_id: person.id, program_id: program1.id)
      create(:programs_director, director_id: person.id, program_id: program2.id)
      assign(:person, person)
    end
    
    it 'displays person and programs' do

      render

      expect(rendered).to have_content 'Edward D. Wood, Jr'
      expect(rendered).to have_link 'Glen or Glenda? (1953)'
      expect(rendered).to have_link 'Plan 9 from Outer Space (1957) - Colorized'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Person'
      expect(rendered).to have_link 'Person List'
      expect(rendered).to have_link 'Edit'
    end

  end
  
end

