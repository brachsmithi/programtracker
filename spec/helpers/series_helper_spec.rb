require 'rails_helper'

RSpec.describe SeriesHelper, type: :helper do
  
  describe 'capsule_series_program' do

    it 'should construct full capsule' do
      program = create(:program, name: 'Brand Upon the Brain!', version: 'Widescreen', year: '2006')
      series_program = create(:series_program, sequence: 2, program: program, series: create(:series))
      expect(helper.capsule_series_program series_program).to eq 'Brand Upon the Brain! (2006) - Widescreen'
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
      program1 = create(:program, name: 'Part One', version: '', year: '')
      program2 = create(:program, name: 'Part Two', version: '', year: '')
      series_program = create(:series_program, sequence: 1, program: program1, series: contained_series)
      series_program = create(:series_program, sequence: 2, program: program1, series: contained_series)
      series_series = create(:series_series, sequence: 1, contained_series: contained_series, wrapper_series: create(:series))
      expect(helper.capsule_series_series series_series).to eq 'Dr. Mabuse, the Gambler [2]'
    end
    
    it 'should handle name only' do
      contained_series = create(:series, name: 'Star Trek (S3)')
      series_series = create(:series_series, contained_series: contained_series, wrapper_series: create(:series))
      expect(helper.capsule_series_series series_series).to eq 'Star Trek (S3)'
    end

  end

  describe 'sequenced_series_capsule' do
    
    it 'converts a series series into a display capsule hash' do
      series = create(:series, name: 'Dr. Who (5th)')
      series_program = create(:series_program, program: create(:program, name: 'Something With Daleks I Guess'), series: series)
      series_series = create(:series_series, sequence: 2, wrapper_series: create(:series, name: 'Dr. Who'), contained_series: series)
      expected_capsule = {seq: 2, display_capsule: 'Dr. Who (5th) [1]', path_method: 'series_path', id: series.id}
      expect(helper.sequenced_series_capsule series_series).to eq expected_capsule
    end

    it 'converts a program series into a display capsule hash' do
      program = create(:program, name: 'King Kong vs. Godzilla', version: '', year: '1962')
      series_program = create(:series_program, sequence: 3, program: program, series: create(:series, name: 'Godzilla'))
      expected_capsule = {seq: 3, display_capsule: 'King Kong vs. Godzilla (1962)', path_method: 'program_path', id: program.id}
      expect(helper.sequenced_series_capsule series_program).to eq expected_capsule
    end

    it 'handles nil sequences' do
      program = create(:program, name: 'Star Wars', version: '', year: '1977')
      series_program = create(:series_program, sequence: nil, program: program, series: create(:series, name: 'Star Wars'))
      expected_capsule = {seq: 0, display_capsule: 'Star Wars (1977)', path_method: 'program_path', id: program.id}
      expect(helper.sequenced_series_capsule series_program).to eq expected_capsule
    end

  end

end
