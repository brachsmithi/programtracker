require 'rails_helper'

RSpec.describe DirectorHelper, type: :helper do
  
  describe 'sort_directors' do
    
    it 'should sort by last name' do
      dir1 = create(:director, name: 'Alfred Hitchcock')
      dir2 = create(:director, name: 'Takashi Miike')
      dir3 = create(:director, name: 'Francis Ford Coppola')

      sorted = helper.sort_directors [dir1, dir2, dir3]

      expect(sorted[0].name).to eq 'Francis Ford Coppola'
      expect(sorted[1].name).to eq 'Alfred Hitchcock'
      expect(sorted[2].name).to eq 'Takashi Miike'
    end

  end

end
