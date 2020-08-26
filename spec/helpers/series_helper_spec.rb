require 'rails_helper'

RSpec.describe SeriesHelper, type: :helper do
  
  describe 'capsule_series_program' do

    it 'should construct full capsule' do
      program = create(:program, name: 'Brand Upon the Brain', version: 'Widescreen')
      series_program = create(:series_program, sequence: 2, program: program, series: create(:series))
      expect(helper.capsule_series_program series_program).to eq '2 - Brand Upon the Brain (Widescreen)'
    end

    it 'should handle name only' do
      program = create(:program, name: 'The Brain', version: '')
      series_program = create(:series_program, sequence: nil, program: program, series: create(:series))
      expect(helper.capsule_series_program series_program).to eq 'The Brain'
    end

  end

end
