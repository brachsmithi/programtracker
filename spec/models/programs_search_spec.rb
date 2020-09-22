require 'rails_helper'

RSpec.describe ProgramsSearch, :type => :model do

  describe 'find' do
    it 'should provide a program' do
      p = Program.create!({
        name: 'A Program'
      })
      ps = ProgramsSearch.find p.id
      expect(ps.program).to eq p
    end

  end

  describe 'sort_title' do
    
    it 'should use sort_name' do
      p = Program.create!({
        name: 'The Uncanny',
        sort_name: 'Uncanny'
      })
      ps = ProgramsSearch.find p.id
      expect(ps.sort_title).to eq 'uncanny'
    end

    it 'should use name when there is no sort_name' do
      p = Program.create!({
        name: 'Bamboozled',
        sort_name: ''
      })
      ps = ProgramsSearch.find p.id
      expect(ps.sort_title).to eq 'bamboozled'
    end

  end

  describe 'search_by_name' do

    it 'should find matches against program name' do
      create(:program, name: 'All That Jazz')
      create(:program, name: 'The Apple')
      create(:program, name: 'Annie Hall')
      create(:program, name: 'The Ballad of Narayama')
      create(:program, name: 'Anything Goes')
      matches = ProgramsSearch.search_by_name 'all'
      expect(matches.count).to eq 3
      expect(matches[0].name).to eq 'All That Jazz'
      expect(matches[1].name).to eq 'Annie Hall'
      expect(matches[2].name).to eq 'The Ballad of Narayama'
    end

    it 'should also search against alternates' do
      program = create(:program, name: 'Aelita: Queen of Mars')
      create(:alternate_title, name: 'Aelita: Revolt of the Robots', program_id: program.id)

      matches = ProgramsSearch.search_by_name 'robot'
      expect(matches.count).to eq 1
      expect(matches[0].name).to eq 'Aelita: Queen of Mars'
    end

    it 'should also search against sort name' do
      program = create(:program, name: 'Ms. 45', sort_name: 'Ms Forty-Five', year: '1981')

      matches = ProgramsSearch.search_by_name 'five'
      expect(matches.count).to eq 1
      expect(matches[0].name).to eq 'Ms. 45'
    end

    it 'should only return one record for program with alternates' do 
      program1 = create(:program, name: 'Ator, the Fighting Eagle')
      create(:alternate_title, name: 'Ator', program_id: program1.id)
      create(:alternate_title, name: 'Ator the Invincible', program_id: program1.id)
      program2 = create(:program, name: 'Kuzdok')
      create(:alternate_title, name: 'Fight', program_id: program2.id)
      create(:alternate_title, name: 'Walka', program_id: program2.id)

      matches = ProgramsSearch.search_by_name 'fight'
      expect(matches.count).to eq 2
      expect(matches[0].name).to eq 'Ator, the Fighting Eagle'
      expect(matches[1].name).to eq 'Kuzdok'
    end

    it 'should sort results' do
      p1 = create(:program, name: 'Halloween', year: '2007')
      p2 = create(:program, name: 'Halloween H20: 20 Years Later', year: '1998', sort_name: 'Halloween H20 Twenty Years Later')
      p3 = create(:program, name: 'Halloween II', year: '1981', sort_name: 'Halloween 2')
      p4 = create(:program, name: 'Halloween', year: '1978')
      p5 = create(:program, name: 'Halloween III: Season of the Witch', year: '1982', sort_name: 'Halloween 3 Season of the Witch')

      matches = ProgramsSearch.search_by_name 'hallow'
      expect(matches.count).to eq 5
      expect(matches[0].name).to eq 'Halloween'
      expect(matches[0].year).to eq '1978'
      expect(matches[1].name).to eq 'Halloween'
      expect(matches[1].year).to eq '2007'
      expect(matches[2].name).to eq 'Halloween II'
      expect(matches[3].name).to eq 'Halloween III: Season of the Witch'
      expect(matches[4].name).to eq 'Halloween H20: 20 Years Later'
    end

  end

end