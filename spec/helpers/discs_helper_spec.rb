require 'rails_helper'

RSpec.describe DiscsHelper, type: :helper do
  
  describe 'disc_display_name' do
    
    it 'should return name' do
      d = create(:disc)
      create(:disc_program, disc: d, program: create(:program, name: 'The Imaginary Voyage', year: '1926'))
      expect(helper.disc_display_name(d)).to eq 'The Imaginary Voyage (1926)'
    end

  end

  describe 'disc_index_capsule' do
    
    it 'should include title, disc format, and location' do
      loc = create(:location, name: 'A-2')
      d = create(:disc, format: 'Blu-ray', location: loc)
      prog = create(:program, name: 'Anaconda', year: '1997')
      create(:disc_program, disc: d, program: prog)

      expect(helper.disc_index_capsule(DiscsSearch.find(d.id))).to eq 'Anaconda (1997) - Blu-ray (A-2)'
    end
    
    it 'should include package where available' do
      loc = create(:location, name: 'Col-14')
      d = create(:disc, name: '1', format: 'DVD', location: loc)
      package = create(:package, name: 'Rozen Maiden')
      create(:disc_package, disc: d, package: package, sequence: 1)

      expect(helper.disc_index_capsule(DiscsSearch.find(d.id))).to eq '[Rozen Maiden] 1 - DVD (Col-14)'
    end

  end

end
