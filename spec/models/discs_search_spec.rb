require 'rails_helper'

RSpec.describe DiscsSearch, :type => :model do

  describe 'find' do
    it 'should provide a disc' do
      d = Disc.create!({
        name: 'Wrapped Disc',
        format: 'DVD',
        state: 'VIEWING',
        location: Location.create!(name: 'Shelf')
      })
      ds = DiscsSearch.find d.id
      expect(ds.disc).to eq d
    end
  end

  describe 'sort_title' do


    def create_disc
      Disc.create!({
        format: 'DVD',
        state: 'VIEWING',
        location: Location.create!(name: 'Shelf')
      })
    end

    it 'should use name when set' do
      disc = create_disc
      disc.name = 'Hammer Trailer Collection'
      disc.save

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'hammer trailer collection'
    end
    
    it 'should use the first feature entered when there is no sequence' do
      disc = create_disc
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'FEATURE')
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'FEATURE')
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'beach party 1963'
    end

    it 'should use the sequence number to find the first feature' do
      disc = create_disc
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'FEATURE', sequence: 2)
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'FEATURE', sequence: 1)
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'beach blanket bingo 1965'
    end

    it 'should use the package name when there are no features' do
      disc = create_disc
      program1 = create(:program, name: 'The Boxing Cats')
      program2 = create(:program, name: 'Automated Hat Maker and Meat Grinder')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'SHORT', sequence: 2)
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'SHORT', sequence: 1)
      package = create(:package, name: 'Silent Shorts')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'silent shorts'
    end

    it 'should use the first program when there are no features, package, or series' do
      disc = create_disc
      program1 = create(:program, name: 'Making of Lord of the Rings', year: '2004')
      program2 = create(:program, name: 'Behind the Scenes', year: '2002')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'BONUS')
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'BONUS')

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'making of lord of the rings 2004'
    end

    it 'disc with no feature and no package should use series' do
      disc = create_disc
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'Dr. Horrible\'s Sing-Along Blog')
      create(:series_program, series_id: series.id, program_id: program.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq "dr. horrible's sing-along blog"
    end

    it 'should mark as empty when all else fails' do
      disc = create_disc
      expect(DiscsSearch.find(disc.id).sort_title).to eq '--no programs--'
    end

    it 'should remove preceding article a from disc name' do
      disc = create_disc
      disc.name = 'A Simple Plan'
      disc.save
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'simple plan'
    end

    it 'should remove preceding article an from disc name' do
      disc = create_disc
      disc.name = 'An Ordinary Life'
      disc.save
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'ordinary life'
    end

    it 'should remove preceding article the from disc name' do
      disc = create_disc
      disc.name = 'The Bat'
      disc.save
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'bat'
    end

    it 'should remove preceding article a from package name' do
      disc = create_disc
      package = create(:package, name: 'A Collection of Silent Shorts')
      create(:disc_package, disc_id: disc.id, package_id: package.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'collection of silent shorts'
    end

    it 'should remove preceding article an from package name' do
      disc = create_disc
      package = create(:package, name: 'An Unfortunate Event')
      create(:disc_package, disc_id: disc.id, package_id: package.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'unfortunate event'
    end

    it 'should remove preceding article the from package name' do
      disc = create_disc
      package = create(:package, name: 'The Hills Have Eyes')
      create(:disc_package, disc_id: disc.id, package_id: package.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'hills have eyes'
    end

    it 'should remove preceding article a from series name' do
      disc = create_disc
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'A TV Show')
      create(:series_program, series_id: series.id, program_id: program.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'tv show'
    end

    it 'should remove preceding article an from series name' do
      disc = create_disc
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'An Unknown Comic')
      create(:series_program, series_id: series.id, program_id: program.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'unknown comic'
    end

    it 'should remove preceding article the from series name' do
      disc = create_disc
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'The Americans')
      create(:series_program, series_id: series.id, program_id: program.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'americans'
    end

  end

  describe 'search_by_name' do
    
    it 'should find program not in sort title' do
      program = create(:program, name: 'Invisible', sort_name: 'invisible')
      disc = create(:disc, name: 'Witness Me!')
      create(:disc_program, disc: disc, program: program)
      expect(DiscsSearch.search_by_name('vis').first.disc).to eq disc
    end

    it 'should find second program' do
      program1 = create(:program, name: 'Oculus')
      program2 = create(:program, name: 'Mirror, Mirror', sort_name: 'Mirror Mirror')
      disc = create(:disc, name: 'Reflections')
      create(:disc_program, disc: disc, program: program1, sequence: 1)
      create(:disc_program, disc: disc, program: program2, sequence: 2)

      expect(DiscsSearch.search_by_name('irr').first.disc).to eq disc
    end
    
    it 'should find series not in sort title' do
      program = create(:program)
      disc = create(:disc)
      series = create(:series, name: 'The Invisible Man')
      create(:series_program, series: series, program: program)
      create(:disc_program, disc: disc, program: program)
      expect(DiscsSearch.search_by_name('man').first.disc).to eq disc
    end
    
    it 'should find package not in sort title' do
      disc = create(:disc, name: 'Disc One')
      package = create(:package, name: 'Alien Worlds')
      create(:disc_package, disc: disc, package: package)
      expect(DiscsSearch.search_by_name('world').first.disc).to eq disc
    end

    it 'should ignore entered capitals' do
      create(:disc, name: 'Movie Trailers')

      matches = DiscsSearch.search_by_name 'TRAIL'
      expect(matches.count).to eq 1
      expect(matches.first.name).to eq 'Movie Trailers'
    end

  end

  describe 'with_no_programs' do

    it 'should return discs that do not have programs' do
      location = create(:location, name: 'Somewhere Over the Rainbow')
      create(:disc, name: 'Disc One', location: location)
      d2 = create(:disc, name: 'Disc II', location: location)
      create(:disc, name: 'Disc Three', location: location)

      create(:disc_program, disc_id: d2.id, program_id: create(:program, name: 'Content').id)

      result = DiscsSearch.with_no_programs

      expect(result.count).to eq 2
      expect(result[0].name).to eq 'Disc One'
      expect(result[1].name).to eq 'Disc Three'
    end
  end

  describe 'display_name' do

    it 'should use name when set' do
      d = create(:disc, name: 'Hammer Trailer Collection')

      expect(DiscsSearch.find(d.id).display_title).to eq 'Hammer Trailer Collection'
    end
    
    it 'should use the first feature entered when there is no sequence' do
      d = create(:disc)
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: d.id, program_id: program1.id, program_type: 'FEATURE')
      create(:disc_program, disc_id: d.id, program_id: program2.id, program_type: 'FEATURE')
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: d.id, package_id: package.id)

      expect(DiscsSearch.find(d.id).display_title).to eq 'Beach Party (1963)'
    end

    it 'should use the sequence number to find the first feature' do
      d = create(:disc)
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: d.id, program_id: program1.id, program_type: 'FEATURE', sequence: 2)
      create(:disc_program, disc_id: d.id, program_id: program2.id, program_type: 'FEATURE', sequence: 1)
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: d.id, package_id: package.id)

      expect(DiscsSearch.find(d.id).display_title).to eq 'Beach Blanket Bingo (1965)'
    end

    it 'should use the package name when there are no features' do
      d = create(:disc)
      program1 = create(:program, name: 'The Boxing Cats')
      program2 = create(:program, name: 'Automated Hat Maker and Meat Grinder')
      create(:disc_program, disc_id: d.id, program_id: program1.id, program_type: 'SHORT', sequence: 2)
      create(:disc_program, disc_id: d.id, program_id: program2.id, program_type: 'SHORT', sequence: 1)
      package = create(:package, name: 'Silent Shorts')
      create(:disc_package, disc_id: d.id, package_id: package.id)

      expect(DiscsSearch.find(d.id).display_title).to eq 'Silent Shorts'
    end

    it 'should use the first program when there are no features, package, or series' do
      d = create(:disc)
      program1 = create(:program, name: 'Making of Lord of the Rings', year: '2004')
      program2 = create(:program, name: 'Behind the Scenes', year: '2002')
      create(:disc_program, disc_id: d.id, program_id: program1.id, program_type: 'BONUS')
      create(:disc_program, disc_id: d.id, program_id: program2.id, program_type: 'BONUS')

      expect(DiscsSearch.find(d.id).display_title).to eq 'Making of Lord of the Rings (2004)'
    end

    it 'disc with no feature and no package should use series' do
      d = create(:disc)
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: d.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'Dr. Horrible\'s Sing-Along Blog')
      create(:series_program, series_id: series.id, program_id: program.id)

      expect(DiscsSearch.find(d.id).display_title).to eq "Dr. Horrible's Sing-Along Blog"
    end

    it 'should mark as empty when all else fails' do
      d = create(:disc)
      expect(DiscsSearch.find(d.id).display_title).to eq '--No Programs--'
    end

  end

end