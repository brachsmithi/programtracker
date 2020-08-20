require 'rails_helper'

RSpec.describe "packages/index.html.haml", type: :view do
  
  context 'with packages' do
  
    before(:each) do
      assign(:packages, [
        create(:package, name: 'Godzilla Criterion Set'),
        create(:package, name: 'Universal Monster Set')
      ])
    end
    
    it 'displays all packages' do

      render

      expect(rendered).to match /Godzilla Criterion Set/
      expect(rendered).to match /Universal Monster Set/
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Packages/
      expect(rendered).to match /New Package/
    end

  end

  context 'on initial load' do
  
    before(:each) do
      assign(:packages, [])
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Packages/
      expect(rendered).to match /New Package/
    end

  end
  
end
