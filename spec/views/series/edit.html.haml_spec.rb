require 'rails_helper'

RSpec.describe "series/edit.html.haml", type: :view do
  
  context 'with assigned sequences' do
    
    before(:each) do
      location = create(:default_location)
      series = create(:series, name: 'Dr. Mabuse')
      program1 = create(:program, name: 'Dr. Mabuse, The Gambler')
      program2 = create(:program, name: 'The Testament of Dr. Mabuse')
      assign(:series, series)
      create(:series_program, series_id: series.id, program_id: program1.id, sequence: 1)
      create(:series_program, series_id: series.id, program_id: program2.id, sequence: 2)
    end

    it 'displays the series form' do

      render

      expect(rendered).to have_content 'Dr. Mabuse'
      expect(rendered).to have_content 'Dr. Mabuse, The Gambler'
      expect(rendered).to have_content 'The Testament of Dr. Mabuse'
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
      location = create(:default_location)
      series = create(:series, name: 'Dr. Mabuse')
      program1 = create(:program, name: 'Dr. Mabuse, The Gambler')
      program2 = create(:program, name: 'The Testament of Dr. Mabuse')
      assign(:series, series)
      create(:series_program, series_id: series.id, program_id: program1.id, sequence: 1)
      create(:series_program, series_id: series.id, program_id: program2.id, sequence: nil)
    end

    it 'displays the series form' do

      render

      expect(rendered).to have_content 'Dr. Mabuse'
      expect(rendered).to have_content 'Dr. Mabuse, The Gambler'
      expect(rendered).to have_content 'The Testament of Dr. Mabuse'
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
