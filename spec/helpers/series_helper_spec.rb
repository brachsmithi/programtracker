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

  describe 'capsule_series_disc' do

    it 'should construct full capsule' do
      disc = create(:disc, name: 'Chaplin Shorts')
      series_disc = create(:series_disc, sequence: 5, disc: disc, series: create(:series))
      expect(helper.capsule_series_disc series_disc).to eq 'Chaplin Shorts'
    end

  end

  describe 'sequenced_series_capsule' do
    
    it 'converts a series series into a display capsule hash' do
      series = create(:series, name: 'Dr. Who (5th)')
      series_program = create(:series_program, program: create(:program, name: 'Something With Daleks I Guess'), series: series)
      series_series = create(:series_series, sequence: 2, wrapper_series: create(:series, name: 'Dr. Who'), contained_series: series)
      expected_capsule = {
        seq: 2, 
        display_capsule: 'Dr. Who (5th) [1]', 
        path_method: 'series_path', 
        id: series.id
      }
      expect(helper.sequenced_series_capsule series_series).to eq expected_capsule
    end

    it 'converts a program series into a display capsule hash' do
      program = create(:program, name: 'King Kong vs. Godzilla', version: '', year: '1962')
      series_program = create(:series_program, sequence: 3, program: program, series: create(:series, name: 'Godzilla'))
      expected_capsule = {
        seq: 3, 
        display_capsule: 'King Kong vs. Godzilla (1962)', 
        path_method: 'program_path', 
        id: program.id
      }
      expect(helper.sequenced_series_capsule series_program).to eq expected_capsule
    end

    it 'converts a disc series into a display capsule hash' do
      disc = create(:disc, name: 'Comedy Capers')
      series_disc = create(:series_disc, sequence: 8, disc: disc, series: create(:series, name: 'Silent Shorts'))
      expected_capsule = {
        seq: 8, 
        display_capsule: 'Comedy Capers', 
        path_method: 'disc_path', 
        id: disc.id
      }
      expect(helper.sequenced_series_capsule series_disc).to eq expected_capsule
    end

    it 'handles nil sequences' do
      program = create(:program, name: 'Star Wars', version: '', year: '1977')
      series_program = create(:series_program, sequence: nil, program: program, series: create(:series, name: 'Star Wars'))
      expected_capsule = {
        seq: 0, 
        display_capsule: 'Star Wars (1977)', 
        path_method: 'program_path', 
        id: program.id
      }
      expect(helper.sequenced_series_capsule series_program).to eq expected_capsule
    end

  end

  describe 'series_capsule_array' do
    
    it 'should generate array of sequenced series capsules' do
      wrapper_series = create(:series, name: 'Voyage to the Bottom of the Sea')
      contained_series1 = create(:series, name: 'Voyage to the Bottom of the Sea (S1)')
      contained_series2 = create(:series, name: 'Voyage to the Bottom of the Sea (S2)')
      program1 = create(:program, name: 'Voyage to the Bottom of the Sea', year: '1961', version: '')
      program2 = create(:program, name: 'Voyage to the Bottom of the Sea (TV Pilot)', year: '', version: '')
      disc = create(:disc, name: 'Interviews')
      create(:series_program, series: wrapper_series, program: program2, sequence: 2)
      create(:series_series, wrapper_series: wrapper_series, contained_series: contained_series2, sequence: 4)
      create(:series_disc, series: wrapper_series, disc: disc, sequence: 5)
      create(:series_series, wrapper_series: wrapper_series, contained_series: contained_series1, sequence: 3)
      create(:series_program, series: wrapper_series, program: program1, sequence: 1)
      expected_program_capsule1 = {
        seq: 1, 
        display_capsule: 'Voyage to the Bottom of the Sea (1961)', 
        path_method: 'program_path', 
        id: program1.id
      }
      expected_program_capsule2 = {
        seq: 2, 
        display_capsule: 'Voyage to the Bottom of the Sea (TV Pilot)', 
        path_method: 'program_path', 
        id: program2.id
      }
      expected_series_capsule1 = {
        seq: 3, 
        display_capsule: 'Voyage to the Bottom of the Sea (S1)', 
        path_method: 'series_path', 
        id: contained_series1.id
      }
      expected_series_capsule2 = {
        seq: 4, 
        display_capsule: 'Voyage to the Bottom of the Sea (S2)', 
        path_method: 'series_path', 
        id: contained_series2.id
      }
      expected_series_disc = {
        seq: 5,
        display_capsule: 'Interviews',
        path_method: 'disc_path',
        id: disc.id
      }
      expected_array = [
        expected_program_capsule1, 
        expected_program_capsule2, 
        expected_series_capsule1, 
        expected_series_capsule2, 
        expected_series_disc
      ]
      expect(helper.series_capsule_array wrapper_series).to eq expected_array
    end

    it 'should handle empty series programs' do
      wrapper_series = create(:series, name: 'Lost in Space')
      contained_series = create(:series, name: 'Lost in Space (S1)')
      disc = create(:disc, name: 'Extras')
      create(:series_series, wrapper_series: wrapper_series, contained_series: contained_series, sequence: 2)
      create(:series_disc, series: wrapper_series, disc: disc, sequence: 1)
      expected_series_capsule = {
        seq: 2, 
        display_capsule: 'Lost in Space (S1)', 
        path_method: 'series_path', 
        id: contained_series.id
      }
      expected_disc_capsule = {
        seq: 1, 
        display_capsule: 'Extras', 
        path_method: 'disc_path', 
        id: disc.id
      }
      expect(helper.series_capsule_array wrapper_series).to eq [expected_disc_capsule, expected_series_capsule]
    end

    it 'should handle empty series series' do
      wrapper_series = create(:series, name: 'The Time Tunnel')
      program = create(:program, name: 'Episode 12', year: '', version: '')
      disc = create(:disc, name: 'Tonight Show Appearance')
      create(:series_program, series: wrapper_series, program: program, sequence: 12)
      create(:series_disc, series: wrapper_series, disc: disc, sequence: 4)
      expected_program_capsule = {
        seq: 12, 
        display_capsule: 'Episode 12', 
        path_method: 'program_path', 
        id: program.id
      }
      expected_disc_capsule = {
        seq: 4, 
        display_capsule: 'Tonight Show Appearance', 
        path_method: 'disc_path', 
        id: disc.id
      }
      expect(helper.series_capsule_array wrapper_series).to eq [expected_disc_capsule, expected_program_capsule]
    end

    it 'should handle empty series' do
      series = create(:series, name: 'Land of the Lost')
      expect(helper.series_capsule_array series).to be_empty
    end

  end

end
