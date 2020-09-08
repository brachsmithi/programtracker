require 'rails_helper'

RSpec.describe "programs/show.html.haml", type: :view do
  
  context 'when fully loaded' do

    before(:each) do
      director1 = Director.create(name: 'John Landis')
      director2 = Director.create(name: 'John Candy')
      series1 = Series.create(name: 'American Werewolf Movies')
      series2 = Series.create(name: 'Werewolf Movies')
      alternate1 = AlternateTitle.create(name: 'American Werewolf I')
      alternate2 = AlternateTitle.create(name: 'The American Werewolf')
      program = create(:program, name: 'An American Werewolf in London', sort_name: 'Amer Werewolf in London', year: '1981', version: 'Theatrical', minutes: 90, directors: [director1, director2], series: [series1, series2], alternate_titles: [alternate1, alternate2])
      assign(:program, program)
    end

    it "should display program data" do
      
      render

      expect(rendered).to match /An American Werewolf in London/
      expect(rendered).to match /(1981)/
      expect(rendered).to match /American Werewolf I, The American Werewolf/
      expect(rendered).to match /1 hr 30 min/
      expect(rendered).to match /Theatrical/
      expect(rendered).to match /John Landis/
      expect(rendered).to match /, John Candy/
      expect(rendered).to match /American Werewolf Movies/
      expect(rendered).to match /, Werewolf Movies/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Directors/
      expect(rendered).to match /Series/
      expect(rendered).to match /Edit/
      expect(rendered).to match /Program List/
    end

  end

  context 'without anything but name' do

    before(:each) do
      program = create(:program, name: 'The Thing With Two Heads', sort_name: '', year: '', version: '', minutes: nil)
      assign(:program, program)
    end

    it "should display program data" do
      
      render

      expect(rendered).to match /The Thing With Two Heads/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Program List/
      expect(rendered).to match /Edit/
      expect(rendered).to_not match /Directors/
      expect(rendered).to_not match /Series/
    end

  end

end
