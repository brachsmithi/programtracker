require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  
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

  describe 'show_icon' do
    
    it 'should generate a show icon' do
      icon = show_icon
      expect(icon).to match /<svg width="1em" height="1em" viewbox="0 0 16 16" class="bi bi-file-earmark-font"[A-Za-z0-9\-"9\0\s.<>\/=+:]*<\/svg>/
    end

  end

  describe 'edit_icon' do
    
    it 'should generate an edit icon' do
      icon = edit_icon
      expect(icon).to match /<svg width="1em" height="1em" viewbox="0 0 16 16" class="bi bi-pencil-fill"[A-Za-z0-9\-"9\0\s.<>\/=+:]*<\/svg>/
    end

  end

  describe 'destroy_icon' do
    
    it 'should generate a destroy icon' do
      icon = destroy_icon
      expect(icon).to match /<svg width="1em" height="1em" viewbox="0 0 16 16" class="bi bi-trash-fill"[A-Za-z0-9\-"9\0\s.<>\/=+:]*<\/svg>/
    end

  end

end