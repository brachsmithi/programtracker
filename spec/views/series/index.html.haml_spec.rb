require 'rails_helper'

RSpec.describe "series/index.html.haml", type: :view do

  context 'with series' do
  
    before(:each) do
      assign(:series, [
        create(:series, name: 'Godzilla'),
        create(:series, name: 'James Bond')
      ])
    end
    
    it 'displays all programs' do

      render

      expect(rendered).to match /Godzilla/
      expect(rendered).to match /James Bond/
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Series/
      expect(rendered).to match /New Series/
    end

  end

  context 'on initial load' do
  
    before(:each) do
      assign(:series, [])
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Series/
      expect(rendered).to match /New Series/
    end

  end

end
