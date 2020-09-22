require 'rails_helper'

RSpec.describe DirectorsHelper, type: :helper do
  
  describe 'capsule_director' do
    
    it 'should include aliases' do
      director = create(:director, name: 'Jesus Franco')
      create(:director_alias, name: 'Jess Franco', director_id: director.id)
      create(:director_alias, name: 'Clifford Brown Jr.', director_id: director.id)
      expect(helper.capsule_director(director)).to eq 'Jesus Franco (Jess Franco, Clifford Brown Jr.)'
    end

    it 'should handle lack of aliases gracefully' do
      director = create(:director, name: 'John Carpenter')
      expect(helper.capsule_director(director)).to eq 'John Carpenter'
    end

  end

end
