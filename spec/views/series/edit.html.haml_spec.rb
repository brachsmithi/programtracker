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

      expect(rendered).to match /Dr. Mabuse/
      expect(rendered).to match /Dr. Mabuse, The Gambler/
      expect(rendered).to match /The Testament of Dr. Mabuse/
      expect(rendered).to match /Sequence/
      expect(rendered).to match /1/
      expect(rendered).to match /2/
      expect(rendered).to match /Name/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Series/
      expect(rendered).to match /Update/
      expect(rendered).to match /Cancel/
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

      expect(rendered).to match /Dr. Mabuse/
      expect(rendered).to match /Dr. Mabuse, The Gambler/
      expect(rendered).to match /The Testament of Dr. Mabuse/
      expect(rendered).to match /Sequence/
      expect(rendered).to match /1/
      expect(rendered).to match /Name/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Series/
      expect(rendered).to match /Update/
      expect(rendered).to match /Cancel/
    end

  end

end
