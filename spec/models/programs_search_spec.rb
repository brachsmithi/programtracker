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
      create(:program, name: 'Ms. 45', sort_name: 'Ms Forty-Five', year: '1981')

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

    it 'should only return one record for program with alternates in series' do
      series = create(:series, name: 'Terry Gilliam Films')
      program1 = create(:program, name: 'Monty Python and the Holy Grail')
      create(:alternate_title, name: 'The Holy Grail', program_id: program1.id)
      create(:series_program, program_id: program1.id, series_id: series.id)
      program2 = create(:program, name: 'The Fisher King')
      create(:series_program, program_id: program2.id, series_id: series.id)

      matches = ProgramsSearch.search_by_name 'gilliam'
      expect(matches.count).to eq 2
      expect(matches[0].name).to eq 'Monty Python and the Holy Grail'
      expect(matches[1].name).to eq 'The Fisher King'
    end

    it 'should only return one record for program in disc and package' do
      package = create(:package, name: 'Farscape: Season 2')
      disc = create(:disc, name: 'Disc Six')
      create(:disc_package, disc_id: disc.id, package_id: package.id)
      program1 = create(:program, name: 'Liars, Guns and Money: Part 2: With Friends Like These...', sort_name: 'Liars Guns and Money Part 2 With Friends Like These')
      create(:alternate_title, name: 'With Friends Like These', program_id: program1.id)
      create(:disc_program, disc_id: disc.id, program_id: program1.id)
      program2 = create(:program, name: 'Liars, Guns and Money: Part 3: Plan B', sort_name: 'Liars Guns and Money Part 3 Plan B')
      create(:alternate_title, name: 'Plan B', program_id: program2.id)
      create(:disc_program, disc_id: disc.id, program_id: program2.id)

      matches = ProgramsSearch.search_by_name 'farscape'
      expect(matches.count).to eq 2
      expect(matches[0].name).to eq program1.name
      expect(matches[1].name).to eq program2.name
    end

    it 'should only return one record for program in multiple series' do
      program = create(:program, name: 'Son of Godzilla')
      series1 = create(:series, name: 'Godzilla')
      series2 = create(:series, name: 'Godzilla (Showa)')
      create(:series_program, program_id: program.id, series_id: series1.id)
      create(:series_program, program_id: program.id, series_id: series2.id)

      matches = ProgramsSearch.search_by_name 'zilla'
      expect(matches.count).to eq 1
      expect(matches.first.name).to eq program.name
    end

    it 'should only return one record for program in multiple discs' do
      program = create(:program, name: 'A Bucket of Blood')
      location = create(:location, name: 'B-4')
      disc1 = create(:disc, format: 'Blu-ray', location: location, state: 'UNWATCHED')
      create(:disc_program, disc_id: disc1.id, program_id: program.id)
      disc2 = create(:disc, format: 'DVD', location: location, state: 'FILED')
      create(:disc_program, disc_id: disc2.id, program_id: program.id)

      matches = ProgramsSearch.search_by_name 'blood'

      expect(matches.count).to eq 1
      expect(matches.first.name).to eq program.name
    end

    it 'should sort results' do
      create(:program, name: 'Halloween', year: '2007')
      create(:program, name: 'Halloween H20: 20 Years Later', year: '1998', sort_name: 'Halloween H20 Twenty Years Later')
      create(:program, name: 'Halloween II', year: '1981', sort_name: 'Halloween 2')
      create(:program, name: 'Halloween', year: '1978')
      create(:program, name: 'Halloween III: Season of the Witch', year: '1982', sort_name: 'Halloween 3 Season of the Witch')

      matches = ProgramsSearch.search_by_name 'hallow'
      expect(matches.count).to eq 5
      expect(matches[0].name).to eq 'Halloween'
      expect(matches[0].year).to eq '1978'
      expect(matches[1].name).to eq 'Halloween II'
      expect(matches[2].name).to eq 'Halloween'
      expect(matches[2].year).to eq '2007'
      expect(matches[3].name).to eq 'Halloween III: Season of the Witch'
      expect(matches[4].name).to eq 'Halloween H20: 20 Years Later'
    end

    it 'should ignore entered capitals' do
      create(:program, name: 'The King and I')

      matches = ProgramsSearch.search_by_name 'KING'
      expect(matches.count).to eq 1
      expect(matches.first.name).to eq 'The King and I'
    end

  end

end