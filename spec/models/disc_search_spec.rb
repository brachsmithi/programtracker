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

    disc = nil

    before(:each) do
      disc = Disc.create!({
        format: 'DVD',
        state: 'VIEWING',
        location: Location.create!(name: 'Shelf')
      })
    end

    it 'should use name when set' do
      disc.name = 'Hammer Trailer Collection'
      disc.save

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'hammer trailer collection'
    end
    
    it 'should use the first feature entered when there is no sequence' do
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'FEATURE')
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'FEATURE')
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'beach party 1963'
    end

    it 'should use the sequence number to find the first feature' do
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'FEATURE', sequence: 2)
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'FEATURE', sequence: 1)
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'beach blanket bingo 1965'
    end

    it 'should use the package name when there are no features' do
      program1 = create(:program, name: 'The Boxing Cats')
      program2 = create(:program, name: 'Automated Hat Maker and Meat Grinder')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'SHORT', sequence: 2)
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'SHORT', sequence: 1)
      package = create(:package, name: 'Silent Shorts')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'silent shorts'
    end

    it 'should use the first program when there are no features, package, or series' do
      program1 = create(:program, name: 'Making of Lord of the Rings', year: '2004')
      program2 = create(:program, name: 'Behind the Scenes', year: '2002')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'BONUS')
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'BONUS')

      expect(DiscsSearch.find(disc.id).sort_title).to eq 'making of lord of the rings 2004'
    end

    it 'disc with no feature and no package should use series' do
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'Dr. Horrible\'s Sing-Along Blog')
      create(:series_program, series_id: series.id, program_id: program.id)

      expect(DiscsSearch.find(disc.id).sort_title).to eq "dr. horrible's sing-along blog"
    end

    it 'should mark as empty when all else fails' do
      expect(DiscsSearch.find(disc.id).sort_title).to eq '--no programs--'
    end

    it 'should remove preceding article a from disc name' do
      disc.name = 'A Simple Plan'
      disc.save
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'simple plan'
    end

    it 'should remove preceding article an from disc name' do
      disc.name = 'An Ordinary Life'
      disc.save
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'ordinary life'
    end

    it 'should remove preceding article the from disc name' do
      disc.name = 'The Bat'
      disc.save
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'bat'
    end

    it 'should remove preceding article a from package name' do
      package = create(:package, name: 'A Collection of Silent Shorts')
      create(:disc_package, disc_id: disc.id, package_id: package.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'collection of silent shorts'
    end

    it 'should remove preceding article an from package name' do
      package = create(:package, name: 'An Unfortunate Event')
      create(:disc_package, disc_id: disc.id, package_id: package.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'unfortunate event'
    end

    it 'should remove preceding article the from package name' do
      package = create(:package, name: 'The Hills Have Eyes')
      create(:disc_package, disc_id: disc.id, package_id: package.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'hills have eyes'
    end

    it 'should remove preceding article a from series name' do
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'A TV Show')
      create(:series_program, series_id: series.id, program_id: program.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'tv show'
    end

    it 'should remove preceding article an from series name' do
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'An Unknown Comic')
      create(:series_program, series_id: series.id, program_id: program.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'unknown comic'
    end

    it 'should remove preceding article the from series name' do
      program = create(:program, name: 'Act I', year: '2008', minutes: '14')
      create(:disc_program, disc_id: disc.id, program_id: program.id, program_type: 'EPISODE')
      series = create(:series, name: 'The Americans')
      create(:series_program, series_id: series.id, program_id: program.id)
      expect(DiscsSearch.find(disc.id).sort_title).to eq 'americans'
    end

  end

end