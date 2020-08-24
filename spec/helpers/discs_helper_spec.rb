require 'rails_helper'

RSpec.describe DiscsHelper, type: :helper do

  describe 'program_select_name' do
    
    it 'should list identifying information' do
      program = create(:program, name: 'Alien', year: 1979, version: 'Theatrical')
      expect(helper.program_select_name(program)).to eq 'Alien (1979) - Theatrical'
    end

    it 'should handle missing year gracefully' do
      program = create(:program, name: 'Alien', year: '', version: 'Theatrical')
      expect(helper.program_select_name(program)).to eq 'Alien - Theatrical'
    end

    it 'should handle missing version gracefully' do
      program = create(:program, name: 'Alien', year: 1979, version: '')
      expect(helper.program_select_name(program)).to eq 'Alien (1979)'
    end

  end

end
