require 'rails_helper'

RSpec.describe "series/edit.html.haml", type: :view do
  
  context 'with assigned sequences' do
    
    before(:each) do
      location = create(:location)
      series = create(:series, name: 'Dr. Mabuse')
      program1 = create(:program, name: 'Dr. Mabuse, The Gambler')
      program2 = create(:program, name: 'The Testament of Dr. Mabuse')
      program3 = create(:program, name: 'Bonus Feature')
      disc = create(:disc, location: location)
      package = create(:package, name: 'Mabuse Triple Feature')
      assign(:series, series)
      assign(:select_series, [create(:series, name: 'First Series'), create(:series, name: 'Second Series')])
      create(:series_program, series_id: series.id, program_id: program1.id, sequence: 1)
      create(:series_program, series_id: series.id, program_id: program2.id, sequence: 2)
      create(:disc_program, disc_id: disc.id, program_id: program3.id)
      create(:series_disc, disc_id: disc.id, series_id: series.id, sequence: 3)
      create(:series_package, package_id: package.id, series_id: series.id, sequence: 5)
    end

    it 'displays the series form' do

      render

      expect(rendered).to have_content 'Dr. Mabuse'
      expect(rendered).to have_content 'Dr. Mabuse, The Gambler'
      expect(rendered).to have_content 'The Testament of Dr. Mabuse'
      expect(rendered).to have_content 'Bonus Feature'
      expect(rendered).to have_content 'Add Wrapper Series'
      expect(rendered).to have_content 'Mabuse Triple Feature'
      expect(rendered).to have_content 'Sequence'
      expect(rendered).to have_content 'Name'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Series'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end

  end

  context 'with sequences assigned and nil' do
    
    before(:each) do
      create(:location)
      series = create(:series, name: 'Dr. Mabuse')
      program1 = create(:program, name: 'Dr. Mabuse, The Gambler')
      program2 = create(:program, name: 'The Testament of Dr. Mabuse')
      assign(:series, series)
      assign(:select_series, [create(:series, name: 'First Series'), create(:series, name: 'Second Series')])
      create(:series_program, series_id: series.id, program_id: program1.id, sequence: 1)
      create(:series_program, series_id: series.id, program_id: program2.id, sequence: nil)
    end

    it 'displays the series form' do

      render

      expect(rendered).to have_content 'Dr. Mabuse'
      expect(rendered).to have_content 'Dr. Mabuse, The Gambler'
      expect(rendered).to have_content 'The Testament of Dr. Mabuse'
      expect(rendered).to have_content 'Sequence'
      expect(rendered).to have_content 'Add Wrapper Series'
      expect(rendered).to have_content 'Name'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Series'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end

  end

  context 'with contained and wrapper series' do
    
    before(:each) do
      create(:location)
      series = create(:series, name: 'Dr. Mabuse')
      ws = create(:series, name: 'The Wrapper of Dr. Mabuse')
      cs = create(:series, name: 'Mabuse, Contained!')
      create(:series_series, wrapper_series: ws, contained_series: series)
      create(:series_series, wrapper_series: series, contained_series: cs)
      assign(:series, series)
      assign(:select_series, [create(:series, name: 'First Series'), create(:series, name: 'Second Series')])
    end

    it 'displays the series form' do

      render

      expect(rendered).to have_content 'Dr. Mabuse'
      expect(rendered).to have_content 'The Wrapper of Dr. Mabuse'
      expect(rendered).to have_content 'Mabuse, Contained!'
      expect(rendered).to have_content 'Add Wrapper Series'
      expect(rendered).to have_content 'Sequence'
      expect(rendered).to have_content 'Name'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Edit Series'
      expect(rendered).to have_link 'Update'
      expect(rendered).to have_link 'Cancel'
    end

  end

end
