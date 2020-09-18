require 'rails_helper'

RSpec.describe SeriesHelper, type: :helper do
  
  describe 'capsule_series_program' do

    it 'should construct full capsule' do
      program = create(:program, name: 'Brand Upon the Brain!', version: 'Widescreen', year: '2006')
      series_program = create(:series_program, sequence: 2, program: program, series: create(:series))
      expect(helper.capsule_series_program series_program).to eq '2 - Brand Upon the Brain! (2006) - Widescreen'
    end

    it 'should handle name only' do
      program = create(:program, name: 'The Brain', version: '', year: '')
      series_program = create(:series_program, sequence: nil, program: program, series: create(:series))
      expect(helper.capsule_series_program series_program).to eq 'The Brain'
    end

  end

  describe 'capsule_series_series' do
    
    it 'should construct full capsule' do
      contained_series = create(:series, name: 'Dr. Mabuse, the Gambler')
      series_series = create(:series_series, sequence: 1, contained_series: contained_series, wrapper_series: create(:series))
      expect(helper.capsule_series_series series_series).to eq '1 - Dr. Mabuse, the Gambler'
    end
    
    it 'should handle name only' do
      contained_series = create(:series, name: 'Star Trek (S3)')
      series_series = create(:series_series, contained_series: contained_series, wrapper_series: create(:series))
      expect(helper.capsule_series_series series_series).to eq 'Star Trek (S3)'
    end

  end

end
