require 'rails_helper'

RSpec.describe "programs/index.html.haml", type: :view do

  context 'with programs' do

    before(:each) do
      assign(:programs, [
        Program.create!(name: 'Zombieland'),
        Program.create!(name: 'Zombieland: Double Tap')
      ])
    end
    
    it 'displays all programs' do

      render

      expect(rendered).to match /Zombieland/
      expect(rendered).to match /Zombieland: Double Tap/
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Programs/
      expect(rendered).to match /New Program/
    end

  end

  context 'on initial load' do
    before(:each) do
      assign(:programs, [])
    end

    it 'displays without data' do
    
      render

      expect(rendered).to match /Programs/
      expect(rendered).to match /New Program/
    end

  end
  
end
