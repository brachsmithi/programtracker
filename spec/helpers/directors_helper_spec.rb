require 'rails_helper'

RSpec.describe PersonsHelper, type: :helper do
  
  describe 'capsule_person' do
    
    it 'should include aliases' do
      person = create(:person, name: 'Jesus Franco')
      create(:person_alias, name: 'Jess Franco', 'director_id': person.id)
      create(:person_alias, name: 'Clifford Brown Jr.', 'director_id': person.id)
      expect(helper.capsule_person(person)).to eq 'Jesus Franco (Jess Franco, Clifford Brown Jr.)'
    end

    it 'should handle lack of aliases gracefully' do
      person = create(:person, name: 'John Carpenter')
      expect(helper.capsule_person(person)).to eq 'John Carpenter'
    end

  end

end
