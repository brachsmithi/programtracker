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
      expect(rendered).to match /Ed Wood, Jr/
      expect(rendered).to match /Ed Wood/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Director/
      expect(rendered).to match /Directors/
    end

  end
  
end

