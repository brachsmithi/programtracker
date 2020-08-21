require 'rails_helper'

RSpec.describe "directors/index.html.haml", type: :view do

  context 'with directors' do

    before(:each) do
      assign(:directors, [
        Director.create!(name: 'Edward D. Wood, Jr'),
        Director.create!(name: 'Ray Dennis Steckler')
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all directors' do

      render

      expect(rendered).to match /Edward D. Wood, Jr/
      expect(rendered).to match /Ray Dennis Steckler/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Directors/
      expect(rendered).to match /New Director/
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
      expect(rendered).to match /destroy/
    end

  end

  context 'on initial load' do
    before(:each) do
      assign(:directors, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays without data' do
    
      render

      expect(rendered).to match /Directors/
      expect(rendered).to match /New Director/
    end

  end

end
