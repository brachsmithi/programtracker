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
      program2 = create(:program, name: 'An American Werewolf in London', sort_name: 'Amer Werewolf in London', year: '1981', version: 'European', minutes: 90, directors: [director1, director2], series: [series1, series2], alternate_titles: [alternate1, alternate2])
      pvc = ProgramVersionCluster.create!
      pvc.programs << program
      pvc.programs << program2
      assign(:program, program)
    end

    it "should display program data" do
      
      render

      expect(rendered).to have_content 'An American Werewolf in London'
      expect(rendered).to have_content '(1981)'
      expect(rendered).to have_content 'American Werewolf I, The American Werewolf'
      expect(rendered).to have_content '1 hr 30 min'
      expect(rendered).to have_content 'Theatrical'
      expect(rendered).to have_content 'with'
      expect(rendered).to have_link 'John Landis'
      expect(rendered).to have_link 'John Candy'
      expect(rendered).to have_link 'American Werewolf Movies'
      expect(rendered).to have_link 'Werewolf Movies'
      expect(rendered).to have_link 'part of cluster'
      expect(rendered).to have_link 'European'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Directors'
      expect(rendered).to have_content 'Series'
      expect(rendered).to have_link 'Edit'
      expect(rendered).to have_link 'Program List'
    end

  end

  context 'without anything but name' do

    before(:each) do
      program = create(:program, name: 'The Thing With Two Heads', sort_name: '', year: '', version: '', minutes: nil)
      assign(:program, program)
    end

    it "should display program data" do
      
      render

      expect(rendered).to have_content 'The Thing With Two Heads'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_link 'Program List'
      expect(rendered).to have_link 'Edit'
      expect(rendered).to_not have_content 'Directors'
      expect(rendered).to_not have_content 'Series'
    end

  end

end
