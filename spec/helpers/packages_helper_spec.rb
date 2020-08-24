require 'rails_helper'

RSpec.describe PackagesHelper, type: :helper do
  
  describe 'capsule_program' do
    
    it 'should include the version' do
      program = create(:program, name: 'Carnival of Souls', version: 'Theatrical')
      expect(helper.capsule_program(program)).to eq 'Carnival of Souls (Theatrical)'
    end

    it 'should handle lack of version gracefully' do
      program = create(:program, name: 'Carnival of Souls', version: '')
      expect(helper.capsule_program(program)).to eq 'Carnival of Souls'
    end

  end

end
