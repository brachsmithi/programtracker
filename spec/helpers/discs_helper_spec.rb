require 'rails_helper'

RSpec.describe DiscsHelper, type: :helper do
  
  describe 'disc_display_name' do
    
    it 'should return name' do
      d = create(:disc)
      create(:disc_program, disc: d, program: create(:program, name: 'The Imaginary Voyage', year: '1926'))
      expect(helper.disc_display_name(d)).to eq 'The Imaginary Voyage (1926)'
    end

  end

end
