require 'rails_helper'

RSpec.describe "persons/index.html.haml", type: :view do

  context 'with persons' do

    before(:each) do
      assign(:persons, [
        Person.create!(name: 'Edward D. Wood, Jr'),
        Person.create!(name: 'Ray Dennis Steckler')
      ])
      allow(view).to receive_messages(will_paginate: nil)
    end
    
    it 'displays all persons' do

      render

      expect(rendered).to have_content 'Edward D. Wood, Jr'
      expect(rendered).to have_content 'Ray Dennis Steckler'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Person Index'
      expect(rendered).to have_link 'New Person'
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
      expect(rendered).to match /destroy/
    end

  end

  context 'on initial load' do
    before(:each) do
      assign(:persons, [])
      allow(view).to receive_messages(will_paginate: nil)
    end

    it 'displays without data' do
    
      render

      expect(rendered).to have_content 'Person Index'
      expect(rendered).to have_link 'New Person'
    end

  end

end
